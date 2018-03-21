Attribute VB_Name = "Test_File_Utils"
Option Explicit
Const CsModuleName = "Test_File_Utils"

Function TestReadFile2Array() As TestResult
Dim sFuncName As String, sText As String, sFilePath As String
Dim oFile As Object
Dim aTmp() As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "ReadFile2Array"
    sText = "valA^valB^valC" & vbCrLf & "valA1^valB2^valC2" & vbCrLf & "valA3^valB3^valC3"
    sFilePath = "C:\Users\burtnolej\tmp.txt"
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
    sPath = "C:\Users\burtnolej\"
    
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
    Test_NumColumns = eTestResult
    Call DeleteFile(sFile1Name)
    Call DeleteFile(sFile2Name)
    Call DeleteFile(sFile3Name)
End Function


