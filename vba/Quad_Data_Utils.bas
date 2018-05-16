Attribute VB_Name = "Quad_Data_Utils"
Option Explicit

Public Function GetStudentNameFromID(iPersonID As Integer) As String
Dim clsAppRuntime As New App_Runtime

    clsAppRuntime.InitProperties bInitializeCache:=False
    GetStudentNameFromID = CrossRefQuadData(clsAppRuntime, QuadDataType.person, QuadSubDataType.Student, _
            "idStudent", iPersonID, "sStudentLastNm")
End Function

Public Function GetTableRecordID(vValue As Variant, sLookUpFieldName As String) As String
Dim clsAppRuntime As New App_Runtime

    clsAppRuntime.InitProperties bInitializeCache:=False
    'GetTableRecordID = CrossRefQuadData(clsAppRuntime, QuadDataType.person, QuadSubDataType.Student, _
    '    sLookUpFieldName, vValue, "ID")
    GetTableRecordID = CrossRefQuadData(clsAppRuntime, QuadDataType.person, QuadSubDataType.Student, _
        sLookUpFieldName, vValue, "RefNo")
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
            
    sLookUpByRangeName = GetDBColumnRange(wsCache.name, sLookUpByColName)
    sLookUpRangeName = GetDBColumnRange(wsCache.name, sLookUpColName)
    
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
                              vRows() As Variant, vColumns() As Variant, _
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

