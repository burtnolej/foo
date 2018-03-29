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
        .Range(dDefnDetails("address")).Value = vValue
    End With
    
    SetEntryValue = 0
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

                ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, ButtonState.Invalid, sSourceSheetName, bTakeFocus:=False

                Exit Function
            End If
        End If
    Next name_
    IsRecordValid = True
    FuncLogIt sFuncName, "Entry Form  [" & sSheetName & "] is valid", C_MODULE_NAME, LogMsgType.INFO

    ChangeButton wbSourceBook, wbTargetbook, sSheetName, C_GOBUTTON_ROW, C_GOBUTTON_COL, _
        ButtonState.Valid, sSourceSheetName, bTakeFocus:=True

End Function
Public Sub FormatCellInvalid(sSheetName As String, rCell As Range)
    SetBgColor sSheetName, rCell, 255, 0, 0
End Sub
Public Sub FormatCellValid(sSheetName As String, rCell As Range)
    SetBgColor sSheetName, rCell, 0, 255, 0
End Sub
Public Sub DoLoadDefinitions()
Dim rSource As Range
Dim wsTmp As Worksheet

    Set wsTmp = ActiveWorkbook.ActiveSheet
    wsTmp.Activate
    Set rSource = ActiveWorkbook.Sheets("Definitions").Range("Definitions")
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource)
    
End Sub
'Public Function IsValidInteger(ByVal iValue As Variant) As Boolean
Public Function IsValidInteger(ParamArray args()) As Boolean
Dim sFuncName As String
Dim iValueTmp As Integer
Dim iValue As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidInteger"
    iValue = args(0)

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
    iValue = args(0)

main:
    aPreps = Split(C_PREPS, ",")
    If IsValidInteger(iValue) = True Then
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
Dim sFuncName As String
Dim aValues() As String
Dim iValue As Variant
Dim sTableName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "IsMember"
    
    If UBound(args) <> 1 Then
        FuncLogIt sFuncName, "Requires 2 parameters ]" & CStr(UBound(args) + 1) & "] given", C_MODULE_NAME, LogMsgType.OK
        Exit Function
    End If
    iValue = args(0)
    sTableName = args(1)
    
main:

    aValues = ListFromRange(ActiveWorkbook.Sheets(sTableName), "l" & sTableName)
    
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

Public Function GenerateEntry(sSheetName As String, sKey As Variant, sAction As Variant, iRow As Integer, Optional iCol As Integer = 1) As Range
Dim sFuncName As String

    sFuncName = C_MODULE_NAME & "." & "GenerateEntry"
    
    With ActiveWorkbook.Sheets(sSheetName)
        sFieldName = Split(sKey, "_")(1)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
    
        rCell.Value = sFieldName
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
                               eButtonState As ButtonState, sButtonFormatSheetName As String) As Range
Dim sButtonRangeName As String

   With ActiveWorkbook.Sheets(sSheetName)
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
        sButtonRangeName = "b" & sSheetName
        CreateNamedRange ActiveWorkbook, rCell.Address, sSheetName, sButtonRangeName, "True"
    End With
    
    Set GenerateButton = rCell
    
    FormatButton wbSourceBook, wbTargetbook, sSheetName, GenerateButton, eButtonState, sButtonFormatSheetName
    
End Function

Public Sub ChangeButton(wbSourceBook As Workbook, wbTargetbook As Workbook, _
                        sSheetName As String, iRow As Integer, iCol As Integer, _
                        eButtonState As ButtonState, sButtonFormatSheetName As String, _
                        Optional bTakeFocus As Boolean = False)
Dim sButtonRangeName As String
Dim rCurrentFocus As Range
Dim rCell As Range

    EventsToggle False
    With ActiveWorkbook.Sheets(sSheetName)
        Set rCurrentFocus = Selection
        Set rCell = .Range(.Cells(iRow, iCol), .Cells(iRow, iCol))
    End With

    FormatButton wbSourceBook, wbTargetbook, sSheetName, rCell, eButtonState, sButtonFormatSheetName
    
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
Public Sub GenerateEntryForms(clsQuadRuntime As Quad_Runtime, sButtonFormatSheetName As String)
'param: wbSourceBook, workbook, where the templates / formats are
'param: wbTargetBook, workbook, where the entry forms will be constructed
Dim dActions As Dictionary
Dim sAction As Variant
Dim sKey As Variant
Dim sCode As String
Dim iRow As Integer
Dim sFieldName As String
Dim rCell As Range
Dim rButton As Range
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateEntryForms"

    If IsSet(dDefinitions) = False Then
        DoLoadDefinitions
    End If
    
    Set dActions = dDefinitions.Item("actions")
    For Each sAction In dActions.Keys()
    
        iRow = 1
        
        Set wsTmp = CreateSheet(clsQuadRuntime.Book, CStr(sAction), bOverwrite:=True)
        
        'Set wsTmp = GetSheet(clsQuadRuntime.Book, "NewStudent")
        sCode = "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine & _
                "dim wbTarget as Workbook, wbSource as Workbook" & vbNewLine & _
                "dim sSourceSheetName as string" & vbNewLine & _
                "set wbSource= Workbooks(" & DOUBLEQUOTE & clsQuadRuntime.TemplateBookName & DOUBLEQUOTE & ")" & vbNewLine & _
                "set wbTarget= Workbooks(" & DOUBLEQUOTE & clsQuadRuntime.BookName & DOUBLEQUOTE & ")" & vbNewLine & _
                "sSourceSheetName = " & DOUBLEQUOTE & clsQuadRuntime.TemplateCellSheetName & DOUBLEQUOTE & vbNewLine & _
                "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.Name & "!Validate" & DOUBLEQUOTE & ",Application.ActiveWorkbook, Application.ActiveSheet.Name, Target" & vbNewLine & _
                "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.Name & "!IsRecordValid" & DOUBLEQUOTE & ",wbSource,wbTarget,Application.ActiveSheet.Name," & "sSourceSheetName" & vbNewLine & _
                "End Sub"

        AddCode2Module clsQuadRuntime.Book, wsTmp.CodeName, sCode
        
        With wsTmp
                                
            .Range(.Cells(iRow, 1), .Cells(iRow, 1)).Value = UCase(sAction)
            iRow = iRow + 1
        
            For Each sKey In dDefinitions.Keys()
                If Split(sKey, "_")(0) = "e" & sAction Then
                    dDefinitions.Item(sKey).Add "address", GenerateEntry(CStr(sAction), sKey, sAction, iRow).Address
                    iRow = iRow + 1
                End If
            Next sKey
        End With
        
        GenerateButton clsQuadRuntime.TemplateBook, clsQuadRuntime.Book, CStr(sAction), C_GOBUTTON_ROW, C_GOBUTTON_COL, ButtonState.Invalid, sButtonFormatSheetName
        
        HideEntryForm CStr(sAction)
        FuncLogIt sFuncName, "Generated Form for action [" & sAction & "]", C_MODULE_NAME, LogMsgType.INFO
        
    Next sAction
End Sub
Public Function LoadDefinitions(wsTmp As Worksheet, Optional rSource As Range = Nothing) As Dictionary
Dim dDefinitions As New Dictionary
Dim dDefnDetail As Dictionary
Dim dDefnActions As New Dictionary 'holds a discrete list of actions that have been defined
Dim dDefnTables As New Dictionary 'holds a discrete list of tables that have been defined
Dim rRow As Range
Dim sTableName As String
Dim sFieldName As String
Dim sActionName As String
Dim sValidationType As String
Dim sValidationParam As String
Dim sFuncName As String
Dim sKey As String

setup:
    sFuncName = C_MODULE_NAME & "." & "LoadDefinitions"

main:
    If rSource Is Nothing Then
        Set rSource = Range("rDefinitions")
    End If
    
    With wsTmp
        For Each rRow In rSource.Rows
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
Dim sValidFunc As String
Dim bValid As Boolean
Dim eThisErrorType As ErrorType
Dim mThisModule As VBComponent

    EventsToggle False
    On Error GoTo err_name
    If UBound(Split(rTarget.Name.Name, "!")) = 1 Then
        sDefnName = Split(rTarget.Name.Name, "!")(1)
    Else
        sDefnName = rTarget.Name.Name
    End If
    On Error GoTo 0
    
    sFuncName = C_MODULE_NAME & "." & "Validate"
    
    If dDefinitions Is Nothing Then
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions
    End If
    
    If dDefinitions.Exists(sDefnName) = False Then
        FuncLogIt sFuncName, "Loading definition for  in [" & sDefnName & "]", C_MODULE_NAME, _
            LogMsgType.Failure
    Else
        Set dDefnDetail = dDefinitions.Item(sDefnName)
        sValidType = dDefnDetail.Item("validation_type")
        sValidFunc = dDefnDetail.Item("validation_param")
        FuncLogIt sFuncName, "Using validation  [" & sValidType & "] [" & sValidFunc & "]", C_MODULE_NAME, _
            LogMsgType.OK
        
        On Error GoTo err
        Validate = Application.Run(sValidFunc, rTarget.Value, dDefnDetail.Item("db_table_name"))
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



