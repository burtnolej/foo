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

Const C_DB_DEFAULT_FIELDS = "CreatedTime,LastUpdatedTime,ID"

Public Function CalcCreatedTime(sTableName As String) As Date
    CalcCreatedTime = Now()
End Function
Public Function CalcLastUpdatedTime(sTableName As String) As Date
    CalcLastUpdatedTime = Now()
End Function
Public Function CalcID(sTableName As String) As Integer
    CalcID = ActiveWorkbook.Sheets(sTableName).Range("i" & sTableName & "NextFree").Value
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

Public Function GetDBColumnRange(ByVal sTableName, sFieldName) As String
Dim sLookUpTableName As String
    If Left(sTableName, 1) = "&" Then
        sTableName = Right(sTableName, Len(sTableName) - 5)
    End If
    
    GetDBColumnRange = "db" & sTableName & sFieldName
End Function
Public Function GetTableRecord(sTableName As String, iID As Integer) As Dictionary
Dim sFuncName As String
Dim i As Integer
Dim wsTable As Worksheet
Dim sKey As Variant
Dim dDefnDetails As Dictionary
Dim sColRange As String
Dim dRecord As New Dictionary
Dim sFieldName As String
Dim sFieldValue As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetTableRecord"
    Set wsTable = GetSheet(ActiveWorkbook, sTableName)
    
main:
    With wsTable
        For Each sKey In dDefinitions.Keys()
            If dDefinitions.Item(sKey).Exists("db_table_name") = False Then
                FuncLogIt sFuncName, "entry [" & sKey & "] does not have a \'db_table_name\' record", C_MODULE_NAME, LogMsgType.Error
                Exit Function
            End If
            
            If dDefinitions.Item(sKey).Item("db_table_name") = sTableName Then
                Set dDefnDetails = dDefinitions.Item(sKey)
                sFieldName = dDefnDetails.Item("db_field_name")
                sColRange = GetDBColumnRange(sTableName, sFieldName)
                sFieldValue = wsTable.Range(sColRange).Rows(iID + 1)
                dRecord.Add sFieldName, sFieldValue
            End If
        Next sKey
    End With

    FuncLogIt sFuncName, "retreived [" & CStr(UBound(dRecord.Keys()) + 1) & "] fields from id [" & CStr(iID) & "] from table [" & sTableName & "]", C_MODULE_NAME, LogMsgType.OK
    
    Set GetTableRecord = dRecord
End Function
Public Function AddTableRecordAuto(wbTmp As Workbook, sTableName As String, _
        vColNames() As String, vRows() As String, _
        Optional bAddDefaultFields As Boolean = True, Optional bBulkLoad As Boolean = False) As Integer
' add 1 or more records to a "table"; used for bulk load from db or for creating tests
' assumes records are "valid", all values need to be passed in as arguments
' can provide a database table as the source
' also flag that allows assumption columns are in the same order as the table so can be written to sheet in 1 write
' param: sColumnNames, String Array; index for sRows retreived from posn in this list
' param: sRows, String Array 2d ; data rows
' param: sTableName, String; can derive the sheet that the rows need to be added to
Dim sKey As Variant, sDetailKey As Variant, sSheetName As String, sColRange As String, sFuncName As String
Dim dDetail As Dictionary
Dim iRowCount As Integer, iColCount As Integer, iNextFree As Integer, iDefaultFieldCount As Integer
Dim iMaxRow As Integer, iMaxCol As Integer
Dim wsTable As Worksheet
Dim rTarget As Range
Dim aDefaultFields() As String

    ' ASSERTIONS ---------------------------------------------------------

    If Is2DArray(vRows) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg is not of type 2D string array"
    End If
    
    If IsInstance(vColNames, vbStringArray) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg is not of type string array"
    End If

    If UBound(vColNames) <> UBound(vRows, 2) Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="col description array must have 1 item per column in rows array"
    End If
    ' END ASSERTIONS ------------------------------------------------------

setup:
    sFuncName = C_MODULE_NAME & "." & "AddTableRecordAuto"
    Set wsTable = GetSheet(wbTmp, sTableName)
    aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
        
main:

    If bBulkLoad = False Then
        iNextFree = wsTable.Range("i" & sTableName & "NextFree").Value + 1
            
        For iRowCount = 0 To UBound(vRows)
            For iColCount = 0 To UBound(vRows, 2)
                sColRange = GetDBColumnRange(sTableName, vColNames(iColCount))
                wsTable.Range(sColRange).Rows(iNextFree) = vRows(iRowCount, iColCount)
            Next iColCount
    
            For iDefaultFieldCount = 0 To UBound(aDefaultFields)
                sColRange = GetDBColumnRange(sTableName, aDefaultFields(iDefaultFieldCount))
                wsTable.Range(sColRange).Rows(iNextFree) = Application.Run("Calc" & aDefaultFields(iDefaultFieldCount), sTableName)
            Next iDefaultFieldCount
            wsTable.Range("i" & sTableName & "NextFree").Value = iNextFree
            iNextFree = iNextFree + 1
            
        Next iRowCount
    Else
        If bAddDefaultFields = True Then
            ' add default columns to array and calc values
        End If
        iMaxRow = UBound(vRows)
        iMaxCol = UBound(vColNames)
        With wsTable
            Set rTarget = .Range(.Cells(1, 1), .Cells(iMaxRow + 1, iMaxCol + 1))
            rTarget = vRows
        End With
        
    End If
    
End Function

Public Function AddTableRecord(sTableName As String) As Integer
Dim sKey As Variant
Dim dDefnDetails As Dictionary
Dim wsTmp As Worksheet
Dim iNextFree As Integer
Dim sColRange As String
Dim wsTable As Worksheet
Dim aDefaultFields() As String
Dim sFuncName As String
Dim i As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "AddTableRecord"
    Set wsTmp = GetSheet(ActiveWorkbook, "New" & sTableName)
    Set wsTable = GetSheet(ActiveWorkbook, sTableName)
    
main:
    With wsTmp
        iNextFree = wsTable.Range("i" & sTableName & "NextFree").Value + 1
        
        For Each sKey In dDefinitions.Keys()
            If dDefinitions.Item(sKey).Exists("db_table_name") = False Then
                FuncLogIt sFuncName, "entry [" & sKey & "] does not have a \'db_table_name\' record", C_MODULE_NAME, LogMsgType.Error
                Exit Function
            End If
            
            If dDefinitions.Item(sKey).Item("db_table_name") = sTableName Then
                Set dDefnDetails = dDefinitions.Item(sKey)
                sColRange = GetDBColumnRange(sTableName, dDefnDetails.Item("db_field_name"))

                If NamedRangeExists(ActiveWorkbook, sTableName, sColRange) = False Then
                    AddTableRecord = -1
                    FuncLogIt sFuncName, "range [" & sColRange & "] does not exist in sheet [" & sTableName & "]", C_MODULE_NAME, LogMsgType.OK
                    Exit Function
                End If
                
                wsTable.Range(sColRange).Rows(iNextFree) = .Range(dDefnDetails.Item("address")).Value
            End If
        Next sKey
        
        aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
        For i = 0 To UBound(aDefaultFields)
            sColRange = GetDBColumnRange(sTableName, aDefaultFields(i))
            wsTable.Range(sColRange).Rows(iNextFree) = Application.Run("Calc" & aDefaultFields(i), sTableName)
            'Application.Run "Format" & aDefaultFields(i), wsTmp, wsTable.Range(sColRange).Rows(iNextFree)
        Next i
    End With
    
    FuncLogIt sFuncName, "record id [" & CStr(iNextFree + 1) & "] added to table [" & sTableName & "]", C_MODULE_NAME, LogMsgType.OK
    
    wsTable.Range("i" & sTableName & "NextFree").Value = iNextFree
    
err:
    
End Function
Public Sub CreateTableColumn(wsTmp As Worksheet, iCol As Integer, sTableName As String, sFieldName As String)
Dim rColumn As Range
Dim sRangeName As String

    With wsTmp
        .Range(.Cells(1, iCol), .Cells(1, iCol)).Value = sFieldName
        Set rColumn = .Range(.Cells(1, iCol), .Cells(10000, iCol))
    End With
    
    sRangeName = "db" & sTableName & sFieldName
    CreateNamedRange ActiveWorkbook, rColumn.Address, wsTmp.Name, sRangeName, "True"
End Sub
Public Function CreateTable(sTableName As String) As Worksheet
Dim iCol As Integer
Dim dDefnDetail As Dictionary
Dim vSource() As String
Dim rTarget As Range
Dim wsTmp As Worksheet
Dim sKey As Variant
Dim aDefaultFields() As String
Dim i As Integer
Dim sRangeName As String
Dim sFuncName As String
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=False
    
    sFuncName = C_MODULE_NAME & "." & "CreateTable"
    
    Set wsTmp = CreateSheet(ActiveWorkbook, CStr(sTableName), bOverwrite:=True)
    wsTmp.Visible = xlSheetHidden
    
    aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")

    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsQuadRuntime:=clsQuadRuntime
    End If
    
    With wsTmp
        For Each sKey In dDefinitions.Keys()
            If dDefinitions.Item(sKey).Item("db_table_name") = sTableName Then
                Set dDefnDetail = dDefinitions.Item(sKey)
                iCol = iCol + 1
                CreateTableColumn wsTmp, iCol, sTableName, dDefinitions.Item(sKey).Item("db_field_name")
            End If
        Next sKey
        iCol = iCol + 1
        For i = iCol To iCol + UBound(aDefaultFields)
            CreateTableColumn wsTmp, i, sTableName, aDefaultFields(i - iCol)
        Next i

        Set rTarget = .Range(.Cells(1, i + 1), .Cells(1, i + 1))
        rTarget.Value = 1
        sRangeName = "i" & sTableName & "NextFree"
        CreateNamedRange ActiveWorkbook, rTarget.Address, wsTmp.Name, sRangeName, "True"
        
        FuncLogIt sFuncName, "Created db table [" & sTableName & "] with [" & CStr(i + 1) & "] columns", C_MODULE_NAME, LogMsgType.INFO
    End With

    Set CreateTable = wsTmp
                
End Function

Public Sub CreateTables()

Dim dTables As Dictionary
Dim sTableName As Variant
Dim sFieldName As String
Dim sFuncName As String
Dim iCount As Integer
Dim wsTmp
setup:
    sFuncName = C_MODULE_NAME & "." & "CreateTables"

    If dDefinitions Is Nothing Then
        DoLoadDefinitions
    End If
    
    Set dTables = dDefinitions.Item("tables")
    For Each sTableName In dTables.Keys()
        iCount = iCount + 1
        CreateTable CStr(sTableName)
        
    Next sTableName

    FuncLogIt sFuncName, "Created [" & CStr(iCount) & "] tables", C_MODULE_NAME, LogMsgType.INFO

End Sub
