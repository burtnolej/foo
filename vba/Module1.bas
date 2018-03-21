Attribute VB_Name = "Module1"
Option Explicit


Sub test()
Dim s As String
Dim i As Integer
Dim max As Integer
Dim inc As Integer

    s = "^b^c^d"

    max = Len(s)
    inc = 2
    
    For i = max To inc Step -1 * inc
        Debug.Print Mid(s, i - 1, inc)
    Next i
End Sub



Sub test2()

Dim a() As Variant
Dim b() As Variant
Dim C As Variant


    a = Init2DVariantArray([{1, 2, 3;4,5,6}])
    b = Init2DVariantArray([{7,8,9;10,11,12}])
    
    C = AddArrays(3, a, b)
    
End Sub

Sub test3()

Dim a() As String
Dim b() As String
Dim C As Variant


    a = Init2DStringArray([{1, 2, 3;4,5,6}])
    b = Init2DStringArray([{7,8,9;10,11,12}])
    
    C = AddArrays(3, a, b)
    
End Sub


Sub passingbyref(ByRef arg As Range, ByRef vTmp As Variant)

    Set arg = Range("A1:A1")
    vTmp(0) = "foo"
    vTmp(1) = "bar"
End Sub

Sub testpassingbyref()
Dim rTmp As Range
Dim vTmp As Variant

    ReDim vTmp(0 To 1)
     passingbyref rTmp, vTmp
     Debug.Print rTmp.Address
End Sub


Sub poparray(ByRef vTmp() As Variant)

End Sub

Sub test4()
Dim a() As String, a2() As String
Dim s As String, s0 As String
s = "^2^3^4"
s0 = ""

   a = Split(s, HAT)
   
   a2 = Split(s0, HAT)
   
   Debug.Print UBound(a2)
End Sub

Function Test_NumColumns() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aTmp() As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".NumColumns"
    ReDim aTmp(0 To 100, 0 To 3)

main:
    If NumColumns(aTmp) <> 4 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_NumColumns = eTestResult
    
End Function

