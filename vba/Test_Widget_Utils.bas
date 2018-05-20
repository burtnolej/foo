Attribute VB_Name = "Test_Widget_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_Widget_Utils"

Function Test_GetWidgetSizes() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim iColWidthCount As Integer
Dim vColWidths() As Integer, vRowHeights() As Integer
setup:
    
    sFuncName = C_MODULE_NAME & "." & "GetWidgetColWidths"
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

    vColWidths = GetWidgetSizes(wsTmp, rSource)
    vRowHeights = GetWidgetSizes(wsTmp, rSource, eWidgetDim:=WidgetDimension.Vz)
    
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
    Test_GetWidgetSizes = eTestResult
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
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatButton"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.Name = "fButtonInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsAppRuntime.CacheBook
    
main:

    FormatWidget clsAppRuntime.Book, clsAppRuntime.Book, sSheetName, rTarget, WidgetState.Invalid, _
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
    clsAppRuntime.Delete
    
End Function

Function Test_FormatEntry() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatEntry"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.Name = "fEntryInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsAppRuntime.CacheBook
    
main:

    FormatWidget clsAppRuntime.Book, clsAppRuntime.Book, sSheetName, rTarget, WidgetState.Invalid, _
            sSourceSheetName:=sSheetName, eWidgetType:=Entry
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
    clsAppRuntime.Delete
    
End Function
Function Test_FormatColRowSize_1Widget() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rTarget = .Range(.Cells(4, 10), .Cells(4, 10))
        rSource.EntireRow.RowHeight = 10
        rSource.EntireColumn.ColumnWidth = 5
        rSource.Name = "foo"
    End With
    
main:

    FormatColRowSize clsAppRuntime.Book, clsAppRuntime.Book, sSheetName, sSheetName, "foo", _
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
    Test_FormatColRowSize_1Widget = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsAppRuntime.Delete
    
End Function


Function Test_FormatColRowSize_Range() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(5, 5))
        Set rTarget = .Range(.Cells(10, 10), .Cells(15, 15))
        rSource.EntireRow.RowHeight = 3
        rSource.EntireColumn.ColumnWidth = 3
        rSource.Name = "foo"
    End With
    
main:

    FormatColRowSize clsAppRuntime.Book, clsAppRuntime.Book, sSheetName, sSheetName, "foo", _
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
    clsAppRuntime.Delete
    
End Function

Function Test_FormatColRowSize_Range_DiffSizes() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(5, 5))
        Set rTarget = .Range(.Cells(10, 10), .Cells(15, 15))
        rSource.EntireRow.RowHeight = 3
        rSource.EntireColumn.ColumnWidth = 3
        rSource.Rows(2).EntireRow.RowHeight = 20
        rSource.Columns(2).EntireColumn.ColumnWidth = 20
        rSource.Name = "foo"
    End With
    
main:

    FormatColRowSize clsAppRuntime.Book, clsAppRuntime.Book, sSheetName, sSheetName, "foo", _
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
    clsAppRuntime.Delete

   
End Function

Function Test_FormatColRowSize_Range_MergedWidget() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(5, 5))
        Set rTarget = .Range(.Cells(10, 10), .Cells(15, 15))
        rSource.EntireRow.RowHeight = 3
        rSource.EntireColumn.ColumnWidth = 3
        rSource.Rows(2).EntireRow.RowHeight = 20
        rSource.Columns(2).EntireColumn.ColumnWidth = 20
        rSource.Name = "foo"
        rSource.Merge
    End With
    
main:

    FormatColRowSize clsAppRuntime.Book, clsAppRuntime.Book, sSheetName, sSheetName, "foo", _
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
    Test_FormatColRowSize_Range_MergedWidget = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsAppRuntime.Delete
    
End Function



Function Test_FormatWidgetInvalid() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "FormatWidgetInvalid"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
    End With
    
    FormatWidgetInvalid "test", rTarget

    If GetBgColor(sSheetName, rTarget).AsString <> "255,0,0" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK


    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatWidgetInvalid = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function

