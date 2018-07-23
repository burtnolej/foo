Attribute VB_Name = "Quad_Schedule_View"
'Public Function GetScheduleDataFromDB
'Public Function GetScheduleWidgetColWidths
'Public Function GetScheduleWidgetFormat
'Function GetScheduleDataHelpers
'Public Function BuildSchedule
'Public Function BuildScheduleView

Option Explicit
Const C_MODULE_NAME = "Quad_Schedule_View"

Public Function GetNextClassLectureID() As Integer
' this should do a max on the table column
    GetNextClassLectureID = 10000
End Function

Function AddAddLesson(clsAppRuntime As App_Runtime, _
                dValues As Dictionary, sTemplateRangeName As String, _
                iStudentID As Integer, _
                Optional eQuadDataSubType As QuadSubDataType = QuadSubDataType.Student) As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer
Dim aColumnWidths() As Integer
Dim sSheetName As String, sTableName As String, sTemplateRowRangeName As String, sTemplateColRangeName As String
Dim wsSchedule As Worksheet, wsTable As Worksheet
Dim rTemplateSource As Range
    
    ' this is about adding a new lesson to a schedule view
    clsAppRuntime.ScheduleBook.Windows(1).Visible = False
    
    sSheetName = "view_" & EnumQuadSubDataType(eQuadDataSubType) & "_" & CStr(iStudentID)
    If SheetExists(clsAppRuntime.ScheduleBook, sSheetName) = False Then
        Set wsSchedule = CreateSheet(clsAppRuntime.ScheduleBook, sSheetName)
        
        ' draw headers
        sTemplateRowRangeName = "f" & "student" & "ScheduleRowLabel"
        GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRowRangeName
        BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.PeriodEnum, iFormatWidth, iFormatHeight
    
        sTemplateColRangeName = "f" & "student" & "ScheduleColLabel"
        GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateColRangeName
        BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.DayEnum, iFormatWidth, iFormatHeight, iStartCol:=4, iStartRow:=2, bVz:=False

    Else
        Set wsSchedule = GetSheet(clsAppRuntime.ScheduleBook, sSheetName)
    End If
    
    sTableName = "schedule_" & EnumQuadSubDataType(eQuadDataSubType)
    
    ' if Table does not exist
    If SheetExists(clsAppRuntime.CacheBook, sTableName) = False Then
        Set wsTable = CreateTable(sTableName, wbTmp:=clsAppRuntime.CacheBook)
    Else
        Set wsTable = GetSheet(clsAppRuntime.CacheBook, sTableName)
    End If
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsAppRuntime, sTemplateRangeName, iColWidthCount)
        
    Set AddAddLesson = BuildScheduleCellView(clsAppRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths)

    AddTableRecordFromDict wsTable, sTableName, dValues
    
    clsAppRuntime.ScheduleBook.Windows(1).Visible = True
End Function

Public Sub GenerateScheduleLessonListView(dArgs As Dictionary)
'<<<
'purpose: Create a list view type form showing a persons scheduled events
'param  : clsAppRuntime,App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'rtype  :
'>>>
Dim sFuncName As String, sSheetName As String, sDefn As String, sDataType As String, sSubDataType As String, sFormName As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim lStartTick As Long
Dim vValues() As Variant
Dim rData As Range, rHeader As Range
Dim clsAppRuntime As App_Runtime
Dim iStudentID As Integer
Dim clsExecProc As New Exec_Proc
Dim eFormType As FormType

unpackargs:
    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If dArgs.Exists("sValue") Then
        ' this has been called by a generic update callback
        iStudentID = CInt(dArgs.Item("sValue"))
    Else
        iStudentID = dArgs("iStudentID")
    End If
    
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    If dArgs.Exists("eFormType") Then
        eFormType = dArgs.Item("eFormType")
    Else
        eFormType = FormType.ViewList
    End If
    
    If dArgs.Exists("sSubDataType") Then
        sSubDataType = dArgs.Item("sSubDataType")
    Else
        sSubDataType = "Lesson"
    End If
    
    
setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleListView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:


    sSheetName = "test"
    sDataType = "Schedule"
    'sSubDataType = "Lesson"
    If SheetExists(clsAppRuntime.TemplateBook, sSheetName) = False Then
        CreateSheet clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True
        GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, eFormType
        
    End If
                     
    'AddArgs dArgs, False, "iStudentID", iStudentID, "eQuadDataType", QuadDataType.Schedule, "eQuadSubDataType", _
    '    QuadSubDataType.Lesson, "eQuadScope", QuadScope.specified, "bInTable", True
        
    AddArgs dArgs, False, "iStudentID", iStudentID, "eQuadDataType", QuadDataType.Schedule, "eQuadSubDataType", _
        GetQuadSubDataTypeEnumFromValue(sSubDataType), "eQuadScope", QuadScope.specified, "bInTable", True
        
        
    
    Set wsTmp = Application.Run(C_GET_SCHEDULE_DATA, dArgs)
    
    Set rData = wsTmp.Range("data")
    Set rData = rData.Offset(1).Resize(rData.Rows.Count - 1)
    
    vValues = rData
    
    AddArgs dArgs, False, "vValues", vValues, "bLoadRefData", True
    Application.Run C_GENERATE_FORMS, dArgs

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub

'Public Function BuildSchedule(clsAppRuntime As App_Runtime, _
'                              eQuadSubDataType As QuadSubDataType, _
'                              iPersonID As Integer) As Worksheet


Public Sub GenerateScheduleView(dArgs As Dictionary)

'Public Sub GenerateScheduleView(clsAppRuntime As App_Runtime, iStudentID As Integer)
'<<<
'purpose: Create a schedule view type form showing a persons scheduled events in calendar grid format
'param  : clsAppRuntime,App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'rtype  :
'>>>
Dim sFuncName As String, sSheetName As String, sDefn As String, sDataType As String, sSubDataType As String, sFormName As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim lStartTick As Long
Dim vValues() As Variant
Dim rData As Range, rHeader As Range
Dim clsAppRuntime As App_Runtime
Dim iStudentID As Integer
Dim clsExecProc As New Exec_Proc
Dim sAppState As Variant

unpackargs:
    Set clsAppRuntime = dArgs("clsAppRuntime")
    
    If clsAppRuntime.Version <> "" Then
        AddDict dArgs, "ver_series", clsAppRuntime.Version
    End If
    
    If clsAppRuntime.AppState <> "" Then
        For Each sAppState In Split(clsAppRuntime.AppState, COMMA)
            AddDict dArgs, CStr(Split(CStr(sAppState), "=")(0)), CStr(Split(CStr(sAppState), "=")(1))
        Next sAppState
    End If
        
    If dArgs.Exists("sValue") Then
        ' this has been called by a generic update callback
        iStudentID = CInt(dArgs.Item("sValue"))
    Else
        iStudentID = dArgs("iStudentID")
    End If
    
    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        'Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    sSheetName = "test"
    sDataType = "Schedule"
    sSubDataType = "Lesson"
    If SheetExists(clsAppRuntime.TemplateBook, sSheetName) = False Then
        CreateSheet clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True
        GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.ViewSchedule
    End If
                     
    AddArgs dArgs, False, "clsExecProc", clsExecProc, "iStudentID", iStudentID, "eQuadDataType", QuadDataType.Schedule, "eQuadSubDataType", QuadSubDataType.Lesson, "eQuadScope", QuadScope.specified, "bInTable", True
    Set wsTmp = Application.Run(C_GET_SCHEDULE_DATA, dArgs)
    
    Set rData = wsTmp.Range("data")
    
    vValues = rData
    
    AddArgs dArgs, False, "vValues", vValues, "iRecordID", iStudentID, "bLoadRefData", True
    Application.Run C_GENERATE_FORMS, dArgs

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub

Public Function BuildSchedule(dArgs As Dictionary) As Worksheet

'"""Using data from the database, and a format template, create a visual schedule on a new sheet
'param:sScheduleType, string, either student or teacher
'param:iPersonalId, integer, value of the student or teacher to retreive the schedule for
'rtype:Worksheet, the sheet object where the schedule view has been written
'"""
Dim sResultFileName As String, sFuncName As String, sTemplateRangeName As String, sCacheSheetName As String
Dim aSchedule() As Variant
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim wbMaster As Workbook, wbTmp As Workbook
Dim eQuadSubDataType As QuadSubDataType
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc
Dim vCopyValues As Variant

unpackargs:

    If dArgs.Exists("wbMaster") = False Then
        ' no versions running, one code book which is the current one
        Set wbTmp = ActiveWorkbook
    Else
        Set wbMaster = dArgs.Item("wbMaster")
        'Set wbTmp = dArgs.Item("wbTmp")
    End If
    
    iPersonID = dArgs.Item("iPersonID")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")
    Set clsExecProc = dArgs.Item("clsExecProc")

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildSchedule"
    sTemplateRangeName = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"
    FuncLogIt sFuncName, "Template range name not set so defaulting to  [" & sTemplateRangeName & "]", C_MODULE_NAME, LogMsgType.INFO
   
main:
    If IsDataCached(clsAppRuntime, QuadDataType.Schedule, eQuadSubDataType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results

        'AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student
        clsExecProc.ExecProc "GetPersonScheduleDataFromDB", dArgs

        'GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, eQuadSubDataType
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, _
                            eQuadSubDataType, iPersonID, bInTable:=True)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, eQuadSubDataType, _
                            iPersonID, bCacheNameOnly:=True)
    End If
    ' get the template widths and heights
    vCopyValues = GetScheduleCellFormat(clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName)
    ' store the data needed to build the schedules as a module member variable for easy access
    GetScheduleDataHelpers clsAppRuntime, sCacheSheetName
    ' draw the schedule
    
    AddArgs dArgs, False, "iFormatWidth", iFormatWidth, "iFormatHeight", iFormatHeight, "aColumnWidths", aColumnWidths
    Application.Run C_BUILD_SCHEDULE_VIEW, dArgs
    'Set BuildSchedule = BuildScheduleView(clsAppRuntime, aColumnWidths, iFormatWidth, iFormatHeight, eQuadSubDataType, iPersonID)
    Set BuildSchedule = dArgs.Item("result")
cleanup:
    AddErrorToDict dArgs, vResult:=BuildSchedule
    Exit Function
    
err:
    AddErrorToDict dArgs, iErrorCode:=err.Number, sErrorDesc:=err.Description
End Function

Public Function GetScheduleData(dArgs As Dictionary)
Dim sCacheSheetName As String, sFuncName As String
Dim aSchedule() As Variant
Dim clsAppRuntime As App_Runtime
Dim eQuadDataType As QuadDataType
Dim eQuadSubDataType As QuadSubDataType
Dim eQuadScope As QuadScope
Dim bInTable As Boolean
Dim iPersonID As Integer
Dim clsExecProc As Exec_Proc

unpackargs:

    Set clsAppRuntime = dArgs("clsAppRuntime")
    iPersonID = dArgs.Item("iStudentID")
    eQuadDataType = dArgs.Item("eQuadDataType")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    eQuadScope = dArgs.Item("eQuadScope")
    bInTable = dArgs.Item("bInTable")
    
    
    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        'Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleData"
    
main:

    If IsDataCached(clsAppRuntime, QuadDataType.Schedule, eQuadSubDataType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results
        AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "sPersonId", iPersonID, "eQuadSubDataType", eQuadSubDataType
        'GetScheduleLessonDataFromDB dArgs
        
        clsExecProc.ExecProc "GetScheduleLessonDataFromDB", dArgs
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, eQuadSubDataType, iDataID:=iPersonID, bInTable:=bInTable)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, eQuadSubDataType, _
                            iPersonID, bCacheNameOnly:=True, bInTable:=bInTable)
    End If
    
    Set GetScheduleData = clsAppRuntime.CacheBook.Sheets(sCacheSheetName)

End Function
    
Public Sub GetScheduleLessonDataFromDB(dArgs As Dictionary)
Dim sResultFileName As String, sSpName As String, sResults As String, sFuncName As String, sPeriod As String, sDay As String, sPersonId As String
Dim dSpArgs As New Dictionary
Dim wbMaster As Workbook, wbTmp As Workbook
Dim eQuadSubDataType As QuadSubDataType
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As New Exec_Proc

unpackargs:

    If dArgs.Exists("wbMaster") = False Then
        ' no versions running, one code book which is the current one
        Set wbTmp = ActiveWorkbook
    Else
        Set wbMaster = dArgs.Item("wbMaster")
    End If
    
    sPersonId = dArgs.Item("sPersonId")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    sPeriod = dArgs.Item("sPeriod")
    sDay = dArgs.Item("sDay")
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")
    If dArgs.Exists("clsExecProc") = False Then
        clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleLessonDataFromDB"
    
    ' Assertions --------------------------------
    'If IsValidPersonID(clsAppRuntime, CStr(sPersonId), eQuadSubDataType) = False Then
    
    If CInt(sPersonId) <> 0 Then
        AddArgs dArgs, False, "iPersonID", CInt(sPersonId)
        If Application.Run(C_IS_VALID_PERSON, dArgs) = False Then
            err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
        Else
             FuncLogIt sFuncName, "[" & EnumQuadSubDataType(eQuadSubDataType) & "] id[" & CStr(sPersonId) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
        End If
    End If
    ' END Assertions ----------------------------

main:
    'sSpName = "schedule_lesson"
    sSpName = "schedule_" & EnumQuadSubDataType(eQuadSubDataType)

    'If sPersonId <> 0 Then
    dSpArgs.Add "students", InitVariantArray(Array(sPersonId))
    'End If
    
    FuncLogIt sFuncName, "schedule type is [" & EnumQuadSubDataType(eQuadSubDataType) & "] using sp [" & sSpName & "]", C_MODULE_NAME, LogMsgType.INFO
    
    If sPeriod <> "" Then
        dSpArgs.Add "periods", InitVariantArray(Split(sPeriod, ","))
        FuncLogIt sFuncName, "Period WHERE clause specified  [" & sPeriod & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

    If sDay <> "" Then
        dSpArgs.Add "days", InitVariantArray(Split(sDay, ","))
        FuncLogIt sFuncName, "Day WHERE clause specified  [" & sDay & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
cleanup:
    GetQuadDataFromDB clsAppRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=True

End Sub


'Public Sub GetPersonScheduleDataFromDB(clsAppRuntime As App_Runtime, _
'                                 sPersonId As Integer, _
'                                 eQuadSubDataType As QuadSubDataType, _
'                        Optional sPeriod As String, _
'                        Optional sDay As String)
                        
Public Sub GetPersonScheduleDataFromDB(dArgs As Dictionary)
Dim sResultFileName As String, sSpName As String, sResults As String, sFuncName As String, sPeriod As String, sDay As String
Dim dSpArgs As New Dictionary
Dim iPersonID As Integer
Dim eQuadSubDataType As QuadSubDataType
Dim clsAppRuntime As App_Runtime

unpackargs:
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    iPersonID = dArgs.Item("iPersonID")
    sPeriod = dArgs.Item("sPeriod")
    sDay = dArgs.Item("sDay")

setup:
    sFuncName = C_MODULE_NAME & "." & "GetPersonScheduleDataFromDB"
    
    ' Assertions --------------------------------
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", eQuadSubDataType
    
    If iPersonID <> 0 Then
        If Application.Run(C_IS_VALID_PERSON, dArgs) = False Then
        'If IsValidPersonID(clsAppRuntime, CStr(iPersonID), eQuadSubDataType) = False Then
            err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
        Else
             FuncLogIt sFuncName, "[" & EnumQuadSubDataType(eQuadSubDataType) & "] id[" & CStr(iPersonID) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
        End If
    End If
    ' END Assertions ----------------------------

main:
    If eQuadSubDataType = QuadSubDataType.Student Then
        sSpName = "student_schedule"
        dSpArgs.Add "students", InitVariantArray(Array(iPersonID))
    ElseIf eQuadSubDataType = QuadSubDataType.Teacher Then
        sSpName = "teacher_schedule"
        dSpArgs.Add "teachers", InitVariantArray(Array(iPersonID))
    ElseIf eQuadSubDataType = QuadSubDataType.School Then
        sSpName = "school_schedule"
        dSpArgs.Add "students", InitVariantArray(Array(iPersonID))
        GoTo cleanup ' no days/periods required
    End If
    FuncLogIt sFuncName, "schedule type is [" & EnumQuadSubDataType(eQuadSubDataType) & "] using sp [" & sSpName & "]", C_MODULE_NAME, LogMsgType.INFO
    
    If sPeriod <> "" Then
        dSpArgs.Add "periods", InitVariantArray(Split(sPeriod, ","))
        FuncLogIt sFuncName, "Period WHERE clause specified  [" & sPeriod & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

    If sDay <> "" Then
        dSpArgs.Add "days", InitVariantArray(Split(sDay, ","))
        FuncLogIt sFuncName, "Day WHERE clause specified  [" & sDay & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
cleanup:
    GetQuadDataFromDB clsAppRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=True

End Sub
Function GetScheduleDataHelpers(clsAppRuntime As App_Runtime, sCacheSheetName As String)
Dim iScheduleWidth As Integer, iScheduleHeight As Integer
Dim rSource As Range
    ' Assertions --------------------------------
    ' END Assertions ----------------------------
    
    Set rSource = clsAppRuntime.CacheBook.Sheets(sCacheSheetName).Range(clsAppRuntime.CacheRangeName)
    iScheduleWidth = rSource.Columns.Count
    iScheduleHeight = rSource.Rows.Count

    clsAppRuntime.CurrentSheetColumns = rSource.Rows(1)
    clsAppRuntime.CurrentSheetSource = rSource.Resize(rSource.Rows.Count - 1).Offset(1)
    
End Function


Public Function GetScheduleCellFormat(clsAppRuntime As App_Runtime, ByRef iFormatWidth As Integer, _
                                 ByRef iFormatHeight As Integer, sScheduleFormatRangeName As String) As Variant
'gets the template for the cell and puts it into the clipboard
'param: sSourceBookName, string, the book that holds the templates (vba_source_new.xlsm)
'param: sSourceSheetName, string, the sheet in sSourceBookName that holds the templates (FormStyles)
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim rScheduleFormatRange As Range

    Set rScheduleFormatRange = clsAppRuntime.TemplateBook.Names(sScheduleFormatRangeName).RefersToRange
    rScheduleFormatRange.Copy
    iFormatWidth = rScheduleFormatRange.Range(sScheduleFormatRangeName).Columns.Count
    iFormatHeight = rScheduleFormatRange.Range(sScheduleFormatRangeName).Rows.Count

    GetScheduleCellFormat = rScheduleFormatRange.value
End Function
        
Public Function GetScheduleCellColWidths(clsAppRuntime As App_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim aColumnWidths() As Integer
Dim rWidget As Range

    ReDim aColumnWidths(0 To 20)
    With clsAppRuntime.TemplateSheet
        '.Activate
        For Each rWidget In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rWidget.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rWidget
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetScheduleCellColWidths = aColumnWidths
End Function


Function BuildScheduleCellView(dArgs As Dictionary)
'Function BuildScheduleCellView(clsAppRuntime As App_Runtime, _
'                          wsSchedule As Worksheet, _
'                          ByVal dValues As Dictionary, _
'                          iFormatWidth As Integer, iFormatHeight As Integer, _
'                          aColumnWidths() As Integer, _
'                Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student, _
'                Optional iViewRowOffset As Integer = 0, _
'                Optional iViewColOffset As Integer = 2, _
'                Optional vCopyValues As Variant) As Range

Dim iScheduleCurrentRow As Integer, iScheduleCurrentCol As Integer, iColWidthCount As Integer, iFormatHeight, iViewColOffset As Integer, iFormatWidth As Integer, iViewRowOffset As Integer
Dim rScheduleFormatTargetRange As Range, rWidget As Range
Dim sFormatTemplateRange As String, sDayCd As String, sFuncName As String, sFormName As String
Dim lStartTick As Long, lSubStartTick As Long
Dim wsSchedule As Worksheet
Dim dValues As Dictionary
Dim eQuadSubDataType As QuadSubDataType
Dim vCopyValues As Variant
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc


unpackargs:
    Set clsAppRuntime = dArgs("clsAppRuntime")

    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    If dArgs.Exists("sFormName") Then
        ' generating a specific form not all defined
        sFormName = dArgs.Item("sFormName")
    Else
        sFormName = ""
    End If
    
    Set wsSchedule = dArgs.Item("wsSchedule")
    Set dValues = dArgs.Item("dValues")
    vCopyValues = dArgs.Item("vCopyValues")
    iFormatWidth = dArgs.Item("iFormatWidth")
    iFormatHeight = dArgs.Item("iFormatHeight")
    
    If dArgs.Exists("eQuadSubDataType") Then
        ' generating a specific form not all defined
        eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    Else
        eQuadSubDataType = QuadSubDataType.Student
    End If

    If dArgs.Exists("iViewRowOffset") Then
        ' generating a specific form not all defined
        iViewRowOffset = dArgs.Item("iViewRowOffset")
    Else
        iViewRowOffset = 0
    End If

    If dArgs.Exists("iViewColOffset") Then
        ' generating a specific form not all defined
        iViewColOffset = dArgs.Item("iViewColOffset")
    Else
        iViewColOffset = 0
    End If
    
setup:
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleCellView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    'On Error GoTo err
    
    sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"

main:

    With wsSchedule
    
        iScheduleCurrentRow = iFormatHeight * CInt(dValues("idTimePeriod")) + iViewRowOffset
        
        If dValues.Exists("cdDay") Then
            iScheduleCurrentCol = 2 + (iFormatWidth * (CInt(IndexArray(Split(clsAppRuntime.DayEnum, COMMA), _
                                            dValues("cdDay"))))) + iViewColOffset
        Else

            AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "eQuadDataType", QuadDataType.Misc, "eQuadSubDataType", QuadSubDataType.Day, _
                        "sLookUpByColName", "idDay", "sLookUpByValue", dValues("idDay"), "sLookUpColName", "cdDay"
            Application.Run C_CROSS_REF_QUAD_DATA, dArgs
            sDayCd = dArgs.Item("result")
            
            iScheduleCurrentCol = 2 + (iFormatWidth * (CInt(IndexArray(Split(clsAppRuntime.DayEnum, COMMA), _
                                       sDayCd)))) + iViewColOffset
        End If
                                  
        
        Set rScheduleFormatTargetRange = wsSchedule.Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), _
                    .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
        
        If IsSet(vCopyValues) = False Then
            rScheduleFormatTargetRange.PasteSpecial Paste:=xlPasteAll, operation:=xlNone, SkipBlanks:=False, Transpose:=False
        Else
            rScheduleFormatTargetRange = vCopyValues
        End If
        
        For Each rWidget In rScheduleFormatTargetRange.Cells
            If Left(rWidget.value, 1) = "&" Then
                AddDict dArgs, "dFields", dValues, True
                Application.Run Right(rWidget.value, Len(rWidget.value) - 1), dArgs
                rWidget.value = dArgs.Item("result")
           End If
        Next rWidget
    End With
        
cleanup:
    FuncLogIt sFuncName, "[cdDay=" & dValues.Item("cdDay") & "] [idTimePeriod=" & dValues.Item("idTimePeriod") & "] ", C_MODULE_NAME, LogMsgType.DEBUGGING
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
    Set BuildScheduleCellView = rScheduleFormatTargetRange
    Exit Function

err:
    FuncLogIt sFuncName, "Error [ " & err.Description & "]  [cdDay=" & dValues.Item("cdDay") & "] [idTimePeriod=" & dValues.Item("idTimePeriod") & "]", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this
    

End Function
Function BuildScheduleView(dArgs As Dictionary)
'Function BuildScheduleView(clsAppRuntime As App_Runtime, _
'                           aColumnWidths() As Integer, _
'                           iFormatWidth As Integer, _
'                           iFormatHeight As Integer, _
'                           eQuadSubDataType As QuadSubDataType, _
'                           iPersonID As Integer, _
'                          Optional vCopyValues As Variant) As Worksheet
Dim wsSchedule As Worksheet
Dim sScheduleSheetName As String
Dim dValues As Dictionary
Dim i As Integer, j As Integer, iPersonID As Integer
Dim eQuadSubDataType As QuadSubDataType
Dim clsAppRuntime As App_Runtime

unpackargs:
    Set clsAppRuntime = dArgs("clsAppRuntime")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    iPersonID = dArgs.Item("iPersonID")

setup:
    DoEventsOff
    
    sScheduleSheetName = "view_" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID)
    
    If SheetExists(clsAppRuntime.ScheduleBook, sScheduleSheetName) = True Then
        Set wsSchedule = GetSheet(clsAppRuntime.ScheduleBook, sScheduleSheetName)
    Else
        Set wsSchedule = CreateSheet(clsAppRuntime.ScheduleBook, sScheduleSheetName, bOverwrite:=True)
    End If
        
    AddArgs dArgs, False, "wsSchedule", wsSchedule
    For i = 1 To UBound(clsAppRuntime.CurrentSheetSource)
    
        ' generate a dictionary of the details
        Set dValues = New Dictionary
        For j = 1 To UBound(clsAppRuntime.CurrentSheetSource, 2)
            dValues.Add clsAppRuntime.CurrentSheetColumns(1, j), clsAppRuntime.CurrentSheetSource(i, j)
        Next j
    
        AddDict dArgs, "dValues", dValues, True
        
        Application.Run C_BUILD_SCHEDULE_CELL_VIEW, dArgs
        'BuildScheduleCellView clsAppRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths, vCopyValues:=vCopyValues
        
    Next i
    
    Set BuildScheduleView = wsSchedule
    AddDict dArgs, "result", wsSchedule, True
DoEventsOn
End Function


Function BuildScheduleViewFromValues(dArgs As Dictionary)

Dim wsSchedule As Worksheet
Dim sScheduleSheetName As String, sTemplateRangeName As String, sCacheSheetName As String, sFuncName As String, lStartTick As Long, sSheetName As String, sFormType As String, sTemplateSheetName As String
Dim dValues As Dictionary
Dim i As Integer, j As Integer, iFormatWidth As Integer, iFormatHeight As Integer, iPersonID As Integer
Dim aColumnWidths() As Integer
Dim vCopyValues As Variant, vValues As Variant
Dim wbTarget As Workbook
Dim eQuadSubDataType As QuadSubDataType
Dim clsAppRuntime As App_Runtime
Dim clsExecProc As Exec_Proc

unpackargs:
    Set clsAppRuntime = dArgs("clsAppRuntime")

    If dArgs.Exists("clsExecProc") = False Then
        Set clsExecProc = GetExecProcGlobal(wbTmp:=Workbooks(clsAppRuntime.MainBookName))
    Else
        Set clsExecProc = dArgs.Item("clsExecProc")
    End If
    
    If dArgs.Exists("sFormType") Then
        ' generating a specific form not all defined
        sFormType = dArgs.Item("sFormType")
    Else
        sFormType = "Add"
    End If
    
    If dArgs.Exists("sTemplateSheetName") Then
        ' generating a specific form not all defined
        sTemplateSheetName = dArgs.Item("sTemplateSheetName")
    Else
        sTemplateSheetName = "Add"
    End If
    
    sSheetName = dArgs.Item("sSheetName")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    Set wbTarget = dArgs.Item("wbTarget")
    iPersonID = dArgs.Item("iPersonID")
    vValues = dArgs.Item("vValues")
    
setup:
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleViewFromValues"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    
    DoEventsOff

main:

    If SheetExists(wbTarget, sSheetName) = True Then
        Set wsSchedule = GetSheet(wbTarget, sSheetName)
    Else
        Set wsSchedule = CreateSheet(wbTarget, sSheetName, bOverwrite:=True)
    End If
    
    sTemplateRangeName = "f" & "student" & "ScheduleRowLabel"
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.PeriodEnum, iFormatWidth, iFormatHeight, iStartRow:=7, iStartCol:=2, _
        idAcadPeriod:=dArgs.Item("idAcadPeriod")
    
    sTemplateRangeName = "f" & "student" & "ScheduleColLabel"
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.DayEnum, iFormatWidth, iFormatHeight, bVz:=False, iStartCol:=4, _
        idAcadPeriod:=dArgs.Item("idAcadPeriod")

    sTemplateRangeName = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"
    sCacheSheetName = "schedule_lesson_" & iPersonID
    
    vCopyValues = GetScheduleCellFormat(clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName)
    GetScheduleDataHelpers clsAppRuntime, sCacheSheetName

    ' the OffSets need to be how far the Schedule widget is offset from the origin of the Schedule Form
    AddArgs dArgs, False, "wsSchedule", wsSchedule, "vCopyValues", vCopyValues, "iFormatWidth", iFormatWidth, "iFormatHeight", iFormatHeight, _
             "iViewColOffset", 2, "iViewRowOffset", 4
    For i = 2 To UBound(vValues)
        ' generate a dictionary of the details from the cache
        Set dValues = New Dictionary
        For j = 1 To UBound(vValues, 2)
            dValues.Add vValues(1, j), vValues(i, j)
        Next j
        AddDict dArgs, "dValues", dValues, True

        Application.Run C_BUILD_SCHEDULE_CELL_VIEW, dArgs
    Next i
    
    Set BuildScheduleViewFromValues = wsSchedule
    
cleanup:
    DoEventsOn
    FuncLogIt sFuncName, "[iPersonID=" & CStr(iPersonID) & "] ", C_MODULE_NAME, LogMsgType.DEBUGGING
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function
Function BuildScheduleHeaderView(clsAppRuntime As App_Runtime, _
                          wsSchedule As Worksheet, _
                          sEnums As String, _
                          iFormatWidth As Integer, iFormatHeight As Integer, _
                Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student, _
                Optional iStartRow As Integer = 3, _
                Optional iStartCol As Integer = 1, _
                Optional bVz As Boolean = True, _
                Optional idAcadPeriod = 1) As Range

Dim iScheduleCurrentRow As Integer, iColWidthCount As Integer, i As Integer, iScheduleCurrentCol As Integer
Dim rScheduleFormatTargetRange As Range, rWidget As Range, rMarker As Range
Dim sFormatTemplateRange As String
Dim iNumValues As Integer
Dim vEnumValues() As String
Dim dArgs As New Dictionary

    vEnumValues = Split(sEnums, COMMA)

    iNumValues = UBound(vEnumValues) + 1
    
    If bVz = True Then
        sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleRowLabel"
    Else
        sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleColLabel"
    End If
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime
                
    With wsSchedule
        For i = 1 To iNumValues

            ' paste the formats into the corresponding cell on the "grid"
            If bVz = True Then
                iScheduleCurrentRow = iStartRow + (iFormatHeight * (i - 1))
                iScheduleCurrentCol = iStartCol
            Else
                iScheduleCurrentRow = iStartRow
                iScheduleCurrentCol = iStartCol + (iFormatWidth * (i - 1))
            End If
            
            Set rScheduleFormatTargetRange = wsSchedule.Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
            rScheduleFormatTargetRange.PasteSpecial Paste:=xlPasteAll, operation:=xlNone, SkipBlanks:=False, Transpose:=False
            
            'FormatColRowSize clsAppRuntime.TemplateBook, clsAppRuntime.ScheduleBook, _
            '        wsSchedule.Name, clsAppRuntime.TemplateSheetName, sFormatTemplateRange, _
            '        iTargetFirstRow:=iScheduleCurrentRow, iTargetFirstCol:=iScheduleCurrentCol
        
            ' evaluate the data functions to get the content
            For Each rWidget In rScheduleFormatTargetRange.Cells
                If Left(rWidget.value, 1) = "&" Then

                    AddArgs dArgs, False, "sValue", vEnumValues(i - 1), "idAcadPeriod", idAcadPeriod
                    rWidget.value = Application.Run(Right(rWidget.value, Len(rWidget.value) - 1), dArgs)
                End If
            Next rWidget
            
            ' put inivisble markets in row 1 and col 1 so context menu's know what cell
            If bVz = True Then
                Set rMarker = wsSchedule.Range(.Cells(iScheduleCurrentRow, 1), .Cells(iScheduleCurrentRow + iFormatHeight - 1, 1))
            Else
                Set rMarker = wsSchedule.Range(.Cells(1, iScheduleCurrentCol), .Cells(1, iScheduleCurrentCol + iFormatWidth - 1))
            End If
            rMarker.value = vEnumValues(i - 1)
            SetFgColor wsSchedule.Name, rMarker.Address, 255, 255, 255, wbTmp:=clsAppRuntime.ScheduleBook
        Next i
    End With
    
    Set BuildScheduleHeaderView = rScheduleFormatTargetRange
End Function

