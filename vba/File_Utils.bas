Attribute VB_Name = "File_Utils"
Const C_MODULE_NAME = "File_Utils"
Public Function DirExists(sPathCWD As String, sDirName As String) As Boolean
Dim objFSO As Object
Dim oFile As Object

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    If objFSO.FolderExists(sPath) Then
        DirExists = True
        Exit Function
    End If
    
    DirExists = False
End Function
Public Function GetFileFromPath(sPath As String) As String
Dim fso As New FileSystemObject
Dim fileName As String
    GetFileFromPath = fso.GetFileName(sPath)
End Function

Public Sub FileMove(sFileName As String, sSourcePath As String, sTargetPath As String)
Dim objFSO As Object
Dim sFuncName As String
    sFuncName = "FileMove"
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    On Error GoTo err
    objFSO.MoveFile sSourcePath & sFileName, sTargetPath & sFileName
    On Error GoTo 0
    FuncLogIt sFuncName, "Moved [" & sFileName & "] from  [" & sSourcePath & "] to [" & sTargetPath & "]", C_MODULE_NAME, LogMsgType.FAILURE
    Exit Sub
err:
    FuncLogIt sFuncName, "Failed to move [" & sFileName & "] from  [" & sSourcePath & "] to [" & sTargetPath & "] with err [" & err.Description & "]", C_MODULE_NAME, LogMsgType.FAILURE

End Sub
Public Function GetFolderFiles(sPath As String, Optional bDateSorted As Boolean = False) As String()
Dim vFileNames() As String
Dim i As Integer
Dim objFSO As Object
    ReDim vFileNames(0 To 10000)
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    File = Dir(sPath)
    While (File <> "")
        vFileNames(i) = File
        i = i + 1
        File = Dir
    Wend
    ReDim Preserve vFileNames(0 To i - 1)
    GetFolderFiles = vFileNames
End Function
Public Function CreateDir(sPath As String) As Object
Dim objFSO As Object
Dim oDir As Object
Dim sFuncName As String

    sFuncName = "CreateDir"
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    On Error GoTo err
    Set oDir = objFSO.CreateFolder(sPath)
    On Error GoTo 0
    FuncLogIt sFuncName, "Created Dir [" & sPath & "]", C_MODULE_NAME, LogMsgType.OK
    Set CreateDir = oDir
    Exit Function
err:
    FuncLogIt sFuncName, "Failed to create Dir [" & sPath & "] with err [" & err.Description & "]", C_MODULE_NAME, LogMsgType.FAILURE
    
End Function
Public Sub RemoveDir(sPath As String)
Dim objFSO As Object
Dim oDir As Object
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    objFSO.DeleteFolder (sPath)
End Sub
Public Function ReadFile(sPath As String) As String
Dim iLineNum As Integer

    Set oFile = OpenFile(sPath, 1)
    iLineNum = 1
    Do While oFile.AtEndOfStream = False
        If iLineNum = 1 Then
            ReadFile = oFile.ReadLine
        Else
            ReadFile = ReadFile & vbLf & oFile.ReadLine
        End If
        iLineNum = iLineNum + 1
    Loop
End Function
Public Function ReadFile2Array(sPath As String, _
                                Optional sFieldDelim As String = "^") As String()
' Assumes rows are deliminated by newlines
Dim iCol As Integer
Dim iRow As Integer
Dim aTmpRow() As String, aTmp() As String

    ReDim aTmp(0 To 10000, 0 To 100)

    Set oFile = OpenFile(sPath, 1)
    iRow = 0
    Do While oFile.AtEndOfStream = False
        aTmpRow = Split(oFile.ReadLine, sFieldDelim)
        For iCol = 0 To UBound(aTmpRow)
            aTmp(iRow, iCol) = aTmpRow(iCol)
        Next iCol

        iRow = iRow + 1
    Loop
    
    aTmp = ReDim2DArray(aTmp, iRow, iCol)
    
    ReadFile2Array = aTmp
End Function
Public Function FileExists(sPath As String) As Boolean
    If Dir(sPath) <> "" Then
        FileExists = True
    Else
        FileExists = False
    End If
End Function
Public Function OpenFile(sPath As String, iRWFlag As Integer) As Object
Dim objFSO As Object
Dim oFile As Object

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set oFile = objFSO.OpenTextFile(sPath, iRWFlag)
    
    Set OpenFile = oFile
End Function
Public Sub AppendFile(sPath As String, sText As String)
Dim oFile As Object
    Set oFile = OpenFile(sPath, 8)
    oFile.Write (sText)
    Set oFile = Nothing
End Sub
Public Function CreateFile(sPath As String) As Object
Dim objFSO As Object
Dim oFile As Object

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set oFile = objFSO.CreateTextFile(sPath)
    
    Set CreateFile = oFile
    
    Set oFile = Nothing
    Set objFSO = Nothing
End Function

Public Sub TouchFile(sPath As String)
' iRWFlag = 1 for reading and 2 for writing
Dim objFSO As Object
Dim oFile As Object

    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set oFile = objFSO.CreateTextFile(sPath)
    oFile.Close
    
    Set oFile = Nothing
    Set objFSO = Nothing
End Sub

Public Function DeleteFile(sPath As String)
Dim objFSO As Object
Dim oFile As Object
Dim sFuncName As String

    sFuncName = "DeleteFile"
    
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    On Error GoTo err
    objFSO.DeleteFile sPath
    On Error GoTo 0
    FuncLogIt sFuncName, "Deleted [" & sPath & "]", C_MODULE_NAME, LogMsgType.FAILURE
    Exit Function
    
err:
    FuncLogIt sFuncName, "Failed to delete [" & sPath & "] with err [" & err.Description & "]", C_MODULE_NAME, LogMsgType.FAILURE

End Function

Public Function WriteFile(sPath As String, sText As String)
Dim oFile As Object
    Set oFile = OpenFile(sPath, 2)
    oFile.Write (sText)
    Set oFile = Nothing
End Function

Public Function FilesAreSame(ByVal fFirst As String, ByVal fSecond As String) As Boolean
Dim lLen1 As Long, lLen2 As Long
Dim iFileNum1 As Integer
Dim iFileNum2 As Integer
Dim bytArr1() As Byte, bytArr2() As Byte
Dim lCtr As Long, lStart As Long
Dim bAns As Boolean
Dim sFuncName As String

    If Dir(fFirst) = "" Or Dir(fSecond) = "" Then
        FuncLogIt sFuncName, "Cannot find files find file [" & CStr(File1) & "]  [" & CStr(File2) & "]", C_MODULE_NAME, LogMsgType.OK
        Exit Function
    End If
        
    lLen1 = FileLen(fFirst)
    lLen2 = FileLen(fSecond)

    If lLen1 <> lLen2 Then
        FilesAreSame = False
        FuncLogIt sFuncName, "Files are not same length len1 [" & CStr(lLen1) & "] != [" & CStr(lLen2) & "]", C_MODULE_NAME, LogMsgType.OK
        Exit Function
    Else
        iFileNum1 = FreeFile
        Open fFirst For Binary Access Read As #iFileNum1
        iFileNum2 = FreeFile
        Open fSecond For Binary Access Read As #iFileNum2

        'put contents of both into byte Array
        bytArr1() = InputB(LOF(iFileNum1), #iFileNum1)
        bytArr2() = InputB(LOF(iFileNum2), #iFileNum2)
        lLen1 = UBound(bytArr1)
        lStart = LBound(bytArr1)
    
        bAns = True
        For lCtr = lStart To lLen1
            If bytArr1(lCtr) <> bytArr2(lCtr) Then
                bAns = False
                FuncLogIt sFuncName, "Bytes are not the same at char [" & CStr(lCtr) & "] [" & CStr(bytArr1(lCtr)) & "] != [" & CStr(bytArr2(lCtr)) & "]", C_MODULE_NAME, LogMsgType.OK
                Exit For
            End If
            
        Next
        FilesAreSame = bAns
       
    End If
 
    If iFileNum1 > 0 Then Close #iFileNum1
    If iFileNum2 > 0 Then Close #iFileNum2
    
End Function

