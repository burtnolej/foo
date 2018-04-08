Attribute VB_Name = "Test_Entry_Utils"
Const CsModuleName = "Test_Entry_Utils"

Sub test()
    TestGenerateEntryFormsLoadRefDataFromDB
End Sub
Function TestGenerateEntryFormsLoadRefDataFromDB() As TestResult
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
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)
    
    sDefn = "NewLesson^Lesson^SFirstName^String^IsMember^&get_person_student^sStudentFirstNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^LastName^String^IsMember^&get_person_student^sStudentLastNm" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^Prep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentFirstNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sStudentLastNm^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idStudent^Integer^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^idPrep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^sPrepNm^String^^^"
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange clsQuadRuntime.Book, rTarget.Address, sSheetName, "Definitions", "True"
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:
    GenerateEntryForms clsQuadRuntime, bLoadRefData:=True

    ' reset to simulate worksheet callbacks in normal runtime; force defaults need to be reloaded
    EventsToggle True
    Set Entry_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    With ActiveWorkbook.Sheets(sTargetSheetName)
    'With clsQuadRuntime.Book.Sheets(sTargetSheetName)
    
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate ActiveWorkbook, sTargetSheetName, rTarget
        'Validate clsQuadRuntime.Book, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        'Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        'rTarget = "Raskin"
        'Validate clsQuadRuntime.Book, sTargetSheetName, rTarget

        'If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
        '    eTestResult = TestResult.Failure
        '    GoTo teardown
        'End If
        
        'Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        'rTarget = "4"
        'Validate clsQuadRuntime.Book, sTargetSheetName, rTarget

        'If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
        '    eTestResult = TestResult.Failure
        '    GoTo teardown
        'End If
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGenerateEntryFormsLoadRefDataFromDB = eTestResult
    clsQuadRuntime.Delete
    DeleteEntryForms
    DeleteSheet clsQuadRuntime.Book, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName
    
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
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)
    
    sDefn = "NewStudent^person_student^Name^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^Age^Integer^IsInteger^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewStudent^person_student^Prep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^Name^String^^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^Age^Integer^IsInteger^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewTeacher^person_teacher^Prep^Integer^IsValidPrep^^" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^StudentName^String^IsMember^person_student^Name" & DOUBLEDOLLAR
    sDefn = sDefn & "NewLesson^Lesson^TeacherName^String^IsMember^person_teacher^Name"
    vSource = Init2DStringArrayFromString(sDefn)
    
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Jon^45^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Quinton^6^2"
    vStudents = Init2DStringArrayFromString(sDefn)
    sCacheSheetName = CacheData(clsQuadRuntime, vStudents, QuadDataType.person, QuadSubDataType.student, bInTable:=True)
    
    sDefn = "Name^Age^Prep" & DOUBLEDOLLAR
    sDefn = sDefn & "Nancy^46^1" & DOUBLEDOLLAR
    sDefn = sDefn & "Betty^36^2"
    vTeachers = Init2DStringArrayFromString(sDefn)
    sCacheSheetName = CacheData(clsQuadRuntime, vTeachers, QuadDataType.person, QuadSubDataType.teacher, bInTable:=True)
    
main:

    GenerateEntryForms clsQuadRuntime, bLoadRefData:=False
    
    EventsToggle True
    With clsQuadRuntime.Book.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Jon"
        Validate clsQuadRuntime.Book, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Betty"
        Validate clsQuadRuntime.Book, sTargetSheetName, rTarget

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
    clsQuadRuntime.Delete
    DeleteEntryForms
    DeleteSheet clsQuadRuntime.Book, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName
    
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
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewStudent","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateEntryForms clsQuadRuntime
    
    If SheetExists(clsQuadRuntime.Book, sTargetSheetName) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    With clsQuadRuntime.Book.Sheets(sTargetSheetName)
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = 123

        Validate clsQuadRuntime.Book, sTargetSheetName, rTarget

        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = 4
        
        Validate clsQuadRuntime.Book, sTargetSheetName, rTarget
        
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.CacheBook, "NewStudent", clsQuadRuntime.TemplateCellSheetName
        
        If GetBgColor(sTargetSheetName, clsQuadRuntime.Book.Sheets(sTargetSheetName).Range("bNewStudent")).AsString <> "51,204,51" Then
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
    clsQuadRuntime.Delete
    DeleteEntryForms
    DeleteSheet clsQuadRuntime.Book, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName
    
End Function

Function TestGenerateEntryFormsMulti() As TestResult
' multiple entry forms
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
Dim rEntry As Range
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "GenerateEntryFormsMulti"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewTeacher","Teacher","TeacherAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateEntryForms clsQuadRuntime
    
    If SheetExists(ActiveWorkbook, "NewStudent") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If SheetExists(ActiveWorkbook, "NewTeacher") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rEntry = GetEntryCell("NewStudent", "StudentAge")
    rEntry.Value = 123
    Validate clsQuadRuntime.Book, "NewStudent", rEntry
    
    If IsEntryValid("NewStudent", rEntry) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rEntry = GetEntryCell("NewTeacher", "TeacherAge")
    rEntry.Value = 666
    Validate clsQuadRuntime.Book, "NewTeacher", rEntry
    
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
    TestGenerateEntryFormsMulti = eTestResult
    clsQuadRuntime.Delete
    DeleteEntryForms
    DeleteSheet clsQuadRuntime.Book, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName

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
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "LoadDefinitions"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentName","List","foo";"NewStudent","Student","StudentPrep","IntegerRange","gt0_lt100"}])
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
Function TestIsValidInteger() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "IsValidInteger"

main:
    If IsValidInteger(123) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger("ABC") <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(123) = True Then
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
 
    If IsValidInteger("ABC") = False Then
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
    
End Function
Function TestIsValidPrep() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "IsValidPrep"

main:
    If IsValidPrep(1) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidPrep(11) <> False Then
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
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "Validations"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewStudent","Student","StudentAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
main:
    With wsTmp
        Set rInput = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rInput.Value = 123
    rInput.Name = "eNewStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.Book, "test", rInput)
    
    If bResult = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    rInput.Value = "ABC"
    rInput.Name = "eNewStudent_StudentAge"
    bResult = Validate(clsQuadRuntime.Book, "test", rInput)
    
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
    clsQuadRuntime.Delete
    DeleteSheet ActiveWorkbook, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName
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
    On Error GoTo err:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = CsModuleName & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    AddTableRecordAuto ActiveWorkbook, "foo", vColNames, vRows
    
main:
   
    If IsMember("Jon", "Foo", Array("Foo", "FooName")) <> True Then
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
    clsQuadRuntime.Delete
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
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
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewFoo","Foo","FooName","List","IsMember";"NewFoo","Foo","FooAge","Integer","IsValidInteger";"NewBar","Bar","BarName","List","IsMember";"NewBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    CreateTables
    AddTableRecordAuto ActiveWorkbook, "foo", vColNames, vRows
    
main:
    If IsMember("Nancy", "Foo", Array("Foo", "FooName")) <> False Then
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
    clsQuadRuntime.Delete
    DeleteSheet ActiveWorkbook, sSheetName
    DeleteSheet ActiveWorkbook, "Foo"
    DeleteSheet ActiveWorkbook, "Bar"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
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
    On Error GoTo err:
    sFuncName = CsModuleName & "." & "IsRecordValid"
    sSheetName = "TestNewStudent"
    sFieldName1 = "StudentAge"
    sFieldName2 = "StudentName"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"TestNewStudent","Student","StudentAge","Integer","IsValidInteger";"TestNewStudent","Student","StudentName","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)
    
    sKey = "e" & sSheetName & "_" & sFieldName1
    Set rInput = GenerateEntry(sSheetName, sKey, sSheetName, 4)
    rInput.Value = 123
    bResult = Validate(ActiveWorkbook, sSheetName, rInput)
    
    If bResult <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    sKey = "e" & sSheetName & "_" & sFieldName2
    Set rInput = GenerateEntry(sSheetName, sKey, sSheetName, 5)
    rInput.Value = "ABC"
    bResult = Validate(ActiveWorkbook, sSheetName, rInput)
    
    If bResult <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If IsRecordValid(clsQuadRuntime.TemplateBook, clsQuadRuntime.Book, sSheetName, _
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
    clsQuadRuntime.Delete
    DeleteSheet ActiveWorkbook, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName
    
End Function
