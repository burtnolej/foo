Attribute VB_Name = "Validation_Utils"
Option Explicit
Const C_MODULE_NAME = "Validation_Utils"

Public Function Validate(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, sDefnName As String, vValueToValidate As Variant) As Boolean
Dim sFuncName As String, sActionFuncName As String, sValidType As String, sValidateFuncName As String
Dim dDefnDetail As Dictionary
Dim vValidParams() As String
Dim lStartTick As Long

setup:
    'On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "Validate"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
main:
    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsAppRuntime:=clsAppRuntime
    End If
    
    'need to take off any __n extensions as they are all validated the same way
    If InStr(sDefnName, "__") <> 0 Then
        sDefnName = Split(sDefnName, "__")(0)
    End If
    
    If dDefinitions.Exists(sDefnName) = False Then
        ' usually called from tests, where dDefinitions is already set
        FuncLogIt sFuncName, "Loading definition for  in [" & sDefnName & "]", C_MODULE_NAME, LogMsgType.Failure
    Else
        Set dDefnDetail = dDefinitions.Item(sDefnName)
        sValidType = dDefnDetail.Item("validation_type")
        sValidateFuncName = dDefnDetail.Item("validation_param")
        
        If sValidateFuncName = "" Then
            Validate = True
            FuncLogIt sFuncName, "Validation func not defined for [" & sDefnName & "]", C_MODULE_NAME, LogMsgType.OK
            GoTo cleanup
        End If
        
        If IsSet(dDefnDetail.Item("validation_args")) = True Then
            vValidParams = dDefnDetail.Item("validation_args")
        End If
        
        FuncLogIt sFuncName, "Using validation  [" & sValidType & "] [" & sValidateFuncName & "]", C_MODULE_NAME, LogMsgType.OK
        
        On Error GoTo err
        If IsSet(clsAppRuntime) Then
            'first passed arg now needs to be clsAppRuntime if IsSet
            Validate = Application.Run(sValidateFuncName, clsAppRuntime, vValueToValidate, vValidParams, clsExecProc)
        Else
            Validate = Application.Run(sValidateFuncName, vValueToValidate, dDefnDetail.Item("CacheTableName"), vValidParams, clsExecProc)
        End If
        On Error GoTo 0
    End If
    
cleanup:
    FuncLogIt sFuncName, "[sDefnName=" & sDefnName & "]  [vValueToValidate=" & CStr(vValueToValidate) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

    Exit Function

err:
    Validate = False
    FuncLogIt sFuncName, "Error [ " & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick

End Function

Private Function GetWidgetKeyFromCell(wbBook As Workbook, rTarget As Range, sSheetName As String) As String
Dim sKey As Variant


    For Each sKey In dDefinitions.Keys()
        If GetFormTypeFromRangeName(CStr(sKey)) = FormType.ViewListEntry Then
            If Intersect(wbBook.Sheets(sSheetName).Range(sKey), rTarget) Is Nothing Then
            Else
                GetWidgetKeyFromCell = sKey
                Exit Function
            End If

        End If
    Next sKey
    
    GetWidgetKeyFromCell = ""
            
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
Dim clsExecProc As Exec_Proc
Dim lStartTick As Long
Dim sKey As Variant, sDefinedRange As Variant
Dim vDefinedAddNamesRanges() As String

setup:
    
    CloseLogFile
    GetLogFile ' write stdout to a logfile
    'Log_Utils.LogFilter = "0,1,2,3"
    'Log_Utils.LogFilter = "1"
    
    sFuncName = C_MODULE_NAME & "." & "ValidateWidget"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    
    EventsToggle False
    
    'clsAppRuntime.InitProperties bInitializeCache:=False
    Set clsAppRuntime = GetAppRuntimeGlobal

    If IsSet(clsAppRuntime.VersionBook) = True Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName), wbTmp2:=clsAppRuntime.VersionBook)
    Else
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    End If
    
    If dDefinitions Is Nothing Then
        ' when called from a callback and dDefinitons needs to be reconstituted
        FuncLogIt sFuncName, "Definitions not loaded so reloading", C_MODULE_NAME, LogMsgType.INFO
        DoLoadDefinitions clsAppRuntime:=clsAppRuntime
    End If

main:

    On Error Resume Next
    If UBound(Split(rTarget.Name.Name, "!")) = 1 Then
        sDefnName = Split(rTarget.Name.Name, "!")(1)
    Else
        sDefnName = rTarget.Name.Name
    End If
    On Error GoTo 0
    
    If sDefnName = "" Then
        If GetFormTypeFromAction(sSheetName) = "ViewListEntry" Then
            sDefnName = GetWidgetKeyFromCell(wbBook, rTarget, sSheetName)
        End If
    End If
    
    ValidateWidget = Validate(clsAppRuntime, clsExecProc, sDefnName, rTarget.value)
    
    If ValidateWidget = True Then
        SetBgColorFromString sSheetName, rTarget, C_RGB_VALID, wbTmp:=wbBook
    
        Set dDefnDetail = dDefinitions.Item(sDefnName)
        If dDefnDetail.Item("ActionName") <> "" Then
            sActionFuncName = Right(dDefnDetail.Item("ActionName"), Len(dDefnDetail.Item("ActionName")) - 1)
   
            FuncLogIt sFuncName, "Executing post validation [sActionFuncName=" & sActionFuncName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING
            AddArgs dArgs, True, "clsAppRuntime", clsAppRuntime, "sValue", rTarget.value, "sKey", rTarget.Name.Name, "sFormName", sSheetName
            Application.Run sActionFuncName, dArgs
            'GenerateScheduleView dArgs
        End If
    
        'Exit Function
    Else
        SetBgColorFromString sSheetName, rTarget, C_RGB_INVALID, wbTmp:=wbBook
        ValidateWidget = False
    End If

cleanup:
    'SetBgColorFromString sSheetName, rTarget, C_RGB_INVALID, wbTmp:=clsAppRuntime.AddBook
    'ValidateWidget = False
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
Dim clsExecProc As New Exec_Proc
Dim wsCache As Worksheet

    Set clsAppRuntime = args(0)
    sValue = args(1)
    sLookUpTableName = args(2)(0)
    sLookUpColumnName = args(2)(1)
    Set clsExecProc = args(3)

    sColumnRange = GetDBColumnRange(sLookUpTableName, sLookUpColumnName)
    
    If Left(sLookUpTableName, 1) = "&" Then
        Set wsCache = Application.Run(Right(sLookUpTableName, Len(sLookUpTableName) - 1), clsAppRuntime, clsExecProc)
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

Public Function IsNotValidStudentFullName(ParamArray args()) As Boolean
Dim bMember As Boolean
Dim vArgs As Variant
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim sValue As String

    Set clsAppRuntime = args(0)
    sValue = args(1)
    vArgs = args(2)
    Set clsExecProc = args(3)

    bMember = IsValidStudentFullName(clsAppRuntime, sValue, vArgs, clsExecProc)
    
    If bMember = True Then
        IsNotValidStudentFullName = False
    Else
        IsNotValidStudentFullName = True
    End If
End Function

Public Function IsNotValidTeacherFullName(ParamArray args()) As Boolean
Dim bMember As Boolean
Dim vArgs As Variant
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim sValue As String

    Set clsAppRuntime = args(0)
    sValue = args(1)
    vArgs = args(2)
    Set clsExecProc = args(3)

    bMember = IsValidTeacherFullName(clsAppRuntime, sValue, vArgs, clsExecProc)
    
    If bMember = True Then
        IsNotValidTeacherFullName = False
    Else
        IsNotValidTeacherFullName = True
    End If
End Function


Public Function IsValidStudentFullName(ParamArray args()) As Boolean
Dim sColumnRange As String, sLookUpTableName As String, sLookUpColumnName As String, sValue As String, sFirstName As String, sLastName As String, sVersion As String
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim vNameParts() As String
Dim dArgs As New Dictionary
Dim idStudent As String

    IsValidStudentFullName = True
    
    Set clsAppRuntime = args(0)
    sValue = args(1)
    sLookUpTableName = args(2)(0)
    sLookUpColumnName = args(2)(1)
    Set clsExecProc = args(3)
    
    vNameParts = Split(sValue, Space)
    
    sFirstName = vNameParts(0)
    sLastName = vNameParts(1)
                
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadSubDataType", QuadSubDataType.Student, "eQuadDataType", QuadDataType.person, _
        "sLookUpByColName", "sStudentFirstNm", "sLookUpByValue", sFirstName, "sLookUpColName", "idStudent", _
        "sLookUpByColName2", "sStudentLastNm", "sLookUpByValue2", sLastName, "ver_series", clsAppRuntime.Version
    
    clsExecProc.ExecProc "CrossRefQuadData", dArgs

    IsValidStudentFullName = dArgs.Item("result")
    
End Function

Public Function IsValidTeacherFullName(ParamArray args()) As Boolean
Dim sColumnRange As String, sLookUpTableName As String, sLookUpColumnName As String, sValue As String, sFirstName As String, sLastName As String, sVersion As String
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim vNameParts() As String
Dim dArgs As New Dictionary
Dim idStudent As String

    IsValidTeacherFullName = True
    
    Set clsAppRuntime = args(0)
    sValue = args(1)
    sLookUpTableName = args(2)(0)
    sLookUpColumnName = args(2)(1)
    Set clsExecProc = args(3)
    
    vNameParts = Split(sValue, Space)
    
    sFirstName = vNameParts(0)
    sLastName = vNameParts(1)
                
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadSubDataType", QuadSubDataType.Teacher, "eQuadDataType", QuadDataType.person, _
        "sLookUpByColName", "sStudentFirstNm", "sLookUpByValue", sFirstName, "sLookUpColName", "idStudent", _
        "sLookUpByColName2", "sStudentLastNm", "sLookUpByValue2", sLastName, "ver_series", clsAppRuntime.Version
    
    clsExecProc.ExecProc "CrossRefQuadData", dArgs

    IsValidTeacherFullName = dArgs.Item("result")
    
End Function


Public Function IsNotMember(ParamArray args()) As Boolean
Dim bMember As Boolean
Dim vArgs As Variant
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim sValue As String

    Set clsAppRuntime = args(0)
    sValue = args(1)
    vArgs = args(2)
    Set clsExecProc = args(3)

    bMember = IsMember(clsAppRuntime, sValue, vArgs, clsExecProc)
    
    If bMember = True Then
        IsNotMember = False
    Else
        IsNotMember = True
    End If
End Function





