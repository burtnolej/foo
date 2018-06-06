Attribute VB_Name = "Quad_Data_DB_Utils"
Option Explicit

Const C_MODULE_NAME = "Quad_Data_DB_Utils"

' GetStudentNameFromID

' CrossRefQuadData
' UpdateQuadDataInDB
' InsertQuadDataToDB
' GetQuadDataFromDB
' CreateQuadArgsFile

Public Function GetStudentNameFromID(iPersonID As Integer) As String
Dim clsAppRuntime As New App_Runtime

    clsAppRuntime.InitProperties bInitializeCache:=False
    GetStudentNameFromID = CrossRefQuadData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, _
            "idStudent", iPersonID, "sStudentLastNm")
End Function

Public Function CrossRefQuadData(clsAppRuntime As App_Runtime, _
                                 eQuadDataType As QuadDataType, _
                                 eQuadSubDataType As QuadSubDataType, _
                                 sLookUpByColName As String, _
                                 sLookUpByValue As Variant, _
                                 sLookUpColName As String)
Dim wsCache As Worksheet
Dim sLookUpByRangeName As String, sLookUpRangeName As String
Dim vLookUpByValues() As String, vLookUpValues() As String

    Set wsCache = GetPersonData(clsAppRuntime, eQuadDataType, eQuadSubDataType, QuadScope.all, _
                                    bInTable:=True)
            
    sLookUpByRangeName = GetDBColumnRange(wsCache.Name, sLookUpByColName)
    sLookUpRangeName = GetDBColumnRange(wsCache.Name, sLookUpColName)
    
    vLookUpByValues = ListFromRange(wsCache, sLookUpByRangeName)
    vLookUpValues = ListFromRange(wsCache, sLookUpRangeName)

    CrossRefQuadData = vLookUpValues(IndexArray(vLookUpByValues, CStr(sLookUpByValue)))

    
End Function

Public Sub UpdateQuadDataInDB(clsAppRuntime As App_Runtime, sSpName As String, vRow() As Variant, _
                    Optional bHeaderFlag As Boolean = False)
Dim aArgs() As String

    CreateQuadArgsFile clsAppRuntime, sSpName, vRow:=vRow, bHeaderFlag:=bHeaderFlag
    aArgs = InitStringArray(Array("python", clsAppRuntime.ExecPath & "excel_data_utils.py", "--input_file", clsAppRuntime.FileName))
                    
    ShellRun aArgs
  
End Sub

Public Sub InsertQuadDataToDB(clsAppRuntime As App_Runtime, sSpName As String, _
                              vRows As Variant, vColumns As Variant, _
                    Optional bHeaderFlag As Boolean = False)

Dim aArgs() As String
    CreateQuadArgsFile clsAppRuntime, sSpName, vRows:=vRows, vColumns:=vColumns, bHeaderFlag:=bHeaderFlag
    aArgs = InitStringArray(Array("python", clsAppRuntime.ExecPath & "excel_data_utils.py", "--input_file", clsAppRuntime.FileName))
                    
    ShellRun aArgs
  
End Sub
    
Public Sub GetQuadDataFromDB(clsAppRuntime As App_Runtime, sSpName As String, _
                        Optional dSpArgs As Dictionary, _
                        Optional bHeaderFlag As Boolean = False)
' get the raw data from a backsheet
Dim sExecPath As String, sRuntimePath As String, sResult As String
Dim aArgs() As String

    CreateQuadArgsFile clsAppRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=bHeaderFlag
    aArgs = InitStringArray(Array("python", clsAppRuntime.ExecPath & "excel_data_utils.py", "--input_file", clsAppRuntime.FileName))
                    
    ShellRun aArgs
    
End Sub


Public Sub CreateQuadArgsFile(clsAppRuntime As App_Runtime, sSpName As String, _
        Optional dSpArgs As Dictionary, _
        Optional vRows As Variant, _
        Optional vColumns As Variant, _
        Optional vColumnDefns As Variant, _
        Optional vRow As Variant, _
        Optional bDeleteFlag As Boolean = False, _
        Optional bHeaderFlag As Boolean = False, _
        Optional bDecodeFlag As Boolean = False)
        
Dim PYTHONPATH As String, xSpArgs As String, sTmp As String

    PYTHONPATH = LCase(Environ("PYTHONPATH"))

    On Error Resume Next 'in case running for first time and nothing to delete
    Call DeleteFile(clsAppRuntime.FileName)
    On Error GoTo 0
    Call TouchFile(clsAppRuntime.FileName)
    
    Call AppendFile(clsAppRuntime.FileName, "database_name:" & UUEncode(clsAppRuntime.DatabasePath) & vbCrLf)
    Call AppendFile(clsAppRuntime.FileName, "sp_name:" & UUEncode(sSpName) & vbCrLf)
    Call AppendFile(clsAppRuntime.FileName, "delete_flag:" & UUEncode(CStr(bDeleteFlag)) & vbCrLf)
    
    If bHeaderFlag = True Then
        Call AppendFile(clsAppRuntime.FileName, "header_flag:" & UUEncode("True") & vbCrLf)
    End If

    If IsSet(dSpArgs) = True Then
        xSpArgs = CreateXMLDocfromDict(dSpArgs).xml
        Call AppendFile(clsAppRuntime.FileName, "sp_args:" & UUEncode(xSpArgs) & vbCrLf)
    End If
    
    Call AppendFile(clsAppRuntime.FileName, "runtime_dir:" & UUEncode(clsAppRuntime.RuntimeDir) & vbCrLf)
    
    If clsAppRuntime.ResultFileName <> "" Then
        Call AppendFile(clsAppRuntime.FileName, "result_file:" & UUEncode(clsAppRuntime.ResultFileName) & vbCrLf)
    End If

    If IsSet(vColumnDefns) = True Then
        Call AppendFile(clsAppRuntime.FileName, "column_defns:" & ArrayNDtoString(vColumnDefns, bUUEncode:=True) & vbCrLf)
    End If
    
    If IsSet(vColumns) = True Then
        Call AppendFile(clsAppRuntime.FileName, "columns:" & ArrayNDtoString(vColumns, bUUEncode:=True) & vbCrLf)
    End If
    
    If IsSet(vRow) = True Then
        Call AppendFile(clsAppRuntime.FileName, "row:" & ArrayNDtoString(vRow, bUUEncode:=True) & vbCrLf)
    End If
    
    If IsSet(vRows) = True Then
        
        sTmp = ArrayNDtoString(vRows, bUUEncode:=True)
        
        If bDecodeFlag = True Then
            sTmp = AsciiReplace(sTmp, 10, 43, iToCount:=3)
        Else
            sTmp = Replace(sTmp, "'", "")
        End If

        Call AppendFile(clsAppRuntime.FileName, "rows:" & sTmp & vbCrLf)
    
    End If
    
End Sub



