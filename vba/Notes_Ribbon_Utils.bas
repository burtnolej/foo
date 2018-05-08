Attribute VB_Name = "Notes_Ribbon_Utils"
Option Explicit

#If VBA7 Then
    Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
        ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
#Else
    Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
        ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
#End If

Dim rib As IRibbonUI
Dim IndexOfSelectedItem As Integer
Dim sDatabaseName As String
Dim sTableName As String
Dim sDBDatabaseName As String
Dim sDBTableName As String
Dim sDBLoadRange As String
Dim sDBLoadSheet As String
Dim sFieldSelect As String
Dim ItemCount As Integer
Dim ListItemsRg As Range
Dim dStartDate As Double
Public Sub xxgetPressed(control As IRibbonControl, ByRef returnedVal)
'
' Code for getPressed callback. Ribbon control checkBox
'
    If control.id = "checkboxShowMessage" Then
        returnedVal = b_checkboxShowMessage
    End If
End Sub

Public Sub xxxGetText(control As IRibbonControl, ByRef returnedVal)
Dim iIndex As Integer
Dim dControlValues As Dictionary

    Set dControlValues = GetControlValues()
    returnedVal = dControlValues.Item(control.id)

End Sub
Public Sub xxxOnChange(control As IRibbonControl, Text As Variant)
Dim dReturnVal As Double
Dim iIndex As Integer
Dim vControls() As Variant
Dim dControlValues As Dictionary
Dim rRibValues As Range

    With ActiveWorkbook.Sheets("config")
        Set rRibValues = .Range("ribbon_Values")
    End With
    
    Set dControlValues = GetControlValues(vControls)
    
    iIndex = Application.Run("VBASource.xlsm!IndexArray", vControls, control.id)
    
    If control.id = "SetStartDate" Then
        rRibValues.Rows(iIndex + 1).value = Application.Run("VBASource.xlsm!GetSecsFromOrigin", Text, dReturnVal)
    ElseIf Text = " False" Then
            rRibValues.Rows(iIndex + 1).value = "False"
    ElseIf Text = "True" Then
            rRibValues.Rows(iIndex + 1).value = "True"
    ElseIf Text = "False" Then
            rRibValues.Rows(iIndex + 1).value = "True"
    Else
            rRibValues.Rows(iIndex + 1).value = Text
    End If
End Sub

Function xxxGetControlValues(Optional ByRef vControls As Variant) As Dictionary
Dim dControlValues As New Dictionary
Dim i As Integer
Dim rRibLabels As Range
Dim rRibValues As Range
Dim rCell As Range
Dim iControlCount As Integer

    ReDim vControls(0 To 1000)
    
    With ActiveWorkbook.Sheets("config")
        Set rRibLabels = .Range("ribbon_Labels")
        Set rRibValues = .Range("ribbon_Values")
    End With

    For Each rCell In rRibLabels.Cells
        vControls(iControlCount) = rCell.value
        iControlCount = iControlCount + 1
    Next rCell
    
    ReDim Preserve vControls(0 To iControlCount - 1)
    
    For i = 0 To UBound(vControls)
        dControlValues.Add vControls(i), rRibValues.Rows(i + 1).value
    Next i
    
    Set GetControlValues = dControlValues
End Function
Sub xxxxOnAction(control As IRibbonControl, Optional bCheckbox As Boolean)
Dim dControlValues As Dictionary

    Set dControlValues = GetControlValues()
    
    If control.id = "EventOnButton" Then
        Application.Run "VBASource.xlsm!EventsToggle", True
    ElseIf control.id = "LoadFiles" Then
        Application.Run "VBASource.xlsm!LoadDirToRange"
    ElseIf control.id = "LoadEmailsFromDB" Then
        Application.Run "VBASource.xlsm!DoLoadEmailFromDB", dControlValues.Item("SetFieldSelect"), dControlValues.Item("SetDatabaseName"), _
                                                        dControlValues.Item("SetTableName"), dControlValues.Item("SetStartDate"), _
                                                        dControlValues.Item("SetEndDate"), dControlValues.Item("SetKeyword"), _
                                                        dControlValues.Item("SetSender")
                                                        
    ElseIf control.id = "LoadEmailsFromOutlook" Then
        Application.Run "VBASource.xlsm!DoLoadEmailFromOutlook", dControlValues.Item("SetFieldSelect"), dControlValues.Item("SetDatabaseName"), _
                                                        dControlValues.Item("SetTableName"), dControlValues.Item("SetStartDate")
    ElseIf control.id = "GetTagsFromColumn" Then
        Application.Run "VBASource.xlsm!DoGetTagsFromColumn"
    ElseIf control.id = "UpdateTags" Then
        Application.Run "VBASource.xlsm!DoUpdateTags"
    ElseIf control.id = "LoadRange2DB" Then
        Application.Run "VBASource.xlsm!DoRange2DB", dControlValues.Item("SetDBDatabaseName"), dControlValues.Item("SetDBTableName"), _
                                                        dControlValues.Item("SetDBRange"), dControlValues.Item("SetDBSheet")
    ElseIf control.id = "UpdateRange2DB" Then
        Application.Run "VBASource.xlsm!DoUpdate2DB", dControlValues.Item("SetDBDatabaseName"), dControlValues.Item("SetDBTableName"), _
                                                        dControlValues.Item("SetDBRange"), dControlValues.Item("SetDBSheet")
    ElseIf control.id = "LookupInDB" Then
        Application.Run "VBASource.xlsm!DoLookupInDB", dControlValues.Item("SetDBDatabaseName"), dControlValues.Item("SetDBTableName"), _
                                                        dControlValues.Item("SetDBRange"), dControlValues.Item("SetDBSheet")
    ElseIf control.id = "Export2File" Then
        Application.Run "VBASource.xlsm!DoRange2File", ActiveWorkbook.ActiveSheet.name, ActiveWorkbook.name, Selection.Address, Selection.Column, Selection.Rows.Count, _
            CBool(dControlValues.Item("sheetUtils_SetEncode")), dControlValues.Item("sheetUtils_SetFileName"), dControlValues.Item("sheetUtils_SetDelim")
    ElseIf control.id = "SetEncode" Then
        OnChange control, str(bCheckbox)
    ElseIf control.id = "sheetUtils_SetEncode" Then
        OnChange control, str(bCheckbox)
    ElseIf control.id = "GotoBottom" Then
        Application.Run "VBASource.xlsm!ChangeFocus", "bottom", ActiveWorkbook.ActiveSheet.name
    ElseIf control.id = "ScrollUp" Then
        Application.Run "VBASource.xlsm!ScrollWindow", "up", ActiveWorkbook.ActiveSheet.name
    ElseIf control.id = "ScrollDown" Then
        Application.Run "VBASource.xlsm!ScrollWindow", "down", ActiveWorkbook.ActiveSheet.name
    ElseIf control.id = "ClearBelow" Then
        Application.Run "VBASource.xlsm!ClearContentsBelow", Selection, ActiveWorkbook.ActiveSheet.name
    ElseIf control.id = "ViewLogDir" Then
        Application.Run "VBASource.xlsm!LoadDirToRange", dControlValues.Item("SetDirName"), dControlValues.Item("SetLogSheet")
    End If

End Sub
''Excel calls this went it loads our workbook because our RibbonX
'' specified it:  onLoad="ribbonLoaded"
Sub xxxxribbonLoaded(ribbon As IRibbonUI)
    Set rib = ribbon ''We capture the ribbon variable for later use, specifically to invalidate it.  When you invalidate the ribbon Excel recreates it.
    'ActiveWorkbook.Sheets("config").Cells(1, 1).Value = ObjPtr(rib)
End Sub

''Called by sheet change event handler (module Sheet1) to make Excel recreate the ribbon
Sub xxxRedoRib()
    rib.Invalidate
End Sub

''=========Drop Down Code =========

''Callback for Dropdown getItemCount.
''Tells Excel how many items in the drop down.
Sub xxxxDDItemCount(control As IRibbonControl, ByRef returnedVal)
    With Range("ListRange")
        Set ListItemsRg = Range(.Cells(1), .Offset(.Rows.Count).End(xlUp))
        ItemCount = ListItemsRg.Rows.Count
        returnedVal = ItemCount
    End With
End Sub

''Callback for dropdown getItemLabel.
''Called once for each item in drop down.
''If DDItemCount tells Excel there are 10 items in the drop down
''Excel calls this sub 10 times with an increased "index" argument each time.
''We use "index" to know which item to return to Excel.
Sub xxxDDListItem(control As IRibbonControl, index As Integer, ByRef returnedVal)
    returnedVal = ListItemsRg.Cells(index + 1).value ''index is 0-based, our list is 1-based so we add 1.
End Sub

''Drop down change handler.
''Called when a drop down item is selected.
Sub xxxDDOnAction(control As IRibbonControl, id As String, index As Integer)
    ''All we do is note the index number of the item selected.
    ''We use this in sub DDItemSelectedIndex below to reselect the current
    ''item, if possible, after an invalidate.
    IndexOfSelectedItem = index
End Sub

''Returns index of item to display.
''To display current item after the drop down is invalidated.
Sub DDItemSelectedIndex(control As IRibbonControl, ByRef returnedVal)
    If IndexOfSelectedItem > ItemCount - 1 Then IndexOfSelectedItem = ItemCount - 1 ''In case list was shortened
    returnedVal = IndexOfSelectedItem
End Sub

''------- End DD Code --------

Function RibbonState() As Long
' is ribbon visible or not
Dim rib As Object
    RibbonState = (CommandBars("Ribbon").Controls(1).Height < 100)
    Set rib = CommandBars("Ribbon").Controls(1)
    
End Function
#If VBA7 Then
Function GetRibbon(ByVal lRibbonPointer As LongPtr) As Object
#Else
Function GetRibbon(ByVal lRibbonPointer As Long) As Object
#End If

    Dim objRibbon As Object

    Call CopyMemory(objRibbon, lRibbonPointer, LenB(lRibbonPointer))

    Set GetRibbon = objRibbon
    Set objRibbon = Nothing
End Function

Public Sub RefreshRibbon()

    If rib Is Nothing Then
        Set rib = GetRibbon(ActiveWorkbook.Sheets("config").Cells(10, 1).value)
    ' Else: Do nothing!
    End If

    'On Error Resume Next
    rib.Invalidate
    
    'On Error GoTo 0
End Sub





