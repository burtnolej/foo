Attribute VB_Name = "Date_Utils"
'GetDateString(sDate As String, Optional sFormat As String) As String

Public Function GetDateString(sDate As String, Optional sFormat As String) As String
    If sFormat = "" Then
        sFormat = "ddmmyyHHMMSS"
    End If
    
    GetDateString = Format(sDate, sFormat)
End Function
