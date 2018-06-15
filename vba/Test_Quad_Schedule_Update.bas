Attribute VB_Name = "Test_Quad_Schedule_Update"
Option Explicit
Const C_MODULE_NAME = "Test_Quad_Schedule_View"
Public Function Test_GenerateScheduleLessonListViewUpdate_Simulation() As TestResult
'<<<
'purpose: generate a listview then simulate updating and make sure that the widgets are not
'       : redrawn but values are updated
'>>>
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long
Dim eTestResult As TestResult
Dim rTarget As Range, rViewListColumn As Range
Dim dArgs As New Dictionary

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleLessonListViewUpdate_Simulation"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iStudentID", 2
    Application.Run C_GENERATE_SCHEDULE_LESSON_LIST_VIEW, dArgs
    AddDict dArgs, "iStudentID", 3, bUpdate:=True
    Application.Run C_GENERATE_SCHEDULE_LESSON_LIST_VIEW, dArgs
        
    Set rViewListColumn = clsAppRuntime.ViewBook.Sheets("ViewList_Schedule_Lesson").Range("lViewList_Schedule_Lesson_idStudent")
    
    If rViewListColumn.Rows(1).value <> "3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GenerateScheduleLessonListViewUpdate_Simulation = eTestResult
    clsAppRuntime.Delete
    
End Function


Public Function Test_GenerateScheduleLessonListViewUpdate() As TestResult
'<<<
'purpose: update listview via selector widget
'>>>
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long
Dim eTestResult As TestResult
Dim rTarget As Range, rViewListColumn As Range
Dim dArgs As New Dictionary

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    sFuncName = C_MODULE_NAME & "." & "Test_GenerateScheduleLessonListViewUpdate"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iStudentID", 2
    Application.Run C_GENERATE_SCHEDULE_LESSON_LIST_VIEW, dArgs
    
    EventsToggle True
    With clsAppRuntime.ViewBook.Sheets("ViewList_Schedule_Lesson")
        Set rTarget = .Range(.Cells(1, 2), .Cells(1, 2))
        rTarget = "3"
        ValidateWidget clsAppRuntime.ViewBook, "ViewList_Schedule_Lesson", rTarget
    End With

    Set rViewListColumn = clsAppRuntime.ViewBook.Sheets("ViewList_Schedule_Lesson").Range("lViewList_Schedule_Lesson_idStudent")
    
    If rViewListColumn.Rows(1).value <> "3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GenerateScheduleLessonListViewUpdate = eTestResult
    clsAppRuntime.Delete
    
End Function
