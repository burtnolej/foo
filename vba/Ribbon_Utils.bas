Attribute VB_Name = "Ribbon_Utils"
Option Explicit
Const C_MODULE_NAME = "Ribbon_Utils"

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
Dim checkVal As Boolean
Dim ListItemsRg As Range
Dim dStartDate As Double
Public Sub getPressed(control As IRibbonControl, ByRef returnedVal)
'
' Code for getPressed callback. Ribbon control checkBox
'
    If control.ID = "checkboxShowMessage" Then
        returnedVal = checkVal
    End If
End Sub
Public Sub GetText(control As IRibbonControl, ByRef returnedVal)
Dim iIndex As Integer
Dim dControlValues As Dictionary

    Set dControlValues = GetControlValues()
    returnedVal = dControlValues.Item(control.ID)

End Sub
Function GetControlValues(Optional ByRef vControls As Variant) As Dictionary
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
        vControls(iControlCount) = rCell.Value
        iControlCount = iControlCount + 1
    Next rCell
    
    ReDim Preserve vControls(0 To iControlCount - 1)
    
    For i = 0 To UBound(vControls)
        dControlValues.Add vControls(i), rRibValues.Rows(i + 1).Value
    Next i
    
    Set GetControlValues = dControlValues
End Function
Public Sub OnChange(control As IRibbonControl, text As Variant, Optional sControlID As String)
Dim dReturnVal As Double
Dim iIndex As Integer
Dim vControls() As Variant
Dim dControlValues As Dictionary
Dim rRibValues As Range

    With ActiveWorkbook.Sheets("config")
        Set rRibValues = .Range("ribbon_Values")
    End With
    
    Set dControlValues = GetControlValues(vControls)
    
    ' this is so we can overide the control whose persisted value gets updated
    If sControlID = BLANK Then
        sControlID = CStr(control.ID)
    End If
    
    iIndex = IndexArray(vControls, sControlID)
    
    If text = " False" Then
            rRibValues.Rows(iIndex + 1).Value = "False"
    ElseIf text = "True" Then
            rRibValues.Rows(iIndex + 1).Value = "True"
    ElseIf text = "False" Then
            rRibValues.Rows(iIndex + 1).Value = "True"
    Else
            rRibValues.Rows(iIndex + 1).Value = text
    End If
End Sub

Sub OnAction(control As IRibbonControl, Optional bCheckbox As Boolean)
Dim dControlValues As Dictionary
Dim wsTmp As Worksheet
Dim rSource As Range
Dim sFuncName As String
Dim vControls() As Variant

setup:
    sFuncName = "OnAction"
    GetLogFile

    On Error GoTo err
    If control.ID = "LoadDefinitions" Then
        DoLoadDefinitions
        DumpDefinitions
    ElseIf control.ID = "GenerateEntryForm" Then
        GenerateEntryForms
    ElseIf control.ID = "DeleteEntryForm" Then
        DeleteEntryForms
    ElseIf control.ID = "Student" Then
        HideAllEntryForms
        ShowEntryForm "Student"
    ElseIf control.ID = "Teacher" Then
        HideAllEntryForms
        ShowEntryForm "Teacher"
    ElseIf control.ID = "FormStyles" Then
        ToggleSheet ActiveWorkbook, "FormStyles"
    ElseIf control.ID = "Definitions" Then
        ToggleSheet ActiveWorkbook, "Definitions"
    ElseIf control.ID = "CellStyles" Then
        ToggleSheet ActiveWorkbook, "CellStyles"
        
        
    ' Tab: Admin
    ElseIf control.ID = "DoBackups" Then
        BackupModules
    ElseIf control.ID = "GetProcs" Then
        DumpProcs
    ElseIf control.ID = "ViewLogs" Then
        DoViewLogs
    ElseIf control.ID = "RefreshRibbon" Then
        RefreshRibbon
    
    ' Group: Config
    ElseIf control.ID = "DecodeFlag" Then
        OnChange control, str(bCheckbox)
        'If checkVal = True Then
    ElseIf control.ID = "ImportQuery" Then
        OnChange control, GetQueryFromRange, "QueryString"
        RefreshRibbon ' so that the Ribbon entry gets updated
    ' Group: Database Actions
    ElseIf control.ID = "Insert" Then
        Set dControlValues = GetControlValues(vControls)
        DoInsertDBRows ActiveSheet, Selection, dControlValues.Item("DatabaseName"), _
                    dControlValues.Item("TableName"), dControlValues.Item("DecodeFlag")
        ', bDecodeFlag:=True
    Else
        GoTo fail
    End If
    On Error GoTo 0
    
    FuncLogIt sFuncName, "Control element ID in [" & control.ID & "]", C_MODULE_NAME, LogMsgType.OK
    GoTo exitsub
    
fail:
    FuncLogIt sFuncName, "Could not find an action for  in [" & control.ID & "] definitions", C_MODULE_NAME, LogMsgType.FAILURE
    GoTo exitsub

err:
    FuncLogIt sFuncName, "message [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
    GoTo exitsub

exitsub:
    CloseLogFile
    
End Sub

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
Sub ribbonLoaded(ribbon As IRibbonUI)
    Set rib = ribbon ''We capture the ribbon variable for later use, specifically to invalidate it.  When you invalidate the ribbon Excel recreates it.
    ActiveWorkbook.Sheets("config").Cells(1, 10).Value = ObjPtr(rib)
End Sub
Public Sub RefreshRibbon()

    If rib Is Nothing Then
        Set rib = GetRibbon(ActiveWorkbook.Sheets("config").Cells(1, 10).Value)
    ' Else: Do nothing!
    End If

    'On Error Resume Next
    rib.Invalidate
    
    'On Error GoTo 0
End Sub



