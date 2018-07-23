Attribute VB_Name = "Quad_Form_Definitions_Utils"
Option Explicit
Const C_MODULE_NAME = "Quad_Form_Definitions_Utils"

'Public Function GetDefinitionMiscTimePeriod(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionMiscTimePeriod(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionPersonTeacher"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.TimePeriod)
    sDataType = EnumQuadDataType(QuadDataType.Misc)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
  
    If eFormType = FormType.Add Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodStart^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodEnd^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sPeriodTimeLabel^String^^^^^Entry"
        'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idAcadPeriod^Integer^^^^^Entry"
    ElseIf eFormType = FormType.View Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^&UpdateViewTimePeriodForm^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^^^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodStart^^^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodEnd^^^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sPeriodTimeLabel^String^^^^^Entry"
        'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idAcadPeriod^Integer^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionMiscTimePeriod = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function
'Public Function GetDefinitionMiscPrep(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False) As String
Public Function GetDefinitionMiscPrep(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If
setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionMiscPrep"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Prep)
    sDataType = EnumQuadDataType(QuadDataType.Misc)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Or eFormType = FormType.View Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idPrep^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sPrepNm^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If

cleanup:
    GetDefinitionMiscPrep = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

'Public Function GetDefinitionMiscDay(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionMiscDay(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionMiscDay"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Day)
    sDataType = EnumQuadDataType(QuadDataType.Misc)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idDay^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sDayDesc^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdDay^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionMiscDay = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function


'Public Function GetDefinitionCoursesSection(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionCoursesSection(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If
setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionCoursesSection"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Section)
    sDataType = EnumQuadDataType(QuadDataType.Courses)
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSection^String^^^^^Entry" & DOUBLEDOLLAR
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idAcadPeriod^String^IsValidAcadPeriod^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idCourse^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSubject^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idClassType^String^IsValidClassType^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLeadTeacher^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iFreq^String^IsValidFreq^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFreqUnit^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iMaxCapacity^String^IsValidMaxCapacity^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtSectionStart^String^IsValidSectionStart^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtSectionEnd^String^IsValidSectionEnd^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdSectionGroup^String^IsValidSectionGroup^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSectionPrep^Integer^IsValidSectionPrep^^^^Entry"
        
        'need a v2 for these
        'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "lStudentEnroll^String^^^^^Entry" & DOUBLEDOLLAR
        'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "lFacultyEnroll^String^^^^^Entry"


        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.person), EnumQuadSubDataType(QuadSubDataType.Student), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.person), EnumQuadSubDataType(QuadSubDataType.Teacher), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Course), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Subject), sDefn:=sDefn)
        'sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Section), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.ClassTypeCode), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Location), sDefn:=sDefn)
    
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
        
cleanup:
    GetDefinitionCoursesSection = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function

'Public Function GetDefinitionMiscLocation(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionMiscLocation(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If


setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionMiscLocation"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Location)
    sDataType = EnumQuadDataType(QuadDataType.Misc)
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    If eFormType = FormType.Add Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idBuilding^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFloorNbr^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sRoomNbr^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sRoomDesc^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iMaxCapacity^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
        
cleanup:
    GetDefinitionMiscLocation = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function
        
'Public Function GetDefinitionCoursesSubject(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionCoursesSubject(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If


setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionCoursesSubject"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Subject)
    sDataType = EnumQuadDataType(QuadDataType.Courses)
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
        If bLoader = True Then
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sSubjectLongDesc^String^IsNotMember^&get_courses_subject^sSubjectLongDesc^^Entry" & DOUBLEDOLLAR
        Else
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sSubjectLongDesc^String^^^^^Entry" & DOUBLEDOLLAR
        End If
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSubject^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
        
cleanup:
    GetDefinitionCoursesSubject = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

'Public Function GetDefinitionCoursesClassTypeCode(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionCoursesClassTypeCode(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionCoursesClassTypeCode"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.ClassTypeCode)
    sDataType = EnumQuadDataType(QuadDataType.Courses)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idClassType^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sClassTypeDesc^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionCoursesClassTypeCode = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function


'Public Function GetDefinitionCoursesCourse(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionCoursesCourse(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionCoursesCourse"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Course)
    sDataType = EnumQuadDataType(QuadDataType.Courses)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    
    If eFormType = FormType.Add Then

        If bLoader = True Then
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sCourseNm^String^IsNotMember^&get_courses_course^sCourseNm^^Entry" & DOUBLEDOLLAR
        Else
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sCourseNm^String^IsMember^&get_courses_course^sCourseNm^^Entry" & DOUBLEDOLLAR
        End If
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idCourse^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSubject^String^^^^^Entry"
        AddDict dArgs, "eFormType", FormType.Add
        AddDict dArgs, "sDefn", sDefn
        
        'sDefn = GetDefinitionCoursesSubject(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        sDefn = GetDefinitionCoursesSubject(dArgs)
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionCoursesCourse = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function



'Public Function GetDefinitionScheduleStudent(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionScheduleStudent(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionScheduleStudent"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Student)
    sDataType = EnumQuadDataType(QuadDataType.Schedule)

main:
    If sFormName = "" Then
        sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    End If
    
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    
    If eFormType = FormType.View Then
    
        If GetLastChar(sDefn) <> DOLLAR And Len(sDefn) <> 0 Then sDefn = sDefn & DOUBLEDOLLAR
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sClassFocusArea^String^IsValidClassFocusArea^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFirstNm^String^IsMember^&get_person_teacher^sFacultyFirstNm^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdDay^Integer^IsMember^&get_misc_day^cdDay^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^Integer^IsValidLocation^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSection^Integer^IsValidSection^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdClassType^Integer^IsValidClassType^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iFreq^Integer^IsValidFreq^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idClassLecture^Integer^IsValidClassLecture^^^^View"
    End If
    
    If eFormType = FormType.View Or eFormType = FormType.Add Then
    'If eFormType = FormType.View Or eFormType = FormType.Add Or eFormType = FormType.ViewSchedule Then
    
        If GetLastChar(sDefn) <> DOLLAR And Len(sDefn) <> 0 Then sDefn = sDefn & DOUBLEDOLLAR
    
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "sClassFocusArea^String^IsValidClassFocusArea^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "sFacultyFirstNm^String^IsMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "cdDay^Integer^IsMember^&get_misc_day^cdDay^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "idLocation^Integer^IsValidLocation^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "idSection^Integer^IsValidSection^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "cdClassType^Integer^IsValidClassType^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "iFreq^Integer^IsValidFreq^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Student" & HAT & sCacheTableName & HAT & "idClassLecture^Integer^IsValidClassLecture^^^^Entry"
            
        AddDict dArgs, "eFormType", FormType.Add
        AddDict dArgs, "sDefn", sDefn
        
        AddDict dArgs, "sDefn", GetDefinitionPersonStudent(dArgs)
        AddDict dArgs, "sDefn", GetDefinitionCoursesSection(dArgs)
        AddDict dArgs, "sDefn", GetDefinitionCoursesSubject(dArgs)
        AddDict dArgs, "sDefn", GetDefinitionMiscTimePeriod(dArgs)
        AddDict dArgs, "sDefn", GetDefinitionMiscDay(dArgs)
        AddDict dArgs, "sDefn", GetDefinitionMiscLocation(dArgs)
        sDefn = GetDefinitionCoursesClassTypeCode(dArgs)

    End If
    
    If eFormType = FormType.ViewList Then
    
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^String^IsMember^&get_person_student^idStudent^&UpdateViewStudentScheduleForm^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sSubjectLongDesc^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sCourseNm^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sClassFocusArea^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFirstNm^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdDay^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSection^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdClassType^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iFreq^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idClassLecture^^^^^^ListText"

        AddDict dArgs, "eFormType", FormType.Add
        AddDict dArgs, "sDefn", sDefn
        'sDefn = GetDefinitionScheduleStudent(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        'sDefn = GetDefinitionPersonStudent(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        AddDict dArgs, "sDefn", GetDefinitionScheduleStudent(dArgs)
        sDefn = GetDefinitionPersonStudent(dArgs)
    End If
    
cleanup:
    GetDefinitionScheduleStudent = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function

'Public Function GetDefinitionPersonStudentLevel(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionPersonStudentLevel(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionPersonStudentLevel"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.studentlevel)
    sDataType = EnumQuadDataType(QuadDataType.person)
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    
    If eFormType = FormType.Add Or eFormType = FormType.View Then
    
        If GetLastChar(sDefn) <> DOLLAR And Len(sDefn) <> 0 Then sDefn = sDefn & DOUBLEDOLLAR
        
        If bLoader = True Then
            sDefn = sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sStudentFullName^String^^^^^Entry" & DOUBLEDOLLAR
        End If
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idAcadPeriod^Integer^IsValidAcadPeriod^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idPrep^Integer^IsMember^&get_misc_prep^idPrep^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iGradeLevel^Integer^IsValidGradeLevel^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPrepStart^Integer^IsValidPrepStart^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPrepEnd^String^IsValidPrepEnd^^^^Entry"
        
        AddDict dArgs, "eFormType", FormType.Add
        AddDict dArgs, "sDefn", sDefn
        
        'sDefn = GetDefinitionMiscPrep(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        'sDefn = GetDefinitionPersonStudent(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        AddDict dArgs, "sDefn", GetDefinitionMiscPrep(dArgs)

        clsExecProc.ExecProc "GetDefinitionPersonStudent", dArgs
        sDefn = dArgs.Item("result")
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionPersonStudentLevel = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
   
End Function

'Public Function GetDefinitionPersonStudent(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionPersonStudent(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If
        
setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionStudent"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Student)
    sDataType = EnumQuadDataType(QuadDataType.person)
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.View Then
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^&UpdateViewStudentForm^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sStudentLastNm^^^^^^Text" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^^^^^^Text" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idPrep^^^^^^Text" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iGradeLevel^^^^^^Text" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sPrepNm^^^^^^Text" & DOUBLEDOLLAR
        
    End If
    
    If eFormType = FormType.Add Or eFormType = FormType.View Then
    
        If GetLastChar(sDefn) <> DOLLAR And Len(sDefn) <> 0 Then sDefn = sDefn & DOUBLEDOLLAR
        
        If bLoader = True Then
            sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
        Else
            sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentLastNm^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
        End If
        
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "idPrep^Integer^IsMember^&get_misc_prep^idPrep^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "iGradeLevel^Integer^IsValidGradeLevel^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sPrepNm^Integer^IsMember^&get_misc_prep^sPrepNm^^Entry"
        
        ' need to put in V2
        'sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "idAcadPeriod^Integer^IsValidAcadPeriod^^^^Entry" & DOUBLEDOLLAR
        'sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentFullName^String^IsNotValidStudentFullName^&get_person_student^^^Entry"

        AddDict dArgs, "eFormType", FormType.Add
        AddDict dArgs, "sDefn", sDefn
        sDefn = GetDefinitionMiscPrep(dArgs)
        'sDefn = GetDefinitionMiscPrep(clsAppRuntime, clsExecProc, FormType.Add, sDefn)

    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionPersonStudent = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
   
End Function
        
'Public Function GetDefinitionPersonTeacher(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionPersonTeacher(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionPersonTeacher"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Teacher)
    sDataType = EnumQuadDataType(QuadDataType.person)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
 
        
        If bLoader = True Then
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFirstNm^String^IsNotMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyLastNm^String^IsNotMember^&get_person_teacher^sFacultyLastNm^^Entry" & DOUBLEDOLLAR
        Else
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyLastNm^String^^^^^Entry" & DOUBLEDOLLAR
        End If
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idFaculty^Integer^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sFacultyFullName^String^IsNotValidTeacherFullName^&get_person_student^^^Entry"
        
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionPersonTeacher = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
End Function

'Public Function GetDefinitionPersonWorkHours(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionPersonWorkHours(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionPersonWorkHours"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.WorkHours)
    sDataType = EnumQuadDataType(QuadDataType.person)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
 
        
        If bLoader = True Then
            'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFirstNm^String^IsNotMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
            'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyLastNm^String^IsNotMember^&get_person_teacher^sFacultyLastNm^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtStartWorkTime^String^IsValidWorkHour^^^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtEndWorkTime^String^IsValidWorkHour^^^^Entry" & DOUBLEDOLLAR

        Else
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtStartWorkTime^String^^^^^Entry" & DOUBLEDOLLAR
            sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtEndWorkTime^String^^^^^Entry" & DOUBLEDOLLAR
        End If
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idFaculty^Integer^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idDay^Integer^IsMember^&get_misc_day^idDay^^Entry"
        
        AddDict dArgs, "eFormType", FormType.Add
        AddDict dArgs, "sDefn", sDefn
        
        'sDefn = GetDefinitionPersonTeacher(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        'sDefn = GetDefinitionMiscDay(clsAppRuntime, clsExecProc, FormType.Add, sDefn)
        AddDict dArgs, "sDefn", GetDefinitionPersonTeacher(dArgs)
        sDefn = GetDefinitionMiscDay(dArgs)
        
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionPersonWorkHours = sDefn
    AddDict dArgs, "result", sDefn, True
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
End Function



Public Function GetDefinitionScheduleSchool(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:

    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    sSubDataType = "School"
    sDataType = "Schedule"
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If eFormType = FormType.ViewListEntry Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFullName^Integer^IsMember^IsValidFacultyFullName^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdDay^Integer^IsMember^IsValidDayCd^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^IsValidTimePeriod^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^Integer^IsMember^IsValidLocation^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "cdClassType^Integer^IsMember^IsValidClassType^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sStudentFullName^String^IsMember^IsValidStudentFullName^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFullName^String^IsMember^IsValidFacultyFullName^^^Entry"
    End If
    
    'sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Schedule), EnumQuadSubDataType(QuadSubDataType.Lesson), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Subject), sDefn:=sDefn)

    
cleanup:
    GetDefinitionScheduleSchool = sDefn
    AddDict dArgs, "result", sDefn, True
    
End Function
    
'Public Function GetDefinitionScheduleLesson(eFormType As FormType, Optional sDefn As String, Optional sFormName As String, Optional bLoader As Boolean = False)
Public Function GetDefinitionScheduleLesson(dArgs As Dictionary)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String, sDefn As String, sFormName As String
Dim lStartTick As Long
Dim eFormType As FormType
Dim bLoader As Boolean
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    eFormType = dArgs.Item("eFormType")
    If dArgs.Exists("sDefn") Then
        ' generating a specific form not all defined
        sDefn = dArgs.Item("sDefn")
    Else
        sDefn = ""
    End If

    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("bLoader") Then
        ' generating a specific form not all defined
        bLoader = dArgs.Item("bLoader")
    Else
        bLoader = False
    End If

setup:

    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    sSubDataType = "Lesson"
    sDataType = "Schedule"
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)

    If eFormType = FormType.ViewSchedule Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^&GenerateScheduleView^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "oScheduleView^^^" & sFormName & "^^^Schedule" & DOUBLEDOLLAR
        
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idFaculty^Integer^IsMember^&get_person_teacher^idFaculty^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idSection^Integer^IsMember^&get_courses_section^idSection^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idLocation^Integer^IsMember^&get_misc_location^idLocation^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idDay^Integer^IsMember^&get_misc_day^idDay^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry"

        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.person), EnumQuadSubDataType(QuadSubDataType.Student), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.person), EnumQuadSubDataType(QuadSubDataType.Teacher), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Course), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Subject), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Section), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.TimePeriod), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Prep), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Location), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Day), sDefn:=sDefn)
        sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.ClassTypeCode), sDefn:=sDefn)
        GoTo cleanup
        
    End If

    If eFormType = FormType.ViewList Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^&GenerateScheduleLessonListView^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idFaculty^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSection^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idDay^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^^^^^^ListText"
    End If
    
    If eFormType = FormType.ViewListEntry Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^&GenerateScheduleLessonListView^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idFaculty^Integer^IsMember^&get_person_teacher^idFaculty^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSection^Integer^IsMember^&get_courses_section^idSection^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^Integer^IsMember^&get_misc_location^idLocation^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idDay^Integer^IsMember^&get_misc_day^idDay^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry"
    End If
    
    If eFormType = FormType.ViewList Or eFormType = FormType.ViewListEntry Or eFormType = FormType.Add Then
    
        If GetLastChar(sDefn) <> DOLLAR And Len(sDefn) <> 0 Then sDefn = sDefn & DOUBLEDOLLAR
        
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idFaculty^Integer^IsMember^&get_person_teacher^idFaculty^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idSection^Integer^IsMember^&get_courses_section^idSection^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idLocation^Integer^IsMember^&get_misc_location^idLocation^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idDay^Integer^IsMember^&get_misc_day^idDay^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry"
    End If
    
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.person), EnumQuadSubDataType(QuadSubDataType.Student), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.person), EnumQuadSubDataType(QuadSubDataType.Teacher), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Course), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Subject), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Section), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.ClassTypeCode), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.TimePeriod), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Prep), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Location), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Day), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(clsAppRuntime, clsExecProc, FormType.Add, EnumQuadDataType(QuadDataType.Schedule), EnumQuadSubDataType(QuadSubDataType.Student), sDefn:=sDefn) & DOUBLEDOLLAR


    sDefn = sDefn & sFormName & "^^COMMIT^^^" & sFormName & "^^^Button"

cleanup:
    GetDefinitionScheduleLesson = sDefn
    AddDict dArgs, "result", sDefn, True
End Function
