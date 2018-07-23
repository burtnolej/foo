Attribute VB_Name = "Quad_Data_DB_Utils"
Option Explicit

Const C_MODULE_NAME = "Quad_Data_DB_Utils"
Public Function GetStudentIdListFromNameList(sStudentNmList As String) As String
Dim clsAppRuntime As New App_Runtime
Dim vStudentNms() As String, vNameParts() As String
Dim vStudentIds() As String
Dim iStudentCount As Integer
Dim sStudentNm As Variant
Dim sFirstNm As String, sLastNm As String

    clsAppRuntime.InitProperties bInitializeCache:=False

    ReDim vStudentIds(0 To 30)
    vStudentNms = Split(sStudentNmList, UNDERSCORE)
    For Each sStudentNm In vStudentNms
        If sStudentNm <> "" Then
            vNameParts = Split(sStudentNm, Space)
            
            vStudentIds(iStudentCount) = GetStudentIDFromFullName(sStudentNm)
            'vStudentIds(iStudentCount) = GetStudentIDFromName(vNameParts(0), vNameParts(1))
            iStudentCount = iStudentCount + 1
        End If
    Next sStudentNm

    If iStudentCount = 0 Then
        GetStudentIdListFromNameList = ""
    Else
    ReDim Preserve vStudentIds(0 To iStudentCount - 1)
        GetStudentIdListFromNameList = Join(vStudentIds, UNDERSCORE)
    End If

End Function
Public Function GetFacultyIdListFromNameList(sFacultyNmList As String) As String
Dim clsAppRuntime As New App_Runtime
Dim vFacultyNms() As String, vNameParts() As String
Dim vFacultyIds() As String
Dim iFacultyCount As Integer
Dim sFacultyNm As Variant
Dim sFirstNm As String, sLastNm As String

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    ReDim vFacultyIds(0 To 10)
    vFacultyNms = Split(sFacultyNmList, UNDERSCORE)
    For Each sFacultyNm In vFacultyNms
        If sFacultyNm <> "" Then
            vNameParts = Split(sFacultyNm, Space)
            'vFacultyIds(iFacultyCount) = GetFacultyIDFromName(vNameParts(0), vNameParts(1))
            vFacultyIds(iFacultyCount) = GetFacultyIDFromFullName(vNameParts(0) & " " & vNameParts(1))
            iFacultyCount = iFacultyCount + 1
        End If
    Next sFacultyNm
    If iFacultyCount = 0 Then
        GetFacultyIdListFromNameList = ""
    Else
        ReDim Preserve vFacultyIds(0 To iFacultyCount - 1)
        GetFacultyIdListFromNameList = Join(vFacultyIds, UNDERSCORE)
    End If

End Function

Public Function GetStudentNameFromID(iPersonID As Integer) As String
Dim clsAppRuntime As New App_Runtime

    clsAppRuntime.InitProperties bInitializeCache:=False
    GetStudentNameFromID = CrossRefQuadData(clsAppRuntime, QuadDataType.person, QuadSubDataType.Student, _
            "idStudent", iPersonID, "sStudentLastNm")
End Function

Public Function GetSubjectIDFromName(sSubjectLongDesc As String) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
            
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.Courses, "eQuadSubDataType", QuadSubDataType.Subject, _
                "sLookUpByColName", "sSubjectLongDesc", "sLookUpByValue", sSubjectLongDesc, "sLookUpColName", "idSubject"
    
    GetSubjectIDFromName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)
End Function



Public Function GetPrepIDFromName(sPrepNm As String) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
            
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.Misc, "eQuadSubDataType", QuadSubDataType.Prep, _
                "sLookUpByColName", "sPrepNm", "sLookUpByValue", sPrepNm, "sLookUpColName", "idPrep"
    
    GetPrepIDFromName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)
End Function


Public Function GetCourseIDFromName(sCourseNm As String) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
            
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.Courses, "eQuadSubDataType", QuadSubDataType.Course, _
                "sLookUpByColName", "sCourseNm", "sLookUpByValue", sCourseNm, "sLookUpColName", "idCourse"
    
    GetCourseIDFromName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)
End Function

Public Function GetFacultyIDFromFullName(sFacultyFullName) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.person, "eQuadSubDataType", QuadSubDataType.Teacher, _
                "sLookUpByColName", "sFacultyFullName", "sLookUpByValue", sFacultyFullName, "sLookUpColName", "idFaculty", "ver_series", clsAppRuntime.Version
                
    GetFacultyIDFromFullName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)

End Function

Public Function GetFacultyIDFromName(sFacultyFirstNm As String, sFacultyLastNm As String) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.person, "eQuadSubDataType", QuadSubDataType.Teacher, _
                "sLookUpByColName", "sFacultyFirstNm", "sLookUpByValue", sFacultyFirstNm, "sLookUpColName", "idFaculty", _
                "sLookUpByColName2", "sFacultyLastNm", "sLookUpByValue2", sFacultyLastNm, "ver_series", clsAppRuntime.Version
                
    GetFacultyIDFromName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)

End Function


Public Function GetStudentIDFromFullName(sStudentFullName) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.person, "eQuadSubDataType", QuadSubDataType.Student, _
                "sLookUpByColName", "sStudentFullName", "sLookUpByValue", sStudentFullName, "sLookUpColName", "idStudent", "ver_series", clsAppRuntime.Version
                
    GetStudentIDFromFullName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)

End Function


Public Function GetStudentIDFromName(sStudentFirstNm As String, sStudentLastNm As String) As String
Dim clsAppRuntime As New App_Runtime
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.person, "eQuadSubDataType", QuadSubDataType.Student, _
                "sLookUpByColName", "sStudentFirstNm", "sLookUpByValue", sStudentFirstNm, "sLookUpColName", "idStudent"
                
    GetStudentIDFromName = Application.Run(C_CROSS_REF_QUAD_DATA, dArgs)

End Function


Public Function GetMaxFieldValue(dArgs As Dictionary) As Integer
Dim wsCache As Worksheet
Dim clsAppRuntime As App_Runtime
Dim eQuadDataType As QuadDataType
Dim eQuadSubDataType As QuadSubDataType
Dim clsExecProc As Exec_Proc
Dim sLookUpByColName As String, sFuncName As String, sLookUpByRangeName As String
Dim lStartTick As Long

unpackargs:

    
    Set clsAppRuntime = dArgs("clsAppRuntime")
    eQuadSubDataType = dArgs("eQuadSubDataType")
    eQuadDataType = dArgs("eQuadDataType")

    sLookUpByColName = dArgs("sLookUpByColName")

    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
setup:
    sFuncName = C_MODULE_NAME & "." & "GetMaxFieldValue"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", eQuadDataType, "eQuadSubDataType", eQuadSubDataType, _
            "eQuadScope", QuadScope.all, "bInTable", True
    
    clsExecProc.ExecProc "GetPersonData", dArgs
    Set wsCache = dArgs.Item("result")
    
    sLookUpByRangeName = GetDBColumnRange(wsCache.Name, sLookUpByColName)
        
    GetMaxFieldValue = GetMaxRangeValue(wsCache, sLookUpByRangeName)
    

cleanup:
    FuncLogIt sFuncName, " [sLookUpByRangeName=" & sLookUpByRangeName & "][GetMaxFieldValue=" & CStr(GetMaxFieldValue) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "] ", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
End Function
Public Function CrossRefQuadData(dArgs As Dictionary)
Dim wsCache As Worksheet
Dim sLookUpByRangeName As String, sLookUpRangeName As String, sLookUpByRangeName2 As String, sFuncName As String, sLookUpByColName As String, sLookUpByValue As Variant, sLookUpColName As String, sLookUpByColName2 As String, sLookUpByValue2 As Variant
Dim vLookUpByValues() As String, vLookUpByValues2() As String, vLookUpValues() As String
Dim lStartTick As Long
Dim clsAppRuntime As App_Runtime
Dim eQuadDataType As QuadDataType
Dim eQuadSubDataType As QuadSubDataType
Dim clsExecProc As Exec_Proc
Dim vIndexes() As Integer
Dim i As Integer, iIndex As Integer

unpackargs:

    
    Set clsAppRuntime = dArgs("clsAppRuntime")
    eQuadSubDataType = dArgs("eQuadSubDataType")
    eQuadDataType = dArgs("eQuadDataType")
    sLookUpByColName = dArgs("sLookUpByColName")
    sLookUpByValue = dArgs("sLookUpByValue")
    sLookUpColName = dArgs("sLookUpColName")
    
    If dArgs.Exists("sLookUpByValue2") Then
        sLookUpByValue2 = dArgs("sLookUpByValue2")
    End If
    
    If dArgs.Exists("sLookUpByColName2") Then
        sLookUpByColName2 = dArgs("sLookUpByColName2")
    End If

    'sLookUpByColName2 = "sFacultyLastNm"
    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
setup:
    sFuncName = C_MODULE_NAME & "." & "CrossRefQuadData"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", eQuadDataType, "eQuadSubDataType", eQuadSubDataType, _
            "eQuadScope", QuadScope.all, "bInTable", True
    
    clsExecProc.ExecProc "GetPersonData", dArgs
    Set wsCache = dArgs.Item("result")
    
    sLookUpByRangeName = GetDBColumnRange(wsCache.Name, sLookUpByColName)
    sLookUpRangeName = GetDBColumnRange(wsCache.Name, sLookUpColName)
    
    vLookUpByValues = ListFromRange(wsCache, sLookUpByRangeName)
    vLookUpValues = ListFromRange(wsCache, sLookUpRangeName)

    CrossRefQuadData = "-1"
    On Error Resume Next
    
    If sLookUpByColName2 <> "" Then
        vIndexes = IndexArrayMulti(vLookUpByValues, CStr(sLookUpByValue))

        If vIndexes(0) <> -1 Then
        
            sLookUpByRangeName2 = GetDBColumnRange(wsCache.Name, sLookUpByColName2)
            vLookUpByValues2 = ListFromRange(wsCache, sLookUpByRangeName2)
            
            For i = 0 To UBound(vIndexes)

                'iIndex = IndexArray(vLookUpByValues2, CStr(sLookUpByValue2))
                
                
                If vLookUpByValues2(vIndexes(i)) = CStr(sLookUpByValue2) Then
                    CrossRefQuadData = vLookUpValues(vIndexes(i))
                    GoTo cleanup
                End If
                    
                
                'If iIndex <> -1 Then
                '    CrossRefQuadData = vLookUpValues(iIndex)
                '    GoTo cleanup
                'End If
            Next i
        End If
        
        AddDict dArgs, "result", False
        Exit Function
        
    Else
        CrossRefQuadData = vLookUpValues(IndexArray(vLookUpByValues, CStr(sLookUpByValue)))
    End If

cleanup:

    'AddDict dArgs, "result", vLookUpValues(IndexArray(vLookUpByValues, CStr(sLookUpByValue))), True
    AddDict dArgs, "result", CrossRefQuadData, True
    
    On Error GoTo 0
    
    FuncLogIt sFuncName, " [sLookUpByColName=" & sLookUpByColName & "] [sLookUpByValue=" & sLookUpByValue & "] [sLookUpColName=" & sLookUpColName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "] ", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    
    
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



