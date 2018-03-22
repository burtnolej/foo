Attribute VB_Name = "Test_Quad_Utils"
Option Explicit
Const CsModuleName = "Test_Quad_Utils"

Public Function Test_GetQuadStudentSchedule() As TestResult
Dim sDatabasePath As String, sResults As String, resultstr As String
Dim sSpName As String
Dim dSpArgs As New Dictionary
Dim sResultFileName As String
Dim eTestResult As TestResult

    sDatabasePath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\app\quad\utils\excel\test_misc\QuadQA.db"
    sResultFileName = "C:\\Users\\burtnolej\\Documents\\runtime\\pyshell_results.txt"
    sSpName = "student_schedule"
    
    dSpArgs.Add "periods", InitVariantArray(Array(1, 2))
    dSpArgs.Add "days", InitVariantArray(Array("M", "F"))
    dSpArgs.Add "students", InitVariantArray(Array(70))
    
    sResults = GetQuadStudentSchedule(sDatabasePath, sSpName, dSpArgs:=dSpArgs, _
                    sResultFileName:=sResultFileName)
    
   If FileExists(sResultFileName) Then
        resultstr = ReadFile(sResultFileName)
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Split(Split(resultstr, "$$")(3), "^")(2) <> "Typing.com" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetQuadStudentSchedule = eTestResult
    
End Function

