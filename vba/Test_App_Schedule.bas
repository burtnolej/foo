Attribute VB_Name = "Test_App_Schedule"
Option Explicit
'Test_ParseRawData
'Test_GetScheduleDataFromDB
'Test_GetScheduleDataFromDB_1Period1Student
'Test_BuildSchedule_Student_Cached
'Test_BuildSchedule_Student_NotCached
'Test_BuildSchedule_Student_Multi
Const C_MODULE_NAME = "Test_App_Schedule"

Public Function Test_BuildSchedule_Student_OverideScheduleBook() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime
Dim sScheduleName As String, sSchedulePath As String

    sScheduleName = "schedule.xlsm"
    sSchedulePath = GetHomePath() & "\"
    
    CreateBook sScheduleName, sSchedulePath
    clsQuadRuntime.InitProperties sScheduleBookName:=sScheduleName, sScheduleBookPath:=sSchedulePath
            
    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID)
                              
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.Student) & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    CloseBook clsQuadRuntime.ScheduleBook
    DeleteBook clsQuadRuntime.ScheduleBookName, clsQuadRuntime.ScheduleBookPath

End Function

Public Function Test_BuildScheduleHeaders() As TestResult
Dim sSheetName As String, sFuncName As String, sTemplateRangeName As String, sTargetSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String, vKeys() As String, vValues As Variant
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer, iSourceColHeight As Integer, iTargetColHeight As Integer
Dim clsQuadRuntime As New Quad_Runtime
Dim dValues As New Dictionary

setup:
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleHeaders"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    sTargetSheetName = "NewLesson"
    
main:
    GenerateScheduleEntry clsQuadRuntime
    
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleCell"
    
    'clsQuadRuntime.InitProperties
    sSheetName = "view_student_70"
    Set wsSchedule = CreateSheet(clsQuadRuntime.CacheBook, sSheetName)
    
    sTemplateRangeName = "f" & "student" & "ScheduleRowLabel"
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    BuildScheduleHeaderView clsQuadRuntime, wsSchedule, clsQuadRuntime.PeriodEnum, iFormatWidth, iFormatHeight
    
    sTemplateRangeName = "f" & "student" & "ScheduleColLabel"
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    BuildScheduleHeaderView clsQuadRuntime, wsSchedule, clsQuadRuntime.DayEnum, iFormatWidth, iFormatHeight, iStartCol:=2, iStartRow:=2, bVz:=False

    iSourceColHeight = clsQuadRuntime.TemplateBook.Sheets("FormStyles").Range(sTemplateRangeName).Columns(1).EntireColumn.ColumnWidth
    iTargetColHeight = clsQuadRuntime.CacheBook.Sheets(sSheetName).Range("B1:B1").EntireColumn.ColumnWidth
    If iSourceColHeight <> iTargetColHeight Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_BuildScheduleHeaders = eTestResult
    clsQuadRuntime.Delete
    'DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.student) & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
End Function


Public Function Test_CacheQuadRuntimePtr() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime
Dim wbBook As Workbook

setup:
    clsQuadRuntime.InitProperties sDayEnum:="foobar", bInitializeCache:=True
    LetQuadRuntimeGlobal clsQuadRuntime
    Set clsQuadRuntime = Nothing
    
main:

    Set clsQuadRuntime = GetQuadRuntimeGlobal

    If IsQuadRuntime(clsQuadRuntime) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If clsQuadRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If


    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_CacheQuadRuntimePtr = eTestResult
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

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
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID - 1)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID - 2)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID - 3)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID - 4)
                              
    With ActiveWorkbook
        If "view_student_66,schedule_student_66,view_student_67,schedule_student_67,view_student_68,schedule_student_68,view_student_69,schedule_student_69,view_student_70,schedule_student_70,person_student" <> Join(GetSheets(clsQuadRuntime.CacheBook), ",") Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.Student) & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_BuildScheduleCell() As TestResult
Dim sSheetName As String, sFuncName As String, sTemplateRangeName As String
Dim eTestResult As TestResult
Dim aSchedule() As String, vKeys() As String, vValues As Variant
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime
Dim dValues As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildScheduleCell"
    sTemplateRangeName = "f" & "student" & "ScheduleCell"
    
    clsQuadRuntime.InitProperties
    sSheetName = "view_student_70"
    Set wsSchedule = CreateSheet(clsQuadRuntime.CacheBook, sSheetName)
    
    vKeys = Split("sSubjectLongDesc,sCourseNm,sClassFocusArea,sFacultyFirstNm,cdDay,idTimePeriod,idLocation,idSection,cdClassType,iFreq,idClassLecture", COMMA)
    vValues = Split("Homeroom,Homeroom,None,Isaac,M,1,9,165,Seminar,5,993", COMMA)
    Set dValues = InitDict(vKeys, vValues)
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsQuadRuntime, sTemplateRangeName, iColWidthCount)
        
    BuildScheduleCellView clsQuadRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths
                                  
    With wsSchedule
    
        Set rResult = .Range("C4:E7")
        
        If rResult.Columns(3).Rows(1).value <> "Homeroom" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(3).Rows(2).value <> "Isaac[Seminar]" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(3).Rows(3).value <> "Room:9" Then
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
    clsQuadRuntime.Delete
    'DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.student) & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function

Sub test()
    Test_BuildSchedule_Student_NotCached
End Sub
Public Function Test_BuildSchedule_Student_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties
            
    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID)
                              
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.Student) & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_BuildSchedule_Student_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sTemplateBookName As String, sCacheBookName As String, sTemplateBookPath As String, sResultFileName As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, QuadSubDataType.Student
    aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, QuadDataType.schedule, QuadSubDataType.Student, iPersonID)
    
main:
    Set wsSchedule = BuildSchedule(clsQuadRuntime, QuadSubDataType.Student, iPersonID)
                              
    With wsSchedule
        Set rResult = .Range("L20:Q23")
        
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & EnumQuadSubDataType(QuadSubDataType.Student) & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function


Public Function Test_CacheData_Schedule() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, QuadSubDataType.Student
    aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, QuadDataType.schedule, QuadSubDataType.Student, iPersonID)
 
    With clsQuadRuntime.CacheBook.Sheets(sCacheSheetName)
        If .Range(.Cells(47, 11), .Cells(47, 11)).value <> 1476 Then
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
    clsQuadRuntime.Delete
    DeleteSheet clsQuadRuntime.CacheBook, sCacheSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_ParseRawData() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, QuadDataType.schedule
    aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
 
    If aSchedule(46, 10) <> 1476 Then
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
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_GetScheduleDataFromDB() As TestResult
'"" get a subset of the schedule for more than 1 student to test basics
'""
Dim sResultStr As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70

main:
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, QuadSubDataType.Student, _
                sPeriod:="1,2", sDay:="M,F"

   If FileExists(clsQuadRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsQuadRuntime.ResultFileName)
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
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_GetScheduleDataFromDB_1Period1Student() As TestResult
'"" get 1 period of a  schedule for 1 student
'""
Dim sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    iPersonID = 70

main:
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, QuadSubDataType.Student, sPeriod:="1"
    
    If FileExists(clsQuadRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsQuadRuntime.ResultFileName)
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
    clsQuadRuntime.Delete
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function

