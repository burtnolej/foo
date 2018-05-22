Attribute VB_Name = "App_Person"
'Public Function GetPersonDataFromDB
'Public Function GetPersonData

Option Explicit
Const C_MODULE_NAME = "App_Person"
Const cTeacherLookUpCol = "idFaculty"
Const cStudentLookUpCol = "idStudent"

Public Sub GeneratePersonView(clsAppRuntime As App_Runtime)
'<<<
'purpose: Create a view type form showing a person (student or teacher)
'param  : clsAppRuntime,App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'rtype  :
'>>>
Dim sFuncName As String, sSheetName As String, sDefn As String, sDataType As String, sSubDataType As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim lStartTick As Long

setup:
    
    sFuncName = C_MODULE_NAME & "." & "GeneratePersonView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    sSheetName = "test"
    CreateSheet clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True
    
main:
    sDataType = "Person"
    sSubDataType = "Student"
    GetDefinition clsAppRuntime, sDataType, sSubDataType, sSheetName, FormType.View
    GenerateForms clsAppRuntime, bLoadRefData:=True

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub
Public Function get_person_student(clsAppRuntime As App_Runtime, _
                      Optional bInTable As Boolean = True) As Worksheet
    Set get_person_student = GetPersonData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
Public Function get_person_teacher(clsAppRuntime As App_Runtime, _
                      Optional bInTable As Boolean = True) As Worksheet
    Set get_person_teacher = GetPersonData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Teacher, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
                     
Public Function GetPersonData(clsAppRuntime As App_Runtime, _
                              eQuadDataType As QuadDataType, _
                              eQuadSubDataType As QuadSubDataType, _
                     Optional eQuadScope As QuadScope = QuadScope.specified, _
                     Optional bInTable As Boolean = False) As Worksheet
'<<<
' purpose: returns a worksheet containing the person data set, uses cached data if already there
' param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : eQuadScope, QuadScope; all persons or a specific individual
' returns: Worksheet; containing the data
'>>>
Dim sCacheSheetName As String, sFuncName As String
Dim aSchedule() As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "GetPersonData"
    'FuncLogIt sFuncName, "[eQuadDataType=" & eQuadDataType & "] [eQuadSubDataType=" & eQuadSubDataType & "] [bInTable=" & CStr(bInTable) & "]", C_MODULE_NAME, LogMsgType.INFUNC

main:

    On Error GoTo err
    If IsDataCached(clsAppRuntime, eQuadDataType, eQuadSubDataType) = False Then
        GetPersonDataFromDB clsAppRuntime, eQuadSubDataType, eQuadScope:=eQuadScope
        aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, eQuadDataType, eQuadSubDataType, _
                                    bInTable:=bInTable)
    Else
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, eQuadDataType, eQuadSubDataType, bCacheNameOnly:=True, _
                                    bInTable:=bInTable)
    End If
    
    Set GetPersonData = clsAppRuntime.CacheBook.Sheets(sCacheSheetName)
    
cleanup:
    On Error GoTo 0
    Exit Function

err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error

End Function

Public Sub UpdatePersonDataInDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               sFieldName As String, sFieldVal As Variant, _
                               sPredName As String, sPredVal As Variant)
Dim sSpName As String
Dim vRow() As Variant

    vRow = Array(sFieldName, sFieldVal, sPredName, sPredVal)
    sSpName = "update_basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"
    UpdateQuadDataInDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRow:=vRow
                               
End Sub

Public Sub InsertPersonDataToDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               vRows As Variant, _
                               vColumns As Variant)
                               
Dim sSpName As String

    sSpName = "insert_basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"
    InsertQuadDataToDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRows:=vRows, vColumns:=vColumns
                               
End Sub

Public Sub DeletePersonDataFromDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               iPersonID As String)
'<<<
'>>>
Dim sDatabasePath As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary

    sSpName = "delete_basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"
    dSpArgs.Add EnumQuadSubDataType(eQuadSubDataType) & "s", InitVariantArray(Array(iPersonID))

    GetQuadDataFromDB clsAppRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs

End Sub
Public Sub GetPersonDataFromDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                      Optional eQuadScope = QuadScope.specified, _
                      Optional iPersonID As String)
'<<<
' purpose: go to the database to get person data
' param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : eQuadScope, QuadScope; all persons or a specific individual
' param  : iPersonID (optional), Integer; id of the specific individual we want to get data for
' returns: data is store in clsAppRuntime.ResultFileName to be read / parsed by called
'>>>
Dim sDatabasePath As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary

    sSpName = "basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"

    If eQuadScope = QuadScope.all Then
        sSpName = "all_" & sSpName
    Else
        dSpArgs.Add EnumQuadSubDataType(eQuadSubDataType) & "s", InitVariantArray(Array(iPersonID))
    End If

    GetQuadDataFromDB clsAppRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs

End Sub

