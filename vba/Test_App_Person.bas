Attribute VB_Name = "Test_App_Person"
'Test_IsValidPersonID_Student
'Test_IsValidPersonID_Student_NotFound
'Test_IsValidPersonID_Teacher
'Test_IsValidPersonID_Teacher_NotFound
'Test_GetAllPersonDataFromDB
'Test_GetPersonDataFromDB
'Test_CacheData_Schedule
'Test_CacheData_Person

Option Explicit

Public Function Test_IsValidPersonID_Student() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    DoLoadDefinitions clsQuadRuntime
main:
    If IsValidPersonID(clsQuadRuntime, 70, QuadSubDataType.Student) = False Then
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
    clsQuadRuntime.Delete
End Function

Public Function Test_IsValidPersonID_Student_NotFound() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"

    
    If IsValidPersonID(clsQuadRuntime, 999, QuadSubDataType.Student) = True Then
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
    clsQuadRuntime.Delete

End Function
Public Function Test_IsValidPersonID_Teacher() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"

    If IsValidPersonID(clsQuadRuntime, 70, QuadSubDataType.teacher) = False Then
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
    clsQuadRuntime.Delete
    
End Function

Public Function Test_IsValidPersonID_Teacher_NotFound() As TestResult
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    
    If IsValidPersonID(clsQuadRuntime, 999, QuadSubDataType.teacher) = True Then
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
    clsQuadRuntime.Delete
   
End Function

Public Function Test_GetAllPersonDataFromDB() As TestResult
Dim sResultStr As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
main:
    GetPersonDataFromDB clsQuadRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    
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
    clsQuadRuntime.Delete
    
End Function
Public Function Test_GetPersonDataFromDB() As TestResult
Dim sResultStr As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
main:
    GetPersonDataFromDB clsQuadRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, _
                        iPersonID:=70
    
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
    clsQuadRuntime.Delete
    
End Function

Public Function Test_GetPersonData_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True

main:
    GetPersonData clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, eQuadScope:=QuadScope.all

    Set wsCache = GetPersonData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, eQuadScope:=QuadScope.all)
    With wsCache
        If .Range(.Cells(83, 5), .Cells(83, 5)).value <> "Photon" Then
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
    clsQuadRuntime.Delete
    
End Function

Public Function Test_GetPersonData_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultFileName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsQuadRuntime As New Quad_Runtime

setup:
    On Error GoTo err
    clsQuadRuntime.InitProperties bInitializeCache:=True

main:
    Set wsCache = GetPersonData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, eQuadScope:=QuadScope.all)
    With wsCache
        If .Range(.Cells(83, 5), .Cells(83, 5)).value <> "Photon" Then
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
    clsQuadRuntime.Delete

End Function
