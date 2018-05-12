Attribute VB_Name = "Test_App_Courses"
'Test_GetCoursesCourse
'Test_GetCoursesSubject
Option Explicit
Const C_MODULE_NAME = "Test_App_Courses"


Public Function Test_GetCoursesSubject() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_GetCoursesSubject"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new subject ---------------------------------------------------------------
    sDefn = "AddSubject^courses_subject^Name^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddSubject^courses_subject^ID^String^^^^^Entry"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
main:
    Set wsCache = get_courses_subject(clsQuadRuntime)
    If wsCache.Range("dbcourses_subjectName").Rows(17) <> "Specials" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetCoursesSubject = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, "courses_subject"
    clsQuadRuntime.Delete

End Function

Public Function Test_GetCoursesCourse() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "GetCourseCourse"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new course ---------------------------------------------------------------
    sDefn = "AddCourse^courses_course^Name^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddCourse^courses_course^ID^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddCourse^courses_course^SubjectID^String^^^^^Entry"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
main:
    Set wsCache = get_courses_course(clsQuadRuntime)
    If wsCache.Range("dbcourses_courseName").Rows(13) <> "Physics" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetCoursesCourse = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, "courses_course"
    clsQuadRuntime.Delete

End Function

Public Function Test_GetMiscTimePeriod() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "GetMiscTimePeriod"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: Add timeperiod ---------------------------------------------------------------
    sDefn = "AddTimePeriod^misc_timeperiod^ID^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTimePeriod^misc_timeperiod^PeriodStart^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddCourse^misc_timeperiod^SubjectID^PeriodEnd^^^^^Entry"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
main:
    Set wsCache = get_misc_timeperiod(clsQuadRuntime)
    If Format(wsCache.Range("dbmisc_timeperiodPeriodStart").Rows(7), "h:mm") <> "11:36" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetMiscTimePeriod = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, "misc_timeperiod"
    clsQuadRuntime.Delete

End Function

Public Function Test_GetMiscPrep() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "GetMiscPrep"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: Add prep ---------------------------------------------------------------
    sDefn = "AddPrep^misc_prep^ID^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddPrep^misc_prep^Name^String^^^^^Entry"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
main:
    Set wsCache = get_misc_prep(clsQuadRuntime)
    If wsCache.Range("dbmisc_prepName").Rows(5) <> "Pulsar" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetMiscPrep = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, "misc_prep"
    clsQuadRuntime.Delete

End Function

Public Function Test_GetMiscDay() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New App_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "GetDay"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: Add day ---------------------------------------------------------------
    sDefn = "AddDay^misc_day^ID^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddDay^misc_day^LongDay^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddDay^misc_day^ShortDay^String^^^^^Entry"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
main:
    Set wsCache = get_misc_day(clsQuadRuntime)
    If wsCache.Range("dbmisc_dayLongDay").Rows(6) <> "Friday" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetMiscDay = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, "misc_day"
    clsQuadRuntime.Delete

End Function
