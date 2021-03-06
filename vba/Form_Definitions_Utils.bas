Attribute VB_Name = "Form_Definitions_Utils"
Option Explicit
Const C_MODULE_NAME = "Form_Definitions_Utils"


Function ExecDefinitionFunc(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, eFormType As FormType, _
                            sDataType As String, sSubDataType As String, Optional sDefn As String, _
                Optional sFormName As String, Optional bLoader As Boolean = True) As String
                
Dim sFuncName As String
Dim dArgs As New Dictionary
    sFuncName = "GetDefinition" & WorksheetFunction.Proper(sDataType) & WorksheetFunction.Proper(sSubDataType)
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "clsExecProc", clsExecProc, "eFormType", eFormType, "sDefn", sDefn, _
            "sFormName", sFormName, "bLoader", bLoader, "ver_series", clsAppRuntime.Version
    clsExecProc.ExecProc sFuncName, dArgs
        
    'ExecDefinitionFunc = Application.Run(sFuncName, eFormType, sDefn, sFormName, bLoader)
    ExecDefinitionFunc = dArgs.Item("result")
End Function


Sub GetDefinition(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, sDataType As String, sSubDataType As String, sSheetName As String, eFormType As FormType, _
                Optional wbTmp As Workbook, Optional bLoader As Boolean = False)
'<<<
'purpose: load definitions required to support the Add Lesson workflow
'param  : clsAppRuntime, App_Runtime; App defaults
'param  : sSheetName, string; where to store the excel representation of the definition
'>>>
Dim sFuncName As String, sDefn As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim lStartTick As Long

setup:
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GetDefinition"
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = clsAppRuntime.TemplateBook
    End If
    
    Set wsTmp = CreateSheet(wbTmp, sSheetName, bOverwrite:=True)
    
main:

    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, eFormType, sDataType, sSubDataType, bLoader:=bLoader)
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange wbTmp, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

cleanup:
    FuncLogIt sFuncName, "Loaded [num defns=" & CStr(UBound(Split(sDefn, DOUBLEDOLLAR))) & "] [sSheetName=" & sSheetName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Sub
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Sub

Public Function GetCacheTableNameFromDataType(sDataType As String, sSubDataType As String) As String
    GetCacheTableNameFromDataType = LCase(sDataType) & UNDERSCORE & LCase(sSubDataType)
End Function

Public Function GetCacheTableName(sRangeName As String) As String
'<<<
'purpose:
'param  :
'param  :
'rtype  : String; i.e. person_student
'>>>
Dim dDetailDefn As Dictionary
Dim sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetCacheTableName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    
main:

    If InStr(sRangeName, BANG) <> 0 Then
        sRangeName = Split(sRangeName, BANG)(1)
    End If
    Set dDetailDefn = dDefinitions.Item(sRangeName)
    GetCacheTableName = dDetailDefn.Item("CacheTableName")
    
    If GetCacheTableName = "" Then
        err.Raise ErrorMsgType.CACHE_TABLE_NAME_CANNOT_BE_BLANK, Description:="[GetCacheTableName=" & GetCacheTableName & "]"
    End If
    
cleanup:
    FuncLogIt sFuncName, "[sRangeName=" & sRangeName & "] [Result=" & GetCacheTableName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
     
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

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
Dim sCacheTableName As String, sFieldName As String, sActionName As String, sValidationType As String, sActionFunc As String
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
            sCacheTableName = rRow.Columns(2)
            sFieldName = rRow.Columns(3)
            sValidationType = rRow.Columns(4)
            sValidationParam = rRow.Columns(5)
            sActionFunc = rRow.Columns(8)
            
            If bIgnoreWidgetType = False Then
                eWidgetType = GetWidgetTypeFromValue(rRow.Columns(9))
            Else
                eWidgetType = WidgetType.Entry
            End If
            
            If sCacheTableName = BLANK Then
                If eWidgetType <> WidgetType.Button Then
                    err.Raise ErrorMsgType.CACHE_TABLE_NAME_CANNOT_BE_BLANK, Description:="[sFieldName=" & sFieldName & "] [sCacheTableName=" & sCacheTableName & "]"
                End If
            End If
            
            If sFieldName = BLANK Then
                err.Raise ErrorMsgType.FIELD_NAME_CANNOT_BE_BLANK, Description:="[sFieldName=" & sFieldName & "]"
            End If
            
            Set dDefnDetail = New Dictionary
            dDefnDetail.Add "validation_type", sValidationType
            dDefnDetail.Add "validation_param", sValidationParam
            dDefnDetail.Add "CacheTableName", sCacheTableName
            dDefnDetail.Add "FieldName", sFieldName
            dDefnDetail.Add "WidgetType", eWidgetType
            dDefnDetail.Add "ActionName", sActionFunc
            
            ReDim Preserve vValidationParams(0 To 1)
            
            iCol = 6
            'If rRow.Columns(iCol).value <> "" Then
                If rRow.Columns(iCol).value = "" Then
                    vValidationParams(0) = sCacheTableName
                Else
                    vValidationParams(0) = rRow.Columns(iCol).value
                End If
            'End If
            
            iCol = 7
            'If rRow.Columns(iCol).value <> "" Then
                If rRow.Columns(iCol).value = "" Then
                    vValidationParams(1) = sFieldName
                Else
                    vValidationParams(1) = rRow.Columns(iCol).value
                End If
            'End If
            
            'For iCol = 6 To 7
            '    If rRow.Columns(iCol).value <> "" Then
            '        If rRow.Columns(iCol).value = "" Then
            '            ValidationParams(iValidationParamCount) = sCacheTableName
            '        Else
            '            vValidationParams(iValidationParamCount) = rRow.Columns(iCol).value
            '        End If
            '
            '        iValidationParamCount = iValidationParamCount + 1
            '    End If
            'Next iCol
            
            'If iValidationParamCount > 0 Then
                'ReDim Preserve vValidationParams(0 To iValidationParamCount - 1)
            
            'End If
            
            dDefnDetail.Add "validation_args", vValidationParams
            sKey = GetWidgetKey(sActionName, sFieldName, eWidgetType)
            
            If dDefinitions.Exists(sKey) = True Then
                FuncLogIt sFuncName, "definition for [" & sKey & "] already loaded", C_MODULE_NAME, LogMsgType.INFO
            Else
                dDefinitions.Add sKey, dDefnDetail
            End If
            
            If dDefnActions.Exists(sActionName) = False Then
                'rRow.Select
                dDefnActions.Add sActionName, Nothing
            End If

            If dDefnTables.Exists(sCacheTableName) = False Then
                dDefnTables.Add sCacheTableName, Nothing
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

Public Sub DoLoadDefinitions(Optional clsAppRuntime As App_Runtime)
Dim rSource As Range
Dim wsTmp As Worksheet
Dim wbTmp As Workbook

    If IsSet(clsAppRuntime) = True Then
        Set wbTmp = clsAppRuntime.TemplateBook
        Set wsTmp = wbTmp.Sheets(clsAppRuntime.DefinitionSheetName)
    Else
        Set wbTmp = ActiveWorkbook
        Set wsTmp = wbTmp.Sheets(clsAppRuntime.DefinitionSheetName)
    End If
    
    Set rSource = wsTmp.Range("Definitions")
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource)
    
    End Sub

Public Sub DumpDefinitions(Optional bLog As Boolean = True, Optional bWorksheet As Boolean = False)
Dim sKey As Variant
Dim vDetail As Variant
Dim sFuncName As String, sDetail As String
Dim dDefnDetail As Dictionary
Dim sOutput As String

    sFuncName = C_MODULE_NAME & "." & "DumpDefinitions"
    
    For Each sKey In dDefinitions.Keys
        If sKey <> "actions" And sKey <> "tables" Then
            Set dDefnDetail = dDefinitions.Item(sKey)
            sOutput = sOutput & vbNewLine & sKey & vbNewLine
            For Each vDetail In dDefnDetail.Keys
                If MyVarType(dDefnDetail.Item(vDetail)) = 46 Then
                    sDetail = "[" & Join(dDefnDetail.Item(CStr(vDetail)), COMMA) & "]"
                Else
                    sDetail = dDefnDetail.Item(vDetail)
                End If
                sOutput = sOutput & PadStr(CStr(vDetail), "left", 20, " ") & " = " & PadStr(sDetail, "right", 20, " ") & vbNewLine
            Next vDetail
        End If
        Debug.Print sOutput
        sOutput = ""
    Next sKey
    
    Debug.Print sOutput
End Sub
