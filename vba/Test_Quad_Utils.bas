Attribute VB_Name = "Test_Quad_Utils"
Option Explicit
'Function TestSheetTableLookup()
'Function TestRowAsDict()

Const C_MODULE_NAME = "Test_Quad_Utils"
Public Function Test_CrossRefQuadData() As TestResult
Dim clsAppRuntime As New App_Runtime
Dim vSource() As String
Dim sDefn As String, sDefnSheetName As String
Dim rTarget As Range
Dim wsTmp As Worksheet
Dim eTestResult As TestResult

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True

    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsAppRuntime.Book, sDefnSheetName, bOverwrite:=True)
        
    sDefn = "Add_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode^^^Entry"
           
    vSource = Init2DStringArrayFromString(sDefn)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    If CrossRefQuadData(clsAppRuntime, QuadDataType.person, _
                    QuadSubDataType.Student, "idStudent", 1, "sStudentLastNm") <> "Gromek" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
        
    eTestResult = TestResult.OK
    GoTo teardown

                                 
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CrossRefQuadData = eTestResult
    clsAppRuntime.Delete
    
End Function
Public Function Test_CacheData_Table() As TestResult
'"" cache data but wrap in a table
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String, sDefnSheetName As String, sDefn As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aPersonData() As Variant, vSource() As String
Dim clsAppRuntime As New App_Runtime
Dim wsTmp As Worksheet
Dim rTarget As Range

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsAppRuntime.Book, sDefnSheetName, bOverwrite:=True)
    
    'sDefn = "AddLesson^Lesson^sSubjectLongDesc^AlphaNumeric^IsMember^Subject" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^sCourseNm^AlphaNumeric^IsMember^Course" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^sClassFocusArea^AlphaNumeric^IsMember^Course" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^sFacultyFirstNm^AlphaNumeric^IsMember^Faculty" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^cdDay^AlphaNumeric^IsMember^DayCode" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^idTimePeriod^AlphaNumeric^IsMember^ClassLecture" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^idLocation^AlphaNumeric^IsMember^ClassLecture" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^idSection^AlphaNumeric^IsMember^ClassLecture" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^cdClassType^AlphaNumeric^IsMember^ClassTypeCode" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^iFreq^AlphaNumeric^IsMember^Section" & DOUBLEDOLLAR
    'sDefn = sDefn & "AddLesson^Lesson^idClassLecture^AlphaNumeric^IsMember^ClassLecture"
    
    sDefn = "Add_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode^^^Entry"
           
    vSource = Init2DStringArrayFromString(sDefn)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    aPersonData = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsAppRuntime, aPersonData, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)
        
    With clsAppRuntime.CacheBook.Sheets(sCacheSheetName)
        If .Range(.Cells(83, 2), .Cells(83, 2)).value <> "Tzvi" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        Else
            eTestResult = TestResult.OK
        End If
    End With
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CacheData_Table = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, sCacheSheetName
    clsAppRuntime.Delete
    
End Function


Function TestGetAndInitAppRuntimeNoVals() As TestResult
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetAndInitAppRuntimeNoVals"
    
    Set clsAppRuntime = GetAppRuntimeGlobal(bInitFlag:=True)
    
    If clsAppRuntime.DayEnum <> "M,T,W,R,F" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitAppRuntimeNoVals = eTestResult
    clsAppRuntime.Delete
    ResetAppRuntimeGlobal

End Function
Function TestGetAndInitAppRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "TestGetAndInitAppRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsAppRuntime = GetAppRuntimeGlobal(bInitFlag:=True, dAppRuntimeValues:=dValues)
    
    If clsAppRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitAppRuntime = eTestResult
    clsAppRuntime.Delete
    ResetAppRuntimeGlobal

End Function
Function TestInitAppRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "InitAppRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsAppRuntime = InitAppRuntimeGlobal(dAppRuntimeValues:=dValues)
    
    If clsAppRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestInitAppRuntime = eTestResult
    clsAppRuntime.Delete
    ResetAppRuntimeGlobal

End Function

