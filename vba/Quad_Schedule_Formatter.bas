Attribute VB_Name = "Quad_Schedule_Formatter"
Const C_MODULE_NAME = "Quad_Schedule_Formatter"

Function FmtRowLabel(dArgs As Dictionary) As String
'Function FmtRowLabel(ByVal sValue As String, Optional clsAppRuntime As App_Runtime) As String
Dim sPeriodStart As String, sPeriodEnd As String
Dim dFields As Dictionary
Dim clsAppRuntime As App_Runtime
Dim idAcadPeriod As Integer

unpackargs:
    
    sValue = dArgs.Item("sValue")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")
    
    If dArgs.Exists("idAcadPeriod") = True Then
        idAcadPeriod = dArgs.Item("idAcadPeriod")
    Else
        idAcadPeriod = 1
    End If

    If IsSet(clsAppRuntime) = False Then
        Set clsAppRuntime = New App_Runtime
        clsAppRuntime.InitProperties bInitializeCache:=False
    End If
    
main:


    AddArgs dArgs, False, "eQuadDataType", QuadDataType.Misc, _
                          "eQuadSubDataType", QuadSubDataType.TimePeriod, _
                          "sLookUpByColName", "idTimePeriod", _
                          "sLookUpByValue", sValue, _
                          "sLookUpColName", "sPeriodTimeLabel", _
                          "sLookUpByColName2", "idAcadPeriod", _
                          "sLookUpByValue2", idAcadPeriod

            
    Application.Run C_CROSS_REF_QUAD_DATA, dArgs
    sPeriodTimeLabel = dArgs.Item("result")


    FmtRowLabel = sPeriodTimeLabel
End Function
Function FmtColLabel(dArgs As Dictionary) As String
Dim dFields As Dictionary
Dim clsAppRuntime As App_Runtime
Dim sColLabel As String

unpackargs:
    
    sValue = dArgs.Item("sValue")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")

    If IsSet(clsAppRuntime) = False Then
        Set clsAppRuntime = New App_Runtime
        clsAppRuntime.InitProperties bInitializeCache:=False
    End If

main:
    AddArgs dArgs, False, "eQuadDataType", QuadDataType.Misc, _
                          "eQuadSubDataType", QuadSubDataType.Day, _
                          "sLookUpByColName", "cdDay", _
                          "sLookUpByValue", sValue, _
                          "sLookUpColName", "sDayDesc"
            
    Application.Run C_CROSS_REF_QUAD_DATA, dArgs
    sColLabel = dArgs.Item("result")

    FmtColLabel = sColLabel
End Function
Function FmtRowID(dArgs As Dictionary) As String
    FmtRowID = dArgs.Item("sValue")
End Function
Function FmtSSCourseName(dArgs As Dictionary) As String
'Function FmtSSCourseName(ByVal dFields As Dictionary, Optional clsAppRuntime As App_Runtime) As String
Dim iCourseID As Integer
Dim dFields As Dictionary
Dim clsAppRuntime As App_Runtime

unpackargs:
    
    Set dFields = dArgs.Item("dFields")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")

    If IsSet(clsAppRuntime) = False Then
        Set clsAppRuntime = New App_Runtime
        clsAppRuntime.InitProperties bInitializeCache:=False
    End If

main:
    If dFields.Exists("sCourseNm") = False Then
        
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, _
                              "eQuadSubDataType", QuadSubDataType.Section, _
                              "sLookUpByColName", "idSection", _
                              "sLookUpByValue", dFields.Item("idSection"), _
                              "sLookUpColName", "idCourse"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        iCourseID = dArgs.Item("result")
        'iCourseID = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Section, _
        '            "idSection", dFields.Item("idSection"), "idCourse")
        
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, _
                              "eQuadSubDataType", QuadSubDataType.Course, _
                              "sLookUpByColName", "idCourse", _
                              "sLookUpByValue", iCourseID, _
                              "sLookUpColName", "sCourseNm"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        FmtSSCourseName = dArgs.Item("result")
        'FmtSSCourseName = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Course, _
        '            "idCourse", iCourseID, "sCourseNm")
                    
    Else
        FmtSSCourseName = dFields.Item("sCourseNm")
    End If

End Function


'Function FmtSSSubjectName(ByVal dFields As Dictionary, Optional clsAppRuntime As App_Runtime) As String
Function FmtSSSubjectName(dArgs As Dictionary) As String
Dim idSubject As Integer
Dim dFields As Dictionary
Dim clsAppRuntime As App_Runtime

unpackargs:
    
    Set dFields = dArgs.Item("dFields")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")

    If IsSet(clsAppRuntime) = False Then
        Set clsAppRuntime = New App_Runtime
        clsAppRuntime.InitProperties bInitializeCache:=False
    End If

setup:
    On Error GoTo err
    
main:

    If dFields.Exists("sSubjectNm") = True Then
        FmtSSSubjectName = dFields.Item("sSubjectNm")
        Exit Function
    End If
    
    If dFields.Exists("idSubject") = True Then
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, "eQuadSubDataType", QuadSubDataType.Subject, _
            "sLookUpByColName", "idSubject", "sLookUpByValue", idSubject, "sLookUpColName", "sSubjectNm"
            
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        'FmtSSSubjectName = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Subject, _
        '            "idSubject", idSubject, "sSubjectNm")
        GoTo cleanup

    End If
    
    If dFields.Exists("idSection") = True Then
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, "eQuadSubDataType", QuadSubDataType.Section, _
            "sLookUpByColName", "idSection", "sLookUpByValue", dFields.Item("idSection"), "sLookUpColName", "idSubject"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        idSubject = dArgs.Item("result")
                
        'idSubject = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Section, _
        '            "idSection", dFields.Item("idSection"), "idSubject")
        
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, "eQuadSubDataType", QuadSubDataType.Subject, _
            "sLookUpByColName", "idSubject", "sLookUpByValue", idSubject, "sLookUpColName", "sSubjectLongDesc"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        'FmtSSSubjectName = dArgs.Item("result")
        
        'FmtSSSubjectName = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Subject, _
        '            "idSubject", idSubject, "sSubjectLongDesc")
        
        GoTo cleanup
    End If
    
    GoTo err

cleanup:
    FmtSSSubjectName = dArgs.Item("result")
    Exit Function
 
err:
    err.Raise ErrorMsgType.INSUFFICIENT_FIELDS_TO_DO_LOOKUP, Description:="[nu"
    
End Function

Function FmtSSName(dArgs As Dictionary) As String
'Function FmtSSName(ByVal dFields As Dictionary, Optional clsAppRuntime As App_Runtime) As String
'""" the schedule drawer iterates over the schedule data table and based on the template
'    calls this routine to generate the content
':param: dFields, dictionary, available data fields associated with this day/period pair
'John [ 1:1 ]
Dim sClassType As String
Dim dFields As Dictionary
Dim clsAppRuntime As App_Runtime
Dim idClassType As String

unpackargs:
    
    Set dFields = dArgs.Item("dFields")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")

    If IsSet(clsAppRuntime) = False Then
        Set clsAppRuntime = New App_Runtime
        clsAppRuntime.InitProperties bInitializeCache:=False
    End If
    
main:
    If dFields.Exists("cdClassType") = False Then
        sClassType = "NotSet"
    Else
        sClassType = dFields.Item("cdClassType")
    End If
    
    If dFields.Exists("sFacultyFirstNm") = False Then
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.person, _
                              "eQuadSubDataType", QuadSubDataType.Teacher, _
                              "sLookUpByColName", "idFaculty", _
                              "sLookUpByValue", dFields.Item("idFaculty"), _
                              "sLookUpColName", "sFacultyFirstNm"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        FmtSSName = dArgs.Item("result")
        
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, _
                              "eQuadSubDataType", QuadSubDataType.Section, _
                              "sLookUpByColName", "idSection", _
                              "sLookUpByValue", dFields.Item("idSection"), _
                              "sLookUpColName", "idClassType"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        idClassType = dArgs.Item("result")
        
        AddArgs dArgs, False, "eQuadDataType", QuadDataType.Courses, _
                              "eQuadSubDataType", QuadSubDataType.ClassTypeCode, _
                              "sLookUpByColName", "idClassType", _
                              "sLookUpByValue", idClassType, _
                              "sLookUpColName", "sClassTypeDesc"
        Application.Run C_CROSS_REF_QUAD_DATA, dArgs
        sClassTypeDesc = dArgs.Item("result")
        
        FmtSSName = FmtSSName & "[" & sClassTypeDesc & "]"

    Else
        FmtSSName = dFields.Item("sFacultyFirstNm") & "[" & sClassType & "]"
    End If

    AddDict dArgs, "result", FmtSSName, True
End Function
Function FmtSSLoc(dArgs As Dictionary) As String
'Function FmtSSLoc(ByVal dFields As Dictionary, Optional clsAppRuntime As App_Runtime) As String
'Room: 420B
Dim sLocation As String
Dim dFields As Dictionary

unpackargs:
    
    Set dFields = dArgs.Item("dFields")

main:
    If dFields.Exists("idLocation") = False Then
        sLocation = "NotSet"
    Else
        sLocation = dFields.Item("idLocation")
    End If

cleanup:
    FmtSSLoc = "Room:" & sLocation
    AddDict dArgs, "result", FmtSSLoc
End Function
Function FmtTSSection(dArgs As Dictionary) As String
'Function FmtTSSection(ByVal dFields As Dictionary, Optional clsAppRuntime As App_Runtime) As String
'Sect 110 | F2
Dim dFields As Dictionary

unpackargs:
    Set dFields = dArgs.Item("dFields")
main:
    FmtTSSection = dFields.Item("idSection")
    AddDict dArgs, "result", FmtTSSection
End Function
Function FmtTSType(dArgs As Dictionary) As String
'Function FmtTSType(ByVal dFields As Dictionary, Optional clsAppRuntime As App_Runtime) As String
'Seminar - Sect 110
Dim dFields As Dictionary

unpackargs:
    Set dFields = dArgs.Item("dFields")
main:
    FmtTSType = dFields.Item("cdClassType") & " - Sect " & dFields.Item("idSection")
    AddDict dArgs, "result", FmtTSType
End Function
