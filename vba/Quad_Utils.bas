Attribute VB_Name = "Quad_Utils"
'Public Function ParseRawData
'Public Sub CacheData
'Public Sub CreateQuadArgsFile
'Public Function IsDataCached
'Public Function GetQuadDataFromDB
'Public Function Row2Dict
'Public Function SheetTableLookup()
Const C_MODULE_NAME = "Quad_Utils"

Public Const C_PREPS = "1,2,3,4,5"
Public Const C_GRADE_LEVELS = "1,2,3,4,5,6,7,8,9,10,11,12"

Enum ListType
    Students = 1
    Teachers = 2
End Enum

Enum QuadDataType
    Schedule = 1
    Person = 2
    Courses = 3
    Misc = 4
End Enum

Const C_QUAD_DATA_TYPE = "schedule,person,courses,misc"

Enum QuadSubDataType
    Student = 1
    Teacher = 2
    Course = 3
    Subject = 4
    TimePeriod = 5
    Day = 6
    Prep = 7
    Lesson = 8
    Studentlevel = 9
    Location = 10
    Section = 11
End Enum

Const C_QUAD_SUB_DATA_TYPE = "student,teacher,course,subject,timeperiod,day,prep,lesson,studentlevel,location,section"

Enum QuadScope
    all = 1
    specified = 2
End Enum

Const C_QUAD_SCOPE = "all,specified"



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
Public Sub CreateQuadArgsFile(clsAppRuntime As App_Runtime, sSpName As String, _
        Optional dSpArgs As Dictionary, _
        Optional vRows As Variant, _
        Optional vColumns As Variant, _
        Optional vColumnDefns As Variant, _
        Optional vRow As Variant, _
        Optional bDeleteFlag As Boolean = False, _
        Optional bHeaderFlag As Boolean = False)
        
Dim PYTHONPATH As String, xSpArgs As String, sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(clsAppRuntime.FileName)
    On Error GoTo 0
    Call TouchFile(clsAppRuntime.FileName)
    
    Call AppendFile(clsAppRuntime.FileName, "database_name:" & UUEncode(clsAppRuntime.DatabasePath) & vbCrLf)
    Call AppendFile(clsAppRuntime.FileName, "sp_name:" & UUEncode(sSpName) & vbCrLf)
    Call AppendFile(clsAppRuntime.FileName, "delete_flag:" & UUEncode(CStr(bDeleteFlag)) & vbCrLf)
    
    If bHeaderFlag = True Then
        Call AppendFile(clsAppRuntime.FileName, "header_flag:" & UUEncode("True") & vbCrLf)
    End If

    If IsSet(dSpArgs) = True Then
        xSpArgs = CreateXMLDocfromDict(dSpArgs).xml
        Call AppendFile(clsAppRuntime.FileName, "sp_args:" & UUEncode(xSpArgs) & vbCrLf)
    End If
    
    Call AppendFile(clsAppRuntime.FileName, "runtime_dir:" & UUEncode(clsAppRuntime.RuntimeDir) & vbCrLf)
    
    If clsAppRuntime.ResultFileName <> "" Then
        Call AppendFile(clsAppRuntime.FileName, "result_file:" & UUEncode(clsAppRuntime.ResultFileName) & vbCrLf)
    End If

    If IsSet(vColumnDefns) = True Then
        Call AppendFile(clsAppRuntime.FileName, "column_defns:" & ArrayNDtoString(vColumnDefns, bUUEncode:=True) & vbCrLf)
    End If
    
    If IsSet(vColumns) = True Then
        Call AppendFile(clsAppRuntime.FileName, "columns:" & ArrayNDtoString(vColumns, bUUEncode:=True) & vbCrLf)
    End If
    
    If IsSet(vRow) = True Then
        Call AppendFile(clsAppRuntime.FileName, "row:" & ArrayNDtoString(vRow, bUUEncode:=True) & vbCrLf)
    End If
    
    If IsSet(vRows) = True Then
        
        sTmp = ArrayNDtoString(vRows, bUUEncode:=True)
        
        If bDecodeFlag = True Then
            sTmp = AsciiReplace(sTmp, 10, 43, iToCount:=3)
        Else
            sTmp = Replace(sTmp, "'", "")
        End If

        Call AppendFile(clsAppRuntime.FileName, "rows:" & sTmp & vbCrLf)
    
    End If
    
End Sub
Public Function IsDataCached(clsAppRuntime As App_Runtime, _
                             eQuadDataType As QuadDataType, _
                             eQuadSubDataType As QuadSubDataType, _
                    Optional iDataID As Integer) As Boolean
'<<<
' purpose: has this data set already been cached
' param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
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

    IsDataCached = SheetExists(clsAppRuntime.CacheBook, sCacheSheetName)
                    
End Function

Public Function ParseRawData(sData As String) As Variant
'"" take the unparsed output returned from python and put into a 2d array
'   where 1 row is 1 day/period and so # periods * # days in total (55 in the beginning)
'   and then columns containing subject,studentname,classtype,location
    ParseRawData = Delim2Array(sData, bVariant:=True)
End Function

Public Function CacheData(clsAppRuntime As App_Runtime, _
                          aData() As Variant, _
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
        CreateTable sCacheSheetName, wbTmp:=clsAppRuntime.CacheBook
        ReDim vColNames(0 To UBound(aData, 2))
        For iColCount = 0 To UBound(aData, 2)
            vColNames(iColCount) = aData(0, iColCount)
        Next iColCount
        AddTableRecordAuto clsAppRuntime.CacheBook, sCacheSheetName, vColNames, _
                aData, bBulkLoad:=True, vTableFilterID:=iDataID

    Else
        Set wsCache = CreateSheet(clsAppRuntime.CacheBook, sCacheSheetName, bOverwrite:=True)
        If SheetExists(clsAppRuntime.CacheBook, "Sheet1") Then
            DeleteSheet clsAppRuntime.CacheBook, "Sheet1" ' can be deleted now not only sheet
        End If
        
        iNumRows = UBound(aData)
        iNumCols = UBound(aData, 2)
        
        With wsCache
            '.Activate
            ' HERE
            Set rTarget = .Range(.Cells(1, 1), .Cells(iNumRows + 1, iNumCols + 1))
            rTarget.value = aData
            
            CreateNamedRange clsAppRuntime.CacheBook, rTarget.Address, sCacheSheetName, clsAppRuntime.CacheRangeName, sLocalScope:="True"
        End With
    End If

endfunc:
    CacheData = sCacheSheetName

End Function
