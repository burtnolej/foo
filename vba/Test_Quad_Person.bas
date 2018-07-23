Attribute VB_Name = "Test_Quad_Person"
'Test_IsValidPersonID_Student
'Test_IsValidPersonID_Student_NotFound
'Test_IsValidPersonID_Teacher
'Test_IsValidPersonID_Teacher_NotFound
'Test_GetAllPersonDataFromDB
'Test_GetPersonDataFromDB
'Test_CacheData_Schedule
'Test_CacheData_Person

Option Explicit
Const C_MODULE_NAME = "Test_Quad_Person"

Public Function Test_GeneratePersonView() As TestResult
'<<<
'purpose: simple wrapper to launch a Student View workflow
'>>>
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As New Exec_Proc
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long
Dim eTestResult As TestResult
Dim rTarget As Range

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    sFuncName = C_MODULE_NAME & "." & "GeneratePersonView"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False
    clsExecProc.InitProperties wbTmp:=ActiveWorkbook

main:
    GeneratePersonView clsAppRuntime, clsExecProc

    With clsAppRuntime.ViewBook.Sheets("View_Person_Student")
        Set rTarget = .Range(.Cells(2, 3), .Cells(2, 3))
        rTarget = "Bruno"
        ValidateWidget clsAppRuntime.ViewBook, "View_Person_Student", rTarget
    End With

    With clsAppRuntime.ViewBook.Sheets("View_Person_Student")
        Set rTarget = .Range(.Cells(4, 3), .Cells(4, 3))
        If rTarget.value <> "Raskin" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    End With
            
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GeneratePersonView = eTestResult
    clsAppRuntime.Delete
End Function
    
    
Public Function Test_IsValidPersonID_Student() As TestResult
Dim eTestResult As TestResult
Dim clsExecProc As Exec_Proc
Dim clsAppRuntime As New App_Runtime
Dim sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
main:
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iPersonID", 70, "eQuadSubDataType", QuadSubDataType.Student
    If Application.Run(C_IS_VALID_PERSON, dArgs) = False Then
    
    'If IsValidPersonID(clsAppRuntime, 70, QuadSubDataType.Student) = False Then
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
Dim clsExecProc As Exec_Proc
Dim sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    'clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iPersonID", 999, "eQuadSubDataType", QuadSubDataType.Student
    If Application.Run(C_IS_VALID_PERSON, dArgs) = False Then
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
Dim clsExecProc As Exec_Proc
Dim sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    'clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iPersonID", 70, "eQuadSubDataType", QuadSubDataType.Teacher
    If Application.Run(C_IS_VALID_PERSON, dArgs) = False Then
    'If IsValidPersonID(clsAppRuntime, 70, QuadSubDataType.Teacher) = False Then
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
Dim clsExecProc As Exec_Proc
Dim sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    'clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:="Definitions"
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iPersonID", 999, "eQuadSubDataType", QuadSubDataType.Teacher
    If Application.Run(C_IS_VALID_PERSON, dArgs) = False Then
    'If IsValidPersonID(clsAppRuntime, 999, QuadSubDataType.Teacher) = True Then
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
Dim sResultStr As String, sSheetName As String, sDataType As String, sSubDataType As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc
Dim vRows() As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    'clsAppRuntime.InitProperties bInitializeCache:=True
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
main:

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.all
    Application.Run C_GET_PERSON_DATA, dArgs
                          
    'GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    
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
Dim clsExecProc As Exec_Proc
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String, sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary
setup:
    On Error GoTo err

    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
    vRows = Init2DVariantArray([{666,"foo","bar",2,6;667,"blah","blah",3,6}])
    vColumns = InitVariantArray(Array("idStudent", "sStudentFirstNm", "sStudentLastNm", "idPrep", "iGradeLevel"))
    InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vRows, vColumns
    
main:
    
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="666"
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="667"
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.all
    Application.Run C_GET_PERSON_DATA_FROM_DB, dArgs
    'GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.all
    
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
Dim clsExecProc As Exec_Proc
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String, sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    vRows = Init2DVariantArray([{666,"foo","bar",2,6;667,"blah","blah",3,6}])
    vColumns = InitVariantArray(Array("idStudent", "sStudentFirstNm", "sStudentLastNm", "idPrep", "iGradeLevel"))
     
main:
    
    InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vRows, vColumns
    UpdatePersonDataInDB clsAppRuntime, QuadSubDataType.Student, "idPrep", 2, "idStudent", 667
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.specified, _
                          "iPersonID", "667"
                          
    Application.Run C_GET_PERSON_DATA_FROM_DB, dArgs
    
    'GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, iPersonID:="667"

    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If sResultStr <> "sStudentFirstNm^sStudentLastNm^idStudent^idPrep^iGradeLevel^sPrepNm$$blah^blah^667^2^6^Luna" Then
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
Dim clsExecProc As Exec_Proc
Dim vRows() As Variant, vColumns() As Variant
Dim sResultStr As String, sSheetName As String, sDataType As String, sSubDataType As String
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    vRows = Init2DVariantArray([{666,"foo","bar",2,6;667,"blah","blah",3,6}])
    vColumns = InitVariantArray(Array("idStudent", "sStudentFirstNm", "sStudentLastNm", "idPrep", "iGradeLevel"))
     
main:
    
    InsertPersonDataToDB clsAppRuntime, QuadSubDataType.Student, vRows, vColumns
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.specified, _
                          "iPersonID", "666"
                          
    Application.Run C_GET_PERSON_DATA_FROM_DB, dArgs
    
    'GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, iPersonID:="666"

    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If sResultStr <> "sStudentFirstNm^sStudentLastNm^idStudent^idPrep^iGradeLevel^sPrepNm$$foo^bar^666^2^6^Luna" Then
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
Dim sResultStr As String, sSheetName As String, sDataType As String, sSubDataType As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View
    
main:

    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.specified, _
                          "iPersonID", "70"
                          
    Application.Run C_GET_PERSON_DATA_FROM_DB, dArgs
    
    'GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, _
    '                    iPersonID:=70
    
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
Dim sResultStr As String, sExpectedResult As String, sCacheSheetName As String, sSheetName As String, sDataType As String, sSubDataType As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc
Dim dArgs As New Dictionary

setup:
    On Error GoTo err
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View

main:

    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadDataType", QuadDataType.person, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.all
                          
    Application.Run C_GET_PERSON_DATA, dArgs
    
    'GetPersonData clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, eQuadScope:=QuadScope.all

    Set wsCache = dArgs.Item("result")
    
    With wsCache
        If .Range(.Cells(83, 6), .Cells(83, 6)).value <> "Photon" Then
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
Dim sResultFileName As String, sSheetName As String, sResultStr As String, sExpectedResult As String, sCacheBookName As String, sCacheSheetName As String, sDataType As String, sSubDataType As String
Dim eTestResult As TestResult
Dim aSchedule() As String
Dim wsCache As Worksheet
Dim clsAppRuntime As New App_Runtime
Dim clsExecProc As Exec_Proc
Dim dArgs As New Dictionary


setup:
    On Error GoTo err
    sDataType = "Person"
    sSubDataType = "Student"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    'clsExecProc.InitProperties wbTmp:=ActiveWorkbook
    Set clsExecProc = GetExecProcGlobal(ActiveWorkbook)
    GetDefinition clsAppRuntime, clsExecProc, sDataType, sSubDataType, sSheetName, FormType.View

main:

    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, _
                          "eQuadDataType", QuadDataType.person, _
                          "eQuadSubDataType", QuadSubDataType.Student, _
                          "eQuadScope", QuadScope.all
                          
    Application.Run C_GET_PERSON_DATA, dArgs
    Set wsCache = dArgs.Item("result")
    
    'Set wsCache = GetPersonData(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, eQuadScope:=QuadScope.all)
    With wsCache
        If .Range(.Cells(83, 6), .Cells(83, 6)).value <> "Photon" Then
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
