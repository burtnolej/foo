Attribute VB_Name = "Quad_Person"
'Public Function GetPersonDataFromDB
'Public Function GetPersonData

Option Explicit
Const C_MODULE_NAME = "Quad_Person"
Const cTeacherLookUpCol = "idFaculty"
Const cStudentLookUpCol = "idStudent"

Public Sub GeneratePersonView(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc)
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
Dim dArgs As New Dictionary

setup:
    
    sFuncName = C_MODULE_NAME & "." & "GeneratePersonView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    sSheetName = "test"
    CreateSheet clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True
    
main:
    sDataType = "Person"
    sSubDataType = "Student"
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "bLoadRefData", True
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime, bLoadRefData:=True

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub
Public Function get_person_student(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, _
                          Optional bInTable As Boolean = True) As Worksheet
Dim dArgs As New Dictionary

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "bInTable", bInTable, _
                          "clsExecProc", clsExecProc, _
                          "eQuadDataType", QuadDataType.person, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.all, _
                          "ver_series", clsAppRuntime.Version
                          
    clsExecProc.ExecProc "GetPersonData", dArgs
    Set get_person_student = dArgs.Item("result")
End Function
Public Function get_person_teacher(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, _
                      Optional bInTable As Boolean = True) As Worksheet
Dim dArgs As New Dictionary

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "bInTable", bInTable, _
                          "clsExecProc", clsExecProc, _
                          "eQuadDataType", QuadDataType.person, _
                          "eQuadSubDataType", QuadSubDataType.Teacher, _
                          "eQuadScope", QuadScope.all, _
                          "ver_series", clsAppRuntime.Version
    clsExecProc.ExecProc "GetPersonData", dArgs
    Set get_person_teacher = dArgs.Item("result")
    
    'Set get_person_teacher = GetPersonData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Teacher, eQuadScope:=QuadScope.all, bInTable:=bInTable)
End Function
                     
Public Function GetPersonData(dArgs As Dictionary) As Worksheet

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
Dim clsExecProc As Exec_Proc
Dim clsAppRuntime As App_Runtime
Dim eQuadDataType As QuadDataType
Dim eQuadSubDataType As QuadSubDataType
Dim eQuadScope As QuadScope
Dim bInTable As Boolean

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    eQuadDataType = dArgs.Item("eQuadDataType")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    eQuadScope = dArgs.Item("eQuadScope")
    bInTable = dArgs.Item("bInTable")
    
    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        'Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    
setup:
    sFuncName = C_MODULE_NAME & "." & "GetPersonData"
    'FuncLogIt sFuncName, "[eQuadDataType=" & eQuadDataType & "] [eQuadSubDataType=" & eQuadSubDataType & "] [bInTable=" & CStr(bInTable) & "]", C_MODULE_NAME, LogMsgType.INFUNC

main:

    On Error GoTo err
    If IsDataCached(clsAppRuntime, eQuadDataType, eQuadSubDataType) = False Then
        clsExecProc.ExecProc "GetPersonDataFromDB", dArgs
        'GetPersonDataFromDB clsAppRuntime, eQuadSubDataType, eQuadScope:=eQuadScope
        aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, eQuadDataType, eQuadSubDataType, _
                                    bInTable:=bInTable)
    Else
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, eQuadDataType, eQuadSubDataType, bCacheNameOnly:=True, _
                                    bInTable:=bInTable)
    End If
    
    Set GetPersonData = clsAppRuntime.CacheBook.Sheets(sCacheSheetName)
    AddDict dArgs, "result", clsAppRuntime.CacheBook.Sheets(sCacheSheetName), True
    
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
    sSpName = "update_" & EnumQuadSubDataType(eQuadSubDataType) & ""
    UpdateQuadDataInDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRow:=vRow
                               
End Sub

Public Sub InsertPersonDataToDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               vRows As Variant, _
                               vColumns As Variant)
                               
Dim sSpName As String

    sSpName = "insert_" & EnumQuadSubDataType(eQuadSubDataType) & ""
    InsertQuadDataToDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRows:=vRows, vColumns:=vColumns
                               
End Sub

Public Sub InsertCoursesDataToDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               vRows As Variant, _
                               vColumns As Variant)
                               
Dim sSpName As String
    sSpName = "insert_" & EnumQuadSubDataType(eQuadSubDataType) & ""
    InsertQuadDataToDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRows:=vRows, vColumns:=vColumns
                               
End Sub

Public Sub DeletePersonDataFromDB(clsAppRuntime As App_Runtime, _
                               eQuadSubDataType As QuadSubDataType, _
                               iPersonID As String)
'<<<
'>>>
Dim sDatabasePath As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary

    sSpName = "delete_" & EnumQuadSubDataType(eQuadSubDataType) & ""
    dSpArgs.Add EnumQuadSubDataType(eQuadSubDataType) & "s", InitVariantArray(Array(iPersonID))

    GetQuadDataFromDB clsAppRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs

End Sub

Public Sub GetPersonDataFromDB(dArgs As Dictionary)

'Public Sub GetPersonDataFromDB(clsAppRuntime As App_Runtime, _
'                               eQuadSubDataType As QuadSubDataType, _
'                      Optional eQuadScope = QuadScope.specified, _
'                      Optional iPersonID As String)
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
Dim clsExecProc As Exec_Proc
Dim clsAppRuntime As App_Runtime
Dim eQuadSubDataType As QuadSubDataType
Dim eQuadScope As QuadScope
Dim iPersonID As Integer

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    eQuadScope = dArgs.Item("eQuadScope")
    iPersonID = dArgs.Item("iPersonID")

    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        'Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If

main:
    sSpName = "" & EnumQuadSubDataType(eQuadSubDataType) & ""
    'sSpName = "" & Application.Run(C_ENUM_QUAD_SUB_DATA_TYPE, eQuadSubDataType) & ""

    If eQuadScope = QuadScope.all Then
        sSpName = "all_" & sSpName
    Else
        dSpArgs.Add EnumQuadSubDataType(eQuadSubDataType) & "s", InitVariantArray(Array(iPersonID))
        'dSpArgs.Add Application.Run(C_ENUM_QUAD_SUB_DATA_TYPE, eQuadSubDataType) & "s", Application.Run(C_INIT_VARIANT_ARRAY, Array(iPersonID))
    End If

    GetQuadDataFromDB clsAppRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs
    'Application.Run C_GET_QUAD_DATA_FROM_DB, clsAppRuntime, sSpName, dSpArgs, True

End Sub

