Attribute VB_Name = "Test_Quad_Schedule_View"
Option Explicit
'Test_ParseRawData
'Test_GetScheduleDataFromDB
'Test_GetScheduleDataFromDB_1Period1Student
'Test_BuildSchedule_Student_Cached
'Test_BuildSchedule_Student_NotCached
'Test_BuildSchedule_Student_Multi
Const C_MODULE_NAME = "Test_Quad_Schedule_View"

Public Function Test_GenerateScheduleLessonListView() As TestResult

'<<<
'purpose: simple wrapper to launch a Student View workflow
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
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleLessonListView"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iStudentID", 2
    'GenerateScheduleLessonListView clsAppRuntime, 2
    GenerateScheduleLessonListView dArgs
        
    Set rViewListColumn = clsAppRuntime.ViewBook.Sheets("ViewList_Schedule_Lesson").Range("lViewList_Schedule_Lesson_idStudent")
    
    If rViewListColumn.Rows(1).value <> "2" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GenerateScheduleLessonListView = eTestResult
    clsAppRuntime.Delete
    
End Function

Public Function Test_BuildSchedule_Student_OverideScheduleBook() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsAppRuntime As New App_Runtime
Dim sScheduleName As String, sSchedulePath As String
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties sScheduleBookName:=sScheduleName, sScheduleBookPath:=sSchedulePath
    iPersonID = 70
    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add
    
    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student
    Set wsSchedule = BuildSchedule(dArgs)
    
    With wsSchedule
        Set rResult = .Range("L20:M23")
        
        If rResult.Columns(2).Rows(1).value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(2).Rows(2).value <> "David[Seminar]" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(2).Rows(3).value <> "Room:14" Then
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
    Test_BuildSchedule_Student_OverideScheduleBook = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, wsSchedule.Name
    clsAppRuntime.Delete

End Function

Public Function Test_BuildScheduleHeaders() As TestResult
Dim sSheetName As String, sFuncName As String, sTemplateRangeName As String, sTargetSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String, vKeys() As String, vValues As Variant
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer, iSourceColHeight As Integer, iTargetColHeight As Integer
Dim clsAppRuntime As New App_Runtime
Dim dValues As New Dictionary

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleHeaders"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "AddLesson"
    
main:
    GenerateScheduleAdd clsAppRuntime
    
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleCell"
    
    'clsAppRuntime.InitProperties
    sSheetName = "view_student_70"
    Set wsSchedule = CreateSheet(clsAppRuntime.ScheduleBook, sSheetName)
    
    sTemplateRangeName = "f" & "student" & "ScheduleRowLabel"
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.PeriodEnum, iFormatWidth, iFormatHeight
    
    sTemplateRangeName = "f" & "student" & "ScheduleColLabel"
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.DayEnum, iFormatWidth, iFormatHeight, iStartCol:=2, iStartRow:=2, bVz:=False
    
    iSourceColHeight = clsAppRuntime.TemplateBook.Names(sTemplateRangeName).RefersToRange.Columns(1).EntireColumn.ColumnWidth
    
    iTargetColHeight = clsAppRuntime.ScheduleBook.Sheets(sSheetName).Range("B1:B1").EntireColumn.ColumnWidth
    If iSourceColHeight <> iTargetColHeight Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If clsAppRuntime.ScheduleBook.Sheets(sSheetName).Range("E1:E1").value <> "T" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_BuildScheduleHeaders = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, sSheetName
    clsAppRuntime.Delete
End Function


Public Function Test_CacheAppRuntimePtr() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim wbBook As Workbook

setup:
    clsAppRuntime.InitProperties sDayEnum:="foobar", bInitializeCache:=True
    LetAppRuntimeGlobal clsAppRuntime
    Set clsAppRuntime = Nothing
    
main:

    Set clsAppRuntime = GetAppRuntimeGlobal

    If IsAppRuntime(clsAppRuntime) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If clsAppRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If


    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CacheAppRuntimePtr = eTestResult
    clsAppRuntime.Delete

End Function

Public Function Test_BuildSchedule_Student_Multi() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

    
setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70
    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add
    
    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student
    Set wsSchedule = BuildSchedule(dArgs)
    
    AddDict dArgs, "iPersonID", iPersonID - 1, bUpdate:=True
    Set wsSchedule = BuildSchedule(dArgs)
    
    AddDict dArgs, "iPersonID", iPersonID - 2, bUpdate:=True
    Set wsSchedule = BuildSchedule(dArgs)
    
    AddDict dArgs, "iPersonID", iPersonID - 3, bUpdate:=True
    Set wsSchedule = BuildSchedule(dArgs)
    
    AddDict dArgs, "iPersonID", iPersonID - 4, bUpdate:=True
    Set wsSchedule = BuildSchedule(dArgs)

    With ActiveWorkbook
        If "view_student_66,view_student_67,view_student_68,view_student_69,view_student_70,Sheet1" <> Join(GetSheets(clsAppRuntime.ScheduleBook), ",") Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If "person_student,schedule_student_70,schedule_student_69,schedule_student_68,schedule_student_67,schedule_student_66,Sheet1" <> Join(GetSheets(clsAppRuntime.CacheBook), ",") Then
            Debug.Print Join(GetSheets(clsAppRuntime.CacheBook), ",")
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    DeleteSheet clsAppRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.Student) & "_" & CStr(iPersonID)
    DeleteSheet clsAppRuntime.CacheBook, wsSchedule.Name
    clsAppRuntime.Delete
    
End Function
Public Function Test_BuildScheduleCell() As TestResult
Dim sSheetName As String, sFuncName As String, sTemplateRangeName As String
Dim eTestResult As TestResult
Dim aSchedule() As String, vKeys() As String, vValues As Variant
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsAppRuntime As New App_Runtime
Dim dValues As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleCell"
    sTemplateRangeName = "f" & "student" & "ScheduleCell"
    
    clsAppRuntime.InitProperties
    sSheetName = "view_student_70"
    Set wsSchedule = CreateSheet(clsAppRuntime.ScheduleBook, sSheetName)
    
    vKeys = Split("sSubjectLongDesc,sCourseNm,sClassFocusArea,sFacultyFirstNm,cdDay,idTimePeriod,idLocation,idSection,cdClassType,iFreq,idClassLecture", COMMA)
    vValues = Split("Homeroom,Homeroom,None,Isaac,M,1,9,165,Seminar,5,993", COMMA)
    Set dValues = InitDict(vKeys, vValues)
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsAppRuntime, sTemplateRangeName, iColWidthCount)
        
    BuildScheduleCellView clsAppRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths
                                  
    With wsSchedule
    
        Set rResult = .Range("D4:E7")
        'Set rResult = .Range("C4:E7")
        
        If rResult.Columns(2).Rows(1).value <> "Homeroom" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(2).Rows(2).value <> "Isaac[Seminar]" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(2).Rows(3).value <> "Room:9" Then
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
    Test_BuildScheduleCell = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, sSheetName
    clsAppRuntime.Delete
    
End Function

Public Function Test_BuildSchedule_Student_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

setup:
    
    clsAppRuntime.InitProperties
    iPersonID = 70
    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add

    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student
    Set wsSchedule = BuildSchedule(dArgs)
                              
    With wsSchedule
        
        Set rResult = .Range("L20:M23")
        
        If rResult.Columns(2).Rows(1).value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(2).Rows(2).value <> "David[Seminar]" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(2).Rows(3).value <> "Room:14" Then
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
    Test_BuildSchedule_Student_NotCached = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, wsSchedule.Name
    clsAppRuntime.Delete
    
End Function



Public Function Test_BuildSchedule_Student_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sTemplateBookName As String, sCacheBookName As String, sTemplateBookPath As String, sResultFileName As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As Variant
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70
    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add

    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student
    
    'GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, QuadSubDataType.Student
    GetPersonScheduleDataFromDB dArgs
    aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, QuadSubDataType.Student, iPersonID)
    
main:

    Set wsSchedule = BuildSchedule(dArgs)
    'Set wsSchedule = BuildSchedule(clsAppRuntime, QuadSubDataType.Student, iPersonID)
                              
    With wsSchedule
        Set rResult = .Range("L20:M23")
        
        If rResult.Columns(2).Rows(1).value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(2).Rows(2).value <> "David[Seminar]" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(2).Rows(3).value <> "Room:14" Then
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
    Test_BuildSchedule_Student_Cached = eTestResult
    DeleteSheet clsAppRuntime.ScheduleBook, wsSchedule.Name
    clsAppRuntime.Delete
    
End Function


Public Function Test_CacheData_Schedule() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As Variant
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="test"
    iPersonID = 70
    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add
    
    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student

    'GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, QuadSubDataType.Student
    GetPersonScheduleDataFromDB dArgs
    aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, QuadSubDataType.Student, iPersonID)
 
    With clsAppRuntime.CacheBook.Sheets(sCacheSheetName)
        If .Range(.Cells(47, 11), .Cells(47, 11)).value <> 1573 Then
            eTestResult = TestResult.Failure
            GoTo teardown
        Else
            eTestResult = TestResult.OK
        End If
    End With
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CacheData_Schedule = eTestResult
    clsAppRuntime.Delete
    
End Function
Public Function Test_ParseRawData() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As Variant
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70

    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student

    'GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, QuadDataType.Schedule
    GetPersonScheduleDataFromDB dArgs
    
    aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
 
    If aSchedule(46, 10) <> 1573 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    Else
        eTestResult = TestResult.OK
    End If
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_ParseRawData = eTestResult
    clsAppRuntime.Delete
    
End Function
Public Function Test_GetScheduleDataFromDB() As TestResult
'"" get a subset of the schedule for more than 1 student to test basics
'""
Dim sResultStr As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70
    GetDefinition clsAppRuntime, "Schedule", "Student", "test", FormType.Add

    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student, "sPeriod", "1,2", "sDay", "M,F"

main:
    'GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, QuadSubDataType.Student, sPeriod:="1,2", sDay:="M,F"
    GetPersonScheduleDataFromDB dArgs

   If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Split(Split(sResultStr, "$$")(4), "^")(2) <> "Typing.com" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetScheduleDataFromDB = eTestResult
    clsAppRuntime.Delete
    
End Function
Public Function Test_GetScheduleDataFromDB_1Period1Student() As TestResult
'"" get 1 period of a  schedule for 1 student
'""
Dim sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim dArgs As New Dictionary

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70


    clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    AddArgs dArgs, True, "clsExecProc", clsExecProc, "clsAppRuntime", clsAppRuntime, "iPersonID", iPersonID, "eQuadSubDataType", QuadSubDataType.Student, "sPeriod", "1"

main:
    'GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, QuadSubDataType.Student, sPeriod:="1"
    GetPersonScheduleDataFromDB dArgs
    
    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
           
    sExpectedResult = "sSubjectLongDesc^sCourseNm^sClassFocusArea^sFacultyFirstNm^cdDay^idTimePeriod^idLocation^idSection^cdClassType^iFreq^idClassLecture$$Homeroom^Homeroom^None^Isaac^M^1^9^165^Seminar^5^993$$Homeroom^Homeroom^None^Isaac^T^1^9^165^Seminar^5^994$$Homeroom^Homeroom^None^Isaac^W^1^9^165^Seminar^5^995$$Homeroom^Homeroom^None^Isaac^R^1^9^165^Seminar^5^996$$Homeroom^Homeroom^None^Isaac^F^1^9^165^Seminar^5^997"
    
    If sExpectedResult <> sResultStr Then
        eTestResult = TestResult.Failure
        GoTo teardown
    Else
        eTestResult = TestResult.OK
    End If
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetScheduleDataFromDB_1Period1Student = eTestResult
    clsAppRuntime.Delete

    
End Function

