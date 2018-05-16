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
Dim sFuncName As String, sSheetName As String
Dim sDefn As String
Dim vSource() As String
Dim wsTmp As Worksheet, wsView As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult
Dim lStartTick As Long

setup:
    
    sFuncName = C_MODULE_NAME & "." & "GeneratePersonView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)

    sDefn = "ViewStudent^person_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^&UpdateViewStudentForm^Selector" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^sStudentFirstNm^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^idStudent^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^idPrep^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateForms clsAppRuntime, bLoadRefData:=True

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub


Public Function IsValidPersonID(clsAppRuntime As App_Runtime, _
                                iPersonID As Integer, _
                                eQuadSubDataType As QuadSubDataType) As Boolean
'<<<
' purpose: tests if the given person ID exists; retreives data to perform the test
'        : currently uses the non table mechanism for storing data and looking up
' param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : iPersonID, Integer; id to be checked
' returns: boolean
'>>>

Dim sFuncName As String, sLookUpCol As String
Dim wsPersonDataCache As Worksheet
Dim vStudentIDs() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidPersonID"
    FuncLogIt sFuncName, "[iPersonID=" & iPersonID & "] [eQuadSubDataType=" & eQuadSubDataType & "]", C_MODULE_NAME, LogMsgType.INFUNC
    On Error GoTo err

main:
    Set wsPersonDataCache = GetPersonData(clsAppRuntime, QuadDataType.person, eQuadSubDataType, _
                eQuadScope:=QuadScope.all, bInTable:=True)

    If eQuadSubDataType = QuadSubDataType.teacher Then
        sLookUpCol = cTeacherLookUpCol
    Else
        sLookUpCol = cStudentLookUpCol
    End If

    'clsAppRuntime.InitProperties bInitializeCache:=False
    vStudentIDs = GetColumnValues(clsAppRuntime, QuadDataType.person, QuadSubDataType.Student, "idStudent")

    If InArray(vStudentIDs, CStr(iPersonID)) Then
        IsValidPersonID = True
        FuncLogIt sFuncName, "Student ID [" & CStr(iPersonID) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
        Exit Function
    End If
    
    IsValidPersonID = False
    FuncLogIt sFuncName, "Student ID [" & CStr(iPersonID) & "] is INVALID ", C_MODULE_NAME, LogMsgType.INFO
    
cleanup:
    On Error GoTo 0
    Exit Function

err:
    FuncLogIt sFuncName, "[iPersonID=" & iPersonID & "] [eQuadSubDataType=" & eQuadSubDataType & "]", C_MODULE_NAME, LogMsgType.Error

End Function
Public Function get_person_student(clsAppRuntime As App_Runtime, _
                      Optional bInTable As Boolean = True) As Worksheet
    Set get_person_student = GetPersonData(clsAppRuntime, QuadDataType.person, QuadSubDataType.Student, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
Public Function get_person_teacher(clsAppRuntime As App_Runtime, _
                      Optional bInTable As Boolean = True) As Worksheet
    Set get_person_teacher = GetPersonData(clsAppRuntime, QuadDataType.person, QuadSubDataType.teacher, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
                     
'Public Function GetPersonData(clsAppRuntime As App_Runtime, _
'                              eQuadSubDataType As QuadSubDataType, _
'                     Optional eQuadScope As QuadScope = QuadScope.specified, _
'                     Optional bInTable As Boolean = False) As Worksheet
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
                               sFieldname As String, sFieldVal As Variant, _
                               sPredName As String, sPredVal As Variant)
Dim sSpName As String
Dim vRow() As Variant

    vRow = Array(sFieldname, sFieldVal, sPredName, sPredVal)
    sSpName = "update_basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"
    UpdateQuadDataInDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRow:=vRow
                               
End Sub

Public Sub InsertPersonDataToDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               vRows() As Variant, _
                               vColumns() As Variant)
                               
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

