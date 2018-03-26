Attribute VB_Name = "App_Schedule_Formatter"
Function FmtSSCourseName(dFields As Dictionary) As String
'Science
    FmtSSCourseName = dFields.Item("sCourseNm")
End Function
Function FmtSSName(dFields As Dictionary) As String
'""" the schedule drawer iterates over the schedule data table and based on the template
'    calls this routine to generate the content
':param: dFields, dictionary, available data fields associated with this day/period pair
'John [ 1:1 ]
    FmtSSName = dFields.Item("sFacultyFirstNm") & "[" & dFields.Item("cdClassType") & "]"
End Function
Function FmtSSLoc(dFields As Dictionary) As String
'Room: 420B
    FmtSSLoc = "Room:" & dFields.Item("idLocation")
End Function
Function FmtTSSection(dFields As Dictionary) As String
'Sect 110 | F2
    FmtTSSection dFields.Item("idSection")
End Function
Function FmtTSType(dFields As Dictionary) As String
'Seminar - Sect 110
    FmtTSType dFields.Item("cdClassType") & " - Sect " & dFields.Item("idSection")
End Function
