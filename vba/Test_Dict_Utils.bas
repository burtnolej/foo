Attribute VB_Name = "Test_Dict_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_Dict_Utils"

Function Test_Dict2Array() As TestResult
Dim sFuncName As String
Dim dTmp As New Dictionary
Dim dTmp2 As New Dictionary
Dim dTmp3 As New Dictionary
Dim aResult() As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "Dict2Array"

    dTmp2.Add "item1", "foo"
    dTmp2.Add "item2", "bar"
    dTmp.Add "foo", dTmp2
    
    dTmp3.Add "item1", "foo2"
    dTmp3.Add "item2", "bar2"
    dTmp.Add "foo2", dTmp3
    
    aResult = Dict2Array(dTmp, InitStringArray(Array("item1", "item2")))
    
    If ArrayNDtoString(aResult) <> "foo^foo^bar$$foo2^foo2^bar2" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Dict2Array = eTestResult
End Function

