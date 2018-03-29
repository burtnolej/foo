Attribute VB_Name = "Widget_Utils"
'Sub FormatButton(sTargetSheetName As String, rButton As Range, eButtonState As ButtonState, Optional sSourceSheetName As String = C_CELL_STYLES_SHEET)
Const C_CELL_STYLES_SHEET = "CellStyles"

Enum WidgetRefCellNames
    fButtonInvalid = 1
    fButtonValid = 2
    fButtonPressed = 3
End Enum

Const C_WIDGET_REF_CELL_NAMES = "fButtonInvalid,fButtonValid,fButtonPressed"

Enum ButtonState
    Invalid = 1
    Pressed = 2
    Valid = 3
End Enum

Const C_BUTTON_STATE = "Invalid,Pressed,Valid"

Public Sub FormatButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                        sTargetSheetName As String, rButton As Range, eButtonState As ButtonState, _
                        sSourceSheetName As String)
Dim eWRefCName As String
    eWRefCName = "fButton" & Split(C_BUTTON_STATE, ",")(eButtonState - 1)
    CopyFormat wbSourceBook, wbTargetbook, sSourceSheetName, sTargetSheetName, eWRefCName, rButton.Address
End Sub
