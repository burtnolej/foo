Attribute VB_Name = "Test_Table_Utils"
Option Explicit
Const CsModuleName = "Test_Table_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    
    ' 1: Create tables
    ' ----------------------------------------------------------------------------------------------
    ' From a definition, create table sheets and all the named ranges that set where to find a particular
    ' field on the sheet and show many fields exists and what they are
    TestCreateTables
    
    ' 2: Add and retreve table Record manually
    ' ----------------------------------------------------------------------------------------------
    ' From a definition, create entry forms, fill out values for a record, manually call function
    ' to add the single record (dont validate and use button) and then retreive the record by calling
    ' GetRecord function
    TestAddTableRecordManual
    
    ' 3: Add and retreve multiple Records from 1 table manually
    ' ----------------------------------------------------------------------------------------------
    ' as 2)
    TestAddTableMultipleRecordManual
    
    ' 4: Add and retreve multiple Records from Multi tables manually
    ' ----------------------------------------------------------------------------------------------
    ' as 2)
    TestAddTableMultipleRecordMultiTableManual
    
    ' 5: Add bad records
    ' ----------------------------------------------------------------------------------------------
    ' Try to set a value for a field that does not exist
    TestAddTableRecordFail

    'GetLogFile
End Sub


Sub TestAddTableRecordManual()
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
Dim bTestPassed As Boolean
setup:

    sFuncName = CsModuleName & "." & "AddTableRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms
    
    SetEntryValue "NewFoo", "FooAge", 123
    SetEntryValue "NewFoo", "FooName", "blahblah"
    
    AddTableRecord "Foo"
    
    Set dRecord = GetTableRecord("Foo", 1)
    
    If dRecord.Exists("FooAge") = False Then
        GoTo fail
    End If

    If dRecord.Exists("FooName") = False Then
        GoTo fail
    End If
    
    If dRecord.Item("FooName") <> "blahblah" Then
        GoTo fail
    End If
    
    If dRecord.Item("FooAge") <> "123" Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    Call TestLogIt(sFuncName, bTestPassed)
End Sub


Sub TestCreateTables()
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim bTestPassed As Boolean
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
        GoTo fail
    End If
    
    If SheetExists(ActiveWorkbook, "bar") = False Then
        GoTo fail
    End If
    
    If NamedRangeExists(ActiveWorkbook, "foo", "dbFooFooAge") = False Then
        GoTo fail
    End If
    
    If NamedRangeExists(ActiveWorkbook, "bar", "dbBarBarName") = False Then
        GoTo fail
    End If
    
    If NamedRangeExists(ActiveWorkbook, "bar", "iBarNextFree") = False Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "foo"
    DeleteSheet ActiveWorkbook, "bar"
    Call TestLogIt(sFuncName, bTestPassed)
End Sub


Sub TestAddTableMultipleRecordManual()
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
Dim bTestPassed As Boolean
setup:

    sFuncName = CsModuleName & "." & "TestAddTableMultipleRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms
    
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
        GoTo fail
    End If

    If dRecord.Item("FooAge") <> 123 Then
        GoTo fail
    End If
    
    Set dRecord = GetTableRecord("Foo", 2)
    
    If dRecord.Exists("FooAge") = False Then
        GoTo fail
    End If

    If dRecord.Item("FooAge") <> 666 Then
        GoTo fail
    End If
    
    Set dRecord = GetTableRecord("Foo", 3)
    
    If dRecord.Exists("FooAge") = False Then
        GoTo fail
    End If

    If dRecord.Item("FooAge") <> 444 Then
        GoTo fail
    End If

    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub TestAddTableMultipleRecordMultiTableManual()
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
Dim bTestPassed As Boolean
setup:

    sFuncName = CsModuleName & "." & "TestAddTableMultipleRecordMultiTableManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms
    
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
        GoTo fail
    End If

    If dRecord.Item("FooAge") <> 444 Then
        GoTo fail
    End If
    
    Set dRecord = GetTableRecord("Bar", 3)
    
    If dRecord.Exists("BarAge") = False Then
        GoTo fail
    End If

    If dRecord.Item("BarAge") <> 444 Then
        GoTo fail
    End If

    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub TestAddTableRecordFail()
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim bTestPassed As Boolean
Dim iResultCode As Integer

setup:

    sFuncName = CsModuleName & "." & "AddTableRecordFail"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    GenerateEntryForms
    
    iResultCode = SetEntryValue("NewFoo", "BadFieldName", 123)
    
    If iResultCode <> -1 Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    DeleteEntryForms
    Call TestLogIt(sFuncName, bTestPassed)
End Sub


