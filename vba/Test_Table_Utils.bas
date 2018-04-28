Attribute VB_Name = "Test_Table_Utils"
'Function TestAddTableRecordManual()
'Function TestCreateTables()
'Function TestAddTableMultipleRecordManual()
'Function TestAddTableMultipleRecordMultiTableManual()
'Function TestAddTableRecordFail()
'Function TestAddTableRecordAuto()

Option Explicit
Const CsModuleName = "Test_Table_Utils"

Sub cleanup_workbooks()
Dim wbTmp As Workbook
Dim sBookNames As String, sCacheFilePath As String
Dim sCacheBook As Variant

    sBookNames = "cache.xlsm,schedule.xlsm,add.xlsm,menu.xlsm"
    sCacheFilePath = GetHomePath & "\quad_runtime_cache"
    For Each sCacheBook In Split(sBookNames, COMMA)
        On Error Resume Next
        Set wbTmp = Workbooks(sCacheBook)
        CloseBook wbTmp
        DeleteBook CStr(sCacheBook)
        DeleteFile sCacheFilePath
        On Error GoTo 0
    Next sCacheBook
    
End Sub
Function T_e_stInsertTableRecords() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sResults As String, sResultFileName As String
Dim vSource() As String, vRows() As Variant, vColNames() As String, aColumnDefns() As Variant, aRows() As Variant, aColumns() As String, aArgs() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "InsertTableRecords"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = True
    aColumnDefns = Init2DVariantArray([{"FooName","Text";"FooAge","Integer";"FooID","Integer"}])
    'aColumns = InitStringArray(Array("colA", "colB", "colC"))
    'aRows = Init2DVariantArray([{"valA","valB","valC";"valA1","valB2","valC2";"valA3","valB3","valC3"}])
    sFileName = Environ("MYHOME") & "\\uufoo.txt"
    sExecPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\"
    sResultFileName = Environ("MYHOME") & "\\uufoo.txt_result"
    
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddFoo","Foo","FooID","Integer","IsValidInteger","","","","Entry"}])

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Jon","43","1";"Quinton","6","2"}])
    vColNames = InitStringArray(Array("FooName", "FooAge", "FooID"))
main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsQuadRuntime.CacheBook
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
    'AddTableRecord
    
    'GetTableRecords bDirty:=True
    
    ' create the database and table
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=vColNames, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=vRows, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))

    sResults = ShellRun(aArgs)
    
    ' insert rows
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))

    sResults = ShellRun(aArgs)

    ' query results and change the delete flag status as need to cleanup after test
    Call DeleteFile(sFileName)

    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=True, _
                            sQryStr:="select * from foobar", _
                            sFileName:=sFileName, _
                            sEncoding:="uu", _
                            sResultFileName:=sResultFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type query", _
            "--input_filename " & sFileName))

    ShellRun (aArgs)
    
    If FileExists(sResultFileName) Then
        sResultStr = ReadFile(sResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If sResultStr <> "Jon^43^1$$Quinton^6^2" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestInsertTableRecords = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteFile(sResultFileName)
    clsQuadRuntime.Delete
    
End Function
Function TestAddTableRecordAutoBulk() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String
Dim vSource() As String, vRows() As Variant, vColNames() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rTable As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "AddTableRecordAuto"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
                                  
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Name","Age";"Jon","43";"Quinton","6";"NanNan","70";"GranPops","69";"Nancy","46"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsQuadRuntime.CacheBook
    
    Set rTable = AddTableRecordAuto(clsQuadRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True, bAddDefaultFields:=True)
    
    If rTable.Rows(1).Columns(6) <> "SyncState" Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If rTable.Rows(3).Columns(5) <> "3" Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If rTable.Rows.Count <> 6 Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
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
    TestAddTableRecordAutoBulk = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    clsQuadRuntime.Delete

End Function
Function TestAddTableRecordAuto() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String
Dim vSource() As String, vRows() As Variant, vColNames() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rTable As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "AddTableRecordAuto"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
                                  
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])


    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsQuadRuntime.CacheBook
        
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
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
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsQuadRuntime.CacheBook
    
    GenerateForms clsQuadRuntime
    
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, _
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
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
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
  
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
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry"
    vSource = Init2DStringArrayFromString(sDefn)
    
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
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
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsQuadRuntime.CacheBook
    GenerateForms clsQuadRuntime
        
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    clsQuadRuntime.Delete

End Function


Function TestAddTableRecordManualOntoDBLoad() As TestResult
' From a definition, create entry forms, fill out values for a record, manually call function
' to add the single record (dont validate and use button) and then retreive the record
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String
Dim vSource() As String, vRows() As Variant, vColNames() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sFuncName = CsModuleName & "." & "TestAddTableRecordManualOntoDBLoad"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsQuadRuntime.CacheBook
        
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
main:

    GenerateForms clsQuadRuntime
        
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 1, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 6 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If clsQuadRuntime.CacheBook.Sheets("Foo").Range("dbFooSyncState").Rows(2) <> "DB" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If clsQuadRuntime.CacheBook.Sheets("Foo").Range("dbFooSyncState").Rows(3) <> "User" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 3, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 666 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 4, wbTmp:=clsQuadRuntime.CacheBook)
    
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
    TestAddTableRecordManualOntoDBLoad = eTestResult
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
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
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsQuadRuntime.CacheBook
    GenerateForms clsQuadRuntime
    
    ' Table Foo
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsQuadRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    ' Table Bar
    SetEntryValue "AddBar", "BarName", "blahblah", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Bar", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddBar", "BarName", "foofoo", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Bar", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    SetEntryValue "AddBar", "BarName", "barbar", wbTmp:=clsQuadRuntime.AddBook
    
    AddTableRecord "Bar", wbAddBook:=clsQuadRuntime.AddBook, wbCacheBook:=clsQuadRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 3, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    
    Set dRecord = GetTableRecord("Bar", 3, wbTmp:=clsQuadRuntime.CacheBook)
    
    If dRecord.Exists("BarName") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddTableMultipleRecordMultiTableManual = eTestResult
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
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
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsQuadRuntime.CacheBook
    GenerateForms clsQuadRuntime
    
    iResultCode = SetEntryValue("AddFoo", "BadFieldName", 123, wbTmp:=clsQuadRuntime.AddBook)
    
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.CacheBook, "Foo"
    DeleteSheet clsQuadRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    clsQuadRuntime.Delete

    
End Function
