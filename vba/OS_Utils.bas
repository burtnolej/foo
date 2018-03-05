Attribute VB_Name = "OS_Utils"
Const C_MODULE_NAME = "OS_Utils"
Public Function ShellRun(ParamArray X()) As String
Dim s As String
Dim sLine As String
Dim oShell As Object
Dim oExec As Object
Dim oOutput As Object, oError As Object
Dim sCmd As String
Dim iX As Integer
Dim sFuncName As String
Dim sCwd As String

    sFuncName = "ShellRun"

    sCwd = GetHomePath
    
    ChDir sCwd & "/runtime"

    FuncLogIt sFuncName, "running from directory [" & sCwd & "]", C_MODULE_NAME, LogMsgType.INFO
    
    sCmd = "cmd /c " & Join(X(0), " ")
    
    'Run a shell command, returning the output as a string'
    Set oShell = CreateObject("WScript.Shell")

    'run command'
    'On Error Resume Next
    Set oExec = oShell.Exec(sCmd)
    Set oOutput = oExec.StdOut
    Set oError = oExec.StdErr

    'handle the results as they are written to and read from the StdOut object'
    While Not oOutput.AtEndOfStream
        sLine = oOutput.ReadLine
        If sLine <> "" Then s = s & sLine & vbCrLf
    Wend
   
    If oExec.ExitCode = 0 Then
        FuncLogIt sFuncName, "executed shell cmd [" & sCmd & "]", C_MODULE_NAME, LogMsgType.OK
    Else
        FuncLogIt sFuncName, "Error executing shell cmd [" & sCmd & "]", C_MODULE_NAME, LogMsgType.FAILURE
        ShellRun = "-1"
        Exit Function
    End If
    
    ShellRun = s

End Function

Public Function GetHomePath() As String
Dim oShell As Object
    Set oShell = CreateObject("WScript.Shell")
    GetHomePath = oShell.SpecialFolders("MyDocuments")
End Function

Public Function PopUpWindow(strText As String, strTitle As String, iType As Integer, _
            Optional iWait As Integer = 3000) As Integer
Dim oShell As Object

'https://ss64.com/vb/popup.html

    Set oShell = CreateObject("WScript.Shell")
    PopUpWindow = oShell.Popup(strText, iWait, strTitle, iType)

End Function

Public Sub PopUpInput()

   Debug.Print InputBox("Give me some input", "Hi", 1)

End Sub
