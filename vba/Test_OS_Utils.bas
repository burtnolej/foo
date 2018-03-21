Attribute VB_Name = "Test_OS_Utils"
Option Explicit
Const CsModuleName = "Test_Shell_Utils"
Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    
    ' test that single and multi line results can be parsed
    Test_ShellRun
    

    Test_PopUpWindow

    'GetLogFile
End Sub
Sub Test_ShellRun()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim aArgs() As String
Dim aResults() As String

setup:

     sFuncName = "ShellRun"
     
main:

    aArgs = InitStringArray(Array("hostname"))

    If ShellRun(aArgs) <> "puma-PC" & vbCrLf Then
        GoTo fail
    End If

    aArgs = InitStringArray(Array("systeminfo"))

    aResults = Split(ShellRun(aArgs), vbCrLf)
    
    If aResults(6) <> "Registered Owner:          burtnolej" Then
        GoTo fail
    End If
    
    aArgs = InitStringArray(Array("foobar"))

    aResults = Split(ShellRun(aArgs), vbCrLf)
    
    If aResults(0) <> "-1" Then
        GoTo fail
    End If

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub Test_PopUpWindow()
Dim sFuncName As String
Dim iType As Integer
Dim iReturnCode As Integer
Dim bTestPassed As Boolean
    
    sFuncName = "PopUpWindow"
    
    iType = vbYesNoCancel + vbQuestion + vbDefaultButton2
    iReturnCode = PopUpWindow("This is a sensible question", "This is my title", iType, iWait:=1)
    
    If iReturnCode <> -1 Then
        GoTo fail
    End If

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
End Sub


