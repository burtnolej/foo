Attribute VB_Name = "Widget_Lookup_Utils"
Option Explicit
Const C_MODULE_NAME = "Widget_Lookup_Utils"
Function GetKey(sSheetName As String, sFieldName As String, Optional eWidgetType As WidgetType = WidgetType.Entry) As String
Dim sKeySuffix As String

    If eWidgetType = WidgetType.Entry Then
        sKeySuffix = "e"
    ElseIf eWidgetType = WidgetType.Button Then
        sKeySuffix = "b"
    ElseIf eWidgetType = WidgetType.Text Then
        sKeySuffix = "t"
    ElseIf eWidgetType = WidgetType.ListText Then
        sKeySuffix = "l"
    ElseIf eWidgetType = WidgetType.Selector Then
        sKeySuffix = "s"
    End If
    
    GetKey = sKeySuffix & sSheetName & "_" & sFieldName
End Function
'Function GetEntryKey(sSheetName As String, sFieldName As String) As String
'Dim sKey As String

    'sKey = "e" & sSheetName & "_" & sFieldName
    'GetEntryKey = sKey
'End Function
'GetFormSheetNameFromRangeName

Function GetFieldNameFromRangeName(sRangeName As String) As String
'<<<
'purpose: [WorksheetName|TableName]!s+[ActionName]_[FieldName] i.e. "ViewStudent!sViewStudent_sStudentFirstNm"
'       : would return sViewStudent_sStudentFirstNm
'param  :
'       :
'param  :
'rtype  :
'>>>

Dim sFuncName As String, sSuffix As String
Dim sSplits() As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetFieldNameFromRangeName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    sSplits = Split(sRangeName, UNDERSCORE)
    GetFieldNameFromRangeName = sSplits(UBound(sSplits))

cleanup:
    FuncLogIt sFuncName, "[sRangeName=" & sRangeName & "] [Result=" & GetFieldNameFromRangeName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

End Function
Function GetWidgetTypeFromRangeName(sRangeName As String) As WidgetType
'<<<
'purpose: [WorksheetName|TableName]!s+[ActionName]_[FieldName] i.e. "ViewStudent!sViewStudent_sStudentFirstNm"
'       : would return sViewStudent_sStudentFirstNm
'param  :
'       :
'param  :
'rtype  :
'>>>

Dim sFuncName As String, sSuffix As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetWidgetTypeFromRangeName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    If InStr(sRangeName, BANG) <> 0 Then
        sRangeName = Split(sRangeName, BANG)(1)
    End If
    
    sSuffix = Left(sRangeName, 1)
    
    If sSuffix = "e" Then
        GetWidgetTypeFromRangeName = WidgetType.Entry
    ElseIf sSuffix = "b" Then
        GetWidgetTypeFromRangeName = WidgetType.Button
    ElseIf sSuffix = "t" Then
        GetWidgetTypeFromRangeName = WidgetType.Text
    ElseIf sSuffix = "l" Then
        GetWidgetTypeFromRangeName = WidgetType.ListText
    ElseIf sSuffix = "s" Then
        GetWidgetTypeFromRangeName = WidgetType.Selector
    End If

cleanup:
    FuncLogIt sFuncName, "[sRangeName=" & sRangeName & "] [Result=" & EnumWidgetType(GetWidgetTypeFromRangeName) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

End Function

Function GetFormTypeFromRangeName(sRangeName As String) As FormType
'<<<
'purpose: [WorksheetName|TableName]!s+[ActionName]_[FieldName] i.e. "ViewStudent!sViewStudent_sStudentFirstNm"
'param  :
'       :
'param  :
'rtype  :

Dim sFuncName As String, sFormName As String, sFormWidgetTypeTuple As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetFormTypeFromRangeName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    If InStr(sRangeName, BANG) <> 0 Then
        sRangeName = Split(sRangeName, BANG)(1)
    End If
    
    sFormWidgetTypeTuple = Split(sRangeName, UNDERSCORE)(0)
    sFormName = Right(sFormWidgetTypeTuple, Len(sFormWidgetTypeTuple) - 1)
    
    If sFormName Like "View" & ASTERISK Then
        GetFormTypeFromRangeName = FormType.View
    ElseIf sFormName Like "ViewList" & ASTERISK Then
        GetFormTypeFromRangeName = FormType.ViewList
    ElseIf sFormName Like "Add" & ASTERISK Then
        GetFormTypeFromRangeName = FormType.Add
    ElseIf sFormName Like "Menu" & ASTERISK Then
        GetFormTypeFromRangeName = FormType.Menu
    End If

cleanup:
    FuncLogIt sFuncName, "[sRangeName=" & sRangeName & "] [Result=" & EnumFormType(GetFormTypeFromRangeName) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

End Function
