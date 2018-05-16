Attribute VB_Name = "Validation_Utils"
Option Explicit
Const C_MODULE_NAME = "Validation_Utils"

Public Function Validate(wbBook As Workbook, sSheetName As String, rTarget As Range) As Boolean
Dim sFuncName As String, sDefnName As String, sActionFuncName As String, sValidType As String
Dim dDefnDetail As Dictionary
Dim vValidParams() As String
Dim bValid As Boolean
Dim eThisErrorType As ErrorType
Dim mThisModule As VBComponent
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=False
    
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
        DoLoadDefinitions clsAppRuntime:=clsAppRuntime
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
        If IsSet(clsAppRuntime) Then
            'first passed arg now needs to be clsAppRuntime if IsSet
            Validate = Application.Run(sFuncName, clsAppRuntime, rTarget.value, vValidParams)
        Else
            Validate = Application.Run(sFuncName, rTarget.value, dDefnDetail.Item("CacheTableName"), vValidParams)
        End If
        On Error GoTo 0
        
        If Validate = True Then
            SetBgColorFromString sSheetName, rTarget, C_RGB_VALID, wbTmp:=wbBook
            
            If dDefnDetail.Item("ActionName") <> "" Then
                sActionFuncName = Right(dDefnDetail.Item("ActionName"), Len(dDefnDetail.Item("ActionName")) - 1)
                Application.Run sActionFuncName, clsAppRuntime, rTarget.value, rTarget.name.name
            End If
            
            Exit Function
        End If
    End If
    
    SetBgColorFromString sSheetName, rTarget, C_RGB_INVALID, wbTmp:=clsAppRuntime.AddBook
    Validate = False
    EventsToggle True
    
    Exit Function

err:
    SetBgColorFromString sSheetName, rTarget, C_RGB_ERROR, wbTmp:=clsAppRuntime.AddBook
    FuncLogIt sFuncName, "Error [" & err.Description & "]", C_MODULE_NAME, _
            LogMsgType.Failure
    Exit Function

err_name:
    FuncLogIt sFuncName, "Error with range name for [" & rTarget.Address & "} [" & err.Description & "]", C_MODULE_NAME, _
            LogMsgType.Failure
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





