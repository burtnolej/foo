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

Public Sub GenerateForms(clsAppRuntime As App_Runtime, _
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
'param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'param  : bLoadRefData, Boolean; when true will force loading of ref data from db
'>>>
Dim dActions As Dictionary, dDefnDetails As Dictionary
Dim sAction As Variant, sKey As Variant, vFormType As Variant
Dim sCode As String, sFieldName As String, sFuncName As String, sCallbackFunc As String, sDBColName As String, sFormType As String, sTemplateSheetName As String
Dim rWidget As Range, rButton As Range, rCell As Range, rFormat As Range
Dim vGenerated() As String
Dim wbTmp As Workbook, wbTarget As Workbook
Dim eWidgetType As WidgetType
Dim wsTmp As Worksheet
Dim i As Integer, iHeaderCount As Integer
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    EventsToggle False
        
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
                    Set wbTarget = CallByName(clsAppRuntime, "ViewBook", VbGet)
                Else
                    Set wbTarget = CallByName(clsAppRuntime, vFormType & "Book", VbGet)
                End If
                sFormType = CStr(vFormType)
                
            End If
        Next vFormType
        
        FuncLogIt sFuncName, "Creating Form [Form Type=" & sFormType & "] [Target Workbook=" & wbTarget.Name & "] [Action = " & sAction & "]", C_MODULE_NAME, LogMsgType.INFO
        
        If IsSet(wbTarget) = False Then
            FuncLogIt sFuncName, "invalid formtype  [" & CStr(sAction) & "]", C_MODULE_NAME, LogMsgType.Failure
            GoTo nextaction
        End If
    
        Set wsTmp = CreateSheet(wbTarget, CStr(sAction), bOverwrite:=True)
        
        For i = 1 To UBound(Split(C_WIDGET_TYPE, COMMA)) + 1
            eWidgetType = i

            sCode = GetEntryCallbackCode(clsAppRuntime, CStr(sAction), wbTarget.Name, eWidgetType:=eWidgetType)
            sTemplateSheetName = FormatForm(clsAppRuntime, CStr(sAction), sFormType:=sFormType)
            
            If eWidgetType = WidgetType.ListText Then
            
                ' only try to draw widgets if the Action matches the provided FormType
                'If GetFormTypeFromAction(CStr(sAction)) = "ViewList" Then
                
                    ' the headers are better off being drawn in the generate widgets as each column is drawn
                    'Set rFormat = clsAppRuntime.TemplateBook.Sheets(sTemplateSheetName).Range("fViewListHeader")
                    
                    iHeaderCount = 1
                    'For Each rCell In rFormat.Cells
                        'wsTmp.Range(rCell.Address).value = vHeaderValues(1, iHeaderCount)
                        'iHeaderCount = iHeaderCount + 1
                    'Next rCell
                    
                    GenerateWidgets clsAppRuntime, CStr(sAction), wbTmp:=wbTarget, vValues:=vValues, eWidgetType:=eWidgetType, sFormType:=sFormType, sTemplateSheetName:=sTemplateSheetName
                'End If
            ElseIf eWidgetType = WidgetType.Text Then
                GenerateWidgets clsAppRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, eWidgetType:=eWidgetType, sFormType:=sFormType, sTemplateSheetName:=sTemplateSheetName
            ElseIf eWidgetType = WidgetType.Button Then
                vGenerated = GenerateWidgets(clsAppRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, eWidgetType:=eWidgetType, sFormType:=sFormType, sTemplateSheetName:=sTemplateSheetName)
                If IsEmptyArray(vGenerated) = False Then
                    sCode = GenerateCallbackCode(clsAppRuntime, vGenerated, CStr(sAction), sCurrentCode:=sCode, wbTmp:=wbTarget)
                End If
                AddCode2Module wbTarget, wsTmp.CodeName, sCode
            ElseIf eWidgetType = WidgetType.Selector Then
                GenerateWidgets clsAppRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, eWidgetType:=eWidgetType, sFormType:=sFormType, sTemplateSheetName:=sTemplateSheetName
            ElseIf eWidgetType = WidgetType.Entry Then
                GenerateWidgets clsAppRuntime, CStr(sAction), wbTmp:=wbTarget, dDefaultValues:=dDefaultValues, sTemplateSheetName:=sTemplateSheetName
            End If
            
            If eWidgetType = WidgetType.Button Or eWidgetType = WidgetType.Entry Then
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
    
cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    EventsToggle True
End Sub

Public Sub UpdateViewStudentForm(ParamArray args())
'<<<
'purpose:
'param  :
'       :
'param  :
'rtype  :
'>>>
Dim clsAppRuntime As App_Runtime
Dim lStartTick As Long
Dim eWidgetType As WidgetType
Dim eFormType As FormType
Dim sSubDataType As String, sView As String, sFuncName As String, sValue As String, sLookUpIdRangeName As String, sTableName As String, sDataType As String

setup:
    sFuncName = C_MODULE_NAME & "." & "UpdateViewStudentForm"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    Set clsAppRuntime = args(0)
    sValue = args(1)
    sLookUpIdRangeName = args(2)
    
    
    'its an update Student view function
    sSubDataType = "Student"
    sDataType = "Person"
    eWidgetType = WidgetType.Text
    'its an update view function
    eFormType = FormType.View
    
    UpdateForm clsAppRuntime, sValue, sLookUpIdRangeName, sSubDataType, eWidgetType, eFormType, sDataType

cleanup:
    FuncLogIt sFuncName, "[sValue=" & sValue & "] [sLookUpIdRangeName=" & sLookUpIdRangeName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick


End Sub

Public Function GetFormName(eFormType As FormType, sDataType As String, sSubDataType As String) As String
'<<<
'purpose: A FormName is the name of the Sheet that is generated
'param  : eFormType, FormType; i.e. 3
'param  : SubDataType (i.e. Quad this would be Student|Teacher
'rtype  : String; i.e. ViewStudent
'>>>
Dim sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetFormName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    
    If sSubDataType = "" Then
        GoTo err
    End If
    
main:
    
    GetFormName = EnumFormType(eFormType) & UNDERSCORE & sDataType & UNDERSCORE & sSubDataType
    
cleanup:
    FuncLogIt sFuncName, "[eFormType=" & eFormType & "] [sSubDataType=" & sSubDataType & "] [Result=" & GetFormName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function
Public Sub UpdateForm(ParamArray args())
'<<<
'purpose:
'param  :
'       :
'param  :
'rtype  :
'>>>
Dim sCacheTableName As String, sValue As String, sLookUpIdRangeName As String, sRecordID As String, sFieldName As String, sFuncName As String, sLookUpFieldName As String, sDataType As String
Dim clsAppRuntime As App_Runtime
Dim sKey As Variant
Dim rTarget As Range
Dim lStartTick As Long
Dim eWidgetType As WidgetType
Dim eFormType As FormType
Dim sSubDataType As String, sFormName As String
Dim dValues As Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "UpdateForm"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    Set clsAppRuntime = args(0)
    sValue = args(1) ' i.e Bruno - if the LookupID is sStudentFirstNm
    sLookUpIdRangeName = args(2) ' i.e. ViewStudent!sViewStudent_sStudentFirstNm - if the form is a ViewStudent form
    sSubDataType = args(3) ' i.e. Student
    eWidgetType = args(4) ' i.e. 3  for Text
    eFormType = args(5) ' i.e. 3 for View
    sDataType = args(6) ' i.e. Person
    
    clsAppRuntime.InitProperties bInitializeCache:=False
 
 
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    
    ' how to get the cache table for this lookup
    sCacheTableName = GetCacheTableName(sLookUpIdRangeName) ' i.e. person_student
    
    sLookUpFieldName = GetFieldName(sLookUpIdRangeName)
    
    'to look up the record gets the record key/id field name from the range name passed in
    sRecordID = GetTableRecordID(sValue, sLookUpFieldName)
    
    Set dValues = GetTableRecord(sCacheTableName, CInt(sRecordID) - 1, wbTmp:=clsAppRuntime.CacheBook)
    
    For Each sKey In dDefinitions.Keys
        If InArray(Array("tables", "actions"), sKey) = False Then
            If IsWidgetRangeNameForView(CStr(sKey), sFormName, eWidgetType) = True Then
                sFieldName = GetFieldName(CStr(sKey))
                Set rTarget = clsAppRuntime.ViewBook.Sheets(sFormName).Range(sKey)
                rTarget.value = dValues.Item(sFieldName)
            End If
        End If
    Next sKey
    
    EventsToggle True
    clsAppRuntime.ViewBook.Activate

cleanup:
    FuncLogIt sFuncName, "[sCacheTableName=" & sCacheTableName & "] [sValue=" & sValue & "] [sLookUpIdRangeName=" & sLookUpIdRangeName & "] [sFormName=" & sFormName & "] [eWidgetType=" & EnumWidgetType(eWidgetType) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

End Sub
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
Public Function FormatForm(clsAppRuntime As App_Runtime, _
                           sTargetSheetName As String, _
                  Optional sFormType As String = "Add", _
                  Optional iFirstCol As Integer = 1, _
                  Optional iFirstRow As Integer = 1) As String
Dim sFormFormatRangeName As String
Dim rFormFormatRange As Range, rFormFormatTargetRange As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer
Dim wsForm As Worksheet
Dim wbTarget As Workbook
Dim sFuncName As String
Dim lStartTick As Long
Dim wsFormFormat As Worksheet

setup:
    sFuncName = C_MODULE_NAME & "." & "FormatForm"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    sFormFormatRangeName = "f" & sFormType
    If sFormType = "ViewList" Then
        Set wbTarget = CallByName(clsAppRuntime, "ViewBook", VbGet)
    Else
        Set wbTarget = CallByName(clsAppRuntime, sFormType & "Book", VbGet)
    End If
    
    Set wsForm = wbTarget.Sheets(sTargetSheetName)
    Set rFormFormatRange = clsAppRuntime.TemplateBook.Names(sFormFormatRangeName).RefersToRange
    Set wsFormFormat = rFormFormatRange.Worksheet
    
    rFormFormatRange.Copy
    iFormatWidth = rFormFormatRange.Columns.Count
    iFormatHeight = rFormFormatRange.Rows.Count
    
    wsForm.Visible = True
    With wsForm
        wsForm.Range(.Cells(iFirstRow, iFirstCol), _
                     .Cells(iFirstRow + iFormatHeight - 1, _
                            iFirstCol + iFormatWidth - 1)).PasteSpecial Paste:=xlPasteFormats, _
                                                                               operation:=xlNone, _
                                                                               SkipBlanks:=False, _
                                                                               Transpose:=False
    End With

    'FormatColRowSize clsAppRuntime.TemplateBook, wbTarget, _
    '        wsForm.name, clsAppRuntime.TemplateSheetName, sFormFormatRangeName
    FormatColRowSize clsAppRuntime.TemplateBook, wbTarget, _
            wsForm.Name, wsFormFormat.Name, sFormFormatRangeName
            
cleanup:
    FormatForm = wsFormFormat.Name 'this is so rest the locations of the individual widgets on the form can easilly be found
    FuncLogIt sFuncName, "[sTargetSheetName=" & sTargetSheetName & "] [sFormFormatRangeName=" & sFormFormatRangeName & "] [wbTarget=" & wbTarget.Name & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick


End Function

Public Function GetRecordValuesAsDict(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                sSheetName As String) As Dictionary
Dim rEntryWidget As Range
Dim sFuncName As String, sActionName As String, sFieldName As String
Dim dValues As New Dictionary
Dim aNames() As String
Dim name_ As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "GetRecordValuesAsDict"

main:
    aNames = GetSheetNamedRanges(wbTargetbook, sSheetName)
    For Each name_ In aNames
        sActionName = GetActionFromWidgetKey(name_)
        'sActionName = Split(name_, "_")(0)
        
        ' we just want to match entry fields so 1st char + ActionName
        If Left(name_, 1) & sActionName = "e" & sSheetName Then
            'sFieldName = Split(name_, "_")(1)
            sFieldName = GetFieldName(CStr(name_))
            
            Set rEntryWidget = wbTargetbook.Sheets(sSheetName).Range(name_)
            dValues.Add sFieldName, rEntryWidget.value
            End If
    Next name_
    
    Set GetRecordValuesAsDict = dValues
End Function
Public Function IsRecordValid(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                sSheetName As String, sSourceSheetName As String) As Boolean
Dim rEntryWidget As Range
Dim cRGB As RGBColor
Dim sFuncName As String
Dim aNames() As String
Dim name_ As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "IsRecordValid"

main:

    aNames = GetSheetNamedRanges(wbTargetbook, sSheetName)
    For Each name_ In aNames
        If Left(name_, 1) & GetActionFromWidgetKey(name_) = "e" & sSheetName Then
        'If Split(name_, "_")(0) = "e" & sSheetName Then
            Set rEntryWidget = wbTargetbook.Sheets(sSheetName).Range(name_)
            Set cRGB = GetBgColor(sSheetName, rEntryWidget)
            If cRGB.AsString <> C_RGB_VALID Then
                IsRecordValid = False
                FuncLogIt sFuncName, "Widget named [" & name_ & "] not valid", C_MODULE_NAME, LogMsgType.INFO

                ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, WidgetState.Invalid, sSourceSheetName, bTakeFocus:=False

                Exit Function
            End If
        End If
    Next name_
    IsRecordValid = True
    FuncLogIt sFuncName, "Add Form  [" & sSheetName & "] is valid", C_MODULE_NAME, LogMsgType.INFO

    ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, _
        WidgetState.Valid, sSourceSheetName, bTakeFocus:=True

End Function



Public Sub UpdateDefaultValues(sKey As String, dDefaultValues As Dictionary, sAction As String, rWidget As Range)
Dim sDBColName As String
    If IsSet(dDefaultValues) = True Then ' add default value if one exists
        If dDefaultValues.Exists(sAction) = True Then
            sDBColName = GetFieldName(sKey)
            'sDBColName = Split(sKey, "_")(1)
            If dDefaultValues.Item(sAction).Exists(sDBColName) = True Then
                rWidget.value = dDefaultValues.Item(sAction).Item(sDBColName)
            End If
        End If
    End If
End Sub


