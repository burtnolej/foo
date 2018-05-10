Attribute VB_Name = "App_Schedule_Add"
Option Explicit
Const C_MODULE_NAME = "App_Schedule_Add"

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
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties bInitializeCache:=False

    Set Form_Utils.dDefinitions = LoadDefinitions(clsQuadRuntime.TemplateBook.Sheets("Definitions"), _
                rSource:=clsQuadRuntime.TemplateBook.Sheets("Definitions").Range("Definitions"))
                
    Set wsCache = GetScheduleData(clsQuadRuntime, iPersonID, QuadDataType.schedule, eQuadSubDataType, bInTable:=True)
        
    vPeriodIds = GetColumnValues(clsQuadRuntime, QuadDataType.schedule, QuadSubDataType.Student, _
                "idTimePeriod", iPersonID:=iPersonID)
    vTmp = IndexArrayMulti(vPeriodIds, CStr(iPeriodID))
    vDayCds = GetColumnValues(clsQuadRuntime, QuadDataType.schedule, QuadSubDataType.Student, _
                    "cdDay", iPersonID:=iPersonID)

    iIndex = IndexArray(vDayCds, sDayCd, vWhere:=vTmp)
    dDefaultValues.Add "AddLesson", Row2Dict(wsCache, clsQuadRuntime.CacheRangeName, iIndex + 1)

    GenerateForms clsQuadRuntime, sFormName:="AddLesson", dDefaultValues:=dDefaultValues, _
        bSetAsValid:=True

End Sub
Public Function AddLesson() As Range
Dim dEntryValues As Dictionary
Dim sFormatRangeName As String
Dim clsQuadRuntime As New Quad_Runtime
Dim iPersonID As Integer

    clsQuadRuntime.InitProperties bInitializeCache:=False
    sFormatRangeName = "f" & "student" & "ScheduleCell"
    Set dEntryValues = GetRecordValuesAsDict(clsQuadRuntime.TemplateBook, clsQuadRuntime.AddBook, "AddLesson")
    iPersonID = CrossRefQuadData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, "sStudentFirstNm", dEntryValues.Item("sStudentFirstNm"), "idStudent")
    Set AddLesson = AddAddLesson(clsQuadRuntime, dEntryValues, sFormatRangeName, iPersonID)
    
End Function
        
Function AddAddLesson(clsQuadRuntime As Quad_Runtime, _
                dValues As Dictionary, sTemplateRangeName As String, _
                iStudentID As Integer, _
                Optional eQuadDataSubType As QuadSubDataType = QuadSubDataType.Student) As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer
Dim aColumnWidths() As Integer
Dim sSheetName As String, sTableName As String, sTemplateRowRangeName As String, sTemplateColRangeName As String
Dim wsSchedule As Worksheet, wsTable As Worksheet
Dim rTemplateSource As Range
    
    clsQuadRuntime.ScheduleBook.Windows(1).Visible = False
    
    sSheetName = "view_" & EnumQuadSubDataType(eQuadDataSubType) & "_" & CStr(iStudentID)
    If SheetExists(clsQuadRuntime.ScheduleBook, sSheetName) = False Then
        Set wsSchedule = CreateSheet(clsQuadRuntime.ScheduleBook, sSheetName)
        
        ' draw headers
        sTemplateRowRangeName = "f" & "student" & "ScheduleRowLabel"
        GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRowRangeName
        BuildScheduleHeaderView clsQuadRuntime, wsSchedule, clsQuadRuntime.PeriodEnum, iFormatWidth, iFormatHeight
    
        sTemplateColRangeName = "f" & "student" & "ScheduleColLabel"
        GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateColRangeName
        BuildScheduleHeaderView clsQuadRuntime, wsSchedule, clsQuadRuntime.DayEnum, iFormatWidth, iFormatHeight, iStartCol:=4, iStartRow:=2, bVz:=False

    Else
        Set wsSchedule = GetSheet(clsQuadRuntime.ScheduleBook, sSheetName)
    End If
    
    sTableName = "schedule_" & EnumQuadSubDataType(eQuadDataSubType)
    
    ' if Table does not exist
    If SheetExists(clsQuadRuntime.CacheBook, sTableName) = False Then
        Set wsTable = CreateTable(sTableName, wbTmp:=clsQuadRuntime.CacheBook)
    Else
        Set wsTable = GetSheet(clsQuadRuntime.CacheBook, sTableName)
    End If
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsQuadRuntime, sTemplateRangeName, iColWidthCount)
        
    Set AddAddLesson = BuildScheduleCellView(clsQuadRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths)

    AddTableRecordFromDict wsTable, sTableName, dValues
    
    clsQuadRuntime.ScheduleBook.Windows(1).Visible = True
End Function
Public Sub GenerateScheduleAdd(clsQuadRuntime As Quad_Runtime)

Dim sFuncName As String, sSheetName As String
Dim sDefn As String
Dim vSource() As String
'Dim vStudents() As String, vTeachers() As String, vLessons() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
'Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult

setup:
    
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleAdd"
    sSheetName = "test"
    'clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)

    ''sDefn = "AddLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^SLastName^String^IsMember^&get_person_student^sStudentLastNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^TFirstName^String^IsMember^&get_person_teacher^sFacultyFirstNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^TLastName^String^IsMember^&get_person_teacher^sFacultyLastNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^CourseName^String^IsMember^&get_courses_course^sCourseNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^SubjectName^String^IsMember^&get_courses_subject^sSubjectLongDesc" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^sPrepNm^String^IsMember^&get_misc_prep^sPrepNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod" & DOUBLEDOLLAR
    ''sDefn = sDefn & "AddLesson^Lesson^cdDay^String^IsMember^&get_misc_day^cdDay" & DOUBLEDOLLAR
    
    
    ' table: Add lesson
    ' --------------------------------------------------------------------------------
    ' attr : student name
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^schedule_student^sStudentLastNm^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
    ' attr : teacher_name
    sDefn = sDefn & "AddLesson^schedule_student^sFacultyFirstNm^String^IsMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^schedule_student^sFacultyLastNm^String^IsMember^&get_person_teacher^sFacultyLastNm^^Entry" & DOUBLEDOLLAR
    ' attr : ref data
    sDefn = sDefn & "AddLesson^schedule_student^sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^schedule_student^sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^schedule_student^idPrep^Integer^IsMember^&get_misc_prep^sPrepNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^schedule_student^idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^schedule_student^cdDay^Integer^IsMember^&get_misc_day^cdDay^^Entry" & DOUBLEDOLLAR
    
    ' Add student
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
    ' Add teacher
    sDefn = sDefn & "AddStudent^person_teacher^sFacultyFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_teacher^sFacultyLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_teacher^idFaculty^Integer^^^^^Entry" & DOUBLEDOLLAR
    ' table: Add subject ---------------------------------------------------------------
    sDefn = sDefn & "AddSubject^courses_subject^sSubjectLongDesc^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddSubject^courses_subject^idSubject^String^^^^^Entry" & DOUBLEDOLLAR
    ' table: Add course ---------------------------------------------------------------
    sDefn = sDefn & "AddCourse^courses_course^sCourseNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddCourse^courses_course^idCourse^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddCourse^courses_course^idSubject^String^^^^^Entry" & DOUBLEDOLLAR
    ' table: Add timeperiod ---------------------------------------------------------------
    sDefn = sDefn & "AddTimePeriod^misc_timeperiod^idTimePeriod^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTimePeriod^misc_timeperiod^dtPeriodStart^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTimePeriod^misc_timeperiod^dtPeriodEnd^String^^^^^Entry" & DOUBLEDOLLAR
    ' table: Add prep ---------------------------------------------------------------
    sDefn = sDefn & "AddPrep^misc_prep^idPrep^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddPrep^misc_prep^sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
    ' table: Add day ---------------------------------------------------------------
    sDefn = sDefn & "AddDay^misc_day^idDay^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddDay^misc_day^sDayDesc^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddDay^misc_day^cdDay^String^^^^^Entry" & DOUBLEDOLLAR
    ' button: Add lesson ---------------------------------------------------------------
    sDefn = sDefn & "AddLesson^^COMMIT^^^AddLesson^^^Button"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateForms clsQuadRuntime, bLoadRefData:=True
    
End Sub
