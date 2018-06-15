Attribute VB_Name = "Quad_Form_Definitions_Utils"
Option Explicit
Const C_MODULE_NAME = "Quad_Form_Definitions_Utils"

' GetDefinitionMiscTimePeriod
' GetDefinitionMiscPrep
' GetDefinitionMiscDay
' GetDefinitionMiscLocation

' GetDefinitionCoursesSection
' GetDefinitionCoursesSubject
' GetDefinitionCoursesCourse

' GetDefinitionPersonStudent
' GetDefinitionPersonTeacher

' GetDefinitionScheduleLesson
' GetDefinitionScheduleStudent

Enum DefinitionErrorMsgType
    BAD_SUBDATATYPE = 10001
    INVALID_FORMTYPE = 10002
End Enum

Enum DefnType
    Lesson = 1
End Enum

Public Const C_DEFN_TYPE = "AddLesson"

Function EnumDefnType(i As Long) As String
    EnumDefnType = Split(C_DEFN_TYPE, COMMA)(i - 1)
End Function

Public Function GetDefinitionMiscTimePeriod(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodEnd^String^^^^^Entry"
    ElseIf eFormType = FormType.View Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^&UpdateViewTimePeriodForm^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^^^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodStart^^^^^^View" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtPeriodEnd^^^^^^View"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionMiscTimePeriod = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function
Public Function GetDefinitionMiscPrep(eFormType As FormType, Optional sDefn As String, Optional sFormName As String) As String
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function

Public Function GetDefinitionMiscDay(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function


Public Function GetDefinitionCoursesSection(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idAcadPeriod^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSubject^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idCourse^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idClassType^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLeadTeacher^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idPrepRangeFrom^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idPrepRangeTo^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iFreq^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFreqUnit^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "iMaxCapacity^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtSectionStart^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "dtSectionEnd^String^^^^^Entry"
        
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
        
cleanup:
    GetDefinitionCoursesSection = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function

Public Function GetDefinitionMiscLocation(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function
        
Public Function GetDefinitionCoursesSubject(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sSubjectLongDesc^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSubject^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
        
cleanup:
    GetDefinitionCoursesSubject = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function
Public Function GetDefinitionCoursesCourse(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sCourseNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idCourse^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSubject^String^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionCoursesCourse = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function
Public Function GetDefinitionScheduleStudent(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

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
        
        sDefn = GetDefinitionPersonStudent(FormType.Add, sDefn)
        sDefn = GetDefinitionCoursesSection(FormType.Add, sDefn)
        sDefn = GetDefinitionMiscTimePeriod(FormType.Add, sDefn)
        sDefn = GetDefinitionMiscDay(FormType.Add, sDefn)
        sDefn = GetDefinitionMiscLocation(FormType.Add, sDefn)
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

        sDefn = GetDefinitionScheduleStudent(FormType.Add, sDefn)
        sDefn = GetDefinitionPersonStudent(FormType.Add, sDefn)
    End If
    
cleanup:
    GetDefinitionScheduleStudent = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function


Public Function GetDefinitionPersonStudent(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sCacheTableName As String, sSubDataType As String, sDataType As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionStudent"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Student)
    sDataType = EnumQuadDataType(QuadDataType.Person)
    
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
            
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "idPrep^Integer^IsMember^&get_misc_prep^idPrep^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "iGradeLevel^Integer^IsValidGradeLevel^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Person_Student" & HAT & sCacheTableName & HAT & "sPrepNm^String^IsPrepNm^^^^Entry"
        
        sDefn = GetDefinitionMiscPrep(FormType.Add, sDefn)
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionPersonStudent = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
   
End Function
        
Public Function GetDefinitionPersonTeacher(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sFuncName As String, sSubDataType As String, sDataType As String, sCacheTableName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDefinitionPersonTeacher"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Teacher)
    sDataType = EnumQuadDataType(QuadDataType.Person)

main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)
    
    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR

    If eFormType = FormType.Add Then
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "sFacultyLastNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idFaculty^Integer^^^^^Entry"
    Else
        err.Raise DefinitionErrorMsgType.INVALID_FORMTYPE, Description:="[FormType=" & EnumFormType(eFormType) & "]"
    End If
    
cleanup:
    GetDefinitionPersonTeacher = sDefn
    FuncLogIt sFuncName, "[sDefn=" & sDefn & "] [eFormType=" & EnumFormType(eFormType) & "] [result=" & sDefn & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
End Function
Public Function GetDefinitionScheduleLesson(eFormType As FormType, Optional sDefn As String, Optional sFormName As String)
Dim sSubDataType As String, sDataType As String, sCacheTableName As String

    If sDefn <> "" Then sDefn = sDefn & DOUBLEDOLLAR
    sSubDataType = "Lesson"
    sDataType = "Schedule"
    
main:
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))
    sCacheTableName = GetCacheTableNameFromDataType(sDataType, sSubDataType)

    If eFormType = FormType.ViewList Then
    
        'sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^&UpdateListViewScheduleLessonForm^Selector" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^&GenerateScheduleLessonListView^Selector" & DOUBLEDOLLAR
        
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idStudent^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idFaculty^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idSection^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idLocation^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idDay^^^^^^ListText" & DOUBLEDOLLAR
        sDefn = sDefn & sFormName & HAT & sCacheTableName & HAT & "idTimePeriod^^^^^^ListText"
    End If
    
    If eFormType = FormType.ViewList Or eFormType = FormType.Add Then
    
        If GetLastChar(sDefn) <> DOLLAR And Len(sDefn) <> 0 Then sDefn = sDefn & DOUBLEDOLLAR
        
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idStudent^Integer^IsMember^&get_person_student^idStudent^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idFaculty^Integer^IsMember^&get_person_teacher^idFaculty^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idSection^Integer^IsMember^&get_courses_section^idSection^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idLocation^Integer^IsMember^&get_misc_location^idLocation^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idDay^Integer^IsMember^&get_misc_day^idDay^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "Add_Schedule_Lesson" & HAT & sCacheTableName & HAT & "idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry"
    End If
    
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Person), EnumQuadSubDataType(QuadSubDataType.Student), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Person), EnumQuadSubDataType(QuadSubDataType.Teacher), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Course), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Subject), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Courses), EnumQuadSubDataType(QuadSubDataType.Section), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.TimePeriod), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Prep), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Location), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Misc), EnumQuadSubDataType(QuadSubDataType.Day), sDefn:=sDefn)
    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Schedule), EnumQuadSubDataType(QuadSubDataType.Student), sDefn:=sDefn) & DOUBLEDOLLAR


    sDefn = sDefn & sFormName & "^^COMMIT^^^" & sFormName & "^^^Button"

    GetDefinitionScheduleLesson = sDefn
End Function
