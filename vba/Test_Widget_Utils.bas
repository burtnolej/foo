Attribute VB_Name = "Test_Widget_Utils"
Option Explicit
Const CsModuleName = "Test_Widget_Utils"
Function Test_FormatButton() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor
Dim clsQuadRuntime As New Quad_Runtime

setup:
    clsQuadRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = CsModuleName & "." & "CopyFormat"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rSource.Name = "fButtonInvalid"

    SetBgColor sSheetName, rSource, 255, 255, 0
    
main:

    FormatButton clsQuadRuntime.Book, clsQuadRuntime.Book, sSheetName, rTarget, ButtonState.Invalid, _
            sSourceSheetName:=sSheetName
    Set cRGB = GetBgColor(sSheetName, rTarget)
    
    If cRGB.AsString <> "255,255,0" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_FormatButton = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName

End Function
