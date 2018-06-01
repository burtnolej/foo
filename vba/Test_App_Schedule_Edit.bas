Attribute VB_Name = "Test_App_Schedule_Edit"
Option Explicit
Const C_MODULE_NAME = "Test_App_Schedule_Edit"

Sub test()
    Test_EditLesson
End Sub
Function Test_EditLesson() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String, sDataType As String, sSubDataType As String
Dim dRecordValues As Dictionary

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "EditLesson"

    sDataType = "Schedule"
    sSubDataType = "Lesson"
    sSheetName = "test"
    clsAppRuntime.InitProperties bInitializeCache:=True
    GetDefinition clsAppRuntime, sDataType, sSubDataType, sSheetName, FormType.Add
    
main:

    EditLesson 2, "1", 1, eQuadSubDataType:=QuadSubDataType.Lesson

    If clsAppRuntime.AddBook.Sheets("Add_Schedule_Lesson").Range("eAdd_Schedule_Lesson_idStudent").value = "2" Then
        eTestResult = TestResult.OK
        GoTo teardown
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

err:
    eTestResult = TestResult.Error

teardown:
    Test_EditLesson = eTestResult
    DeleteSheet clsAppRuntime.Book, sSheetName
    clsAppRuntime.Delete
    
End Function


