Attribute VB_Name = "Validation_Utils"
Option Explicit
Const C_MODULE_NAME = "Validation_Utils"

Public Function Validate(clsAppRuntime As App_Runtime, sDefnName As String, vValueToValidate As Variant) As Boolean
Dim sFuncName As String, sActionFuncName As String, sValidType As String
Dim dDefnDetail As Dictionary
Dim vValidParams() As String

    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsAppRuntime:=clsAppRuntime
    End If
    
    If dDefinitions.Exists(sDefnName) = False Then
        ' usually called from tests, where dDefinitions is already set
        FuncLogIt sFuncName, "Loading definition for  in [" & sDefnName & "]", C_MODULE_NAME, LogMsgType.Failure
    Else
        Set dDefnDetail = dDefinitions.Item(sDefnName)
        sValidType = dDefnDetail.Item("validation_type")
        sFuncName = dDefnDetail.Item("validation_param")
        
        If sFuncName = "" Then
            Validate = True
            FuncLogIt sFuncName, "Validation func not defined for [" & sDefnName & "]", C_MODULE_NAME, LogMsgType.OK
            Exit Function
        End If
        
        If IsSet(dDefnDetail.Item("validation_args")) = True Then
            vValidParams = dDefnDetail.Item("validation_args")
        End If
        
        FuncLogIt sFuncName, "Using validation  [" & sValidType & "] [" & sFuncName & "]", C_MODULE_NAME, LogMsgType.OK
        
        On Error GoTo err
        If IsSet(clsAppRuntime) Then
            'first passed arg now needs to be clsAppRuntime if IsSet
            Validate = Application.Run(sFuncName, clsAppRuntime, vValueToValidate, vValidParams)
        Else
            Validate = Application.Run(sFuncName, vValueToValidate, dDefnDetail.Item("CacheTableName"), vValidParams)
        End If
        On Error GoTo 0
    End If
    
    Exit Function

err:
    Validate = False
        
End Function
Public Function ValidateWidget(wbBook As Workbook, sSheetName As String, rTarget As Range) As Boolean
'<<<
'purpose: determine if a value entered into a widget is valid or not
'param  : sSheetName, string; where the form is located
'param  : rTarget, Range; the Cell containing the widget
'rtype  :
'>>>
Dim sFuncName As String, sDefnName As String, sActionFuncName As String, sValidType As String
Dim dDefnDetail As Dictionary, dArgs As New Dictionary
Dim clsAppRuntime As New App_Runtime
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "ValidateWidget"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=False
    EventsToggle False
    
    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsAppRuntime:=clsAppRuntime
    End If

main:
    If UBound(Split(rTarget.Name.Name, "!")) = 1 Then
        sDefnName = Split(rTarget.Name.Name, "!")(1)
    Else
        sDefnName = rTarget.Name.Name
    End If
    On Error GoTo 0
    
    ValidateWidget = Validate(clsAppRuntime, sDefnName, rTarget.value)
    
    If ValidateWidget = True Then
        SetBgColorFromString sSheetName, rTarget, C_RGB_VALID, wbTmp:=wbBook
    
        Set dDefnDetail = dDefinitions.Item(sDefnName)
        If dDefnDetail.Item("ActionName") <> "" Then
            sActionFuncName = Right(dDefnDetail.Item("ActionName"), Len(dDefnDetail.Item("ActionName")) - 1)
            
            'make this dArgs and make the callback the GenerateScheduleLessonListView
            AddArgs dArgs, True, "clsAppRuntime", clsAppRuntime, "sValue", rTarget.value, _
                    "sKey", rTarget.Name.Name, "sFormName", sSheetName
                    
            'Application.Run sActionFuncName, clsAppRuntime, rTarget.value, rTarget.Name.Name
            Application.Run sActionFuncName, dArgs
        End If
    
        Exit Function
    End If

cleanup:
    SetBgColorFromString sSheetName, rTarget, C_RGB_INVALID, wbTmp:=clsAppRuntime.AddBook
    ValidateWidget = False
    EventsToggle True
    FuncLogIt sFuncName, "[sSheetName=" & sSheetName & "] [Range=" & rTarget.Address & "] [Value=" & rTarget.value & "] [result=" & CStr(ValidateWidget) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
    
err:
    SetBgColorFromString sSheetName, rTarget, C_RGB_ERROR, wbTmp:=clsAppRuntime.AddBook
    FuncLogIt sFuncName, "Error [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Failure
    Exit Function

err_name:
    FuncLogIt sFuncName, "Error with range name for [" & rTarget.Address & "} [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Failure
End Function

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

Public Function IsMember(ParamArray args()) As Boolean
Dim sColumnRange As String, sLookUpTableName As String, sLookUpColumnName As String, sValue As String
Dim vValid2DValues() As Variant
Dim vValidValues() As String
Dim clsAppRuntime As New App_Runtime
Dim wsCache As Worksheet

    Set clsAppRuntime = args(0)
    sValue = args(1)
    sLookUpTableName = args(2)(0)
    sLookUpColumnName = args(2)(1)

    sColumnRange = GetDBColumnRange(sLookUpTableName, sLookUpColumnName)
    
    If Left(sLookUpTableName, 1) = "&" Then
        Set wsCache = Application.Run(Right(sLookUpTableName, Len(sLookUpTableName) - 1), clsAppRuntime)
        vValidValues = ListFromRange(wsCache, sColumnRange)
    Else
        vValidValues = ListFromRange(clsAppRuntime.CacheBook.Sheets(sLookUpTableName), sColumnRange)
    End If
    
    If InArray(vValidValues, sValue) = False Then
        IsMember = False
        Exit Function
    End If
    
    IsMember = True
End Function





