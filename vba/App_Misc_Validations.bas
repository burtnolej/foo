Attribute VB_Name = "App_Misc_Validations"
Option Explicit
Const C_MODULE_NAME = "App_Misc_Validations"
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
Public Function IsValidGradeLevel(ParamArray args()) As Boolean
Dim sFuncName As String
Dim aGrades() As String
Dim iValue As Variant
 
setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidGradeLevel"
    iValue = args(1)
main:
    aGrades = Split(C_GRADE_LEVELS, ",")
    If IsValidInteger(args(0), args(1)) = True Then
    
        If InArray(aGrades, iValue) = True Then
            IsValidGradeLevel = True
            FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is valid", C_MODULE_NAME, LogMsgType.OK
            Exit Function
        End If
    End If
err:
    IsValidGradeLevel = False
    FuncLogIt sFuncName, "Value [" & CStr(iValue) & "] is invalid", C_MODULE_NAME, LogMsgType.OK

End Function

Public Function IsValidClassLecture(ParamArray args()) As Boolean
    IsValidClassLecture = True
End Function
Public Function IsValidFreq(ParamArray args()) As Boolean
    IsValidFreq = True
End Function
Public Function IsValidClassType(ParamArray args()) As Boolean
    IsValidClassType = True
End Function
Public Function IsValidSection(ParamArray args()) As Boolean
    IsValidSection = True
End Function
Public Function IsValidLocation(ParamArray args()) As Boolean
    IsValidLocation = True
End Function
Public Function IsValidClassFocusArea(ParamArray args()) As Boolean
    IsValidClassFocusArea = True
End Function
Public Function IsValidSectionEnd(ParamArray args()) As Boolean
    IsValidSectionEnd = True
End Function
Public Function IsValidSectionStart(ParamArray args()) As Boolean
    IsValidSectionStart = True
End Function
Public Function IsValidMaxCapacity(ParamArray args()) As Boolean
    IsValidMaxCapacity = True
End Function
Public Function IsValidAcadPeriod(ParamArray args()) As Boolean
    IsValidAcadPeriod = True
End Function
Public Function IsValidSectionGroup(ParamArray args()) As Boolean
    IsValidSectionGroup = True
End Function
Public Function IsValidSectionPrep(ParamArray args()) As Boolean
    IsValidSectionPrep = True
End Function
Public Function IsValidStudentEnroll(ParamArray args()) As Boolean
    IsValidStudentEnroll = True
End Function
Public Function IsValidFacultyEnroll(ParamArray args()) As Boolean
    IsValidFacultyEnroll = True
End Function
Public Function IsValidWorkHour(ParamArray args()) As Boolean
    IsValidWorkHour = True
End Function
Public Function IsValidPrepStart(ParamArray args()) As Boolean
    IsValidPrepStart = True
End Function
Public Function IsValidPrepEnd(ParamArray args()) As Boolean
    IsValidPrepEnd = True
End Function




        
