Attribute VB_Name = "Test_Macros"
Option Explicit
Const CsModuleName = "Test_Macros"


Public Function Test_DoQueryDBRows() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String
Dim bDeleteFlag As Boolean, bDecodeFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String
Dim wb As Workbook

setup:
    sFuncName = CsModuleName & "." & "DoQueryDBRows"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False
    bDecodeFlag = False
    sDataPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\test_misc\testdata_100rows.csv"
    Set wb = Workbooks("vba_source_new.xlsm")
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = Environ("MYHOME") & "\\unifoo.txt"
    sExecPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\"

    CreatePySqliteArgsFile sDatabaseName, sTableName, bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, sFileName:=sFileName
                            
    ' create the database and table
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))
    
    sResults = ShellRun_Foreground(aArgs)
    
    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))
            
    sResults = ShellRun_Foreground(aArgs)
    
main:
    DoQueryDBRows wb, "foobar", "foobar", "foobar", True, "select * from foobar"
    sExpectedResult = "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu"
 
    With wb.Sheets("foobar")
        If .Range(.Cells(101, 4), .Cells(101, 4)).value <> sExpectedResult Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_DoQueryDBRows = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteSheet(wb, "foobar")
    
End Function

Public Function Test_DoQueryDBRowsResultFile() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String, _
    sResultFilePath As String, sEncoding As String
Dim bDeleteFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String
Dim wb As Workbook

setup:
    sFuncName = CsModuleName & "." & "DoQueryDBRowsResultFile"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False

    sDataPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\test_misc\testdata_100rows.csv"
    Set wb = Workbooks("vba_source_new.xlsm")
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = Environ("MYHOME") & "\\uufoo.txt"
    sExecPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\"
    sEncoding = "uu"

    CreatePySqliteArgsFile sDatabaseName, sTableName, bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, sFileName:=sFileName, sEncoding:=sEncoding
                        
    ' create the database and table
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))
    
    sResults = ShellRun_Foreground(aArgs)
    
    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))
            
    sResults = ShellRun_Foreground(aArgs)
    
main:
    
    sResultFilePath = DoQueryDBRows(wb, "foobar", "foobar", "foobar", True, "select * from foobar", _
        bResultFile:=True)
        
    sExpectedResult = "quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat. Sed nunc est, mollis non, cursus non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna. Sed eu"
 
    With wb.Sheets("foobar")
        ' 101 rows because of the added filter row
        If .Range(.Cells(101, 4), .Cells(101, 4)).value <> sExpectedResult Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_DoQueryDBRowsResultFile = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteSheet(wb, "foobar")
    Call DeleteFile(sResultFilePath)
    
End Function

Public Function Test_DoQueryDBRowsResultFileLarge() As TestResult
Dim sFuncName As String, sResults As String, sExecPath As String, sDatabaseName As String, _
    sTableName As String, sFileName As String, sDataPath As String, sExpectedResult As String, _
    sResultFilePath As String, sEncoding As String
Dim bDeleteFlag As Boolean
Dim eTestResult As TestResult
Dim aColumnDefns() As Variant
Dim aRows() As String, aColumns() As String, aArgs() As String, aFields() As String
Dim wb As Workbook

setup:
    sFuncName = CsModuleName & "." & "DoQueryDBRowsResultFile"
    sDatabaseName = "foobar"
    sTableName = "foobar"
    bDeleteFlag = False

    sDataPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\test_misc\testdata.csv"
    Set wb = Workbooks("vba_source_new.xlsm")
    aColumnDefns = Init2DVariantArray([{"FirstName","Text";"LastName","Text";"Country","Text";"Description","Text";"Age","Integer"}])
    aColumns = InitStringArray(Array("FirstName", "LastName", "Country", "Description", "Age"))
    aRows = ReadFile2Array(sDataPath)
    sFileName = Environ("MYHOME") & "\\uufoo.txt"
    sExecPath = Environ("MYHOME") & "\GitHub\quadviewer\utils\excel\"
    sEncoding = "uu"

    CreatePySqliteArgsFile sDatabaseName, sTableName, bDeleteFlag:=bDeleteFlag, _
                            aColumns:=aColumns, aColumnDefns:=aColumnDefns, _
                            aRows:=aRows, sFileName:=sFileName, sEncoding:=sEncoding
                        
    ' create the database and table
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type create", _
            "--input_filename " & sFileName))
    
    sResults = ShellRun_Foreground(aArgs)
    
    ' insert rows
    aArgs = InitStringArray(Array("python", sExecPath & "excel_database_util.py", _
            "--access_type insert", _
            "--input_filename " & sFileName))
            
    sResults = ShellRun_Foreground(aArgs)
    
main:
    
    sResultFilePath = DoQueryDBRows(wb, "foobar", "foobar", "foobar", True, "select * from foobar", _
        bResultFile:=True)
        
    sExpectedResult = "leo elementum sem, vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu,"
    
    With wb.Sheets("foobar")
        If .Range(.Cells(999, 4), .Cells(999, 4)).value <> sExpectedResult Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_DoQueryDBRowsResultFileLarge = eTestResult
    Call DeleteFile(sFileName)
    Call DeleteSheet(wb, "foobar")
    Call DeleteFile(sResultFilePath)
    
End Function


