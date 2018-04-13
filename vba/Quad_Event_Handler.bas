VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Quad_Event_Handler"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private WithEvents AddNew As Quad_AddNew_Event
Attribute AddNew.VB_VarHelpID = -1
Private Sub AddNew_VariableChange(value As String) 'This is the event handler.

    
    'Select Case value
    '    Case 1:
    '        Application.Run "vba_source_new.xlsm!test_action"
    '    Case 2:
    '        MsgBox "here, 2!"
    '    Case Default:
    '        'Do Nothing
    'End Select
End Sub
Public Property Get EventVariable() As Quad_AddNew_Event
    Set EventVariable = AddNew
End Property
Public Property Let EventVariable(value As Quad_AddNew_Event)
    Set AddNew = value
End Property
