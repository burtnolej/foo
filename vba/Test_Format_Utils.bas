Attribute VB_Name = "Test_Format_Utils"
Option Explicit
Const CsModuleName = "Test_Format_Utils"
Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_BgColor
    Test_CopyFormat
  
    'GetLogFile
End Sub
Sub Test_CopyFormat()
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
    
    rTarget.Name = "target"
    rSource.Name = "source"

    SetBgColor sSheetName, rSource, 255, 255, 0
    
    CopyFormat sSheetName, sSheetName, "source", "target"
main:

    Set cRGB = GetBgColor(sSheetName, rTarget)
    
    If cRGB.AsString <> "255,255,0" Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

Sub Test_BgColor()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sResult As String
Dim rCell As Range
Dim cRGB As RGBColor
Dim sSheetName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "BgColor"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    With wsTmp
        Set rCell = .Range(.Cells(1, 1), .Cells(1, 1))
    End With
    
main:

    SetBgColor sSheetName, rCell, 255, 0, 0
    Set cRGB = GetBgColor(sSheetName, rCell)
    
    If cRGB.AsString <> "255,0,0" Then
        GoTo fail
    End If
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    Call TestLogIt(sFuncName, bTestPassed)
End Sub

