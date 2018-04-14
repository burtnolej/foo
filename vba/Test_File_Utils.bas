Attribute VB_Name = "Test_File_Utils"
Option Explicit
Const CsModuleName = "Test_File_Utils"


Function TestInitFileArray() As TestResult
Dim sFilePath As String
Dim vArray() As String, vResultArray() As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err
    sFilePath = Environ("MYHOME") & "\\foo.txt"
    
main:
    InitFileArray sFilePath, 30
    vResultArray = ReadFile2Array(sFilePath, bSingleCol:=True)

    If vResultArray(15) <> " " Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestInitFileArray = eTestResult
    Call DeleteFile(sFilePath)
End Function


Function TestWriteArray2File() As TestResult
Dim sFilePath As String
Dim vArray() As String, vResultArray() As String
Dim i As Integer
Dim oFile As Object
Dim eTestResult As TestResult

setup:
    On Error GoTo err
    sFilePath = Environ("MYHOME") & "\\foo.txt"
    Set oFile = CreateFile(sFilePath)
    ReDim vArray(0 To 29)
    
    oFile.Close
    For i = 0 To 29
        vArray(i) = SPACE
    Next i
    
    vArray(15) = "foobar"
    
    WriteArray2File vArray, sFilePath
    vResultArray = ReadFile2Array(sFilePath, bSingleCol:=True)
    
    If vResultArray(15) <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestWriteArray2File = eTestResult
    Call DeleteFile(sFilePath)
End Function
Function TestReadFile2Array() As TestResult
Dim sFuncName As String, sText As String, sFilePath As String
Dim oFile As Object
Dim aTmp() As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "ReadFile2Array"
    sText = "valA^valB^valC" & vbCrLf & "valA1^valB2^valC2" & vbCrLf & "valA3^valB3^valC3"
    sFilePath = Environ("MYHOME") & "\tmp.txt"
    Set oFile = CreateFile(sFilePath)
    Set oFile = Nothing
    Call WriteFile(sFilePath, sText)
    
main:
    aTmp = ReadFile2Array(sFilePath)
    If UBound(aTmp, 2) <> 2 Then
        eTestResult = TestResult.Failure
    ElseIf UBound(aTmp, 1) <> 2 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestReadFile2Array = eTestResult
    Call DeleteFile(sFilePath)
    
End Function

Function Test_FilesAreSame() As TestResult
Dim sFuncName As String
Dim sPath As String
Dim eTestResult As TestResult
Dim sFile1Name As String, sFile2Name As String, sFile3Name As String

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "FilesAreSame"
    sPath = Environ("MYHOME") & "\"
    
    sFile1Name = sPath & "file1"
    CreateFile sFile1Name
    WriteFile sFile1Name, "foobar"
   
    sFile2Name = sPath & "file2"
    CreateFile sFile2Name
    WriteFile sFile2Name, "foobar"
    
    sFile3Name = sPath & "file3"
    CreateFile sFile3Name
    WriteFile sFile3Name, "fuobar"
    
main:

    If FilesAreSame(sFile1Name, sFile2Name) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If FilesAreSame(sFile1Name, sFile3Name) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FilesAreSame = eTestResult
    Call DeleteFile(sFile1Name)
    Call DeleteFile(sFile2Name)
    Call DeleteFile(sFile3Name)
End Function
Function Test_GetFolderFiles() As TestResult
Dim sFuncName As String
Dim sPath As String
Dim eTestResult As TestResult
Dim sFile1Name As String, sFile2Name As String, sFile3Name As String
Dim vFiles() As String
Dim vExtensions() As String

setup:
    'On Error GoTo err:
    vExtensions = InitStringArray(Array("jpg", "png"))
    sFuncName = CsModuleName & "." & "GetFolderFiles"
    sPath = Environ("MYHOME") & "\icon"
    CreateDir sPath
    
    sFile1Name = sPath & "\file1.jpg"
    CreateFile sFile1Name
   
    sFile2Name = sPath & "\file2.png"
    CreateFile sFile2Name
    
    sFile3Name = sPath & "\file3.txt"
    CreateFile sFile3Name
    
main:

    vFiles = GetFolderFiles(sPath & "\")
    If UBound(vFiles) <> 2 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    vFiles = GetFolderFiles(sPath & "\", vExtensions:=vExtensions)
    If UBound(vFiles) <> 1 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetFolderFiles = eTestResult
    Call DeleteFile(sFile1Name)
    Call DeleteFile(sFile2Name)
    Call DeleteFile(sFile3Name)
    
    RemoveDir sPath
    
End Function

