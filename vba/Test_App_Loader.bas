Attribute VB_Name = "Test_App_Loader"
Option Explicit
Const C_MODULE_NAME = "Test_App_Loader"


Private Sub CreateNamedRangesForLoaderSheet(sSheetName As String, rTarget As Range, wbTmp As Workbook)
    CreateNamedRange wbTmp, rTarget.Offset(1, 2).Resize(rTarget.Rows.Count - 1, rTarget.Columns.Count - 2).Address, sSheetName, "lData", "True"
    CreateNamedRange wbTmp, rTarget.Offset(1).Resize(rTarget.Rows.Count - 1, 2).Address, sSheetName, "lDataType", "True"
    CreateNamedRange wbTmp, rTarget.Offset(, 2).Resize(1, rTarget.Columns.Count - 2).Address, sSheetName, "lHeader", "True"

End Sub

Public Function TXXXest_App_Loader_Schedule_Lesson() As TestResult
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String, sLoaderData As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sDataType As String, sSubDataType As String

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    
    ' Schedule
    sDataType = "Schedule"
    sSubDataType = "Lesson"
    
    sSheetName = GetLoaderSheetName(sDataType, sSubDataType)
    
    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)

    'sLoaderData = "DataType^SubDataType^sSubjectLongDesc^sCourseNm^sClassFocusArea^sFacultyFirstNm^cdDay^idTimePeriod^idLocation^idSection^cdClassType^iFreq^idClassLecture" & DOUBLEDOLLAR
    'sLoaderData = sLoaderData & "Schedule^Student^Art^Art^DummyFA^David^M^4^DummyL^DummyS^DummyCT^DummyF^DummyCL" & DOUBLEDOLLAR
    'sLoaderData = sLoaderData & "Schedule^Student^Art^Art^DummyFA^David^T^4^DummyL^DummyS^DummyCT^DummyF^DummyCL" & DOUBLEDOLLAR
    'sLoaderData = sLoaderData & "Schedule^Student^Art^Art^DummyFA^David^W^4^DummyL^DummyS^DummyCT^DummyF^DummyCL"
    
    sLoaderData = "DataType^SubDataType^cdDay^idTimePeriod^idLocation^idSection" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Schedule^Student^F^7^1^700" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Schedule^Student^F^8^2^700" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Schedule^Student^F^9^3^700"
    
    'sLoaderData = "DataType^SubDataType^sStudentFirstNm^sStudentLastNm^sFacultyFirstNm^sFacultyLastNm^sCourseNm^sSubjectLongDesc^idPrep^idTimePeriod^cdDay" & DOUBLEDOLLAR
    'sLoaderData = sLoaderData & "Schedule^Student^Bruno^Raskin^David^Stone^Art^Art^Luna^4^M" & DOUBLEDOLLAR
    'sLoaderData = sLoaderData & "Schedule^Student^Bruno^Raskin^David^Stone^Art^Art^Luna^4^T" & DOUBLEDOLLAR
    'sLoaderData = sLoaderData & "Schedule^Student^Bruno^Raskin^David^Stone^Art^Art^Luna^4^W"
    vSource = Init2DStringArrayFromString(sLoaderData)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRangesForLoaderSheet sSheetName, rTarget, clsAppRuntime.CacheBook
    
    DataLoader sDataType, sSubDataType, wbTmp:=clsAppRuntime.CacheBook
    
    
teardown:
    Test_App_Loader_Schedule_Lesson = eTestResult
    clsAppRuntime.Delete
    
End Function


Public Function Test_App_Loader_Person_Student() As TestResult
Dim sSheetName As String, sResultStr As String, sFuncName As String, sDefn As String, sSearchCode As String, sModuleCode As String, sExpectedResultStr As String, sLoaderData As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rAdd As Range, rButton As Range
Dim dDefinitions As Dictionary, dDefnDetails As Dictionary
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sDataType As String, sSubDataType As String

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "TestGenerateMenuForm"
    
    ' Schedule
    sDataType = "Person"
    sSubDataType = "Student"
    
    sSheetName = GetLoaderSheetName(sDataType, sSubDataType)

    Set wsTmp = CreateSheet(clsAppRuntime.CacheBook, sSheetName, bOverwrite:=True)
    sLoaderData = "DataType^SubDataType^idStudent^sStudentFirstNm^sStudentLastNm^idPrep^iGradeLevel" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Person^Student^666^foo^bar^2^6" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Person^Student^667^blah^blah^3^6"
    vSource = Init2DStringArrayFromString(sLoaderData)
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRangesForLoaderSheet sSheetName, rTarget, clsAppRuntime.CacheBook
    
    DataLoader sDataType, sSubDataType, wbTmp:=clsAppRuntime.CacheBook, bValidateFields:=False
    
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, _
                        iPersonID:=666
    
    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If Split(Split(sResultStr, "$$")(1), "^")(0) <> "foo" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    GetPersonDataFromDB clsAppRuntime, QuadSubDataType.Student, eQuadScope:=QuadScope.specified, _
                        iPersonID:=667
    
    If FileExists(clsAppRuntime.ResultFileName) Then
        sResultStr = ReadFile(clsAppRuntime.ResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    If Split(Split(sResultStr, "$$")(1), "^")(0) <> "blah" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    
teardown:
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="666"
    DeletePersonDataFromDB clsAppRuntime, QuadSubDataType.Student, iPersonID:="667"
    Test_App_Loader_Person_Student = eTestResult
    clsAppRuntime.Delete
    
End Function
