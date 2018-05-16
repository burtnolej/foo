Attribute VB_Name = "Test_Table_Utils"
'Function TestAddTableRecordManual()
'Function TestCreateTables()
'Function TestAddTableMultipleRecordManual()
'Function TestAddTableMultipleRecordMultiTableManual()
'Function TestAddTableRecordFail()
'Function TestAddTableRecordAuto()

Option Explicit
Const C_MODULE_NAME = "Test_Table_Utils"

Sub cleanup_workbooks()
Dim wbTmp As Workbook
Dim sBookNames As String, sCacheFilePath As String
Dim sCacheBook As Variant
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    'sBookNames = "cache.xlsm,schedule.xlsm,add.xlsm,menu.xlsm"
    sCacheFilePath = GetHomePath & "\app_runtime_cache"
    For Each sCacheBook In Split(clsAppRuntime.BookEnum, COMMA)
        On Error Resume Next
        Set wbTmp = Workbooks(sCacheBook)
        CloseBook wbTmp
        DeleteBook CStr(sCacheBook)
        DeleteFile sCacheFilePath
        On Error GoTo 0
    Next sCacheBook
    
End Sub
Function TestGetDirtyTableRecords() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sResults As String, sResultFileName As String
Dim vSource() As String, vRows() As Variant, vColNames() As String, aColumnDefns() As Variant, aRows() As Variant, aColumns() As String, aArgs() As String, vDBRows() As Variant
Dim vDirtyRows() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "GetDirtyTableRecords"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = True
    aColumnDefns = Init2DVariantArray([{"FooName","Text";"FooAge","Integer";"FooID","Integer"}])
    sFileName = Environ("MYHOME") & "\\uufoo.txt"
    sExecPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\"
    sResultFileName = Environ("MYHOME") & "\\uufoo.txt_result"
    
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddFoo","Foo","FooID","Integer","IsValidInteger","","","","Entry"}])

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"FooName","FooAge","FooID";"Jon","43","1";"Quinton","6","2"}])
    vDBRows = Init2DVariantArray([{"Jon","43","1";"Quinton","6","2"}])
    vColNames = InitStringArray(Array("FooName", "FooAge", "FooID")) ' db does not want the column headers
main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsAppRuntime.CacheBook
    AddTableRecordAuto clsAppRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
    GenerateForms clsAppRuntime
        
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooID", "1", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooID", "2", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooID", "3", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    ReDim vDirtyRows(0 To 1000, 0 To 2)
    GetDirtyTableRecords vDirtyRows, "Foo", wbTmp:=clsAppRuntime.CacheBook
    
    If UBound(vDirtyRows) <> 2 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If vDirtyRows(2, 0) <> "barbar" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If vDirtyRows(2, 1) <> "444" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If vDirtyRows(2, 2) <> "3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetDirtyTableRecords = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteFile(sResultFileName)
    clsAppRuntime.Delete
    
End Function
Function TestAddTableRecordAutoBulk() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String
Dim vSource() As String, vRows() As Variant, vColNames() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rTable As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordAuto"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
                                  
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Name","Age";"Jon","43";"Quinton","6";"NanNan","70";"GranPops","69";"Nancy","46"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsAppRuntime.CacheBook
    
    Set rTable = AddTableRecordAuto(clsAppRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True, bAddDefaultFields:=True)
    
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
    
    Set dRecord = GetTableRecord("Foo", 2, wbTmp:=clsAppRuntime.CacheBook)
    
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
    DeleteSheet clsAppRuntime.CacheBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    clsAppRuntime.Delete

End Function
Function TestAddTableRecordAuto() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sColumns As String
Dim vSource() As String, vRows() As Variant, vColNames() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rTable As Range
Dim dDefinitions As Dictionary
Dim dRecord As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordAuto"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
                                  
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])


    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"FooName","FooAge";"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsAppRuntime.CacheBook
        
    AddTableRecordAuto clsAppRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
    Set dRecord = GetTableRecord("Foo", 2, wbTmp:=clsAppRuntime.CacheBook)
    
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
    DeleteSheet clsAppRuntime.CacheBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    clsAppRuntime.Delete

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
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsAppRuntime.CacheBook
    
    GenerateForms clsAppRuntime
    
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, _
        wbCacheBook:=clsAppRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 1, wbTmp:=clsAppRuntime.CacheBook)
    
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
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    clsAppRuntime.Delete

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
Dim clsAppRuntime As New App_Runtime

setup:

    clsAppRuntime.InitProperties bInitializeCache:=True
    sFuncName = C_MODULE_NAME & "." & "CreateTables"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
  
    CreateTables clsAppRuntime.CacheBook
    
    If SheetExists(clsAppRuntime.CacheBook, "foo") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If SheetExists(clsAppRuntime.CacheBook, "bar") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(clsAppRuntime.CacheBook, "foo", "dbFooFooAge") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(clsAppRuntime.CacheBook, "bar", "dbBarBarName") = False Then
         eTestResult = TestResult.Failure
         GoTo teardown
    End If
    
    If NamedRangeExists(clsAppRuntime.CacheBook, "bar", "iBarNextFree") = False Then
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
    DeleteSheet clsAppRuntime.CacheBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "foo"
    DeleteSheet clsAppRuntime.CacheBook, "bar"
    clsAppRuntime.Delete

End Function

Function Test_AddTableRecordFromDict() As TestResult
    'AddTableRecordFromDict
Dim aSchedule() As String, vKeys() As String, vValues As Variant, vSource() As String
Dim dValues As New Dictionary
Dim sFuncName As String, sSheetName As String, sTableName As String, sDefn As String
Dim clsAppRuntime As New App_Runtime
Dim wsTmp As Worksheet, wsTable As Worksheet
Dim rTarget As Range
Dim dRecordValues As Dictionary
Dim eTestResult As TestResult

    clsAppRuntime.InitProperties bInitializeCache:=True
    sFuncName = C_MODULE_NAME & "." & "TestAddTableMultipleRecordManual"
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

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    Set wsTable = CreateTable(sTableName, wbTmp:=clsAppRuntime.CacheBook)
    
main:
    
    AddTableRecordFromDict wsTable, sTableName, dValues
    
    
    Set dRecordValues = GetTableRecord(sTableName, 1, wbTmp:=clsAppRuntime.CacheBook)
    
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
    clsAppRuntime.Delete

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
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sFuncName = C_MODULE_NAME & "." & "TestAddTableMultipleRecordManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsAppRuntime.CacheBook
    GenerateForms clsAppRuntime
        
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 1, wbTmp:=clsAppRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 123 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 2, wbTmp:=clsAppRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 666 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 3, wbTmp:=clsAppRuntime.CacheBook)
    
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
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    clsAppRuntime.Delete

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
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sFuncName = C_MODULE_NAME & "." & "TestAddTableRecordManualOntoDBLoad"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"FooName","FooAge";"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables wbTmp:=clsAppRuntime.CacheBook
        
    AddTableRecordAuto clsAppRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
main:

    GenerateForms clsAppRuntime
        
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 1, wbTmp:=clsAppRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 43 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If clsAppRuntime.CacheBook.Sheets("Foo").Range("iFooSyncState").Rows(2) <> "DB" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If clsAppRuntime.CacheBook.Sheets("Foo").Range("iFooSyncState").Rows(4) <> "User" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 4, wbTmp:=clsAppRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dRecord.Item("FooAge") <> 666 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set dRecord = GetTableRecord("Foo", 5, wbTmp:=clsAppRuntime.CacheBook)
    
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
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    clsAppRuntime.Delete

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
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sFuncName = C_MODULE_NAME & "." & "TestAddTableMultipleRecordMultiTableManual"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsAppRuntime.CacheBook
    GenerateForms clsAppRuntime
    
    ' Table Foo
    SetEntryValue "AddFoo", "FooAge", 123, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "blahblah", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 666, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "foofoo", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddFoo", "FooAge", 444, wbTmp:=clsAppRuntime.AddBook
    SetEntryValue "AddFoo", "FooName", "barbar", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Foo", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    ' Table Bar
    SetEntryValue "AddBar", "BarName", "blahblah", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Bar", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddBar", "BarName", "foofoo", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Bar", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    SetEntryValue "AddBar", "BarName", "barbar", wbTmp:=clsAppRuntime.AddBook
    
    AddTableRecord "Bar", wbAddBook:=clsAppRuntime.AddBook, wbCacheBook:=clsAppRuntime.CacheBook
    
    Set dRecord = GetTableRecord("Foo", 3, wbTmp:=clsAppRuntime.CacheBook)
    
    If dRecord.Exists("FooAge") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    
    Set dRecord = GetTableRecord("Bar", 3, wbTmp:=clsAppRuntime.CacheBook)
    
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
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    clsAppRuntime.Delete

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
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordFail"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember","","","","Entry";"AddFoo","Foo","FooAge","Integer","IsValidInteger","","","","Entry";"AddBar","Bar","BarName","List","IsMember","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables clsAppRuntime.CacheBook
    GenerateForms clsAppRuntime
    
    iResultCode = SetEntryValue("AddFoo", "BadFieldName", 123, wbTmp:=clsAppRuntime.AddBook)
    
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
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.CacheBook, "Foo"
    DeleteSheet clsAppRuntime.CacheBook, "Bar"
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    clsAppRuntime.Delete

    
End Function

Function TestRowAsDict() As TestResult

Dim sInputStr As String, sRangeName As String, sFuncName As String, sSheetName As String
Dim iChunkLen As Integer
Dim vSource() As String
Dim eTestResult As TestResult
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dResult As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "TestRowAsDict"
    sSheetName = "test"
    sRangeName = "data"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A", "B", "C";"a1","a2","a3";"b1","b2","b3"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRange ActiveWorkbook, rTarget.Address, sSheetName, sRangeName, "True"
    
main:

    Set dResult = Row2Dict(wsTmp, sRangeName, 3)
    
    If dResult.Count <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    ElseIf dResult.Item("C") <> "b3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    TestRowAsDict = eTestResult
End Function

