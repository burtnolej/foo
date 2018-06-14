Attribute VB_Name = "Quad_Schedule_Add"
Option Explicit
Const C_MODULE_NAME = "Quad_Schedule_Add"

Public Sub InsertScheduleLessonDataToDB(dArgs As Dictionary)
Dim sSpName As String
Dim iWidth As Integer, iHeight As Integer, iNextClassLectureID As Integer, i As Integer, iOrigLastCol As Integer
Dim clsAppRuntime As Object
Dim eQuadSubDataType As QuadSubDataType
Dim wbMaster As Workbook
Dim vRows As Variant, vColumns As Variant

unpackargs:
    Set clsAppRuntime = dArgs.Item("clsAppRuntime")
    eQuadSubDataType = dArgs.Item("eQuadSubDataType")
    vRows = dArgs.Item("vRows")
    vColumns = dArgs.Item("vColumns")
    Set wbMaster = dArgs.Item("wbMaster")

setup:
    iWidth = UBound(vRows, 2) - LBound(vRows, 2) + 1
    iHeight = UBound(vRows) - LBound(vRows) + 1
    iOrigLastCol = UBound(vRows, 2)

    iNextClassLectureID = GetNextClassLectureID
    
    vRows = ReDim2DArray(vRows, iHeight, iWidth + 1, bVariant:=True, bExpand:=True)
    
    For i = LBound(vRows) To UBound(vRows)
      vRows(i, iOrigLastCol + 1) = iNextClassLectureID
      iNextClassLectureID = iNextClassLectureID + 1
    Next i

    iHeight = UBound(vColumns) + 1
    
    ReDim Preserve vColumns(0 To iHeight)
    vColumns(iHeight) = "idClassLecture"
    
    'sSpName = "insert_" & LCase(EnumQuadSubDataType(eQuadSubDataType)) & "_schedule"
    sSpName = "insert_schedule_lesson"
    InsertQuadDataToDB clsAppRuntime, sSpName, bHeaderFlag:=True, vRows:=vRows, vColumns:=vColumns
                               
End Sub
Public Function AddScheduleLesson(Optional eQuadDataSubType As QuadSubDataType = QuadSubDataType.Lesson) As Range
Dim dEntryValues As Dictionary
Dim sFormatRangeName As String, sTableName As String, sFormName As String
Dim clsAppRuntime As New App_Runtime
Dim iPersonID As Integer
Dim wsTable As Worksheet

    'probably need to take the view schedule student component out of the add schedule lesson  function
    'as Data model is different
    
    'and cache the existing schedule student table
    
    'then add the new row to that too
    
    'then draw / update the schedule from their
    
    clsAppRuntime.InitProperties bInitializeCache:=False
    
    sFormName = GetFormName(FormType.Add, WorksheetFunction.Proper(EnumQuadDataType(QuadDataType.Schedule)), _
                WorksheetFunction.Proper(EnumQuadSubDataType(eQuadDataSubType)))
    'sFormatRangeName = "f" & "student" & "ScheduleCell"
    Set dEntryValues = GetRecordValuesAsDict(clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, sFormName)
    'iPersonID = CrossRefQuadData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, "sStudentFirstNm", dEntryValues.Item("sStudentFirstNm"), "idStudent")
    'Set AddLesson = AddAddLesson(clsAppRuntime, dEntryValues, sFormatRangeName, dEntryValues.Item("idStudent"))
    
    sTableName = "schedule_" & EnumQuadSubDataType(eQuadDataSubType)
    
    ' if Table does not exist
    If SheetExists(clsAppRuntime.CacheBook, sTableName) = False Then
        Set wsTable = CreateTable(sTableName, wbTmp:=clsAppRuntime.CacheBook)
    Else
        Set wsTable = GetSheet(clsAppRuntime.CacheBook, sTableName)
    End If
    
    AddTableRecordFromDict wsTable, sTableName, dEntryValues
    
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
