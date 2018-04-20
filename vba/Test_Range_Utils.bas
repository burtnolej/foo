Attribute VB_Name = "Test_Range_Utils"
Option Explicit
Const CsModuleName = "Test_Range_Utils"

Function Test_GetRangeDimensions_Merged() As TestResult
Dim sFuncName As String, sSheetName As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim rSource As Range
Dim iWidth As Integer, iHeight As Integer

setup:
    sFuncName = CsModuleName & "." & "ListFromRange"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    Set rSource = wsTmp.Range("A1:C3")
    rSource.Merge
    Set rSource = wsTmp.Range("A1:A1")
    
    GetRangeDimensions rSource, iWidth, iHeight
    
    If iWidth <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If iHeight <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    Else
        eTestResult = TestResult.OK
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetRangeDimensions_Merged = eTestResult
    
    DeleteSheet ActiveWorkbook, sSheetName

End Function

Function Test_GetRangeDimensions() As TestResult
Dim sFuncName As String, sSheetName As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim rSource As Range
Dim iWidth As Integer, iHeight As Integer

setup:
    sFuncName = CsModuleName & "." & "ListFromRange"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    Set rSource = wsTmp.Range("A1:C3")
    
    GetRangeDimensions rSource, iWidth, iHeight
    
    If iWidth <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If iHeight <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    Else
        eTestResult = TestResult.OK
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetRangeDimensions = eTestResult
    
    DeleteSheet ActiveWorkbook, sSheetName

End Function

Function Test_ListFromRange_RangeDoesNotExist() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rTarget As Range
Dim vSource() As String
Dim vResult() As String

setup:
    sFuncName = CsModuleName & "." & "ListFromRange"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A","B";"C","D";"E","F"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    
main:

    On Error GoTo err
    vResult = ListFromRange(wsTmp, "foobar", bNamedRange:=True)
    eTestResult = TestResult.Failure
    GoTo teardown
    
err:
    eTestResult = TestResult.OK
    GoTo teardown
    
teardown:
    Test_ListFromRange_RangeDoesNotExist = eTestResult
    
    DeleteSheet ActiveWorkbook, sSheetName

End Function

Function Test_ListFromRange() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rTarget As Range
Dim vSource() As String
Dim vResult() As String

setup:
    sFuncName = CsModuleName & "." & "ListFromRange"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A","B";"C","D";"E","F"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    
main:

    vResult = ListFromRange(wsTmp, rTarget.Address)
     
    If Array2String(vResult) <> "ACE" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ListFromRange = eTestResult
    
    DeleteSheet ActiveWorkbook, sSheetName

End Function

Function Test_IsCell() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rTarget As Range

setup:
    sFuncName = CsModuleName & "." & "IsCell"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
    End With

main:
    If IsCell(rTarget) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rTarget = rTarget.Resize(, 2)
    
    If IsCell(rTarget) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsCell = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    
End Function
Function Test_IsBlankCell() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rTarget As Range

setup:
    sFuncName = CsModuleName & "." & "IsBlankCell"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
    End With

main:
    If IsBlankCell(rTarget) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    rTarget.value = 123
    
    If IsBlankCell(rTarget) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsBlankCell = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    
End Function
Function Test_GetSheetNamedRanges() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim aNames() As String

setup:
    sFuncName = CsModuleName & "." & "GetSheetNamedRanges"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    
    CreateNamedRange ActiveWorkbook, "A1:A1", sSheetName, "range1", "True"
    CreateNamedRange ActiveWorkbook, "B1:B1", sSheetName, "range2", "True"
    
main:
    aNames = GetSheetNamedRanges(ActiveWorkbook, sSheetName)
    
    If aNames(0) <> "range1" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If aNames(1) <> "range2" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetSheetNamedRanges = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function


Function Test_ListFromRow() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rTarget As Range
Dim vSource() As String
Dim vResult() As Variant

setup:
    'ReDim vResult(0 To 0, 0 To 2)
    sFuncName = CsModuleName & "." & "ListFromRange"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A", "B", "C";"","",""}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    ReDim vResult(0 To 0, 0 To 2)
main:

    rTarget.Select
    Set rTarget = rTarget.Resize(1)
    rTarget.Select
    vResult = rTarget.value
    'If Array2String(vResult) <> "ACE" Then
    '    eTestResult = TestResult.Failure
    'Else
    '    eTestResult = TestResult.OK
    'End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ListFromRow = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function
