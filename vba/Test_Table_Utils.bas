Attribute VB_Name = "Test_Table_Utils"
'Function TestAddTableRecordManual()
'Function TestCreateTables()
'Function TestAddTableMultipleRecordManual()
'Function TestAddTableMultipleRecordMultiTableManual()
'Function TestAddTableRecordFail()
'Function TestAddTableRecordAuto()

Option Explicit
Const CsModuleName = "Test_Table_Utils"

Function TestAddTableRecordAuto() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String
Dim vSource() As String, vRows() As String, vColNames() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "AddTableRecordAuto"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
        
    AddTableRecordAuto ActiveWorkbook, "foo", vColNames, vRows
    
    Set dRecord = GetTableRecord("Foo", 2)
    
    If dRecord.Exists("FooAge") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If dRecord.Exists("FooName") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If dRecord.Item("FooName") <> "Quinton" Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If dRecord.Item("FooAge") <> "6" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If


    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddTableRecordAuto = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Function TestAddTableRecordManual() As TestResult
' From a definition, create entry forms, fill out values for a record, manually call function
' to add the single record (dont validate and use button) and then retreive the record
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "AddTableRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    
    GenerateEntryForms clsQuadRuntime, clsQuadRuntime.TemplateCellSheetName
    
    SetEntryValue "NewFoo", "FooAge", 123
    SetEntryValue "NewFoo", "FooName", "blahblah"
    
    AddTableRecord "Foo"
    
    Set dRecord = GetTableRecord("Foo", 1)
    
    If dRecord.Exists("FooAge") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If

    If dRecord.Exists("FooName") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If dRecord.Item("FooName") <> "blahblah" Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If dRecord.Item("FooAge") <> "123" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddTableRecordManual = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function


Function TestCreateTables() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim eTestResult As TestResult
setup:

    sFuncName = CsModuleName & "." & "CreateTables"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
  
    CreateTables
    
    If SheetExists(ActiveWorkbook, "foo") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If SheetExists(ActiveWorkbook, "bar") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(ActiveWorkbook, "foo", "dbFooFooAge") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(ActiveWorkbook, "bar", "dbBarBarName") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(ActiveWorkbook, "bar", "iBarNextFree") = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestCreateTables = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "foo"
    DeleteSheet ActiveWorkbook, "bar"

End Function


Function TestAddTableMultipleRecordManual() As TestResult
' From a definition, create entry forms, fill out values for a record, manually call function
' to add the single record (dont validate and use button) and then retreive the record
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sFuncName = CsModuleName & "." & "TestAddTableMultipleRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms clsQuadRuntime, clsQuadRuntime.TemplateCellSheetName
        
    SetEntryValue "NewFoo", "FooAge", 123
    SetEntryValue "NewFoo", "FooName", "blahblah"
    
    AddTableRecord "Foo"
    
    SetEntryValue "NewFoo", "FooAge", 666
    SetEntryValue "NewFoo", "FooName", "foofoo"
    
    AddTableRecord "Foo"
    
    SetEntryValue "NewFoo", "FooAge", 444
    SetEntryValue "NewFoo", "FooName", "barbar"
    
    AddTableRecord "Foo"
    
    Set dRecord = GetTableRecord("Foo", 1)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 123 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 2)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 666 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 3)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 444 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddTableMultipleRecordManual = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function



Function TestAddTableMultipleRecordMultiTableManual() As TestResult
' From a definition, create entry forms, fill out values for a record, manually call function
' to add the single record (dont validate and use button) and then retreive the record
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sFuncName = CsModuleName & "." & "TestAddTableMultipleRecordMultiTableManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms clsQuadRuntime, clsQuadRuntime.TemplateCellSheetName
    
    ' Table Foo
    SetEntryValue "NewFoo", "FooAge", 123
    SetEntryValue "NewFoo", "FooName", "blahblah"
    
    AddTableRecord "Foo"
    
    SetEntryValue "NewFoo", "FooAge", 666
    SetEntryValue "NewFoo", "FooName", "foofoo"
    
    AddTableRecord "Foo"
    
    SetEntryValue "NewFoo", "FooAge", 444
    SetEntryValue "NewFoo", "FooName", "barbar"
    
    AddTableRecord "Foo"
    
    ' Table Bar
    SetEntryValue "NewBar", "BarAge", 123
    SetEntryValue "NewBar", "BarName", "blahblah"
    
    AddTableRecord "Bar"
    
    SetEntryValue "NewBar", "BarAge", 666
    SetEntryValue "NewBar", "BarName", "foofoo"
    
    AddTableRecord "Bar"
    
    SetEntryValue "NewBar", "BarAge", 444
    SetEntryValue "NewBar", "BarName", "barbar"
    
    AddTableRecord "Bar"
    
    Set dRecord = GetTableRecord("Foo", 3)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 444 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Bar", 3)
    
    If dRecord.Exists("BarAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("BarAge") <> 444 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddTableMultipleRecordMultiTableManual = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Function TestAddTableRecordFail() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim iResultCode As Integer
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sFuncName = CsModuleName & "." & "AddTableRecordFail"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms clsQuadRuntime, clsQuadRuntime.TemplateCellSheetName
    
    iResultCode = SetEntryValue("NewFoo", "BadFieldName", 123)
    
    If iResultCode <> -1 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddTableRecordFail = eTestResult
    
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
End Function


