Attribute VB_Name = "Quad_Utils"
'Public Function ParseRawData
'Public Sub CacheData
'Public Sub CreateQuadArgsFile
'Public Function IsDataCached
'Public Function GetQuadDataFromDB
'Public Function Row2Dict
'Public Function SheetTableLookup()

Const C_MODULE_NAME = "Quad_Utils"
Private clsQuadRuntimeGlobal As Quad_Runtime
Public Sub ResetQuadRuntimeGlobal()
    Set clsQuadRuntimeGlobal = Nothing
End Sub


Public Function InitQuadRuntimeGlobal(Optional dQuadRuntimeValues As Dictionary) As Quad_Runtime
Dim clsQuadRuntime As New Quad_Runtime
Dim vKey As Variant

    clsQuadRuntime.InitProperties
    
    If IsSet(dQuadRuntimeValues) Then
        For Each vKey In dQuadRuntimeValues
            CallByName clsQuadRuntime, vKey, VbLet, dQuadRuntimeValues.Item(vKey)
        Next vKey
    End If
    
    Set InitQuadRuntimeGlobal = clsQuadRuntime
End Function
Public Sub LetQuadRuntimeGlobal(clsQuadRuntime As Quad_Runtime)
Dim sFuncName As String
    sFuncName = C_MODULE_NAME & "." & "LetQuadRuntimeGlobal"
    If IsInstance(clsQuadRuntime, vbQuadRuntime) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg is not of type Quad_Runtime"
    End If
    
    Set clsQuadRuntimeGlobal = clsQuadRuntime
    FuncLogIt sFuncName, "Setting GLOBAL Quad_Utils.clsQuadRuntimeGlobal", C_MODULE_NAME, LogMsgType.INFO
End Sub
Public Function GetQuadRuntimeGlobal(Optional bInitFlag As Boolean = False, _
                                     Optional dQuadRuntimeValues As Dictionary) As Quad_Runtime
Dim sFuncName As String
    sFuncName = C_MODULE_NAME & "." & "GetQuadRuntimeGlobal"
    
    If IsSet(clsQuadRuntimeGlobal) Then
        Set GetQuadRuntimeGlobal = clsQuadRuntimeGlobal
        FuncLogIt sFuncName, "GETTING GLOBAL Quad_Utils.clsQuadRuntimeGlobal", C_MODULE_NAME, LogMsgType.INFO
    Else
        If bInitFlag = True Then
            Set GetQuadRuntimeGlobal = InitQuadRuntimeGlobal(dQuadRuntimeValues:=dQuadRuntimeValues)
            FuncLogIt sFuncName, "Initializating GLOBAL Quad_Utils.clsQuadRuntimeGlobal", C_MODULE_NAME, LogMsgType.INFO
        Else
            Set GetQuadRuntimeGlobal = Nothing
            FuncLogIt sFuncName, "Cannot GET GLOBAL Quad_Utils.clsQuadRuntimeGlobal as its not set", C_MODULE_NAME, LogMsgType.INFO
        End If
    End If
End Function
Public Function SheetTableLookup(wsDataSheet As Worksheet, sRangeName As String, _
                            sLookupColName As String, vLookUpVal As Variant) As Integer
' assumes row 1 contains the column names
':param:sLookupColName, string, column name that will be used as AboveAverage unique index to lookup by
Dim vColumnNames As Variant, vColumnNamesTransposed As Variant
Dim rColumns As Range, rData As Range
Dim iColumnIdx As Integer

    With wsDataSheet
        Set rData = .Range(sRangeName)
        Set rColumns = rData.Resize(1)
        vColumnNames = rColumns
        vColumnNamesTransposed = ConvertArrayFromRangeto1D(vColumnNames, bHz:=True)
        iColumnIdx = IndexArray(vColumnNamesTransposed, sLookupColName) + 1
        On Error GoTo notfound
        SheetTableLookup = Application.Match(CStr(vLookUpVal), rData.Columns(iColumnIdx), 0)
        Exit Function
        On Error GoTo 0
    End With
notfound:
    SheetTableLookup = -1

End Function

Public Function Row2Dict(wsDataSheet As Worksheet, sRangeName As String, iRowId As Integer) As Dictionary
Dim vColumnNames As Variant, vDataRow As Variant, vColumnNamesTransposed As Variant, vDataRowTransposed As Variant
Dim rColumns As Range, rData As Range, rDataRow As Range
Dim iColumnIdx As Integer
Dim dValues As New Dictionary
Dim iCell As Variant

    With wsDataSheet
        Set rData = .Range(sRangeName)
        Set rColumns = rData.Resize(1)
        Set rDataRow = rData.Resize(1).Offset(iRowId - 1)
        vColumnNames = rColumns
        vDataRow = rDataRow
        vColumnNamesTransposed = ConvertArrayFromRangeto1D(vColumnNames, bHz:=True)
        vDataRowTransposed = ConvertArrayFromRangeto1D(vDataRow, bHz:=True)
        
        For iCell = 0 To UBound(vColumnNamesTransposed)
            dValues.Add vColumnNamesTransposed(iCell), vDataRowTransposed(iCell)
        Next iCell
    End With
    
    Set Row2Dict = dValues
        
End Function

Public Sub SetCacheBook(ByRef sCacheBookName As String, ByRef sCacheBookPath As String)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SetCacheBook"
    ' Assertions --------------------------------
    If sCacheBookPath <> "" And DirExists(sCacheBookPath) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sCacheBookPath dir not found"
    End If
    
    If sCacheBookName <> "" And sCacheBookPath <> "" Then
        If FileExists(sCacheBookPath & "\\" & sCacheBookName) = False Then
            err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg '" & sCacheBookPath & "\\" & sCacheBookName & "[ file not found"
        End If
    End If
    
    ' END Assertions -----------------------------

main:
    If sCacheBookName = "" Then
        sCacheBookName = Quad_Utils.sCacheBookName
        FuncLogIt sFuncName, "Cache workbook name not set so defaulting to [" & sCacheBookName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    If sCacheBookPath = "" Then
        sCacheBookPath = Quad_Utils.sCacheBookPath
        FuncLogIt sFuncName, "Cache workbook path not set so defaulting to [" & sCacheBookPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Sub

Public Sub SetBook(ByRef sBookName As String, ByRef sBookPath As String)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SetBook"
    ' Assertions --------------------------------
    If sBookPath <> "" And DirExists(sBookPath) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sBookPath dir not found"
    End If
    ' END Assertions -----------------------------

main:
    If sBookName = "" Then
        sBookName = Quad_Utils.sBookName
        FuncLogIt sFuncName, "main workbook name not set so defaulting to [" & sCacheBookName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    If sBookPath = "" Then
        sBookPath = Quad_Utils.sBookPath
        FuncLogIt sFuncName, "main workbook path not set so defaulting to [" & sBookPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Sub

Public Sub CreateQuadArgsFile(clsQuadRuntime As Quad_Runtime, sSpName As String, _
        Optional dSpArgs As Dictionary, _
        Optional bHeaderFlag As Boolean = False)

Dim PYTHONPATH As String, xSpArgs As String, sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(clsQuadRuntime.FileName)
    On Error GoTo 0
    Call TouchFile(clsQuadRuntime.FileName)
    
    Call AppendFile(clsQuadRuntime.FileName, "database_name:" & UUEncode(clsQuadRuntime.DatabasePath) & vbCrLf)
    Call AppendFile(clsQuadRuntime.FileName, "sp_name:" & UUEncode(sSpName) & vbCrLf)
    
    If bHeaderFlag = True Then
        Call AppendFile(clsQuadRuntime.FileName, "header_flag:" & UUEncode("True") & vbCrLf)
    End If

    If IsSet(dSpArgs) = True Then
        xSpArgs = CreateXMLDocfromDict(dSpArgs).xml
        Call AppendFile(clsQuadRuntime.FileName, "sp_args:" & UUEncode(xSpArgs) & vbCrLf)
    End If
    
    Call AppendFile(clsQuadRuntime.FileName, "runtime_dir:" & UUEncode(clsQuadRuntime.RuntimeDir) & vbCrLf)
    
    If clsQuadRuntime.ResultFileName <> "" Then
        Call AppendFile(clsQuadRuntime.FileName, "result_file:" & UUEncode(clsQuadRuntime.ResultFileName) & vbCrLf)
    End If
    
End Sub
                           
Public Sub GetQuadDataFromDB(clsQuadRuntime As Quad_Runtime, sSpName As String, _
                        Optional dSpArgs As Dictionary, _
                        Optional bHeaderFlag As Boolean = False)
' get the raw data from a backsheet
Dim sExecPath As String, sRuntimePath As String, sResult As String
Dim aArgs() As String

    CreateQuadArgsFile clsQuadRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=bHeaderFlag
    aArgs = InitStringArray(Array("python", clsQuadRuntime.ExecPath & "excel_data_utils.py", "--input_file", clsQuadRuntime.FileName))
                    
    ShellRun aArgs
    
End Sub

Public Function IsDataCached(clsQuadRuntime As Quad_Runtime, sDataType As String, sSubDataType As String, _
                    Optional iDataId As Integer) As Boolean
Dim sCacheSheetName As String

    sCacheSheetName = sDataType & "_" & sSubDataType
    If iDataId <> 0 Then
        sCacheSheetName = sCacheSheetName & "_" & CStr(iDataId)
    End If

    IsDataCached = SheetExists(clsQuadRuntime.CacheBook, sCacheSheetName)
                    
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

Public Function CacheData(clsQuadRuntime As Quad_Runtime, aData() As String, sDataType As String, sSubDataType As String, _
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
    
    Set wsCache = CreateSheet(clsQuadRuntime.CacheBook, sCacheSheetName, bOverwrite:=True)
    If SheetExists(clsQuadRuntime.CacheBook, "Sheet1") Then
        DeleteSheet clsQuadRuntime.CacheBook, "Sheet1" ' can be deleted now not only sheet
    End If
    
    iNumRows = UBound(aData)
    iNumCols = UBound(aData, 2)
    
    With wsCache
        .Activate
        Set rTarget = .Range(.Cells(1, 1), .Cells(iNumRows + 1, iNumCols + 1))
        rTarget.Value = aData
        
        CreateNamedRange ActiveWorkbook, rTarget.Address, sCacheSheetName, clsQuadRuntime.CacheRangeName, sLocalScope:="True"
    End With

endfunc:
    CacheData = sCacheSheetName

End Function
