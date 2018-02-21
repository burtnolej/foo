Attribute VB_Name = "Test_Array_Utils"
Const CsModuleName = "Test_Array_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_HasNDimensions
    Test_EqualsArray
    Test_ConvertArrayFromRangeto1D
    Test_Is2DArray
    Test_ArrayNDtoString
    Test_InArray
    Test_ReDim2DArray
    
    'GetLogFile
    
End Sub
Sub Test_ReDim2DArray()
Dim aTmp() As String
Dim aTmpVariant As Variant

Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "ReDim2DArray"
    aTmp = Init2DStringArray([{"A","B","C","","","";"D","E","F","","","";"","","","","",""}])
    aTmpVariant = Init2DVariantArray(aTmp)
main:

    aTmp = ReDim2DArray(aTmp, 2, 3)
    
    If ArrayNDtoString(aTmp) <> "A^B^C$$D^E^F" Then
        GoTo fail
    End If
    
    aTmpVariant = ReDim2DArray(aTmpVariant, 2, 3)
    
    If ArrayNDtoString(aTmpVariant) <> "A^B^C$$D^E^F" Then
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


Sub Test_InArray()
' test that an inarray can be used in a conditional check like an IF Then statement
Dim a2dTmp() As String
Dim aNdTmp() As String
Dim aTmp() As String
Dim a2dIntTmp() As Integer
Dim aIntTmp() As Integer
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "InArray"
    
main:

    If InArray(Array("A", "B"), "A") <> True Then
        GoTo fail
    End If


    If InArray(Array("A", "B"), "C") <> False Then
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

Sub Test_ArrayNDtoString()
' test 2d 1d and nd; decoded and plain
Dim a2dTmp() As String
Dim aNdTmp() As String
Dim aTmp() As String
Dim a2dIntTmp() As Integer
Dim aIntTmp() As Integer
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "ArrayNDtoString"
    
main:
    a2dTmp = Init2DStringArray([{"a","b";"c","d"}])
    aNdTmp = Init2DStringArray([{"A","B","C";"D","E","F";"G","H","I"}])
    aTmp = InitStringArray(Array("A", "B"))

    If ArrayNDtoString(a2dTmp) <> "A^B$$C^D" Then
        GoTo fail
    End If
    
    If ArrayNDtoString(a2dTmp, bUUEncode:=True) <> "QQ==^Qg==$$Qw==^RA==" Then
        GoTo fail
    End If
    
    If ArrayNDtoString(aTmp) <> "A$$B" Then
        GoTo fail
    End If
    
    If ArrayNDtoString(aTmp, bUUEncode:=True) <> "QQ==$$Qg==" Then
        GoTo fail
    End If
    
    Debug.Print ArrayNDtoString(aNdTmp)
    
    If ArrayNDtoString(aNdTmp) <> "A^B^C$$D^E^F$$G^H^I" Then
        GoTo fail
    End If
        
    If ArrayNDtoString(aNdTmp, sRowDelim:="_", sFieldDelim:="&") <> "A&B&C_D&E&F_G&H&I" Then
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


Sub Test_Is2DArray()
' Test if can detect 2d integer and string arrays
Dim a2dTmp() As String
Dim aTmp() As String
Dim a2dIntTmp() As Integer
Dim aIntTmp() As Integer
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "Is2DArray"
    
main:
    a2dTmp = Init2DStringArray([{"a","b";"c","d"}])
    aTmp = InitStringArray(Array("A", "B"))

    If Is2DArray(a2dTmp) = False Then
        GoTo fail
    End If
    
    If Is2DArray(aTmp) = True Then
        GoTo fail
    End If
    
    a2dIntTmp = Init2DIntArray([{1,2;3,4}])
    aTmp = InitStringArray(Array(1, 2))

    If Is2DArray(a2dIntTmp) = False Then
        GoTo fail
    End If
    
    If Is2DArray(aIntTmp) = True Then
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
Sub Test_HasNDimensions()
' Using variant, int and string arrays, test both true/false cases

Dim sFuncName As String
Dim vSource() As String
Dim aSource() As Integer

Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "HasNDimensions"
    
main:
    vSource = Init2DStringArray([{"a","b";"c","d"}])
    
    If HasNDimensions(vSource, 2) = False Then
        GoTo fail
    End If
    
    vSource = InitStringArray(Array("A", "B"))

    If HasNDimensions(vSource, 1) = False Then
        GoTo fail
    End If
    
    If HasNDimensions(vSource, 3) = True Then
        GoTo fail
    End If
    
    aSource = Init2DIntArray([{1,2;3,4}])
    
    If HasNDimensions(aSource, 2) = False Then
        GoTo fail
    End If
    
    aSource = InitIntArray(Array(1, 2))

    If HasNDimensions(aSource, 1) = False Then
        GoTo fail
    End If
    
    If HasNDimensions(aSource, 3) = True Then
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


Sub Test_ConvertArrayFromRangeto1D()
' test compare success and failure cases for variant, integer and string arrays
Dim sFuncName As String
Dim vSource() As String
Dim vTarget() As String

Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "ConvertArrayFromRangeto1D"
    ReDim vSource(1 To 2, 1 To 2)
main:
    vSource(1, 1) = "A"
    vSource(1, 2) = ""
    vSource(2, 1) = "C"
    vSource(2, 2) = ""
    
    vTarget = ConvertArrayFromRangeto1D(vSource)
    
    If EqualsArray(vTarget, Array("A", "C")) <> True Then
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
Sub Test_EqualsArray()
' Array Compare - test compare success and failure cases for variant, integer and string arrays
Dim vArray1() As Variant
Dim vArray2() As Variant
Dim aArray1() As String
Dim aArray2() As String
Dim aArrayInt1() As String
Dim aArrayInt2() As String
Dim bResult As Boolean
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "EqualsArray"
    vArray1 = Array("tmp1", "tmp2")
    vArray2 = Array("tmp1", "tmp2")
    
    ReDim aArray1(0 To 1)
    ReDim aArray2(0 To 1)
    
    ReDim aArrayInt1(0 To 1)
    ReDim aArrayInt2(0 To 1)

    
main:
    bResult = EqualsArray(vArray1, vArray2)
    
    If bResult <> True Then
        GoTo fail
    End If

    ' String arrays
    aArray1(0) = "tmp1"
    aArray1(1) = "tmp2"
    aArray1 = aArray2
    
    bResult = EqualsArray(aArray1, aArray2)
    
    If bResult <> True Then
        GoTo fail
    End If
    
    aArray2(0) = "tmp1"
    aArray2(1) = "tmp3"
    
    bResult = EqualsArray(aArray1, aArray2)
    
    If bResult <> False Then
        GoTo fail
    End If
    

    ' Integer arrays
    aArrayInt1(0) = 1
    aArrayInt1(1) = 2
    aArrayInt1 = aArrayInt2
    
    bResult = EqualsArray(aArrayInt1, aArrayInt2)
    
    If bResult <> True Then
        GoTo fail
    End If

    aArrayInt2(0) = 2
    aArrayInt2(1) = 2
    
    bResult = EqualsArray(aArrayInt1, aArrayInt2)
    
    If bResult <> False Then
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
