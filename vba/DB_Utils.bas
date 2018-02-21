Attribute VB_Name = "DB_Utils"
Public Function GetQueryFromRange(Optional rSource As Range) As String
Dim iType As Integer
Dim sFuncName As String

    If rSource Is Nothing Then
        Set rSource = Selection
    End If
        
    sFuncName = "GetQueryFromRange"
    
    iType = vbYesNoCancel + vbQuestion + vbDefaultButton2
    iReturnCode = PopUpWindow("Query:" & rSource.Value, "Verify Query", iType)
    
    If iReturnCode = 6 Then
        GetQueryFromRange = rSource.Value
    Else
        GetQueryFromRange = "-1"
    End If
End Function
Public Sub CreatePySqliteArgsFile( _
    sDatabaseName As String, _
    sTableName As String, _
    Optional bDeleteFlag As Boolean = False, _
    Optional bDecodeFlag As Boolean = False, _
    Optional aColumns As Variant, _
    Optional aColumnDefns As Variant, _
    Optional aRows As Variant, _
    Optional sQryStr As String = "", _
    Optional sFileName As String = "C:\Users\burtnolej\Development\pyshell.args.txt", _
    Optional sRuntimeDir As String = "C:\Users\burtnolej\Documents\runtime")
    
Dim PYTHONPATH As String
Dim sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    'create a file of the following format
    'values with square brackets need to be uuencoded
    
    'database_name  :[dbname]\n
    'table_name     :[tablename]\n
    'delete_flag    :[False|True]\n # delete database after access; used in testing
    'decode_flag    :[False|True]\n # store as
    'columns        :[colA]^[colB]^[colC]\n
    'column_defns   :[colA^colAtype]$$[colB^colBtype]$$[colC^colCtype]\n
    'qry_str        :[select ?? from ?? where ?? = ?? etc
    'rows           :[valA]^[valB]^[valC]$$[valA1]^[valB1]^[valC1]\n

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFileName)
    On Error GoTo 0
    Call TouchFile(sFileName)
    
    Call AppendFile(sFileName, "database_name:" & EncodeBase64(sDatabaseName) & vbCrLf)
    Call AppendFile(sFileName, "table_name:" & EncodeBase64(sTableName) & vbCrLf)
    Call AppendFile(sFileName, "delete_flag:" & EncodeBase64(CStr(bDeleteFlag)) & vbCrLf)
    Call AppendFile(sFileName, "decode_flag:" & EncodeBase64(CStr(bDecodeFlag)) & vbCrLf)
    Call AppendFile(sFileName, "runtime_dir:" & EncodeBase64(sRuntimeDir) & vbCrLf)
    
    If Not IsMissing(aColumnDefns) Then
        Call AppendFile(sFileName, "column_defns:" & ArrayNDtoString(aColumnDefns, bUUEncode:=True) & vbCrLf)
    End If
    
    If Not IsMissing(aColumns) Then
        Call AppendFile(sFileName, "columns:" & ArrayNDtoString(aColumns, bUUEncode:=True) & vbCrLf)
    End If
    
    If Not IsMissing(aRows) Then
        sTmp = ArrayNDtoString(aRows, bUUEncode:=True)
        
        sTmp = AsciiReplace(sTmp, 10, 43, iToCount:=3)

        Call AppendFile(sFileName, "rows:" & sTmp & vbCrLf)
    
    End If

    If sQryStr <> "" Then
        Call AppendFile(sFileName, "qry_str:" & EncodeBase64(sQryStr) & vbCrLf)
    End If
End Sub

Public Function ParsePySqliteArgsFile(sFileName As String) As Dictionary
Dim dResult As New Dictionary
Dim sFileStr As String
Dim aResultRows() As String, aRows() As String, aCols() As String
Dim aResult As Variant
Dim iRow As Integer, iCol As Integer

    sFileAsStr = ReadFile(sFileName)
    
    aResultRows = Split(sFileAsStr, vbLf)
    
    For Each sResultRow In aResultRows
        sKey = Split(sResultRow, ":")(0)

        If InArray(Array("rows", "columns", "column_defns"), sKey) Then
            ReDim aResult(0 To 10000, 0 To 100)
            sValue = Split(sResultRow, ":")(1)
            aRows = Split(sValue, "$$")
            For iRow = 0 To UBound(aRows)
                aCols = Split(aRows(iRow), "^")
                For iCol = 0 To UBound(aCols)
                    aResult(iRow, iCol) = StrConv(DecodeBase64(aCols(iCol)), vbUnicode)
                Next iCol
            Next iRow
            
            
            aResult = ReDim2DArray(aResult, iRow, iCol)
            'ReDim Preserve aResult(0 To iRow - 1, 0 To iCol - 1)
            dResult.Add sKey, aResult
        Else:
            sValue = StrConv(DecodeBase64(Split(sResultRow, ":")(1)), vbUnicode)
            dResult.Add sKey, sValue
        End If
    Next sResultRow
    
    Set ParsePySqliteArgsFile = dResult

End Function
Public Function DBInsert(sDatabaseName As String, _
                    sTableName As String, _
                    bDecodeFlag As Boolean, _
                    aColumns() As String, _
                    aColumnsDefns() As String, _
                    aRows As Variant, _
                    Optional sFileName As String = "C:\Users\burtnolej\args.txt")
       
Dim sExecPath As String
Dim iCurrentNumRows As Integer, iNumRows As Integer

    sExecPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\"
    sRuntimePath = "C:\Users\burtnolej\Documents\runtime\"
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDecodeFlag:=bDecodeFlag, _
                            aColumns:=aColumns, _
                            aColumnDefns:=aColumnsDefns, _
                            aRows:=aRows, _
                            sQryStr:="select * from " & sTableName, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "query", _
            sFileName, _
            sRuntimePath))
            
    iCurrentNumRows = UBound(Split(ShellRun(aArgs), DOUBLEDOLLAR)) + 1
    
    
    ' create the database and table
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "create", _
            sFileName, _
            sRuntimePath))

    sResults = ShellRun(aArgs)
    
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "insert", _
            sFileName, _
            sRuntimePath))


    sResults = ShellRun(aArgs)
    
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "query", _
            sFileName, _
            sRuntimePath))
    

     iNumRows = UBound(Split(ShellRun(aArgs), DOUBLEDOLLAR)) + 1
     
     DBInsert = iNumRows
End Function
Public Function DBQuery(sDatabaseName As String, _
                        sTableName As String, _
                        bDeleteFlag As Boolean, _
                        sQryStr As String, _
                        Optional sFileName As String = "pyshellargs.txt") As String
                        
    CreatePySqliteArgsFile sDatabaseName, _
                            sTableName, _
                            bDeleteFlag:=bDeleteFlag, _
                            sQryStr:=sQryStr, _
                            sFileName:=sFileName
                            
    aArgs = InitStringArray(Array("python", _
            sExecPath & "excel_database_util.py", _
            "query", _
            sFileName))

    DBQuery = CleanString(ShellRun(aArgs))
    
End Function
