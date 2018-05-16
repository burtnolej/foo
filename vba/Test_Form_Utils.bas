Attribute VB_Name = "Test_Form_Utils"
Const C_MODULE_NAME = "Test_Form_Utils"

Function TestGenerateFormsLoadRefDataFromDBMultipleRefs() As TestResult
' uses both student and teacher reference tables
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim sDefn As String
Dim vSource() As String, vStudents() As String, vTeachers() As String, vLessons() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    ResetAppRuntimeGlobal
    
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "AddLesson"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
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
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)


main:
    GenerateForms clsAppRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile
    
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
    'With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "David"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
        'ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "Stone"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
        'ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
    
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
Dim clsAppRuntime As New App_Runtime

setup:
    ResetAppRuntimeGlobal
    
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    
    sTargetSheetName = "AddLesson"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
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
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateForms clsAppRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile
    
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Raskin"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "4"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
    
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
Dim clsAppRuntime As New App_Runtime

setup:
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
        
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sSheetName = "test"
    sTargetSheetName = "AddLesson"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    
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
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Jon^45^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Quinton^6^2"
    vStudents = Init2DStringArrayFromString(sDefn, bVariant:=True)
    sCacheSheetName = CacheData(clsAppRuntime, vStudents, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Nancy^46^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Betty^36^2"
    vTeachers = Init2DStringArrayFromString(sDefn, bVariant:=True)
    sCacheSheetName = CacheData(clsAppRuntime, vTeachers, QuadDataType.person, QuadSubDataType.teacher, bInTable:=True)
    
main:

    GenerateForms clsAppRuntime, bLoadRefData:=False
    
    EventsToggle True
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Jon"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Betty"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
    
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
Dim clsAppRuntime As New App_Runtime

setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sTargetSheetName = "AddStudent"
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger";"AddStudent","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)

main:

    GenerateForms clsAppRuntime
    
    If SheetExists(clsAppRuntime.AddBook, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "AddStudent", clsAppRuntime.TemplateWidgetSheetName
        
        ' no buttons implemented so need to hardcode where the button will be on the screen
        If GetBgColor(sTargetSheetName, clsAppRuntime.AddBook.Sheets(sTargetSheetName).Range("H2:H2")).AsString <> "51,204,51" Then
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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
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
Dim clsAppRuntime As New App_Runtime

setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sTargetSheetName = "AddStudent"
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"AddStudent","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry";"AddStudent","","COMMIT","","","AddStudent","","","Button"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateForms clsAppRuntime
    
    If SheetExists(clsAppRuntime.AddBook, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "AddStudent", clsAppRuntime.TemplateWidgetSheetName
        
        If GetBgColor(sTargetSheetName, clsAppRuntime.AddBook.Sheets(sTargetSheetName).Range("H2:H2")).AsString <> "51,204,51" Then
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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
End Function


Function GetEntryWidget(sSheetName As String, sFieldname As String, Optional wbTmp As Workbook) As Range
' just used in testing, puts an entry Widget wherever the current focus is
Dim sKey As String
Dim dDefnDetail As Dictionary

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    'sKey = GetEntryKey(sSheetName, sFieldName)
    sKey = GetKey(sSheetName, sFieldname)
    Set dDefnDetail = dDefinitions.Item(sKey)
    Set GetEntryWidget = wbTmp.Sheets(sSheetName).Range(dDefnDetail.Item("address"))
    
End Function


Function TestGenerateMenuForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
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
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateForms clsAppRuntime
    
    sSearchCode = "If Target.Column = 2 And Target.Row = 2 Then" & vbNewLine
    sSearchCode = sSearchCode & "Application.Run ""vba_source_new.xlsm!ToggleScheduleWindow""" & vbNewLine
    sSearchCode = sSearchCode & "End If"

    sModuleCode = GetProcCode(clsAppRuntime.MenuBook, "Sheet2", "Worksheet_SelectionChange")
    
    If InParagraph(sSearchCode, sModuleCode) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sSearchCode = "If Target.Column = 4 And Target.Row = 5 Then" & vbNewLine
    sSearchCode = sSearchCode & "Application.Run ""vba_source_new.xlsm!ShowAddTeacher""" & vbNewLine
    sSearchCode = sSearchCode & "End If"

    sModuleCode = GetProcCode(clsAppRuntime.MenuBook, "Sheet2", "Worksheet_SelectionChange")
    
    If InParagraph(sSearchCode, sModuleCode) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rButton = clsAppRuntime.MenuBook.Sheets("MenuMain").Range("D5:D5")
    
    If rButton.name.name <> "MenuMain!bMenuMain_Show_AddTeacher" Then
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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete

End Function


Function TestGenerateViewForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^sStudentFirstNm^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^StudentAge^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^StudentPrep^^^^^^Text"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    dTmp.Add "sStudentFirstNm", "Jon"
    dTmp.Add "StudentAge", "46"
    dTmp.Add "StudentPrep", "3"
    dDefaultValues.Add "ViewStudent", dTmp
    
main:
    
    GenerateForms clsAppRuntime, dDefaultValues:=dDefaultValues
        
    Set rText = clsAppRuntime.ViewBook.Sheets("ViewStudent").Range("C4:C4")
    
    If rText.name.name <> "ViewStudent!tViewStudent_sStudentFirstNm" Then
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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete

End Function
Function TestGenerateViewSelectForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "ViewStudent^person_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^&UpdateViewStudentForm^Selector" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^sStudentFirstNm^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^idStudent^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewStudent^person_student^idPrep^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    dTmp.Add "sStudentFirstNm", "Jon"
    dTmp.Add "idStudent", "666"
    dTmp.Add "idPrep", "3"
    dDefaultValues.Add "ViewStudent", dTmp
    
main:

    GenerateForms clsAppRuntime, dDefaultValues:=dDefaultValues
    
    EventsToggle True
    With clsAppRuntime.ViewBook.Sheets("ViewStudent")
        Set rTarget = .Range(.Cells(2, 3), .Cells(2, 3))
        rTarget = "Bruno"
        ValidateWidget clsAppRuntime.ViewBook, "ViewStudent", rTarget
    End With

    Set rText = clsAppRuntime.ViewBook.Sheets("ViewStudent").Range("C4:C4")
    
    If rText.name.name <> "ViewStudent!tViewStudent_sStudentFirstNm" Then
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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete

End Function


Function TestGenerateViewListForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String, vValues() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range, rColumn As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateViewListForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^Student^sStudentFirstNm^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^Student^StudentAge^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^Student^StudentPrep^^^^^^ListText"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    vValues = Init2DStringArray([{"sStudentFirstNm","StudentAge","StudentPrep";"Jon", "46", "3";"Nancy", "47", "2";"Quinton", "6.5", "4"}])
    
main:

    GenerateForms clsAppRuntime, vValues:=vValues

    Set rColumn = clsAppRuntime.ViewBook.Sheets("ViewListStudents").Range("lViewListStudents_sStudentFirstNm")
    
    If rColumn.Rows(1).value <> "Jon" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If rColumn.Rows(3).value <> "Quinton" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rColumn = clsAppRuntime.ViewBook.Sheets("ViewListStudents").Range("lViewListStudents_StudentPrep")

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
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete

End Function

Function TestGenerateViewListForm_PassingWrongValues() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String, vValues() As Integer
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range, rColumn As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateViewListForm_PassingWrongValues"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "AddStudent^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^Student^sStudentFirstNm^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^Student^StudentAge^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewListStudents^Student^StudentPrep^^^^^^ListText"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
main:

    GenerateForms clsAppRuntime, vValues:=vValues
    
    eTestResult = TestResult.Failure
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.OK
    On Error GoTo 0
    GoTo teardown
    
teardown:
    TestGenerateViewListForm_PassingWrongValues = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete

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
    sFuncName = C_MODULE_NAME & "." & "LoadDefinitions"
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
    
    If dDefnDetails.Exists("CacheTableName") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If dDefnDetails.Item("CacheTableName") <> "Student" Then
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
Dim clsAppRuntime As New App_Runtime

setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "LoadDefinitions"
    clsAppRuntime.InitProperties
    
    sSheetName = "test"
    Set wsTmp = clsAppRuntime.TemplateBook.Sheets(clsAppRuntime.DefinitionSheetName)
    Set rTarget = wsTmp.Range("Definitions")
main:

    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    DumpDefinitions
    
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestLoadDefinitionsFullSet = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function
Function DummyAddRecordCallback() As String
    DummyAddRecordCallback = "FOOBAR"
    Debug.Print "FOOBAR"
End Function

Function TestIsRecordValid() As TestResult
Dim sFuncName As String, sTemplateSheetName As String
Dim sSheetName As String, sFieldName2 As String, sFieldName1 As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult
Dim rInput As Range
Dim sKey As String

Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "IsRecordValid"
    sSheetName = "TestAddStudent"
    sFieldName1 = "StudentAge"
    sFieldName2 = "StudentName"
    Set wsTmp = CreateSheet(clsAppRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"TestAddStudent","Student","StudentAge","Integer","IsValidInteger";"TestAddStudent","Student","StudentName","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    
    sKey = "e" & sSheetName & "_" & sFieldName1
    
    sTemplateSheetName = clsAppRuntime.TemplateBook.Names("fAdd").RefersToRange.Worksheet.name
    
    GenerateWidgets clsAppRuntime, sSheetName, wbTmp:=clsAppRuntime.AddBook, sTemplateSheetName:=sTemplateSheetName
    Set rInput = wsTmp.Range(sKey)
    rInput.value = 123
    bResult = ValidateWidget(clsAppRuntime.AddBook, sSheetName, rInput)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sKey = "e" & sSheetName & "_" & sFieldName2
    'GenerateAdd clsAppRuntime, sSheetName, sSheetName, "", wbTmp:=clsAppRuntime.AddBook
    Set rInput = wsTmp.Range(sKey)
    rInput.value = "ABC"
    bResult = ValidateWidget(clsAppRuntime.AddBook, sSheetName, rInput)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If IsRecordValid(clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, sSheetName, _
                clsAppRuntime.TemplateWidgetSheetName) = True Then
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
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
    
End Function

Sub test()
    TestFormatForms
End Sub
Function TestFormatForms() As TestResult
' 1 Add form
' test if Widget validation works
' test if form validation works
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim vSource() As String
Dim wsTmp As Worksheet, wsFormat As Worksheet, wsWidgetFormat As Worksheet
Dim rTarget As Range, rFormat As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim wbTemplateBook As Workbook

setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sTargetSheetName = "AddStudent"
    ResetAppRuntimeGlobal

    ' create cache so can add new template sheet to it
    FileCopy "cache.xlsm", Environ("MYHOME") & "\runtime\archive\", Environ("MYHOME") & "\runtime\"
    
    Set wbTemplateBook = OpenBook("cache.xlsm", Environ("MYHOME") & "\\runtime")
    Set wsFormat = CreateSheet(wbTemplateBook, "FormStyles", bOverwrite:=True)
    Set wsWidgetFormat = CreateSheet(wbTemplateBook, "WidgetStyles", bOverwrite:=True)
    
    clsAppRuntime.InitProperties bInitializeCache:=True, _
        sTemplateBookName:="cache.xlsm", sTemplateBookPath:=Environ("MYHOME") & "\\runtime"
        
    CreateNamedRange clsAppRuntime.TemplateBook, "A1:A1", "WidgetStyles", "fButtonInValid", "True"
    CreateNamedRange clsAppRuntime.TemplateBook, "A2:A2", "WidgetStyles", "fButtonValid", "True"
    CreateNamedRange clsAppRuntime.TemplateBook, "A3:A3", "WidgetStyles", "fEntryValid", "True"
    CreateNamedRange clsAppRuntime.TemplateBook, "A4:A4", "WidgetStyles", "fEntryInValid", "True"
    
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"AddStudent","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    With wsFormat
        Set rFormat = .Range("$A$1:$I$50")
        SetBgColor "FormStyles", rFormat, 123, 34, 200, wbTmp:=clsAppRuntime.TemplateBook
        rFormat.Rows(25).EntireRow.RowHeight = 3
        rFormat.Columns(5).EntireColumn.ColumnWidth = 3
    End With
    
    CreateNamedRange clsAppRuntime.TemplateBook, rFormat.Address, "FormStyles", "fAdd", "False"

main:

    CreateNamedRange clsAppRuntime.TemplateBook, "B2:B2", "FormStyles", "fAddEntry1", "False"
    CreateNamedRange clsAppRuntime.TemplateBook, "B3:C3", "FormStyles", "fAddEntry2", "False"
    
    GenerateForms clsAppRuntime
    
    With clsAppRuntime.AddBook.Sheets("AddStudent")
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
    TestFormatForms = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete
    
End Function
