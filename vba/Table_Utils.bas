Attribute VB_Name = "Table_Utils"
'Function   CalcCreatedTime         (sTableName As String)                  As Date
'Function   CalcLastUpdatedTime     (sTableName As String)                  As Date
'Function   CalcID                  (sTableName As String)                  As Integer
'Sub        FormatID                (wsTmp As Worksheet, rCell As Range)
'Sub        FormatLastUpdatedTime   (wsTmp As Worksheet, rCell As Range)
'Sub        FormatCreatedTime       (wsTmp As Worksheet, rCell As Range)
'Function   GetTableRecord          (sTableName As String, iID As Integer)  As Dictionary
'Function   AddTableRecord          (sTableName As String)                  As Integer
'Function   CreateTable             (sTableName As String)                  As Worksheet
'Sub        CreateTableColumn       (wsTmp As Worksheet, iCol As Integer, sTableName As String, sFieldName As String)

Option Explicit
Const C_MODULE_NAME = "Table_Utils"
Const C_DB_DEFAULT_FIELDS = "CreatedTime,LastUpdatedTime,RefNo,SyncState"

Enum ColumnType
    Db = 1
    INFO = 2
End Enum

Const C_COLUMN_TYPE = "DB,Info"

Function EnumColumnType(i As Long) As String
    EnumColumnType = Split(C_COLUMN_TYPE, COMMA)(i - 1)
End Function
Function GetColumnTypeEnumFromValue(sValue As String) As Long
    GetColumnTypeEnumFromValue = IndexArray(C_COLUMN_TYPE, sValue)
End Function

Public Function CalcSyncState(sTableName As String, Optional wbTmp As Workbook) As String
    CalcSyncState = "User"
End Function
Public Function CalcCreatedTime(sTableName As String, Optional wbTmp As Workbook) As Date
    CalcCreatedTime = Now()
End Function
Public Function CalcLastUpdatedTime(sTableName As String, Optional wbTmp As Workbook) As Date
    CalcLastUpdatedTime = Now()
End Function
Public Function CalcRefNo(sTableName As String, Optional wbTmp As Workbook) As String
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    CalcRefNo = "=Row()"
               
    'CalcID = wbTmp.Sheets(sTableName).Range("i" & sTableName & "NextFree").value

End Function
Public Sub FormatID(wsTmp As Worksheet, rCell As Range)
    MakeCellInteger wsTmp, rCell
End Sub
Public Sub FormatLastUpdatedTime(wsTmp As Worksheet, rCell As Range)
    MakeCellLongDate wsTmp, rCell
End Sub
Public Sub FormatCreatedTime(wsTmp As Worksheet, rCell As Range)
    MakeCellLongDate wsTmp, rCell
End Sub

Public Function GetTableName(sDataType As String, sSubDataType As String) As String
    GetTableName = LCase(sDataType) & UNDERSCORE & LCase(sSubDataType)
End Function
Public Function GetTable(clsAppRuntime As App_Runtime, sDataType As String, sSubDataType As String) As Worksheet
Dim sTableName As String
    sTableName = GetTableName(sDataType, sSubDataType)
    
    ' if Table does not exist
    If SheetExists(clsAppRuntime.CacheBook, sTableName) = False Then
        Set GetTable = CreateTable(sTableName, wbTmp:=clsAppRuntime.CacheBook)
    Else
        Set GetTable = GetSheet(clsAppRuntime.CacheBook, sTableName)
    End If
    
End Function
Public Function Row2Dict(wsDataSheet As Worksheet, sRangeName As String, iRowId As Integer) As Dictionary
Dim vColumnNames As Variant, vDataRow As Variant, vColumnNamesTransposed As Variant, vDataRowTransposed As Variant
Dim rColumns As Range, rData As Range, rDataRow As Range
Dim iColumnIdx As Integer
Dim dValues As New Dictionary
Dim iWidget As Variant

    With wsDataSheet
        Set rData = .Range(sRangeName)
        Set rColumns = rData.Resize(1)
        Set rDataRow = rData.Resize(1).Offset(iRowId - 1)
        vColumnNames = rColumns
        vDataRow = rDataRow
        vColumnNamesTransposed = ConvertArrayFromRangeto1D(vColumnNames, bHz:=True)
        vDataRowTransposed = ConvertArrayFromRangeto1D(vDataRow, bHz:=True)
        
        For iWidget = 0 To UBound(vColumnNamesTransposed)
            dValues.Add vColumnNamesTransposed(iWidget), vDataRowTransposed(iWidget)
        Next iWidget
    End With
    
    Set Row2Dict = dValues
        
End Function
Public Function GetColumnValues(clsAppRuntime As App_Runtime, _
                                 eQuadDataType As QuadDataType, _
                                 eQuadSubDataType As QuadSubDataType, _
                                 sLookUpColName As String, _
                        Optional iPersonID As Integer) As String()
Dim wsCache As Worksheet
Dim sLookUpRangeName As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetColumnValues"
    'FuncLogIt sFuncName, "[sLookUpColName=" & sLookUpColName & "] [iPersonID=" & iPersonID & "]", C_MODULE_NAME, LogMsgType.INFUNC

main:
    If eQuadDataType = QuadDataType.Schedule Then
        Set wsCache = GetScheduleData(clsAppRuntime, iPersonID, eQuadDataType, eQuadSubDataType, bInTable:=True)
    Else
        Set wsCache = GetPersonData(clsAppRuntime, eQuadDataType, eQuadSubDataType, QuadScope.all, bInTable:=True)
    End If
    sLookUpRangeName = GetDBColumnRange(wsCache.Name, sLookUpColName)
    GetColumnValues = ListFromRange(wsCache, sLookUpRangeName)
                       
endfunc:
    On Error GoTo 0
    Exit Function
    
err:
    FuncLogIt sFuncName, "[sLookUpColName=" & sLookUpColName & "] [iPersonID=" & iPersonID & "]", C_MODULE_NAME, LogMsgType.Error
                       
End Function
Public Function IsWidgetRangeNameForView(sWidgetRangeName As String, sTableName As String, eWidgetType As WidgetType) As Boolean
'<<<
'purpose:
'param  :
'param  :
'rtype  :
'>>>
Dim sFuncName As String, sWidgetSuffix As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "IsKeyForTable"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    IsWidgetRangeNameForView = False
    sWidgetSuffix = LCase(Left(EnumWidgetType(eWidgetType), 1))
    If Split(sWidgetRangeName, UNDERSCORE)(0) = sWidgetSuffix & sTableName Then
        IsWidgetRangeNameForView = True
    End If

cleanup:
    FuncLogIt sFuncName, "[sKey=" & sWidgetRangeName & "][sTableName=" & sTableName & "] [Result=" & CStr(IsWidgetRangeNameForView) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
  
End Function

Public Function GetTableWidgetKeys(sTableName As String, Optional bFieldNameOnly As Boolean = False) As String()
'<<<
'purpose: a field can appear in Definitions multiple times so need to eliminate dupes
'param  :
'param  :
'rtype  :
'>>>
Dim vWidgetKeys() As String
Dim iWidgetKeyCount As Integer
Dim lStartTick As Long
Dim sFuncName As String, sFieldName As String
Dim sKey As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "GetTableWidgetKeys"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    ReDim vWidgetKeys(0 To 100)
main:
    
    For Each sKey In dDefinitions.Keys()
        If dDefinitions.Item(sKey).Item("CacheTableName") = sTableName Then
        
            sFieldName = GetFieldName(CStr(sKey))
            
            If InArray(vWidgetKeys, sFieldName, bLike:=True) = False Then
                If bFieldNameOnly = True Then
                    vWidgetKeys(iWidgetKeyCount) = Split(CStr(sKey), UNDERSCORE)(1)
                Else
                    vWidgetKeys(iWidgetKeyCount) = CStr(sKey)
                End If
                iWidgetKeyCount = iWidgetKeyCount + 1
            End If
        End If
    Next sKey
    
    ReDim Preserve vWidgetKeys(0 To iWidgetKeyCount - 1)
    GetTableWidgetKeys = vWidgetKeys
    
cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    FuncLogIt sFuncName, "[sTableName=" & sTableName & "] [Result=" & CStr(UBound(GetTableWidgetKeys) + 1) & " keys]", C_MODULE_NAME, LogMsgType.DEBUGGING2

End Function

        
Public Function GetDBColumnRange(ByVal sTableName, sFieldName, _
        Optional eColumnType As ColumnType = ColumnType.Db) As String
'<<<
'purpose:
'param  :
'param  :
'rtype  :
'>>>
Dim sLookUpTableName As String, sSuffix As String, sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDBColumnRange"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    If Left(sTableName, 1) = "&" Then
        sTableName = Right(sTableName, Len(sTableName) - 5)
    End If

    If sFieldName = "ID" Or sFieldName = "RefNo" Or sFieldName = "SyncState" Or sFieldName = "CreatedTime" Or sFieldName = "LastUpdatedTime" Then
        eColumnType = ColumnType.INFO
    End If
    
    If eColumnType = ColumnType.Db Then
        sSuffix = "db"
    ElseIf eColumnType = ColumnType.INFO Then
        sSuffix = "i"
    End If
    
    GetDBColumnRange = sSuffix & sTableName & sFieldName

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    FuncLogIt sFuncName, "[sTableName=" & sTableName & "] [sFieldName=" & sFieldName & "] [Result=" & GetDBColumnRange & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
  
End Function

Public Function GetDirtyTableRecords(sTableName As String, _
                            Optional wbTmp As Workbook, _
                            Optional bResetDirtyFlag As Boolean = False) As Variant
Dim sFuncName As String, sFieldName As String, sFieldValue As String, sColRange As String
Dim wsTable As Worksheet
Dim sKey As Variant
Dim dDefnDetails As Dictionary, dRecordValues As Dictionary
Dim rSyncState As Range
Dim iNextFree As Integer, iRow As Integer, iNumDirtyRows As Integer, i As Integer
Dim vValues() As String, vRows() As Variant

setup:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If

    ReDim vRows(0 To 1000, 0 To 12)
    
main:
    sFuncName = C_MODULE_NAME & "." & "GetDirtyTableRecords"
    Set wsTable = GetSheet(wbTmp, sTableName)
    
    sColRange = GetDBColumnRange(sTableName, "NextFree", eColumnType:=ColumnType.INFO)
    iNextFree = CInt(wsTable.Range(sColRange).Rows(1).value)
    
    sColRange = GetDBColumnRange(sTableName, "SyncState", eColumnType:=ColumnType.INFO)
    Set rSyncState = wsTable.Range(sColRange)
    
    For iRow = 2 To iNextFree
        If rSyncState.Rows(iRow).value = "User" Then
            ReDim vValues(0)
            GetTableRecord sTableName, iRow - 1, wbTmp:=wbTmp, vValues:=vValues
            
            For i = 0 To UBound(vValues)
                vRows(iNumDirtyRows, i) = vValues(i)
            Next i

            iNumDirtyRows = iNumDirtyRows + 1
            If bResetDirtyFlag = True Then
                rSyncState.Rows(iRow).value = "DB"
            End If
        End If
    Next iRow
    
cleanup:
    GetDirtyTableRecords = ReDim2DArray(vRows, iNumDirtyRows, UBound(vValues) + 1, bVariant:=True)
    
End Function
Public Function GetTableRecord(sTableName As String, iID As Integer, Optional wbTmp As Workbook, _
                Optional vValues As Variant) As Dictionary
Dim sFuncName As String, sColRange As String, sFieldName As String, sFieldValue As String
Dim i As Integer, iNumValues As Integer
Dim wsTable As Worksheet
Dim sKey As Variant
Dim dDefnDetails As Dictionary, dRecord As New Dictionary
Dim vWidgetKeys() As String

setup:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    sFuncName = C_MODULE_NAME & "." & "GetTableRecord"
    Set wsTable = GetSheet(wbTmp, sTableName)
    
main:
    With wsTable
        vWidgetKeys = GetTableWidgetKeys(sTableName)
        'For Each sKey In dDefinitions.Keys()
        If UBound(vWidgetKeys) = 0 Then
            FuncLogIt sFuncName, "entry [" & sKey & "] does not have a \'CacheTableName\' record", C_MODULE_NAME, LogMsgType.Error
            'Exit Function
        End If
            
        For i = 0 To UBound(vWidgetKeys)
        
        'If dDefinitions.Item(sKey).Item("CacheTableName") = sTableName Then
            Set dDefnDetails = dDefinitions.Item(vWidgetKeys(i))
            sFieldName = dDefnDetails.Item("FieldName")
            sColRange = GetDBColumnRange(sTableName, sFieldName)
            sFieldValue = wsTable.Range(sColRange).Rows(iID + 1)
            'sFieldValue = wsTable.Range(sColRange).Rows(iID)
            dRecord.Add sFieldName, sFieldValue
            iNumValues = iNumValues + 1
        'End If
        Next i
       ' Next sKey
    End With

    If IsSet(vValues) = True Then
        ReDim vValues(0 To iNumValues - 1)
        For i = 0 To UBound(dRecord.Keys)
            vValues(i) = dRecord.Item(dRecord.Keys(i))
        Next i
    End If
    
    FuncLogIt sFuncName, "retreived [" & CStr(UBound(dRecord.Keys()) + 1) & "] fields from id [" & CStr(iID) & "] from table [" & sTableName & "]", C_MODULE_NAME, LogMsgType.OK
    
    Set GetTableRecord = dRecord
End Function
Public Function AddTableRecordAuto(wbTmp As Workbook, sTableName As String, _
        vColNames() As String, ByVal vRows As Variant, _
        Optional bAddDefaultFields As Boolean = True, _
        Optional bBulkLoad As Boolean = False, _
        Optional vTableFilterID As Variant) As Range
' add 1 or more records to a "table"; used for bulk load from DB or for creating tests
' assumes records are "valid", all values need to be passed in as arguments
' can provide a database table as the source
' also flag that allows assumption columns are in the same order as the table so can be written to sheet in 1 write
' param: sColumnNames, String Array; index for sRows retreived from posn in this list
' param: sRows, String Array 2d ; data rows
' param: sTableName, String; can derive the sheet that the rows need to be added to
Dim sKey As Variant, sDetailKey As Variant, sSheetName As String, sColRange As String, sFuncName As String
Dim dDetail As Dictionary
Dim iRowCount As Integer, iColCount As Integer, iNextFree As Integer, iDefaultFieldCount As Integer, iOrigWidth As Integer
Dim iMaxRow As Integer, iMaxCol As Integer, i As Integer, j As Integer, iOrigLastCol As Integer
Dim wsTable As Worksheet
Dim rTarget As Range, rNextFree As Range
Dim aDefaultFields() As String
Dim aDefaultValues() As Variant

    ' ASSERTIONS ---------------------------------------------------------

    If Is2DArray(vRows) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg is not of type 2D string array"
    End If
    
    If IsInstance(vColNames, vbStringArray) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg is not of type string array"
    End If

    If UBound(vColNames) <> UBound(vRows, 2) - LBound(vRows, 2) Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="col description array must have 1 item per column in rows array"
    End If
    ' END ASSERTIONS ------------------------------------------------------

setup:
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordAuto"
    
    If IsSet(vTableFilterID) = True Then
        If vTableFilterID <> 0 Then
            sTableName = sTableName & "_" & CStr(vTableFilterID)
        End If
    End If
    
    Set wsTable = GetSheet(wbTmp, sTableName)
    'End If
    aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
        
main:

    If bBulkLoad = False Then
        ' default to 1 if for some reason iNextFree is not readable
        iNextFree = 2
        On Error Resume Next
        iNextFree = wsTable.Range("i" & sTableName & "NextFree").value + 1
        On Error GoTo 0
        
        For iRowCount = LBound(vRows) To UBound(vRows)
            For iColCount = LBound(vRows, 2) To UBound(vRows, 2)
                sColRange = GetDBColumnRange(sTableName, vColNames(iColCount - LBound(vRows, 2)))
                wsTable.Range(sColRange).Rows(iNextFree) = vRows(iRowCount, iColCount)
            Next iColCount
    
            For iDefaultFieldCount = 0 To UBound(aDefaultFields)
                sColRange = GetDBColumnRange(sTableName, aDefaultFields(iDefaultFieldCount))
                wsTable.Range(sColRange).Rows(iNextFree) = Application.Run("Calc" & aDefaultFields(iDefaultFieldCount), sTableName, wbTmp)
            Next iDefaultFieldCount
            wsTable.Range("i" & sTableName & "NextFree").value = iNextFree
            iNextFree = iNextFree + 1
            
        Next iRowCount
    Else
        If bAddDefaultFields = True Then
            ' add default columns to array and calc values
            'aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
            ReDim aDefaultValues(0 To 3)
            iOrigWidth = UBound(vRows, 2) + 1 - LBound(vRows)
            iOrigLastCol = UBound(vRows, 2)
            vRows = ReDim2DArray(vRows, UBound(vRows) - LBound(vRows) + 1, iOrigWidth + UBound(aDefaultFields) + 1, bExpand:=True, _
            iStartCol:=LBound(vRows, 2), iStartRow:=LBound(vRows), bVariant:=True)
            ReDim Preserve vColNames(0 To UBound(vColNames))
            
            vRows(LBound(vRows), iOrigLastCol + 1) = aDefaultFields(0)
            vRows(LBound(vRows), iOrigLastCol + 2) = aDefaultFields(1)
            vRows(LBound(vRows), iOrigLastCol + 3) = aDefaultFields(2)
            vRows(LBound(vRows), iOrigLastCol + 4) = aDefaultFields(3)
            
            aDefaultValues(0) = Application.Run("Calc" & aDefaultFields(0), sTableName, wbTmp)
            aDefaultValues(1) = Application.Run("Calc" & aDefaultFields(1), sTableName, wbTmp)
            aDefaultValues(2) = "=Row()"
            aDefaultValues(3) = "DB"
            
            ' fill down (assume 1st row is headings)
            For i = LBound(vRows) + 1 To UBound(vRows)
                For j = LBound(vRows, 2) + iOrigWidth To LBound(vRows, 2) + iOrigWidth + UBound(aDefaultValues)
                    vRows(i, j) = aDefaultValues(j - iOrigWidth - LBound(vRows, 2))
                Next j
            Next i
            
            Set rNextFree = wsTable.Range("i" & sTableName & "NextFree")
            rNextFree.value = UBound(vRows) - LBound(vRows) + 1
        End If
        
        iMaxRow = UBound(vRows) - LBound(vRows) + 1
        iMaxCol = UBound(vColNames) + 1 + UBound(aDefaultFields) + 1
        With wsTable
            Set rTarget = .Range(.Cells(1, 1), .Cells(iMaxRow, iMaxCol))
            rTarget = vRows
            rTarget.Name = "data"
        End With
        
        Set AddTableRecordAuto = rTarget
    End If
End Function

Public Function AddTableRecordFromDict(wsTable As Worksheet, _
                                       sTableName As String, _
                                       dValues As Dictionary) As Integer
Dim sKey As Variant
Dim iNextFree As Integer, i As Integer
Dim sFuncName As String, sColRange As String
Dim aDefaultFields() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordFromDict"

main:

    iNextFree = 2
    On Error Resume Next
    iNextFree = wsTable.Range("i" & sTableName & "NextFree").Rows(1).value + 1
    On Error GoTo 0
    
    'iNextFree = wsTable.Range("i" & sTableName & "NextFree").value + 1
    
    For Each sKey In dValues
        sColRange = GetDBColumnRange(sTableName, sKey)
        wsTable.Range(sColRange).Rows(iNextFree) = dValues.Item(sKey)
    Next sKey
    
    aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
    For i = 0 To UBound(aDefaultFields)
        sColRange = GetDBColumnRange(sTableName, aDefaultFields(i), ColumnType.INFO)
        wsTable.Range(sColRange).Rows(iNextFree) = Application.Run("Calc" & aDefaultFields(i), sTableName, wsTable.Parent)
    Next i


    wsTable.Range("i" & sTableName & "NextFree").value = iNextFree

    AddTableRecordFromDict = iNextFree
End Function
Public Function AddTableRecord(sTableName As String, _
                      Optional wbAddBook As Workbook, _
                      Optional wbCacheBook As Workbook) As Integer
' used for inserting rows from a user add screen
Dim sKey As Variant
Dim dDefnDetails As Dictionary
Dim wsAdd As Worksheet, wsTable As Worksheet
Dim iNextFree As Integer, i As Integer
Dim sColRange As String, sFuncName As String
Dim aDefaultFields() As String, vWidgetKeys() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "AddTableRecord"
    
    If IsSet(wbAddBook) = False Then
        Set wbAddBook = ActiveWorkbook
    End If
    
    If IsSet(wbCacheBook) = False Then
        Set wbCacheBook = ActiveWorkbook
    End If
    
    Set wsAdd = GetSheet(wbAddBook, "Add" & sTableName)
    Set wsTable = GetSheet(wbCacheBook, sTableName)
    
main:
    With wsAdd
        
        iNextFree = 2
        On Error Resume Next
        iNextFree = wsTable.Range("i" & sTableName & "NextFree").Rows(1).value + 1
        On Error GoTo 0

        vWidgetKeys = GetTableWidgetKeys(sTableName)
        If UBound(vWidgetKeys) = 0 Then
            FuncLogIt sFuncName, "entry [" & sKey & "] does not have a \'CacheTableName\' record", C_MODULE_NAME, LogMsgType.Error
        End If
            
        For i = 0 To UBound(vWidgetKeys)
            If dDefinitions.Item(vWidgetKeys(i)).Item("CacheTableName") = sTableName Then
                Set dDefnDetails = dDefinitions.Item(vWidgetKeys(i))
                sColRange = GetDBColumnRange(sTableName, dDefnDetails.Item("FieldName"))

                If NamedRangeExists(wbCacheBook, sTableName, sColRange) = False Then
                    AddTableRecord = -1
                    FuncLogIt sFuncName, "range [" & sColRange & "] does not exist in sheet [" & sTableName & "]", C_MODULE_NAME, LogMsgType.OK
                    Exit Function
                End If
                
                wsTable.Range(sColRange).Rows(iNextFree) = .Range(dDefnDetails.Item("address")).value
            End If
        'Next sKey
        Next i
        
        aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
        For i = 0 To UBound(aDefaultFields)
            sColRange = GetDBColumnRange(sTableName, aDefaultFields(i), ColumnType.INFO)
            wsTable.Range(sColRange).Rows(iNextFree) = Application.Run("Calc" & aDefaultFields(i), sTableName, wbCacheBook)
        Next i
    End With
    
    FuncLogIt sFuncName, "record id [" & CStr(iNextFree + 1) & "] added to table [" & sTableName & "]", C_MODULE_NAME, LogMsgType.OK
    
    wsTable.Range("i" & sTableName & "NextFree").value = iNextFree
    
err:
    
End Function
Public Sub CreateTableColumn(wsTmp As Worksheet, iCol As Integer, ByVal sTableName As String, sFieldName As String, _
                Optional wbTmp As Workbook, _
                Optional vDataID As Variant, _
                Optional eColumnType As ColumnType = ColumnType.Db, _
                Optional iFirstDataLine As Integer = 2)
'<<<
'purpose: simple wrapper to launch a Student View workflow
'param  : clsAppRuntime,App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'param  :
'rtype  :
'>>>
Dim rColumn As Range
Dim sRangeName As String, sSuffix As String, sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "CreateTableColumn"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    
main:
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    If eColumnType = ColumnType.Db Then
        sSuffix = "db"
    ElseIf eColumnType = ColumnType.INFO Then
        sSuffix = "i"
    End If
    
    
    With wsTmp
        .Range(.Cells(1, iCol), .Cells(1, iCol)).value = sFieldName ' draw headings
        'Set rColumn = .Range(.Cells(iFirstDataLine, iCol), .Cells(10000, iCol))
        Set rColumn = .Range(.Cells(1, iCol), .Cells(10000, iCol))
    End With
    
    If IsSet(vDataID) Then
        sTableName = sTableName & UNDERSCORE & CStr(vDataID)
    End If
    sRangeName = sSuffix & sTableName & sFieldName
        
    CreateNamedRange wbTmp, rColumn.Address, wsTmp.Name, sRangeName, "True"

cleanup:
    FuncLogIt sFuncName, "[iCol=" & CStr(iCol) & "] [sTableName=" & sTableName & "] [sFieldName=" & sFieldName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Sub

err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Sub
Public Function CreateTable(sTableName As String, _
                   Optional wbTmp As Workbook, _
                   Optional bShowFilter As Boolean = False) As Worksheet
Dim iCol As Integer
Dim dDefnDetail As Dictionary
Dim vSource() As String, vTableNameSplits() As String, vWidgetKeys() As String
Dim rTarget As Range
Dim wsTmp As Worksheet
Dim sKey As Variant
Dim aDefaultFields() As String
Dim i As Integer
Dim sRangeName As String
Dim sFuncName As String
Dim clsAppRuntime As New App_Runtime
Dim vDataID As Variant

setup:
    clsAppRuntime.InitProperties bInitializeCache:=False
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    sFuncName = C_MODULE_NAME & "." & "CreateTable"
    
    Set wsTmp = CreateSheet(wbTmp, CStr(sTableName), bOverwrite:=True)
    wsTmp.Visible = xlSheetHidden
    
    aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")

    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsAppRuntime:=clsAppRuntime
    End If

    ' this is to account for sub tables that are filtered tables (like by personID)
    vTableNameSplits = Split(sTableName, UNDERSCORE)
    If UBound(vTableNameSplits) = 2 Then
        sTableName = vTableNameSplits(0) & UNDERSCORE & vTableNameSplits(1)
        vDataID = vTableNameSplits(2)
    Else
        Set vDataID = Nothing
    End If
            
    With wsTmp
        vWidgetKeys = GetTableWidgetKeys(sTableName)
        
        For i = 0 To UBound(vWidgetKeys)
            CreateTableColumn wsTmp, i + 1, sTableName, dDefinitions.Item(vWidgetKeys(i)).Item("FieldName"), wbTmp:=clsAppRuntime.CacheBook, vDataID:=vDataID
        Next i
        
        iCol = i + 1
        For i = iCol To iCol + UBound(aDefaultFields)
            CreateTableColumn wsTmp, i, sTableName, aDefaultFields(i - iCol), _
                wbTmp:=clsAppRuntime.CacheBook, vDataID:=vDataID, eColumnType:=ColumnType.INFO
        Next i

        ' create the range that stored the NextFree row
        Set rTarget = .Range(.Cells(1, i + 1), .Cells(1, i + 1))
        rTarget.value = 1
        sRangeName = "i" & sTableName & "NextFree"
        CreateTableColumn wsTmp, i + 1, sTableName, "NextFree", wbTmp:=clsAppRuntime.CacheBook, vDataID:=vDataID, eColumnType:=ColumnType.INFO
                
        FuncLogIt sFuncName, "Created db table [" & sTableName & "] with [" & CStr(i + 1) & "] columns", C_MODULE_NAME, LogMsgType.INFO
    End With

    Set CreateTable = wsTmp
                
End Function

Public Sub CreateTables(Optional wbTmp As Workbook, _
                        Optional bShowFilter As Boolean = False)

Dim dTables As Dictionary
Dim sTableName As Variant
Dim sFieldName As String
Dim sFuncName As String
Dim iCount As Integer
Dim wsTmp
setup:
    sFuncName = C_MODULE_NAME & "." & "CreateTables"

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    If dDefinitions Is Nothing Then
        DoLoadDefinitions
    End If
    
    Set dTables = dDefinitions.Item("tables")
    For Each sTableName In dTables.Keys()
        iCount = iCount + 1
        CreateTable CStr(sTableName), wbTmp:=wbTmp, bShowFilter:=bShowFilter
        
    Next sTableName

    FuncLogIt sFuncName, "Created [" & CStr(iCount) & "] tables", C_MODULE_NAME, LogMsgType.INFO

End Sub
