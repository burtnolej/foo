Attribute VB_Name = "Quad_Utils"
Public Const sExecPath = "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\app\\quad\\utils\\excel\\"
Public Const sRuntimeDir = "C:\\Users\\burtnolej\\Documents\\runtime\\"
Public Const sFilename = "C:\\Users\\burtnolej\\Development\\uupyshell.args.txt"

Public Sub CreateQuadArgsFile(sDatabaseName As String, _
        sSpName As String, _
        Optional dSpArgs As Dictionary, _
        Optional sFilename As String = "C:\Users\burtnolej\Development\uupyshell.args.txt", _
        Optional sRuntimeDir As String = "C:\Users\burtnolej\Documents\runtime")

Dim PYTHONPATH As String, xSpArgs As String, sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(sFilename)
    On Error GoTo 0
    Call TouchFile(sFilename)
    
    

    Call AppendFile(sFilename, "database_name:" & UUEncode(sDatabaseName) & vbCrLf)
    Call AppendFile(sFilename, "sp_name:" & UUEncode(sSpName) & vbCrLf)

    If IsSet(dSpArgs) = True Then
        xSpArgs = CreateXMLDocfromDict(dSpArgs).xml
        Call AppendFile(sFilename, "sp_args:" & UUEncode(xSpArgs) & vbCrLf)
    End If
    
    Call AppendFile(sFilename, "runtime_dir:" & UUEncode(Quad_Utils.sRuntimeDir) & vbCrLf)
        
End Sub

Public Function GetQuadStudentSchedule(sDatabaseName As String, sSpName As String, _
            Optional dSpArgs As Dictionary) As String
            

Dim sExecPath As String
Dim sRuntimePath As String

    CreateQuadArgsFile sDatabaseName, sSpName, dSpArgs:=dSpArgs

    'aArgs = InitStringArray(Array("python", Quad_Utils.sExecPath & "excel_data_utils.py", _
    '        "input_file", sFilename))
            
    aArgs = InitStringArray(Array("python", Quad_Utils.sExecPath & "excel_data_utils.py", "--input_file", sFilename))
    result = ShellRun(aArgs)
    
    GetQuadStudentSchedule = result
    
End Function



