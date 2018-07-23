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
Dim clsAppRuntime As New App_Runtime, dArgs As New Dictionary
Dim clsExecProc As Exec_Proc

setup:
    ResetAppRuntimeGlobal
    
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, "Schedule", "Lesson", sSheetName, FormType.Add
    sTargetSheetName = "Add_Schedule_Lesson"

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "bLoadRefData", True
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile
    
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)

        'eAdd_Schedule_Lesson_idStudent
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "2"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        'eAdd_Schedule_Lesson_idFaculty
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "994"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        'eAdd_Schedule_Lesson_idLocation
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "1"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        'eAdd_Schedule_Lesson_idSection
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "700"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
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


Function TestGenerateFormsIsMember() As TestResult
' 1 Add form but record that requires IsMember validation
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim sDefn As String
Dim vSource() As String, vStudents() As Variant, vTeachers() As Variant, vLessons() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc


setup:
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    sSheetName = "test"
    GetDefinition clsAppRuntime, clsExecProc, "Person", "Student", sSheetName, FormType.Add
    
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    
    sTargetSheetName = "Add_Person_Student"

    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Jon^45^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Quinton^6^2"
    vStudents = Init2DStringArrayFromString(sDefn, bVariant:=True)
    sCacheSheetName = CacheData(clsAppRuntime, vStudents, QuadDataType.person, QuadSubDataType.Student, bInTable:=True)

main:

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "bLoadRefData", True
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime, bLoadRefData:=False
    
    EventsToggle True
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
    
    
        'eAdd_Person_Student_sStudentFirstNm
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Jon"
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
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc


setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sTargetSheetName = "Add_Student_Schedule"
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"Add_Student_Schedule","Student","StudentAge","Integer","IsValidInteger";"Add_Student_Schedule","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)

main:

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime
    
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
        
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, sTargetSheetName, clsAppRuntime.TemplateWidgetSheetName
        
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
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc


setup:
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateForms"
    sTargetSheetName = "Add_Student_Schedule"
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"Add_Student_Schedule","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"Add_Student_Schedule","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry";"Add_Student_Schedule","","COMMIT","","","AddStudent","","","Button"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime
    
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
        
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "Add_Student_Schedule", clsAppRuntime.TemplateWidgetSheetName
        
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


Function GetEntryWidget(sSheetName As String, sFieldName As String, Optional wbTmp As Workbook) As Range
' just used in testing, puts an entry Widget wherever the current focus is
Dim sKey As String
Dim dDefnDetail As Dictionary

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    'sKey = GetEntryKey(sSheetName, sFieldName)
    sKey = GetWidgetKey(sSheetName, sFieldName)
    Set dDefnDetail = dDefinitions.Item(sKey)
    Set GetEntryWidget = wbTmp.Sheets(sSheetName).Range(dDefnDetail.Item("address"))
    
End Function


Function TestGenerateMenuForm() As TestResult
' multiple Add forms
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True

    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "Add_Student_Schedule^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Teacher^Teacher^TeacherAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Teacher^Teacher^TeacherPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Teacher^^COMMIT^^^AddTeacher^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "Menu_Main_^^Toggle_Schedule_Window^^^ToggleScheduleWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "Menu_Main_^^Toggle_Add_Window^^^ToggleAddWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "Menu_Main_^^Toggle_Cache_Window^^^ToggleCacheWindow^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "Menu_Main_^^Show_AddStudent^^^ShowAddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "Menu_Main_^^Show_AddTeacher^^^ShowAddTeacher^^^Button"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime
    
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
    
    Set rButton = clsAppRuntime.MenuBook.Sheets("Menu_Main_").Range("D5:D5")
    
    If rButton.Name.Name <> "Menu_Main_!bMenu_Main__Show_AddTeacher" Then
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
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "Add_Person_Student^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^person_student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^person_student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "View_Person_Student^person_student^sStudentFirstNm^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "View_Person_Student^person_student^StudentAge^^^^^^Text" & DOUBLEDOLLAR
    sDefn = sDefn & "View_Person_Student^person_student^StudentPrep^^^^^^Text"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    dTmp.Add "sStudentFirstNm", "Jon"
    dTmp.Add "StudentAge", "46"
    dTmp.Add "StudentPrep", "3"
    dDefaultValues.Add "View_Person_Student", dTmp
    
main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "dDefaultValues", dDefaultValues
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime, dDefaultValues:=dDefaultValues
        
    Set rText = clsAppRuntime.ViewBook.Sheets("View_Person_Student").Range("C4:C4")
    
    If rText.Name.Name <> "View_Person_Student!tView_Person_Student_sStudentFirstNm" Then
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
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String, sDataType As String, sSubDataType As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc


setup:
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateViewSelectForm"
    
    sDataType = "Person"
    sSubDataType = "Student"
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
    dTmp.Add "sStudentLastNm", "Butler"
    dTmp.Add "idStudent", "666"
    dTmp.Add "idPrep", "3"
    dTmp.Add "iGradeLevel", "8"
    
    dDefaultValues.Add "View_Schedule_Student", dTmp
    
main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "dDefaultValues", dDefaultValues
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime, dDefaultValues:=dDefaultValues
    
    EventsToggle True
    With clsAppRuntime.ViewBook.Sheets("View_Person_Student")
        Set rTarget = .Range(.Cells(2, 3), .Cells(2, 3))
        rTarget = "Bruno"
        ValidateWidget clsAppRuntime.ViewBook, "View_Person_Student", rTarget
    End With

    Set rText = clsAppRuntime.ViewBook.Sheets("View_Person_Student").Range("C4:C4")
    
    If rText.Name.Name <> "View_Person_Student!tView_Person_Student_sStudentLastNm" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If rText.value <> "Raskin" Then
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
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateViewListForm"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "Add_Schedule_Lesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewList_Person_Student^Student^sStudentFirstNm^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewList_Person_Student^Student^StudentAge^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewList_Person_Student^Student^StudentPrep^^^^^^ListText"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    vValues = Init2DStringArray([{"sStudentFirstNm","StudentAge","StudentPrep";"Jon", "46", "3";"Nancy", "47", "2";"Quinton", "6.5", "4"}])
    
main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "vValues", vValues
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime, vValues:=vValues

    Set rColumn = clsAppRuntime.ViewBook.Sheets("ViewList_Person_Student").Range("lViewList_Person_Student_sStudentFirstNm")
    
    If rColumn.Rows(1).value <> "Jon" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If rColumn.Rows(3).value <> "Quinton" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rColumn = clsAppRuntime.ViewBook.Sheets("ViewList_Person_Student").Range("lViewList_Person_Student_StudentPrep")

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
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dDefaultValues As New Dictionary, dTmp As New Dictionary, dArgs As New Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "GenerateViewListForm_PassingWrongValues"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True)
    sDefn = "Add_Schedule_Lesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^Student^StudentAge^Integer^IsValidInteger^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^Student^StudentPrep^IntegerRange^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
    sDefn = sDefn & "Add_Person_Student^^COMMIT^^^AddStudent^^^Button" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewList_Person_Students^Student^sStudentFirstNm^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewList_Person_Students^Student^StudentAge^^^^^^ListText" & DOUBLEDOLLAR
    sDefn = sDefn & "ViewList_Person_Students^Student^StudentPrep^^^^^^ListText"
     
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsAppRuntime.TemplateBook, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "vValues", vValues
    Application.Run C_GENERATE_FORMS, dArgs

    'GenerateForms clsAppRuntime, vValues:=vValues
    
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
Dim dArgs As New Dictionary
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "IsRecordValid"
    sSheetName = "test"
    sFieldName1 = "StudentAge"
    sFieldName2 = "StudentName"
    Set wsTmp = CreateSheet(clsAppRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"Add_Person_Student","Student","StudentAge","Integer","IsValidInteger";"Add_Person_Student","Student","StudentName","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    
    Set wsTmp = CreateSheet(clsAppRuntime.AddBook, "Add_Person_Student", bOverwrite:=True)
    sKey = "e" & "Add_Person_Student" & "_" & sFieldName1
    
    sTemplateSheetName = clsAppRuntime.TemplateBook.Names("fAdd").RefersToRange.Worksheet.Name
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "sAction", "Add_Person_Student", "wbTmp", clsAppRuntime.AddBook, "sTemplateSheetName", sTemplateSheetName
    Application.Run C_GENERATE_WIDGETS, dArgs
    'GenerateWidgets clsAppRuntime, sSheetName, wbTmp:=clsAppRuntime.AddBook, sTemplateSheetName:=sTemplateSheetName

    Set rInput = wsTmp.Range(sKey)
    rInput.value = 123
    bResult = ValidateWidget(clsAppRuntime.AddBook, "Add_Person_Student", rInput)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sKey = "e" & "Add_Person_Student" & "_" & sFieldName2
    'GenerateAdd clsAppRuntime, sSheetName, sSheetName, "", wbTmp:=clsAppRuntime.AddBook
    Set rInput = wsTmp.Range(sKey)
    rInput.value = "ABC"
    bResult = ValidateWidget(clsAppRuntime.AddBook, sSheetName, rInput)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If IsRecordValid(clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "Add_Person_Student", _
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

Function TestFormatForms() As TestResult
' 1 Add form
' test if Widget validation works
' test if form validation works
Dim sFuncName As String, sSheetName As String, sResultStr As String, sExpectedResultStr As String, sTargetSheetName As String
Dim vSource() As String
Dim wsTmp As Worksheet, wsFormat As Worksheet, wsWidgetFormat As Worksheet
Dim rTarget As Range, rFormat As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary, dArgs As New Dictionary
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
    vSource = Init2DStringArray([{"Add_Person_Student","Student","StudentAge","Integer","IsValidInteger","","","","Entry";"Add_Person_Student","Student","StudentPrep","IntegerRange","IsValidPrep","","","","Entry"}])
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
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime
    Application.Run C_GENERATE_FORMS, dArgs
    'GenerateForms clsAppRuntime
    
    With clsAppRuntime.AddBook.Sheets("Add_Person_Student")
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
