Attribute VB_Name = "App_Schedule_Entry"
Option Explicit

Function DoGenerateScheduleEntry() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim sDefn As String
Dim vSource() As String, vStudents() As String, vTeachers() As String, vLessons() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    ResetQuadRuntimeGlobal
    
    sFuncName = CsModuleName & "." & "DoGenerateScheduleEntry"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "NewLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new lesson
    ' --------------------------------------------------------------------------------
    ' attr : student name
    sDefn = "NewLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^SLastName^String^IsMember^&get_person_student^sStudentLastNm" & DOUBLEDOLLAR
    ' attr : teacher_name
    sDefn = sDefn & "NewLesson^Lesson^TFirstName^String^IsMember^&get_person_teacher^sFacultyFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^TLastName^String^IsMember^&get_person_teacher^sFacultyLastNm" & DOUBLEDOLLAR
         
    ' attr : prep
    sDefn = sDefn & "NewLesson^Lesson^Prep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    
    ' new student
    sDefn = sDefn & "NewStudent^person_student^sStudentFirstNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentLastNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idStudent^Integer^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idPrep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sPrepNm^String^^^"
    
    ' new teacher
    sDefn = sDefn & "NewStudent^person_student^sFacultyFirstNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sFacultyLastNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idFaculty^Integer^^^" & DOUBLEDOLLAR
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateEntryForms clsQuadRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    
End Function
