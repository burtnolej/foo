Attribute VB_Name = "Quad_Utils"
Public Const sExecPath = "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\app\\quad\\utils\\excel\\"
Public Const sRuntimeDir = "C:\\Users\\burtnolej\\Documents\\runtime\\"
Public Const sFileName = "C:\\Users\\burtnolej\\Development\\uupyshell.args.txt"

Public Sub CreateQuadArgsFile(sDatabaseName As String, _
        sSpName As String, _
        Optional dSpArgs As Dictionary, _
        Optional sFileName As String = "C:\Users\burtnolej\Development\uupyshell.args.txt", _
        Optional sRuntimeDir As String = "C:\Users\burtnolej\Documents\runtime", _
        Optional sResultFileName As String)

Dim PYTHONPATH As String, xSpArgs As String, sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFileName)
    On Error GoTo 0
    Call TouchFile(sFileName)
    
    
    Call AppendFile(sFileName, "database_name:" & UUEncode(sDatabaseName) & vbCrLf)
    Call AppendFile(sFileName, "sp_name:" & UUEncode(sSpName) & vbCrLf)

    If IsSet(dSpArgs) = True Then
        xSpArgs = CreateXMLDocfromDict(dSpArgs).xml
        Call AppendFile(sFileName, "sp_args:" & UUEncode(xSpArgs) & vbCrLf)
    End If
    
    Call AppendFile(sFileName, "runtime_dir:" & UUEncode(Quad_Utils.sRuntimeDir) & vbCrLf)
    
    If sResultFileName <> "" Then
        Call AppendFile(sFileName, "result_file:" & UUEncode(sResultFileName) & vbCrLf)
    End If
    
End Sub

Public Function GetQuadStudentSchedule(sDatabaseName As String, sSpName As String, _
            Optional dSpArgs As Dictionary, Optional sResultFileName As String) As String
Dim sExecPath As String
Dim sRuntimePath As String

    CreateQuadArgsFile sDatabaseName, sSpName, dSpArgs:=dSpArgs, sResultFileName:=sResultFileName

    aArgs = InitStringArray(Array("python", Quad_Utils.sExecPath & "excel_data_utils.py", _
                    "--input_file", sFileName))
                    
    result = ShellRun(aArgs)
    
    If sResultFileName <> "" Then
        GetQuadStudentSchedule = sResultFileName
    Else
        GetQuadStudentSchedule = result
    End If
End Function



