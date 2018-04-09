Attribute VB_Name = "Test_Format_Utils"
Option Explicit
Const CsModuleName = "Test_Format_Utils"


Function Test_CopyFormat() As TestResult
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
    Set wsTmp = CreateSheet(clsQuadRuntime.Book, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rTarget.Name = "target"
    rSource.Name = "source"

    SetBgColor sSheetName, rSource, 255, 255, 0
    CopyFormat clsQuadRuntime.Book, clsQuadRuntime.Book, _
            sSheetName, sSheetName, "source", "target"
main:

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
    Test_CopyFormat = eTestResult
    clsQuadRuntime.Delete
    DeleteSheet ActiveWorkbook, sSheetName
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
End Function

Function Test_BgColor() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sResult As String
Dim rCell As Range
Dim cRGB As RGBColor
Dim sSheetName As String
Dim eTestResult As TestResult

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
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_BgColor = eTestResult
    DeleteSheet ActiveWorkbook, sSheetName
End Function

