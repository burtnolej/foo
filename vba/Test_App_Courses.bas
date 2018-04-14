Attribute VB_Name = "Test_App_Courses"
'Test_GetCoursesCourse
'Test_GetCoursesSubject
Option Explicit
Const CsModuleName = "Test_App_Courses"


Public Function Test_GetCoursesSubject() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "Test_GetCoursesSubject"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new subject ---------------------------------------------------------------
    sDefn = "NewSubject^courses_subject^Name^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewSubject^courses_subject^ID^String^^^"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "courses_subject"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Public Function Test_GetCoursesCourse() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "GetCourseCourse"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new course ---------------------------------------------------------------
    sDefn = "NewCourse^courses_course^Name^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewCourse^courses_course^ID^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewCourse^courses_course^SubjectID^String^^^"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "courses_course"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Public Function Test_GetMiscTimePeriod() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "GetMiscTimePeriod"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new timeperiod ---------------------------------------------------------------
    sDefn = "NewTimePeriod^misc_timeperiod^ID^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTimePeriod^misc_timeperiod^PeriodStart^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewCourse^misc_timeperiod^SubjectID^PeriodEnd^^^"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
main:
    Set wsCache = get_misc_timeperiod(clsQuadRuntime)
    If wsCache.Range("dbmisc_timeperiodPeriodStart").Rows(7) <> "11:36" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetMiscTimePeriod = eTestResult
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "misc_timeperiod"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Public Function Test_GetMiscPrep() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "GetMiscPrep"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new prep ---------------------------------------------------------------
    sDefn = "NewPrep^misc_prep^ID^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewPrep^misc_prep^Name^String^^^"

    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "misc_prep"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Public Function Test_GetMiscDay() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wsCache As Worksheet
Dim sFuncName As String, sSheetName As String, sDefn As String
Dim vSource() As String
Dim rTarget As Range

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "GetDay"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)

    ' table: new day ---------------------------------------------------------------
    sDefn = "NewDay^misc_day^ID^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewDay^misc_day^LongDay^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewDay^misc_day^ShortDay^String^^^"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsCache, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsCache, rSource:=rTarget)
    
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "misc_day"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function
