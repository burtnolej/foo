Attribute VB_Name = "Widget_Utils"
'Sub FormatButton(sTargetSheetName As String, rButton As Range, eButtonState As ButtonState, Optional sSourceSheetName As String = C_WIDGET_STYLES_SHEET)
Const C_MODULE_NAME = "Widget_Utils"
Const C_WIDGET_STYLES_SHEET = "WidgetStyles"

Enum WidgetRefWidgetNames
    fButtonInvalid = 1
    fButtonValid = 2
    fButtonPressed = 3
End Enum

Const C_WIDGET_REF_WIDGET_NAMES = "fButtonInvalid,fButtonValid,fButtonPressed"

Enum WidgetState
    Invalid = 1
    Pressed = 2
    Valid = 3
End Enum

Const C_WIDGET_STATE = "Invalid,Pressed,Valid"

Enum WidgetType
    Button = 1
    Entry = 2
    Text = 3
    ListText = 4
    Selector = 5
End Enum

Public Const C_WIDGET_TYPE = "Button,Entry,Text,ListText,Selector"

Enum WidgetDimension
    Hz = 1
    Vz = 2
End Enum

Const C_WIDGET_TYPE_STATE = "Entry,Button,Text,ListText,Selector"
Function EnumWidgetType(i As Long) As String
    EnumWidgetType = Split(C_WIDGET_TYPE, COMMA)(i - 1)
End Function
Function GetWidgetTypeFromValue(sValue As String) As Long
    On Error GoTo err
    GetWidgetTypeFromValue = IndexArray(Split(C_WIDGET_TYPE, COMMA), sValue) + 1
    If GetWidgetTypeFromValue = 0 Then
        GoTo err
    End If
    On Error GoTo 0
    Exit Function
    
err:
    err.Raise ErrorMsgType.INVALID_WIDGETTYPE, Description:="value [" & sValue & "] is not recognized"
    
End Function

Public Function GetWidgetSizes(wsTemplate As Worksheet, _
                             rSource As Range, _
                    Optional eWidgetDim As WidgetDimension = WidgetDimension.Hz) As Integer()
Dim aSizes() As Integer
Dim rWidget As Range, rNewRange As Range
Dim iWidth As Integer, iHeight As Integer, iSizeCount As Integer
    GetRangeDimensions rSource, iWidth, iHeight
    
    ReDim aSizes(0 To 50)
    With wsTemplate
        'HERE
        '.Activate
        Set rNewRange = rSource.Resize(iHeight, iWidth)
        
        If eWidgetDim = Hz Then
            For Each rWidget In rNewRange.Rows(1).Cells
                aSizes(iSizeCount) = rWidget.EntireColumn.ColumnWidth
                iSizeCount = iSizeCount + 1
            Next rWidget
        Else
            For Each rWidget In rNewRange.Columns(1).Cells
                aSizes(iSizeCount) = rWidget.EntireRow.RowHeight
                iSizeCount = iSizeCount + 1
            Next rWidget
        End If
        ReDim Preserve aSizes(0 To iSizeCount - 1)
    End With
    
    GetWidgetSizes = aSizes
End Function

Public Function GetWidgetColWidthsORig(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
Dim aColumnWidths() As Integer
Dim rWidget As Range

    ReDim aColumnWidths(0 To 20)
    With clsQuadRuntime.TemplateSheet
        .Activate
        For Each rWidget In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rWidget.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rWidget
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetWidgetColWidths = aColumnWidths
End Function


Public Sub FormatWidget(wbSourceBook As Workbook, _
                        wbTargetbook As Workbook, _
                        sTargetSheetName As String, _
                        rWidget As Range, _
                        eWidgetState As WidgetState, _
                        sSourceSheetName As String, _
               Optional eWidgetType As WidgetType = WidgetType.Button)
Dim eWRefCName As String
    eWRefCName = "f" & Split(C_WIDGET_TYPE, COMMA)(eWidgetType - 1) & Split(C_WIDGET_STATE, COMMA)(eWidgetState - 1)
    CopyFormat wbSourceBook, wbTargetbook, sSourceSheetName, sTargetSheetName, eWRefCName, rWidget.Address
End Sub

'add format EntryWidget here to copy formats for entry Widgets

'Public Function GetScheduleWidgetColWidths(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
'                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleWidget


Public Sub FormatColRowSize(wbSourceBook As Workbook, _
                            wbTargetbook As Workbook, _
                            sTargetSheetName As String, _
                            sSourceSheetName As String, _
                            sSourceRangeName As String, _
                   Optional iTargetFirstRow As Integer = 1, _
                   Optional iTargetFirstCol As Integer = 1)

Dim aColumnWidths() As Integer, aRowHeights() As Integer
Dim iColWidthCount As Integer, iRowHeightCount As Integer, iRow As Integer, iCol As Integer, iFormatRowCount As Integer, iFormatColCount As Integer
Dim rWidget As Range, rTargetRange As Range, rSourceRange As Range
Dim wsTemplateSheet As Worksheet, wsTargetSheet As Worksheet

    Set wsTargetSheet = wbTargetbook.Sheets(sTargetSheetName)
    'Set wsTemplateSheet = wbSourceBook.Sheets(sSourceSheetName)

    Set wsTemplateSheet = wbSourceBook.Names(sSourceRangeName).RefersToRange.Parent

    Set rSourceRange = wsTemplateSheet.Range(sSourceRangeName)
    
    aColumnWidths = GetWidgetSizes(wsTemplateSheet, rSourceRange)
    aRowHeights = GetWidgetSizes(wsTemplateSheet, rSourceRange, eWidgetDim:=WidgetDimension.Vz)
    
    With wsTargetSheet
        Set rTargetRange = .Range(.Cells(iTargetFirstRow, iTargetFirstCol), _
                    .Cells(iTargetFirstRow + UBound(aRowHeights), _
                           iTargetFirstCol + UBound(aColumnWidths)))
    End With
    
    'rTargetRange.Select
    For iRow = 1 To UBound(aRowHeights) + 1
        rTargetRange.Rows(iRow).EntireRow.RowHeight = aRowHeights(iRow - 1)
    Next iRow
    
    For iCol = 1 To UBound(aColumnWidths) + 1
        rTargetRange.Columns(iCol).EntireColumn.ColumnWidth = aColumnWidths(iCol - 1)
    Next iCol
End Sub


Sub CreateComboBox1()
    With ActiveSheet.OLEObjects.Add(ClassType:="Forms.ComboBox.1", _
                Link:=False, DisplayAsIcon:=False, Left:=50, Top:=80, Width:=100, _
                Height:=15)
        With .Object
            .AddItem "Date"
            .AddItem "Dart"
            .AddItem "Player"
            .AddItem "Team"
            .AddItem "Goals"
            .AddItem "Number"
        End With
    End With
End Sub

Public Function GetWidgetLocationRanges(wbTmp As Workbook, sFormType As String, _
                        eWidgetType As WidgetType) As String()
'<<<
'purpose: get all the named ranges for Widgets for a certain WidgetType within a Form
'       : for instance fViewButton1, fViewButton2, fViewButton3 ...
'param  : sFormType, String; i.e. Add
'param  : eWidgetType, WidgetType
'rtype  : String Array
'>>>
Dim aNames() As String
Dim iCount As Integer, i As Integer
Dim sFuncName As String, sRangeName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetWidgetLocationRanges"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    ReDim aNames(0 To 100)

main:

    sRangeName = "f" & sFormType & EnumWidgetType(eWidgetType)
    For i = 1 To 100
        If NamedRangeExists(wbTmp, "", sRangeName & CStr(i)) = True Then
            aNames(iCount) = sRangeName & CStr(i)
            iCount = iCount + 1
        Else
            GoTo cleanup
        End If
    Next i
    
cleanup:
    If iCount = 0 Then
        ReDim aNames(0)
    Else
        ReDim Preserve aNames(0 To iCount - 1)
    End If
    GetWidgetLocationRanges = aNames
    
    FuncLogIt sFuncName, " [wbTmp" & wbTmp.name & "] [sFormType=" & sFormType & "] [eWidgetType=" & EnumWidgetType(eWidgetType) & "] [Result=" & CStr(UBound(GetWidgetLocationRanges) + 1) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function
Public Function GenerateWidgets(clsQuadRuntime As Quad_Runtime, _
                              sAction As String, _
                     Optional dDefaultValues As Dictionary, _
                     Optional vValues As Variant, _
                     Optional wbTmp As Workbook, _
                     Optional eWidgetType As WidgetType = WidgetType.Entry, _
                     Optional sFormType As String = "Add", _
                     Optional sTemplateSheetName As String = "FormStyles") As String()
'<<<
'purpose: given a set of definitions (taken from the global variable dDefinitions, generate
'       : all the entry widgets (labels, entry , view etc)
'param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'param  : sAction, String; user action that entrys need to be generated for (like NewLesson)
'param  : dDefaultValues (Optional), Dictionary; name/value pairs of fieldname and value
'param  : vValues (Optional), 2d string array, required when populating a ListForm
'param  : wbTmp (Optional), workbook that contains the sheet that form is to be written to
'param  : eWidgetType (Optional), defaults to Entry, needs to specify WidgetType to be generated
'param  : sFormType (Optional), defaults to Add, needs to specify the type of form to be generated
'rtype  : a list of the keys from the widgets that were created
'>>>
Dim sFuncName As String, sSheetName As String, sWidgetTypeSuffix As String, sFormatRangeNameSuffix As String
Dim iRow As Integer, iCol As Integer, iWidth As Integer, iHeight As Integer, iWidgetCount As Integer, iParentRowOffset As Integer, iParentColOffset As Integer, iListWidth As Integer
Dim rWidget As Range, rFormat As Range, rListHeader As Range, rListRow As Range, rListColumn As Range
Dim vDefinedEntryNamesRanges() As String, vKeySplits() As String, vGenerated() As String
Dim wbTarget As Workbook
Dim dDefnDetail As Dictionary
Dim lStartTick As Long

setup:
    'On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GenerateWidgets"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    ReDim vGenerated(0 To 20)
                
    sSheetName = sAction  'assume the Sheet name is equal to the Action (like NewLesson)
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
        
    If sFormType = "ViewList" Then
        Set wbTarget = CallByName(clsQuadRuntime, "ViewBook", VbGet)
    Else
        Set wbTarget = CallByName(clsQuadRuntime, sFormType & "Book", VbGet)
    End If
    
main:
    ' get location opf entry screens
    'vDefinedAddNamesRanges = GetSheetNamedRanges(clsQuadRuntime.TemplateBook, sTemplateSheetName, "f" & sFormType & EnumWidgetType(eWidgetType))
    vDefinedAddNamesRanges = GetWidgetLocationRanges(clsQuadRuntime.TemplateBook, sFormType, eWidgetType)
    
    ' get location of parent format
    'With clsQuadRuntime.TemplateSheet.Range("f" & sFormType)
    With clsQuadRuntime.TemplateBook.Names("f" & sFormType).RefersToRange
        iParentRowOffset = .Rows(1).Row - 1
        iParentColOffset = .Columns(1).Column - 1
    End With
    
    If IsEmptyArray(vDefinedAddNamesRanges) = True Then
        'FuncLogIt sFuncName, "No formats defined for [WidgetType" & EnumWidgetType(eWidgetType) & "]  [sAction=" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
        GoTo cleanup
    End If

    ' for each entry in the definition generate a input field
    With wbTmp.Sheets(sSheetName)
        .Range(.Cells(1, 1), .Cells(1, 1)).value = UCase(sAction)
     
        For Each sKey In dDefinitions.Keys()
        
            ' only go further if the definition matches the Widget type specified by passed param
            Set dDefnDetail = dDefinitions.Item(sKey)
            If dDefnDetail.Item("WidgetType") <> eWidgetType Then
                GoTo nextdefn
            End If
            
            vKeySplits = Split(sKey, "_")
            sWidgetTypeSuffix = Left(vKeySplits(0), 1)

            If Right(vKeySplits(0), Len(vKeySplits(0)) - 1) <> sAction Then
                GoTo nextdefn
            End If
            
            If InArray(Array("actions", "tables"), sKey) Then
                GoTo nextdefn
            End If
            
            Set rFormat = clsQuadRuntime.TemplateBook.Sheets(sTemplateSheetName).Range(vDefinedAddNamesRanges(iWidgetCount))
            
            iRow = rFormat.Row - iParentRowOffset
            iCol = rFormat.Column - iParentColOffset
            iWidth = rFormat.Columns.Count
            iHeight = rFormat.Rows.Count
            
            If iWidgetCount > UBound(vDefinedAddNamesRanges) Then
                err.Raise ErrorMsgType.FORMAT_NOT_DEFINED, Description:="cannot find a format for number [" & CStr(iWidgetCount) * "]"
            End If
            
            If sWidgetTypeSuffix = "e" Then
                Set rWidget = GenerateEntryWidget(CStr(sKey), iRow, iCol, sAction, sSheetName, wbTmp:=wbTmp)
                FormatWidget clsQuadRuntime.TemplateBook, wbTarget, CStr(sAction), rWidget, WidgetState.Invalid, sSourceSheetName:=clsQuadRuntime.TemplateWidgetSheetName, eWidgetType:=WidgetType.Entry
                dDefinitions.Item(sKey).Add "address", rWidget.Address
                UpdateDefaultValues CStr(sKey), dDefaultValues, sAction, rWidget
            ElseIf sWidgetTypeSuffix = "s" Then
                GenerateSelector clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, WidgetState.Invalid, clsQuadRuntime.TemplateWidgetSheetName, CStr(sKey)
            ElseIf sWidgetTypeSuffix = "b" Then
                GenerateButton clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, WidgetState.Invalid, clsQuadRuntime.TemplateWidgetSheetName, CStr(sKey)
            ElseIf sWidgetTypeSuffix = "t" Then
                Set rWidget = GenerateView(clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, clsQuadRuntime.TemplateWidgetSheetName, CStr(sKey))
                dDefinitions.Item(sKey).Add "address", rWidget.Address
                UpdateDefaultValues CStr(sKey), dDefaultValues, sAction, rWidget
            ElseIf sWidgetTypeSuffix = "l" Then

                If Is2DArray(vValues) = False Then
                    err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="Expecting a 2d string array got [" & MyVarType(vValues) & "] [sFormType=" & sFormType & "]"
                End If

                Set rListColumn = GenerateViewList(clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, clsQuadRuntime.TemplateWidgetSheetName, CStr(sKey), iHeight:=iHeight)
                    
                For iRow = 1 To UBound(vValues)
                        On Error Resume Next
                        rListColumn.Rows(iRow).value = vValues(iRow, iWidgetCount)
                        On Error GoTo 0
                Next iRow
            Else
                err.Raise 999, Description:="WidgetType suffix [" & sWidgetTypeSuffix & "] not implemented"
            End If
            
            vGenerated(iWidgetCount) = sKey
            iWidgetCount = iWidgetCount + 1

nextdefn:
        Next sKey
     End With

cleanup:
    If iWidgetCount = 0 Then
        ReDim vGenerated(0)
    Else
        ReDim Preserve vGenerated(iWidgetCount - 1)
    End If
    On Error GoTo 0
    GenerateWidgets = vGenerated
    If iWidgetCount > 0 Then
        FuncLogIt sFuncName, "Created [" & CStr(iWidgetCount) & "] widgets of type [" & EnumWidgetType(eWidgetType) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
    End If
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

    Exit Function

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "]  [sKey=" & sKey & "] [sAction=" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

Public Function GenerateViewList(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               sViewFormatSheetName As String, _
                               sKey As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1, _
                         Optional iHeight As Integer = 0) As Range
Dim sViewRangeName As String, sFieldName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iRow, iCol), .Cells(iRow + iHeight, iCol))
        sViewRangeName = sKey
        CreateNamedRange wbTargetbook, rWidget.Address, sSheetName, sViewRangeName, "True"
        
        'Set rLabel = rWidget.Offset(iEntryRowOffset, iEntryColOffset)
        'sFieldName = Split(sKey, "_")(1)
        'rLabel.value = sFieldName
        
    End With
    
    Set GenerateViewList = rWidget
    
    FormatWidget wbSourceBook, wbTargetbook, sSheetName, GenerateViewList, WidgetState.Invalid, sViewFormatSheetName, _
        WidgetType.ListText
    
End Function
Public Function GenerateView(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               sViewFormatSheetName As String, _
                               sKey As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1) As Range
Dim sViewRangeName As String, sFieldName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        sViewRangeName = sKey
        CreateNamedRange wbTargetbook, rWidget.Address, sSheetName, sViewRangeName, "True"
        
        Set rLabel = rWidget.Offset(iEntryRowOffset, iEntryColOffset)
        sFieldName = Split(sKey, "_")(1)
        rLabel.value = sFieldName
        
    End With
    
    Set GenerateView = rWidget
    
    FormatWidget wbSourceBook, wbTargetbook, sSheetName, GenerateView, WidgetState.Invalid, sViewFormatSheetName, _
        WidgetType.Text
    
End Function

Public Function GenerateButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               eButtonState As WidgetState, sButtonFormatSheetName As String, _
                               sKey As String) As Range
Dim sButtonRangeName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        'sButtonRangeName = "b" & sSheetName
        ' 4/25/18 to accomodate multi and dynamically defined buttons
        sButtonRangeName = sKey
        CreateNamedRange wbTargetbook, rWidget.Address, sSheetName, sButtonRangeName, "True"
    End With
    
    Set GenerateButton = rWidget
    
    FormatWidget wbSourceBook, wbTargetbook, sSheetName, GenerateButton, eButtonState, sButtonFormatSheetName
    
End Function

Public Function GenerateSelector(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               eSelectorState As WidgetState, sSelectorFormatSheetName As String, _
                               sKey As String) As Range
Dim sSelectorRangeName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        sSelectorRangeName = sKey
        CreateNamedRange wbTargetbook, rWidget.Address, sSheetName, sSelectorRangeName, "True"
    End With
    
    Set GenerateSelector = rWidget
    
    FormatWidget wbSourceBook, wbTargetbook, sSheetName, GenerateSelector, eSelectorState, sSelectorFormatSheetName, WidgetType.Selector
    
End Function


Public Sub ChangeButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                        sSheetName As String, iRow As Integer, iCol As Integer, _
                        eWidgetState As WidgetState, sButtonFormatSheetName As String, _
                        Optional bTakeFocus As Boolean = False)
Dim sButtonRangeName As String
Dim rCurrentFocus As Range
Dim rWidget As Range

    EventsToggle False
    With wbTargetbook.Sheets(sSheetName)
        Set rCurrentFocus = Selection
        Set rWidget = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
    End With

    FormatWidget wbSourceBook, wbTargetbook, sSheetName, rWidget, eWidgetState, sButtonFormatSheetName
    
    If bTakeFocus = False Then
        rCurrentFocus.Select
    End If
    EventsToggle True
    
End Sub
Function IsEntryValid(sSheetName As String, rTarget As Range) As Boolean
Dim cRGB As RGBColor
    Set cRGB = GetBgColor(sSheetName, rTarget)
    If cRGB.AsString <> C_RGB_VALID Then
        IsEntryValid = False
        Exit Function
    End If

    IsEntryValid = True

End Function
Public Function SetEntryValue(sAction As String, sFieldName As String, vValue As Variant, _
    Optional wbTmp As Workbook) As Integer
Dim dDefnDetails As Dictionary
Dim sEntryKey As String
Dim sFuncName As String

setup:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    sFuncName = C_MODULE_NAME & "." & "SetEntryValue"
    
    'sEntryKey = GetEntryKey(sAction, sFieldName)
    sEntryKey = GetKey(sAction, sFieldName)
    
                
    If dDefinitions.Exists(sEntryKey) = False Then
        FuncLogIt sFuncName, "range [" & sEntryKey & "] does not exist in sheet [" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
        SetEntryValue = -1
        Exit Function
    End If
    
    Set dDefnDetails = dDefinitions.Item(sEntryKey)
    With wbTmp.Sheets(sAction)
        .Range(dDefnDetails("address")).value = vValue
    End With
    
    SetEntryValue = 0
End Function

Public Function Validate(wbBook As Workbook, sSheetName As String, rTarget As Range) As Boolean
Dim sFuncName As String, sDefnName As String, sActionFuncName As String, sValidType As String
Dim dDefnDetail As Dictionary
Dim vValidParams() As String
Dim bValid As Boolean
Dim eThisErrorType As ErrorType
Dim mThisModule As VBComponent
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=False
    
    EventsToggle False
    'On Error GoTo err_name

    If UBound(Split(rTarget.name.name, "!")) = 1 Then
        sDefnName = Split(rTarget.name.name, "!")(1)
    Else
        sDefnName = rTarget.name.name
    End If
    On Error GoTo 0
    
    sFuncName = C_MODULE_NAME & "." & "Validate"
    
    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsQuadRuntime:=clsQuadRuntime
    End If
    
    If dDefinitions.Exists(sDefnName) = False Then
        ' usually called from tests, where dDefinitions is already set
        FuncLogIt sFuncName, "Loading definition for  in [" & sDefnName & "]", C_MODULE_NAME, _
            LogMsgType.Failure
    Else
        Set dDefnDetail = dDefinitions.Item(sDefnName)
        sValidType = dDefnDetail.Item("validation_type")
        sFuncName = dDefnDetail.Item("validation_param")
        If IsSet(dDefnDetail.Item("validation_args")) = True Then
            vValidParams = dDefnDetail.Item("validation_args")
        End If
        
        FuncLogIt sFuncName, "Using validation  [" & sValidType & "] [" & sFuncName & "]", C_MODULE_NAME, _
            LogMsgType.OK
        
        On Error GoTo err
        If IsSet(clsQuadRuntime) Then
            'first passed arg now needs to be clsQuadRuntime if IsSet
            Validate = Application.Run(sFuncName, clsQuadRuntime, rTarget.value, vValidParams)
        Else
            Validate = Application.Run(sFuncName, rTarget.value, dDefnDetail.Item("CacheTableName"), vValidParams)
        End If
        On Error GoTo 0
        
        If Validate = True Then
            SetBgColorFromString sSheetName, rTarget, C_RGB_VALID, wbTmp:=wbBook
            
            If dDefnDetail.Item("ActionName") <> "" Then
                sActionFuncName = Right(dDefnDetail.Item("ActionName"), Len(dDefnDetail.Item("ActionName")) - 1)
                Application.Run sActionFuncName, clsQuadRuntime, rTarget.value, rTarget.name.name
            End If
            
            Exit Function
        End If
    End If
    
    SetBgColorFromString sSheetName, rTarget, C_RGB_INVALID, wbTmp:=clsQuadRuntime.AddBook
    Validate = False
    EventsToggle True
    
    Exit Function

err:
    SetBgColorFromString sSheetName, rTarget, C_RGB_ERROR, wbTmp:=clsQuadRuntime.AddBook
    FuncLogIt sFuncName, "Error [" & err.Description & "]", C_MODULE_NAME, _
            LogMsgType.Failure
    Exit Function

err_name:
    FuncLogIt sFuncName, "Error with range name for [" & rTarget.Address & "} [" & err.Description & "]", C_MODULE_NAME, _
            LogMsgType.Failure
End Function


Public Sub FormatWidgetInvalid(sSheetName As String, rWidget As Range)
    SetBgColor sSheetName, rWidget, 255, 0, 0
End Sub
Public Sub FormatWidgetValid(sSheetName As String, rWidget As Range)
    SetBgColor sSheetName, rWidget, 0, 255, 0
End Sub

'Public Function IsValidInteger(ByVal iValue As Variant) As Boolean
Public Function IsValidInteger(ParamArray args()) As Boolean
Dim sFuncName As String
Dim iValueTmp As Integer
Dim iValue As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidInteger"
    iValue = args(1)

main:
    On Error GoTo err
    iValueTmp = Int(iValue)
    On Error GoTo 0
    IsValidInteger = True
    FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is valid", C_MODULE_NAME, LogMsgType.OK

    Exit Function
err:
    IsValidInteger = False
    FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is invalid ", C_MODULE_NAME, LogMsgType.OK

End Function
Public Function IsValidString(ParamArray args()) As Boolean
    IsValidString = True
End Function
Public Function IsValidPrep(ParamArray args()) As Boolean
Dim sFuncName As String
Dim aPreps() As String
Dim iValue As Variant
 
setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidPrep"
    iValue = args(1)
main:
    aPreps = Split(C_PREPS, ",")
    'If IsValidInteger(iValue) = True Then
    If IsValidInteger(args(0), args(1)) = True Then
    'If IsValidInteger(args(0), args(1), args(2)) = True Then
    
        If InArray(aPreps, iValue) = True Then
            IsValidPrep = True
            FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is valid", C_MODULE_NAME, LogMsgType.OK
            Exit Function
        End If
    End If
err:
    IsValidPrep = False
    FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is invalid", C_MODULE_NAME, LogMsgType.OK

End Function

Public Function IsMember(ParamArray args()) As Boolean
Dim sColumnRange As String, sLookUpTableName As String, sLookUpColumnName As String, sValue As String
Dim vValid2DValues() As Variant
Dim vValidValues() As String
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet

    Set clsQuadRuntime = args(0)
    sValue = args(1)
    sLookUpTableName = args(2)(0)
    sLookUpColumnName = args(2)(1)

    sColumnRange = GetDBColumnRange(sLookUpTableName, sLookUpColumnName)
    
    If Left(sLookUpTableName, 1) = "&" Then
        Set wsCache = Application.Run(Right(sLookUpTableName, Len(sLookUpTableName) - 1), clsQuadRuntime)
        vValidValues = ListFromRange(wsCache, sColumnRange)
    Else
        vValidValues = ListFromRange(clsQuadRuntime.CacheBook.Sheets(sLookUpTableName), sColumnRange)
    End If
    
    If InArray(vValidValues, sValue) = False Then
        IsMember = False
        Exit Function
    End If
    
    IsMember = True
End Function




Public Function GenerateEntryWidget(sKey As String, iLabelRow As Integer, iLabelCol As Integer, _
                                  sAction As String, sSheetName As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1, _
                         Optional wbTmp As Workbook) As Range
'<<<
'purpose: generate a specific entry Widget
'param  : sKey, String, named range to be applied to the new Widget (like eNewLesson_SFirstName)
'param  : iLabelCol, iLabelRow as integer, location of the entry Widget label (the actual entry is
'param  : iEntryRowOffset,iEntryColOffset as integer; where is the entry in relation to the label
'param  : sAction, String; user action that entrys need to be generated for (like NewLesson)
'>>>
Dim rWidget As Range, rLabel As Range
Dim sFieldName As String
Dim sFuncName As String

setup:
    On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GenerateEntryWidget"
    
main:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    With wbTmp.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iLabelRow, iLabelCol), .Cells(iLabelRow, iLabelCol))
        CreateNamedRange wbTmp, rWidget.Address, CStr(sAction), CStr(sKey), "True"
        
        Set rLabel = rWidget.Offset(iEntryRowOffset, iEntryColOffset)
        sFieldName = Split(sKey, "_")(1)
        rLabel.value = sFieldName
    End With

    Set GenerateEntryWidget = rWidget
    
cleanup:
    On Error GoTo 0
    Exit Function

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "]  [sKey=" & sKey & "] [sAction=" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

Public Sub DeleteEntry(sSheetName As String, sKey As Variant, Optional wbTmp As Workbook)
Dim sFuncName As String

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    sFuncName = C_MODULE_NAME & "." & "DeleteEntry"
    If Left(sKey, Len("e" & sSheetName)) = "e" & sSheetName Then
        DeleteNamedRange wbTmp, sSheetName, CStr(sKey)
    End If
        
End Sub



