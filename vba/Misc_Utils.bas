Attribute VB_Name = "Misc_Utils"
Enum MyVbType

    vbEmpty = 0 'Empty (uninitialized)
    vbNull = 1 'Null (no valid data)
    vbInteger = 2 'Integer
    vbLong = 3 'Long integer
    vbSingle = 4 'Single-precision floating-point number
    vbDouble = 5 'Double-precision floating-point number
    vbCurrency = 6 'Currency value
    vbDate = 7 'Date value
    vbString = 8 'String
    vbObject = 9 'Object
    vbError = 10 'Error value
    vbBoolean = 11 'Boolean value
    vbVariant = 12 'Variant (used only witharrays of variants)
    vbDataObject = 13 'A data access object
    vbDecimal = 14 'Decimal value
    vbByte = 17 'Byte value
    vbLongLong = 20 'LongLong integer (Valid on 64-bit platforms only.)
    vbDict = 24
    vbIntArray = 26
    vb2DIntArray2Columns = 27
    vb2DIntArray3Columns = 28
    vb2DIntArray4Columns = 29
    vbStringArray = 46
    vbStringArray2Columns = 47
    vbStringArray3Columns = 48
    vbStringArray4Columns = 49
    vbStringArray6Columns = 51
    vbStringArray8Columns = 53
    vbVariantArray = 66
    vbVariantArray2Columns = 67
    vbVariantArray3Columns = 68
    vbVariantArray4Columns = 69
    
    vbQuadRuntime = 100

    vbUserDefinedType = 36 'Variants that contain user-defined types
    vbArray = 8192  'Array
    
End Enum

Public Sub EventsToggle(bStatus As Boolean)
    Application.EnableEvents = bStatus
    Application.ScreenUpdating = bStatus
End Sub

Function IsQuadRuntime(obj As Variant) As Boolean
    On Error GoTo err
    If obj.IsAQuadRuntime = True Then
        IsQuadRuntime = True
        Exit Function
    End If
    
    On Error GoTo 0
    Exit Function
err:
    IsQuadRuntime = False
    
End Function
Function IsDict(dTmp As Variant) As Boolean
    IsDict = True
    On Error GoTo err
    If dTmp.Count > -1 Then
    End If
    dTmp.Add "somethingthatsunlikelytoexist", "bar"
    If dTmp.Item("somethingthatsunlikelytoexist") <> "bar" Then
        GoTo err
    End If
    dTmp.Remove "somethingthatsunlikelytoexist"
    On Error GoTo 0
    Exit Function
err:
    IsDict = False
End Function

#If VBA7 Then
Function GetObj(ByVal lObjectPointer As LongPtr) As Object
#Else
Function GetObj(ByVal lObjectPointer As Long) As Object
#End If

    Dim obj As Object

    Call CopyMemory(obj, lObjectPointer, LenB(lObjectPointer))

    Set GetObj = obj
    Set obj = Nothing
End Function


Function MyVarType(vObject As Variant) As Integer
Dim iSubType As Integer
    Select Case VarType(vObject)
        Case 9
            If IsDict(vObject) Then
                MyVarType = 24
                Exit Function
            ElseIf IsQuadRuntime(vObject) Then
                MyVarType = 100
                Exit Function
            End If
        Case Is >= 8192
            iSubType = VarType(vObject) - 8192
            Select Case iSubType
                Case 2
                    MyVarType = 25 + NumColumns(vObject, bAssert:=False)
                Case 8
                    MyVarType = 45 + NumColumns(vObject, bAssert:=False)
                Case 12
                    MyVarType = 65 + NumColumns(vObject, bAssert:=False)
                Case Else
                    MyVarType = 8192
            End Select
            Exit Function
    End Select

    MyVarType = VarType(vObject)

End Function
Function EnumVarType(i As Long) As String

    If i = 36 Then
        EnumVarType = "vbUserDefinedType"
    ElseIf i = 8192 Then
        EnumVarType = "vbArray"
    ElseIf i >= 25 And i < 45 Then
        EnumVarType = "vb2DIntArray" & CStr(i - 24) & "Columns"
    ElseIf i >= 45 And i < 65 Then
        EnumVarType = "vb2DStringArray" & CStr(i - 44) & "Columns"
    ElseIf i >= 65 And i < 85 Then
        EnumVarType = "vb2DVariantArray" & CStr(i - 64) & "Columns"
    ElseIf i >= 0 And i < 25 Then
        EnumVarType = Array("vbEmpty", "vbNull", "vbInteger", "vbLong", "vbSingle", _
                            "vbDouble", "vbCurrency", "vbDate", "vbString", "vbObject", _
                            "vbError", "vbBoolean", "vbVariant", "vbDataObject", "vbDecimal", _
                            "", "", "", "", "vbByte", "", "", "", "vbLongLong", _
                            "vbDict", "vbIntArray", "vbStringArray", "vbVariantArray")(i)
    ElseIf i = 100 Then
        EnumVarType = "vbQuadRuntime"
    Else
        err.Raise 102, Description:=" VarType enum [" & CStr(i) & "] is not recognised"
    End If
End Function

Public Function IsEqual(vValue1 As Variant, vValue2 As Variant, _
    Optional sFuncName As String = "Unknown", _
    Optional bAssert As Boolean = True) As Boolean
    
    If vValue1 <> vValue2 Then
        IsEqual = False
        
        If bAssert = True Then
            err.Raise 101, Description:="[" & sFuncName & "] value1 and 2 are not equal [" & CStr(UBound(vValue1)) & "] [" & CStr(UBound(vValue2)) & "]"
        End If
        Exit Function
    End If
    
    IsEqual = True
        
End Function

Public Function IsInstance(oTmp As Variant, tObjType As MyVbType, _
            Optional sFuncName As String = "Unknown", _
            Optional bAssert As Boolean = True) As Boolean
            
    If MyVarType(oTmp) <> tObjType Then
        IsInstance = False
        
        If bAssert = True Then
            err.Raise 101, Description:="[" & sFuncName & "] object is not of type [" & EnumVarType(tObjType) & "] got [" & EnumVarType(VarType(oTmp)) & "]"
        End If
        Exit Function
    End If

    IsInstance = True
End Function
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
Public Function EncodeBase64(Text As String) As String
Dim arrData() As Byte
Dim objXML As MSXML2.DOMDocument
Dim objNode As MSXML2.IXMLDOMElement
  
  arrData = StrConv(Text, vbFromUnicode)
  Set objXML = New MSXML2.DOMDocument
  Set objNode = objXML.createElement("b64")

  objNode.DataType = "bin.base64"
  objNode.nodeTypedValue = arrData
  EncodeBase64 = objNode.Text

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
    objNode.Text = strData
    DecodeBase64 = objNode.nodeTypedValue
    
    ' thanks, bye
    Set objNode = Nothing
    Set objXML = Nothing
End Function
'Public Function IsSet(oTmp As Object) As Boolean
Public Function IsSet(oTmp As Variant) As Boolean

    If IsInstance(oTmp, vbObject, bAssert:=False) = True Then
        If oTmp Is Nothing Then
            IsSet = False
            Exit Function
        End If
    End If
        
    If IsEmpty(oTmp) Or IsMissing(oTmp) Then
        IsSet = False
        Exit Function
    End If

istrue:
    IsSet = True
End Function
Public Function UUEncode(sValue As String) As String
    UUEncode = Application.WorksheetFunction.EncodeURL(sValue)
End Function

Public Function UUDecode(sValue As String) As String

Dim TempAns As String
Dim CurChr As Integer

CurChr = 1

    Do Until CurChr - 1 = Len(sValue)
        Select Case Mid(sValue, CurChr, 1)
            Case "+"
                TempAns = TempAns & " "
            Case "%"
                TempAns = TempAns & Chr(Val("&h" & Mid(sValue, CurChr + 1, 2)))
                CurChr = CurChr + 2
            Case Else
                TempAns = TempAns & Mid(sValue, CurChr, 1)
        End Select

        CurChr = CurChr + 1
    Loop

UUDecode = TempAns
End Function

