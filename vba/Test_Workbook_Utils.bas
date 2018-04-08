Attribute VB_Name = "Test_Workbook_Utils"
Const CsModuleName = "Test_Workbook_Utils"



Function T_e_st_CreateHiddenSheet()
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
setup:
    sFuncName = CsModuleName & "." & "CreateHiddenSheet"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    wsTmp.Visible = xlSheetHidden
    
End Function
Function Test_ShowSheet() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
setup:
    sFuncName = CsModuleName & "." & "ShowSheet"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:
    HideSheet ActiveWorkbook, sSheetName
    ShowSheet ActiveWorkbook, sSheetName
    If SheetIsVisible(ActiveWorkbook, sSheetName) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ShowSheet = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName

End Function

Function Test_ToggleSheet() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
setup:
    
    sFuncName = CsModuleName & "." & "ToggleSheet"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:

    ToggleSheet ActiveWorkbook, sSheetName
    If SheetIsVisible(ActiveWorkbook, sSheetName) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    ToggleSheet ActiveWorkbook, sSheetName
    If SheetIsVisible(ActiveWorkbook, sSheetName) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ToggleSheet = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function
