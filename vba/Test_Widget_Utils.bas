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
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatButton"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.name = "fButtonInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsQuadRuntime.CacheBook
    
main:

    FormatWidget clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, rTarget, WidgetState.Invalid, _
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
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatEntry"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.CacheBook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.name = "fEntryInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsQuadRuntime.CacheBook
    
main:

    FormatWidget clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, rTarget, WidgetState.Invalid, _
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
    clsQuadRuntime.Delete
    
End Function
Function Test_FormatColRowSize_1Widget() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
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
    Test_FormatColRowSize_1Widget = eTestResult
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
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
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
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
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

Function Test_FormatColRowSize_Range_MergedWidget() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
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
    Test_FormatColRowSize_Range_MergedWidget = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function TestIsValidInteger() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime

setup:
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "IsValidInteger"

main:
    If IsValidInteger(clsQuadRuntime, 123) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(clsQuadRuntime, "ABC") <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(clsQuadRuntime, 123) = True Then
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
 
    If IsValidInteger(clsQuadRuntime, "ABC") = False Then
        eTestResult = TestResult.OK
    Else
        eTestResult = TestResult.Failure
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsValidInteger = eTestResult
    clsQuadRuntime.Delete
    
End Function

Function TestIsValidPrep() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime

setup:
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "IsValidPrep"

main:
    If IsValidPrep(clsQuadRuntime, 1) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidPrep(clsQuadRuntime, 11) <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsValidPrep = eTestResult
    clsQuadRuntime.Delete
    
End Function

Function TestValidations() As TestResult

Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult
Dim rInput As Range
Dim clsQuadRuntime As New App_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "Validations"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger";"AddStudent","Student","StudentAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    
main:
    With wsTmp
        Set rInput = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rInput.value = 123
    rInput.name = "eAddStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.AddBook, "test", rInput)
    
    If bResult = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    rInput.value = "ABC"
    rInput.name = "eAddStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.AddBook, "test", rInput)
    
    If bResult = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestValidations = eTestResult
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete

End Function
Function TestIsMemberOfTable() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As Variant
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsQuadRuntime As New App_Runtime
 
setup:
    'On Error GoTo err:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = C_MODULE_NAME & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember";"AddFoo","Foo","FooAge","Integer","IsValidInteger";"AddBar","Bar","BarName","List","IsMember";"AddBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    CreateTables clsQuadRuntime.CacheBook
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
main:
   
    If IsMember(clsQuadRuntime, "Jon", Array("Foo", "FooName")) <> True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsMemberOfTable = eTestResult
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.AddBook, "Foo"
    DeleteSheet clsQuadRuntime.AddBook, "Bar"
    clsQuadRuntime.Delete
    
 End Function

Function TestIsMemberOfTableFailure() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsQuadRuntime As New App_Runtime
 
setup:
    On Error GoTo err:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = C_MODULE_NAME & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember";"AddFoo","Foo","FooAge","Integer","IsValidInteger";"AddBar","Bar","BarName","List","IsMember";"AddBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    CreateTables clsQuadRuntime.CacheBook
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows
    
main:
    If IsMember(clsQuadRuntime, "Nancy", Array("Foo", "FooName")) <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsMemberOfTableFailure = eTestResult
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.AddBook, "Foo"
    DeleteSheet clsQuadRuntime.AddBook, "Bar"
    clsQuadRuntime.Delete
    
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

