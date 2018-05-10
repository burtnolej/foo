Attribute VB_Name = "Form_Definitions_Utils"
Option Explicit
Const C_MODULE_NAME = "Form_Definitions_Utils"
Public Function GetTableNameFromRangeName(sRangeName As String)
'<<<
'purpose:
'param  :
'param  :
'rtype  :
'>>>
Dim dDetailDefn As Dictionary
Dim sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetTableNameFromRangeName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:

    If InStr(sRangeName, BANG) <> 0 Then
        sRangeName = Split(sRangeName, BANG)(1)
    End If
    Set dDetailDefn = dDefinitions.Item(sRangeName)
    GetTableNameFromRangeName = dDetailDefn.Item("db_table_name")
    
cleanup:
    FuncLogIt sFuncName, "[sRangeName=" & sRangeName & "] [Result=" & GetTableNameFromRangeName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
     
End Function
Public Function LoadDefinitions(wsTmp As Worksheet, _
                       Optional rSource As Range = Nothing, _
                       Optional bIgnoreWidgetType As Boolean = False) As Dictionary
'<<<
'purpose: loads the configuration that defines what forms to construct, what widgets to put on the forms
'       : how to validate entries and what actions to take on user input
'param  : wsTmp, worksheet; location of the config
'param  : rSource, range (Optional); where to find config on sheet (defaults to the range named "Definitions" if not specified"
'param  : bIgnoreWidgetType, boolean (Optional); if True then assumes everything is an Entry;
'       : this is to allow for backwards compatability of tests written before WidgetTypes was specified in the config
'rtype  : dictionary;
'>>>
                     
Dim dDefinitions As New Dictionary, dDefnDetail As Dictionary, dDefnActions As New Dictionary, dDefnTables As New Dictionary
Dim rRow As Range
Dim sTableName As String, sFieldName As String, sActionName As String, sValidationType As String, sActionFunc As String
Dim eWidgetType As WidgetType
Dim sValidationParam As String, sFuncName As String, sKey As String
Dim vValidationParams() As String
Dim iCol As Integer, iValidationParamCount As Integer
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "LoadDefinitions"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
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
            
            If bIgnoreWidgetType = False Then
                eWidgetType = GetWidgetTypeFromValue(rRow.Columns(9))
            Else
                eWidgetType = WidgetType.Entry
            End If
            
            Set dDefnDetail = New Dictionary
            dDefnDetail.Add "validation_type", sValidationType
            dDefnDetail.Add "validation_param", sValidationParam
            dDefnDetail.Add "db_table_name", sTableName
            dDefnDetail.Add "db_field_name", sFieldName
            dDefnDetail.Add "widget_type", eWidgetType
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
            
            sKey = GetKey(sActionName, sFieldName, eWidgetType)
            
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
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    FuncLogIt sFuncName, "Loaded in [" & CStr(UBound(dDefinitions.Keys())) & "] definitions", C_MODULE_NAME, LogMsgType.DEBUGGING2
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
        Set wsTmp = wbTmp.Sheets(clsQuadRuntime.DefinitionSheetName)
    End If
    
    Set rSource = wsTmp.Range("Definitions")
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource)
    
    End Sub

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
