Attribute VB_Name = "Form_Callback_Utils"
Option Explicit
Const C_MODULE_NAME = "Form_Callback_Utils"

Function GetCallerModuleCode() As String
' add a caller module so can simulate change events more reliably
    GetCallerModuleCode = "Public Sub Invoke_Worksheet_SelectionChange(sSheetName As String, rTarget As Range)" & vbNewLine & _
                "Dim ws As Worksheet" & vbNewLine & _
                "set ws = Sheets(sSheetName)" & vbNewLine & _
                "Application.Run ws.CodeName & " & DOUBLEQUOTE & ".Worksheet_SelectionChange" & DOUBLEQUOTE & ", rTarget" & vbNewLine & _
                "End Sub"
End Function
        
Function GetEntryCallbackCode(clsQuadRuntime As App_Runtime, sAction As String, sTargetBookName As String, _
        Optional eWidgetType As WidgetType = WidgetType.Entry) As String
Dim sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetEntryCallbackCode"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)

main:
    GetEntryCallbackCode = "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine & _
            "dim wbTarget as Workbook, wbSource as Workbook" & vbNewLine & _
            "dim sSourceSheetName as string" & vbNewLine & _
            "dim sSheetName as string" & vbNewLine & _
            "sSheetName=" & DOUBLEQUOTE & sAction & DOUBLEQUOTE & vbNewLine & _
            "set wbSource= Workbooks(" & DOUBLEQUOTE & clsQuadRuntime.TemplateBookName & DOUBLEQUOTE & ")" & vbNewLine & _
            "set wbTarget= Workbooks(" & DOUBLEQUOTE & sTargetBookName & DOUBLEQUOTE & ")" & vbNewLine & _
            "sSourceSheetName = " & DOUBLEQUOTE & clsQuadRuntime.TemplateWidgetSheetName & DOUBLEQUOTE & vbNewLine & _
            "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.MainBookName & "!Validate" & DOUBLEQUOTE & ",wbTarget,sSheetName, Target" & vbNewLine
            
           '"Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.name & "!Validate" & DOUBLEQUOTE & ",wbTarget,sSheetName, Target" & vbNewLine
            
            
    If eWidgetType = WidgetType.Entry Then
        GetEntryCallbackCode = GetEntryCallbackCode & "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.TemplateBook.name & "!IsRecordValid" & DOUBLEQUOTE & ",wbSource,wbTarget,sSheetName,sSourceSheetName" & vbNewLine
    End If
    
    GetEntryCallbackCode = GetEntryCallbackCode & "End Sub"
    
cleanup:
    FuncLogIt sFuncName, "[sTargetBookName=" & sTargetBookName & "] [sAction=" & sAction & "] [eWidgetType=" & CStr(eWidgetType) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

End Function
Function GenerateCallbackCode(clsQuadRuntime As App_Runtime, vButtons() As String, sActionName As String, _
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
Function GetButtonCallbackCode(clsQuadRuntime As App_Runtime, _
    iButtonCol As Integer, iButtonRow As Integer, sCallbackFunc As String) As String
    GetButtonCallbackCode = _
                    "If Target.Column = " & CStr(iButtonCol) & " And Target.Row = " & CStr(iButtonRow) & " Then" & vbNewLine & _
                    "Application.Run " & DOUBLEQUOTE & clsQuadRuntime.MainBookName & "!" & sCallbackFunc & DOUBLEQUOTE & vbNewLine & _
                    "End If" & vbNewLine
End Function

