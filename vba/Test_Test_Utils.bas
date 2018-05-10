Attribute VB_Name = "Test_Test_Utils"
Const C_MODULE_NAME = "Test_Array_Utils"
Function Test_EnumValueOf() As TestResult
Dim sFuncName As String
Dim vEnum As Variant
Dim sEnumStr As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & ".EnumValueOf"

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
    sFuncName = C_MODULE_NAME & ".EnumIterator"

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

