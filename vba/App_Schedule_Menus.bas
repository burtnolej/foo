Attribute VB_Name = "App_Schedule_Menus"
Option Explicit
Function GetScheduleMenuContent(control As IRibbonControl, ByRef returnedVal)
Dim xml As String, sDataSubType As String, sScope As String
Dim rSelection As Range
Dim wsPersonDataCache As Worksheet
Dim rColumns As Range, rRow As Range
Dim aXMLElement() As String, aXMLElementAttr() As String, aXMLRootElementAttr() As String
Dim iNumNodes As Integer, iMaxNumNodes As Integer
Dim xDoc As MSXML2.DOMDocument
Dim sName As String

    sDataSubType = "student"
    sScope = "all"

    Set wsPersonDataCache = GetPersonData(Quad_Utils.sBookName, Quad_Utils.sCacheBookPath, sDataSubType, sScope:=sScope, sCacheBookName:=Quad_Utils.sCacheBookName)

    With wsPersonDataCache
        Set rColumns = .Range("data").Resize(1)
        iMaxNumNodes = .Range("data").Rows.Count - 1
        ReDim aXMLElement(0 To iMaxNumNodes - 1, 0 To 1)
        ReDim aXMLElementAttr(0 To iMaxNumNodes - 1, 0 To 7)
    
        aXMLRootElementAttr = Init2DStringArray([{"xmlns","http://schemas.microsoft.com/office/2009/07/customui";"",""}])
                                 
        For Each rRow In .Range("data").Offset(1).Resize(.Range("data").Rows.Count - 1).Rows
            If rRow.Columns(5).Value = "Photon" Then
                aXMLElement(iNumNodes, 0) = "button"
                aXMLElementAttr(iNumNodes, 0) = "id"
                aXMLElementAttr(iNumNodes, 1) = "SchedBut_" & sDataSubType & "_" & CStr(rRow.Columns(3))
                aXMLElementAttr(iNumNodes, 2) = "imageMso"
                aXMLElementAttr(iNumNodes, 3) = "Help"
                aXMLElementAttr(iNumNodes, 4) = "label"
                aXMLElementAttr(iNumNodes, 5) = rRow.Columns(1).Value & " " & rRow.Columns(2).Value
                aXMLElementAttr(iNumNodes, 6) = "onAction"
                aXMLElementAttr(iNumNodes, 7) = "onAction"
                iNumNodes = iNumNodes + 1
            End If
        Next rRow
        
        aXMLElement = ReDim2DArray(aXMLElement, iNumNodes - 1, 2)
        aXMLElementAttr = ReDim2DArray(aXMLElementAttr, iNumNodes - 1, 8)
        
        Set xDoc = CreateXMLDocfromArray(aXMLElement, aXMLElementAttr:=aXMLElementAttr, sRootName:="menu", aXMLRootElementAttr:=aXMLRootElementAttr)
        returnedVal = xDoc.xml
    End With
End Function
