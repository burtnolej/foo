Attribute VB_Name = "Test_OS_Utils"
Option Explicit
Const CsModuleName = "Test_Shell_Utils"
Function Test_ShellRun() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aArgs() As String
Dim aResults() As String

setup:

     sFuncName = "ShellRun"
     
main:

    aArgs = InitStringArray(Array("hostname"))

    If ShellRun(aArgs) <> "puma-PC" & vbCrLf Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    aArgs = InitStringArray(Array("systeminfo"))

    aResults = Split(ShellRun(aArgs), vbCrLf)
    
    If aResults(6) <> "Registered Owner:          burtnolej" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    aArgs = InitStringArray(Array("foobar"))

    aResults = Split(ShellRun(aArgs), vbCrLf)
    
    If aResults(0) <> "-1" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ShellRun = eTestResult
End Function

Function Test_PopUpWindow() As TestResult
Dim sFuncName As String
Dim iType As Integer
Dim iReturnCode As Integer
Dim eTestResult As TestResult
    
    sFuncName = "PopUpWindow"
    
    iType = vbYesNoCancel + vbQuestion + vbDefaultButton2
    iReturnCode = PopUpWindow("This is a sensible question", "This is my title", iType, iWait:=1)
    
    If iReturnCode <> -1 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PopUpWindow = eTestResult
End Function


