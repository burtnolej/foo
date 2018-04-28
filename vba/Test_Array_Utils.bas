Attribute VB_Name = "Test_Array_Utils"
Const CsModuleName = "Test_Array_Utils"

Public Function Test_Delim2Array_Variant() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim sTmp As String
Dim vTmp() As Variant

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".Init2DStringArray"
    
main:
    sTmp = "a^b^c^d$$1^2^3^4$$5^6^7^8"
    
    vTmp = Delim2Array(sTmp, bVariant:=True)
    
    If UBound(vTmp) <> 2 Then
        eTestResult = TestResult.Failure
    End If
    
    If UBound(vTmp, 2) <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If vTmp(2, 3) <> "8" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Delim2Array_Variant = eTestResult
    
End Function


Public Function Test_Delim2Array() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim sTmp As String
Dim vTmp() As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".Init2DStringArray"
    
main:
    sTmp = "a^b^c^d$$1^2^3^4$$5^6^7^8"
    
    vTmp = Delim2Array(sTmp)
    
    If UBound(vTmp) <> 2 Then
        eTestResult = TestResult.Failure
    End If
    
    If UBound(vTmp, 2) <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If vTmp(2, 3) <> "8" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Delim2Array = eTestResult
    
End Function

Public Function Test_Init2DStringArray() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim vTmp() As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".Init2DStringArray"
    
main:
    vTmp = Init2DStringArray([{"a","b","c","d";"1","2","3","4";"5","6","7","8"}])
    
    If UBound(vTmp) <> 2 Then
        eTestResult = TestResult.Failure
    End If
    
    If UBound(vTmp, 2) <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If vTmp(2, 3) <> "8" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init2DStringArray = eTestResult
    
End Function

Public Function Test_Init2DStringArrayFromString() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim sInputStr As String
Dim vTmp() As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".Init2DStringArrayFromString"
    sInputStr = "a^b^c^d$$1^2^3^4$$5^6^7^8"
    
main:
    vTmp = Init2DStringArrayFromString(sInputStr)
    
    If UBound(vTmp) <> 2 Then
        eTestResult = TestResult.Failure
    End If
    
    If UBound(vTmp, 2) <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If vTmp(2, 3) <> "8" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init2DStringArrayFromString = eTestResult
    
End Function


Public Function Test_NumColumns() As TestResult
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
Function Test_NumColumnsNot2DArray() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aTmp() As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".NumColumnsNot2DArray"
    ReDim aTmp(0 To 100)

main:

    If NumColumns(aTmp, bAssert:=False) <> 1 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_NumColumnsNot2DArray = eTestResult
    
End Function

Function Test_NumColumnsVariant() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aTmp() As Variant

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & ".NumColumnsVariant"
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
    Test_NumColumnsVariant = eTestResult
    
End Function

Function Test_ReDim2DArray() As TestResult
Dim aTmp() As String
Dim aTmpVariant As Variant

Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "ReDim2DArray"
    aTmp = Init2DStringArray([{"A","B","C","","","";"D","E","F","","","";"","","","","",""}])
    aTmpVariant = Init2DVariantArray(aTmp)
main:

    aTmp = ReDim2DArray(aTmp, 2, 3)
    
    If ArrayNDtoString(aTmp) <> "A^B^C$$D^E^F" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    aTmpVariant = ReDim2DArray(aTmpVariant, 2, 3)
    
    If ArrayNDtoString(aTmpVariant) <> "A^B^C$$D^E^F" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error

teardown:
    Test_ReDim2DArray = eTestResult
    
End Function

Function Test_ReDim2DArray_NonZero_StartColRow() As TestResult
Dim aTmp() As String
Dim aTmpVariant As Variant

Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "ReDim2DArray"
    ReDim aTmpVariant(1 To 3, 1 To 3)
    aTmpVariant(1, 1) = "A"
    aTmpVariant(1, 2) = "B"
    aTmpVariant(1, 3) = "C"
    
    aTmpVariant(2, 1) = "D"
    aTmpVariant(2, 2) = "E"
    aTmpVariant(2, 3) = "F"

    aTmpVariant(3, 1) = ""
    aTmpVariant(3, 2) = ""
    aTmpVariant(3, 3) = ""
    
main:

    aTmp = ReDim2DArray(aTmpVariant, 2, 2)
    
    If ArrayNDtoString(aTmp) <> "A^B$$D^E" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ReDim2DArray_NonZero_StartColRow = eTestResult
    
End Function

Function Test_InArray() As TestResult
' test that an inarray can be used in a conditional check like an IF Then statement
Dim a2dTmp() As String
Dim aNdTmp() As String
Dim aTmp() As String
Dim a2dIntTmp() As Integer
Dim aIntTmp() As Integer
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "InArray"
    
main:

    If InArray(Array("A", "B"), "A") <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If


    If InArray(Array("A", "B"), "C") <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_InArray = eTestResult

End Function

Function Test_ArrayNDtoString() As TestResult
' test 2d 1d and nd; decoded and plain
Dim a2dTmp() As String
Dim aNdTmp() As String
Dim aTmp() As String
Dim a2dIntTmp() As Integer
Dim aIntTmp() As Integer
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "ArrayNDtoString"
    
main:
    a2dTmp = Init2DStringArray([{"A","B";"C","D"}])
    aNdTmp = Init2DStringArray([{"A","B","C";"D","E","F";"G","H","I"}])
    aTmp = InitStringArray(Array("A", "B"))

    If ArrayNDtoString(a2dTmp) <> "A^B$$C^D" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If ArrayNDtoString(a2dTmp, bUUEncode:=True) <> "A^B$$C^D" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If ArrayNDtoString(aTmp) <> "A$$B" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If ArrayNDtoString(aTmp, bUUEncode:=True) <> "A$$B" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If ArrayNDtoString(aNdTmp) <> "A^B^C$$D^E^F$$G^H^I" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
        
    If ArrayNDtoString(aNdTmp, sRowDelim:="_", sFieldDelim:="&") <> "A&B&C_D&E&F_G&H&I" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
     
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ArrayNDtoString = eTestResult
    
End Function


Function Test_Is2DArray() As TestResult
' Test if can detect 2d integer and string arrays
Dim a2dTmp() As String
Dim aTmp() As String
Dim a2dIntTmp() As Integer
Dim aIntTmp() As Integer
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "Is2DArray"
    
main:
    a2dTmp = Init2DStringArray([{"A","B";"C","D"}])
    aTmp = InitStringArray(Array("A", "B"))

    If Is2DArray(a2dTmp) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Is2DArray(aTmp) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    a2dIntTmp = Init2DIntArray([{1,2;3,4}])
    aTmp = InitStringArray(Array(1, 2))

    If Is2DArray(a2dIntTmp) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Is2DArray(aIntTmp) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Is2DArray = eTestResult
    
End Function
Function Test_HasNDimensions() As TestResult
' Using variant, int and string arrays, test both true/false cases

Dim sFuncName As String
Dim vSource() As String
Dim aSource() As Integer

Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "HasNDimensions"
    
main:
    vSource = Init2DStringArray([{"A","B";"C","D"}])
    
    If HasNDimensions(vSource, 2) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    vSource = InitStringArray(Array("A", "B"))

    If HasNDimensions(vSource, 1) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If HasNDimensions(vSource, 3) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    aSource = Init2DIntArray([{1,2;3,4}])
    
    If HasNDimensions(aSource, 2) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    aSource = InitIntArray(Array(1, 2))

    If HasNDimensions(aSource, 1) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If HasNDimensions(aSource, 3) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_HasNDimensions = eTestResult
    
End Function


Function Test_ConvertArrayFromRangeto1D() As TestResult
' test compare success and failure cases for variant, integer and string arrays
Dim sFuncName As String
Dim vSource() As String
Dim vTarget() As String

Dim eTestResult As TestResult
setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "ConvertArrayFromRangeto1D"
    ReDim vSource(1 To 2, 1 To 2)
main:
    vSource(1, 1) = "A"
    vSource(1, 2) = ""
    vSource(2, 1) = "C"
    vSource(2, 2) = ""
    
    vTarget = ConvertArrayFromRangeto1D(vSource)
    
    If EqualsArray(vTarget, Array("A", "C")) <> True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ConvertArrayFromRangeto1D = eTestResult
    
End Function

Function Test_EqualsArray() As TestResult
' Array Compare - test compare success and failure cases for variant, integer and string arrays
Dim vArray1() As Variant
Dim vArray2() As Variant
Dim aArray1() As String
Dim aArray2() As String
Dim aArrayInt1() As String
Dim aArrayInt2() As String
Dim bResult As Boolean
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
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
        eTestResult = TestResult.Failure
    GoTo teardown
    End If

    ' String arrays
    aArray1(0) = "tmp1"
    aArray1(1) = "tmp2"
    aArray1 = aArray2
    
    bResult = EqualsArray(aArray1, aArray2)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    aArray2(0) = "tmp1"
    aArray2(1) = "tmp3"
    
    bResult = EqualsArray(aArray1, aArray2)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    ' Integer arrays
    aArrayInt1(0) = 1
    aArrayInt1(1) = 2
    aArrayInt1 = aArrayInt2
    
    bResult = EqualsArray(aArrayInt1, aArrayInt2)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    aArrayInt2(0) = 2
    aArrayInt2(1) = 2
    
    bResult = EqualsArray(aArrayInt1, aArrayInt2)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_EqualsArray = eTestResult
    
End Function

