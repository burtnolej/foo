Attribute VB_Name = "App_Courses"
Option Explicit
Public Function get_courses_course(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_course = GetPersonData(clsAppRuntime, _
                                           QuadDataType.courses, _
                                           QuadSubDataType.Course, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_courses_subject(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_courses_subject = GetPersonData(clsAppRuntime, _
                                           QuadDataType.courses, _
                                           QuadSubDataType.subject, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_misc_timeperiod(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_misc_timeperiod = GetPersonData(clsAppRuntime, _
                                           QuadDataType.misc, _
                                           QuadSubDataType.TimePeriod, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_misc_prep(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_misc_prep = GetPersonData(clsAppRuntime, _
                                           QuadDataType.misc, _
                                           QuadSubDataType.Prep, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
Public Function get_misc_day(clsAppRuntime As App_Runtime, _
                          Optional bInTable As Boolean = True) As Worksheet
    Set get_misc_day = GetPersonData(clsAppRuntime, _
                                           QuadDataType.misc, _
                                           QuadSubDataType.day, _
                                           eQuadScope:=QuadScope.all, _
                                           bInTable:=bInTable)
End Function
