Attribute VB_Name = "Test_Widget_Utils"
Option Explicit
Const CsModuleName = "Test_Widget_Utils"
Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_FormatButton
  
    'GetLogFile
End Sub
Sub Test_FormatButton()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim bTestPassed As Boolean
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As RGBColor

setup:
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

    FormatButton sSheetName, rTarget, ButtonState.Invalid, sSourceSheetName:=sSheetName
    Set cRGB = GetBgColor(sSheetName, rTarget)
    
    If cRGB.AsString <> "255,255,0" Then
        GoTo fail
    End If
    
Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub
