Attribute VB_Name = "Test_File_Utils"
Option Explicit

Const CsModuleName = "Test_File_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    
    Test_FilesAreSame
    TestReadFile2Array
    
    'GetLogFile
End Sub
Sub TestReadFile2Array()
Dim sFuncName As String, sText As String, sFilePath As String
Dim oFile As Object
Dim aTmp() As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "ReadFile2Array"
    sText = "valA^valB^valC" & vbCrLf & "valA1^valB2^valC2" & vbCrLf & "valA3^valB3^valC3"
    sFilePath = "C:\Users\burtnolej\tmp.txt"
    Set oFile = CreateFile(sFilePath)
    Set oFile = Nothing
    Call WriteFile(sFilePath, sText)
    
main:
    aTmp = ReadFile2Array(sFilePath)
    If UBound(aTmp, 2) <> 2 Then
        GoTo fail
    ElseIf UBound(aTmp, 1) <> 2 Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteFile(sFilePath)
    Exit Sub
    
End Sub

Sub Test_FilesAreSame()
Dim sFuncName As String
Dim sPath As String
Dim bTestPassed As Boolean
Dim sFile1Name As String, sFile2Name As String, sFile3Name As String

setup:
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
        GoTo fail
    End If
    
    If FilesAreSame(sFile1Name, sFile3Name) = True Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call DeleteFile(sFile1Name)
    Call DeleteFile(sFile2Name)
    Call DeleteFile(sFile3Name)
    Call TestLogIt(sFuncName, bTestPassed)
End Sub


