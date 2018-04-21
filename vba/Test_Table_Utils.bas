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
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsQuadRuntime.CacheBook
        
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows
    
    Set dRecord = GetTableRecord("Foo", 2, wbTmp:=clsQuadRuntime.CacheBook)
    
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
    DeleteSheet clsQuadRuntime.CacheBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    clsQuadRuntime.Delete

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
    CreateTables clsQuadRuntime.CacheBook
    
    GenerateEntryForms clsQuadRuntime
    
    SetEntryValue "NewFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, _
        wbCacheBook:=clsQuadRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 1, wbTmp:=clsQuadRuntime.CacheBook)
    
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
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    clsQuadRuntime.Delete

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
Dim clsQuadRuntime As New Quad_Runtime

setup:

    clsQuadRuntime.InitProperties bInitializeCache:=True
    sFuncName = CsModuleName & "." & "CreateTables"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
  
    CreateTables clsQuadRuntime.CacheBook
    
    If SheetExists(clsQuadRuntime.CacheBook, "foo") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If SheetExists(clsQuadRuntime.CacheBook, "bar") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(clsQuadRuntime.CacheBook, "foo", "dbFooFooAge") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(clsQuadRuntime.CacheBook, "bar", "dbBarBarName") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(clsQuadRuntime.CacheBook, "bar", "iBarNextFree") = False Then
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
    DeleteSheet clsQuadRuntime.CacheBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "foo"
    DeleteSheet clsQuadRuntime.CacheBook, "bar"
    clsQuadRuntime.Delete

End Function

Function Test_AddTableRecordFromDict() As TestResult
    'AddTableRecordFromDict
Dim aSchedule() As String, vKeys() As String, vValues As Variant, vSource() As String
Dim dValues As New Dictionary
Dim sFuncName As String, sSheetName As String, sTableName As String, sDefn As String
Dim clsQuadRuntime As New Quad_Runtime
Dim wsTmp As Worksheet, wsTable As Worksheet
Dim rTarget As Range
Dim dRecordValues As Dictionary
Dim eTestResult As TestResult

    clsQuadRuntime.InitProperties bInitializeCache:=True
    sFuncName = CsModuleName & "." & "TestAddTableMultipleRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    
    vKeys = Split("sStudentFirstNm,sStudentLastNm,idStudent,idPrep,sPrepNm", COMMA)
    vValues = Split("Jon,Butler,1,5,Luna", COMMA)
    Set dValues = InitDict(vKeys, vValues)

    sTableName = "person_student"
   ' new student
    sDefn = sDefn & "NewStudent^person_student^sStudentFirstNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentLastNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idStudent^Integer^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idPrep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sPrepNm^String^^^"
    vSource = Init2DStringArrayFromString(sDefn)
    
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    Set wsTable = CreateTable(sTableName, wbTmp:=clsQuadRuntime.CacheBook)
    
main:
    
    AddTableRecordFromDict wsTable, sTableName, dValues
    
    
    Set dRecordValues = GetTableRecord(sTableName, 1, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecordValues.Item("sPrepNm") <> "Luna" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddTableRecordFromDict = eTestResult
    clsQuadRuntime.Delete

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
    CreateTables clsQuadRuntime.CacheBook
    GenerateEntryForms clsQuadRuntime
        
    SetEntryValue "NewFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "NewFoo", "FooAge", 666, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "foofoo", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "NewFoo", "FooAge", 444, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "barbar", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 1, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 123 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 2, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 666 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 3, wbTmp:=clsQuadRuntime.CacheBook)
    
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
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    clsQuadRuntime.Delete

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
    CreateTables clsQuadRuntime.CacheBook
    GenerateEntryForms clsQuadRuntime
    
    ' Table Foo
    SetEntryValue "NewFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "NewFoo", "FooAge", 666, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "foofoo", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "NewFoo", "FooAge", 444, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewFoo", "FooName", "barbar", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Foo", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    ' Table Bar
    SetEntryValue "NewBar", "BarAge", 123, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewBar", "BarName", "blahblah", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Bar", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "NewBar", "BarAge", 666, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewBar", "BarName", "foofoo", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Bar", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "NewBar", "BarAge", 444, wbTmp:=clsQuadRuntime.EntryBook
    SetEntryValue "NewBar", "BarName", "barbar", wbTmp:=clsQuadRuntime.EntryBook
    
    AddTableRecord "Bar", wbEntryBook:=clsQuadRuntime.EntryBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 3, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 444 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Bar", 3, wbTmp:=clsQuadRuntime.CacheBook)
    
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
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    clsQuadRuntime.Delete

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
    CreateTables clsQuadRuntime.CacheBook
    GenerateEntryForms clsQuadRuntime
    
    iResultCode = SetEntryValue("NewFoo", "BadFieldName", 123, wbTmp:=clsQuadRuntime.EntryBook)
    
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
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    clsQuadRuntime.Delete

    
End Function
