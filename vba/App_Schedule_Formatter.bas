Attribute VB_Name = "App_Schedule_Formatter"
Function FmtRowLabel(ByVal sValue As String) As String
Dim clsAppRuntime As New App_Runtime
Dim sPeriodStart As String, sPeriodEnd As String
    clsAppRuntime.InitProperties bInitializeCache:=False
    sPeriodStart = CrossRefQuadData(clsAppRuntime, QuadDataType.Misc, QuadSubDataType.TimePeriod, _
                "idTimePeriod", sValue, "dtPeriodStart")
    sPeriodEnd = CrossRefQuadData(clsAppRuntime, QuadDataType.Misc, QuadSubDataType.TimePeriod, _
                "idTimePeriod", sValue, "dtPeriodEnd")
                
    FmtRowLabel = sPeriodStart & "-" & sPeriodEnd
End Function

Function FmtRowID(ByVal sValue As String) As String
    FmtRowID = sValue
End Function
Function FmtColLabel(ByVal sValue As String) As String
    FmtColLabel = sValue
End Function

Function FmtSSCourseName(ByVal dFields As Dictionary) As String
Dim clsAppRuntime As New App_Runtime
Dim iCourseID As Integer
    clsAppRuntime.InitProperties bInitializeCache:=False
    
    If dFields.Exists("sCourseNm") = False Then
        iCourseID = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Section, _
                    "idSection", dFields.Item("idSection"), "idCourse")
        FmtSSCourseName = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Course, _
                    "idCourse", iCourseID, "sCourseNm")
                    
    Else
        FmtSSCourseName = dFields.Item("sCourseNm")
    End If

End Function
Function FmtSSName(ByVal dFields As Dictionary) As String
'""" the schedule drawer iterates over the schedule data table and based on the template
'    calls this routine to generate the content
':param: dFields, dictionary, available data fields associated with this day/period pair
'John [ 1:1 ]
Dim clsAppRuntime As New App_Runtime
Dim sClassType As String

    clsAppRuntime.InitProperties bInitializeCache:=False
    

    If dFields.Exists("cdClassType") = False Then
        sClassType = "NotSet"
    Else
        sClassType = dFields.Item("cdClassType")
    End If
    
    If dFields.Exists("sFacultyFirstNm") = False Then
        FmtSSName = CrossRefQuadData(clsAppRuntime, QuadDataType.Courses, QuadSubDataType.Section, _
                    "idSection", dFields.Item("idSection"), "idLeadTeacher")
    Else
        FmtSSName = dFields.Item("sFacultyFirstNm") & "[" & sClassType & "]"
    End If
    
End Function
Function FmtSSLoc(ByVal dFields As Dictionary) As String
'Room: 420B
Dim sLocation As String
    If dFields.Exists("idLocation") = False Then
        sLocation = "NotSet"
    Else
        sLocation = dFields.Item("idLocation")
    End If
    
    FmtSSLoc = "Room:" & sLocation
End Function
Function FmtTSSection(ByVal dFields As Dictionary) As String
'Sect 110 | F2
    FmtTSSection dFields.Item("idSection")
End Function
Function FmtTSType(ByVal dFields As Dictionary) As String
'Seminar - Sect 110
    FmtTSType dFields.Item("cdClassType") & " - Sect " & dFields.Item("idSection")
End Function
