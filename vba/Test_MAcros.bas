Attribute VB_Name = "Test_MAcros"
Option Explicit
Const CsModuleName = "Test_Macros"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    
    Test_DoQueryDBRows
    'Test_DoQueryDBRowsResultFileLarge
    'Test_DoQueryDBRowsResultFile
    
    'GetLogFile
End Sub
Sub Test_DoQueryDBRows()
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean, bTestPassed As Boolean
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String
Dim wb As Workbook

setup:
    sFuncName = CsModuleName & "." & "DoQueryDBRows"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = False
    sDataPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\excel\test_misc\testdata_100rows.csv"
    Set wb = Workbooks("vba_source_new.xlsm")
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = "C:\\Users\\burtnolej\\unifoo.txt"
    sExecPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\excel\"

    CreatePySqliteArgsFile sDatabaseName, sTableName, bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, sFileName:=sFileName
                            
    ' create the database and table
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))
    
    sResults = ShellRun(aArgs)
    
    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))
            
    sResults = ShellRun(aArgs)
    
main:
    DoQueryDBRows wb, "foobar", "foobar", "foobar", True, "select * from foobar"
    sExpectedResult = "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu"
 
    With wb.Sheets("foobar")
        ' 101 rows because of the added filter row
        If .Range(.Cells(101, 4), .Cells(101, 4)).Value <> sExpectedResult Then
            GoTo fail
        End If
    End With
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteFile(sFileName)
    Call DeleteSheet(wb, "foobar")
    
End Sub

Sub Test_DoQueryDBRowsResultFile()
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String, _
    sResultFilePath As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean, bTestPassed As Boolean
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String
Dim wb As Workbook

setup:
    sFuncName = CsModuleName & "." & "DoQueryDBRowsResultFile"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = False
    sDataPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\excel\testdata_100rows.csv"
    Set wb = Workbooks("vba_source_new.xlsm")
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = "C:\\Users\\burtnolej\\foo.txt"
    sExecPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\"

    CreatePySqliteArgsFile sDatabaseName, sTableName, bDeleteFlag:=bDeleteFlag, _
                            bDecodeFlag:=bDecodeFlag, aColumns:=aColumns, aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, sFileName:=sFileName
                            
    ' create the database and table
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))
    
    sResults = ShellRun(aArgs)
    
    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))
            
    sResults = ShellRun(aArgs)
    
main:
    
    sResultFilePath = DoQueryDBRows(wb, "foobar", "foobar", "foobar", True, "select * from foobar", _
        bDecodeFlag:=True, bResultFile:=True)
        
    sExpectedResult = "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu"
 
    With wb.Sheets("foobar")
        ' 101 rows because of the added filter row
        If .Range(.Cells(101, 4), .Cells(101, 4)).Value <> sExpectedResult Then
            GoTo fail
        End If
    End With
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteFile(sFileName)
    Call DeleteSheet(wb, "foobar")
    Call DeleteFile(sResultFilePath)
    
End Sub


Sub Test_DoQueryDBRowsResultFileLarge()
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String, _
    sResultFilePath As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean, bTestPassed As Boolean
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String
Dim wb As Workbook

setup:
    sFuncName = CsModuleName & "." & "DoQueryDBRowsResultFile"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = False
    sDataPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\testdata.csv"
    Set wb = Workbooks("vba_source_new.xlsm")
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    
    Debug.Print "before parsing input data file" & GetDateString(Now)
    aRows = ReadFile2Array(sDataPath)
    sFileName = "C:\\Users\\burtnolej\\foo.txt"
    sExecPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\"

    Debug.Print "before creating args file" & GetDateString(Now)

    CreatePySqliteArgsFile sDatabaseName, sTableName, bDeleteFlag:=bDeleteFlag, _
                            bDecodeFlag:=bDecodeFlag, aColumns:=aColumns, aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, sFileName:=sFileName
    
    Debug.Print "before create" & GetDateString(Now)
    
    ' create the database and table
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))
    
    sResults = ShellRun(aArgs)
    
    Debug.Print "before insert" & GetDateString(Now)
     
    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))
            
    sResults = ShellRun(aArgs)
    
main:
    Debug.Print "after insert " & GetDateString(Now)
    
    sResultFilePath = DoQueryDBRows(wb, "foobar", "foobar", "foobar", True, "select * from foobar", _
       bResultFile:=True)

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteFile(sFileName)
    Call DeleteSheet(wb, "foobar")
    Call DeleteFile(sResultFilePath)
    
End Sub

