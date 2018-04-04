Attribute VB_Name = "Test_App_Schedule"
Option Explicit
'Test_GetScheduleDataFromDB
'Test_GetScheduleDataFromDB_1Period1Student
'Test_GetAllPersonDataFromDB
'Test_GetPersonDataFromDB
'Test_ParseRawData
'Test_CacheData_Schedule
'Test_CacheData_Person
'Test_BuildSchedule_Student_Cached
'Test_BuildSchedule_Student_NotCached
'Test_BuildSchedule_Student_Multi
'Test_IsValidPersonID_Student
'Test_IsValidPersonID_Student_NotFound
'Test_IsValidPersonID_Teacher
'Test_IsValidPersonID_Teacher_NotFound

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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Public Function Test_IsValidPersonID_Student() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
main:
    If IsValidPersonID(clsQuadRuntime, 70, "student") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Student = eTestResult
    
    DeleteSheet clsQuadRuntime.CacheBook, "person_student"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function

Public Function Test_IsValidPersonID_Student_NotFound() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    If IsValidPersonID(clsQuadRuntime, 999, "student") = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Student_NotFound = eTestResult
    
    DeleteSheet clsQuadRuntime.CacheBook, "person_student"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function
Public Function Test_IsValidPersonID_Teacher() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    If IsValidPersonID(clsQuadRuntime, 70, "teacher") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Teacher = eTestResult
    
    DeleteSheet clsQuadRuntime.CacheBook, "person_student"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName
End Function

Public Function Test_IsValidPersonID_Teacher_NotFound() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    If IsValidPersonID(clsQuadRuntime, 999, "teacher") = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Teacher_NotFound = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, "person_student"
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

End Function
Public Function Test_BuildSchedule_Student_Multi() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sScheduleType As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sScheduleType = "student"

    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID - 1)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID - 2)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID - 3)
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID - 4)
                              
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
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & sScheduleType & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function

Public Function Test_BuildSchedule_Student_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sScheduleType As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties
            
    sScheduleType = "student"
    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID)
                              
    With wsSchedule
        Set rResult = .Range("O20:Q23")
        
        If rResult.Columns(3).Rows(1).Value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(3).Rows(2).Value <> "David[Seminar]" Then
            Debug.Print rResult.Columns(3).Rows(2).Value
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(3).Rows(3).Value <> "Room:14" Then
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
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & sScheduleType & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_BuildSchedule_Student_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sTemplateBookName As String, sCacheBookName As String, sScheduleType As String, sTemplateBookPath As String, sDataType As String, sResultFileName As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sScheduleType = "student"
    iPersonID = 70
    sDataType = "schedule"
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, sScheduleType
    aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, sDataType, sScheduleType, iPersonID)
    
main:
    Set wsSchedule = BuildSchedule(clsQuadRuntime, sScheduleType, iPersonID)
                              
    With wsSchedule
        Set rResult = .Range("O20:Q23")
        
        If rResult.Columns(3).Rows(1).Value <> "Art" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If rResult.Columns(3).Rows(2).Value <> "David[Seminar]" Then
            Debug.Print rResult.Columns(3).Rows(2).Value
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        If rResult.Columns(3).Rows(3).Value <> "Room:14" Then
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
    DeleteSheet clsQuadRuntime.CacheBook, "schedule_" & sScheduleType & "_" & CStr(iPersonID)
    DeleteSheet clsQuadRuntime.CacheBook, wsSchedule.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function

Public Function Test_GetAllPersonDataFromDB() As TestResult
Dim sScheduleType As String, sScope As String, sResultStr As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sScheduleType = "student"
    sScope = "all"
    GetPersonDataFromDB clsQuadRuntime, sScheduleType, sScope:=sScope
    
    If FileExists(clsQuadRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsQuadRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If UBound(Split(sResultStr, "$$")) <> 82 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetAllPersonDataFromDB = eTestResult
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_GetPersonDataFromDB() As TestResult
Dim sScheduleType As String, sScope As String, sResultStr As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sScheduleType = "student"
    sScope = "specified"
    
    GetPersonDataFromDB clsQuadRuntime, sScheduleType, sScope:=sScope, iPersonID:=70
    
    If FileExists(clsQuadRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsQuadRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If Split(Split(sResultStr, "$$")(1), "^")(0) <> "Donovan" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetPersonDataFromDB = eTestResult
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function


Public Function Test_GetScheduleDataFromDB() As TestResult
'"" get a subset of the schedule for more than 1 student to test basics
'""
Dim sScheduleType As String, sResultStr As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sScheduleType = "student"
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, sScheduleType, sPeriod:="1,2", sDay:="M,F"

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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_GetScheduleDataFromDB_1Period1Student() As TestResult
'"" get 1 period of a  schedule for 1 student
'""
Dim sScheduleType As String, sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sScheduleType = "student"
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, sScheduleType, sPeriod:="1"
    
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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_CacheData_Schedule() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sDataType As String, sDataSubType As String, sResultStr As String, sExpectedResult As String, sCacheSheetName As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True

    sDataType = "schedule"
    sDataSubType = "student"
    
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, sDataSubType
    aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
    sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, sDataType, sDataSubType, iPersonID)
 
    With clsQuadRuntime.CacheBook.Sheets(sCacheSheetName)
        If .Range(.Cells(47, 11), .Cells(47, 11)).Value <> 1476 Then
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
    DeleteSheet clsQuadRuntime.CacheBook, sCacheSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function

Public Function Test_GetPersonData_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sDataType As String, sDataSubType As String, sResultStr As String, sExpectedResult As String, sCacheSheetName As String, sScope As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    sDataType = "person"
    sDataSubType = "student"
    sScope = "all"
    
    GetPersonData clsQuadRuntime, sDataSubType, sScope:=sScope

main:

    Set wsCache = GetPersonData(clsQuadRuntime, sDataSubType, sScope:=sScope)
    With wsCache
        If .Range(.Cells(83, 5), .Cells(83, 5)).Value <> "Photon" Then
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
    Test_GetPersonData_Cached = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, wsCache.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function

Sub tests()
    Test_BuildSchedule_Student_NotCached
End Sub
Public Function Test_GetPersonData_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sDataType As String, sDataSubType As String, sResultFileName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String, sScope As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True

    sDataType = "person"
    sDataSubType = "student"
    sScope = "all"

    Set wsCache = GetPersonData(clsQuadRuntime, sDataSubType, sScope:=sScope)
    With wsCache
        If .Range(.Cells(83, 5), .Cells(83, 5)).Value <> "Photon" Then
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
    Test_GetPersonData_NotCached = eTestResult
    DeleteSheet clsQuadRuntime.CacheBook, wsCache.Name
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function
Public Function Test_ParseRawData() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sScheduleType As String, sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sScheduleType = "student"
    iPersonID = 70
    
    GetScheduleDataFromDB clsQuadRuntime, iPersonID, sScheduleType
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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath

    
End Function


