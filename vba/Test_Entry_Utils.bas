Attribute VB_Name = "Test_Entry_Utils"
Const CsModuleName = "Test_Entry_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    TestGenerateEntryForms
    TestGenerateEntryFormsMulti
    TestGenerateEntryFormsIsValid
    
    TestLoadDefinitions
    
    TestValidations
    TestIsValidInteger
    TestIsValidPrep
    TestIsMember
    TestIsRecordValid
    
    Test_FormatCellInvalid

    'GetLogFile
End Sub

Sub TestGenerateEntryForms()

Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim bTestPassed As Boolean
setup:
    
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewStudent","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateEntryForms
    
    If SheetExists(ActiveWorkbook, "NewStudent") = False Then
        GoTo fail
    End If

    With ActiveWorkbook.Sheets("NewStudent")
        .Range(.Cells(2, 2), .Cells(2, 2)) = 123
    End With
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteEntryForms
    'DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub TestGenerateEntryFormsMulti()

Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim bTestPassed As Boolean
Dim rEntry As Range

setup:
    
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewTeacher","Teacher","TeacherAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateEntryForms
    
    If SheetExists(ActiveWorkbook, "NewStudent") = False Then
        GoTo fail
    End If
    
    If SheetExists(ActiveWorkbook, "NewTeacher") = False Then
        GoTo fail
    End If
    
    Set rEntry = GetEntryCell("NewStudent", "StudentAge")
    rEntry.Value = 123
    Validate ActiveWorkbook, "NewStudent", rEntry
    
    If IsEntryValid("NewStudent", rEntry) = False Then
        GoTo fail
    End If
    
    Set rEntry = GetEntryCell("NewTeacher", "TeacherAge")
    rEntry.Value = 666
    Validate ActiveWorkbook, "NewTeacher", rEntry
    
    If IsEntryValid("NewTeacher", rEntry) = False Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteEntryForms
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub TestGenerateEntryFormsIsValid()

Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim bTestPassed As Boolean
setup:
    
    sFuncName = CsModuleName & "." & "GenerateEntryForms"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentAge","Integer","IsValidInteger";"NewStudent","Student","StudentPrep","IntegerRange","IsValidPrep"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Entry_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

main:

    GenerateEntryForms

    With wsTmp
        .Range("B2:B2").Value = 123
        .Range("B3:B3").Value = 666
    End With
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub TestLoadDefinitions()
Dim sFuncName As String
Dim sSheetName As String
Dim sResultStr As String
Dim sExpectedResultStr As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dDefinitions As Dictionary
Dim dDefnDetails As Dictionary
Dim bTestPassed As Boolean
setup:
    
    sFuncName = CsModuleName & "." & "LoadDefinitions"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"NewStudent","Student","StudentName","List","foo";"NewStudent","Student","StudentPrep","IntegerRange","gt0_lt100"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)

main:

    Set dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

    If dDefinitions.Exists("eNewStudent_StudentName") = False Then
        GoTo fail
    End If
    
    On Error GoTo fail
    Set dDefnDetails = dDefinitions.Item("eNewStudent_StudentName")
    On Error GoTo 0
    
    If dDefnDetails.Exists("db_table_name") = False Then
        GoTo fail
    End If
    
    If dDefnDetails.Item("db_table_name") <> "Student" Then
        GoTo fail
    End If
    
    If dDefinitions.Exists("actions") = False Then
        GoTo fail
    End If
    
    If dDefinitions.Item("actions").Keys()(0) <> "NewStudent" Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub TestIsValidInteger()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "IsValidInteger"

main:
    If IsValidInteger(123) <> True Then
        GoTo fail
    End If
    
    If IsValidInteger("ABC") <> False Then
        GoTo fail
    End If
    
    If IsValidInteger(123) = True Then
    Else
        GoTo fail
    End If
 
    If IsValidInteger("ABC") = False Then
    Else
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub TestIsValidPrep()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "IsValidPrep"

main:
    If IsValidPrep(1) <> True Then
        GoTo fail
    End If
    
    If IsValidPrep(11) <> False Then
        GoTo fail
    End If
    
  
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub TestValidations()

Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim bTestPassed As Boolean
Dim rInput As Range

setup:
    
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
    bResult = Validate(ActiveWorkbook, "test", rInput)
    
    If bResult = False Then
        GoTo fail
    End If
    
    rInput.Value = "ABC"
    rInput.Name = "eNewStudent_StudentAge"
    bResult = Validate(ActiveWorkbook, "test", rInput)
    
    If bResult = True Then
        GoTo fail
    End If

success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub
Sub TestIsMember()
Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim bTestPassed As Boolean
Dim rInput As Range
Dim sTableName As String

setup:
    sFuncName = CsModuleName & "." & "IsMember"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AA";"BB";"CC";"DD";"EE";"FF";"GG";"HH"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    
    CreateNamedRange ActiveWorkbook, rTarget.Address, sSheetName, "l" & sSheetName, "True"
    
main:
    If IsMember("BB", sSheetName) <> True Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_FormatCellInvalid()
Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim bTestPassed As Boolean

setup:
    
    sFuncName = CsModuleName & "." & "FormatCellInvalid"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

main:
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
    End With
    
    FormatCellInvalid "test", rTarget
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub TestIsRecordValid()

Dim sFuncName As String
Dim sSheetName As String
Dim sFieldName2 As String
Dim sFieldName1 As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim bTestPassed As Boolean
Dim rInput As Range
Dim sKey As String

setup:
    
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
        GoTo fail
    End If
    
    sKey = "e" & sSheetName & "_" & sFieldName2
    Set rInput = GenerateEntry(sSheetName, sKey, sSheetName, 5)
    rInput.Value = "ABC"
    bResult = Validate(ActiveWorkbook, sSheetName, rInput)
    
    If bResult <> False Then
        GoTo fail
    End If

main:
    If IsRecordValid(sSheetName) = True Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    Debug.Print err.Description
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub
