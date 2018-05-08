Attribute VB_Name = "Widget_Utils"
'Sub FormatButton(sTargetSheetName As String, rButton As Range, eButtonState As ButtonState, Optional sSourceSheetName As String = C_CELL_STYLES_SHEET)
Const C_CELL_STYLES_SHEET = "CellStyles"

Enum WidgetRefCellNames
    fButtonInvalid = 1
    fButtonValid = 2
    fButtonPressed = 3
End Enum

Const C_WIDGET_REF_CELL_NAMES = "fButtonInvalid,fButtonValid,fButtonPressed"

Enum CellState
    Invalid = 1
    Pressed = 2
    Valid = 3
End Enum

Const C_CELL_STATE = "Invalid,Pressed,Valid"

Enum CellType
    Button = 1
    Entry = 2
    Text = 3
    ListText = 4
    Selector = 5
End Enum

Public Const C_CELL_TYPE = "Button,Entry,Text,ListText,Selector"

Enum CellDimension
    Hz = 1
    Vz = 2
End Enum

Const C_CELL_TYPE_STATE = "Entry,Button,Text,ListText,Selector"
Function EnumCellType(i As Long) As String
    EnumCellType = Split(C_CELL_TYPE, COMMA)(i - 1)
End Function
Function GetCellTypeFromValue(sValue As String) As Long
    On Error GoTo err
    GetCellTypeFromValue = IndexArray(Split(C_CELL_TYPE, COMMA), sValue) + 1
    If GetCellTypeFromValue = 0 Then
        GoTo err
    End If
    On Error GoTo 0
    Exit Function
    
err:
    err.Raise ErrorMsgType.INVALID_CELLTYPE, Description:="value [" & sValue & "] is not recognized"
    
End Function

Public Function GetCellSizes(wsTemplate As Worksheet, _
                             rSource As Range, _
                    Optional eCellDim As CellDimension = CellDimension.Hz) As Integer()
Dim aSizes() As Integer
Dim rCell As Range, rNewRange As Range
Dim iWidth As Integer, iHeight As Integer, iSizeCount As Integer
    GetRangeDimensions rSource, iWidth, iHeight
    
    ReDim aSizes(0 To 50)
    With wsTemplate
        'HERE
        '.Activate
        Set rNewRange = rSource.Resize(iHeight, iWidth)
        
        If eCellDim = Hz Then
            For Each rCell In rNewRange.Rows(1).Cells
                aSizes(iSizeCount) = rCell.EntireColumn.ColumnWidth
                iSizeCount = iSizeCount + 1
            Next rCell
        Else
            For Each rCell In rNewRange.Columns(1).Cells
                aSizes(iSizeCount) = rCell.EntireRow.RowHeight
                iSizeCount = iSizeCount + 1
            Next rCell
        End If
        ReDim Preserve aSizes(0 To iSizeCount - 1)
    End With
    
    GetCellSizes = aSizes
End Function

Public Function GetCellColWidthsORig(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
Dim aColumnWidths() As Integer
Dim rCell As Range

    ReDim aColumnWidths(0 To 20)
    With clsQuadRuntime.TemplateSheet
        .Activate
        For Each rCell In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rCell.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rCell
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetCellColWidths = aColumnWidths
End Function


Public Sub FormatCell(wbSourceBook As Workbook, _
                        wbTargetbook As Workbook, _
                        sTargetSheetName As String, _
                        rCell As Range, _
                        eCellState As CellState, _
                        sSourceSheetName As String, _
               Optional eCellType As CellType = CellType.Button)
Dim eWRefCName As String
    eWRefCName = "f" & Split(C_CELL_TYPE, COMMA)(eCellType - 1) & Split(C_CELL_STATE, COMMA)(eCellState - 1)
    CopyFormat wbSourceBook, wbTargetbook, sSourceSheetName, sTargetSheetName, eWRefCName, rCell.Address
End Sub

'add format EntryCell here to copy formats for entry cells

'Public Function GetScheduleCellColWidths(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
'                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell


Public Sub FormatColRowSize(wbSourceBook As Workbook, _
                            wbTargetbook As Workbook, _
                            sTargetSheetName As String, _
                            sSourceSheetName As String, _
                            sSourceRangeName As String, _
                   Optional iTargetFirstRow As Integer = 1, _
                   Optional iTargetFirstCol As Integer = 1)

Dim aColumnWidths() As Integer, aRowHeights() As Integer
Dim iColWidthCount As Integer, iRowHeightCount As Integer, iRow As Integer, iCol As Integer, iFormatRowCount As Integer, iFormatColCount As Integer
Dim rCell As Range, rTargetRange As Range, rSourceRange As Range
Dim wsTemplateSheet As Worksheet, wsTargetSheet As Worksheet

    Set wsTargetSheet = wbTargetbook.Sheets(sTargetSheetName)
    Set wsTemplateSheet = wbSourceBook.Sheets(sSourceSheetName)
    
    Set rSourceRange = wsTemplateSheet.Range(sSourceRangeName)
    
    aColumnWidths = GetCellSizes(wsTemplateSheet, rSourceRange)
    aRowHeights = GetCellSizes(wsTemplateSheet, rSourceRange, eCellDim:=CellDimension.Vz)
    
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

Public Function GenerateWidgets(clsQuadRuntime As Quad_Runtime, _
                              sAction As String, _
                     Optional dDefaultValues As Dictionary, _
                     Optional vValues As Variant, _
                     Optional wbTmp As Workbook, _
                     Optional eCellType As CellType = CellType.Entry, _
                     Optional sFormType As String = "Add") As String()
'<<<
'purpose: given a set of definitions (taken from the global variable dDefinitions, generate
'       : all the entry widgets (labels, entry , view etc)
'param  : clsQuadRuntime, Quad_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'param  : sAction, String; user action that entrys need to be generated for (like NewLesson)
'param  : dDefaultValues (Optional), Dictionary; name/value pairs of fieldname and value
'param  : vValues (Optional), 2d string array, required when populating a ListForm
'param  : wbTmp (Optional), workbook that contains the sheet that form is to be written to
'param  : eCellType (Optional), defaults to Entry, needs to specify CellType to be generated
'param  : sFormType (Optional), defaults to Add, needs to specify the type of form to be generated
'rtype  : a list of the keys from the widgets that were created
'>>>
Dim sFuncName As String, sSheetName As String, sCellTypeSuffix As String
Dim iRow As Integer, iCol As Integer, iWidth As Integer, iHeight As Integer, iWidgetCount As Integer, iParentRowOffset As Integer, iParentColOffset As Integer, iListWidth As Integer
Dim rCell As Range, rFormat As Range, rListHeader As Range, rListRow As Range, rListColumn As Range
Dim vDefinedEntryNamesRanges() As String, vKeySplits() As String, vGenerated() As String
Dim wbTarget As Workbook
Dim dDefnDetail As Dictionary

setup:
    'On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GenerateWidgets"
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
    vDefinedAddNamesRanges = GetSheetNamedRanges(clsQuadRuntime.TemplateBook, "FormStyles", "f" & sFormType & EnumCellType(eCellType))
    
    ' get location of parent format
    With clsQuadRuntime.TemplateSheet.Range("f" & sFormType)
        iParentRowOffset = .Rows(1).Row - 1
        iParentColOffset = .Columns(1).Column - 1
    End With
    
    If IsEmptyArray(vDefinedAddNamesRanges) = True Then
        'FuncLogIt sFuncName, "No formats defined for [CellType" & EnumCellType(eCellType) & "]  [sAction=" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
        GoTo cleanup
    End If

    ' for each entry in the definition generate a input field
    With wbTmp.Sheets(sSheetName)
        .Range(.Cells(1, 1), .Cells(1, 1)).value = UCase(sAction)
     
        For Each sKey In dDefinitions.Keys()
        
            ' only go further if the definition matches the cell type specified by passed param
            Set dDefnDetail = dDefinitions.Item(sKey)
            If dDefnDetail.Item("cell_type") <> eCellType Then
                GoTo nextdefn
            End If
            
            vKeySplits = Split(sKey, "_")
            sCellTypeSuffix = Left(vKeySplits(0), 1)

            If Right(vKeySplits(0), Len(vKeySplits(0)) - 1) <> sAction Then
                GoTo nextdefn
            End If
            
            If InArray(Array("actions", "tables"), sKey) Then
                GoTo nextdefn
            End If
            
            Set rFormat = clsQuadRuntime.TemplateSheet.Range(vDefinedAddNamesRanges(iWidgetCount))
            iRow = rFormat.Row - iParentRowOffset
            iCol = rFormat.Column - iParentColOffset
            iWidth = rFormat.Columns.Count
            iHeight = rFormat.Rows.Count
            
            If iWidgetCount > UBound(vDefinedAddNamesRanges) Then
                err.Raise ErrorMsgType.FORMAT_NOT_DEFINED, Description:="cannot find a format for number [" & CStr(iWidgetCount) * "]"
            End If
            
            If sCellTypeSuffix = "e" Then
                Set rCell = GenerateEntryCell(CStr(sKey), iRow, iCol, sAction, sSheetName, wbTmp:=wbTmp)
                FormatCell clsQuadRuntime.TemplateBook, wbTarget, CStr(sAction), rCell, CellState.Invalid, sSourceSheetName:=clsQuadRuntime.TemplateCellSheetName, eCellType:=CellType.Entry
                dDefinitions.Item(sKey).Add "address", rCell.Address
                UpdateDefaultValues CStr(sKey), dDefaultValues, sAction, rCell
            ElseIf sCellTypeSuffix = "s" Then
                GenerateSelector clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, CellState.Invalid, clsQuadRuntime.TemplateCellSheetName, CStr(sKey)
            ElseIf sCellTypeSuffix = "b" Then
                GenerateButton clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, CellState.Invalid, clsQuadRuntime.TemplateCellSheetName, CStr(sKey)
            ElseIf sCellTypeSuffix = "t" Then
                Set rCell = GenerateView(clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, clsQuadRuntime.TemplateCellSheetName, CStr(sKey))
                dDefinitions.Item(sKey).Add "address", rCell.Address
                UpdateDefaultValues CStr(sKey), dDefaultValues, sAction, rCell
            ElseIf sCellTypeSuffix = "l" Then

                If Is2DArray(vValues) = False Then
                    err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="Expecting a 2d string array got [" & MyVarType(vValues) & "] [sFormType=" & sFormType & "]"
                End If

                Set rListColumn = GenerateViewList(clsQuadRuntime.TemplateBook, wbTarget, sAction, iRow, iCol, clsQuadRuntime.TemplateCellSheetName, CStr(sKey), iHeight:=iHeight)
                    
                For iRow = 1 To UBound(vValues)
                        On Error Resume Next
                        rListColumn.Rows(iRow).value = vValues(iRow, iWidgetCount)
                        On Error GoTo 0
                Next iRow
            Else
                err.Raise 999, Description:="CellType suffix [" & sCellTypeSuffix & "] not implemented"
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
        FuncLogIt sFuncName, "Created [" & CStr(iWidgetCount) & "] widgets of type [" & EnumCellType(eCellType) & "]", C_MODULE_NAME, LogMsgType.Error
    End If
    
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
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow + iHeight, iCol))
        sViewRangeName = sKey
        CreateNamedRange wbTargetbook, rCell.Address, sSheetName, sViewRangeName, "True"
        
        'Set rLabel = rCell.Offset(iEntryRowOffset, iEntryColOffset)
        'sFieldName = Split(sKey, "_")(1)
        'rLabel.value = sFieldName
        
    End With
    
    Set GenerateViewList = rCell
    
    FormatCell wbSourceBook, wbTargetbook, sSheetName, GenerateViewList, CellState.Invalid, sViewFormatSheetName, _
        CellType.ListText
    
End Function
Public Function GenerateView(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               sViewFormatSheetName As String, _
                               sKey As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1) As Range
Dim sViewRangeName As String, sFieldName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        sViewRangeName = sKey
        CreateNamedRange wbTargetbook, rCell.Address, sSheetName, sViewRangeName, "True"
        
        Set rLabel = rCell.Offset(iEntryRowOffset, iEntryColOffset)
        sFieldName = Split(sKey, "_")(1)
        rLabel.value = sFieldName
        
    End With
    
    Set GenerateView = rCell
    
    FormatCell wbSourceBook, wbTargetbook, sSheetName, GenerateView, CellState.Invalid, sViewFormatSheetName, _
        CellType.Text
    
End Function

Public Function GenerateButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               eButtonState As CellState, sButtonFormatSheetName As String, _
                               sKey As String) As Range
Dim sButtonRangeName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        'sButtonRangeName = "b" & sSheetName
        ' 4/25/18 to accomodate multi and dynamically defined buttons
        sButtonRangeName = sKey
        CreateNamedRange wbTargetbook, rCell.Address, sSheetName, sButtonRangeName, "True"
    End With
    
    Set GenerateButton = rCell
    
    FormatCell wbSourceBook, wbTargetbook, sSheetName, GenerateButton, eButtonState, sButtonFormatSheetName
    
End Function

Public Function GenerateSelector(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               eSelectorState As CellState, sSelectorFormatSheetName As String, _
                               sKey As String) As Range
Dim sSelectorRangeName As String

   With wbTargetbook.Sheets(sSheetName)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        sSelectorRangeName = sKey
        CreateNamedRange wbTargetbook, rCell.Address, sSheetName, sSelectorRangeName, "True"
    End With
    
    Set GenerateSelector = rCell
    
    FormatCell wbSourceBook, wbTargetbook, sSheetName, GenerateSelector, eSelectorState, sSelectorFormatSheetName, CellType.Selector
    
End Function


Public Sub ChangeButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                        sSheetName As String, iRow As Integer, iCol As Integer, _
                        eCellState As CellState, sButtonFormatSheetName As String, _
                        Optional bTakeFocus As Boolean = False)
Dim sButtonRangeName As String
Dim rCurrentFocus As Range
Dim rCell As Range

    EventsToggle False
    With wbTargetbook.Sheets(sSheetName)
        Set rCurrentFocus = Selection
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
    End With

    FormatCell wbSourceBook, wbTargetbook, sSheetName, rCell, eCellState, sButtonFormatSheetName
    
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
    
    sEntryKey = GetEntryKey(sAction, sFieldName)
                
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
            Validate = Application.Run(sFuncName, rTarget.value, dDefnDetail.Item("db_table_name"), vValidParams)
        End If
        On Error GoTo 0
        
        If Validate = True Then
            'SetBgColorFromString sSheetName, rTarget, C_RGB_VALID, wbTmp:=clsQuadRuntime.AddBook
            SetBgColorFromString sSheetName, rTarget, C_RGB_VALID, wbTmp:=wbBook
            
            If dDefnDetail.Item("action_func") <> "" Then
                sActionFuncName = Right(dDefnDetail.Item("action_func"), Len(dDefnDetail.Item("action_func")) - 1)
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


Public Sub FormatCellInvalid(sSheetName As String, rCell As Range)
    SetBgColor sSheetName, rCell, 255, 0, 0
End Sub
Public Sub FormatCellValid(sSheetName As String, rCell As Range)
    SetBgColor sSheetName, rCell, 0, 255, 0
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


Function GetKey(sSheetName As String, sFieldName As String, Optional eCellType As CellType = CellType.Entry) As String
Dim sKeySuffix As String
    If eCellType = CellType.Entry Then
        eKeySuffix = "e"
    ElseIf eCellType = CellType.Button Then
        eKeySuffix = "b"
    ElseIf eCellType = CellType.Text Then
        eKeySuffix = "t"
    ElseIf eCellType = CellType.ListText Then
        eKeySuffix = "l"
    ElseIf eCellType = CellType.Selector Then
        eKeySuffix = "s"
    End If
    
    GetKey = eKeySuffix & sSheetName & "_" & sFieldName
    
End Function
Function GetEntryKey(sSheetName As String, sFieldName As String) As String
Dim sKey As String

    sKey = "e" & sSheetName & "_" & sFieldName
    GetEntryKey = sKey
End Function

Public Function GenerateEntryCell(sKey As String, iLabelRow As Integer, iLabelCol As Integer, _
                                  sAction As String, sSheetName As String, _
                         Optional iEntryRowOffset As Integer = 0, _
                         Optional iEntryColOffset As Integer = -1, _
                         Optional wbTmp As Workbook) As Range
'<<<
'purpose: generate a specific entry cell
'param  : sKey, String, named range to be applied to the new cell (like eNewLesson_SFirstName)
'param  : iLabelCol, iLabelRow as integer, location of the entry cell label (the actual entry is
'param  : iEntryRowOffset,iEntryColOffset as integer; where is the entry in relation to the label
'param  : sAction, String; user action that entrys need to be generated for (like NewLesson)
'>>>
Dim rCell As Range, rLabel As Range
Dim sFieldName As String
Dim sFuncName As String

setup:
    On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GenerateEntryCell"
    
main:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    With wbTmp.Sheets(sSheetName)
        Set rCell = .Range(.Cells(iLabelRow, iLabelCol), .Cells(iLabelRow, iLabelCol))
        CreateNamedRange wbTmp, rCell.Address, CStr(sAction), CStr(sKey), "True"
        
        Set rLabel = rCell.Offset(iEntryRowOffset, iEntryColOffset)
        sFieldName = Split(sKey, "_")(1)
        rLabel.value = sFieldName
    End With

    Set GenerateEntryCell = rCell
    
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

