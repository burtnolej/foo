Attribute VB_Name = "Quad_Data_Utils"
Option Explicit

Const C_MODULE_NAME = "Quad_Data_Utils"

' EnumQuadDataType
' GetQuadDataTypeEnumFromValue

' EnumQuadSubDataType
' GetQuadSubDataTypeEnumFromValue

' EnumQuadScope
' GetQuadScopeEnumFromValue
Public Const C_PREPS = "1,2,3,4,5"
Public Const C_GRADE_LEVELS = "1,2,3,4,5,6,7,8,9,10,11,12"

Enum ListType
    Students = 1
    Teachers = 2
End Enum

Enum QuadDataType
    Schedule = 1
    Person = 2
    Courses = 3
    Misc = 4
End Enum

Const C_QUAD_DATA_TYPE = "schedule,person,courses,misc"

Enum QuadSubDataType
    Student = 1
    Teacher = 2
    Course = 3
    Subject = 4
    TimePeriod = 5
    Day = 6
    Prep = 7
    Lesson = 8
    Studentlevel = 9
    Location = 10
    Section = 11
End Enum

Const C_QUAD_SUB_DATA_TYPE = "student,teacher,course,subject,timeperiod,day,prep,lesson,studentlevel,location,section"

Enum QuadScope
    all = 1
    specified = 2
End Enum

Const C_QUAD_SCOPE = "all,specified"

Function EnumQuadDataType(i As Long) As String
    EnumQuadDataType = Split(C_QUAD_DATA_TYPE, COMMA)(i - 1)
End Function
Function GetQuadDataTypeEnumFromValue(sValue As String) As Long
    GetQuadDataTypeEnumFromValue = IndexArray(C_QUAD_DATA_TYPE, sValue)
End Function
Function EnumQuadSubDataType(i As Long) As String
    EnumQuadSubDataType = Split(C_QUAD_SUB_DATA_TYPE, COMMA)(i - 1)
End Function
Function GetQuadSubDataTypeEnumFromValue(sValue As String) As Long
    GetQuadSubDataTypeEnumFromValue = IndexArray(C_QUAD_SUB_DATA_TYPE, sValue)
End Function
Function EnumQuadScope(i As Long) As String
    EnumQuadScope = Split(C_QUAD_SCOPE, COMMA)(i - 1)
End Function
Function GetQuadScopeEnumFromValue(sValue As String) As Long
    GetQuadScopeEnumFromValue = IndexArray(C_QUAD_SCOPE, sValue)
End Function

