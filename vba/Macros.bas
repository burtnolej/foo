Attribute VB_Name = "Macros"
Const CsModuleName = "Macros"
Public Sub RunTests()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_Entry_Utils.TestRunner
    Test_File_Utils.TestRunner
    Test_Format_Utils.TestRunner
    Test_Log_Utils.TestRunner
    Test_Module_Utils.TestRunner
    Test_Range_Utils.TestRunner
    Test_Table_Utils.TestRunner
    Test_Array_Utils.TestRunner
    'Call CloseLogFile
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
    
    Set ws = CreateSheet(ActiveWorkbook, "Checkins")
        
    ReDim aCheckinFiles(0 To 1000, 0 To 1)
    'sSuffix = "_" & GetDateString(Now())
    sSuffix = ""
    
    CreateDir sTmpDirectory
    ExportModules ActiveWorkbook, sTmpDirectory, sSuffix
    aFiles = GetFolderFiles(sTmpDirectory)
    
    For Each file_ In aFiles
        If FileExists(sDirectory & CStr(file_)) = False Then
            FileMove CStr(file_), sTmpDirectory, sDirectory
            FuncLogIt sFuncName, "Module [" & CStr(file_) & "] is new so moving", C_MODULE_NAME, LogMsgType.OK
            aCheckinFiles(iNewCount + iUpdateCount, 0) = sDirectory & CStr(file_)
            aCheckinFiles(iNewCount + iUpdateCount, 1) = "NEW"
            iNewCount = iNewCount + 1
        ElseIf FilesAreSame(sTmpDirectory & CStr(file_), sDirectory & CStr(file_)) = False Then
            DeleteFile CStr(sDirectory & file_)
            FileMove CStr(file_), sTmpDirectory, sDirectory
            FuncLogIt sFuncName, "Module [" & CStr(file_) & "] has changed so moving", C_MODULE_NAME, LogMsgType.OK
            aCheckinFiles(iNewCount + iUpdateCount, 0) = sDirectory & CStr(file_)
             aCheckinFiles(iNewCount + iUpdateCount, 1) = "UPDATE"
            iUpdateCount = iUpdateCount + 1
        Else
            FuncLogIt sFuncName, "Module [" & CStr(file_) & "] has NOT changed so ignoring", C_MODULE_NAME, LogMsgType.OK
        End If
    Next file_
    
    RemoveDir "C:\Users\burtnolej\tmp_export_modules"
    aCheckinFiles = ReDim2DArray(aCheckinFiles, iNewCount + iUpdateCount - 1, 2)
    Call CloseLogFile
    
    RangeFromStrArray aCheckinFiles, ws, 0, 0
    
    iType = vbDefaultButton2
    PopUpWindow "New:" & vbTab & CStr(iNewCount) & vbCrLf & "Updated:" & vbTab & CStr(iUpdateCount), "BackupModules", iType
    
End Sub
Public Sub DoGitCreateRepo(sReponame As String, sUsername As String)
    GitCreateRepo sReponame, sUsername:=sUsername
End Sub

Public Sub DoGitCommit(ws As Worksheet)
Dim rCell As Range
    If rSource.Columns.Count <> 1 Then
        iType = vbDefaultButton2
        PopUpWindow "Selection needs to be 1 column", "Error", iType
    End If
    
    For Each rCell In rSource.Cells
        If FileExists(rCell.Value) = False Then
            iType = vbDefaultButton2
            PopUpWindow "File [" & rCell.Value & "] cannot be found", "Error", iType
        End If
    Next rCell
End Sub
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
