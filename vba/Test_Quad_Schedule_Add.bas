Attribute VB_Name = "Test_Quad_Schedule_Add"
Option Explicit
Const C_MODULE_NAME = "Test_Quad_Schedule_Add"
Public Function FillEntryValues(vValues() As String, iCol As Integer, iFirstRow As Integer, _
    sTargetSheetName As String, iNumEntries As Integer, Optional bValidate As Boolean = True, _
    Optional wbTmp As Workbook) As Boolean
Dim rTarget As Range, rWidget As Range
Dim i As Integer

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    With wbTmp.Sheets(sTargetSheetName)
        For i = 0 To iNumEntries - 1
            Set rTarget = .Range(.Cells(iFirstRow + i, iCol), .Cells(iFirstRow + i, iCol))
            rTarget = vValues(i)
            If ValidateWidget(wbTmp, sTargetSheetName, rTarget) = False Then
                FillEntryValues = False
                Exit Function
            End If
        Next i
    End With
       
    FillEntryValues = True
End Function

Public Function Test_InsertScheduleLessonDataToDB() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String, sSheetName As String
Dim dArgs As New Dictionary

setup:
    'On Error GoTo err
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, "Schedule", "Lesson", sSheetName, FormType.Add
    
    vRows = Init2DVariantArray([{2,994,5,7,1,700;2,994,5,8,2,700;2,994,5,9,3,700}])
    vColumns = InitVariantArray(Array("idStudent", "idFaculty", "idDay", "idTimePeriod", "idLocation", "idSection"))

main:
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, _
            "eQuadSubDataType", QuadSubDataType.Student, "vRows", vRows, "vColumns", vColumns
    InsertScheduleLessonDataToDB dArgs

    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, _
            "eQuadSubDataType", QuadSubDataType.Student, "sPeriod", "7", "sDay", "5", "sPersonId", "2"
    GetScheduleLessonDataFromDB dArgs

    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If sResultStr <> "idStudent^idFaculty^idSection^idLocation^idDay^idTimePeriod^idClassLecture$$2^994^700^1^5^7^10000" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_InsertScheduleLessonDataToDB = eTestResult
    clsAppRuntime.Delete
    DeleteClassLectureDataFromDB clsAppRuntime, 10000
    DeleteClassLectureDataFromDB clsAppRuntime, 10001
    DeleteClassLectureDataFromDB clsAppRuntime, 10002
    
End Function


Function Test_AddScheduleLesson_Multiple() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer
Dim vEntryValues() As String
Dim clsExecProc As Exec_Proc

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddScheduleLesson_Multiple"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    sTargetSheetName = "Add_Schedule_Lesson"
    ReDim vEntryValues(0 To 8)
    
main:
    GenerateScheduleAdd clsAppRuntime, clsExecProc, sSheetName
    
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile

    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
        vEntryValues = InitStringArray(Array("2", "994", "700", "1", "5", "7"))
        
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 6, wbTmp:=clsAppRuntime.AddBook
    
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "Add_Schedule_Lesson", clsAppRuntime.TemplateWidgetSheetName

        Set rWidget = AddScheduleLesson()
        vEntryValues = InitStringArray(Array("2", "994", "700", "1", "5", "8"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 6, wbTmp:=clsAppRuntime.AddBook
        
        Set rWidget = AddScheduleLesson()
        vEntryValues = InitStringArray(Array("2", "994", "700", "1", "5", "9"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 6, wbTmp:=clsAppRuntime.AddBook
        
        Set rWidget = AddScheduleLesson()
        
        Set dRecordValues = GetTableRecord("schedule_lesson", 1, wbTmp:=clsAppRuntime.CacheBook)
        
        If dRecordValues.Exists("idStudent") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("idDay") <> "5" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddScheduleLesson_Multiple = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
    
End Function
Function Test_AddScheduleLessonOverrideScheduleName() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String, sScheduleName As String, sSchedulePath As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer
Dim clsExecProc As Exec_Proc

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddScheduleLessonOverrideScheduleName"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    sTargetSheetName = "Add_Schedule_Lesson"
    
main:
    GenerateScheduleAdd clsAppRuntime, clsExecProc
    
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile

    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)

        ' idStudent
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "2"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idFaculty
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "994"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idLocation
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "1"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' idSection
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "700"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idDay
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = "1"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' idTimePeriod
        Set rTarget = .Range(.Cells(7, 2), .Cells(7, 2))
        rTarget = "7"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "Add_Schedule_Lesson", clsAppRuntime.TemplateWidgetSheetName
        
        Set rWidget = AddScheduleLesson()
        
        Set dRecordValues = GetTableRecord("schedule_lesson", 1, wbTmp:=clsAppRuntime.CacheBook)
                
        If dRecordValues.Exists("idStudent") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("idTimePeriod") <> "7" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddScheduleLessonOverrideScheduleName = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
End Function

Function Test_AddScheduleLesson() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer
Dim clsExecProc As Exec_Proc

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddScheduleLesson"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    sTargetSheetName = "Add_Schedule_Lesson"
    
main:
    GenerateScheduleAdd clsAppRuntime, clsExecProc
    
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile
    
    'need to test that the extra row has been added
    
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)

        ' idStudent
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "2"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idFaculty
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "994"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idLocation
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "1"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' idSection
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = "700"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idDay
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = "5"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' idTimePeriod
        Set rTarget = .Range(.Cells(7, 2), .Cells(7, 2))
        rTarget = "7"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
 
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "Add_Schedule_Lesson", clsAppRuntime.TemplateWidgetSheetName

        Set rWidget = AddScheduleLesson()
        
        Set dRecordValues = GetTableRecord("schedule_lesson", 1, wbTmp:=clsAppRuntime.CacheBook)
        
        If dRecordValues.Exists("idStudent") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("idTimePeriod") <> "7" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddScheduleLesson = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
    
End Function
