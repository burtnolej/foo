Attribute VB_Name = "App_Schedule_Entry"
Option Explicit
Const CsModuleName = "App_Schedule_Entry"

Function AddNewLesson()
' add new record to table draw on schedule
' takes a dict with following fields
'vKeys = Split("sSubjectLongDesc,sCourseNm,sClassFocusArea,sFacultyFirstNm,cdDay,idTimePeriod,idLocation,idSection,cdClassType,iFreq,idClassLecture", COMMA)
'vValues = Split("Homeroom,Homeroom,None,Isaac,M,1,9,165,Seminar,5,993", COMMA)
    
    BuildScheduleCellView clsQuadRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths

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

    ' table: new lesson
    ' --------------------------------------------------------------------------------
    ' attr : student name
    sDefn = "NewLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^SLastName^String^IsMember^&get_person_student^sStudentLastNm" & DOUBLEDOLLAR
    ' attr : teacher_name
    sDefn = sDefn & "NewLesson^Lesson^TFirstName^String^IsMember^&get_person_teacher^sFacultyFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^TLastName^String^IsMember^&get_person_teacher^sFacultyLastNm" & DOUBLEDOLLAR
    ' attr : ref data
    sDefn = sDefn & "NewLesson^Lesson^CourseName^Integer^IsMember^&get_courses_course^sCourseNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^SubjectName^Integer^IsMember^&get_courses_subject^sSubjectLongDesc" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^Prep^Integer^IsMember^&get_misc_prep^sPrepNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^TimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^Day^Integer^IsMember^&get_misc_day^cdDay" & DOUBLEDOLLAR
    
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
