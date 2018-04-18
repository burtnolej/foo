Attribute VB_Name = "App_Schedule_Entry"
Option Explicit
Const CsModuleName = "App_Schedule_Entry"

Public Function NewLesson() As Range
Dim dEntryValues As Dictionary
Dim sFormatRangeName As String
Dim clsQuadRuntime As New Quad_Runtime
Dim iPersonID As Integer

    clsQuadRuntime.InitProperties bInitializeCache:=False
    sFormatRangeName = "f" & "student" & "ScheduleCell"
    Set dEntryValues = GetRecordValuesAsDict(clsQuadRuntime.TemplateBook, clsQuadRuntime.CacheBook, "NewLesson")
    iPersonID = CrossRefQuadData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, "sStudentFirstNm", dEntryValues.Item("sStudentFirstNm"), "idStudent")
    Set NewLesson = AddNewLesson(clsQuadRuntime, dEntryValues, sFormatRangeName, iPersonID)
    
End Function
        
Function AddNewLesson(clsQuadRuntime As Quad_Runtime, _
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
    'Set wsTable = clsQuadRuntime.CacheBook.Sheets(sTableName)
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsQuadRuntime, sTemplateRangeName, iColWidthCount)
        
    Set AddNewLesson = BuildScheduleCellView(clsQuadRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths)

    AddTableRecordFromDict wsTable, sTableName, dValues
    
    clsQuadRuntime.ScheduleBook.Windows(1).Visible = True
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
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)

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
    sDefn = "NewLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
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
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateEntryForms clsQuadRuntime, bLoadRefData:=True
    
End Sub
