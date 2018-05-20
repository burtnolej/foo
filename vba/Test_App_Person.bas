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
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    DoLoadDefinitions clsAppRuntime
main:
    If IsValidPersonID(clsAppRuntime, 70, QuadSubDataType.Student) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Student = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, "person_student"
    clsAppRuntime.Delete
End Function

Public Function Test_IsValidPersonID_Student_NotFound() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"

    
    If IsValidPersonID(clsAppRuntime, 999, QuadSubDataType.Student) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Student_NotFound = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, "person_student"
    clsAppRuntime.Delete

End Function
Public Function Test_IsValidPersonID_Teacher() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"

    If IsValidPersonID(clsAppRuntime, 70, QuadSubDataType.Teacher) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Teacher = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, "person_student"
    clsAppRuntime.Delete
    
End Function

Public Function Test_IsValidPersonID_Teacher_NotFound() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    
    If IsValidPersonID(clsAppRuntime, 999, QuadSubDataType.Teacher) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsValidPersonID_Teacher_NotFound = eTestResult
    DeleteSheet clsAppRuntime.CacheBook, "person_student"
    clsAppRuntime.Delete
   
End Function

Public Function Test_GetAllPersonDataFromDB() As TestResult
Dim sResultStr As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim vRows() As String

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True
    
main:
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    
    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
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
    clsAppRuntime.Delete
    
End Function

Public Function Test_DeletePersonDataToDB() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True
    vRows = Init2DVariantArray([{666,"foo","bar",2,6;667,"blah","blah",3,6}])
    vColumns = InitVariantArray(Array("idStudent", "sStudentFirstNm", "sStudentLastNm", "idPrep", "iGradeLevel"))
    InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vRows, vColumns
    
main:
    
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="666"
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="667"
    
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    
    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
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
    Test_DeletePersonDataToDB = eTestResult
    clsAppRuntime.Delete
    
End Function

Public Function Test_UpdatePersonDataInDB() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True
    vRows = Init2DVariantArray([{666,"foo","bar",2,6;667,"blah","blah",3,6}])
    vColumns = InitVariantArray(Array("idStudent", "sStudentFirstNm", "sStudentLastNm", "idPrep", "iGradeLevel"))
     
main:
    
    InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vRows, vColumns
    UpdatePersonDataInDB clsAppRuntime, QuadSubDataType.Student, "idPrep", 2, "idStudent", 667
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, iPersonID:="667"

    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
     
    Debug.Print sResultStr
    
    If sResultStr <> "sStudentFirstNm^sStudentLastNm^idStudent^idPrep^sPrepNm$$blah^blah^667^2^Luna" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_UpdatePersonDataInDB = eTestResult
    clsAppRuntime.Delete
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="666"
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="667"
    
End Function

Public Function Test_InsertPersonDataToDB() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True
    vRows = Init2DVariantArray([{666,"foo","bar",2,6;667,"blah","blah",3,6}])
    vColumns = InitVariantArray(Array("idStudent", "sStudentFirstNm", "sStudentLastNm", "idPrep", "iGradeLevel"))
     
main:
    
    InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vRows, vColumns
    
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, iPersonID:="666"

    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
        
    If sResultStr <> "sStudentFirstNm^sStudentLastNm^idStudent^idPrep^sPrepNm$$foo^bar^666^2^Luna" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_InsertPersonDataToDB = eTestResult
    clsAppRuntime.Delete
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="666"
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="667"
    
End Function

Public Function Test_GetPersonDataFromDB() As TestResult
Dim sResultStr As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True
    
main:
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, _
                        iPersonID:=70
    
    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
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
    clsAppRuntime.Delete
    
End Function

Public Function Test_GetPersonData_Cached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True

main:
    GetPersonData clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, eQuadScope:=QuadScope.all

    Set wsCache = GetPersonData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, eQuadScope:=QuadScope.all)
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
    DeleteSheet clsAppRuntime.CacheBook, wsCache.Name
    clsAppRuntime.Delete
    
End Function

Public Function Test_GetPersonData_NotCached() As TestResult
'"" get a full schedule for 1 student, parse and put into a backsheet
'""
Dim sResultFileName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsAppRuntime As New App_Runtime

setup:
    On Error GoTo err
    clsAppRuntime.InitProperties bInitializeCache:=True

main:
    Set wsCache = GetPersonData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, eQuadScope:=QuadScope.all)
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
    DeleteSheet clsAppRuntime.CacheBook, wsCache.Name
    clsAppRuntime.Delete

End Function
