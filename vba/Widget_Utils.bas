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
    Schedule = 6
    ListEntry = 7
End Enum

Public Const C_WIDGET_TYPE = "Button,Entry,Text,ListText,Selector,Schedule,ListEntry"

Enum WidgetDimension
    Hz = 1
    Vz = 2
End Enum

Const C_WIDGET_TYPE_STATE = "Entry,Button,Text,ListText,Selector,ListEntry"
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
    
    ReDim aSizes(0 To 75)
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

Public Function GetWidgetColWidthsORig(clsAppRuntime As App_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
Dim aColumnWidths() As Integer
Dim rWidget As Range

    ReDim aColumnWidths(0 To 20)
    With clsAppRuntime.TemplateSheet
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

'Public Function GetScheduleWidgetColWidths(clsAppRuntime As App_Runtime, sScheduleFormatRangeName As String, _
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
Dim lStartTick As Long
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "FormatColRowSize"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err

main:
    Set wsTargetSheet = wbTargetbook.Sheets(sTargetSheetName)
    Set wsTemplateSheet = wbSourceBook.Names(sSourceRangeName).RefersToRange.Parent

    Set rSourceRange = wsTemplateSheet.Range(sSourceRangeName)
    
    aColumnWidths = GetWidgetSizes(wsTemplateSheet, rSourceRange)
    aRowHeights = GetWidgetSizes(wsTemplateSheet, rSourceRange, eWidgetDim:=WidgetDimension.Vz)
    
    With wsTargetSheet
        Set rTargetRange = .Range(.Cells(iTargetFirstRow, iTargetFirstCol), _
                    .Cells(iTargetFirstRow + UBound(aRowHeights), _
                           iTargetFirstCol + UBound(aColumnWidths)))
    End With
    
    For iRow = 1 To UBound(aRowHeights) + 1
        rTargetRange.Rows(iRow).EntireRow.RowHeight = aRowHeights(iRow - 1)
    Next iRow
    
    For iCol = 1 To UBound(aColumnWidths) + 1
        rTargetRange.Columns(iCol).EntireColumn.ColumnWidth = aColumnWidths(iCol - 1)
    Next iCol
    
cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Sub

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "] ", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
    
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
    
    FuncLogIt sFuncName, " [wbTmp" & wbTmp.Name & "] [sFormType=" & sFormType & "] [eWidgetType=" & EnumWidgetType(eWidgetType) & "] [Result=" & CStr(UBound(GetWidgetLocationRanges) + 1) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

Public Function GenerateWidgets(dArgs As Dictionary) As String()
'Public Function GenerateWidgets(clsAppRuntime As App_Runtime, _
'                              sAction As String, _
'                     Optional dDefaultValues As Dictionary, _
'                     Optional vValues As Variant, _
'                     Optional wbTmp As Workbook, _
'                     Optional eWidgetType As WidgetType = WidgetType.Entry, _
'                     Optional sFormType As String = "Add", _
'                     Optional sTemplateSheetName As String = "FormStyles", _
'                     Optional iRecordID As Integer) As String()
'<<<
'purpose: given a set of definitions (taken from the global variable dDefinitions, generate
'       : all the entry widgets (labels, entry , view etc)
'param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'param  : sAction, String; user action that entrys need to be generated for (like NewLesson)
'param  : dDefaultValues (Optional), Dictionary; name/value pairs of fieldname and value
'param  : vValues (Optional), 2d string array, required when populating a ListForm
'param  : wbTmp (Optional), workbook that contains the sheet that form is to be written to
'param  : eWidgetType (Optional), defaults to Entry, needs to specify WidgetType to be generated
'param  : sFormType (Optional), defaults to Add, needs to specify the type of form to be generated
'rtype  : a list of the keys from the widgets that were created
'>>>
Dim sFuncName As String, sSheetName As String, sWidgetTypeSuffix As String, sFormatRangeNameSuffix As String, sTemplateSheetName As String, sFormType As String, sAction As String, sHeaderRangeName As String
Dim iRow As Integer, iCol As Integer, iWidth As Integer, iHeight As Integer, iWidgetCount As Integer, iParentRowOffset As Integer, iParentColOffset As Integer, iListWidth As Integer, iHeaderRow As Integer, iHeaderCol As Integer
Dim rWidget As Range, rFormat As Range, rListHeader As Range, rListRow As Range, rListColumn As Range, rHeaderFormatRange As Range, rFilterFormatRange As Range
Dim vDefinedEntryNamesRanges() As String, vKeySplits() As String, vGenerated() As String
Dim wbTarget As Workbook, wbTmp As Workbook
Dim dDefnDetail As Dictionary, dDefaultValues As Dictionary
Dim lStartTick As Long
Dim vValues As Variant
Dim eWidgetType As WidgetType

unpackargs:
    Set clsAppRuntime = dArgs("clsAppRuntime")

    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    If dArgs.Exists("sFormType") Then
        ' generating a specific form not all defined
        sFormType = dArgs.Item("sFormType")
    Else
        sFormType = "Add"
    End If
    
    If dArgs.Exists("eWidgetType") Then
        ' generating a specific form not all defined
        eWidgetType = dArgs.Item("eWidgetType")
    Else
        eWidgetType = WidgetType.Entry
    End If
    
    If dArgs.Exists("sTemplateSheetName") Then
        ' generating a specific form not all defined
        sTemplateSheetName = dArgs.Item("sTemplateSheetName")
    Else
        sTemplateSheetName = "FormStyles"
    End If
    
    If dArgs.Exists("dDefaultValues") Then
        ' generating a specific form not all defined
        Set dDefaultValues = dArgs.Item("dDefaultValues")
    End If
    
    'Set dDefaultValues = dArgs.Item("dDefaultValues")
    vValues = dArgs.Item("vValues")
    Set wbTmp = dArgs.Item("wbTmp")
    iRecordID = dArgs.Item("iRecordID")
    'eWidgetType = dArgs.Item("eWidgetType")
    sAction = dArgs.Item("sAction")
    
setup:
    On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GenerateWidgets"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    ReDim vGenerated(0 To 20)
                
    sSheetName = sAction  'assume the Sheet name is equal to the Action (like NewLesson)
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
        
    If sFormType = "ViewList" Or sFormType = "ViewListEntry" Then
        Set wbTarget = CallByName(clsAppRuntime, "ViewBook", VbGet)
    ElseIf sFormType = "ViewSchedule" Then
        Set wbTarget = CallByName(clsAppRuntime, "ScheduleBook", VbGet)
    Else
        Set wbTarget = CallByName(clsAppRuntime, sFormType & "Book", VbGet)
    End If
    
main:
    ' get location opf entry screens
    'vDefinedAddNamesRanges = GetSheetNamedRanges(clsAppRuntime.TemplateBook, sTemplateSheetName, "f" & sFormType & EnumWidgetType(eWidgetType))
    vDefinedAddNamesRanges = GetWidgetLocationRanges(clsAppRuntime.TemplateBook, sFormType, eWidgetType)
    
    ' get location of parent format
    'With clsAppRuntime.TemplateSheet.Range("f" & sFormType)
    With clsAppRuntime.TemplateBook.Names("f" & sFormType).RefersToRange
        iParentRowOffset = .Rows(1).Row - 1
        iParentColOffset = .Columns(1).Column - 1
    End With
    
    If IsEmptyArray(vDefinedAddNamesRanges) = True Then
        'FuncLogIt sFuncName, "No formats defined for [WidgetType" & EnumWidgetType(eWidgetType) & "]  [sAction=" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
        GoTo cleanup
    End If

    ' get header location if one exists
    sHeaderRangeName = "f" & sFormType & "Header"
    'On Error Resume Next
    If NamedRangeExists(clsAppRuntime.TemplateBook, sTemplateSheetName, sHeaderRangeName, bLocalScope:=False) = True Then
        Set rHeaderFormatRange = clsAppRuntime.TemplateBook.Sheets(sTemplateSheetName).Range(sHeaderRangeName)
    End If
    'On Error GoTo 0
    
    ' get filter location if one exists
    'sFilterRangeName = "f" & sFormType & "Filter"
    'On Error Resume Next
    'Set rFilterFormatRange = clsAppRuntime.TemplateBook.Sheets(sTemplateSheetName).Range(sFilterRangeName)
    'CreateFilter wbTarget, sSheetName, rFilterFormatRange, 100
    'On Error GoTo 0
    
    ' for each entry in the definition generate a input field
    With wbTmp.Sheets(sSheetName)
        .Range(.Cells(1, 1), .Cells(1, 1)).value = UCase(sAction)
     
        For Each sKey In dDefinitions.Keys()
        
            ' only go further if named range has not been created previously or its a view widget as we are likely updating
            If NamedRangeExists(wbTmp, sSheetName, CStr(sKey)) = True Then
                If GetFormTypeFromRangeName(CStr(sKey)) <> FormType.View And GetFormTypeFromRangeName(CStr(sKey)) <> FormType.ViewList Then
                    FuncLogIt sFuncName, "Skipping as  [key=" & CStr(sKey) & "] exists already ", C_MODULE_NAME, LogMsgType.DEBUGGING
                    GoTo nextdefn
                End If
            End If
            
            ' only go further if the definition matches the Widget type specified by passed param
            Set dDefnDetail = dDefinitions.Item(sKey)
            If dDefnDetail.Item("WidgetType") <> eWidgetType Then
                GoTo nextdefn
            End If
            
            vKeySplits = Split(sKey, "_")
            sWidgetTypeSuffix = Left(vKeySplits(0), 1)

            If GetActionFromWidgetKey(sKey) <> sAction Then
                GoTo nextdefn
            End If

            If InArray(Array("actions", "tables"), sKey) Then
                GoTo nextdefn
            End If
            
            'not picking up format correctly
            
            Set rFormat = clsAppRuntime.TemplateBook.Sheets(sTemplateSheetName).Range(vDefinedAddNamesRanges(iWidgetCount))
            
            iRow = rFormat.Row - iParentRowOffset
            iCol = rFormat.Column - iParentColOffset

            iWidth = rFormat.Columns.Count
            iHeight = rFormat.Rows.Count
            
            If iWidgetCount > UBound(vDefinedAddNamesRanges) Then
                err.Raise ErrorMsgType.FORMAT_NOT_DEFINED, Description:="cannot find a format for number [" & CStr(iWidgetCount) * "]"
            End If
            
            If sWidgetTypeSuffix = "e" Then
        
                If GetFormTypeFromAction(sAction) <> "ViewListEntry" Then
                    Set rWidget = GenerateEntryWidget(CStr(sKey), iRow, iCol, sAction, sSheetName, wbTmp:=wbTmp)
                Else
                    Set rWidget = GenerateEntryWidget(CStr(sKey), iRow, iCol, sAction, sSheetName, wbTmp:=wbTmp, iEndLabelRowOffset:=iHeight)
                    
                    If IsSet(rHeaderFormatRange) = True Then
                        Set rHeaderCell = rHeaderFormatRange.Columns(iWidgetCount + LBound(vValues, 2))
                        iHeaderRow = rHeaderCell.Row - iParentRowOffset
                        iHeaderCol = rHeaderCell.Column - iParentColOffset
                        'Debug.Print wbTmp.Sheets(sSheetName).Range(.Cells(iHeaderRow, iHeaderCol), .Cells(iHeaderRow, iHeaderCol)).Address
                        
                        wbTmp.Sheets(sSheetName).Range(.Cells(iHeaderRow, iHeaderCol), .Cells(iHeaderRow, iHeaderCol)).value = GetFieldName(CStr(sKey))
                    End If
                    
                    For iRow = 1 To UBound(vValues)
                        rWidget.Rows(iRow).value = vValues(iRow, iWidgetCount + LBound(vValues, 2))
                    Next iRow
                End If
            
                FormatWidget clsAppRuntime.TemplateBook, wbTarget, CStr(sAction), rWidget, WidgetState.Invalid, sSourceSheetName:=clsAppRuntime.TemplateWidgetSheetName, _
                            eWidgetType:=WidgetType.Entry
                AddDict dDefinitions.Item(sKey), "address", rWidget.Address, bUpdate:=True
                UpdateDefaultValues CStr(sKey), dDefaultValues, sAction, rWidget
            ElseIf sWidgetTypeSuffix = "s" Then
                GenerateSelector clsAppRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, WidgetState.Invalid, clsAppRuntime.TemplateWidgetSheetName, CStr(sKey)
            ElseIf sWidgetTypeSuffix = "b" Then
                GenerateButton clsAppRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, WidgetState.Invalid, clsAppRuntime.TemplateWidgetSheetName, CStr(sKey)
            ElseIf sWidgetTypeSuffix = "t" Then
                Set rWidget = GenerateView(clsAppRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, clsAppRuntime.TemplateWidgetSheetName, CStr(sKey))
                dDefinitions.Item(sKey).Add "address", rWidget.Address
                UpdateDefaultValues CStr(sKey), dDefaultValues, sAction, rWidget
                
             ElseIf sWidgetTypeSuffix = "c" Then
                
                AddArgs dArgs, False, "sSheetName", sAction, "wbTarget", wbTarget, "eQuadSubDataType", QuadSubDataType.Student, "iPersonID", iRecordID
                BuildScheduleViewFromValues dArgs
                
            ElseIf sWidgetTypeSuffix = "l" Then

                If Is2DArray(vValues) = False Then
                    err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="Expecting a 2d string array got [" & MyVarType(vValues) & "] [sFormType=" & sFormType & "]"
                End If

                Set rListColumn = GenerateViewList(clsAppRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, clsAppRuntime.TemplateWidgetSheetName, CStr(sKey), iHeight:=iHeight)

                For iRow = 1 To UBound(vValues)
                    rListColumn.Rows(iRow).value = vValues(iRow, iWidgetCount + LBound(vValues, 2))
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
    AddDict dArgs, "result", vGenerated, True
    If iWidgetCount > 0 Then
        FuncLogIt sFuncName, "Created [" & CStr(iWidgetCount) & "] widgets of type [" & EnumWidgetType(eWidgetType) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
    End If
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

    Exit Function

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "]  [sKey=" & sKey & "] [sAction=" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
    'err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

Public Function GenerateViewList(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               sViewFormatSheetName As String, _
                               sKey As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1, _
                         Optional iHeight As Integer = 0) As Range
Dim sViewRangeName As String, sFieldName As String
Dim lStartTick As Long
Dim rWidget As Range

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateViewList"
    lStartTick = FuncLogIt(sFuncName, "[sSheetName=" & sSheetName & "] [sKey=" & sKey & "]", C_MODULE_NAME, LogMsgType.INFUNC)

main:

    With wbTargetbook.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iRow, iCol), .Cells(iRow + iHeight, iCol))
            
        If NamedRangeExists(wbTargetbook, sSheetName, sKey) = False Then

            sViewRangeName = sKey
            CreateNamedRange wbTargetbook, rWidget.Address, sSheetName, sViewRangeName, "True"
        
            FormatWidget wbSourceBook, wbTargetbook, sSheetName, rWidget, WidgetState.Invalid, sViewFormatSheetName, _
                WidgetType.ListText
        Else
            FuncLogIt sFuncName, "Skipping as named range [key=" & CStr(sKey) & "] exists already ", C_MODULE_NAME, LogMsgType.DEBUGGING2
        End If
        
        Set GenerateViewList = rWidget
    End With
        
        
cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
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
Dim cRGB As rgbColor
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
    sEntryKey = GetWidgetKey(sAction, sFieldName)
    
                
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

Public Sub FormatWidgetInvalid(sSheetName As String, rWidget As Range)
    SetBgColor sSheetName, rWidget, 255, 0, 0
End Sub
Public Sub FormatWidgetValid(sSheetName As String, rWidget As Range)
    SetBgColor sSheetName, rWidget, 0, 255, 0
End Sub


Public Function GenerateEntryWidget(sKey As String, iLabelRow As Integer, iLabelCol As Integer, _
                                  sAction As String, sSheetName As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1, _
                         Optional wbTmp As Workbook, _
                         Optional iEndLabelRowOffset As Integer = 0) As Range
'<<<
'purpose: generate a specific entry Widget
'param  : sKey, String, named range to be applied to the new Widget (like eNewLesson_SFirstName)
'param  : iLabelCol, iLabelRow as integer, location of the entry Widget label (the actual entry is
'param  : iEntryRowOffset,iEntryColOffset as integer; where is the entry in relation to the label
'param  : sAction, String; user action that entrys need to be generated for (like NewLesson)
'>>>
Dim rWidget As Range, rLabel As Range, rCell As Range
Dim sFieldName As String
Dim sFuncName As String
Dim i As Integer

setup:
    On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GenerateEntryWidget"
    
main:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    

    
    With wbTmp.Sheets(sSheetName)
        Set rWidget = .Range(.Cells(iLabelRow, iLabelCol), .Cells(iLabelRow + iEndLabelRowOffset, iLabelCol))
        CreateNamedRange wbTmp, rWidget.Address, CStr(sAction), CStr(sKey), "True"
        
        Set rLabel = rWidget.Offset(iEntryRowOffset, iEntryColOffset)
        sFieldName = GetFieldName(sKey)
        
        If GetFormTypeFromAction(sAction) <> "ViewListEntry" Then
            rLabel.value = sFieldName
        Else
            'For i = 1 To rWidget.Rows.Count
                'CreateNamedRange wbTmp, rWidget.Rows(i).Address, CStr(sAction), CStr(sKey) & "__" & CStr(i), "True"
                'CreateNamedRange wbTmp, rWidget.Rows(i).Address, CStr(sAction), CStr(sKey) & "__" & CStr(i), "True"
            'Next i
        End If
        
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



