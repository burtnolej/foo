Attribute VB_Name = "Test_Entry_Utils"
Const CsModuleName = "Test_Entry_Utils"

Function TestGenerateEntryFormsLoadRefDataFromDBMultipleRefs() As TestResult
' uses both student and teacher reference tables
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
    
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "NewLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    ' table: new lesson ---------------------------------------------------------------
    ' attr : student name
    sDefn = "NewLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^SLastName^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
    ' attr : teacher_name
    sDefn = sDefn & "NewLesson^Lesson^TFirstName^String^IsMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^TLastName^String^IsMember^&get_person_teacher^sFacultyLastNm^^Entry" & DOUBLEDOLLAR
    ' attr : prep
    sDefn = sDefn & "NewLesson^Lesson^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    ' table: new student ---------------------------------------------------------------
    sDefn = sDefn & "NewStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
    ' table: new teacher ---------------------------------------------------------------
    sDefn = sDefn & "NewTeacher^person_teacher^sFacultyFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^sFacultyLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^idFaculty^Integer^^^^^Entry"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)


main:
    GenerateEntryForms clsQuadRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Entry_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
    'With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "David"
        Validate ActiveWorkbook, sTargetSheetName, rTarget
        'Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "Stone"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate ActiveWorkbook, sTargetSheetName, rTarget
        'Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        eTestResult = TestResult.OK
        GoTo teardown
        
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateEntryFormsLoadRefDataFromDBMultipleRefs = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function TestGenerateEntryFormsLoadRefDataFromDB() As TestResult
' uses a db ref table; invoked using the & prefix
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
    
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "NewLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    sDefn = "NewLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^LastName^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sPrepNm^String^^^^^Entry"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateEntryForms clsQuadRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Entry_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate ActiveWorkbook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Raskin"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "4"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        Else
            eTestResult = TestResult.OK
            GoTo teardown
        End If
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateEntryFormsLoadRefDataFromDB = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
    
End Function
Function TestGenerateEntryFormsIsMember() As TestResult
' 1 entry form but record that requires IsMember validation
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
    clsQuadRuntime.InitProperties bInitializeCache:=True
        
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sSheetName = "test"
    sTargetSheetName = "NewLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    sDefn = "NewStudent^person_student^Name^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^Age^Integer^IsInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^Name^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^Age^Integer^IsInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^StudentName^String^IsMember^person_student^Name^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^TeacherName^String^IsMember^person_teacher^Name^^Entry"
    vSource = Init2DStringArrayFromString(sDefn)
    
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Jon^45^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Quinton^6^2"
    vStudents = Init2DStringArrayFromString(sDefn)
    sCacheSheetName = CacheData(clsQuadRuntime, vStudents, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Nancy^46^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Betty^36^2"
    vTeachers = Init2DStringArrayFromString(sDefn)
    sCacheSheetName = CacheData(clsQuadRuntime, vTeachers, QuadDataType.person, QuadSubDataType.teacher, bInTable:=True)
    
main:

    GenerateEntryForms clsQuadRuntime, bLoadRefData:=False
    
    EventsToggle True
    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Jon"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Betty"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateEntryFormsIsMember = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function TestGenerateEntryForms() As TestResult
' 1 entry form
' test if cell validation works
' test if form validation works
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sTargetSheetName = "NewStudent"
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewStudent","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)

main:

    GenerateEntryForms clsQuadRuntime
    
    If SheetExists(clsQuadRuntime.EntryBook, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.EntryBook, "NewStudent", clsQuadRuntime.TemplateCellSheetName
        
        ' no buttons implemented so need to hardcode where the button will be on the screen
        If GetBgColor(sTargetSheetName, clsQuadRuntime.EntryBook.Sheets(sTargetSheetName).Range("H2:H2")).AsString <> "51,204,51" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateEntryForms = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
End Function

Function TestGenerateEntryFormsWithButtons() As TestResult
' 1 entry form
' test if cell validation works
' test if form validation works
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sTargetSheetName = "NewStudent"
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"NewStudent","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry";"NewStudent","","COMMIT","","","NewStudent","","","Button"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateEntryForms clsQuadRuntime
    
    If SheetExists(clsQuadRuntime.EntryBook, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.EntryBook, "NewStudent", clsQuadRuntime.TemplateCellSheetName
        
        If GetBgColor(sTargetSheetName, clsQuadRuntime.EntryBook.Sheets(sTargetSheetName).Range("H2:H2")).AsString <> "51,204,51" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateEntryFormsWithButtons = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
End Function


Function GetEntryCell(sSheetName As String, sFieldName As String, Optional wbTmp As Workbook) As Range
' just used in testing, puts an entry cell wherever the current focus is
Dim sKey As String
Dim dDefnDetail As Dictionary

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    sKey = GetEntryKey(sSheetName, sFieldName)
    Set dDefnDetail = dDefinitions.Item(sKey)
    Set GetEntryCell = wbTmp.Sheets(sSheetName).Range(dDefnDetail.Item("address"))
    
End Function


Function Te___stGenerateMenuForm() As TestResult
' multiple entry forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rEntry As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "NewLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^^COMMIT^^^NewStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^Teacher^TeacherAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^Teacher^TeacherPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^^COMMIT^^^NewTeacher^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Toggle_Schedule_Window^^^ToggleScheduleWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Toggle_Entry_Window^^^ToggleEntryWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Toggle_Cache_Window^^^ToggleCacheWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Show_NewStudent^^^ShowNewStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Show_NewTeacher^^^ShowNewTeacher^^^Button"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)


main:

    GenerateEntryForms clsQuadRuntime
    
    If SheetExists(clsQuadRuntime.EntryBook, "NewStudent") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If SheetExists(clsQuadRuntime.EntryBook, "NewTeacher") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rEntry = GetEntryCell("NewStudent", "StudentAge", wbTmp:=clsQuadRuntime.EntryBook)
    rEntry.value = 123
    Validate clsQuadRuntime.EntryBook, "NewStudent", rEntry
    
    If IsEntryValid("NewStudent", rEntry) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rEntry = GetEntryCell("NewTeacher", "TeacherAge", wbTmp:=clsQuadRuntime.EntryBook)
    rEntry.value = 666
    Validate clsQuadRuntime.EntryBook, "NewTeacher", rEntry
    
    If IsEntryValid("NewTeacher", rEntry) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateMenuForm = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete

End Function
Function TestLoadDefinitions() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim eTestResult As TestResult

setup:
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "LoadDefinitions"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentName","List","foo","","","","Entry";"NewStudent","Student","StudentPrep","IntegerRange","gt0_lt100","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    If dDefinitions.Exists("eNewStudent_StudentName") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    On Error GoTo err
    Set dDefnDetails = dDefinitions.Item("eNewStudent_StudentName")
    On Error GoTo 0
    
    If dDefnDetails.Exists("db_table_name") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If dDefnDetails.Item("db_table_name") <> "Student" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If dDefinitions.Exists("actions") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If dDefinitions.Item("actions").Keys()(0) <> "NewStudent" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestLoadDefinitions = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function

Function TxexsxtLoadDefinitionsFullSet() As TestResult
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "LoadDefinitions"
    clsQuadRuntime.InitProperties
    
    sSheetName = "test"
    Set wsTmp = clsQuadRuntime.TemplateBook.Sheets(clsQuadRuntime.DefinitionSheetName)
    Set rTarget = wsTmp.Range("Definitions")
main:

    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    DumpDefinitions
    
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestLoadDefinitionsFullSet = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function

Function TestIsValidInteger() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "IsValidInteger"

main:
    If IsValidInteger(clsQuadRuntime, 123) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(clsQuadRuntime, "ABC") <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(clsQuadRuntime, 123) = True Then
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
 
    If IsValidInteger(clsQuadRuntime, "ABC") = False Then
        eTestResult = TestResult.OK
    Else
        eTestResult = TestResult.Failure
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsValidInteger = eTestResult
    clsQuadRuntime.Delete
    
End Function

Function TestIsValidPrep() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "IsValidPrep"

main:
    If IsValidPrep(clsQuadRuntime, 1) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidPrep(clsQuadRuntime, 11) <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsValidPrep = eTestResult
    clsQuadRuntime.Delete
    
End Function


Function TestValidations() As TestResult

Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult
Dim rInput As Range
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "Validations"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.EntryBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewStudent","Student","StudentAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    
main:
    With wsTmp
        Set rInput = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rInput.value = 123
    rInput.Name = "eNewStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.EntryBook, "test", rInput)
    
    If bResult = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    rInput.value = "ABC"
    rInput.Name = "eNewStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.EntryBook, "test", rInput)
    
    If bResult = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestValidations = eTestResult
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete

End Function
Function TestIsMemberOfTable() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsQuadRuntime As New Quad_Runtime
 
setup:
    'On Error GoTo err:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = CsModuleName & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsQuadRuntime.EntryBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    CreateTables clsQuadRuntime.CacheBook
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows
    
main:
   
    If IsMember(clsQuadRuntime, "Jon", Array("Foo", "FooName")) <> True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsMemberOfTable = eTestResult
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    DeleteSheet clsQuadRuntime.EntryBook, "Foo"
    DeleteSheet clsQuadRuntime.EntryBook, "Bar"
    clsQuadRuntime.Delete
    
 End Function

Function TestIsMemberOfTableFailure() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsQuadRuntime As New Quad_Runtime
 
setup:
    On Error GoTo err:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = CsModuleName & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsQuadRuntime.EntryBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    CreateTables clsQuadRuntime.CacheBook
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows
    
main:
    If IsMember(clsQuadRuntime, "Nancy", Array("Foo", "FooName")) <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsMemberOfTableFailure = eTestResult
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    DeleteSheet clsQuadRuntime.EntryBook, "Foo"
    DeleteSheet clsQuadRuntime.EntryBook, "Bar"
    clsQuadRuntime.Delete
    
End Function
Function Test_FormatCellInvalid() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "FormatCellInvalid"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
    End With
    
    FormatCellInvalid "test", rTarget

    If GetBgColor(sSheetName, rTarget).AsString <> "255,0,0" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK


    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatCellInvalid = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function



Function DummyNewRecordCallback() As String
    DummyNewRecordCallback = "FOOBAR"
    Debug.Print "FOOBAR"
End Function

Function TestIsRecordValid() As TestResult
Dim sFuncName As String
Dim sSheetName As String
Dim sFieldName2 As String
Dim sFieldName1 As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult
Dim rInput As Range
Dim sKey As String

Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "IsRecordValid"
    sSheetName = "TestNewStudent"
    sFieldName1 = "StudentAge"
    sFieldName2 = "StudentName"
    Set wsTmp = CreateSheet(clsQuadRuntime.EntryBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"TestNewStudent","Student","StudentAge","Integer","IsValidInteger";"TestNewStudent","Student","StudentName","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    
    sKey = "e" & sSheetName & "_" & sFieldName1
    GenerateEntry clsQuadRuntime, sSheetName, wbTmp:=clsQuadRuntime.EntryBook
    Set rInput = wsTmp.Range(sKey)
    rInput.value = 123
    bResult = Validate(clsQuadRuntime.EntryBook, sSheetName, rInput)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sKey = "e" & sSheetName & "_" & sFieldName2
    'GenerateEntry clsQuadRuntime, sSheetName, sSheetName, "", wbTmp:=clsQuadRuntime.EntryBook
    Set rInput = wsTmp.Range(sKey)
    rInput.value = "ABC"
    bResult = Validate(clsQuadRuntime.EntryBook, sSheetName, rInput)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If IsRecordValid(clsQuadRuntime.TemplateBook, clsQuadRuntime.EntryBook, sSheetName, _
                clsQuadRuntime.TemplateCellSheetName) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsRecordValid = eTestResult
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Sub test()
    TestFormatEntryForms
End Sub
Function TestFormatEntryForms() As TestResult
' 1 entry form
' test if cell validation works
' test if form validation works
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim vSource() As String
Dim wsTmp As Worksheet, wsFormat As Worksheet, wsCellFormat As Worksheet
Dim rTarget As Range, rFormat As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wbTemplateBook As Workbook

setup:
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sTargetSheetName = "NewStudent"
    ResetQuadRuntimeGlobal

    ' create cache so can add new template sheet to it
    FileCopy "cache.xlsm", Environ("MYHOME") & "\runtime\archive\", Environ("MYHOME") & "\runtime\"
    
    Set wbTemplateBook = OpenBook("cache.xlsm", Environ("MYHOME") & "\\runtime")
    Set wsFormat = CreateSheet(wbTemplateBook, "FormStyles", bOverwrite:=True)
    Set wsCellFormat = CreateSheet(wbTemplateBook, "CellStyles", bOverwrite:=True)
    
    clsQuadRuntime.InitProperties bInitializeCache:=True, _
        sTemplateBookName:="cache.xlsm", sTemplateBookPath:=Environ("MYHOME") & "\\runtime"
        
    CreateNamedRange clsQuadRuntime.TemplateBook, "A1:A1", "CellStyles", "fButtonInValid", "True"
    CreateNamedRange clsQuadRuntime.TemplateBook, "A2:A2", "CellStyles", "fButtonValid", "True"
    CreateNamedRange clsQuadRuntime.TemplateBook, "A3:A3", "CellStyles", "fEntryValid", "True"
    CreateNamedRange clsQuadRuntime.TemplateBook, "A4:A4", "CellStyles", "fEntryInValid", "True"
    
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"NewStudent","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    With wsFormat
        Set rFormat = .Range("$A$1:$I$50")
        SetBgColor "FormStyles", rFormat, 123, 34, 200, wbTmp:=clsQuadRuntime.TemplateBook
        rFormat.Rows(25).EntireRow.RowHeight = 3
        rFormat.Columns(5).EntireColumn.ColumnWidth = 3
    End With
    
    CreateNamedRange clsQuadRuntime.TemplateBook, rFormat.Address, "FormStyles", "fNew", "True"

main:

    CreateNamedRange clsQuadRuntime.TemplateBook, "B2:B2", "FormStyles", "fNewEntry1", "True"
    CreateNamedRange clsQuadRuntime.TemplateBook, "B3:C3", "FormStyles", "fNewEntry2", "True"
    
    GenerateEntryForms clsQuadRuntime
    
    With clsQuadRuntime.EntryBook.Sheets("NewStudent")
        Set rFormat = .Range("$I$50:$I$50")
        If GetBgColor("NewStudent", rFormat).AsString <> "123,34,200" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rFormat = .Range("$A$1:$I$50")
        
        If rFormat.Rows(25).EntireRow.RowHeight <> 3 Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rFormat.Columns(5).EntireColumn.ColumnWidth <> 3 Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
    End With
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestFormatEntryForms = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.EntryBook, sSheetName
    clsQuadRuntime.Delete
    
End Function
