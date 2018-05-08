Attribute VB_Name = "Test_Widget_Utils"
Option Explicit
Const CsModuleName = "Test_Widget_Utils"

Function Test_GetCellSizes() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim iColWidthCount As Integer
Dim vColWidths() As Integer, vRowHeights() As Integer
setup:
    
    sFuncName = CsModuleName & "." & "GetCellColWidths"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        .Range(.Cells(1, 1), .Cells(1, 1)).EntireRow.RowHeight = 1
        .Range(.Cells(3, 3), .Cells(3, 3)).EntireColumn.ColumnWidth = 1
        Set rSource = .Range(.Cells(1, 1), .Cells(3, 3))
        rSource.Merge
        Set rSource = .Range(.Cells(1, 1), .Cells(1, 1))
    End With
    
main:

    vColWidths = GetCellSizes(wsTmp, rSource)
    vRowHeights = GetCellSizes(wsTmp, rSource, eCellDim:=CellDimension.Vz)
    
    If UBound(vColWidths) <> 2 Then
        eTestResult = TestResult.Failure
    End If
    
    If UBound(vRowHeights) <> 2 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetCellSizes = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function

Sub test()
    Test_FormatButton
End Sub
    
Function Test_FormatButton() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "FormatButton"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.name = "fButtonInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsQuadRuntime.CacheBook
    
main:

    FormatCell clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, rTarget, CellState.Invalid, _
            sSourceSheetName:=sSheetName
    Set cRGB = GetBgColor(sSheetName, rTarget)
    
    If cRGB.AsString <> "255,255,0" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatButton = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function Test_FormatEntry() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "FormatEntry"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.name = "fEntryInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsQuadRuntime.CacheBook
    
main:

    FormatCell clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, rTarget, CellState.Invalid, _
            sSourceSheetName:=sSheetName, eCellType:=Entry
    Set cRGB = GetBgColor(sSheetName, rTarget)
    
    If cRGB.AsString <> "255,255,0" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatEntry = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete
    
End Function
Function Test_FormatColRowSize_1Cell() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rTarget = .Range(.Cells(4, 10), .Cells(4, 10))
        rSource.EntireRow.RowHeight = 10
        rSource.EntireColumn.ColumnWidth = 5
        rSource.name = "foo"
    End With
    
main:

    FormatColRowSize clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, sSheetName, "foo", _
            iTargetFirstRow:=4, iTargetFirstCol:=10
            
    If rTarget.EntireColumn.ColumnWidth <> 5 Then
        eTestResult = TestResult.Failure
    End If
    
    If rTarget.EntireRow.RowHeight <> 10 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatColRowSize_1Cell = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete
    
End Function


Function Test_FormatColRowSize_Range() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(5, 5))
        Set rTarget = .Range(.Cells(10, 10), .Cells(15, 15))
        rSource.EntireRow.RowHeight = 3
        rSource.EntireColumn.ColumnWidth = 3
        rSource.name = "foo"
    End With
    
main:

    FormatColRowSize clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, sSheetName, "foo", _
            iTargetFirstRow:=10, iTargetFirstCol:=10
            
    If rTarget.Columns(5).Rows(5).EntireColumn.ColumnWidth <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If rTarget.Columns(5).Rows(5).EntireRow.RowHeight <> 3 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatColRowSize_Range = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function Test_FormatColRowSize_Range_DiffSizes() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(5, 5))
        Set rTarget = .Range(.Cells(10, 10), .Cells(15, 15))
        rSource.EntireRow.RowHeight = 3
        rSource.EntireColumn.ColumnWidth = 3
        rSource.Rows(2).EntireRow.RowHeight = 20
        rSource.Columns(2).EntireColumn.ColumnWidth = 20
        rSource.name = "foo"
    End With
    
main:

    FormatColRowSize clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, sSheetName, "foo", _
            iTargetFirstRow:=10, iTargetFirstCol:=10
            
    If rTarget.Columns(2).Rows(2).EntireColumn.ColumnWidth <> 20 Then
        eTestResult = TestResult.Failure
    End If
    
    If rTarget.Columns(1).Rows(1).EntireRow.RowHeight <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If rTarget.Columns(3).Rows(3).EntireRow.RowHeight <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatColRowSize_Range_DiffSizes = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete

   
End Function

Function Test_FormatColRowSize_Range_MergedCell() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(5, 5))
        Set rTarget = .Range(.Cells(10, 10), .Cells(15, 15))
        rSource.EntireRow.RowHeight = 3
        rSource.EntireColumn.ColumnWidth = 3
        rSource.Rows(2).EntireRow.RowHeight = 20
        rSource.Columns(2).EntireColumn.ColumnWidth = 20
        rSource.name = "foo"
        rSource.Merge
    End With
    
main:

    FormatColRowSize clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, sSheetName, "foo", _
            iTargetFirstRow:=10, iTargetFirstCol:=10
            
    If rTarget.Columns(2).Rows(2).EntireColumn.ColumnWidth <> 20 Then
        rTarget.Select
        eTestResult = TestResult.Failure
    End If
    
    If rTarget.Columns(1).Rows(1).EntireRow.RowHeight <> 3 Then
        eTestResult = TestResult.Failure
    End If
    
    If rTarget.Columns(3).Rows(3).EntireRow.RowHeight <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatColRowSize_Range_MergedCell = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete
    
End Function


