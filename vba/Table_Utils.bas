Attribute VB_Name = "Table_Utils"
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

Public Function GetDBColumnRange(sTableName, sFieldName) As String
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

setup:
    sFuncName = C_MODULE_NAME & "." & "CreateTable"
    
    Set wsTmp = CreateSheet(ActiveWorkbook, CStr(sTableName), bOverwrite:=True)
    
    aDefaultFields = Split(C_DB_DEFAULT_FIELDS, ",")
    
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
