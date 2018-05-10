Attribute VB_Name = "Test_DB_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_DB_Utils"


Function Test_PySqliteDBInsert() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant, aRows() As Variant
Dim aColumns() As String, aArgs() As String

setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBInsert"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = True
    aColumnDefns = Init2DVariantArray([{"colA","Test";"colB","Text";"colC","Text"}])
    aColumns = InitStringArray(Array("colA", "colB", "colC"))
    aRows = Init2DVariantArray([{"valA","valB","valC";"valA1","valB2","valC2";"valA3","valB3","valC3"}])
    sFileName = Environ("MYHOME") & "\\unifoo.txt"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
main:
    
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, _
                            sFileName:=sFileName
                                            
            
    ' create the database and table
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
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type query", _
            "--input_filename " & sFileName))

    If CleanString(ShellRun(aArgs)) <> "valA^valB^valC$$valA1^valB2^valC2$$valA3^valB3^valC3" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBInsert = eTestResult
    Call DeleteFile(sFileName)
    
End Function
Function Test_PySqliteDBInsertLarge() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String
Dim bDecodeFlag As Boolean, bDeleteFlag As Boolean
Dim aColumnDefns() As Variant
Dim eTestResult As TestResult
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBInsertLarge"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = False
    sDataPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\test_misc\testdata_100rows.csv"

    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = Environ("MYHOME") & "\\unifoo.txt"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
    
main:

    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, _
                            sFileName:=sFileName
                            
    ' create the database and table
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
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type query", _
            "--input_filename " & sFileName))

    aRows = Split(CleanString(ShellRun(aArgs)), "$$")
    aFields = Split(aRows(99), "^")
    sExpectedResult = "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu"
    'sExpectedResult = "tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis in,"
    If aFields(3) <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBInsertLarge = eTestResult
    Call DeleteFile(sFileName)
    
End Function

Function Test_PySqliteDBInfo() As TestResult
Dim sFuncName As String
Dim sDatabaseName As String
Dim sTableName As String
Dim bDeleteFlag As Boolean
Dim bDecodeFlag As Boolean
Dim sFileName As String
Dim aColumnDefns() As Variant
Dim aArgs() As String
Dim sResults As String
Dim sExecPath As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBInfo"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    aColumnDefns = Init2DVariantArray([{"colA","Test";"colB","Text";"colC","Text"}])
    sFileName = Environ("MYHOME") & "\\foo.txt"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
main:
    
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumnDefns:=aColumnDefns, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))

    sResults = ShellRun(aArgs)
    
    ' change the delete flag status as need to cleanup after test
    Call DeleteFile(sFileName)
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=True, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type table_info", _
            "--input_filename " & sFileName))

    sResults = CleanString(ShellRun(aArgs))

    If sResults <> "colA^Test$$colB^Text$$colC^Text" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBInfo = eTestResult
    Call DeleteFile(sFileName)
    
End Function


Function Test_PySqliteDBCreate() As TestResult
Dim sFuncName As String
Dim sDatabaseName As String
Dim sTableName As String
Dim bDeleteFlag As Boolean
Dim bDecodeFlag As Boolean
Dim sFileName As String
Dim aColumnDefns() As Variant
Dim aArgs() As String
Dim sResults As String
Dim sExecPath As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBCreate"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    aColumnDefns = Init2DVariantArray([{"colA","Test";"colB","Text";"colC","Text"}])
    sFileName = Environ("MYHOME") & "\\unifoo.txt"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
main:
    
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumnDefns:=aColumnDefns, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))

    sResults = ShellRun(aArgs)
    
    ' change the delete flag status as need to cleanup after test
    Call DeleteFile(sFileName)
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=True, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type table_exists", _
            "--input_filename " & sFileName))

    sResults = ShellRun(aArgs)
    
    If Left(sResults, 4) <> "True" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBCreate = eTestResult
    Call DeleteFile(sFileName)
    
End Function
Function Test_CreatePySqliteArgsFile() As TestResult
Dim sFuncName As String
Dim vSource() As String
Dim aSource() As Integer
Dim sDatabaseName As String
Dim sTableName As String
Dim bDeleteFlag As Boolean
Dim bDecodeFlag As Boolean
Dim aColumns() As String

Dim sFileName As String
Dim sFileAsStr As String
Dim aResultRows() As String
Dim dResult As New Dictionary
Dim sValue As String
Dim sResultRow As Variant
Dim sKey As String
Dim aTmpResult() As String
Dim aColumnDefns() As Variant
Dim eTestResult As TestResult
Dim aResult() As Variant, aRows() As Variant


setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "CreatePySqliteArgsFile"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = True
    bDecodeFlag = True
    aColumns = InitStringArray(Array("colA", "colB", "colC"))
    aColumnDefns = Init2DVariantArray([{"colA","Test";"colB","Text";"colC","Text"}])
    aRows = Init2DVariantArray([{"valA","valB","valC";"valA1","valB2","valC2";"valA3","valB3","valC3"}])
    sFileName = Environ("MYHOME") & "\\foo.txt"
main:
    
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, _
                            sFileName:=sFileName

    Set dResult = ParsePySqliteArgsFile(sFileName)
 
    If dResult.Item("database_name") <> "foobar" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If dResult.Item("table_name") <> "foobar" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dResult.Item("columns")(1, 0) <> "colB" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If dResult.Item("rows")(1, 1) <> "valB2" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CreatePySqliteArgsFile = eTestResult
    Call DeleteFile(sFileName)
End Function

Function Test_AutoParseInputRange() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim vSource() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "AutoParseInputRange"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"Text","Text";"Col1","Col2";"A","B";"A","B";"A","B";"A","B"}])
    Set rSource = RangeFromStrArray(vSource, wsTmp, 0, 0)
    
    If AutoParseInputRange(wsTmp).Address <> "$A$1:$B$1,$A$2:$B$2,$A$3:$B$6" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AutoParseInputRange = eTestResult
    'Call DeleteFile(sFilename)
    Call DeleteSheet(ActiveWorkbook, sSheetName)
    
End Function


Function Test_PySqliteDBInsertVeryLarge() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBInsertVeryLarge"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = False
    sDataPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\test_misc\testdata.csv" 'takes about 2mins
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = Environ("MYHOME") & "\\unifoo.txt"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
    
main:

    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, _
                            sFileName:=sFileName
                            
    ' create the database and table
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
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "--access_type query", _
            "--input_filename " & sFileName))

    aRows = Split(CleanString(ShellRun(aArgs)), "$$")
    aFields = Split(aRows(99), "^")
    sExpectedResult = "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu"
    'sExpectedResult = "tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis in,"
    If aFields(3) <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBInsertVeryLarge = eTestResult
    Call DeleteFile(sFileName)
    
End Function

Function Test_PySqliteDBQueryResultFileUUEncode() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sResultFileName As String, resultstr As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant, aRows() As Variant
Dim aColumns() As String, aArgs() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBQueryResultFileUUEncode"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = True

    aColumnDefns = Init2DVariantArray([{"colA","Test";"colB","Text";"colC","Text"}])
    aColumns = InitStringArray(Array("colA", "colB", "colC"))
    aRows = Init2DVariantArray([{"valA","valB","valC";"valA1","valB2","valC2";"valA3","valB3","valC3"}])
    sFileName = Environ("MYHOME") & "\\uufoo.txt"
    sResultFileName = Environ("MYHOME") & "\\uufoo.txt_result"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
main:
    
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, _
                            sEncoding:="uu", _
                            sFileName:=sFileName
                                            
            
    ' create the database and table
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

    sResults = ShellRun(aArgs)
    
    If FileExists(sResultFileName) Then
        resultstr = ReadFile(sResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If resultstr <> "valA^valB^valC$$valA1^valB2^valC2$$valA3^valB3^valC3" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBQueryResultFileUUEncode = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteFile(sResultFileName)
    
End Function

Function Test_PySqliteDBQueryResultFileUUEncodeVeryLarge() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sResultFileName As String, resultstr As String, _
    sDataPath As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant
Dim aColumns() As String, aArgs() As String, aRows() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "PySqliteDBQueryResultFileUUEncodeVeryLarge"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = True
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    sDataPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\test_misc\testdata.csv" 'takes about 2mins
    aRows = ReadFile2Array(sDataPath)
    sFileName = Environ("MYHOME") & "\\uufoo.txt"
    sResultFileName = Environ("MYHOME") & "\\uufoo.txt_result"
    sExecPath = Environ("MYHOME") & "\Documents\GitHub\quadviewer\utils\excel\"
 
main:
    
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, _
                            sEncoding:="uu", _
                            sFileName:=sFileName
                                            
            
    ' create the database and table
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

    sResults = ShellRun(aArgs)
    
    If FileExists(sResultFileName) Then
        resultstr = ReadFile(sResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Split(Split(resultstr, "$$")(999), "^")(3) <> "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_PySqliteDBQueryResultFileUUEncodeVeryLarge = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteFile(sResultFileName)
    
End Function

