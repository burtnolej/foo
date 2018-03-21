Attribute VB_Name = "Test_Log_Utils"

Const CsModuleName = "Test_Log_Utils"
Sub TestRunner()
    'GetLogFile
    'Log_Utils.LogFilter = "8,9"
    
    Call TestWriteToLog
End Sub
Sub TestWriteToLog()
Dim vArray() As Variant
Dim sFuncName As String
Dim aWidths() As Integer
Dim aVals() As String
Dim sLogFileName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "." & "WriteToLog"
    vArray = Array("a", "b")
    sLogFileName = "C:\Users\burtnolej\test_log.txt"
    aVals = InitStringArray(Array("foo", "bar"))
    aWidths = InitIntArray(Array(10, 10))
    sExpectedResultStr = "foo       |bar       "
    
    Call GetLogFile(sLogFileName)

main:
    Call WriteToLog(aVals, aWidths)
    sResultStr = ReadFile(sLogFileName)
    
    If sExpectedResultStr <> sResultStr Then
        GoTo fail
    End If
    
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False
    
teardown:
    CloseLogFile
    DeleteFile sLogFileName
End Sub
