Attribute VB_Name = "File_Utils_EPrc"
Option Explicit

Public Function Version__DummyCreateFile(dArgs As Dictionary) As Object
' Original version is this Public Function CreateFile(sPath As String) As Object
Dim sFileName As String, sFilePath As String
Dim objFSO As Object
Dim oFile As Object

setup:
    On Error GoTo err
    
main:
    sFileName = dArgs.Item("sFileName")
    sFilePath = dArgs.Item("sFilePath")
         
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set oFile = objFSO.CreateTextFile(sFilePath & "\" & sFileName)
    
cleanup:
    dArgs.Add "result", oFile
    Set oFile = Nothing
    Set objFSO = Nothing
    Exit Function
    
err:
    dArgs.Add "result", -1
    dArgs.Add "error_code", err.Number
    dArgs.Add "error_desc", err.Description
    Exit Function
    

End Function

Public Function DummyCreateFile(dArgs As Dictionary) As Object
' Original version is this Public Function CreateFile(sPath As String) As Object
Dim sFileName As String, sFilePath As String
Dim objFSO As Object
Dim oFile As Object

setup:
    On Error GoTo err
    
main:
    sFileName = dArgs.Item("sFileName")
    sFilePath = dArgs.Item("sFilePath")
         
    Set objFSO = CreateObject("Scripting.FileSystemObject")
    Set oFile = objFSO.CreateTextFile(sFilePath & "\" & sFileName)

cleanup:
    dArgs.Add "result", oFile
    Set oFile = Nothing
    Set objFSO = Nothing
    Exit Function
    
err:
    dArgs.Add "result", -1
    dArgs.Add "error_code", err.Number
    dArgs.Add "error_desc", err.Description
    Exit Function
    
End Function


