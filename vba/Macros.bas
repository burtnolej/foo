Attribute VB_Name = "Macros"
Const CsModuleName = "Macros"
Public Sub RunTests()
    GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_Array_Utils.TestRunner
    Test_DB_Utils.TestRunner
    Test_Dict_Utils.TestRunner
    Test_Entry_Utils.TestRunner
    Test_File_Utils.TestRunner
    Test_Filter_Utils.TestRunner
    Test_Format_Utils.TestRunner
    'Test_Log_Utils.TestRunner
    Test_MAcros.TestRunner
    Test_Module_Utils.TestRunner
    Test_OS_Utils.TestRunner
    Test_Range_Utils.TestRunner
    Test_String_Utils.TestRunner
    Test_Table_Utils.TestRunner
    Test_Widget_Utils.TestRunner
    Test_Workbook_Utils.TestRunner
    
    Call CloseLogFile
End Sub

Public Sub DoViewLogs()
Dim vFileNames() As String
Dim sLogPath As String
Dim sFileName As Variant
Dim sFuncName As String
Dim iCount As Integer
Dim vFile() As String
Dim iRowNum As Integer
Dim sSheetName As String
Dim wsTmp As Worksheet
Dim aColWidths() As Integer
Dim iColWidth As Variant
Dim rSource As Range

    aColWidths = InitIntArray(Array(10, 10, 10, 15, 20, 60, 10))
    
    sFuncName = CsModuleName & "." & "DoViewLogs"
    sSheetName = "Logs"
    
    sLogPath = "C:\Users\burtnolej\Documents\runtime\"
    
    vFileNames = GetFolderFiles(sLogPath)
    
    iRowNum = 1
    
    If SheetExists(ActiveWorkbook, sSheetName) = True Then
        DeleteSheet ActiveWorkbook, sSheetName
    End If
    
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    
    For Each sFileName In vFileNames
        If InStr(sFileName, "_log") <> 0 Then
            FuncLogIt sFuncName, "Found log [" & sFileName & "] loading", C_MODULE_NAME, LogMsgType.OK
            
            vFile = ReadFile2Array(sLogPath & sFileName, sFieldDelim:="|")
            
            Set rSource = RangeFromStrArray(vFile, wsTmp, iRowNum, 0)
            Set rSource = rSource.Resize(, 1).Offset(, 3)
            rSource.Value = sFileName
            
            iRowNum = iRowNum + UBound(vFile) + 1
        End If
    Next sFileName
    
    iCount = 1
    For Each iColWidth In aColWidths
        SetColumnWidth iCount, CInt(iColWidth), sSheetName
        iCount = iCount + 1
    Next iColWidth
    
    With wsTmp
        Set rSource = .Range(.Cells(1, 1), .Cells(iRowNum, 7))
        
        RangeSort sSheetName, rSource, aSortColumns:=InitIntArray(Array(1))
    End With
    

End Sub
Public Sub DoImportModules()
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookname As String
Dim sFileDir As String
Dim sRootDirectory As String
Dim sImportModuleDirPath As String
Dim sCode As String
Dim sSuffix As String
Dim sExportModuleDirPath As String
Dim sModuleName As String
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim iCount As Integer

setup:
    sFuncName = CsModuleName & "." & "ImportModules"
    'sImportModuleDirPath = "D:\Personal\VBA\current"
    sImportModuleDirPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\vba"
    'sBookname = "Deloitte.xls"
    'Set wbTmp = CreateBook(sExportModuleDirPath & "\" & sBookname)
    Set wbTmp = ActiveWorkbook
main:
    iCount = ImportModules(wbTmp, sImportModuleDirPath, bOverwrite:=False)
    
    Debug.Print "Imported " & CStr(iCount) & " modules from " & sImportModuleDirPath

End Sub
Public Sub DumpProcs()
Dim dProc As Dictionary
Dim aResult() As String
Dim wb As Workbook
Dim ws As Worksheet
Dim rTarget As Range

    Set wb = Workbooks("vba_source_new.xlsm")
    Set dProc = GetProcsInModules(wb)
    Set dProc = GetProcAnalysis(wb, dProc)

    aResult = Dict2Array(dProc, InitStringArray(Array("ModuleName", "Args", "Comments")))
    
    Set ws = CreateSheet(wb, "Procs")
    Set rTarget = RangeFromStrArray(aResult, ws, 1, 0)
    CreateFilter Application.ActiveWorkbook, "Procs", rTarget.Offset(-1).Rows(1), UBound(aResult) + 1
End Sub
Public Sub BackupModules()
Dim sDirectory As String, sTmpDirectory As String, sFuncName As String, sSuffix As String
Dim aFiles() As String, aCheckinFiles() As String
Dim file_ As Variant
Dim iNewCount As Integer, iUpdateCount As Integer, iType As Integer
Dim ws As Worksheet

    GetLogFile
    sFuncName = CsModuleName & "." & "RunExportModules"
    sDirectory = "C:\Users\burtnolej\Documents\GitHub\quadviewer\vba\"
    sTmpDirectory = "C:\Users\burtnolej\tmp_export_modules\"
    
    
        
    ReDim aCheckinFiles(0 To 1000, 0 To 2)
    'sSuffix = "_" & GetDateString(Now())
    sSuffix = ""
    
    CreateDir sTmpDirectory
    ExportModules ActiveWorkbook, sTmpDirectory, sSuffix
    aFiles = GetFolderFiles(sTmpDirectory)
    
    
    For Each file_ In aFiles
        If FileExists(sDirectory & CStr(file_)) = False Then
            'FileMove CStr(file_), sTmpDirectory, sDirectory
            'FuncLogIt sFuncName, "Module [" & CStr(file_) & "] is new so moving", C_MODULE_NAME, LogMsgType.OK
            aCheckinFiles(iNewCount + iUpdateCount, 0) = sTmpDirectory & CStr(file_)
            aCheckinFiles(iNewCount + iUpdateCount, 1) = "NEW"
            aCheckinFiles(iNewCount + iUpdateCount, 2) = sDirectory
            iNewCount = iNewCount + 1
        ElseIf FilesAreSame(sTmpDirectory & CStr(file_), sDirectory & CStr(file_)) = False Then
            DeleteFile CStr(sDirectory & file_)
            'FileMove CStr(file_), sTmpDirectory, sDirectory
            'FuncLogIt sFuncName, "Module [" & CStr(file_) & "] has changed so moving", C_MODULE_NAME, LogMsgType.OK
            aCheckinFiles(iNewCount + iUpdateCount, 0) = sTmpDirectory & CStr(file_)
            aCheckinFiles(iNewCount + iUpdateCount, 1) = "UPDATE"
            aCheckinFiles(iNewCount + iUpdateCount, 2) = sDirectory
            iUpdateCount = iUpdateCount + 1
        Else
            FuncLogIt sFuncName, "Module [" & CStr(file_) & "] has NOT changed so ignoring", C_MODULE_NAME, LogMsgType.OK
        End If
    Next file_
    
    'RemoveDir "C:\Users\burtnolej\tmp_export_modules"
    If iNewCount + iUpdateCount <> 0 Then
        
        Set ws = CreateSheet(ActiveWorkbook, "Checkins")
        
        aCheckinFiles = ReDim2DArray(aCheckinFiles, iNewCount + iUpdateCount, 3)
        Call CloseLogFile
    
        RangeFromStrArray aCheckinFiles, ws, 0, 0
    
        iType = vbDefaultButton2
        PopUpWindow "New:" & vbTab & CStr(iNewCount) & vbCrLf & "Updated:" & vbTab & CStr(iUpdateCount), "BackupModules", iType
    Else
        iType = vbDefaultButton2
        PopUpWindow "No files have changed", "BackupModules", iType
    End If

        
End Sub
Public Sub DoGitCreateRepo(sRepoName As String, sUsername As String)
    GitCreateRepo sRepoName, sUsername:=sUsername
End Sub
Public Sub DoGitDeleteRepo(sRepoName As String, sUsername As String)
    GitDeleteRepo sRepoName, sUsername:=sUsername
End Sub
Public Sub DoGitViewCommits(sRepoName As String)
Dim aResults() As String
Dim ws As Worksheet
    Set ws = CreateSheet(ActiveWorkbook, "CommitHistory")
    aResults = GitViewCommits(sRepoName)
    RangeFromStrArray aResults, ws, 0, 0
End Sub
Public Sub DoGitCommit(rSource As Range, sRepoName As String, _
                    sGitRootPath As String, Optional sMessage As String = "no message")
Dim iType As Integer
Dim rCell As Range
Dim aFiles() As String
Dim iFileCount As Integer
Dim sDirectory As String, sTmpDirectory As String, sFuncName As String

    sFuncName = CsModuleName & "." & "DoGitCommit"
    sDirectory = "C:\Users\burtnolej\Documents\GitHub\quadviewer\vba\"
    sTmpDirectory = "C:\Users\burtnolej\tmp_export_modules\"
    
    ReDim aFiles(0 To 100)
    
    If rSource.Columns.Count <> 1 Then
        iType = vbDefaultButton2
        PopUpWindow "Selection needs to be 1 column", "Error", iType
    End If
    
    For Each rCell In rSource.Cells
        If FileExists(rCell.Value) = False Then
            iType = vbDefaultButton2
            PopUpWindow "File [" & rCell.Value & "] cannot be found", "Error", iType
        Else
            aFiles(iFileCount) = rCell.Value
            iFileCount = iFileCount + 1
        End If
    Next rCell
    ReDim Preserve aFiles(0 To iFileCount - 1)

    For i = 0 To iFileCount - 1
        ' move the file to commit from the tmp dir into the git source tree
        FileMove GetFileFromPath(CStr(aFiles(i))), sTmpDirectory, sDirectory
        FuncLogIt sFuncName, "Module [" & CStr(aFiles(i)) & "] is moving to " & sDirectory, C_MODULE_NAME, LogMsgType.OK
        
        ' change the filepath to be the git source tree
        aFiles(i) = sDirectory & GetFileFromPath(CStr(aFiles(i)))
    Next i
    
    sGitRootPath = sGitRootPath & sRepoName & "\"
    
    GitCommitFiles aFiles, sRepoName, sGitRootPath, sMessage
    
    
    RemoveDir "C:\Users\burtnolej\tmp_export_modules"
    
    iType = vbDefaultButton2
    PopUpWindow "commit " & sMessage & vbCrLf & Array2String(aFiles, sDelim:=vbCrLf) & vbCrLf & "committed to GitHub and moved to " & sDirectory, "DoGitCommit", iType
    
    DeleteSheet ActiveWorkbook, "Checkins"
    
End Sub

Public Function DoQueryDBRows(wb As Workbook, sSheetName As String, sDatabaseName As String, sTableName As String, _
                    bDeleteFlag As Boolean, sQryStr As String, Optional bDecodeFlag As Boolean = False, _
                    Optional bResultFile As Boolean = False) As String
Dim sQryResults As String
Dim rTarget As Range
Dim iWidth As Integer, iLength As Integer
Dim aResults As Variant

    ReDim aResults(0 To 10000, 0 To 100)

    sQryResults = DBQuery(sDatabaseName, _
                    sTableName, _
                    bDeleteFlag, _
                    sQryStr, _
                    bResultFile:=bResultFile)
                    
    Debug.Print "got results before parsing " & GetDateString(Now)

    If bResultFile = True Then
        aRows = Split(ReadFile(sQryResults), "$$")
    Else
        aRows = Split(CleanString(sQryResults), "$$")
    End If
        
    iLength = UBound(aRows)
    For i = 0 To iLength
        aFields = Split(aRows(i), "^")
        iWidth = UBound(aFields)
        For j = 0 To iWidth
            If bDecodeFlag = True Then
                aResults(i, j) = StrConv(DecodeBase64(aFields(j)), vbUnicode)
            Else
                aResults(i, j) = aFields(j)
            End If
        Next j
    Next i
    
    aResults = ReDim2DArray(aResults, iLength + 1, iWidth + 1)
    Set ws = CreateSheet(wb, sSheetName)
    
    With ws
        Set rTarget = .Range(.Cells(2, 1), .Cells(iLength + 2, iWidth + 1))
        rTarget = aResults
    End With
    
    CreateFilter wb, sSheetName, rTarget.Offset(-1).Rows(1), UBound(aResults) + 1

    'iType = vbDefaultButton2
    'PopUpWindow CStr(iRowsInserted) & " inserted into " & sTableName & " in " & sDatabaseName, _
    '                    "Insert Rows", iType
    If bResultFile = True Then
        ' for testing purposes useful for the caller to know where the result file is
        ' DBQuery returns the result filepath when in result file mode
        DoQueryDBRows = sQryResults
    End If
End Function
                        
                        
Public Sub DoInsertDBRows(ws As Worksheet, rSource As Range, sDatabaseName As String, _
                    sTableName As String, Optional bDecodeFlag As Boolean = False)
Dim rArea As Range
Dim iType As Integer, iNumCols As Integer, iNumDataRows As Integer, i As Integer, iRowsInserted As Integer
Dim aRange() As Variant
Dim aColumnsDefn() As String, aColumns() As String, aRows() As Variant

    If rSource.Areas.Count <> 3 Then
        iType = vbDefaultButton2
        PopUpWindow "Selection needs three Areas; 1 each for column names, types then data rows", _
                "Error", iType
    End If
    
    sFuncName = "GetQueryFromRange"
    
    'If iReturnCode = 6 Then
    '    GetQueryFromRange = rSource.Value
    'Else
    '    GetQueryFromRange = "-1"
    'End If
    
    iNumCols = rSource.Areas(1).Columns.Count
    iNumDataRows = rSource.Areas(3).Rows.Count
    
    ' column types in area1
    aRange = rSource.Areas(2)
    ReDim aColumns(0 To iNumCols - 1)
    For i = 1 To iNumCols
        aColumns(i - 1) = aRange(1, i)
    Next i
    
    ' column names in area2
    aRange = rSource.Areas(1)
    ReDim aColumnsDefn(0 To iNumCols - 1, 0 To 1)
    For i = 1 To iNumCols
        aColumnsDefn(i - 1, 0) = aColumns(i - 1)
        aColumnsDefn(i - 1, 1) = aRange(1, i)
    Next i
    
    ' data rows in area3
    aRows = rSource.Areas(3)
    
    iRowsInserted = DBInsert(sDatabaseName, _
                    sTableName, _
                    bDecodeFlag, _
                    aColumns, _
                    aColumnsDefn, _
                    aRows())
                    
    iType = vbDefaultButton2
    PopUpWindow CStr(iRowsInserted) & " inserted into " & sTableName & " in " & sDatabaseName, _
                        "Insert Rows", iType


End Sub
