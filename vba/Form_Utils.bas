Attribute VB_Name = "Form_Utils"
Option Explicit
Const C_MODULE_NAME = "Form_Utils"
Const C_GOBUTTON_ROW = 2
Const C_GOBUTTON_COL = 8

Enum FormType
    Add = 1
    Menu = 2
    View = 3
    ViewList = 4
End Enum

Const C_FORM_TYPE = "Add,Menu,View,ViewList"
Public dDefinitions As Dictionary

Function EnumFormType(i As Long) As String
    EnumFormType = Split(C_FORM_TYPE, COMMA)(i - 1)
End Function
Function GetFormTypeEnumFromValue(sValue As String) As Long
    GetFormTypeEnumFromValue = IndexArray(C_FORM_TYPE, sValue)
End Function

Public dDefinitions As Dictionary

Public Sub GenerateForms(clsQuadRuntime As Quad_Runtime, _
                     Optional bLoadRefData As Boolean = False, _
                     Optional sOverideButtonCallback As String, _
                     Optional sFormName As String, _
                     Optional dDefaultValues As Dictionary, _
                     Optional vValues As Variant, _
                     Optional bSetAsValid As Boolean = False)
'<<<
'purpose: based on Definitions, create a set of sheets that serve as entry screens;
'       : add callback code to the sheets so that user entries are processed immediately
'       : add buttons, that can be used to submit completed records
'       : cache reference data for use in validations when user enters data
'       :
'param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'param  : bLoadRefData, Boolean; when true will force loading of ref data from db
'>>>
Dim dActions As Dictionary, dDefnDetails As Dictionary
Dim sAction As Variant, sKey As Variant, vFormType As Variant
Dim sCode As String, sFieldName As String, sFuncName As String, sCallbackFunc As String, sDBColName As String, sFormType As String
Dim rCell As Range, rButton As Range
Dim vGenerated() As String
Dim wbTmp As Workbook, wbTarget As Workbook
Dim eCellType As CellType
Dim wsTmp As Worksheet
Dim i As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"

    If IsSet(dDefinitions) = False Then
        DoLoadDefinitions
    End If
        
main:
    Set dActions = dDefinitions.Item("actions")
    For Each sAction In dActions.Keys()
    
        If sFormName <> "" Then
            FuncLogIt sFuncName, "Generating for [sFormName=" & sFormName & "]", C_MODULE_NAME, LogMsgType.INFO
            If sAction <> sFormName Then
                GoTo nextaction
            End If
        End If
                
        If sOverideButtonCallback <> "" Then
            FuncLogIt sFuncName, "Overiding [sOverideButtonCallback=" & sOverideButtonCallback & "]", C_MODULE_NAME, LogMsgType.INFO
            sCallbackFunc = sOverideButtonCallback
        Else
            sCallbackFunc = sAction
        End If
        
        ' create the Add sheet and add call back code
        For Each vFormType In Split(C_FORM_TYPE, COMMA)
            If CStr(sAction) Like vFormType & ASTERISK Then
                If vFormType = "ViewList" Then
                    Set wbTarget = CallByName(clsQuadRuntime, "ViewBook", VbGet)
                Else
                    Set wbTarget = CallByName(clsQuadRuntime, vFormType & "Book", VbGet)
                End If
                sFormType = CStr(vFormType)
                
            End If
        Next vFormType
        
        FuncLogIt sFuncName, "Creating Form [Form Type=" & sFormType & "] [Target Workbook=" & wbTarget.name & "] [Action = " & sAction & "]", C_MODULE_NAME, LogMsgType.INFO
        
        If IsSet(wbTarget) = False Then
            FuncLogIt sFuncName, "invalid formtype  [" & CStr(sAction) & "]", C_MODULE_NAME, LogMsgType.Failure
            GoTo nextaction
        End If
    
        Set wsTmp = CreateSheet(wbTarget, CStr(sAction), bOverwrite:=True)
        
        For i = 1 To UBound(Split(C_CELL_TYPE, COMMA)) + 1
            eCellType = i

            sCode = GetEntryCallbackCode(clsQuadRuntime, CStr(sAction), wbTarget.name, eCellType:=eCellType)
            FormatAddForm clsQuadRuntime, CStr(sAction), sFormType:=sFormType
            
            If eCellType = CellType.ListText Then
                GenerateWidgets clsQuadRuntime, CStr(sAction), wbTmp:=wbTarget, vValues:=vValues, eCellType:=eCellType, sFormType:=sFormType
            ElseIf eCellType = CellType.Text Then
                GenerateWidgets clsQuadRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, eCellType:=eCellType, sFormType:=sFormType
            ElseIf eCellType = CellType.Button Then
                vGenerated = GenerateWidgets(clsQuadRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, eCellType:=eCellType, sFormType:=sFormType)
                If IsEmptyArray(vGenerated) = False Then
                    sCode = GenerateCallbackCode(clsQuadRuntime, vGenerated, CStr(sAction), sCurrentCode:=sCode, wbTmp:=wbTarget)
                End If
                AddCode2Module wbTarget, wsTmp.CodeName, sCode
            ElseIf eCellType = CellType.Selector Then
                GenerateWidgets clsQuadRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, eCellType:=eCellType, sFormType:=sFormType
            ElseIf eCellType = CellType.Entry Then
                GenerateWidgets clsQuadRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues
            End If
            
            If eCellType = CellType.Button Or eCellType = CellType.Entry Then
                sCode = GetCallerModuleCode
                ' will already exist if more than 1 entry
                If ModuleExists(wbTarget, "change_event_invoker") = False Then
                    CreateModule wbTarget, "change_event_invoker", sCode
                End If
            End If
        Next i
        HideForm CStr(sAction), wbTmp:=wbTarget

nextaction:
    Next sAction
End Sub


Public Function LoadDefinitions(wsTmp As Worksheet, _
                       Optional rSource As Range = Nothing, _
                       Optional bIgnoreCellType As Boolean = False) As Dictionary
Dim dDefinitions As New Dictionary, dDefnDetail As Dictionary
Dim dDefnActions As New Dictionary 'holds a discrete list of actions that have been defined
Dim dDefnTables As New Dictionary 'holds a discrete list of tables that have been defined
Dim rRow As Range
Dim sTableName As String, sFieldName As String, sActionName As String, sValidationType As String, sActionFunc As String
Dim eCellType As CellType
Dim sValidationParam As String, sFuncName As String, sKey As String
Dim vValidationParams() As String
Dim iCol As Integer, iValidationParamCount As Integer

setup:

    sFuncName = C_MODULE_NAME & "." & "LoadDefinitions"
main:
    If rSource Is Nothing Then
        Set rSource = Range("rDefinitions")
    End If
    
    With wsTmp
        For Each rRow In rSource.Rows
            ReDim vValidationParams(0 To 3)
            'rSource.Select
            iValidationParamCount = 0
            sActionName = rRow.Columns(1)
            sTableName = rRow.Columns(2)
            sFieldName = rRow.Columns(3)
            sValidationType = rRow.Columns(4)
            sValidationParam = rRow.Columns(5)
            sActionFunc = rRow.Columns(8)
            
            If bIgnoreCellType = False Then
                eCellType = GetCellTypeFromValue(rRow.Columns(9))
            Else
                eCellType = CellType.Entry
            End If
            
            Set dDefnDetail = New Dictionary
            dDefnDetail.Add "validation_type", sValidationType
            dDefnDetail.Add "validation_param", sValidationParam
            dDefnDetail.Add "db_table_name", sTableName
            dDefnDetail.Add "db_field_name", sFieldName
            dDefnDetail.Add "cell_type", eCellType
            dDefnDetail.Add "action_func", sActionFunc
            
            For iCol = 6 To 7
                If rRow.Columns(iCol).value <> "" Then
                    vValidationParams(iValidationParamCount) = rRow.Columns(iCol).value
                    iValidationParamCount = iValidationParamCount + 1
                End If
            Next iCol
            
            If iValidationParamCount > 0 Then
                ReDim Preserve vValidationParams(0 To iValidationParamCount - 1)
                dDefnDetail.Add "validation_args", vValidationParams
            End If
            
            sKey = GetKey(sActionName, sFieldName, eCellType)
            
            If dDefinitions.Exists(sKey) = True Then
                FuncLogIt sFuncName, "definition for [" & sKey & "] already loaded", C_MODULE_NAME, LogMsgType.INFO
            Else
                dDefinitions.Add sKey, dDefnDetail
            End If
            
            If dDefnActions.Exists(sActionName) = False Then
                'rRow.Select
                dDefnActions.Add sActionName, Nothing
            End If

            If dDefnTables.Exists(sTableName) = False Then
                dDefnTables.Add sTableName, Nothing
            End If
            
        Next rRow
    End With
    
    dDefinitions.Add "actions", dDefnActions
    dDefinitions.Add "tables", dDefnTables
    
exitfunc:
    Set LoadDefinitions = dDefinitions
    'FuncLogIt sFuncName, "Loaded in [" & CStr(UBound(dDefinitions.Keys())) & "] definitions", C_MODULE_NAME, LogMsgType.OK
    Exit Function

err:
    Set LoadDefinitions = Nothing
    FuncLogIt sFuncName, "loading in definitions in [" & err.Description & "] definitions", C_MODULE_NAME, LogMsgType.Failure

End Function

Public Sub DoLoadDefinitions(Optional clsQuadRuntime As Quad_Runtime)
Dim rSource As Range
Dim wsTmp As Worksheet
Dim wbTmp As Workbook

    If IsSet(clsQuadRuntime) = True Then
        Set wbTmp = clsQuadRuntime.TemplateBook
        Set wsTmp = wbTmp.Sheets(clsQuadRuntime.DefinitionSheetName)
    Else
        Set wbTmp = ActiveWorkbook
        'Set wsTmp = wbTmp.Sheets("Definitions")
        Set wsTmp = wbTmp.Sheets(clsQuadRuntime.DefinitionSheetName)
    End If
    
    Set rSource = wsTmp.Range("Definitions")
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource)
    
    End Sub
    
Public Function UpdateForm(ParamArray args()) As Boolean
Dim dValues As Dictionary, dDetailDefn As Dictionary
Dim sTableName As String, sValue As String, sRangeName As String, sRecordID As String, sFieldName As String
Dim clsQuadRuntime As Quad_Runtime
Dim sKey As Variant
Dim rTarget As Range

    Set clsQuadRuntime = args(0)
    sValue = args(1)
    sRangeName = args(2)
    sTableName = Split(sRangeName, BANG)(0)
    
    clsQuadRuntime.InitProperties bInitializeCache:=False
    
    sRecordID = GetTableRecordID(sValue, "sStudentFirstNm")
    Set dValues = GetTableRecord("person_student", CInt(sRecordID) - 1, wbTmp:=clsQuadRuntime.CacheBook)
    
    For Each sKey In dDefinitions.Keys
        If Split(sKey, UNDERSCORE)(0) = "t" & sTableName Then
            Set dDetailDefn = dDefinitions.Item(sKey)
            sFieldName = Split(sKey, UNDERSCORE)(1)
            Set rTarget = clsQuadRuntime.ViewBook.Sheets(sTableName).Range(sKey)
            rTarget.value = dValues.Item(sFieldName)
        End If
    Next sKey
    
    EventsToggle True
    clsQuadRuntime.ViewBook.Activate
    
End Function
Public Sub ShowForm(sTableName As String)
Dim wsTmp As Worksheet

    Set wsTmp = ShowSheet(ActiveWorkbook, "Add" & sTableName)
    wsTmp.Activate
End Sub

Public Sub HideForm(sSheetName As String, Optional wbTmp As Workbook)

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    If SheetIsVisible(wbTmp, sSheetName) = True Then
        HideSheet wbTmp, sSheetName
    End If
    
End Sub
Public Sub HideForms()
Dim sAction As Variant
Dim sKey As Variant

    If dDefinitions Is Nothing Then
        DoLoadDefinitions
    End If
    
    Set dActions = dDefinitions.Item("actions")
    For Each sAction In dActions.Keys()
        If SheetIsVisible(ActiveWorkbook, CStr(sAction)) = True Then
            HideSheet ActiveWorkbook, CStr(sAction)
        End If
    Next sAction
    
End Sub

Public Sub DeleteForms(Optional wbTmp As Workbook)
Dim sAction As Variant, sKey As Variant
Dim dActions As Dictionary

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    If dDefinitions Is Nothing Then
        DoLoadDefinitions
    End If
    
    Set dActions = dDefinitions.Item("actions")
    For Each sAction In dActions.Keys()
        For Each sKey In dDefinitions.Keys()
            DeleteEntry CStr(sAction), sKey, wbTmp:=wbTmp
        Next sKey
        DeleteSheet wbTmp, CStr(sAction)
    Next sAction
    
End Sub

Public Sub FormatAddForm(clsQuadRuntime As Quad_Runtime, _
                           sTargetSheetName As String, _
                  Optional sFormType As String = "Add", _
                           Optional iFirstCol As Integer = 1, _
                           Optional iFirstRow As Integer = 1)
Dim sFormFormatRangeName As String
Dim rFormFormatRange As Range, rFormFormatTargetRange As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer
Dim wsForm As Worksheet
Dim wbTarget As Workbook

    sFormFormatRangeName = "f" & sFormType
    If sFormType = "ViewList" Then
        Set wbTarget = CallByName(clsQuadRuntime, "ViewBook", VbGet)
    Else
        Set wbTarget = CallByName(clsQuadRuntime, sFormType & "Book", VbGet)
    End If
    
    Set wsForm = wbTarget.Sheets(sTargetSheetName)
    
    With clsQuadRuntime.TemplateSheet
        .Range(sFormFormatRangeName).Copy
        iFormatWidth = .Range(sFormFormatRangeName).Columns.Count
        iFormatHeight = .Range(sFormFormatRangeName).Rows.Count
    End With
    
    wsForm.Visible = True
    With wsForm
        wsForm.Range(.Cells(iFirstRow, iFirstCol), _
                     .Cells(iFirstRow + iFormatHeight - 1, _
                            iFirstCol + iFormatWidth - 1)).PasteSpecial Paste:=xlPasteFormats, _
                                                                               operation:=xlNone, _
                                                                               SkipBlanks:=False, _
                                                                               Transpose:=False
    End With

    FormatColRowSize clsQuadRuntime.TemplateBook, wbTarget, _
            wsForm.name, clsQuadRuntime.TemplateSheetName, sFormFormatRangeName
End Sub

Function GetCallerModuleCode() As String
' add a caller module so can simulate change events more reliably
    GetCallerModuleCode = "Public Sub Invoke_Worksheet_SelectionChange(sSheetName As String, rTarget As Range)" & vbNewLine & _
                "Dim ws As Worksheet" & vbNewLine & _
                "set ws = Sheets(sSheetName)" & vbNewLine & _
                "Application.Run ws.CodeName & " & DOUBLEQUOTE & ".Worksheet_SelectionChange" & DOUBLEQUOTE & ", rTarget" & vbNewLine & _
                "End Sub"
End Function
        
Function GetEntryCallbackCode(clsQuadRuntime As Quad_Runtime, sAction As String, sTargetBookName As String, _
        Optional eCellType As CellType = CellType.Entry) As String
    GetEntryCallbackCode = "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine & _
            "dim wbTarget as Workbook, wbSource as Workbook" & vbNewLine & _
            "dim sSourceSheetName as string" & vbNewLine & _
            "dim sSheetName as string" & vbNewLine & _
            "sSheetName=" & DOUBLEQUOTE & sAction & DOUBLEQUOTE & vbNewLine & _
            "set wbSource= Workbooks(" & DOUBLEQUOTE & clsQuadRuntime.TemplateBookName & DOUBLEQUOTE & ")" & vbNewLine & _
            "set wbTarget= Workbooks(" & DOUBLEQUOTE & sTargetBookName & DOUBLEQUOTE & ")" & vbNewLine & _
            "sSourceSheetName = " & DOUBLEQUOTE & clsQuadRuntime.TemplateCellSheetName & DOUBLEQUOTE & vbNewLine & _
            "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.name & "!Validate" & DOUBLEQUOTE & ",wbTarget,sSheetName, Target" & vbNewLine
            
    If eCellType = CellType.Entry Then
        GetEntryCallbackCode = GetEntryCallbackCode & "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.name & "!IsRecordValid" & DOUBLEQUOTE & ",wbSource,wbTarget,sSheetName,sSourceSheetName" & vbNewLine
    End If
    
    GetEntryCallbackCode = GetEntryCallbackCode & "End Sub"
            
End Function
Function GenerateCallbackCode(clsQuadRuntime As Quad_Runtime, vButtons() As String, sActionName As String, _
                Optional sCurrentCode As String, _
                Optional wbTmp As Workbook) As String
Dim i As Integer, iRow As Integer, iColumn As Integer
Dim sCallback As String, sCallbackCode As String
Dim dDetail As Dictionary
Dim rButton As Range

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    For i = 0 To UBound(vButtons)
        Set dDetail = dDefinitions.Item(vButtons(i))
        sCallback = dDetail.Item("validation_args")(0)
        Set rButton = wbTmp.Sheets(sActionName).Range(vButtons(i))
        sCallbackCode = sCallbackCode & GetButtonCallbackCode(clsQuadRuntime, rButton.Column, rButton.Row, sCallback) & vbNewLine
    Next i
    
    GenerateCallbackCode = sCurrentCode & vbNewLine & _
         "Public Sub Worksheet_SelectionChange(ByVal Target As Range)" & vbNewLine & _
         sCallbackCode & vbNewLine & _
        "End Sub"

End Function
Function GetButtonCallbackCode(clsQuadRuntime As Quad_Runtime, _
    iButtonCol As Integer, iButtonRow As Integer, sCallbackFunc As String) As String
    GetButtonCallbackCode = _
                    "If Target.Column = " & CStr(iButtonCol) & " And Target.Row = " & CStr(iButtonRow) & " Then" & vbNewLine & _
                    "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.name & "!" & sCallbackFunc & DOUBLEQUOTE & vbNewLine & _
                    "End If" & vbNewLine
End Function

Public Function GetRecordValuesAsDict(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                sSheetName As String) As Dictionary
Dim rEntryCell As Range
Dim sFuncName As String, sActionName As String, sFieldName As String
Dim dValues As New Dictionary
Dim aNames() As String
Dim name_ As Variant


setup:
    sFuncName = C_MODULE_NAME & "." & "GetRecordValuesAsDict"

main:

    aNames = GetSheetNamedRanges(wbTargetbook, sSheetName)
    For Each name_ In aNames
        sActionName = Split(name_, "_")(0)
        If sActionName = "e" & sSheetName Then
            sFieldName = Split(name_, "_")(1)
            Set rEntryCell = wbTargetbook.Sheets(sSheetName).Range(name_)
            dValues.Add sFieldName, rEntryCell.value
            End If
    Next name_
    
    Set GetRecordValuesAsDict = dValues
End Function
Public Function IsRecordValid(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                sSheetName As String, sSourceSheetName As String) As Boolean
Dim rEntryCell As Range
Dim cRGB As RGBColor
Dim sFuncName As String
Dim aNames() As String
Dim name_ As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "IsRecordValid"

main:

    aNames = GetSheetNamedRanges(wbTargetbook, sSheetName)
    For Each name_ In aNames
        If Split(name_, "_")(0) = "e" & sSheetName Then
            Set rEntryCell = wbTargetbook.Sheets(sSheetName).Range(name_)
            Set cRGB = GetBgColor(sSheetName, rEntryCell)
            If cRGB.AsString <> C_RGB_VALID Then
                IsRecordValid = False
                FuncLogIt sFuncName, "Cell named [" & name_ & "] not valid", C_MODULE_NAME, LogMsgType.INFO

                ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, CellState.Invalid, sSourceSheetName, bTakeFocus:=False

                Exit Function
            End If
        End If
    Next name_
    IsRecordValid = True
    FuncLogIt sFuncName, "Add Form  [" & sSheetName & "] is valid", C_MODULE_NAME, LogMsgType.INFO

    ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, _
        CellState.Valid, sSourceSheetName, bTakeFocus:=True

End Function

Public Sub DumpDefinitions(Optional bLog As Boolean = True)
Dim sKey As Variant
Dim vDetail As Variant
Dim sFuncName As String, sDetail As String
Dim dDefnDetail As Dictionary
Dim v

    sFuncName = C_MODULE_NAME & "." & "DumpDefinitions"
    
    For Each sKey In dDefinitions.Keys
        If sKey <> "actions" And sKey <> "tables" Then
            Set dDefnDetail = dDefinitions.Item(sKey)
            Debug.Print vbNewLine
            Debug.Print sKey
            For Each vDetail In dDefnDetail.Keys
                If MyVarType(dDefnDetail.Item(vDetail)) = 46 Then
                    sDetail = "[" & Join(dDefnDetail.Item(CStr(vDetail)), COMMA) & "]"
                Else
                    sDetail = dDefnDetail.Item(vDetail)
                End If
                Debug.Print PadStr(CStr(vDetail), "left", 20, " ") & " = " & PadStr(sDetail, "right", 20, " ")
            Next vDetail
        End If
    Next sKey
End Sub

Public Sub UpdateDefaultValues(sKey As String, dDefaultValues As Dictionary, sAction As String, rCell As Range)
Dim sDBColName As String
    If IsSet(dDefaultValues) = True Then ' add default value if one exists
        If dDefaultValues.Exists(sAction) = True Then
            sDBColName = Split(sKey, "_")(1)
            If dDefaultValues.Item(sAction).Exists(sDBColName) = True Then
                rCell.value = dDefaultValues.Item(sAction).Item(sDBColName)
            End If
        End If
    End If
End Sub
