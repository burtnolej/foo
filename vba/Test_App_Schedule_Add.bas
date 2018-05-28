Attribute VB_Name = "Test_App_Schedule_Add"
Option Explicit
Const C_MODULE_NAME = "App_Schedule_Add"
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


Function Test_AddAddScheduleAdd_Multiple() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer
Dim vEntryValues() As String

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddAddScheduleAdd_Multiple"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "AddLesson"
    ReDim vEntryValues(0 To 8)
    
main:
    GenerateScheduleAdd clsAppRuntime, sSheetName
    
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile

    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
        vEntryValues = InitStringArray(Array("2", "1", "700", "F", "7"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 5, wbTmp:=clsAppRuntime.AddBook

        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "AddLesson", clsAppRuntime.TemplateWidgetSheetName

        Set rWidget = AddLesson()
        
        vEntryValues = InitStringArray(Array("2", "2", "700", "F", "8"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 5, wbTmp:=clsAppRuntime.AddBook
        
        Set rWidget = AddLesson()
        
        vEntryValues = InitStringArray(Array("2", "3", "700", "F", "9"))
        FillEntryValues vEntryValues, 2, 2, sTargetSheetName, 5, wbTmp:=clsAppRuntime.AddBook
        
        Set rWidget = AddLesson()
        
        If rWidget.Address <> "$L$36:$M$39" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rWidget.Columns(2).Rows(1).value <> "Pre Algebra" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set dRecordValues = GetTableRecord("schedule_student", 1, wbTmp:=clsAppRuntime.CacheBook)
        
        If dRecordValues.Exists("idStudent") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("cdDay") <> "F" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddAddScheduleAdd_Multiple = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
    
End Function
Function Test_AddAddScheduleAddOverrideScheduleName() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String, sScheduleName As String, sSchedulePath As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddAddScheduleAddOverrideScheduleName"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "AddLesson"
    
main:
    GenerateScheduleAdd clsAppRuntime
    
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile

    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)

'idStudent 2
'idLocation
'idSection
'cdDay
'idTimePeriod


        ' idStudent
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "2"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' idLocation
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
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
        
        ' cdDay
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "M"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' idTimePeriod
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = "7"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
 
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "AddLesson", clsAppRuntime.TemplateWidgetSheetName

        Set rWidget = AddLesson()
        
        If clsAppRuntime.ScheduleBook.Sheets("view_student_2").Range("E28:E28").value <> "Pre Algebra" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rWidget.Address <> "$D$28:$E$31" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rWidget.Columns(2).Rows(1).value <> "Pre Algebra" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set dRecordValues = GetTableRecord("schedule_student", 1, wbTmp:=clsAppRuntime.CacheBook)
        
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
    Test_AddAddScheduleAddOverrideScheduleName = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
End Function

Function Test_AddAddScheduleAdd() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddAddScheduleAdd"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "AddLesson"
    
main:
    GenerateScheduleAdd clsAppRuntime
    
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
        
        ' idLocation
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
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
        
        ' cdDay
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = "M"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' idTimePeriod
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = "7"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
 
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, "AddLesson", clsAppRuntime.TemplateWidgetSheetName

        Set rWidget = AddLesson()
        
        If clsAppRuntime.ScheduleBook.Sheets("view_student_2").Range("E28:E28").value <> "Pre Algebra" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rWidget.Address <> "$D$28:$E$31" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rWidget.Columns(2).Rows(1).value <> "Pre Algebra" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        Set dRecordValues = GetTableRecord("schedule_student", 1, wbTmp:=clsAppRuntime.CacheBook)
        
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
    Test_AddAddScheduleAdd = eTestResult
    DeleteForms wbTmp:=clsAppRuntime.AddBook
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
    
End Function
Sub test()
    Test_EditLesson
End Sub
Function Test_EditLesson() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String
Dim dRecordValues As Dictionary

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "EditLesson"
    clsAppRuntime.InitProperties bInitializeCache:=True
    
main:
    ' force using "Definitions" not "test"
    Set Form_Utils.dDefinitions = LoadDefinitions(ActiveWorkbook.Sheets("Definitions"), _
                rSource:=ActiveWorkbook.Sheets("Definitions").Range("Definitions"))

    EditLesson 2, "M", 1

    If clsAppRuntime.AddBook.Sheets("AddLesson").Range("eAddLesson_sFacultyFirstNm").value = "Ilyssa" Then
        eTestResult = TestResult.OK
        GoTo teardown
    Else
        eTestResult = TestResult.Failure
    End If

err:
    eTestResult = TestResult.Error

teardown:
    Test_EditLesson = eTestResult
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
    
End Function
