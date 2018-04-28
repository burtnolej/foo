Attribute VB_Name = "Date_Utils"
'GetDateString(sDate As String, Optional sFormat As String) As String

Public Function GetDateString(sDate As String, Optional sFormat As String) As String
    If sFormat = "" Then
        sFormat = "ddmmyyHHMMSS"
    End If
    
    GetDateString = Format(sDate, sFormat)
End Function

Sub test()
Dim d1 As Date
Dim lResult As Double

    d1 = Now()
    lResult = GetTimeDelta(d1, Now())
    
    Debug.Print Round(lResult, 10) * 100000
End Sub
Public Function GetTimeDelta(d1 As Date, d2 As Date) As Double
    GetTimeDelta = d2 - d1
    
End Function
