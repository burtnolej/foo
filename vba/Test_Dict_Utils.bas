Attribute VB_Name = "Test_Dict_Utils"
Option Explicit

Const CsModuleName = "Test_Dict_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_Dict2Array
    
    'GetLogFile
    
End Sub
Sub Test_Dict2Array()
Dim sFuncName As String
Dim dTmp As New Dictionary
Dim dTmp2 As New Dictionary
Dim dTmp3 As New Dictionary
Dim aResult() As String
Dim bTestPassed As Boolean

setup:
    
    sFuncName = CsModuleName & "." & "Dict2Array"

    dTmp2.Add "item1", "foo"
    dTmp2.Add "item2", "bar"
    dTmp.Add "foo", dTmp2
    
    dTmp3.Add "item1", "foo2"
    dTmp3.Add "item2", "bar2"
    dTmp.Add "foo2", dTmp3
    
    aResult = Dict2Array(dTmp, InitStringArray(Array("item1", "item2")))
    
    If ArrayNDtoString(aResult) <> "foo^foo^bar$$foo2^foo2^bar2" Then
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

