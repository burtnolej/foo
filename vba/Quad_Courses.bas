Attribute VB_Name = "Quad_Courses"
Option Explicit

Const C_MODULE_NAME = "Quad_Courses"

Public Function get_courses_course(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_course = GetPersonData(clsAppRuntime, _
                                           QuadDataType.Courses, _
                                           QuadSubDataType.Course, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_courses_subject(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_subject = GetPersonData(clsAppRuntime, _
                                           QuadDataType.Courses, _
                                           QuadSubDataType.Subject, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function

Public Function get_courses_section(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_section = GetPersonData(clsAppRuntime, _
                                           QuadDataType.Courses, _
                                           QuadSubDataType.Section, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
