Attribute VB_Name = "Quad_Utils"
'Public Function ParseRawData
'Public Sub CacheData
'Public Sub CreateQuadArgsFile
'Public Function IsDataCached
'Public Function GetQuadDataFromDB
'Public Function Row2Dict
'Public Function SheetTableLookup()
Const C_MODULE_NAME = "Quad_Utils"

Enum QuadDataType
    schedule = 1
    person = 2
    courses = 3
    misc = 4
End Enum

Const C_QUAD_DATA_TYPE = "schedule,person,courses,misc"

Enum QuadSubDataType
    student = 1
    teacher = 2
    Course = 3
    subject = 4
    TimePeriod = 5
    day = 6
    Prep = 7
End Enum

Const C_QUAD_SUB_DATA_TYPE = "student,teacher,course,subject,timeperiod,day,prep"

Enum QuadScope
    all = 1
    specified = 2
End Enum

Const C_QUAD_SCOPE = "all,specified"


Private clsQuadRuntimeGlobal As Quad_Runtime

Function EnumQuadDataType(i As Long) As String
    EnumQuadDataType = Split(C_QUAD_DATA_TYPE, COMMA)(i - 1)
End Function
Function GetQuadDataTypeEnumFromValue(sValue As String) As Long
    GetQuadDataTypeEnumFromValue = IndexArray(C_QUAD_DATA_TYPE, sValue)
End Function
Function EnumQuadSubDataType(i As Long) As String
    EnumQuadSubDataType = Split(C_QUAD_SUB_DATA_TYPE, COMMA)(i - 1)
End Function
Function GetQuadSubDataTypeEnumFromValue(sValue As String) As Long
    GetQuadSubDataTypeEnumFromValue = IndexArray(C_QUAD_SUB_DATA_TYPE, sValue)
End Function
Function EnumQuadScope(i As Long) As String
    EnumQuadScope = Split(C_QUAD_SCOPE, COMMA)(i - 1)
End Function
Function GetQuadScopeEnumFromValue(sValue As String) As Long
    GetQuadScopeEnumFromValue = IndexArray(C_QUAD_SCOPE, sValue)
End Function
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
                            sLookUpColName As String, vLookUpVal As Variant, _
                            Optional wbTmp As Workbook) As Integer
' assumes row 1 contains the column names
':param:sLookupColName, string, column name that will be used as AboveAverage unique index to lookup by
Dim vColumnNames As Variant, vColumnNamesTransposed As Variant
Dim rColumns As Range, rData As Range
Dim iColumnIdx As Integer

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
        
    'Set rData = wbTmp.Sheets("person_student").Range(sRangeName)
    With wsDataSheet
        Set rData = .Range(sRangeName)
        Set rColumns = rData.Resize(1)
        vColumnNames = rColumns
        vColumnNamesTransposed = ConvertArrayFromRangeto1D(vColumnNames, bHz:=True)
        iColumnIdx = IndexArray(vColumnNamesTransposed, sLookUpColName) + 1
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
                        
Public Function GetColumnValues(clsQuadRuntime As Quad_Runtime, _
                                 eQuadDataType As QuadDataType, _
                                 eQuadSubDataType As QuadSubDataType, _
                                 sLookUpColName As String, _
                        Optional iPersonID As Integer) As String()
Dim wsCache As Worksheet
Dim sLookUpRangeName As String

    If eQuadDataType = QuadDataType.schedule Then
        Set wsCache = GetScheduleData(clsQuadRuntime, iPersonID, eQuadDataType, eQuadSubDataType, bInTable:=True)
    Else
        Set wsCache = GetPersonData(clsQuadRuntime, eQuadDataType, eQuadSubDataType, QuadScope.all, bInTable:=True)
    End If
    sLookUpRangeName = GetDBColumnRange(wsCache.Name, sLookUpColName)
    GetColumnValues = ListFromRange(wsCache, sLookUpRangeName)
                                 
End Function
Public Function CrossRefQuadData(clsQuadRuntime As Quad_Runtime, _
                                 eQuadDataType As QuadDataType, _
                                 eQuadSubDataType As QuadSubDataType, _
                                 sLookUpByColName As String, _
                                 sLookUpByValue As Variant, _
                                 sLookUpColName As String)
Dim wsCache As Worksheet
Dim sLookUpByRangeName As String, sLookUpRangeName As String
Dim vLookUpByValues() As String, vLookUpValues() As String

    Set wsCache = GetPersonData(clsQuadRuntime, eQuadDataType, eQuadSubDataType, QuadScope.all, _
                                    bInTable:=True)
            
    sLookUpByRangeName = GetDBColumnRange(wsCache.Name, sLookUpByColName)
    sLookUpRangeName = GetDBColumnRange(wsCache.Name, sLookUpColName)
    
    vLookUpByValues = ListFromRange(wsCache, sLookUpByRangeName)
    vLookUpValues = ListFromRange(wsCache, sLookUpRangeName)

    CrossRefQuadData = vLookUpValues(IndexArray(vLookUpByValues, CStr(sLookUpByValue)))

    
End Function

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
Public Function IsDataCached(clsQuadRuntime As Quad_Runtime, _
                             eQuadDataType As QuadDataType, _
                             eQuadSubDataType As QuadSubDataType, _
                    Optional iDataID As Integer) As Boolean
'<<<
' purpose: has this data set already been cached
' param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : eQuadDataType, QuadDataType; what type of data are we querying
' returns: Boolean
'>>>
Dim sCacheSheetName As String

    sCacheSheetName = EnumQuadDataType(eQuadDataType) & "_" & EnumQuadSubDataType(eQuadSubDataType)
    If iDataID <> 0 Then
        sCacheSheetName = sCacheSheetName & "_" & CStr(iDataID)
    End If

    IsDataCached = SheetExists(clsQuadRuntime.CacheBook, sCacheSheetName)
                    
End Function

Public Function ParseRawData(sData As String) As String()
'"" take the unparsed output returned from python and put into a 2d array
'   where 1 row is 1 day/period and so # periods * # days in total (55 in the beginning)
'   and then columns containing subject,studentname,classtype,location
    ParseRawData = Delim2Array(sData)
End Function

Public Function CacheData(clsQuadRuntime As Quad_Runtime, _
                          aData() As String, _
                          eQuadDataType As QuadDataType, _
                          eQuadSubDataType As QuadSubDataType, _
                 Optional iDataID As Integer, _
                 Optional bCacheNameOnly As Boolean = False, _
                 Optional bInTable As Boolean = False) As String
'<<<
' purpose: take a data set (from db etc) and store it in a worksheet "cache"
'        : store it in "Table" form if required, where Table adds column ranges etc
'        : name of the worksheet is a concat of the passed args so it can be constructed automatically
' param  : aData, string 2D array; contains the raw data to be stored
'        : 1st row contains column names
' param  : eQuadDataType, QuadDataType; what type of data are we querying
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : iDataID (optional), Integer; If its a specific person not all
' param  : bCacheNameOnly, boolean; True if caller just wants to retreive worksheet name of cache
' param  : bInTable, boolean; True if caller wants cache stored in Table form
' returns: String; name of the cache worksheet
'>>>
Dim wbCache As Workbook
Dim wsCache As Worksheet
Dim iNumRows As Integer, iNumCols As Integer, iColCount As Integer
Dim rTarget As Range
Dim nData As Name
Dim sCacheSheetName As String
Dim vColNames() As String
Dim wsCurrentFocus As Worksheet

    sCacheSheetName = EnumQuadDataType(eQuadDataType) & "_" & EnumQuadSubDataType(eQuadSubDataType)
        
    If iDataID <> 0 Then
        sCacheSheetName = sCacheSheetName & "_" & CStr(iDataID)
    End If
    
    ' when the data is already cached and the caller just needs the cache location
    If bCacheNameOnly = True Then
        GoTo endfunc
    End If
    
    ' wrap the data in a Table structure from Table_Utils or create manually
    If bInTable = True Then
        CreateTable sCacheSheetName, wbTmp:=clsQuadRuntime.CacheBook
        ReDim vColNames(0 To UBound(aData, 2))
        For iColCount = 0 To UBound(aData, 2)
            vColNames(iColCount) = aData(0, iColCount)
        Next iColCount
        AddTableRecordAuto clsQuadRuntime.CacheBook, sCacheSheetName, vColNames, _
                aData, bBulkLoad:=True, vTableFilterID:=iDataID

    Else
        Set wsCache = CreateSheet(clsQuadRuntime.CacheBook, sCacheSheetName, bOverwrite:=True)
        If SheetExists(clsQuadRuntime.CacheBook, "Sheet1") Then
            DeleteSheet clsQuadRuntime.CacheBook, "Sheet1" ' can be deleted now not only sheet
        End If
        
        iNumRows = UBound(aData)
        iNumCols = UBound(aData, 2)
        
        With wsCache
            '.Activate
            ' HERE
            Set rTarget = .Range(.Cells(1, 1), .Cells(iNumRows + 1, iNumCols + 1))
            rTarget.value = aData
            
            CreateNamedRange clsQuadRuntime.CacheBook, rTarget.Address, sCacheSheetName, clsQuadRuntime.CacheRangeName, sLocalScope:="True"
        End With
    End If

endfunc:
    CacheData = sCacheSheetName

End Function
