Attribute VB_Name = "Test_App_Loader"
Option Explicit
Const C_MODULE_NAME = "Test_App_Loader"


Private Sub CreateNamedRangesForLoaderSheet(sSheetName As String, rTarget As Range, wbTmp As Workbook)
    CreateNamedRange wbTmp, rTarget.Offset(1, 2).Resize(rTarget.Rows.Count - 1, rTarget.Columns.Count - 2).Address, sSheetName, "lData", "True"
    CreateNamedRange wbTmp, rTarget.Offset(1).Resize(rTarget.Rows.Count - 1, 2).Address, sSheetName, "lDataType", "True"
    CreateNamedRange wbTmp, rTarget.Offset(, 2).Resize(1, rTarget.Columns.Count - 2).Address, sSheetName, "lHeader", "True"

End Sub
Public Function Test_App_Loader_Schedule_Lesson() As TestResult
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
    sLoaderData = "DataType^SubDataType^sStudentFirstNm^sStudentLastNm^sFacultyFirstNm^sFacultyLastNm^sCourseNm^sSubjectLongDesc^idPrep^idTimePeriod^cdDay" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Schedule^Student^Bruno^Raskin^David^Stone^Art^Art^Luna^4^M" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Schedule^Student^Bruno^Raskin^David^Stone^Art^Art^Luna^4^T" & DOUBLEDOLLAR
    sLoaderData = sLoaderData & "Schedule^Student^Bruno^Raskin^David^Stone^Art^Art^Luna^4^W"
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
    
    
teardown:
    Test_App_Loader_Person_Student = eTestResult
    clsAppRuntime.Delete
    
End Function
