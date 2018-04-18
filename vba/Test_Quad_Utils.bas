Attribute VB_Name = "Test_Quad_Utils"
Option Explicit
'Function TestSheetTableLookup()
'Function TestRowAsDict()

Const CsModuleName = "Test_Quad_Utils"
Public Function Test_CrossRefQuadData() As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim vSource() As String
Dim sDefn As String, sDefnSheetName As String
Dim rTarget As Range
Dim wsTmp As Worksheet
Dim eTestResult As TestResult

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True

    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sDefnSheetName, bOverwrite:=True)
        
    sDefn = "new_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode"
           
    vSource = Init2DStringArrayFromString(sDefn)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    If CrossRefQuadData(clsQuadRuntime, QuadDataType.person, _
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
    clsQuadRuntime.Delete
    'DeleteSheet clsQuadRuntime.CacheBook, sCacheSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
End Function
Public Function Test_CacheData_Table() As TestResult
'"" cache data but wrap in a table
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String, sDefnSheetName As String, sDefn As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aPersonData() As String, vSource() As String
Dim clsQuadRuntime As New Quad_Runtime
Dim wsTmp As Worksheet
Dim rTarget As Range

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sDefnSheetName = "test_definition"
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sDefnSheetName, bOverwrite:=True)
    
    'sDefn = "NewLesson^Lesson^sSubjectLongDesc^AlphaNumeric^IsMember^Subject" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^sCourseNm^AlphaNumeric^IsMember^Course" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^sClassFocusArea^AlphaNumeric^IsMember^Course" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^sFacultyFirstNm^AlphaNumeric^IsMember^Faculty" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^cdDay^AlphaNumeric^IsMember^DayCode" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^idTimePeriod^AlphaNumeric^IsMember^ClassLecture" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^idLocation^AlphaNumeric^IsMember^ClassLecture" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^idSection^AlphaNumeric^IsMember^ClassLecture" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^cdClassType^AlphaNumeric^IsMember^ClassTypeCode" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^iFreq^AlphaNumeric^IsMember^Section" & DOUBLEDOLLAR
    'sDefn = sDefn & "NewLesson^Lesson^idClassLecture^AlphaNumeric^IsMember^ClassLecture"
    
    sDefn = "new_person_student^person_student^sStudentFirstNm^AlphaNumeric^IsMember^Student" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^sStudentLastNm^AlphaNumeric^IsMember^Student" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^idStudent^AlphaNumeric^IsMember^Student" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^idPrep^AlphaNumeric^IsMember^StudentLevel" & DOUBLEDOLLAR
    sDefn = sDefn & "new_person_student^person_student^sPrepNm^AlphaNumeric^IsMember^PrepCode"
           
    vSource = Init2DStringArrayFromString(sDefn)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    GetPersonDataFromDB clsQuadRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    aPersonData = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsQuadRuntime, aPersonData, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)
        
    With clsQuadRuntime.CacheBook.Sheets(sCacheSheetName)
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, sCacheSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function


Function TestGetAndInitQuadRuntimeNoVals() As TestResult
Dim clsQuadRuntime As Quad_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & "." & "GetAndInitQuadRuntimeNoVals"
    
    Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True)
    
    If clsQuadRuntime.DayEnum <> "M,T,W,R,F" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitQuadRuntimeNoVals = eTestResult
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    ResetQuadRuntimeGlobal

End Function
Function TestGetAndInitQuadRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsQuadRuntime As Quad_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & "." & "TestGetAndInitQuadRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True, dQuadRuntimeValues:=dValues)
    
    If clsQuadRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitQuadRuntime = eTestResult
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    ResetQuadRuntimeGlobal

End Function
Function TestInitQuadRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsQuadRuntime As Quad_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & "." & "InitQuadRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsQuadRuntime = InitQuadRuntimeGlobal(dQuadRuntimeValues:=dValues)
    
    If clsQuadRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestInitQuadRuntime = eTestResult
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    ResetQuadRuntimeGlobal

End Function
Function TestSheetTableLookup() As TestResult

Dim sInputStr As String, sRangeName As String, sFuncName As String, sSheetName As String
Dim iChunkLen As Integer
Dim vSource() As String
Dim eTestResult As TestResult
Dim wsTmp As Worksheet
Dim rTarget As Range

setup:
    sFuncName = CsModuleName & "." & "SheetTableLookup"
    sSheetName = "test"
    sRangeName = "data"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A", "B", "C";"a1","a2","a3";"b1","b2","b3"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRange ActiveWorkbook, rTarget.Address, sSheetName, sRangeName, "True"
    
main:

    If SheetTableLookup(wsTmp, sRangeName, "B", "b2") <> 3 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    TestSheetTableLookup = eTestResult
End Function
Function TestRowAsDict() As TestResult

Dim sInputStr As String, sRangeName As String, sFuncName As String, sSheetName As String
Dim iChunkLen As Integer
Dim vSource() As String
Dim eTestResult As TestResult
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dResult As New Dictionary

setup:
    sFuncName = CsModuleName & "." & "TestRowAsDict"
    sSheetName = "test"
    sRangeName = "data"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A", "B", "C";"a1","a2","a3";"b1","b2","b3"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRange ActiveWorkbook, rTarget.Address, sSheetName, sRangeName, "True"
    
main:

    Set dResult = Row2Dict(wsTmp, sRangeName, 3)
    
    If dResult.Count <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    ElseIf dResult.Item("C") <> "b3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    TestRowAsDict = eTestResult
End Function
