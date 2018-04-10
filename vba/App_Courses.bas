Attribute VB_Name = "App_Courses"
Option Explicit
Public Function get_courses_course(clsQuadRuntime As Quad_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_course = GetPersonData(clsQuadRuntime, _
                                           QuadDataType.courses, _
                                           QuadSubDataType.Course, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_courses_subject(clsQuadRuntime As Quad_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_subject = GetPersonData(clsQuadRuntime, _
                                           QuadDataType.courses, _
                                           QuadSubDataType.subject, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_misc_timeperiod(clsQuadRuntime As Quad_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_misc_timeperiod = GetPersonData(clsQuadRuntime, _
                                           QuadDataType.misc, _
                                           QuadSubDataType.timeperiod, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_misc_prep(clsQuadRuntime As Quad_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_misc_prep = GetPersonData(clsQuadRuntime, _
                                           QuadDataType.misc, _
                                           QuadSubDataType.prep, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_misc_day(clsQuadRuntime As Quad_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_misc_day = GetPersonData(clsQuadRuntime, _
                                           QuadDataType.misc, _
                                           QuadSubDataType.day, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
