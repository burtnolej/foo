Attribute VB_Name = "Test_Utils"
'Sub    TestLogIt(sFuncName As String, bTestPassed As Boolean)
Const CsModuleName = "Test_Utils"
Public Enum TestResult
    OK = 0
    Failure = 1
    Error = 2
End Enum

Public Const sTestResultEnum = "OK,Failure,Error"

Function GetTestModulesInBook(sBookName As String, Optional sBookPath As String) As String()
Dim wbTmp As Workbook
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim vModulesNames() As String
Dim iCount As Integer

    ReDim vModulesNames(0 To 100)
    Set wbTmp = OpenBook(sBookName, sPath:=sBookPath)
    'Set wbTmp = Workbooks(sBookName)
    

    Set VBProj = wbTmp.VBProject
    For Each VBComp In VBProj.VBComponents
        If Left(VBComp.name, 5) = "Test_" Then
            vModulesNames(iCount) = VBComp.name
            iCount = iCount + 1
        End If
    Next VBComp

    ReDim Preserve vModulesNames(0 To iCount - 1)
    GetTestModulesInBook = vModulesNames
    
End Function
Function GetTestsInModule(wbTmp As Workbook, sModuleName As String) As Dictionary
    Set GetTestsInModule = GetProcsInModules(wbTmp, sModuleName, bTestsOnly:=True)
End Function

Sub DoDumpTestsInBook()
    DumpTestsInBook "vba_source_new.xlsm"
End Sub
Function DumpTestsInBook(sBookName As String)
Dim aModuleNames() As String
Dim dTestCases As Dictionary
Dim sTestCase As Variant

Dim iModuleCount As Integer
    aModuleNames = GetTestModulesInBook(sBookName)
    For iModuleCount = 0 To UBound(aModuleNames)
        Set dTestCases = GetTestsInModule(Workbooks(sBookName), aModuleNames(iModuleCount))
        For Each sTestCase In dTestCases
            Debug.Print sTestCase
        Next sTestCase
    Next iModuleCount

End Function

' <project>-<summary>--<OK=#>
'          |         |-<Failure=#>
'          |         |-<Error=#>
'          |-<module1>-<summary>--<Failure=#>
'          |          |         |-<Error=#>
'          |          |         |-<Test>OK/Fail/Err</Test>
'          |          |-<Test1>OK/Fail/Err</Test>
'          |          |-<Test2>OK/Fail/Err</Test>
'          |-<module2>--<OK>#</OK>
'                     |-<Failure>#</Failure>
'                     |-<Error>#</Error>
'                     |-<Test>OK/Fail/Err</Test>

Sub AddTestResults(ByRef dModuleTestResult As Dictionary, eTestResult As TestResult, sTest As Variant)
Dim dModuleTestResultSummary As Dictionary
    Set dModuleTestResultSummary = dModuleTestResult.Item("summary")
    dModuleTestResult.Add sTest, Split(Test_Utils.sTestResultEnum, ",")(eTestResult)
    dModuleTestResultSummary.Item(Split(Test_Utils.sTestResultEnum, ",")(eTestResult)) = _
    dModuleTestResultSummary.Item(Split(Test_Utils.sTestResultEnum, ",")(eTestResult)) + 1
End Sub
Function InitTestSummary() As Dictionary
Dim dTmp As New Dictionary
    For i = 0 To UBound(Split(Test_Utils.sTestResultEnum, ","))
        dTmp.Add sEnumStr & Split(Test_Utils.sTestResultEnum, ",")(i), 0
    Next i
    Set InitTestSummary = dTmp
End Function

Sub DumpTestResultsToDB(dProjectTestResult As Dictionary, sBookName As String, _
        sDatabaseName As String, sTableName As String, _
        Optional sFileName As String)
Dim sModuleTest As Variant, vTestResult As Variant, sTestCase As Variant, vTestCase As Variant
Dim aColumnDefns() As Variant, aRows() As String
Dim aColumns() As String, aArgs() As String
Dim iResultCount As Integer
Dim sExecPath As String

    If sFileName = "" Then sFileName = Environ("MYHOME") & "\\unifoo.txt"
    'End If
    
    sExecPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\"
    
    
    ReDim aRows(0 To 1000, 0 To 5)

    aColumnDefns = Init2DVariantArray([{"date","Text";"time","Text";"book_name","Text";"module_name","Text";"test_name","Text";"test_result","Text"}])
    aColumns = InitStringArray(Array("date", "time", "book_name", "module_name", "test_name", "test_result"))
    
    For Each sModuleTest In dProjectTestResult.Keys()
        If sModuleTest <> "summary" Then
            For Each vTestCase In dProjectTestResult.Item(sModuleTest).Keys()
                If vTestCase <> "summary" Then
                    aRows(iResultCount, 0) = GetDateString(Now(), "ddmmyy")
                    aRows(iResultCount, 1) = GetDateString(Now(), "HHMMSS")
                    aRows(iResultCount, 2) = sBookName
                    aRows(iResultCount, 3) = sModuleTest
                    aRows(iResultCount, 4) = vTestCase
                    aRows(iResultCount, 5) = dProjectTestResult.Item(sModuleTest).Item(vTestCase)
                    iResultCount = iResultCount + 1
                End If
                
            Next vTestCase
        End If
    Next sModuleTest
    
    aRows = ReDim2DArray(aRows, iResultCount, 6)
        
    CreatePySqliteArgsFile sDatabaseName, sTableName, aColumnDefns:=aColumnDefns, sFileName:=sFileName, _
                           aRows:=aRows, aColumns:=aColumns
    
    ' test is the table already exists
    'CreatePySqliteArgsFile sDatabaseName, sTableName, sFileName:=sFileName
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", "--access_type table_exists", "--input_filename " & sFileName))
    If Left(ShellRun(aArgs), 4) <> "True" Then
        ' create db/table
        aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
                "--access_type create", "--input_filename " & sFileName))
        sResults = ShellRun(aArgs)
    End If

    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", "--input_filename " & sFileName))
    sResults = ShellRun(aArgs)
    
End Sub
Sub DumpTestResults(dProjectTestResult As Dictionary, Optional bDumpTestCase As Boolean = False)
Dim sModuleTest As Variant, vTestResult As Variant, sTestCase As Variant, vTestCase As Variant
Dim dProjectTestResultSummary As Dictionary
Dim dModuleTestResultSummary As Dictionary
Dim dModuleTestResult As Dictionary

    For Each sModuleTest In dProjectTestResult.Keys()
        If sModuleTest <> "summary" Then
            For Each vTestResult In Split(Test_Utils.sTestResultEnum, ",")
                Debug.Print sModuleTest, vTestResult, dProjectTestResult.Item(sModuleTest).Item("summary").Item(vTestResult)
            Next vTestResult
            
            If bDumpTestCase = True Then
                For Each vTestCase In dProjectTestResult.Item(sModuleTest).Keys()
                    If vTestCase <> "summary" Then
                        Debug.Print sModuleTest, vTestCase, vTestResult, dProjectTestResult.Item(sModuleTest).Item(vTestCase)
                    End If
                Next vTestCase
            End If
        End If
    Next sModuleTest
End Sub
Function TestFromPython(sList As String, sList2 As String) As String
Dim vSplits() As String

    vSplits = Split(sList, COMMA)
    
    TestFromPython = Join(vSplits, HAT)
End Function
Sub DoProjectTestRunner()
Dim sIncModules As String
    
    MinimumWindowState
    sIncModules = "Test_Form_Utils"
    ProjectTestRunner sIncModules
    Exit Sub
    
    sIncModules = sIncModules & ",Test_App_Schedule"
    sIncModules = sIncModules & ",Test_App_Schedule_Add"
    sIncModules = sIncModules & ",Test_App_Person"
    sIncModules = sIncModules & ",Test_App_Courses"
    sIncModules = sIncModules & ",Test_Array_Utils"
    'sIncModules = sIncModules & ",Test_DB_Utils"
    sIncModules = sIncModules & ",Test_Form_Utils"
    sIncModules = sIncModules & ",Test_Dict_Utils,Test_File_Utils"
    sIncModules = sIncModules & ",Test_Filter_Utils"
    sIncModules = sIncModules & ",Test_Format_Utils"
    sIncModules = sIncModules & ",Test_Macros"
    sIncModules = sIncModules & ",Test_Misc_Utils"
    'sIncModules = sIncModules & ",Test_Module_Utils"
    sIncModules = sIncModules & ",Test_OS_Utils"
    sIncModules = sIncModules & ",Test_Quad_Utils"
    sIncModules = sIncModules & ",Test_Quad_Runtime"
    sIncModules = sIncModules & ",Test_Range_Utils,Test_String_Utils"
    sIncModules = sIncModules & ",Test_Table_Utils"
    sIncModules = sIncModules & ",Test_Widget_Utils,Test_Workbook_Utils"
    sIncModules = sIncModules & ",Test_XML_utils"
    sIncModules = sIncModules & ",Test_Window_Utils"
    ProjectTestRunner sIncModules

End Sub
Sub ProjectTestRunner(Optional sIncModules As String)
'Optional aIncModules As Variant,
Dim aProjectTestModules() As String
Dim dProjectTestResult As New Dictionary
Dim dProjectTestResultSummary As Dictionary
Dim dModuleTestResult As Dictionary
Dim dModuleTestResultSummary As Dictionary
Dim dTmp As Dictionary
Dim aIncModules As Variant
Dim sModuleTest As Variant
Dim vTestResult As Variant

    GetLogFile
    Log_Utils.LogFilter = "0,1,2,3,4,8,9"
     
    If sIncModules <> "" Then
        aIncModules = Split(sIncModules, ",")
    End If
    
    aProjectTestModules = GetTestModulesInBook("vba_source_new.xlsm", _
        sBookPath:=Environ("MYHOME") & "\\GitHub\\quadviewer")
        
    Set dProjectTestResultSummary = InitTestSummary()
    dProjectTestResult.Add "summary", dProjectTestResultSummary
    
    For Each sModuleTest In aProjectTestModules
        If IsSet(aIncModules) = True Then
            If InArray(aIncModules, sModuleTest) = False Then
                GoTo nextmodule
            End If
        End If
        
        Debug.Print sModuleTest
        ' for this module, create a dictionary to store results for this module
        Set dModuleTestResult = New Dictionary

        ' for this module, create a node for the summary and initialize
        Set dModuleTestResultSummary = InitTestSummary()
        dModuleTestResult.Add "summary", dModuleTestResultSummary
        
        ' on the project, create a node for this module and assign the dict
        dProjectTestResult.Add sModuleTest, dModuleTestResult

        ' run the tests for the module, passing by ref the dictionary to store the results
        ModuleTestRunner dModuleTestResult, CStr(sModuleTest)
        'Application.Run sModuleTest & ".ModuleTestRunner", dModuleTestResult
        
        'add the module results to the project results
        For Each vTestResult In Split(Test_Utils.sTestResultEnum, ",")
            dProjectTestResultSummary.Item(vTestResult) = _
            dProjectTestResultSummary.Item(vTestResult) + _
            dModuleTestResultSummary.Item(vTestResult)
        Next vTestResult
nextmodule:
    Next sModuleTest
        
    'If bToDB = True Then
    DumpTestResultsToDB dProjectTestResult, "vba_source_new.xlsm", "foobar", "foobar"
    'Else
    '    DumpTestResults dProjectTestResult
    'End If
End Sub
Function ModuleTestRunner(ByRef dModuleTestResult As Dictionary, sModuleName As String)
Dim eTestResult As TestResult
Dim sTest As Variant
Dim wbTmp As Workbook
    
    Set wbTmp = OpenBook(Environ("MYHOME") & "\\GitHub\\quadviewer\\vba_source_new.xlsm")
    'Set dTestCases = GetTestsInModule(Workbooks("vba_source_new.xlsm"), sModuleName)
    Set dTestCases = GetTestsInModule(wbTmp, sModuleName)
    For Each sTestCase In dTestCases
        Debug.Print "   " & sTestCase
        eTestResult = TestResult.Error
        On Error Resume Next
        eTestResult = Application.Run(sModuleName & "." & sTestCase)
        Debug.Print "     =>" & eTestResult
        On Error GoTo 0
        AddTestResults dModuleTestResult, eTestResult, sTestCase
        
        Call TestLogItEnum(CStr(sTestCase), eTestResult)
    Next sTestCase

End Function

Public Sub TestLogIt(sFuncName As String, bTestPassed As Boolean)
Dim aLogVals() As String
Dim aLogWidths() As Integer
Dim sNowTime As String
Dim sNowDate As String
Dim eTestMsgType As LogMsgType

    sNowTime = GetDateString(Now(), "HH:MM:SS")
    sNowDate = GetDateString(Now(), "ddmmyy")
    
    If bTestPassed = True Then
        eTestMsgType = LogMsgType.PASS_TEST
    Else
        eTestMsgType = LogMsgType.FAIL_TEST
    End If
    aLogVals = InitStringArray(Array(sNowTime, eTestMsgType, sFuncName, "", sNowDate))
    aLogWidths = InitIntArray(Array(10, 8, 40, 60, 10))
    Call WriteToLog(aLogVals, aLogWidths)
End Sub
Public Sub TestLogItEnum(sFuncName As String, eTestResult As TestResult)
Dim aLogVals() As String
Dim aLogWidths() As Integer
Dim sNowTime As String
Dim sNowDate As String
Dim eTestMsgType As LogMsgType

    sNowTime = GetDateString(Now(), "HH:MM:SS")
    sNowDate = GetDateString(Now(), "ddmmyy")
    
    aLogVals = InitStringArray(Array(sNowTime, eTestResult, sFuncName, "", sNowDate))
    aLogWidths = InitIntArray(Array(10, 8, 40, 60, 10))
    Call WriteToLog(aLogVals, aLogWidths)
End Sub



