Attribute VB_Name = "Test_Utils"
'Sub    TestLogIt(sFuncName As String, bTestPassed As Boolean)
Const CsModuleName = "Test_Utils"
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


