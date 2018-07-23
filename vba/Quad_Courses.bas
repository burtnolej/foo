Attribute VB_Name = "Quad_Courses"
Option Explicit

Const C_MODULE_NAME = "Quad_Courses"

Public Function get_courses_course(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, _
                          Optional bInTable As Boolean = True) As Worksheet
Dim dArgs As New Dictionary

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "bInTable", bInTable, _
                          "clsExecProc", clsExecProc, _
                          "eQuadDataType", QuadDataType.Courses, _
                          "eQuadSubDataType", QuadSubDataType.Course, _
                          "eQuadScope", QuadScope.all
    
    clsExecProc.ExecProc "GetPersonData", dArgs
    Set get_courses_course = dArgs.Item("result")
    
End Function
Public Function get_courses_subject(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, _
                          Optional bInTable As Boolean = True) As Worksheet
Dim dArgs As New Dictionary

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "bInTable", bInTable, _
                          "clsExecProc", clsExecProc, _
                          "eQuadDataType", QuadDataType.Courses, _
                          "eQuadSubDataType", QuadSubDataType.Subject, _
                          "eQuadScope", QuadScope.all
    
    clsExecProc.ExecProc "GetPersonData", dArgs
    Set get_courses_subject = dArgs.Item("result")
    
End Function

Public Function get_courses_section(clsAppRuntime As App_Runtime, clsExecProc As Exec_Proc, _
                          Optional bInTable As Boolean = True) As Worksheet
Dim dArgs As New Dictionary


    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "bInTable", bInTable, _
                          "clsExecProc", clsExecProc, _
                          "eQuadDataType", QuadDataType.Courses, _
                          "eQuadSubDataType", QuadSubDataType.Section, _
                          "eQuadScope", QuadScope.all

    clsExecProc.ExecProc "GetPersonData", dArgs
    Set get_courses_section = dArgs.Item("result")
    
End Function
