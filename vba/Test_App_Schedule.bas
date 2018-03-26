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

Sub test()
    Test_BuildSchedule_Student_Multi
End Sub
Public Function Test_BuildSchedule_Student_Multi() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sTemplateBookName As String, sCacheBookName As String, sScheduleType As String, sTemplateBookPath As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer

    sTemplateBookName = "vba_source_new.xlsm"
    sTemplateBookPath = "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer"
    sScheduleType = "student"
    sCacheBookName = "tmp.xls"
    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID, sCacheBookName:=sCacheBookName)
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID - 1, sCacheBookName:=sCacheBookName)
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID - 2, sCacheBookName:=sCacheBookName)
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID - 3, sCacheBookName:=sCacheBookName)
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID - 4, sCacheBookName:=sCacheBookName)
                              
    With ActiveWorkbook
        If "view_student_66,schedule_student_66,view_student_67,schedule_student_67,view_student_68,schedule_student_68,view_student_69,schedule_student_69,view_student_70,schedule_student_70" <> Join(GetSheets(Workbooks(sCacheBookName)), ",") Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    End With
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_BuildSchedule_Student_Multi = eTestResult
    DeleteSheet Workbooks(sCacheBookName), "schedule_" & sScheduleType & "_" & CStr(iPersonID)
    DeleteSheet Workbooks(sCacheBookName), wsSchedule.Name
    CloseBook Workbooks(sCacheBookName)
    DeleteBook sCacheBookName
    
End Function

Public Function Test_BuildSchedule_Student_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sTemplateBookName As String, sCacheBookName As String, sScheduleType As String, sTemplateBookPath As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim rResult As Range
Dim wsSchedule As Worksheet
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer, iPersonID As Integer

    sTemplateBookName = ActiveWorkbook.Name
    sTemplateBookPath = ActiveWorkbook.Path
    sScheduleType = "student"
    sCacheBookName = "tmp.xls"
    iPersonID = 70
    
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID, sCacheBookName:=sCacheBookName)
                              
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
    DeleteSheet Workbooks(sCacheBookName), "schedule_" & sScheduleType & "_" & CStr(iPersonID)
    DeleteSheet Workbooks(sCacheBookName), wsSchedule.Name
    CloseBook Workbooks(sCacheBookName)
    DeleteBook sCacheBookName
    
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

setup:
    sTemplateBookName = ActiveWorkbook.Name
    sTemplateBookPath = ActiveWorkbook.Path
    sScheduleType = "student"
    sCacheBookName = "tmp.xls"
    iPersonID = 70
    sDataType = "schedule"
    
    sResultFileName = GetScheduleDataFromDB(iPersonID, sScheduleType)
    aSchedule = ParseRawData(ReadFile(sResultFileName))
    sCacheSheetName = CacheData(Quad_Utils.sCacheBookPath, sCacheBookName, aSchedule, sDataType, sScheduleType, iPersonID)
    
main:
    Set wsSchedule = BuildSchedule(sTemplateBookName, sTemplateBookPath, sScheduleType, iPersonID, sCacheBookName:=sCacheBookName)
                              
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
    DeleteSheet Workbooks(sCacheBookName), "schedule_" & sScheduleType & "_" & CStr(iPersonID)
    DeleteSheet Workbooks(sCacheBookName), wsSchedule.Name
    CloseBook Workbooks(sCacheBookName)
    DeleteBook sCacheBookName
    
End Function

Public Function Test_GetAllPersonDataFromDB() As TestResult
Dim sScheduleType As String, sScope As String, sResultFileName As String, sResultStr As String
Dim eTestResult As TestResult

    sScheduleType = "student"
    sScope = "all"
    sResultFileName = GetPersonDataFromDB(sScheduleType, sScope:=sScope)
    
    If FileExists(sResultFileName) Then
        sResultStr = ReadFile(sResultFileName)
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
    
End Function
Public Function Test_GetPersonDataFromDB() As TestResult
Dim sScheduleType As String, sScope As String, sResultFileName As String, sResultStr As String
Dim eTestResult As TestResult

    sScheduleType = "student"
    sScope = "specified"
    
    sResultFileName = GetPersonDataFromDB(sScheduleType, sScope:=sScope, iPersonID:=70)
    
    If FileExists(sResultFileName) Then
        sResultStr = ReadFile(sResultFileName)
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
    
End Function


Public Function Test_GetScheduleDataFromDB() As TestResult
'"" get a subset of the schedule for more than 1 student to test basics
'""
Dim sScheduleType As String, sResultFileName As String, sResultStr As String
Dim iPersonID As Integer
Dim eTestResult As TestResult

    sScheduleType = "student"
    iPersonID = 70
    
    sResultFileName = GetScheduleDataFromDB(iPersonID, sScheduleType, sPeriod:="1,2", sDay:="M,F")

   If FileExists(sResultFileName) Then
        sResultStr = ReadFile(sResultFileName)
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
    
End Function
Public Function Test_GetScheduleDataFromDB_1Period1Student() As TestResult
'"" get 1 period of a  schedule for 1 student
'""
Dim sScheduleType As String, sResultFileName As String, sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult

    sScheduleType = "student"
    iPersonID = 70
    
    sResultFileName = GetScheduleDataFromDB(iPersonID, sScheduleType, sPeriod:="1")
    
    If FileExists(sResultFileName) Then
        sResultStr = ReadFile(sResultFileName)
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
    
End Function
Public Function Test_CacheData_Schedule() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sDataType As String, sDataSubType As String, sResultFileName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As String

    sCacheBookName = "tmp.xls"
    sDataType = "schedule"
    sDataSubType = "student"
    
    iPersonID = 70
    
    sResultFileName = GetScheduleDataFromDB(iPersonID, sDataSubType)
    aSchedule = ParseRawData(ReadFile(sResultFileName))
    sCacheSheetName = CacheData(Quad_Utils.sCacheBookPath, sCacheBookName, aSchedule, sDataType, sDataSubType, iPersonID)
 
    With Workbooks(sCacheBookName).Sheets(sCacheSheetName)
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
    DeleteSheet ActiveWorkbook, sCacheSheetName
    CloseBook Workbooks(sCacheBookName)
    DeleteBook sCacheBookName
    
End Function

Public Function Test_GetPersonData_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sDataType As String, sDataSubType As String, sResultFileName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String, sScope As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet

setup:
    sCacheBookName = "tmp.xls"
    sDataType = "person"
    sDataSubType = "student"
    sScope = "all"
    
    GetPersonData "vba_source_new.xlsm", "C:\\Users\burtnolej\Documents\GitHub\quadviewer", _
                   sDataSubType, sScope:=sScope, sCacheBookName:=sCacheBookName

main:

    Set wsCache = GetPersonData("vba_source_new.xlsm", "C:\\Users\burtnolej\Documents\GitHub\quadviewer", _
                   sDataSubType, sScope:=sScope, sCacheBookName:=sCacheBookName)
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
    DeleteSheet Workbooks(sCacheBookName), wsCache.Name
    CloseBook Workbooks(sCacheBookName)
    DeleteBook sCacheBookName
    
End Function

Public Function Test_GetPersonData_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sDataType As String, sDataSubType As String, sResultFileName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String, sScope As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet

    sCacheBookName = "tmp.xls"
    sDataType = "person"
    sDataSubType = "student"
    sScope = "all"

    Set wsCache = GetPersonData("vba_source_new.xlsm", "C:\\Users\burtnolej\Documents\GitHub\quadviewer", _
                   sDataSubType, sScope:=sScope, sCacheBookName:=sCacheBookName)
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
    DeleteSheet Workbooks(sCacheBookName), wsCache.Name
    CloseBook Workbooks(sCacheBookName)
    DeleteBook sCacheBookName
    
End Function
Public Function Test_ParseRawData() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sScheduleType As String, sResultFileName As String, sResultStr As String, sExpectedResult As String
Dim iPersonID As Integer
Dim eTestResult As TestResult
Dim aSchedule() As String

    sScheduleType = "student"
    iPersonID = 70
    
    sResultFileName = GetScheduleDataFromDB(iPersonID, sScheduleType)
    aSchedule = ParseRawData(ReadFile(sResultFileName))
 
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
    
End Function


