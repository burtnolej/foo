VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Quad_AddNew_Event"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public Event VariableChange(value As String)
Private p_str As String
Public Property Get value() As String
    value = p_str
End Property
Public Property Let value(value As String)
    If p_str <> value Then RaiseEvent VariableChange(value)
    p_str = value
End Property
