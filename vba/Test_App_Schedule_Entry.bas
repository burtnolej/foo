Attribute VB_Name = "Test_App_Schedule_Entry"
Option Explicit
Const CsModuleName = "App_Schedule_Entry"
Public Function FillEntryValues(vValues() As String, iCol As Integer, iFirstRow As Integer, _
    sTargetSheetName As String, iNumEntries As Integer, Optional bValidate As Boolean = True, _
    Optional wbTmp As Workbook) As Boolean
Dim rTarget As Range, rCell As Range
Dim i As Integer

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    With wbTmp.Sheets(sTargetSheetName)
        For i = 0 To iNumEntries - 1
            Set rTarget = .Range(.Cells(iFirstRow + i, iCol), .Cells(iFirstRow + i, iCol))
            rTarget = vValues(i)
            If Validate(wbTmp, sTargetSheetName, rTarget) = False Then
                FillEntryValues = False
                Exit Function
            End If
        Next i
    End With
       
    FillEntryValues = True
End Function


Function Test_AddNewScheduleEntry_Multiple() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim rTarget As Range, rCell As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer
Dim vEntryValues() As String

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "Test_AddNewScheduleEntry_Multiple"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "NewLesson"
    ReDim vEntryValues(0 To 8)
    
main:
    GenerateScheduleEntry clsQuadRuntime
    
    EventsToggle True
    Set Entry_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
        vEntryValues = InitStringArray(Array("Bruno", "Raskin", "David", "Stone", "Art", "Art", "Luna", "4", "M"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 9, wbTmp:=clsQuadRuntime.EntryBook
    
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.EntryBook, "NewLesson", clsQuadRuntime.TemplateCellSheetName

        Set rCell = NewLesson()
        
        vEntryValues = InitStringArray(Array("Bruno", "Raskin", "David", "Stone", "Math", "Math", "Luna", "4", "T"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 9, wbTmp:=clsQuadRuntime.EntryBook
        
        Set rCell = NewLesson()
        
        vEntryValues = InitStringArray(Array("Bruno", "Raskin", "David", "Stone", "History", "History", "Luna", "4", "W"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 9, wbTmp:=clsQuadRuntime.EntryBook
        
        Set rCell = NewLesson()
        
        If rCell.Address <> "$H$16:$I$19" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rCell.Columns(2).Rows(1).value <> "History" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set dRecordValues = GetTableRecord("schedule_student", 1, wbTmp:=clsQuadRuntime.CacheBook)
        
        If dRecordValues.Exists("sFacultyLastNm") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("sFacultyLastNm") <> "Stone" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddNewScheduleEntry_Multiple = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.Book, sSheetName
    clsQuadRuntime.Delete
    
End Function
Function Test_AddNewScheduleEntryOverrideScheduleName() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String, sScheduleName As String, sSchedulePath As String
Dim rTarget As Range, rCell As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "Test_AddNewScheduleEntry"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "NewLesson"
    
main:
    GenerateScheduleEntry clsQuadRuntime
    
    EventsToggle True
    Set Entry_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile

    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
    
        ' SFirstName
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' SLastName
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Raskin"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' TFirstName
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "David"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' TLastName
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "Stone"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' CourseName
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = "Art"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' SubjectName
        Set rTarget = .Range(.Cells(7, 2), .Cells(7, 2))
        rTarget = "Science"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' Prep
        Set rTarget = .Range(.Cells(8, 2), .Cells(8, 2))
        rTarget = "Luna"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' TimePeriod
        Set rTarget = .Range(.Cells(9, 2), .Cells(9, 2))
        rTarget = "4"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' Day
        Set rTarget = .Range(.Cells(10, 2), .Cells(10, 2))
        rTarget = "M"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.EntryBook, "NewLesson", clsQuadRuntime.TemplateCellSheetName

        Set rCell = NewLesson()
        
        If clsQuadRuntime.ScheduleBook.Sheets("view_student_13").Range("E16:E16").value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rCell.Address <> "$D$16:$E$19" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rCell.Columns(2).Rows(1).value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set dRecordValues = GetTableRecord("schedule_student", 1, wbTmp:=clsQuadRuntime.CacheBook)
        
        If dRecordValues.Exists("sFacultyLastNm") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("sFacultyLastNm") <> "Stone" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddNewScheduleEntryOverrideScheduleName = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.Book, sSheetName
    clsQuadRuntime.Delete
End Function

Function Test_AddNewScheduleEntry() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim rTarget As Range, rCell As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "Test_AddNewScheduleEntry"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "NewLesson"
    
main:
    GenerateScheduleEntry clsQuadRuntime
    
    EventsToggle True
    Set Entry_Utils.dDefinitions = Nothing
    clsQuadRuntime.CloseRuntimeCacheFile
    
    'need to test that the extra row has been added
    
    With clsQuadRuntime.EntryBook.Sheets(sTargetSheetName)
    
        ' SFirstName
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' SLastName
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Raskin"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' TFirstName
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "David"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' TLastName
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "Stone"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' CourseName
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = "Art"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' SubjectName
        Set rTarget = .Range(.Cells(7, 2), .Cells(7, 2))
        rTarget = "Science"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' Prep
        Set rTarget = .Range(.Cells(8, 2), .Cells(8, 2))
        rTarget = "Luna"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' TimePeriod
        Set rTarget = .Range(.Cells(9, 2), .Cells(9, 2))
        rTarget = "4"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' Day
        Set rTarget = .Range(.Cells(10, 2), .Cells(10, 2))
        rTarget = "M"
        Validate clsQuadRuntime.EntryBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsQuadRuntime.TemplateBook, clsQuadRuntime.EntryBook, "NewLesson", clsQuadRuntime.TemplateCellSheetName

        Set rCell = NewLesson()
        
        If rCell.Address <> "$D$16:$E$19" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rCell.Columns(2).Rows(1).value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set dRecordValues = GetTableRecord("schedule_student", 1, wbTmp:=clsQuadRuntime.CacheBook)
        
        If dRecordValues.Exists("sFacultyLastNm") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("sFacultyLastNm") <> "Stone" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddNewScheduleEntry = eTestResult
    DeleteEntryForms wbTmp:=clsQuadRuntime.EntryBook
    DeleteSheet clsQuadRuntime.Book, sSheetName
    clsQuadRuntime.Delete
    
End Function
Sub test()
    Test_EditLesson
End Sub
Function Test_EditLesson() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim dRecordValues As Dictionary

setup:
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "EditLesson"
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
main:
    ' force using "Definitions" not "test"
    Set Entry_Utils.dDefinitions = LoadDefinitions(ActiveWorkbook.Sheets("Definitions"), _
                rSource:=ActiveWorkbook.Sheets("Definitions").Range("Definitions"))

    EditLesson 70, "M", 1

    If clsQuadRuntime.EntryBook.Sheets("NewLesson").Range("eNewLesson_sFacultyFirstNm").value = "Isaac" Then
        eTestResult = TestResult.OK
        GoTo teardown
    Else
        eTestResult = TestResult.Failure
    End If

err:
    eTestResult = TestResult.Error

teardown:
    Test_EditLesson = eTestResult
    DeleteSheet clsQuadRuntime.Book, sSheetName
    clsQuadRuntime.Delete
    
End Function
