Attribute VB_Name = "Quad_Utils"
'Public Function ParseRawData
'Public Sub CacheData
'Public Sub CreateQuadArgsFile
'Public Function IsDataCached
'Public Function GetQuadDataFromDB

Public Const sExecPath = "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\app\\quad\\utils\\excel\\"
Public Const sRuntimeDir = "C:\\Users\\burtnolej\\Documents\\runtime\\"
Public Const sFileName = "C:\\Users\\burtnolej\\Development\\uupyshell.args.txt"
Public Const sDayEnum = "M,T,W,R,F"
Public Const sBookName = "vba_source_new.xlsm"
Public Const sCacheBookName = "cache.xls"
Public Const sCacheBookPath = "C:\\Users\\burtnolej\\Documents\\Runtime"
Public Const cTemplateBookName = "vba_source_new.xlsm"

Public Sub CreateQuadArgsFile(sDatabaseName As String, _
        sSpName As String, _
        Optional dSpArgs As Dictionary, _
        Optional sFileName As String = "C:\Users\burtnolej\Development\uupyshell.args.txt", _
        Optional sRuntimeDir As String = "C:\Users\burtnolej\Documents\runtime", _
        Optional sResultFileName As String, _
        Optional bHeaderFlag As Boolean = False)

Dim PYTHONPATH As String, xSpArgs As String, sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFileName)
    On Error GoTo 0
    Call TouchFile(sFileName)
    
    Call AppendFile(sFileName, "database_name:" & UUEncode(sDatabaseName) & vbCrLf)
    Call AppendFile(sFileName, "sp_name:" & UUEncode(sSpName) & vbCrLf)
    
    If bHeaderFlag = True Then
        Call AppendFile(sFileName, "header_flag:" & UUEncode("True") & vbCrLf)
    End If

    If IsSet(dSpArgs) = True Then
        xSpArgs = CreateXMLDocfromDict(dSpArgs).xml
        Call AppendFile(sFileName, "sp_args:" & UUEncode(xSpArgs) & vbCrLf)
    End If
    
    Call AppendFile(sFileName, "runtime_dir:" & UUEncode(Quad_Utils.sRuntimeDir) & vbCrLf)
    
    If sResultFileName <> "" Then
        Call AppendFile(sFileName, "result_file:" & UUEncode(sResultFileName) & vbCrLf)
    End If
    
End Sub
                           
Public Function GetQuadDataFromDB(sDatabaseName As String, _
                                 sSpName As String, _
                        Optional dSpArgs As Dictionary, _
                        Optional sResultFileName As String, _
                        Optional sFileName As String = "C:\Users\burtnolej\Development\uupyshell.args.txt", _
                        Optional bHeaderFlag As Boolean = False) As String
' get the raw data from a backsheet
Dim sExecPath As String, sRuntimePath As String, sResult As String
Dim aArgs() As String

    CreateQuadArgsFile sDatabaseName, sSpName, dSpArgs:=dSpArgs, _
                       sResultFileName:=sResultFileName, _
                       bHeaderFlag:=bHeaderFlag, sFileName:=sFileName
    aArgs = InitStringArray(Array("python", Quad_Utils.sExecPath & "excel_data_utils.py", "--input_file", sFileName))
                    
    sResult = ShellRun(aArgs)
    
    If sResultFileName <> "" Then
        GetQuadDataFromDB = sResultFileName
    Else
        GetQuadDataFromDB = sResult
    End If
End Function

Public Function IsDataCached(sBookPath As String, _
                             sCacheBookName As String, _
                             sDataType As String, _
                             sSubDataType As String, _
                    Optional iDataId As Integer) As Boolean
Dim sCacheSheetName As String

    sCacheSheetName = sDataType & "_" & sSubDataType
    If iDataId <> 0 Then
        sCacheSheetName = sCacheSheetName & "_" & CStr(iDataId)
    End If
    
    
    If BookExists(sBookPath & "\\" & sCacheBookName) = False Then
        IsDataCached = False
        Exit Function
    End If

    OpenBook sCacheBookName, sPath:=sBookPath
    IsDataCached = SheetExists(Workbooks(sCacheBookName), sCacheSheetName)
                    
End Function

Public Function ParseRawData(sScheduleStr As String) As String()
'"" take the unparsed output returned from python and put into a 2d array
'   where 1 row is 1 day/period and so # periods * # days in total (55 in the beginning)
'   and then columns containing subject,studentname,classtype,location

Dim iNumRows As Integer, iNumCols As Integer, i As Integer, j As Integer
Dim vRows As Variant
Dim vFields As Variant
Dim aSchedule() As String

    vRows = Split(sScheduleStr, DOUBLEDOLLAR)
    iNumRows = UBound(vRows)
    iNumCols = UBound(Split(vRows(0), HAT))
    
    ReDim aSchedule(0 To iNumRows, 0 To iNumCols)
    
    For i = 0 To iNumRows
        vFields = Split(vRows(i), HAT)
        
        For j = 0 To iNumCols
            aSchedule(i, j) = vFields(j)
        Next j
    Next i
    
    ParseRawData = aSchedule
End Function

Public Function CacheData(sBookPath As String, _
                          sCacheBookName As String, _
                          aData() As String, _
                          sDataType As String, _
                          sSubDataType As String, _
                          Optional iDataId As Integer, _
                          Optional bCacheNameOnly As Boolean = False) As String
                                  
' in a backsheet
Dim wbCache As Workbook
Dim wsCache As Worksheet
Dim iNumRows As Integer, iNumCols As Integer
Dim rTarget As Range
Dim nData As Name
Dim sCacheSheetName As String

    ' Assertions --------------------------------
    If InArray(Array("schedule", "person"), sDataType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sPersonType needs to be in [schedule|person] got [" & sDataType & "]"
    End If
    
    If InArray(Array("teacher", "student"), sSubDataType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sScope needs to be in [teacher|student] got [" & sSubDataType & "]"
    End If
    ' END Assertions --------------------------------
    
    sCacheSheetName = sDataType & "_" & sSubDataType
    If iDataId <> 0 Then
        sCacheSheetName = sCacheSheetName & "_" & CStr(iDataId)
    End If
    
    ' when the data is already cached and the caller just needs the cache location
    If bCacheNameOnly = True Then
        GoTo endfunc
    End If
    
    If BookExists(sBookPath & "\\" & sCacheBookName) = False Then
        Set wbCache = CreateBook(sCacheBookName)
    Else
        Set wbCache = OpenBook(sCacheBookName, sPath:=sBookPath)
    End If
    
    Set wsCache = CreateSheet(wbCache, sCacheSheetName, bOverwrite:=True)
    If SheetExists(wbCache, "Sheet1") Then
        DeleteSheet wbCache, "Sheet1" ' can be deleted now not only sheet
    End If
    
    iNumRows = UBound(aData)
    iNumCols = UBound(aData, 2)
    
    With wsCache
        .Activate
        Set rTarget = .Range(.Cells(1, 1), .Cells(iNumRows + 1, iNumCols + 1))
        rTarget.Value = aData
        
        CreateNamedRange ActiveWorkbook, rTarget.Address, sCacheSheetName, cCacheRangeName, sLocalScope:="True"
    End With

endfunc:
    CacheData = sCacheSheetName

End Function
