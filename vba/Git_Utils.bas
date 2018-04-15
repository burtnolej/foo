Attribute VB_Name = "Git_Utils"
'Public Const sExecPath = "C:\Users\burtn\Documents\GitHub\quadviewer\utils\excel\"
'Public Const sRuntimeDir = "C:\Users\burtn\Documents\runtime\"
'Public Const sFilename = "C:\Users\burtn\Documents\uupyshell.args.txt"

Public sTokenPath As String
Public Function GetGitToken() As String
    sTokenPath = Environ("MYHOME") & "\.gittoken"
    GetGitToken = ReadFile(sTokenPath)
End Function
Public Sub CreateGitArgsFile(sRepoName As String, _
        sGitRootPath As String, _
        Optional aFiles As Variant, _
        Optional sMessage As String, _
        Optional sUsername As String, _
        Optional sFilename As String, _
        Optional sRuntimeDir As String)

Dim PYTHONPATH As String
Dim sTmp As String

    sRuntimeDir = GetHomePath & "\runtime\"
    
    ' because we cant have variable in default values for arguments
    If sFilename = "" Then
        sFilename = Environ("MYHOME") & "\uupyshell.args.txt"
    End If
    
    If sRuntimeDir = "" Then
        sRuntimeDir = Environ("MYHOME") & "\runtime"
    End If
    
    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFilename)
    On Error GoTo 0
    Call TouchFile(sFilename)
    
    Call AppendFile(sFilename, "token:" & UUEncode(GetGitToken) & vbCrLf)
    Call AppendFile(sFilename, "reponame:" & UUEncode(sRepoName) & vbCrLf)
    Call AppendFile(sFilename, "gitrootpath:" & UUEncode(sGitRootPath) & vbCrLf)
     
    If Not IsEmpty(aFiles) And Not IsMissing(sMessage) Then
        Call AppendFile(sFilename, "commit_message:" & UUEncode(sMessage) & vbCrLf)
    End If
    
    If Not IsEmpty(aFiles) And Not IsMissing(aFiles) Then
        sTmp = ArrayNDtoString(aFiles, bUUEncode:=True)
        'sTmp = AsciiReplace(sTmp, 10, 43, iToCount:=3)
        Call AppendFile(sFilename, "commit_files:" & sTmp & vbCrLf)
    End If
    
    If Not IsMissing(sUsername) Then
        Call AppendFile(sFilename, "username:" & UUEncode(sUsername) & vbCrLf)
    End If

    Call AppendFile(sFilename, "runtime_dir:" & UUEncode(sRuntimeDir) & vbCrLf)
    
    
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
            "history", sFilename, sRuntimePath))
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

    sExecPath = GetHomePath & "\GitHub\quadviewer\utils\excel\"
    'sRuntimeDir = "C:\Users\burtn\Documents\runtime\"
    sFilename = GetHomePath & "\uupyshell.args.txt"

    CreateGitArgsFile sRepoName, sGitRootPath, sMessage:=sMessage, aFiles:=aFiles

    aArgs = InitStringArray(Array("python", sExecPath & "excel_git_utils.py", _
            "commit", sFilename, sRuntimePath))
    ShellRun (aArgs)
End Function

Public Function GitCreateRepo(sRepoName As String, sUsername As String, sGitRootPath As String)
Dim sRuntimePath As String
Dim sExecPath As String

    CreateGitArgsFile sRepoName, sGitRootPath, sUsername:=sUsername
    
    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "create", Git_Utils.sFilename, Git_Utils.sRuntimeDir))
    ShellRun (aArgs)
End Function

Public Function GitDeleteRepo(sRepoName As String, sUsername As String)
Dim sRuntimePath As String
Dim sExecPath As String

    CreateGitArgsFile sRepoName, sUsername:=sUsername
    
    aArgs = InitStringArray(Array("python", Git_Utils.sExecPath & "excel_git_utils.py", _
            "delete", Git_Utils.sFilename, Git_Utils.sRuntimeDir))
    ShellRun (aArgs)
End Function

