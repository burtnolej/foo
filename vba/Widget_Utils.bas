Attribute VB_Name = "Widget_Utils"
'Sub FormatButton(sTargetSheetName As String, rButton As Range, eButtonState As ButtonState, Optional sSourceSheetName As String = C_CELL_STYLES_SHEET)
Const C_CELL_STYLES_SHEET = "CellStyles"

Enum WidgetRefCellNames
    fButtonInvalid = 1
    fButtonValid = 2
    fButtonPressed = 3
End Enum

Const C_WIDGET_REF_CELL_NAMES = "fButtonInvalid,fButtonValid,fButtonPressed"

Enum CellState
    Invalid = 1
    Pressed = 2
    Valid = 3
End Enum

Const C_CELL_STATE = "Invalid,Pressed,Valid"

Enum CellType
    Button = 1
    Entry = 2
End Enum

Enum CellDimension
    Hz = 1
    Vz = 2
End Enum

Const C_CELL_TYPE_STATE = "Button,Entry"

Public Function GetCellSizes(wsTemplate As Worksheet, _
                             rSource As Range, _
                    Optional eCellDim As CellDimension = CellDimension.Hz) As Integer()
Dim aSizes() As Integer
Dim rCell As Range, rNewRange As Range
Dim iWidth As Integer, iHeight As Integer, iSizeCount As Integer
    GetRangeDimensions rSource, iWidth, iHeight
    
    ReDim aSizes(0 To 50)
    With wsTemplate
        .Activate
        Set rNewRange = rSource.Resize(iHeight, iWidth)
        
        If eCellDim = Hz Then
            For Each rCell In rNewRange.Rows(1).Cells
                aSizes(iSizeCount) = rCell.EntireColumn.ColumnWidth
                iSizeCount = iSizeCount + 1
            Next rCell
        Else
            For Each rCell In rNewRange.Columns(1).Cells
                aSizes(iSizeCount) = rCell.EntireRow.RowHeight
                iSizeCount = iSizeCount + 1
            Next rCell
        End If
        ReDim Preserve aSizes(0 To iSizeCount - 1)
    End With
    
    GetCellSizes = aSizes
End Function

Public Function GetCellColWidthsORig(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
Dim aColumnWidths() As Integer
Dim rCell As Range

    ReDim aColumnWidths(0 To 20)
    With clsQuadRuntime.TemplateSheet
        .Activate
        For Each rCell In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rCell.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rCell
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetCellColWidths = aColumnWidths
End Function


Public Sub FormatCell(wbSourceBook As Workbook, _
                        wbTargetbook As Workbook, _
                        sTargetSheetName As String, _
                        rCell As Range, _
                        eCellState As CellState, _
                        sSourceSheetName As String, _
               Optional eCellType As CellType = CellType.Button)
Dim eWRefCName As String
    eWRefCName = "f" & Split(C_CELL_TYPE_STATE, COMMA)(eCellType - 1) & Split(C_CELL_STATE, COMMA)(eCellState - 1)
    CopyFormat wbSourceBook, wbTargetbook, sSourceSheetName, sTargetSheetName, eWRefCName, rCell.Address
End Sub

'add format EntryCell here to copy formats for entry cells

'Public Function GetScheduleCellColWidths(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
'                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell


Public Sub FormatColRowSize(wbSourceBook As Workbook, _
                            wbTargetbook As Workbook, _
                            sTargetSheetName As String, _
                            sSourceSheetName As String, _
                            sSourceRangeName As String, _
                   Optional iTargetFirstRow As Integer = 1, _
                   Optional iTargetFirstCol As Integer = 1)

Dim aColumnWidths() As Integer, aRowHeights() As Integer
Dim iColWidthCount As Integer, iRowHeightCount As Integer, iRow As Integer, iCol As Integer, iFormatRowCount As Integer, iFormatColCount As Integer
Dim rCell As Range, rTargetRange As Range, rSourceRange As Range
Dim wsTemplateSheet As Worksheet, wsTargetSheet As Worksheet

    Set wsTargetSheet = wbTargetbook.Sheets(sTargetSheetName)
    Set wsTemplateSheet = wbSourceBook.Sheets(sSourceSheetName)
    
    Set rSourceRange = wsTemplateSheet.Range(sSourceRangeName)
    
    aColumnWidths = GetCellSizes(wsTemplateSheet, rSourceRange)
    aRowHeights = GetCellSizes(wsTemplateSheet, rSourceRange, eCellDim:=CellDimension.Vz)
    
    With wsTargetSheet
        Set rTargetRange = .Range(.Cells(iTargetFirstRow, iTargetFirstCol), _
                    .Cells(iTargetFirstRow + UBound(aRowHeights), _
                           iTargetFirstCol + UBound(aColumnWidths)))
    End With
    
    'rTargetRange.Select
    For iRow = 1 To UBound(aRowHeights) + 1
        rTargetRange.Rows(iRow).EntireRow.RowHeight = aRowHeights(iRow - 1)
    Next iRow
    
    For iCol = 1 To UBound(aColumnWidths) + 1
        rTargetRange.Columns(iCol).EntireColumn.ColumnWidth = aColumnWidths(iCol - 1)
    Next iCol
End Sub
