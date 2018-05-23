Attribute VB_Name = "App_Schedule_Add"
Option Explicit
Const C_MODULE_NAME = "App_Schedule_Add"


Public Sub InsertScheduleDataToDB(clsAppRuntime As App_Runtime, _
                                  eQuadSubDataType As QuadSubDataType, _
                                  vRows As Variant, _
                                  vColumns As Variant)
                               
Dim sSpName As String

    sSpName = "insert_basic_" & EnumQuadSubDataType(eQuadSubDataType) & "_info"
    InsertQuadDataToDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRows:=vRows, vColumns:=vColumns
                               
End Sub

Public Sub EditLesson(iPersonID As Integer, _
                      sDayCd As String, _
                      iPeriodID As Integer, _
             Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student)
Dim vPeriodIds() As String, vDayCds() As String
Dim vTmp() As Integer
Dim sCacheSheetName As String
Dim wsCache As Worksheet
Dim iIndex As Integer
Dim dAllDefaultValues As New Dictionary, dDefaultValues As New Dictionary
Dim clsAppRuntime As New App_Runtime

    clsAppRuntime.InitProperties bInitializeCache:=False

    Set Form_Utils.dDefinitions = LoadDefinitions(clsAppRuntime.TemplateBook.Sheets("Definitions"), _
                rSource:=clsAppRuntime.TemplateBook.Sheets("Definitions").Range("Definitions"))
                
    Set wsCache = GetScheduleData(clsAppRuntime, iPersonID, QuadDataType.Schedule, eQuadSubDataType, bInTable:=True)
        
    vPeriodIds = GetColumnValues(clsAppRuntime, QuadDataType.Schedule, QuadSubDataType.Student, _
                "idTimePeriod", iPersonID:=iPersonID)
    vTmp = IndexArrayMulti(vPeriodIds, CStr(iPeriodID))
    vDayCds = GetColumnValues(clsAppRuntime, QuadDataType.Schedule, QuadSubDataType.Student, _
                    "cdDay", iPersonID:=iPersonID)

    iIndex = IndexArray(vDayCds, sDayCd, vWhere:=vTmp)
    dDefaultValues.Add "AddLesson", Row2Dict(wsCache, clsAppRuntime.CacheRangeName, iIndex + 1)

    GenerateForms clsAppRuntime, sFormName:="AddLesson", dDefaultValues:=dDefaultValues, _
        bSetAsValid:=True

End Sub
Public Function AddLesson() As Range
Dim dEntryValues As Dictionary
Dim sFormatRangeName As String
Dim clsAppRuntime As New App_Runtime
Dim iPersonID As Integer

    clsAppRuntime.InitProperties bInitializeCache:=False
    sFormatRangeName = "f" & "student" & "ScheduleCell"
    Set dEntryValues = GetRecordValuesAsDict(clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "AddLesson")
    iPersonID = CrossRefQuadData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, "sStudentFirstNm", dEntryValues.Item("sStudentFirstNm"), "idStudent")
    Set AddLesson = AddAddLesson(clsAppRuntime, dEntryValues, sFormatRangeName, iPersonID)
    
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
Public Sub GenerateScheduleAdd(clsAppRuntime As App_Runtime, Optional sSheetName As String = "test")
Dim sFuncName As String, sDefn As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleAdd"
    GetDefinition clsAppRuntime, "Schedule", "Lesson", sSheetName, FormType.Add

main:
    GenerateForms clsAppRuntime, bLoadRefData:=True
    
End Sub
