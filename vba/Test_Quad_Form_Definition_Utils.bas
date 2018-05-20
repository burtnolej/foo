Attribute VB_Name = "Test_Quad_Form_Definition_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_Quad_Form_Definitions_Utils"

Public Function Test_GetDefinitionPersonStudent() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sDefn As String, sExpectedResult As String
Dim eFormType As FormType
Dim sSubDataType As String, sDataType As String

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    DoLoadDefinitions clsAppRuntime
    eFormType = FormType.Add
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Student)
    sDataType = EnumQuadDataType(QuadDataType.Person)
    
    sExpectedResult = "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry$$AddStudent^person_student^sStudentLastNm^String^^^^^Entry$$AddStudent^person_student^idStudent^Integer^^^^^Entry$$AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry$$AddStudent^person_student^sPrepNm^String^^^^^Entry"
main:

    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Person), EnumQuadSubDataType(QuadSubDataType.Student))
    
    If sDefn <> sExpectedResult Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetDefinitionPersonStudent = eTestResult
    clsAppRuntime.Delete
End Function


Public Function Test_GetDefinitionLesson() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sDefn As String, sExpectedResult As String
Dim eFormType As FormType
Dim sSubDataType As String, sDataType As String

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    DoLoadDefinitions clsAppRuntime
    eFormType = FormType.Add
    sSubDataType = EnumQuadSubDataType(QuadSubDataType.Student)
    sDataType = EnumQuadDataType(QuadDataType.Person)
    
    sExpectedResult = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^sStudentLastNm^String^IsMember^&get_person_student^sStudentLastNm^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^sFacultyFirstNm^String^IsMember^&get_person_teacher^sFacultyFirstNm^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^sFacultyLastNm^String^IsMember^&get_person_teacher^sFacultyLastNm^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^idPrep^Integer^IsMember^&get_misc_prep^sPrepNm^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^schedule_student^cdDay^Integer^IsMember^&get_misc_day^cdDay^^Entry$$"
    sExpectedResult = sExpectedResult & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddStudent^person_student^idStudent^Integer^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddStudent^person_student^sPrepNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddTeacher^person_teacher^sFacultyFirstNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddTeacher^person_teacher^sFacultyLastNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddTeacher^person_teacher^idFaculty^Integer^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddCourse^courses_course^sCourseNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddCourse^courses_course^idCourse^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddCourse^courses_course^idSubject^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddSubject^courses_subject^sSubjectLongDesc^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddSubject^courses_subject^idSubject^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddTimeperiod^misc_timeperiod^idTimePeriod^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddTimeperiod^misc_timeperiod^dtPeriodStart^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddTimeperiod^misc_timeperiod^dtPeriodEnd^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddPrep^misc_prep^idPrep^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddPrep^misc_prep^sPrepNm^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddDay^misc_day^idDay^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddDay^misc_day^sDayDesc^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddDay^misc_day^cdDay^String^^^^^Entry$$"
    sExpectedResult = sExpectedResult & "AddLesson^^COMMIT^^^AddLesson^^^Button"


main:

    sDefn = ExecDefinitionFunc(FormType.Add, EnumQuadDataType(QuadDataType.Schedule), EnumQuadSubDataType(QuadSubDataType.Lesson))
    
    If sDefn <> sExpectedResult Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetDefinitionLesson = eTestResult
    clsAppRuntime.Delete
End Function



