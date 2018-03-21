Attribute VB_Name = "Test_Workbook_Utils"
Const CsModuleName = "Test_Workbook_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    
    Test_ShowSheet
    Test_ToggleSheet
    'GetLogFile
End Sub

Sub Test_ShowSheet()

Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim wsTmp As Worksheet
Dim bTestPassed As Boolean
setup:
    
    sFuncName = CsModuleName & "." & "ShowSheet"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:

    HideSheet ActiveWorkbook, sSheetName
    ShowSheet ActiveWorkbook, sSheetName
    If SheetIsVisible(ActiveWorkbook, sSheetName) = False Then
        GoTo fail
    End If

Success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub Test_ToggleSheet()

Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim wsTmp As Worksheet
Dim bTestPassed As Boolean
setup:
    
    sFuncName = CsModuleName & "." & "ToggleSheet"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:

    ToggleSheet ActiveWorkbook, sSheetName
    If SheetIsVisible(ActiveWorkbook, sSheetName) = True Then
        GoTo fail
    End If
    
    ToggleSheet ActiveWorkbook, sSheetName
    If SheetIsVisible(ActiveWorkbook, sSheetName) = False Then
        GoTo fail
    End If

Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub
