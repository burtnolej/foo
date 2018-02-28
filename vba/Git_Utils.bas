Attribute VB_Name = "Git_Utils"
Public Const sExecPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\"
Public Const sRuntimePath = "C:\Users\burtnolej\Documents\runtime\"
Public Const sFileName = "C:\Users\burtnolej\Development\pyshell.args.txt"

Const sTokenPath = "C:\Users\burtnolej\.gittoken"
Public Function GetGitToken() As String
    GetGitToken = ReadFile(sTokenPath)
End Function
Public Sub CreateGitArgsFile(sReponame As String, _
        Optional aFiles As Variant, _
        Optional sMessage As String, _
        Optional sUsername As String, _
        Optional sFileName As String = "C:\Users\burtnolej\Development\pyshell.args.txt", _
        Optional sRuntimeDir As String = "C:\Users\burtnolej\Documents\runtime")

Dim PYTHONPATH As String
Dim sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFileName)
    On Error GoTo 0
    Call TouchFile(sFileName)
    
    Call AppendFile(sFileName, "token:" & GetGitToken & vbCrLf)
    Call AppendFile(sFileName, "reponame:" & EncodeBase64(sReponame) & vbCrLf)
    
    If Not IsEmpty(aFiles) And Not IsMissing(sMessage) Then
        Call AppendFile(sFileName, "message:" & EncodeBase64(sMessage) & vbCrLf)
    End If
    
    If Not IsEmpty(aFiles) And Not IsMissing(aFiles) Then
        Call AppendFile(sFileName, "files:" & ArrayNDtoString(aFiles, bUUEncode:=True) & vbCrLf)
    End If
    
    If Not IsMissing(sUsername) Then
        Call AppendFile(sFileName, "username:" & EncodeBase64(sUsername) & vbCrLf)
    End If
End Sub

Public Function GitCommitFiles(sToken As String, aFiles() As String, _
    sReponame As String, sMessage As String)
Dim sExecPath As String
Dim sRuntimePath As String

    CreateGitArgsFile sReponame, sMessage

    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "commit", sFileName, sRuntimePath))
    ShellRun (aArgs)
End Function

Public Function GitCreateRepo(sReponame As String, sUsername As String)
Dim sRuntimePath As String
Dim sExecPath As String

    CreateGitArgsFile sReponame, sUsername:=sUsername
    
    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "create", Git_Utils.sFileName, Git_Utils.sRuntimePath))
    ShellRun (aArgs)
End Function
