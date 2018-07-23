Attribute VB_Name = "Data_Utils"
Option Explicit

' IsDataCached
' ParseRawData
' CacheData
' GetTableRecordID

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

Public Function GetTableRecordID(vValue As Variant, sLookUpFieldName As String) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary
    clsAppRuntime.InitProperties bInitializeCache:=False
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadDataType", QuadDataType.person, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "sLookUpByColName", sLookUpFieldName, _
                          "sLookUpByValue", vValue, _
                          "sLookUpColName", "RefNo"
    Application.Run C_CROSS_REF_QUAD_DATA, dArgs
    GetTableRecordID = dArgs.Item("result")
    
    'GetTableRecordID = CrossRefQuadData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, _
    '    sLookUpFieldName, vValue, "RefNo")
End Function
