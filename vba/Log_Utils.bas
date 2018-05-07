Attribute VB_Name = "Log_Utils"
Public fLogFile As Object

Enum LogMsgType
    FATAL = 0
    Error = 1
    Failure = 2
    INFO = 3
    OK = 4
    DEBUGGING = 7
    FAIL_TEST = 8
    PASS_TEST = 9
    INFUNC = 11
    OUTFUNC = 12
End Enum

Const C_LOG_MSG_TYPE = "FATAL,Error,Failure,INFO,OK,,,DEBUGGING,FAIL_TEST,PASS_TEST,,INFUNC,OUTFUNC"

Private clsQuadRuntimeGlobal As Quad_Runtime
Public LogFilter As String
Public StartTick As Long

Function EnumLogMsgType(i As Long) As String
    EnumLogMsgType = Split(C_LOG_MSG_TYPE, COMMA)(i)
End Function

Public Sub PurgeLogs()
'<<<
'purpose: remove any log files from the runtime directory. a log is a file that ends in _log
'>>>
Dim sLogPath As String, sFuncName As String, sSheetName As String
Dim vFileNames() As String

setup:
    sFuncName = CsModuleName & "." & "DoPurgeLogs"
    sSheetName = "Logs"
    sLogPath = Environ("MYHOME") & "\runtime\"
    On Error GoTo err
        
    If SheetExists(ActiveWorkbook, sSheetName) = True Then
        DeleteSheet ActiveWorkbook, sSheetName
    End If

main:
    
    GetLogFile
    CloseLogFile
    vFileNames = GetFolderFiles(sLogPath)

    For Each sFileName In vFileNames
        If InStr(sFileName, "_log") <> 0 Then
            DeleteFile sLogPath & CStr(sFileName)
        End If
    Next sFileName
    Exit Sub
    
err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
End Sub
Public Sub ViewLogs()
Dim vFileNames() As String
Dim sLogPath As String, sFuncName As String, sSheetName As String
Dim sFileName As Variant, iColWidth As Variant
Dim iCount As Integer, iRowNum As Integer
Dim vFile() As String, aColWidths() As Integer
Dim wsTmp As Worksheet
Dim rSource As Range

    aColWidths = InitIntArray(Array(10, 10, 10, 15, 20, 60, 10))
    
    sFuncName = CsModuleName & "." & "DoViewLogs"
    sSheetName = "Logs"
    
    sLogPath = Environ("MYHOME") & "\runtime\"
    
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
            rSource.value = sFileName
            
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
        
        RangeSort sSheetName, rSource, aSortColumns:=InitIntArray(Array(1, 2))
    End With
End Sub

Public Sub FuncLogIt(sFuncName As String, sLogMsg As String, sModuleName, eLogMsgType As LogMsgType, Optional sKey As String)
Dim aLogVals() As String
Dim aLogWidths() As Integer
Dim sNowTime As String
Dim sNowDate As String
Dim aLogFilter() As String

    If LogFilter = "" Then
        aLogFilter = InitStringArray(Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12))
    Else
        aLogFilter = Split(LogFilter, ",")
    End If
    
    If InArray(aLogFilter, eLogMsgType) = True Then
        sNowTime = GetDateString(Now(), "HH:MM:SS")
        sNowDate = GetDateString(Now(), "ddmmyy")

        ' take the calling function, a message and some id and write a formatted record to the log
        aLogVals = InitStringArray(Array(sNowTime, GetTicks() - StartTick, EnumLogMsgType(eLogMsgType), BLANK, BLANK, sFuncName, sLogMsg, sNowDate))
        aLogWidths = InitIntArray(Array(10, 5, 8, 1, 1, 40, 60, 10))
        Call WriteToLog(aLogVals, aLogWidths)
    End If
End Sub

Sub SetLogFile(Optional sLogFileName As String = "excel_log.txt")
'Set the module member var to be a pointer to a file
    Set fLogFile = CreateFile(sLogFileName)
End Sub
Function GetLogFile(Optional sLogFileName As String = "excel_log.txt") As Object
' If the module member var has already been set, return it, otherwise set it
    If fLogFile Is Nothing Then
        If FileExists(sLogFileName) = True Then
            Set fLogFile = OpenFile(sLogFileName, 8)
        Else
            Call SetLogFile(sLogFileName)
        End If
    End If
    
    StartTick = GetTicks
        
    Set GetLogFile = fLogFile
End Function
Public Sub CloseLogFile()
    If Not fLogFile Is Nothing Then
        fLogFile.Close
        Set fLogFile = Nothing
    End If
End Sub
Sub WriteToLog(aVals() As String, aWidths() As Integer, Optional sCaller As String = "", Optional sDelim As String = "|")
' Add default elements to the passed log message attributes and either write to the log
' or display in the Immediate window if a log file has not been setup
Dim sLogStr As String
Dim sTimestamp As String
Dim sBookName As String
Dim aHeaderVals() As String
Dim aHeaderWidths() As Integer

    sLogStr = ""
    
    If sCaller <> "" Then
        sTimestamp = GetDateString(Now(), "ddmmyyHHSS")
        sBookName = ActiveWorkbook.Name
        aHeaderVals = InitStringArray(Array(sTimestamp, sBookName, sCaller))
        aHeaderWidths = InitIntArray(Array(14, 10, 20))
        sLogStr = Array2String(aHeaderVals, aWidths:=aHeaderWidths, sDelim:=sDelim) & sDelim
    End If
    
    sLogStr = sLogStr & Array2String(aVals, aWidths:=aWidths, sDelim:=sDelim)
    
    If fLogFile Is Nothing Then
        Debug.Print sLogStr
    Else
        fLogFile.Write sLogStr & vbCrLf
    End If
End Sub

