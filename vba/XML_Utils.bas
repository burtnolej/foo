Attribute VB_Name = "XML_Utils"
Option Explicit
Const C_MODULE_NAME = "XML_Utils"

Function CreateXMLDocfromDict(dTmp As Dictionary) As MSXML2.DOMDocument
Dim vKey As Variant, vElement As Variant
Dim XMLDOC As New MSXML2.DOMDocument
Dim xRoot As IXMLDOMElement, xChild As IXMLDOMElement

    IsInstance dTmp, vbDict

    Set xRoot = XMLDOC.createElement("root")
    XMLDOC.appendChild xRoot
    
    For Each vKey In dTmp.Keys
        If IsInstance(dTmp.Item(vKey), vbVariantArray, bAssert:=False) = False Then
            Set xChild = XMLDOC.createElement(vKey)
            xChild.Text = dTmp.Item(vKey)
            xRoot.appendChild xChild
        Else
            For Each vElement In dTmp.Item(vKey)
                Set xChild = XMLDOC.createElement(vKey)
                xChild.Text = vElement
                xRoot.appendChild xChild
            Next vElement
        End If
    Next vKey
    
    Set CreateXMLDocfromDict = XMLDOC
End Function


Function CreateXMLDocfromArray(aXMLElement() As String, _
            Optional aXMLElementAttr As Variant, _
            Optional sRootName As String = "root", _
            Optional aXMLRootElementAttr As Variant) As MSXML2.DOMDocument
            
Dim vKey As Variant, vElement As Variant
Dim XMLDOC As New MSXML2.DOMDocument
Dim xRoot As IXMLDOMElement, xChild As IXMLDOMElement
Dim iNumElements As Integer, iMaxNumAttributes As Integer, i As Integer, j As Integer, iMaxNumRootAttributes As Integer
Dim sFuncName As String


setup:
    sFuncName = C_MODULE_NAME & ".CreateXMLDocfromArray"

    IsEqual UBound(aXMLElement), UBound(aXMLElementAttr)
    IsInstance aXMLElement, vbStringArray2Columns
    
    iNumElements = UBound(aXMLElement)
    iMaxNumAttributes = -1
    iMaxNumRootAttributes = -1
    
    If IsSet(aXMLElementAttr) Then
        If IsInstance(aXMLElementAttr, vbStringArray2Columns, bAssert:=False) = True Or _
            IsInstance(aXMLElementAttr, vbStringArray4Columns, bAssert:=False) = True Or _
            IsInstance(aXMLElementAttr, vbStringArray6Columns, bAssert:=False) = True Or _
            IsInstance(aXMLElementAttr, vbStringArray8Columns, bAssert:=False) = True Then
            iMaxNumAttributes = UBound(aXMLElementAttr, 2)
        Else
             err.Raise 101, Description:="[" & sFuncName & "] attribute array needs to have even number of columns and no more than 8"
        End If
    End If

    If IsSet(aXMLRootElementAttr) Then
        If IsInstance(aXMLRootElementAttr, vbStringArray2Columns, bAssert:=False) = True Or _
            IsInstance(aXMLRootElementAttr, vbStringArray4Columns, bAssert:=False) = True Or _
            IsInstance(aXMLRootElementAttr, vbStringArray6Columns, bAssert:=False) = True Or _
            IsInstance(aXMLRootElementAttr, vbStringArray8Columns, bAssert:=False) = True Then
            iMaxNumRootAttributes = UBound(aXMLRootElementAttr, 2)
        Else
             err.Raise 101, Description:="[" & sFuncName & "] attribute array needs to have even number of columns and no more than 8"
        End If
    End If
    
main:
    
    Set xRoot = XMLDOC.createElement(sRootName)
    XMLDOC.appendChild xRoot
    
    If iMaxNumRootAttributes <> -1 Then
        For j = 0 To iMaxNumRootAttributes Step 2
            If aXMLRootElementAttr(i, j) <> "" Then
                xRoot.setAttribute aXMLRootElementAttr(i, j), aXMLRootElementAttr(i, j + 1)
            End If
        Next j
    End If
    
    For i = 0 To iNumElements

        Set xChild = XMLDOC.createElement(aXMLElement(i, 0))
        xChild.Text = aXMLElement(i, 1)
        
        If iMaxNumAttributes <> -1 Then
            For j = 0 To iMaxNumAttributes Step 2
                If aXMLElementAttr(i, j) <> "" Then
                    xChild.setAttribute aXMLElementAttr(i, j), aXMLElementAttr(i, j + 1)
                End If
            Next j
        End If
        xRoot.appendChild xChild

    Next i
    
    Set CreateXMLDocfromArray = XMLDOC
End Function

