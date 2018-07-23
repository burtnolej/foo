Attribute VB_Name = "App_Loader"
Option Explicit
Const C_MODULE_NAME = "App_Loader"

Enum LoaderErrorMsgType
    BAD_ARGUMENT = 9111
End Enum

Public Function GetLoaderSheetName(sDataType As String, sSubDataType As String)
    GetLoaderSheetName = "Loader" & UNDERSCORE & sDataType & UNDERSCORE & sSubDataType
End Function

Public Sub DataLoader(dArgs As Dictionary)

'<<<
'purpose: load schedule records from a sheet; validate and add ref data where appropriate
'       : lData and lHeader are the names of the ranges where the data can be found
'>>>
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sDefnSheetName As String, sFieldName As String, sWidgetKey As String, sLoaderSheetName As String, sFormName As String, sDataType As String, sSubDataType As String, sMaxFieldName As String
Dim rHeader As Range, rData As Range, rRow As Range, rCell As Range, rResult As Range, rDataType As Range
Dim iRecordsLoaded As Integer, iRow As Integer, iCol As Integer
Dim vData() As Variant, vHeader() As Variant, vDataType() As Variant, vDirtyRows() As Variant
Dim vRows() As String, vColumnNames() As String
Dim lStartTick As Long
Dim vValueToValidate As Variant
Dim bFieldValid As Boolean, bRowValid As Boolean, bValidateFields As Boolean, bIDValue As New Dictionary, bNewOnly As Boolean
Dim wsCacheTable As Worksheet
Dim dRecordValues As Dictionary
Dim eFormType As FormType
Dim wbTmp As Workbook, wbMaster As Workbook, wbLoader As Workbook
Dim clsExecProc As New Exec_Proc

unpackargs:
        
    sDataType = dArgs.Item("sDataType")
    sSubDataType = dArgs.Item("sSubDataType")
    
    If dArgs.Exists("wbMaster") = False Then
        Set wbMaster = ActiveWorkbook
    Else
        Set wbMaster = dArgs.Item("wbMaster")
    End If
    
    If dArgs.Exists("wbLoader") = True Then
        Set wbLoader = dArgs.Item("wbLoader")
    End If
    
    Set wbTmp = dArgs.Item("wbTmp")
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=wbMaster
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    bValidateFields = dArgs.Item("bValidateFields")
    
    If dArgs.Exists("bNewOnly") = False Then
        bNewOnly = False
    Else
        bNewOnly = True
    End If

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Loader"
    sDefnSheetName = "LoaderDefn"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    'On Error GoTo err
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    eFormType = FormType.Add
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))

    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sDefnSheetName
    
    ' FormType is Add because effectively we are functionally doing the saming thing as adding records via Add forms
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sDefnSheetName, FormType.Add, bLoader:=True

main:
    ' Put named ranges in arrays for easier access
    sLoaderSheetName = GetLoaderSheetName(sDataType, sSubDataType)
    Set rData = wbLoader.Sheets(sLoaderSheetName).Range("lData")
    Set rHeader = wbLoader.Sheets(sLoaderSheetName).Range("lHeader")
    Set rDataType = wbLoader.Sheets(sLoaderSheetName).Range("lDataType")
    Set rResult = rData.Offset(, rData.Columns.Count).Resize(, 1)
    vData = rData
    vHeader = rHeader
    vDataType = rDataType
    
    ' for each data row and each column of each row
    For iRow = 1 To UBound(vData)
        bRowValid = True
        Set dRecordValues = New Dictionary ' for adding to the CacheTable
        For iCol = 1 To UBound(vData, 2)
            sFieldName = vHeader(1, iCol)
            vValueToValidate = vData(iRow, iCol)
            Set rCell = rData.Rows(iRow).Columns(iCol) ' corresponding cell of data being processed
            sDataType = CStr(vDataType(iRow, 1)) ' i.e. Schedule
            sSubDataType = CStr(vDataType(iRow, 2)) ' i.e. Student
            
            sWidgetKey = GetWidgetKey(sFormName, sFieldName, WidgetType.Entry) ' i.e eAddLesson_sFacultyFirstNm

            If vValueToValidate = "CALCID" Then
                If bRowValid = True Then
                    If bIDValue.Exists(sFieldName) = False Then
                        If sFieldName = "idLeadTeacher" Then
                            sMaxFieldName = "idFaculty"
                        Else
                            sMaxFieldName = sFieldName
                        End If
                        AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadSubDataType", GetQuadSubDataTypeEnumFromValue(sSubDataType), "eQuadDataType", GetQuadDataTypeEnumFromValue(sDataType), "sLookUpByColName", sMaxFieldName
                        vValueToValidate = Application.Run(C_GET_MAX_FIELD_VALUE, dArgs) + 1
                        bIDValue.Add sFieldName, vValueToValidate
                    Else
                        vValueToValidate = bIDValue.Item(sFieldName) + 1
                        AddDict bIDValue, sFieldName, vValueToValidate
                    End If
                Else
                        vValueToValidate = -1
                        'AddDict bIDValue, sFieldName, vValueToValidate
                End If
                
                bFieldValid = True
                rCell.value = vValueToValidate
            ElseIf vValueToValidate = "LOOKUP" Then
                If sFieldName = "idSubject" Then
                    vValueToValidate = GetSubjectIDFromName(dRecordValues.Item("sSubjectLongDesc"))
                    dRecordValues.Remove "sSubjectLongDesc"
                ElseIf sFieldName = "idPrep" Then
                    vValueToValidate = GetPrepIDFromName(dRecordValues.Item("sPrepNm"))
                    dRecordValues.Remove "sPrepNm"
                ElseIf sFieldName = "idLeadTeacher" Or sFieldName = "idFaculty" Then
                    If dRecordValues.Exists("sFacultyFullName") = True Then
                        vValueToValidate = GetFacultyIDFromFullName(dRecordValues.Item("sFacultyFullName"))
                        dRecordValues.Remove "sFacultyFullName"
                    Else
                        vValueToValidate = GetFacultyIDFromFullName(dRecordValues.Item("sFacultyFirstNm") & " " & dRecordValues.Item("sFacultyLastNm"))
                        'vValueToValidate = GetFacultyIDFromName(dRecordValues.Item("sFacultyFirstNm"), dRecordValues.Item("sFacultyLastNm"))
                        dRecordValues.Remove "sFacultyFirstNm"
                        dRecordValues.Remove "sFacultyLastNm"
                    End If
                ElseIf sFieldName = "idStudent" Then
                    If dRecordValues.Exists("sStudentFullName") = True Then
                        vValueToValidate = GetStudentIDFromFullName(dRecordValues.Item("sStudentFullName"))
                        dRecordValues.Remove "sStudentFullName"
                    Else
                        vValueToValidate = GetStudentIDFromName(dRecordValues.Item("sStudentFirstNm"), dRecordValues.Item("sStudentLastNm"))
                        dRecordValues.Remove "sStudentFirstNm"
                        dRecordValues.Remove "sStudentLastNm"
                    End If
                ElseIf sFieldName = "idCourse" Then
                    vValueToValidate = GetCourseIDFromName(dRecordValues.Item("sCourseNm"))
                    dRecordValues.Remove "sCourseNm"
                ElseIf sFieldName = "lStudentEnroll" Then
                    vValueToValidate = GetStudentIdListFromNameList(dRecordValues.Item("lStudentNmEnroll"))
                    dRecordValues.Remove "lStudentNmEnroll"
                ElseIf sFieldName = "lFacultyEnroll" Then
                    vValueToValidate = GetFacultyIdListFromNameList(dRecordValues.Item("lFacultyNmEnroll"))
                    dRecordValues.Remove "lFacultyNmEnroll"
                End If
                bFieldValid = True
                rCell.value = vValueToValidate
            Else
            
                If bValidateFields = True Then
                    If dDefinitions.Exists(sWidgetKey) = True Then
                        bFieldValid = Validate(clsAppRuntime, clsExecProc, sWidgetKey, vValueToValidate) ' i.e. David
                    Else
                        bFieldValid = True
                    End If
                Else
                    bFieldValid = True
                End If
            End If

            'rCell.value = vValueToValidate
            dRecordValues.Add sFieldName, vValueToValidate
            
            ' update cell color to show status of validation
            If bFieldValid = False Then
                bRowValid = False
                SetBgColorFromString sLoaderSheetName, rCell, C_RGB_INVALID, wbTmp:=wbLoader
            Else
                SetBgColorFromString sLoaderSheetName, rCell, C_RGB_VALID, wbTmp:=wbLoader
            End If
        Next iCol
        
        ' row is valid if none of the fields are invalid
        rResult.Rows(iRow).value = CStr(bRowValid)
        
        ' add to CacheTable
        If bRowValid = True Then
            Set wsCacheTable = GetTable(clsAppRuntime, sDataType, sSubDataType)
            AddTableRecordFromDict wsCacheTable, wsCacheTable.Name, dRecordValues
        End If

    Next iRow
    
    ' write to DB
    vDirtyRows = GetDirtyTableRecords(wsCacheTable.Name, clsAppRuntime.CacheBook, bResetDirtyFlag:=True)
    vColumnNames = GetTableWidgetKeys(wsCacheTable.Name, bFieldNameOnly:=True)
    
    If sDataType = "Schedule" Then
        AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadSubDataType", QuadSubDataType.Student, "vRows", vDirtyRows, "vColumns", vColumnNames, "wbMaster", wbMaster
        clsExecProc.ExecProc "InsertScheduleLessonDataToDB", dArgs
    ElseIf sDataType = "Courses" Then
        'InsertCoursesDataToDB clsAppRuntime, QuadSubDataType.Section, vDirtyRows, vColumnNames
        InsertCoursesDataToDB clsAppRuntime, GetQuadSubDataTypeEnumFromValue(sSubDataType), vDirtyRows, vColumnNames
    Else
        'InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vDirtyRows, vColumnNames
        InsertPersonDataToDB clsAppRuntime, GetQuadSubDataTypeEnumFromValue(sSubDataType), vDirtyRows, vColumnNames
    End If
    
cleanup:
    FuncLogIt sFuncName, "[sLoaderSheetName=" & sLoaderSheetName & "] [Records Loaded=" & CStr(UBound(vDirtyRows) + 1) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    Exit Sub
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Sub


Public Sub OLD_Data____Loader(sDataType As String, sSubDataType As String, Optional wbTmp As Workbook, Optional bValidateFields As Boolean = True)
'<<<
'purpose: load schedule records from a sheet; validate and add ref data where appropriate
'       : lData and lHeader are the names of the ranges where the data can be found
'>>>
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sDefnSheetName As String, sFieldName As String, sWidgetKey As String, sLoaderSheetName As String, sFormName As String
Dim rHeader As Range, rData As Range, rRow As Range, rCell As Range, rResult As Range, rDataType As Range
Dim iRecordsLoaded As Integer, iRow As Integer, iCol As Integer
Dim vData() As Variant, vHeader() As Variant, vDataType() As Variant, vDirtyRows() As Variant
Dim vRows() As String, vColumnNames() As String
Dim lStartTick As Long
Dim vValueToValidate As Variant
Dim bFieldValid As Boolean, bRowValid As Boolean
Dim wsCacheTable As Worksheet
Dim dRecordValues As Dictionary
Dim eFormType As FormType

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Loader"
    sDefnSheetName = "LoaderDefn"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    'On Error GoTo err
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    eFormType = FormType.Add
    sFormName = GetFormName(eFormType, WorksheetFunction.Proper(sDataType), WorksheetFunction.Proper(sSubDataType))

    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sDefnSheetName
    
    ' FormType is Add because effectively we are functionally doing the saming thing as adding records via Add forms
    GetDefinition clsAppRuntime, sDataType, sSubDataType, sDefnSheetName, FormType.Add

main:
    ' Put named ranges in arrays for easier access
    sLoaderSheetName = GetLoaderSheetName(sDataType, sSubDataType)
    Set rData = wbTmp.Sheets(sLoaderSheetName).Range("lData")
    Set rHeader = wbTmp.Sheets(sLoaderSheetName).Range("lHeader")
    Set rDataType = wbTmp.Sheets(sLoaderSheetName).Range("lDataType")
    Set rResult = rData.Offset(, rData.Columns.Count).Resize(, 1)
    vData = rData
    vHeader = rHeader
    vDataType = rDataType
    
    ' for each data row and each column of each row
    For iRow = 1 To UBound(vData)
        bRowValid = True
        Set dRecordValues = New Dictionary ' for adding to the CacheTable
        For iCol = 1 To UBound(vData, 2)
            sFieldName = vHeader(1, iCol)
            vValueToValidate = vData(iRow, iCol)
            Set rCell = rData.Rows(iRow).Columns(iCol) ' corresponding cell of data being processed
            sDataType = CStr(vDataType(iRow, 1)) ' i.e. Schedule
            sSubDataType = CStr(vDataType(iRow, 2)) ' i.e. Student
            
            'sWidgetKey = GetWidgetKey("AddLesson", sFieldName, WidgetType.Entry) ' i.e eAddLesson_sFacultyFirstNm
            sWidgetKey = GetWidgetKey(sFormName, sFieldName, WidgetType.Entry) ' i.e eAddLesson_sFacultyFirstNm

            If bValidateFields = True Then
                bFieldValid = Validate(clsAppRuntime, sWidgetKey, vValueToValidate) ' i.e. David
            Else
                bFieldValid = True
            End If
            
            dRecordValues.Add sFieldName, vValueToValidate
            
            ' update cell color to show status of validation
            If bFieldValid = False Then
                bRowValid = False
                SetBgColorFromString sLoaderSheetName, rCell, C_RGB_INVALID, wbTmp:=wbTmp
            Else
                SetBgColorFromString sLoaderSheetName, rCell, C_RGB_VALID, wbTmp:=wbTmp
            End If
        Next iCol
        
        ' row is valid if none of the fields are invalid
        rResult.Rows(iRow).value = CStr(bRowValid)
        
        ' add to CacheTable
        If bRowValid = True Then
            Set wsCacheTable = GetTable(clsAppRuntime, sDataType, sSubDataType)
            AddTableRecordFromDict wsCacheTable, wsCacheTable.Name, dRecordValues
        End If
    Next iRow
    
    ' write to DB
    vDirtyRows = GetDirtyTableRecords(wsCacheTable.Name, clsAppRuntime.CacheBook, bResetDirtyFlag:=True)
    vColumnNames = GetTableWidgetKeys(wsCacheTable.Name, bFieldNameOnly:=True)
    
    
    'create this function and put the lines of code below in it
    'make sure the original tests still work
    'then keep just 1 version of App_Loader
    'but need to make it a new type so an pass in the dArgs(ver_series)
    
    'InsertDataToDB (sDataType)
    
    If sDataType = "Schedule" Then
        InsertScheduleLessonDataToDB clsAppRuntime, QuadSubDataType.Student, vDirtyRows, vColumnNames
    Else
        InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vDirtyRows, vColumnNames
    End If
    
cleanup:
    FuncLogIt sFuncName, "[sLoaderSheetName=" & sLoaderSheetName & "] [Records Loaded=" & CStr(UBound(vDirtyRows) + 1) & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    'FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Sub
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Sub
