Attribute VB_Name = "Git_Utils"
Public Const sExecPath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\utils\"
Public Const sRuntimeDir = "C:\Users\burtnolej\Documents\runtime\"
Public Const sFileName = "C:\Users\burtnolej\Development\uupyshell.args.txt"

Const sTokenPath = "C:\Users\burtnolej\.gittoken"
Public Function GetGitToken() As String
    GetGitToken = ReadFile(sTokenPath)
End Function
Public Sub CreateGitArgsFile(sRepoName As String, _
        sGitRootPath As String, _
        Optional aFiles As Variant, _
        Optional sMessage As String, _
        Optional sUsername As String, _
        Optional sFileName As String = "C:\Users\burtnolej\Development\uupyshell.args.txt", _
        Optional sRuntimeDir As String = "C:\Users\burtnolej\Documents\runtime")

Dim PYTHONPATH As String
Dim sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFileName)
    On Error GoTo 0
    Call TouchFile(sFileName)
    
    Call AppendFile(sFileName, "token:" & UUEncode(GetGitToken) & vbCrLf)
    Call AppendFile(sFileName, "reponame:" & UUEncode(sRepoName) & vbCrLf)
    Call AppendFile(sFileName, "gitrootpath:" & UUEncode(sGitRootPath) & vbCrLf)
     
    If Not IsEmpty(aFiles) And Not IsMissing(sMessage) Then
        Call AppendFile(sFileName, "commit_message:" & UUEncode(sMessage) & vbCrLf)
    End If
    
    If Not IsEmpty(aFiles) And Not IsMissing(aFiles) Then
        sTmp = ArrayNDtoString(aFiles, bUUEncode:=True)
        'sTmp = AsciiReplace(sTmp, 10, 43, iToCount:=3)
        Call AppendFile(sFileName, "commit_files:" & sTmp & vbCrLf)
    End If
    
    If Not IsMissing(sUsername) Then
        Call AppendFile(sFileName, "username:" & UUEncode(sUsername) & vbCrLf)
    End If

    Call AppendFile(sFileName, "runtime_dir:" & UUEncode(Git_Utils.sRuntimeDir) & vbCrLf)
    
    
End Sub
Public Function GitViewCommits(sRepoName As String) As String()
Dim sExecPath As String
Dim sRuntimePath As String
Dim aResults() As String
Dim iNumRows As Integer, iNumCols As Integer
Dim aRows() As String, aCols() As String


    ReDim aResults(0 To 100, 0 To 3)
    CreateGitArgsFile sRepoName

    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "history", sFileName, sRuntimePath))
    Results = ShellRun(aArgs)
    
    iNumRows = UBound(Split(Results, DOUBLE_DOLLAR))
    aRows = Split(Results, DOUBLE_DOLLAR)
    For i = 0 To iNumRows
    
        iNumCols = UBound(Split(aRows(i), HAT))
        aCols = Split(aRows(i), HAT)
        For j = 0 To iNumCols
            aResults(i, j) = CStr(StrConv(DecodeBase64(aCols(j)), vbUnicode))
        Next j
    Next i
    
    GitViewCommits = ReDim2DArray(aResults, iNumRows + 1, iNumCols + 1)
    
End Function

Public Function GitCommitFiles(aFiles As Variant, sRepoName As String, sGitRootPath As String, sMessage As String)
Dim sExecPath As String
Dim sRuntimePath As String

    CreateGitArgsFile sRepoName, sGitRootPath, sMessage:=sMessage, aFiles:=aFiles

    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "commit", sFileName, sRuntimePath))
    ShellRun (aArgs)
End Function

Public Function GitCreateRepo(sRepoName As String, sUsername As String, sGitRootPath As String)
Dim sRuntimePath As String
Dim sExecPath As String

    CreateGitArgsFile sRepoName, sGitRootPath, sUsername:=sUsername
    
    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "create", Git_Utils.sFileName, Git_Utils.sRuntimeDir))
    ShellRun (aArgs)
End Function

Public Function GitDeleteRepo(sRepoName As String, sUsername As String)
Dim sRuntimePath As String
Dim sExecPath As String

    CreateGitArgsFile sRepoName, sUsername:=sUsername
    
    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "delete", Git_Utils.sFileName, Git_Utils.sRuntimeDir))
    ShellRun (aArgs)
End Function

