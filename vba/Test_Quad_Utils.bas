Attribute VB_Name = "Test_Quad_Utils"
Option Explicit
Const CsModuleName = "Test_Quad_Utils"

Public Sub Test_GetQuadStudentSchedule()
Dim sDatabasePath As String, sResults As String
Dim sSpName As String
Dim dSpArgs As New Dictionary

    sDatabasePath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\app\quad\utils\excel\test_misc\QuadQA.db"
    sSpName = "student_schedule"
    
    dSpArgs.Add "periods", InitVariantArray(Array(1, 2))
    dSpArgs.Add "days", InitVariantArray(Array("M", "F"))
    dSpArgs.Add "studentid", 70
    
    sResults = GetQuadStudentSchedule(sDatabasePath, sSpName, dSpArgs:=dSpArgs)
    
    Debug.Print sResults
End Sub

