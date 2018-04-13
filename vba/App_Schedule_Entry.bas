Attribute VB_Name = "App_Schedule_Entry"
Option Explicit
Const CsModuleName = "App_Schedule_Entry"

Function AddNewLesson(clsQuadRuntime As Quad_Runtime, dValues As Dictionary, sTemplateRangeName As String, _
                iStudentID As Integer, _
                Optional eQuadDataSubType As QuadSubDataType = QuadSubDataType.student) As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer
Dim aColumnWidths() As Integer
Dim sSheetName As String, sTableName As String
Dim wsSchedule As Worksheet, wsTable As Worksheet

    sSheetName = "view_" & EnumQuadSubDataType(eQuadDataSubType) & "_" & CStr(iStudentID)
    Set wsSchedule = CreateSheet(clsQuadRuntime.CacheBook, sSheetName)

    sTableName = "schedule_" & EnumQuadSubDataType(eQuadDataSubType)
    
    ' if Table does not exist
    Set wsTable = CreateTable(sTableName)
    'Set wsTable = clsQuadRuntime.CacheBook.Sheets(sTableName)
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsQuadRuntime, sTemplateRangeName, iColWidthCount)
        
    Set AddNewLesson = BuildScheduleCellView(clsQuadRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths)

    AddTableRecordFromDict wsTable, sTableName, dValues
End Function
Public Sub GenerateScheduleEntry(clsQuadRuntime As Quad_Runtime)
Dim sFuncName As String, sSheetName As String
Dim sDefn As String
Dim vSource() As String
'Dim vStudents() As String, vTeachers() As String, vLessons() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
'Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult

setup:
    
    sFuncName = CsModuleName & "." & "GenerateScheduleEntry"
    sSheetName = "test"
    'clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ''sDefn = "NewLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^SLastName^String^IsMember^&get_person_student^sStudentLastNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^TFirstName^String^IsMember^&get_person_teacher^sFacultyFirstNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^TLastName^String^IsMember^&get_person_teacher^sFacultyLastNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^CourseName^String^IsMember^&get_courses_course^sCourseNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^SubjectName^String^IsMember^&get_courses_subject^sSubjectLongDesc" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^sPrepNm^String^IsMember^&get_misc_prep^sPrepNm" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod" & DOUBLEDOLLAR
    ''sDefn = sDefn & "NewLesson^Lesson^cdDay^String^IsMember^&get_misc_day^cdDay" & DOUBLEDOLLAR
    
    
    ' table: new lesson
    ' --------------------------------------------------------------------------------
    ' attr : student name
    sDefn = "NewLesson^schedule_student^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^schedule_student^sStudentLastNm^String^IsMember^&get_person_student^sStudentLastNm" & DOUBLEDOLLAR
    ' attr : teacher_name
    sDefn = sDefn & "NewLesson^schedule_student^sFacultyFirstNm^String^IsMember^&get_person_teacher^sFacultyFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^schedule_student^sFacultyLastNm^String^IsMember^&get_person_teacher^sFacultyLastNm" & DOUBLEDOLLAR
    ' attr : ref data
    sDefn = sDefn & "NewLesson^schedule_student^sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^schedule_student^sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^schedule_student^idPrep^Integer^IsMember^&get_misc_prep^sPrepNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^schedule_student^idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^schedule_student^cdDay^Integer^IsMember^&get_misc_day^cdDay" & DOUBLEDOLLAR
    
    ' new student
    sDefn = sDefn & "NewStudent^person_student^sStudentFirstNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentLastNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idStudent^Integer^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idPrep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sPrepNm^String^^^" & DOUBLEDOLLAR
    ' new teacher
    sDefn = sDefn & "NewStudent^person_teacher^sFacultyFirstNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_teacher^sFacultyLastNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_teacher^idFaculty^Integer^^^" & DOUBLEDOLLAR
    ' table: new subject ---------------------------------------------------------------
    sDefn = sDefn & "NewSubject^courses_subject^sSubjectLongDesc^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewSubject^courses_subject^idSubject^String^^^" & DOUBLEDOLLAR
    ' table: new course ---------------------------------------------------------------
    sDefn = sDefn & "NewCourse^courses_course^sCourseNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewCourse^courses_course^idCourse^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewCourse^courses_course^idSubject^String^^^" & DOUBLEDOLLAR
    ' table: new timeperiod ---------------------------------------------------------------
    sDefn = sDefn & "NewTimePeriod^misc_timeperiod^idTimePeriod^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTimePeriod^misc_timeperiod^dtPeriodStart^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTimePeriod^misc_timeperiod^dtPeriodEnd^String^^^" & DOUBLEDOLLAR
    ' table: new prep ---------------------------------------------------------------
    sDefn = sDefn & "NewPrep^misc_prep^idPrep^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewPrep^misc_prep^sPrepNm^String^^^" & DOUBLEDOLLAR
    ' table: new day ---------------------------------------------------------------
    sDefn = sDefn & "NewDay^misc_day^idDay^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewDay^misc_day^sDayDesc^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewDay^misc_day^cdDay^String^^^"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateEntryForms clsQuadRuntime, bLoadRefData:=True
    
End Sub
