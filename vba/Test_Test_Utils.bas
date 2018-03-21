Attribute VB_Name = "Test_Test_Utils"
Const CsModuleName = "Test_Array_Utils"

Sub TestAllRunner()
Dim dTestResult As New Dictionary
Dim dSubTestResult As Dictionary
Dim vItem As Variant
    TestRunner dTestResult
    
    For Each vItem In dTestResult.Keys
        Set dSubTestResult = dTestResult.Item(vItem)
        Debug.Print dSubTestResult.Item(TestResult.OK)
    Next vItem
End Sub
Sub TestRunner(ByRef dTestResults As Dictionary)
Dim aTests() As String
Dim sTest As Variant
Dim eTestResult As TestResult
Dim dSubTestResult As Dictionary

    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    
    aTests = InitStringArray(Array("Test_EnumIterator"))
    
    
    For Each sTest In aTests
        If dTestResults.Exists(sTest) = False Then
            Set dSubTestResult = New Dictionary
            dSubTestResult.Add TestResult.OK, 0
            dSubTestResult.Add TestResult.Failure, 0
            dSubTestResult.Add TestResult.Error, 0
            dTestResults.Add sTest, dSubTestResult
        End If
        
        eTestResult = Application.Run(sTest)
        Set dSubTestResult = dTestResults.Item(sTest)
        dSubTestResult.Item(eTestResult) = dSubTestResult.Item(eTestResult) + 1
            
        Call TestLogItEnum(CStr(sTest), eTestResult)
    Next sTest
    'GetLogFile
End Sub

Function Test_EnumValueOf() As TestResult
Dim sFuncName As String
Dim vEnum As Variant
Dim sEnumStr As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".EnumValueOf"

main:

    If Split(Test_Utils.sTestResultEnum, ",")(0) <> "OK" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    If Split(Test_Utils.sTestResultEnum, ",")(1) <> "Failure" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    
    If Split(Test_Utils.sTestResultEnum, ",")(2) <> "Error" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_EnumValueOf = eTestResult
    
End Function
Function Test_EnumIterator() As TestResult
Dim sFuncName As String
Dim vEnum As Variant
Dim sEnumStr As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".EnumIterator"

main:

    For i = 0 To UBound(Split(Test_Utils.sTestResultEnum, ","))
        sEnumStr = sEnumStr & Split(Test_Utils.sTestResultEnum, ",")(i)
    Next i

    If sEnumStr <> "OKFailureError" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_EnumIterator = eTestResult
    
End Function

