Attribute VB_Name = "Ribbon_Utils"
'Public Sub getPressed(control As IRibbonControl, ByRef returnedVal)
'Public Sub GetText(control As IRibbonControl, ByRef returnedVal)
'Function GetControlValues(Optional ByRef vControls As Variant) As Dictionary
'Public Sub OnChange(control As IRibbonControl, text As Variant, Optional sControlID As String)
'Sub OnAction(control As IRibbonControl, Optional bCheckbox As Boolean)
'Function RibbonState() As Long
'Sub ribbonLoaded(ribbon As IRibbonUI)
'Sub rxgal_getImage(control As IRibbonControl, ByRef returnedVal)
'Sub rxgal_getItemImage(control As IRibbonControl, index As Integer, ByRef returnedVal)
'Sub rxgal_getItemLabel(control As IRibbonControl, index As Integer, ByRef returnedVal)
'Sub rxgal_getItemCount(control As IRibbonControl, ByRef returnedVal)
'Sub GetContent(control As IRibbonControl, ByRef returnedVal)

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
' Code for getPressed callback. Ribbon control checkBox
    If control.id = "checkboxShowMessage" Then
        returnedVal = checkVal
    End If
End Sub
Public Sub GetText(control As IRibbonControl, ByRef returnedVal)
Dim iIndex As Integer
Dim dControlValues As Dictionary

    Set dControlValues = GetControlValues()
    returnedVal = dControlValues.Item(control.id)

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
        vControls(iControlCount) = rCell.value
        iControlCount = iControlCount + 1
    Next rCell
    
    ReDim Preserve vControls(0 To iControlCount - 1)
    
    For i = 0 To UBound(vControls)
        dControlValues.Add vControls(i), rRibValues.Rows(i + 1).value
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
        sControlID = CStr(control.id)
    End If
    
    iIndex = IndexArray(vControls, sControlID)
    
    If text = " False" Then
            rRibValues.Rows(iIndex + 1).value = "False"
    ElseIf text = " True" Then
            rRibValues.Rows(iIndex + 1).value = "True"
    ElseIf text = "False" Then
            rRibValues.Rows(iIndex + 1).value = "True"
    Else
            rRibValues.Rows(iIndex + 1).value = text
    End If
End Sub

Sub rxgal_Click(control As IRibbonControl, id As String, index As Integer)
'Call the macro that belong to the Label when you click on one of the labels
'Example: When you click on the first Label it run the macro named "macro_1"
    'On Error Resume Next
    
    Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True)
    'BuildSchedule clsQuadRuntime, _
    '                eQuadSubDataType:=GetQuadSubDataTypeEnumFromValue(id), _
    '                iPersonID:=CInt(aControlIDSplit(2))

    'Application.Run "macro_" & Format(index + 1, "00")
    'On Error GoTo 0
End Sub

Sub OnAction(control As IRibbonControl, Optional bCheckbox As Boolean)
Dim dControlValues As Dictionary
Dim wsTmp As Worksheet
Dim rSource As Range
Dim sFuncName As String
Dim vControls() As Variant
Dim aControlIDSplit() As String
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = "OnAction"
    GetLogFile

    'On Error GoTo err
    If control.id = "LoadDefinitions" Then
        DoLoadDefinitions
        DumpDefinitions
        
    ElseIf Left(control.id, 8) = "SchedBut" Then
        aControlIDSplit = Split(control.id, "_")
        If UBound(aControlIDSplit) <> 2 Then
            FuncLogIt sFuncName, "SchedBut ID is incorrectly formed [" & control.id & "] needs to have 3 parts delimed by _", C_MODULE_NAME, LogMsgType.Error
        Else
            Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True)
            BuildSchedule clsQuadRuntime, _
                            eQuadSubDataType:=GetQuadSubDataTypeEnumFromValue(aControlIDSplit(1)), _
                            iPersonID:=CInt(aControlIDSplit(2))
        End If
             
    ElseIf control.id = "GenerateEntryForm" Then
        Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True)
        GenerateEntryForms clsQuadRuntime
    ElseIf control.id = "DeleteEntryForm" Then
        DeleteEntryForms
    ElseIf control.id = "Student" Then
        HideAllEntryForms
        ShowEntryForm "Student"
    ElseIf control.id = "Teacher" Then
        HideAllEntryForms
        ShowEntryForm "Teacher"
    ElseIf control.id = "FormStyles" Then
        ToggleSheet ActiveWorkbook, "FormStyles"
    ElseIf control.id = "Definitions" Then
        ToggleSheet ActiveWorkbook, "Definitions"
    ElseIf control.id = "CellStyles" Then
        ToggleSheet ActiveWorkbook, "CellStyles"
        
    ' Tab: Admin
    ElseIf control.id = "DoBackups" Then
        BackupModules
    ElseIf control.id = "GetProcs" Then
        DumpProcs
    ElseIf control.id = "ViewLogs" Then
        DoViewLogs
    ElseIf control.id = "RefreshRibbon" Then
        RefreshRibbon
    ElseIf control.id = "EventsOn" Then
        EventsToggle True
    ' Git
    ElseIf control.id = "Commit" Then
        Set dControlValues = GetControlValues(vControls)
        DoGitCommit Selection, dControlValues.Item("RepoName"), dControlValues.Item("GitRootPath"), _
        sMessage:=dControlValues.Item("CommitMessage")
    ElseIf control.id = "CreateRepo" Then
        Set dControlValues = GetControlValues(vControls)
        DoGitCreateRepo dControlValues.Item("RepoName"), dControlValues.Item("UserName")
    ElseIf control.id = "DeleteRepo" Then
        Set dControlValues = GetControlValues(vControls)
        DoGitDeleteRepo dControlValues.Item("RepoName"), dControlValues.Item("UserName")
    ElseIf control.id = "ViewCommits" Then
        Set dControlValues = GetControlValues(vControls)
        DoGitViewCommits dControlValues.Item("RepoName")
    
    ' Group: Config
    ElseIf control.id = "DecodeFlag" Then
        OnChange control, str(bCheckbox)
    ElseIf control.id = "AutoSelect" Then
        OnChange control, str(bCheckbox)
    ElseIf control.id = "NewSheet" Then
        OnChange control, str(bCheckbox)
        'If checkVal = True Then
    ElseIf control.id = "ImportQuery" Then
        OnChange control, GetQueryFromRange, "QueryString"
        RefreshRibbon ' so that the Ribbon entry gets updated
    ' Group: Database Actions
    ElseIf control.id = "Insert" Then
        Set dControlValues = GetControlValues(vControls)
        DoInsertDBRows ActiveSheet, Selection, dControlValues.Item("DatabaseName"), _
                    dControlValues.Item("TableName"), dControlValues.Item("DecodeFlag")
        ', bDecodeFlag:=True
    ElseIf control.id = "Query" Then
        Set dControlValues = GetControlValues(vControls)
        DoQueryDBRows ActiveWorkbook, dControlValues.Item("TableName"), dControlValues.Item("DatabaseName"), _
                dControlValues.Item("TableName"), dControlValues.Item("QueryString"), _
                        dControlValues.Item("DeleteFlag")
    Else
        GoTo fail
    End If
    'On Error GoTo 0
    
    FuncLogIt sFuncName, "Control element ID in [" & control.id & "]", C_MODULE_NAME, LogMsgType.OK
    GoTo exitsub
    
fail:
    FuncLogIt sFuncName, "Could not find an action for  in [" & control.id & "] definitions", C_MODULE_NAME, LogMsgType.Failure
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
    ActiveWorkbook.Sheets("config").Cells(1, 10).value = ObjPtr(rib)
End Sub
Public Sub RefreshRibbon()

    If rib Is Nothing Then
        Set rib = GetRibbon(ActiveWorkbook.Sheets("config").Cells(1, 10).value)
    ' Else: Do nothing!
    End If

    'On Error Resume Next
    rib.Invalidate
    
    'On Error GoTo 0
End Sub


Sub GetContent(control As IRibbonControl, ByRef returnedVal)
Dim xml As String
Dim rSelection As Range

    Set rSelection = Selection
    
    xml = "<menu xmlns=""http://schemas.microsoft.com/office/2009/07/customui"">" & _
          "<button id=""but1"" imageMso=""Help"" label=""Help"" onAction=""HelpMacro""/>" & _
          "<button id=""but2"" imageMso=""FindDialog"" label=""Find"" onAction=""FindMacro""/>" & _
          "</menu>"

    returnedVal = xml
End Sub

Sub rxgal_getItemCount(control As IRibbonControl, ByRef returnedVal)
Dim vLabelNames As Variant
Dim clsQuadRuntime As New Quad_Runtime
    clsQuadRuntime.InitProperties bInitializeCache:=False
    vLabelNames = GetColumnValues(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, "sStudentLastNm")
    returnedVal = UBound(vLabelNames) + 1
End Sub

Sub rxgal_getItemLabel(control As IRibbonControl, index As Integer, ByRef returnedVal)
Dim vLabelNames As Variant
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties bInitializeCache:=False
    vLabelNames = GetColumnValues(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, "sStudentLastNm")
    
    'is this correct at last index ?
    returnedVal = vLabelNames(index)
End Sub

Sub rxgal_getItemImage(control As IRibbonControl, index As Integer, ByRef returnedVal)
'This callback runs for every picture that is in the Img folder
'Fnum is the number of times it run this code line
Dim sImagePath As String
Dim vFiles() As String
Dim vExtensions() As String


    If index > 8 Then
        index = 0
    End If
    
    vExtensions = InitStringArray(Array("png", "jpg"))
    sImagePath = Environ("MYHOME") & "\Pictures\icons\"
    vFiles = GetFolderFiles(sImagePath, vExtensions:=vExtensions)
    Set returnedVal = LoadPictureGDI(sImagePath & vFiles(index))
        
End Sub

Sub rxgal_getImage(control As IRibbonControl, ByRef returnedVal)
Dim sImagePath As String
Dim vFiles() As String
Dim vExtensions() As String
    
    vExtensions = InitStringArray(Array("png", "jpg"))
    sImagePath = Environ("MYHOME") & "\Pictures\icons\"
    vFiles = GetFolderFiles(sImagePath, vExtensions:=vExtensions)
    Set returnedVal = LoadPictureGDI(sImagePath & vFiles(1))

End Sub
