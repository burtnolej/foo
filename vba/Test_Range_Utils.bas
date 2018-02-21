Attribute VB_Name = "Test_Range_Utils"
Option Explicit
Const CsModuleName = "Test_Range_Utils"
Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_GetSheetNamedRanges
    Test_ListFromRange
    Test_IsCell
    
    'GetLogFile
End Sub

Sub Test_ListFromRange()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub Test_IsCell()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
    Set rTarget = rTarget.Resize(, 2)
    
    If IsCell(rTarget) = True Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub Test_IsBlankCell()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
    rTarget.Value = 123
    
    If IsBlankCell(rTarget) = True Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub Test_GetSheetNamedRanges()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
    If aNames(1) <> "range2" Then
        GoTo fail
    End If
        
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub


Sub Test_ListFromRow()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim bTestPassed As Boolean
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
    
main:

    vResult = rTarget.Resize(1)
     
    'If Array2String(vResult) <> "ACE" Then
    '    GoTo fail
    'End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub
