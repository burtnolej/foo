Attribute VB_Name = "App_Person"
'Public Function GetPersonDataFromDB
'Public Function GetPersonData

Option Explicit
Const C_MODULE_NAME = "App_Person"
Const cTeacherLookUpCol = "idFaculty"
Const cStudentLookUpCol = "idStudent"

Public Function IsValidPersonID(clsQuadRuntime As Quad_Runtime, _
                                iPersonID As Integer, _
                                eQuadSubDataType As QuadSubDataType) As Boolean
'<<<
' purpose: tests if the given person ID exists; retreives data to perform the test
'        : currently uses the non table mechanism for storing data and looking up
' param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : iPersonID, Integer; id to be checked
' returns: boolean
'>>>

Dim sFuncName As String, sLookUpCol As String
Dim wsPersonDataCache As Worksheet

setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidPersonID"

main:
    Set wsPersonDataCache = GetPersonData(clsQuadRuntime, QuadDataType.person, eQuadSubDataType, eQuadScope:=QuadScope.all)

    If eQuadSubDataType = QuadSubDataType.teacher Then
        sLookUpCol = cTeacherLookUpCol
    Else
        sLookUpCol = cStudentLookUpCol
    End If
    
    If SheetTableLookup(wsPersonDataCache, "data", sLookUpCol, iPersonID) <> -1 Then
        IsValidPersonID = True
        Exit Function
    End If
    
    IsValidPersonID = False
    
End Function
Public Function get_person_student(clsQuadRuntime As Quad_Runtime, _
                      Optional bInTable As Boolean = True) As Worksheet
    Set get_person_student = GetPersonData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.student, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
Public Function get_person_teacher(clsQuadRuntime As Quad_Runtime, _
                      Optional bInTable As Boolean = True) As Worksheet
    Set get_person_teacher = GetPersonData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.teacher, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
                     
'Public Function GetPersonData(clsQuadRuntime As Quad_Runtime, _
'                              eQuadSubDataType As QuadSubDataType, _
'                     Optional eQuadScope As QuadScope = QuadScope.specified, _
'                     Optional bInTable As Boolean = False) As Worksheet
Public Function GetPersonData(clsQuadRuntime As Quad_Runtime, _
                              eQuadDataType As QuadDataType, _
                              eQuadSubDataType As QuadSubDataType, _
                     Optional eQuadScope As QuadScope = QuadScope.specified, _
                     Optional bInTable As Boolean = False) As Worksheet

'<<<
' purpose: returns a worksheet containing the person data set, uses cached data if already there
' param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : eQuadScope, QuadScope; all persons or a specific individual
' returns: Worksheet; containing the data
'>>>
'Dim eQuadDataType As QuadDataType
Dim sCacheSheetName As String
Dim aSchedule() As String

    'eQuadDataType = QuadDataType.person
    
    If IsDataCached(clsQuadRuntime, eQuadDataType, eQuadSubDataType) = False Then
        GetPersonDataFromDB clsQuadRuntime, eQuadSubDataType, eQuadScope:=eQuadScope
        aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, eQuadDataType, eQuadSubDataType, _
                                    bInTable:=bInTable)
    Else
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, eQuadDataType, eQuadSubDataType, bCacheNameOnly:=True, _
                                    bInTable:=bInTable)
    End If
    
    Set GetPersonData = clsQuadRuntime.CacheBook.Sheets(sCacheSheetName)
    
End Function
Public Sub GetPersonDataFromDB(clsQuadRuntime As Quad_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                      Optional eQuadScope = QuadScope.specified, _
                      Optional iPersonID As String)
'<<<
' purpose: go to the database to get person data
' param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : eQuadScope, QuadScope; all persons or a specific individual
' param  : iPersonID (optional), Integer; id of the specific individual we want to get data for
' returns: data is store in clsQuadRuntime.ResultFileName to be read / parsed by called
'>>>
Dim sDatabasePath As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary

    sSpName = "basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"

    If eQuadScope = QuadScope.all Then
        sSpName = "all_" & sSpName
    Else
        dSpArgs.Add EnumQuadSubDataType(eQuadSubDataType) & "s", InitVariantArray(Array(iPersonID))
    End If

    GetQuadDataFromDB clsQuadRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs

End Sub

