Attribute VB_Name = "Entry_Utils"
Const C_LIST_TYPE_SHEET = "list_types"
Const C_MODULE_NAME = "Entry_Utils"
Const C_PREPS = "1,2,3,4,5"
Const C_GOBUTTON_ROW = 2
Const C_GOBUTTON_COL = 8

Enum FieldType
    Number = 1
    NumberFormula = 2
    text = 3
    List = 4
End Enum

Enum ListType
    Students = 1
    Teachers = 2
End Enum

Enum NumberRangeType
    gt0lt100 = 1
    gt10lte20 = 2
End Enum

Enum ErrorType
    NotAnInteger = 1
    NotValidPrep = 2
End Enum

Const C_RGB_VALID = "0,255,0"
Const C_RGB_INVALID = "255,0,0"
Const C_RGB_ERROR = "242,242,242"

Public dDefinitions As Dictionary
Function IsEntryValid(sSheetName As String, rTarget As Range) As Boolean
Dim cRGB As RGBColor
    Set cRGB = GetBgColor(sSheetName, rTarget)
    If cRGB.AsString <> C_RGB_VALID Then
        IsEntryValid = False
        Exit Function
    End If

    IsEntryValid = True

End Function
Public Function SetEntryValue(sAction As String, sFieldName As String, vValue As Variant) As Integer
Dim dDefnDetails As Dictionary
Dim sEntryKey As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SetEntryValue"
    
    sEntryKey = GetEntryKey(sAction, sFieldName)
                
    If dDefinitions.Exists(sEntryKey) = False Then
        FuncLogIt sFuncName, "range [" & sEntryKey & "] does not exist in sheet [" & sAction & "]", C_MODULE_NAME, LogMsgType.Error
        SetEntryValue = -1
        Exit Function
    End If
    
    Set dDefnDetails = dDefinitions.Item(sEntryKey)
    With ActiveWorkbook.Sheets(sAction)
        .Range(dDefnDetails("address")).value = vValue
    End With
    
    SetEntryValue = 0
End Function
Public Function GetRecordValuesAsDict(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                sSheetName As String) As Dictionary
Dim rEntryCell As Range
Dim sFuncName As String, sActionName As String, sFieldName As String
Dim dValues As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "GetRecordValuesAsDict"

main:

    aNames = GetSheetNamedRanges(wbTargetbook, sSheetName)
    For Each name_ In aNames
        sActionName = Split(name_, "_")(0)
        If sActionName = "e" & sSheetName Then
            sFieldName = Split(name_, "_")(1)
            Set rEntryCell = ActiveWorkbook.Sheets(sSheetName).Range(name_)
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

setup:
    sFuncName = C_MODULE_NAME & "." & "IsRecordValid"

main:

    aNames = GetSheetNamedRanges(wbTargetbook, sSheetName)
    For Each name_ In aNames
        If Split(name_, "_")(0) = "e" & sSheetName Then
            Set rEntryCell = ActiveWorkbook.Sheets(sSheetName).Range(name_)
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
    FuncLogIt sFuncName, "Entry Form  [" & sSheetName & "] is valid", C_MODULE_NAME, LogMsgType.INFO

    ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, _
        CellState.Valid, sSourceSheetName, bTakeFocus:=True

End Function
Public Sub FormatCellInvalid(sSheetName As String, rCell As Range)
    SetBgColor sSheetName, rCell, 255, 0, 0
End Sub
Public Sub FormatCellValid(sSheetName As String, rCell As Range)
    SetBgColor sSheetName, rCell, 0, 255, 0
End Sub
Public Sub DoLoadDefinitions(Optional clsQuadRuntime As Quad_Runtime)
Dim rSource As Range
Dim wsTmp As Worksheet
Dim wbTmp As Workbook

    If IsSet(clsQuadRuntime) = True Then
        Set wbTmp = clsQuadRuntime.Book
        Set wsTmp = wbTmp.Sheets(clsQuadRuntime.DefinitionSheetName)
    Else
        Set wbTmp = ActiveWorkbook
        Set wsTmp = wbTmp.Sheets("Definitions")
    End If
    
    wsTmp.Activate
    Set rSource = wsTmp.Range("Definitions")
    'Set rSource = wbTmp.Sheets("Definitions").Range("Definitions")
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource)
    
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
    FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is invalid [" & NotAnInteger & "]", C_MODULE_NAME, LogMsgType.OK

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
    FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is invalid [" & NotValidPrep & "]", C_MODULE_NAME, LogMsgType.OK

End Function
Public Function IsMember(ParamArray args()) As Boolean
Dim sColumnRange As String, sLookUpTableName As String, sLookUpColumnName As String, sValue As String
Dim vValid2DValues() As Variant
Dim vValidValues() As String
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet

    'clsQuadRuntime.InitProperties
    Set clsQuadRuntime = args(0)
    sValue = args(1)
    sLookUpTableName = args(2)(0)
    sLookUpColumnName = args(2)(1)


    sColumnRange = GetDBColumnRange(sLookUpTableName, sLookUpColumnName)
    
    If Left(sLookUpTableName, 1) = "&" Then
        Set wsCache = Application.Run(Right(sLookUpTableName, Len(sLookUpTableName) - 1), clsQuadRuntime)
        vValidValues = ListFromRange(wsCache, sColumnRange)
    Else
        vValidValues = ListFromRange(ActiveWorkbook.Sheets(sLookUpTableName), sColumnRange)
    End If
    
    'sColumnRange = GetDBColumnRange(sLookUpTableName, sLookUpColumnName)
    
    'vValidValues = ListFromRange(wsCache, sColumnRange)
    If InArray(vValidValues, sValue) = False Then
        IsMember = False
        Exit Function
    End If
    
    IsMember = True
End Function
Public Function IsMemberOrig(ParamArray args()) As Boolean
Dim sFuncName As String, sTableName As String, sColRange As String
Dim aValues() As String
Dim iValue As Variant
Dim vParams As Variant
setup:
            
    sFuncName = C_MODULE_NAME & "." & "IsMember"
    
    If UBound(args) < 1 Then
        FuncLogIt sFuncName, "Requires at least 2 parameters ]" & CStr(UBound(args) + 1) & "] given", C_MODULE_NAME, LogMsgType.OK
        Exit Function
    End If
    iValue = args(0)
    sTableName = args(1)
    If UBound(args) > 1 Then
        ' col needs to be passed to do lookup in a "Table"
        vParams = args(2)
        sColRange = GetDBColumnRange(vParams(0), vParams(1))
    Else
        ' this is the old pre-table range name
        sColRange = "l" & sTableName
    End If
    
main:

    aValues = ListFromRange(ActiveWorkbook.Sheets(vParams(0)), sColRange)
    
    If InArray(aValues, iValue) = True Then
        IsMember = True
        Exit Function
    End If
    
    IsMember = False
err:

End Function
Public Sub DumpDefinitions(Optional bLog As Boolean = True)
Dim sKey As Variant
Dim sDetail As Variant
Dim sFuncName As String
Dim dDefnDetail As Dictionary

    sFuncName = C_MODULE_NAME & "." & "DumpDefinitions"
    
    For Each sKey In dDefinitions.Keys
        FuncLogIt sFuncName, "Found defn for [" & sKey & "] definitions", C_MODULE_NAME, LogMsgType.INFO
        If sKey <> "actions" And sKey <> "tables" Then
            Set dDefnDetail = dDefinitions.Item(sKey)
            For Each sDetail In dDefnDetail.Keys
                FuncLogIt sFuncName, "Found detail for [" & sDetail & "] [ " & dDefnDetail.Item(sDetail) & "]", C_MODULE_NAME, LogMsgType.INFO
            Next sDetail
        End If
    Next sKey
End Sub
Function GetEntryKey(sSheetName As String, sFieldName As String) As String
Dim sKey As String

    sKey = "e" & sSheetName & "_" & sFieldName
    GetEntryKey = sKey
End Function
Function GetEntryCell(sSheetName As String, sFieldName As String) As Range
Dim sFuncName As String
Dim sKey As String
Dim dDefnDetail As Dictionary
Dim rEntry As Range

    sFuncName = C_MODULE_NAME & "." & "GetEntryCell"
    sKey = GetEntryKey(sSheetName, sFieldName)
   
    Set dDefnDetail = dDefinitions.Item(sKey)
    
    With ActiveWorkbook.Sheets(sSheetName)
        Set GetEntryCell = .Range(dDefnDetail.Item("address"))
    End With
    
End Function

Public Function GenerateEntry(sSheetName As String, _
                              sKey As Variant, _
                              sAction As Variant, _
                              iRow As Integer, _
                              Optional iCol As Integer = 1) As Range
Dim sFuncName As String

    sFuncName = C_MODULE_NAME & "." & "GenerateEntry"
    
    With ActiveWorkbook.Sheets(sSheetName)
        sFieldName = Split(sKey, "_")(1)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
    
        rCell.value = sFieldName
        CreateNamedRange ActiveWorkbook, rCell.Offset(, 1).Address, CStr(sAction), CStr(sKey), "True"
    End With
    
    Set GenerateEntry = rCell.Offset(, 1)

    FuncLogIt sFuncName, "Generated for field [" & sFieldName & "] in cell [" & GenerateEntry.Address & "]", C_MODULE_NAME, LogMsgType.OK
     
End Function
Public Sub DeleteEntry(sSheetName As String, sKey As Variant)
Dim sFuncName As String

    sFuncName = C_MODULE_NAME & "." & "DeleteEntry"
    If Left(sKey, Len("e" & sSheetName)) = "e" & sSheetName Then
        DeleteNamedRange ActiveWorkbook, sSheetName, CStr(sKey)
    Else
        FuncLogIt sFuncName, "Not an entry named range [" & sKey & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
        
End Sub

Public Function GenerateButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                               sSheetName As String, iRow As Integer, iCol As Integer, _
                               eButtonState As CellState, sButtonFormatSheetName As String) As Range
Dim sButtonRangeName As String

   With ActiveWorkbook.Sheets(sSheetName)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        sButtonRangeName = "b" & sSheetName
        CreateNamedRange ActiveWorkbook, rCell.Address, sSheetName, sButtonRangeName, "True"
    End With
    
    Set GenerateButton = rCell
    
    FormatCell wbSourceBook, wbTargetbook, sSheetName, GenerateButton, eButtonState, sButtonFormatSheetName
    
End Function

Public Sub ChangeButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                        sSheetName As String, iRow As Integer, iCol As Integer, _
                        eCellState As CellState, sButtonFormatSheetName As String, _
                        Optional bTakeFocus As Boolean = False)
Dim sButtonRangeName As String
Dim rCurrentFocus As Range
Dim rCell As Range

    EventsToggle False
    With ActiveWorkbook.Sheets(sSheetName)
        Set rCurrentFocus = Selection
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
    End With

    FormatCell wbSourceBook, wbTargetbook, sSheetName, rCell, eCellState, sButtonFormatSheetName
    
    If bTakeFocus = False Then
        rCurrentFocus.Select
    End If
    EventsToggle True
    
End Sub
Public Sub ShowEntryForm(sTableName As String)
Dim wsTmp As Worksheet

    Set wsTmp = ShowSheet(ActiveWorkbook, "New" & sTableName)
    wsTmp.Activate
End Sub

Public Sub HideEntryForm(sSheetName As String)

    If SheetIsVisible(ActiveWorkbook, sSheetName) = True Then
        HideSheet ActiveWorkbook, sSheetName
    End If
    
End Sub
Public Sub HideAllEntryForms()
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

Public Sub DeleteEntryForms()
Dim sAction As Variant
Dim sKey As Variant

    If dDefinitions Is Nothing Then
        DoLoadDefinitions
    End If
    
    Set dActions = dDefinitions.Item("actions")
    For Each sAction In dActions.Keys()
        For Each sKey In dDefinitions.Keys()
        
            DeleteEntry CStr(sAction), sKey
        Next sKey
        DeleteSheet ActiveWorkbook, CStr(sAction)
    Next sAction
    
End Sub

Public Sub FormatEntryForm(clsQuadRuntime As Quad_Runtime, _
                           sTargetSheetName As String, _
                  Optional sFormType As String = "New", _
                           Optional iFirstCol As Integer = 1, _
                           Optional iFirstRow As Integer = 1)
Dim sFormFormatRangeName As String
Dim rFormFormatRange As Range, rFormFormatTargetRange As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer
Dim wsForm As Worksheet

    sFormFormatRangeName = "f" & sFormType
    
    Set wsForm = clsQuadRuntime.Book.Sheets(sTargetSheetName)
    
    With clsQuadRuntime.TemplateSheet
        .Activate
        Set rFormFormatRange = .Range(sFormFormatRangeName)
        rFormFormatRange.Select
        Selection.Copy
    End With
        
    iFormatWidth = rFormFormatRange.Columns.Count
    iFormatHeight = rFormFormatRange.Rows.Count
    
    wsForm.Visible = True
    With wsForm
        .Activate
        Set rFormFormatTargetRange = wsForm.Range(.Cells(iFirstRow, iFirstCol), .Cells(iFirstRow + iFormatHeight - 1, iFirstCol + iFormatWidth - 1))
        rFormFormatTargetRange.Select
        Selection.PasteSpecial Paste:=xlPasteFormats, operation:=xlNone, SkipBlanks:=False, Transpose:=False
    End With

    FormatColRowSize clsQuadRuntime.TemplateBook, clsQuadRuntime.Book, _
            wsForm.Name, clsQuadRuntime.TemplateSheetName, sFormFormatRangeName
End Sub

Public Sub GenerateEntryForms(clsQuadRuntime As Quad_Runtime, _
                     Optional bLoadRefData As Boolean = False, _
                     Optional sOverideButtonCallback As String)
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
Dim dActions As Dictionary
Dim sAction As Variant, sKey As Variant
Dim sCode As String, sFieldName As String, sFuncName As String, sCallbackFunc As String
Dim iRow As Integer
Dim rCell As Range, rButton As Range

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateEntryForms"

    If IsSet(dDefinitions) = False Then
        DoLoadDefinitions
    End If
    
    Set dActions = dDefinitions.Item("actions")
    For Each sAction In dActions.Keys()
    
        If sOverideButtonCallback <> "" Then
            sCallbackFunc = sOverideButtonCallback
        Else
            'sCallbackFunc = "New" & sAction
            sCallbackFunc = sAction
        End If
        
        iRow = 1
        
        ' create the entry sheet and add call back code
        Set wsTmp = CreateSheet(clsQuadRuntime.Book, CStr(sAction), bOverwrite:=True)
        sCode = "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine & _
                "dim wbTarget as Workbook, wbSource as Workbook" & vbNewLine & _
                "dim sSourceSheetName as string" & vbNewLine & _
                "set wbSource= Workbooks(" & DOUBLEQUOTE & clsQuadRuntime.TemplateBookName & DOUBLEQUOTE & ")" & vbNewLine & _
                "set wbTarget= Workbooks(" & DOUBLEQUOTE & clsQuadRuntime.BookName & DOUBLEQUOTE & ")" & vbNewLine & _
                "sSourceSheetName = " & DOUBLEQUOTE & clsQuadRuntime.TemplateCellSheetName & DOUBLEQUOTE & vbNewLine & _
                "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.Name & "!Validate" & DOUBLEQUOTE & ",Application.ActiveWorkbook, Application.ActiveSheet.Name, Target" & vbNewLine & _
                "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.Name & "!IsRecordValid" & DOUBLEQUOTE & ",wbSource,wbTarget,Application.ActiveSheet.Name," & "sSourceSheetName" & vbNewLine & _
                "End Sub"

        ' MOVED  THIS LINE DOWN
        'AddCode2Module clsQuadRuntime.Book, wsTmp.CodeName, sCode

        FormatEntryForm clsQuadRuntime, CStr(sAction)
        
        ' for each entry in the definition generate a input field
        With wsTmp
            .Range(.Cells(iRow, 1), .Cells(iRow, 1)).value = UCase(sAction)
            iRow = iRow + 1
        
            For Each sKey In dDefinitions.Keys()
                If Split(sKey, "_")(0) = "e" & sAction Then
                    Set rCell = GenerateEntry(CStr(sAction), sKey, sAction, iRow)
                    dDefinitions.Item(sKey).Add "address", rCell.Address
                    
                    ' copy across any formatting that exists
                    FormatCell clsQuadRuntime.TemplateBook, clsQuadRuntime.Book, CStr(sAction), rCell, CellState.Invalid, _
                                sSourceSheetName:=clsQuadRuntime.TemplateCellSheetName, eCellType:=CellType.Entry
            
            
                    iRow = iRow + 1
                End If
            Next sKey
        End With
        
        ' generate the commit record button
        GenerateButton clsQuadRuntime.TemplateBook, clsQuadRuntime.Book, CStr(sAction), C_GOBUTTON_ROW, C_GOBUTTON_COL, CellState.Invalid, clsQuadRuntime.TemplateCellSheetName
        
        sCode = sCode & vbNewLine & _
                        "Public Sub Worksheet_SelectionChange(ByVal Target As Range)" & vbNewLine & _
                        "If Target.Column = " & CStr(C_GOBUTTON_COL) & " And Target.Row = " & CStr(C_GOBUTTON_ROW) & " Then" & vbNewLine & _
                        "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.Name & "!" & sCallbackFunc & DOUBLEQUOTE & vbNewLine & _
                        "End If" & vbNewLine & _
                        "End Sub"

        AddCode2Module clsQuadRuntime.Book, wsTmp.CodeName, sCode
        
        ' add a caller module so can simulate change events more reliably
        sCode = "Public Sub Invoke_Worksheet_SelectionChange(sSheetName As String, rTarget As Range)" & vbNewLine & _
        "Dim ws As Worksheet" & vbNewLine & _
        "set ws = Sheets(sSheetName)" & vbNewLine & _
        "Application.Run ws.CodeName & " & DOUBLEQUOTE & ".Worksheet_SelectionChange" & DOUBLEQUOTE & ", rTarget" & vbNewLine & _
        "End Sub"
        
        ' will already exist if more than 1 entry
        If ModuleExists(clsQuadRuntime.Book, "change_event_invoker") = False Then
            CreateModule clsQuadRuntime.Book, "change_event_invoker", sCode
        End If

        'FormatEntryForm clsQuadRuntime, CStr(sAction)
        
        HideEntryForm CStr(sAction)
        FuncLogIt sFuncName, "Generated Form for action [" & sAction & "]", C_MODULE_NAME, LogMsgType.INFO
        
    Next sAction
End Sub
Public Function LoadDefinitions(wsTmp As Worksheet, Optional rSource As Range = Nothing) As Dictionary
Dim dDefinitions As New Dictionary, dDefnDetail As Dictionary
Dim dDefnActions As New Dictionary 'holds a discrete list of actions that have been defined
Dim dDefnTables As New Dictionary 'holds a discrete list of tables that have been defined
Dim rRow As Range
Dim sTableName As String, sFieldName As String, sActionName As String, sValidationType As String
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
            iValidationParamCount = 0
            sActionName = rRow.Columns(1)
            sTableName = rRow.Columns(2)
            sFieldName = rRow.Columns(3)
            sValidationType = rRow.Columns(4)
            sValidationParam = rRow.Columns(5)
            
            Set dDefnDetail = New Dictionary
            dDefnDetail.Add "validation_type", sValidationType
            dDefnDetail.Add "validation_param", sValidationParam
            dDefnDetail.Add "db_table_name", sTableName
            dDefnDetail.Add "db_field_name", sFieldName
            
            For iCol = 6 To 9
                If rRow.Columns(iCol).value <> "" Then
                    vValidationParams(iValidationParamCount) = rRow.Columns(iCol).value
                    iValidationParamCount = iValidationParamCount + 1
                End If
            Next iCol
            
            If iValidationParamCount > 0 Then
                ReDim Preserve vValidationParams(0 To iValidationParamCount - 1)
                dDefnDetail.Add "validation_args", vValidationParams
            End If
            
            sKey = "e" & sActionName & "_" & sFieldName
            If dDefinitions.Exists(sKey) = True Then
                FuncLogIt sFuncName, "definition for [" & sKey & "] already loaded", C_MODULE_NAME, LogMsgType.INFO
            Else
                dDefinitions.Add sKey, dDefnDetail
            End If
            
            If dDefnActions.Exists(sActionName) = False Then
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
    FuncLogIt sFuncName, "Loaded in [" & CStr(UBound(dDefinitions.Keys())) & "] definitions", C_MODULE_NAME, LogMsgType.OK
    Exit Function

err:
    Set LoadDefinitions = Nothing
    FuncLogIt sFuncName, "loading in definitions in [" & err.Description & "] definitions", C_MODULE_NAME, LogMsgType.Failure

End Function
Public Function Validate(wbBook As Workbook, sSheetName As String, rTarget As Range) As Boolean
Dim sFuncName As String
Dim sDefnName As String
Dim dDefnDetail As Dictionary
Dim sValidType As String
Dim vValidParams() As String
Dim bValid As Boolean
Dim eThisErrorType As ErrorType
Dim mThisModule As VBComponent
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=False
    
    EventsToggle False
    'On Error GoTo err_name

    If UBound(Split(rTarget.Name.Name, "!")) = 1 Then
        sDefnName = Split(rTarget.Name.Name, "!")(1)
    Else
        sDefnName = rTarget.Name.Name
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
            SetBgColorFromString sSheetName, rTarget, C_RGB_VALID
            Exit Function
        End If
    End If
    
    SetBgColorFromString sSheetName, rTarget, C_RGB_INVALID
    Validate = False
    EventsToggle True
    
    Exit Function

err:
    SetBgColorFromString sSheetName, rTarget, C_RGB_ERROR
    FuncLogIt sFuncName, "Error [" & err.Description & "]", C_MODULE_NAME, _
            LogMsgType.Failure
    Exit Function

err_name:
    FuncLogIt sFuncName, "Error with range name for [" & rTarget.Address & "} [" & err.Description & "]", C_MODULE_NAME, _
            LogMsgType.Failure
End Function



