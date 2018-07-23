Attribute VB_Name = "Test_Quad_Utils"
Option Explicit
'Function TestSheetTableLookup()
'Function TestRowAsDict()

Const C_MODULE_NAME = "Test_Quad_Utils"
Public Function Test_CrossRefQuadData() As TestResult
Dim clsAppRuntime As New App_Runtime
Dim vSource() As String
Dim sDefn As String, sDefnSheetName As String
Dim rTarget As Range
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True

    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsAppRuntime.Book, sDefnSheetName, bOverwrite:=True)
        
    sDefn = "Add_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode^^^Entry"
           
    vSource = Init2DStringArrayFromString(sDefn)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.person, "eQuadSubDataType", QuadSubDataType.Student, _
                "sLookUpByColName", "idStudent", "sLookUpByValue", 1, "sLookUpColName", "sStudentLastNm"
                
    Application.Run C_CROSS_REF_QUAD_DATA, dArgs
    
    'If CrossRefQuadData(clsAppRuntime, QuadDataType.Person, _
    '                QuadSubDataType.Student, "idStudent", 1, "sStudentLastNm") <> "Gromek" Then
                    
    If dArgs.Item("result") <> "Gromek" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
        
    eTestResult = TestResult.OK
    GoTo teardown

                                 
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CrossRefQuadData = eTestResult
    clsAppRuntime.Delete
    
End Function

Public Function Test_CrossRefQuadData_MultiLookup() As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim vSource() As String
Dim sDefn As String, sDefnSheetName As String, sVersionBookName As String, sPath As String, sDatabasePath As String
Dim rTarget As Range
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim dArgs As New Dictionary
Dim wbTmp2 As Workbook
setup:
    sDatabasePath = Application.Run(C_GET_HOME_PATH) & "\GitHub\quadviewer\" & "app\quad\utils\excel\test_misc\QuadQA_v3.db"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDatabasePath:=sDatabasePath

    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsAppRuntime.Book, sDefnSheetName, bOverwrite:=True)
    sVersionBookName = "vba_source_new_v2.xlsm"

    'sDefn = "Add_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    'sDefn = sDefn & "Add_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    'sDefn = sDefn & "Add_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    'sDefn = sDefn & "Add_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel^^^Entry" & DOUBLEDOLLAR
    'sDefn = sDefn & "Add_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode^^^Entry"
           
    'vSource = Init2DStringArrayFromString(sDefn)
    'Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    'Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    
    'clsAppRuntime.InitProperties bInitializeCache:=True, sDatabasePath:=sDatabasePath, sVersion:="V2", _
    '        sVersionBookName:="vba_source_new_v2.xlsm", sVersionBookPath:=sPath, _
    '        sDefinitionSheetName:=sSheetName
    '
    sPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer"
    Set wbTmp2 = Application.Run(C_OPEN_BOOK, sVersionBookName, sPath)
    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    
    GetDefinition clsAppRuntime, clsExecProc, "Misc", "TimePeriod", sDefnSheetName, FormType.Add

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                        "clsExecProc", clsExecProc, _
                        "eQuadDataType", QuadDataType.Misc, _
                          "eQuadSubDataType", QuadSubDataType.TimePeriod, _
                          "sLookUpByColName", "idTimePeriod", _
                          "sLookUpByValue", 3, _
                          "sLookUpColName", "sPeriodTimeLabel", _
                          "sLookUpByColName2", "idAcadPeriod", _
                          "sLookUpByValue2", 2
                
    Application.Run C_CROSS_REF_QUAD_DATA, dArgs
                    
    If dArgs.Item("result") <> "09:27 to 10:07" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
        
    eTestResult = TestResult.OK
    GoTo teardown

                                 
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CrossRefQuadData_MultiLookup = eTestResult
    clsAppRuntime.Delete
    
End Function


Public Function Test_CacheData_Table() As TestResult
'"" cache data but wrap in a table
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String, sDefnSheetName As String, sDefn As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aPersonData() As Variant, vSource() As String
Dim clsAppRuntime As New App_Runtime
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsAppRuntime.Book, sDefnSheetName, bOverwrite:=True)
    
    sDefn = "Add_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode^^^Entry"
           
    vSource = Init2DStringArrayFromString(sDefn)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadSubDataType", QuadSubDataType.Student, "eQuadScope", QuadScope.all
    Application.Run C_GET_PERSON_DATA_FROM_DB, dArgs
    
    'GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    aPersonData = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsAppRuntime, aPersonData, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)
        
    With clsAppRuntime.CacheBook.Sheets(sCacheSheetName)
        If .Range(.Cells(83, 2), .Cells(83, 2)).value <> "Tzvi" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        Else
            eTestResult = TestResult.OK
        End If
    End With
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CacheData_Table = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, sCacheSheetName
    clsAppRuntime.Delete
    
End Function


Function TestGetAndInitAppRuntimeNoVals() As TestResult
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetAndInitAppRuntimeNoVals"
    
    Set clsAppRuntime = GetAppRuntimeGlobal(bInitFlag:=True)
    
    If clsAppRuntime.DayEnum <> "M,T,W,R,F" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitAppRuntimeNoVals = eTestResult
    'clsAppRuntime.Delete
    'ResetAppRuntimeGlobal

End Function
Function TestGetAndInitAppRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "TestGetAndInitAppRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsAppRuntime = GetAppRuntimeGlobal(bInitFlag:=True, dAppRuntimeValues:=dValues)
    
    If clsAppRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitAppRuntime = eTestResult
    'clsAppRuntime.Delete
    'ResetAppRuntimeGlobal

End Function
Function TestInitAppRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "InitAppRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsAppRuntime = InitAppRuntimeGlobal(dAppRuntimeValues:=dValues)
    
    If clsAppRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestInitAppRuntime = eTestResult
    clsAppRuntime.Delete
    ResetAppRuntimeGlobal

End Function

