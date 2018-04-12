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
