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

Const C_CELL_TYPE_STATE = "Button,Entry"

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
Dim iColWidthCount As Integer, iRowHeightCount As Integer, iRow As Integer, iCol As Integer
Dim rCell As Range, rTargetRange As Range, rSourceRange As Range
Dim wsTemplateSheet As Worksheet, wsTargetSheet As Worksheet

    Set wsTargetSheet = wbTargetbook.Sheets(sTargetSheetName)
    Set wsTemplateSheet = wbSourceBook.Sheets(sSourceSheetName)
    
    ReDim aColumnWidths(0 To 50)
    ReDim aRowHeights(0 To 50)
    
    With wsTemplateSheet
        '.Activate
        Debug.Print wsTemplateSheet.Name
        Set rSourceRange = .Range(sSourceRangeName)
        
        For Each rCell In rSourceRange.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rCell.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rCell
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    
        '.Activate
        For Each rCell In rSourceRange.Columns(1).Cells
            aRowHeights(iRowHeightCount) = rCell.EntireRow.RowHeight
            iRowHeightCount = iRowHeightCount + 1
        Next rCell
        ReDim Preserve aRowHeights(0 To iRowHeightCount - 1)
    End With
    
    With wsTargetSheet
        Set rTargetRange = .Range(.Cells(iTargetFirstRow, iTargetFirstCol), _
                    .Cells(iTargetFirstRow + iRowHeightCount - 1, iTargetFirstCol + iRowHeightCount - 1))
    End With
    
    For iRow = 1 To iRowHeightCount
        rTargetRange.Rows(iRow).EntireRow.RowHeight = aRowHeights(iRow - 1)
    Next iRow
    
    For iCol = 1 To iColWidthCount
        rTargetRange.Columns(iCol).EntireColumn.ColumnWidth = aColumnWidths(iCol - 1)
    Next iCol
End Sub
