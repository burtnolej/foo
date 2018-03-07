Attribute VB_Name = "Test_Misc_Utils"
Const CsModuleName = "Test_Misc_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_UUEncode
    
    'GetLogFile
    
End Sub
Sub Test_UUEncode()
Dim sFuncName As String, sTmp As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "UUEncode"
    sTmp = "C:\\Users\\burtnolej''''"
main:

    If UUDecode(UUEncode(sTmp)) <> sTmp Then
        GoTo fail
    End If
    
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)

End Sub
