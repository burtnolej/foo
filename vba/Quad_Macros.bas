Attribute VB_Name = "Quad_Macros"
Option Explicit
Const C_MODULE_NAME = "Quad_Macros"

Public Sub DoGeneratePersonView()
'<<<
'purpose: simple wrapper to launch a Student View workflow
'>>>
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    
    sFuncName = C_MODULE_NAME & "." & "DoGeneratePersonView"
    CloseLogFile
    GetLogFile ' write stdout to a logfile
    'Log_Utils.LogFilter = "0,1,2,3"
        
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    GeneratePersonView clsAppRuntime

cleanup:
    Set wsView = clsAppRuntime.ViewBook.Sheets("ViewStudent")
    wsView.Visible = xlSheetVisible
    wsView.Activate
    DoEventsOn
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub

Public Sub DoAddAddScheduleAdd()
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sFuncName As String
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String

    DoEventsOn
        
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "DoAddAddScheduleAdd"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    GenerateScheduleAdd clsAppRuntime
End Sub

Public Sub DoGenerateScheduleLessonListView()
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
    sFuncName = C_MODULE_NAME & "." & "DoGenerateScheduleLessonListView"
    CloseLogFile
    GetLogFile ' write stdout to a logfile
    'Log_Utils.LogFilter = "0,1,2,3"
    
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iStudentID", 2
    Application.Run C_GENERATE_SCHEDULE_LESSON_LIST_VIEW, dArgs

End Sub

Public Sub DoGenerateScheduleStudentView()
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long
Dim eTestResult As TestResult
Dim rTarget As Range, rViewListColumn As Range
Dim dArgs As New Dictionary
Dim clsExecProc As New Exec_Proc
Dim wsSchedule As Worksheet

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    sFuncName = C_MODULE_NAME & "." & "DoGenerateScheduleStudentView"
    CloseLogFile
    GetLogFile ' write stdout to a logfile
    'Log_Utils.LogFilter = "0,1,2,3"
    
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:

    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add

    clsExecProc.InitProperties wbTmp:=Workbooks(clsAppRuntime.MainBookName)
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", 70, "eQuadSubDataType", QuadSubDataType.Student
    Set wsSchedule = BuildSchedule(dArgs)


End Sub

Public Sub DoGenerateScheduleView()
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long
Dim eTestResult As TestResult
Dim rTarget As Range, rViewListColumn As Range
Dim dArgs As New Dictionary
Dim clsExecProc As New Exec_Proc

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    sFuncName = C_MODULE_NAME & "." & "DoGenerateScheduleLessonListView"
    CloseLogFile
    GetLogFile ' write stdout to a logfile
    'Log_Utils.LogFilter = "0,1,2,3"
    
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False
                                  
    clsExecProc.InitProperties wbTmp:=Workbooks("vba_source_new.xlsm")
    
    
    'Workbooks("vba_source_new.xlsm").Sheets("config").Cells(2, 10).value = ObjPtr(clsExecProc)

main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iStudentID", 2, "sFormName", "ViewSchedule_Schedule_Lesson"
    GenerateScheduleView dArgs

End Sub
    

    
    
