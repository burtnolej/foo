Attribute VB_Name = "Test_Add_Utils"
Const CsModuleName = "Test_Add_Utils"

Function TestGenerateFormsLoadRefDataFromDBMultipleRefs() As TestResult
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
    
    sFuncName = CsModuleName & "." & "GenerateForms"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "AddLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    ' table: Add lesson ---------------------------------------------------------------
    ' attr : student name
    sDefn = "AddLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^Lesson^SLastName^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
    ' attr : teacher_name
    sDefn = sDefn & "AddLesson^Lesson^TFirstName^String^IsMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^Lesson^TLastName^String^IsMember^&get_person_teacher^sFacultyLastNm^^Entry" & DOUBLEDOLLAR
    ' attr : prep
    sDefn = sDefn & "AddLesson^Lesson^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    ' table: Add student ---------------------------------------------------------------
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
    ' table: Add teacher ---------------------------------------------------------------
    sDefn = sDefn & "AddTeacher^person_teacher^sFacultyFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^person_teacher^sFacultyLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^person_teacher^idFaculty^Integer^^^^^Entry"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)


main:
    GenerateForms clsQuadRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Add_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    With clsQuadRuntime.AddBook.Sheets(sTargetSheetName)
    'With clsQuadRuntime.AddBook.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "David"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
        'Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "Stone"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
        'Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
    
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
    TestGenerateFormsLoadRefDataFromDBMultipleRefs = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function TestGenerateFormsLoadRefDataFromDB() As TestResult
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
    
    sFuncName = CsModuleName & "." & "GenerateForms"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "AddLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    sDefn = "AddLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^Lesson^LastName^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^Lesson^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateForms clsQuadRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Add_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    With clsQuadRuntime.AddBook.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Raskin"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "4"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget

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
    TestGenerateFormsLoadRefDataFromDB = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete
    
End Function
Function TestGenerateFormsIsMember() As TestResult
' 1 Add form but record that requires IsMember validation
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim sDefn As String
Dim vSource() As String, vStudents() As Variant, vTeachers() As Variant, vLessons() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
        
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "GenerateForms"
    sSheetName = "test"
    sTargetSheetName = "AddLesson"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
    sDefn = "AddStudent^person_student^Name^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^Age^Integer^IsInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^person_teacher^Name^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^person_teacher^Age^Integer^IsInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^person_teacher^Prep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^Lesson^StudentName^String^IsMember^person_student^Name^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddLesson^Lesson^TeacherName^String^IsMember^person_teacher^Name^^Entry"
    vSource = Init2DStringArrayFromString(sDefn)
    
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Jon^45^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Quinton^6^2"
    vStudents = Init2DStringArrayFromString(sDefn, bVariant:=True)
    sCacheSheetName = CacheData(clsQuadRuntime, vStudents, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Nancy^46^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Betty^36^2"
    vTeachers = Init2DStringArrayFromString(sDefn, bVariant:=True)
    sCacheSheetName = CacheData(clsQuadRuntime, vTeachers, QuadDataType.person, QuadSubDataType.teacher, bInTable:=True)
    
main:

    GenerateForms clsQuadRuntime, bLoadRefData:=False
    
    EventsToggle True
    With clsQuadRuntime.AddBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Jon"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Betty"
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget

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
    TestGenerateFormsIsMember = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Function TestGenerateForms() As TestResult
' 1 Add form
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
    sFuncName = CsModuleName & "." & "GenerateForms"
    sTargetSheetName = "AddStudent"
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger";"AddStudent","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)

main:

    GenerateForms clsQuadRuntime
    
    If SheetExists(clsQuadRuntime.AddBook, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsQuadRuntime.AddBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.AddBook, "AddStudent", clsQuadRuntime.TemplateCellSheetName
        
        ' no buttons implemented so need to hardcode where the button will be on the screen
        If GetBgColor(sTargetSheetName, clsQuadRuntime.AddBook.Sheets(sTargetSheetName).Range("H2:H2")).AsString <> "51,204,51" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateForms = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete
End Function

Function TestGenerateFormsWithButtons() As TestResult
' 1 Add form
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
    sFuncName = CsModuleName & "." & "GenerateForms"
    sTargetSheetName = "AddStudent"
    ResetQuadRuntimeGlobal
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"AddStudent","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry";"AddStudent","","COMMIT","","","AddStudent","","","Button"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateForms clsQuadRuntime
    
    If SheetExists(clsQuadRuntime.AddBook, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsQuadRuntime.AddBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        Validate clsQuadRuntime.AddBook, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.AddBook, "AddStudent", clsQuadRuntime.TemplateCellSheetName
        
        If GetBgColor(sTargetSheetName, clsQuadRuntime.AddBook.Sheets(sTargetSheetName).Range("H2:H2")).AsString <> "51,204,51" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateFormsWithButtons = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
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


Function TestGenerateMenuForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^Teacher^TeacherAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^Teacher^TeacherPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddTeacher^^COMMIT^^^AddTeacher^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Toggle_Schedule_Window^^^ToggleScheduleWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Toggle_Add_Window^^^ToggleAddWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Toggle_Cache_Window^^^ToggleCacheWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Show_AddStudent^^^ShowAddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "MenuMain^^Show_AddTeacher^^^ShowAddTeacher^^^Button"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateForms clsQuadRuntime
    
    sSearchCode = "If Target.Column = 2 And Target.Row = 2 Then" & vbNewLine
    sSearchCode = sSearchCode & "Application.Run ""vba_source_new.xlsm!ToggleScheduleWindow""" & vbNewLine
    sSearchCode = sSearchCode & "End If"

    sModuleCode = GetProcCode(clsQuadRuntime.MenuBook, "Sheet2", "Worksheet_SelectionChange")
    
    If InParagraph(sSearchCode, sModuleCode) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sSearchCode = "If Target.Column = 4 And Target.Row = 5 Then" & vbNewLine
    sSearchCode = sSearchCode & "Application.Run ""vba_source_new.xlsm!ShowAddTeacher""" & vbNewLine
    sSearchCode = sSearchCode & "End If"

    sModuleCode = GetProcCode(clsQuadRuntime.MenuBook, "Sheet2", "Worksheet_SelectionChange")
    
    If InParagraph(sSearchCode, sModuleCode) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rButton = clsQuadRuntime.MenuBook.Sheets("MenuMain").Range("D5:D5")
    
    If rButton.Name.Name <> "MenuMain!bMenuMain_Show_AddTeacher" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateMenuForm = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete

End Function


Function TestGenerateViewForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^^sStudentFirstNm^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^^StudentAge^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^^StudentPrep^^^^^^Text"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    dTmp.Add "sStudentFirstNm", "Jon"
    dTmp.Add "StudentAge", "46"
    dTmp.Add "StudentPrep", "3"
    dDefaultValues.Add "ViewStudent", dTmp
    
main:

    GenerateForms clsQuadRuntime, dDefaultValues:=dDefaultValues
    
    Set rText = clsQuadRuntime.ViewBook.Sheets("ViewStudent").Range("C4:C4")
    
    If rText.Name.Name <> "ViewStudent!tViewStudent_sStudentFirstNm" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If rText.value <> "Jon" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateViewForm = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete

End Function
Function TestGenerateViewSelectForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "ViewStudent^^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^&UpdateForm^Selector" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^^sStudentFirstNm^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^^idStudent^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^^idPrep^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    dTmp.Add "sStudentFirstNm", "Jon"
    dTmp.Add "idStudent", "666"
    dTmp.Add "idPrep", "3"
    dDefaultValues.Add "ViewStudent", dTmp
    
main:

    GenerateForms clsQuadRuntime, dDefaultValues:=dDefaultValues
    
    EventsToggle True
    With clsQuadRuntime.ViewBook.Sheets("ViewStudent")
        Set rTarget = .Range(.Cells(2, 3), .Cells(2, 3))
        rTarget = "Bruno"
        Validate clsQuadRuntime.ViewBook, "ViewStudent", rTarget
    End With

    Set rText = clsQuadRuntime.ViewBook.Sheets("ViewStudent").Range("C4:C4")
    
    If rText.Name.Name <> "ViewStudent!tViewStudent_sStudentFirstNm" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If rText.value <> "Bruno" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateViewSelectForm = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete

End Function


Function TestGenerateViewListForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String, vValues() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range, rColumn As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = CsModuleName & "." & "TestGenerateViewListForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsQuadRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^^sStudentFirstNm^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^^StudentAge^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^^StudentPrep^^^^^^ListText"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    vValues = Init2DStringArray([{"sStudentFirstNm","StudentAge","StudentPrep";"Jon", "46", "3";"Nancy", "47", "2";"Quinton", "6.5", "4"}])
    
main:

    GenerateForms clsQuadRuntime, vValues:=vValues

    Set rColumn = clsQuadRuntime.ViewBook.Sheets("ViewListStudents").Range("lViewListStudents_sStudentFirstNm")
    
    If rColumn.Rows(1).value <> "Jon" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If rColumn.Rows(3).value <> "Quinton" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rColumn = clsQuadRuntime.ViewBook.Sheets("ViewListStudents").Range("lViewListStudents_StudentPrep")

    If rColumn.Rows(1).value <> "3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If rColumn.Rows(3).value <> "4" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateViewListForm = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
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
    vSource = Init2DStringArray([{"AddStudent","Student","StudentName","List","foo","","","","Entry";"AddStudent","Student","StudentPrep","IntegerRange","gt0_lt100","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    If dDefinitions.Exists("eAddStudent_StudentName") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    On Error GoTo err
    Set dDefnDetails = dDefinitions.Item("eAddStudent_StudentName")
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
    
    If dDefinitions.Item("actions").Keys()(0) <> "AddStudent" Then
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

    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

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
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger";"AddStudent","Student","StudentAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    
main:
    With wsTmp
        Set rInput = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rInput.value = 123
    rInput.Name = "eAddStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.AddBook, "test", rInput)
    
    If bResult = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    rInput.value = "ABC"
    rInput.Name = "eAddStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.AddBook, "test", rInput)
    
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete

End Function
Function TestIsMemberOfTable() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As Variant
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsQuadRuntime As New Quad_Runtime
 
setup:
    'On Error GoTo err:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = CsModuleName & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember";"AddFoo","Foo","FooAge","Integer","IsValidInteger";"AddBar","Bar","BarName","List","IsMember";"AddBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    CreateTables clsQuadRuntime.CacheBook
    AddTableRecordAuto clsQuadRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.AddBook, "Foo"
    DeleteSheet clsQuadRuntime.AddBook, "Bar"
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
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember";"AddFoo","Foo","FooAge","Integer","IsValidInteger";"AddBar","Bar","BarName","List","IsMember";"AddBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    DeleteSheet clsQuadRuntime.AddBook, "Foo"
    DeleteSheet clsQuadRuntime.AddBook, "Bar"
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



Function DummyAddRecordCallback() As String
    DummyAddRecordCallback = "FOOBAR"
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
    sSheetName = "TestAddStudent"
    sFieldName1 = "StudentAge"
    sFieldName2 = "StudentName"
    Set wsTmp = CreateSheet(clsQuadRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"TestAddStudent","Student","StudentAge","Integer","IsValidInteger";"TestAddStudent","Student","StudentName","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreCellType:=True)
    
    sKey = "e" & sSheetName & "_" & sFieldName1
    GenerateForm clsQuadRuntime, sSheetName, wbTmp:=clsQuadRuntime.AddBook
    Set rInput = wsTmp.Range(sKey)
    rInput.value = 123
    bResult = Validate(clsQuadRuntime.AddBook, sSheetName, rInput)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sKey = "e" & sSheetName & "_" & sFieldName2
    'GenerateAdd clsQuadRuntime, sSheetName, sSheetName, "", wbTmp:=clsQuadRuntime.AddBook
    Set rInput = wsTmp.Range(sKey)
    rInput.value = "ABC"
    bResult = Validate(clsQuadRuntime.AddBook, sSheetName, rInput)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If IsRecordValid(clsQuadRuntime.TemplateBook, clsQuadRuntime.AddBook, sSheetName, _
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
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete
    
End Function

Sub test()
    TestFormatAddForms
End Sub
Function TestFormatAddForms() As TestResult
' 1 Add form
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
    sFuncName = CsModuleName & "." & "GenerateForms"
    sTargetSheetName = "AddStudent"
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
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"AddStudent","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Add_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    With wsFormat
        Set rFormat = .Range("$A$1:$I$50")
        SetBgColor "FormStyles", rFormat, 123, 34, 200, wbTmp:=clsQuadRuntime.TemplateBook
        rFormat.Rows(25).EntireRow.RowHeight = 3
        rFormat.Columns(5).EntireColumn.ColumnWidth = 3
    End With
    
    CreateNamedRange clsQuadRuntime.TemplateBook, rFormat.Address, "FormStyles", "fAdd", "True"

main:

    CreateNamedRange clsQuadRuntime.TemplateBook, "B2:B2", "FormStyles", "fAddEntry1", "True"
    CreateNamedRange clsQuadRuntime.TemplateBook, "B3:C3", "FormStyles", "fAddEntry2", "True"
    
    GenerateForms clsQuadRuntime
    
    With clsQuadRuntime.AddBook.Sheets("AddStudent")
        Set rFormat = .Range("$I$50:$I$50")
        If GetBgColor("AddStudent", rFormat).AsString <> "123,34,200" Then
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
    TestFormatAddForms = eTestResult
    DeleteForms wbTmp:=clsQuadRuntime.AddBook
    DeleteSheet clsQuadRuntime.AddBook, sSheetName
    clsQuadRuntime.Delete
    
End Function
