Attribute VB_Name = "Misc_Utils"
Public Sub EventsToggle(bStatus As Boolean)
    Application.EnableEvents = bStatus
    Application.ScreenUpdating = bStatus
End Sub

Public Sub DoEventsOn()
    EventsToggle True
End Sub
Public Sub DoEventsOff()
    EventsToggle False
End Sub
Public Function IsInt(iValue As Variant) As Boolean
Dim iTmp As Integer
    On Error GoTo err
    iTmp = iValue / 10
    IsInt = True
    On Error GoTo 0
    Exit Function
err:
    IsInt = False
    
End Function
Public Function IsBase64(sText As String)
Dim bResult As Boolean
Dim sRe As String
    sRe = "^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$"
    IsBase64 = DoRegEx(sText, sRe)
End Function
Public Function EncodeBase64(text As String) As String
Dim arrData() As Byte
Dim objXML As MSXML2.DOMDocument
Dim objNode As MSXML2.IXMLDOMElement
  
  arrData = StrConv(text, vbFromUnicode)
  Set objXML = New MSXML2.DOMDocument
  Set objNode = objXML.createElement("b64")

  objNode.DataType = "bin.base64"
  objNode.nodeTypedValue = arrData
  EncodeBase64 = objNode.text

  Set objNode = Nothing
  Set objXML = Nothing
End Function
Public Function DecodeBase64(ByVal strData As String) As Byte()
Dim objXML As MSXML2.DOMDocument
Dim objNode As MSXML2.IXMLDOMElement
    
    ' help from MSXML
    Set objXML = New MSXML2.DOMDocument
    Set objNode = objXML.createElement("b64")
    objNode.DataType = "bin.base64"
    objNode.text = strData
    DecodeBase64 = objNode.nodeTypedValue
    
    ' thanks, bye
    Set objNode = Nothing
    Set objXML = Nothing
End Function
