Attribute VB_Name = "Test_Format_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_Format_Utils"

Sub DisplayFormats()
Dim rInputCell As Range, rRow As Range
Dim vColorComponents() As String

    With Workbooks("quad.xlsm").Sheets("CondFormat").Range("cfData")
        For Each rRow In .Rows
        
            Set rInputCell = rRow.Columns(1)
            vColorComponents = Split(rInputCell.value, ",")
    
            SetBgColor "CondFormat", rInputCell, CInt(vColorComponents(0)), CInt(vColorComponents(1)), CInt(vColorComponents(2))
        Next rRow

    End With
End Sub
Function Test_GetCondFormats() As TestResult
Dim sSheetName As String, sBookName As String, sBookPath As String, sCellRangeAddress As String, sFuncName As String
Dim wbTmp As Workbook
Dim wsTmp As Worksheet, wsResult As Worksheet
Dim oCondFormats As FormatConditions
Dim oCondFormat As FormatCondition
Dim rgbColor As rgbColor
Dim vCondFormats() As String
Dim iFormatCount As Integer
Dim eTestResult As TestResult
Dim rTarget As Range

setup:
    sFuncName = C_MODULE_NAME & "." & "Test_GetCondFormats"
    sSheetName = "test"
    Set wsResult = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    
    sBookName = "quad.xlsm"
    sBookPath = "C:\Users\burtnolej\Documents\runtime\"
    sSheetName = "FormStyles_6"
    sCellRangeAddress = "E9:E9"
   
    ReDim vCondFormats(0 To 500, 0 To 3)
    
    Set wbTmp = OpenBook(sBookName, sBookPath)
    Set wsTmp = GetSheet(wbTmp, sSheetName)
    
    Set oCondFormats = wsTmp.Range(sCellRangeAddress).FormatConditions
    
    For Each oCondFormat In oCondFormats
        vCondFormats(iFormatCount, 0) = GetRGBFromExcelColor(oCondFormat.Interior.Color).AsString
        vCondFormats(iFormatCount, 1) = GetRGBFromExcelColor(oCondFormat.Font.Color).AsString
        vCondFormats(iFormatCount, 2) = oCondFormat.Formula1
        vCondFormats(iFormatCount, 3) = oCondFormat.AppliesTo.Address
        iFormatCount = iFormatCount + 1
    Next oCondFormat
    
    vCondFormats = ReDim2DArray(vCondFormats, iFormatCount - 1, 4)
    
    Set rTarget = RangeFromStrArray(vCondFormats, wsResult, 0, 0)
    
teardown:
    Test_GetCondFormats = eTestResult
    
    DeleteSheet ActiveWorkbook, sSheetName
    
End Function


Function Test_SetCondFormats() As TestResult
Dim sSheetName As String, sBookName As String, sBookPath As String, sCellRangeAddress As String, sText As String, sFgColorsString As String, sBgColorsString As String, _
    sFormula As String, sAddress As String
Dim wbTmp As Workbook
Dim wsSource As Worksheet
Dim oCondFormats As FormatConditions
Dim oCondFormat As FormatCondition
Dim rgbColor As rgbColor
Dim vCondFormats() As String
Dim iFormatCount As Integer
Dim rSource As Range, rRow As Range, rCellTarget As Range
Dim vFgComponents() As String, vBgComponents() As String


setup:
    sSheetName = "test"
    sCellRangeAddress = "A1:A1"
    Set wsSource = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)

    sText = "128,0,0^128,0,0^=AND(E1=" & """Work Period""" & ",F1=" & """Work Period""" & ")^$D$1^Work Period^Work Period" & DOUBLEDOLLAR
    sText = sText & "0,255,255^0,255,255^=AND(E2=" & """Work Period""" & ",F2=" & """Humanities Independent Study""" & ")^$D$2^Work Period^Humanities Independent Study" & DOUBLEDOLLAR
    sText = sText & "48,84,150^48,84,150^=E3=" & """Music""" & "^$D$3^Music^"

    vCondFormats = Init2DStringArrayFromString(sText)
    Set rSource = RangeFromStrArray(vCondFormats, wsSource, 0, 0)
    
main:

    For Each rRow In rSource.Rows
        sFgColorsString = rRow.Columns(1)
        sBgColorsString = rRow.Columns(2)
        sFormula = rRow.Columns(3)
        sAddress = rRow.Columns(4)
        
        vFgComponents = Split(sFgColorsString, ",")
        vBgComponents = Split(sBgColorsString, ",")
        
        Set rCellTarget = wsSource.Range(sAddress)
        rCellTarget.FormatConditions.Add Type:=xlExpression, Formula1:=sFormula

        With rSource.FormatConditions(rSource.FormatConditions.Count)
            .SetFirstPriority
            With .Interior
                .PatternColorIndex = xlAutomatic
                .Color = RGB(CInt(vBgComponents(0)), CInt(vBgComponents(1)), CInt(vBgComponents(2)))
                .TintAndShade = 0
            End With
            
            With .Font
                .Color = RGB(CInt(vFgComponents(0)), CInt(vFgComponents(1)), CInt(vFgComponents(2)))
            End With
        End With
        
    Next rRow
End Function

Function Test_CopyFormat() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sSheetName As String
Dim eTestResult As TestResult
Dim rSource As Range
Dim rTarget As Range
Dim cRGB As rgbColor
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    
    sFuncName = C_MODULE_NAME & "." & "CopyFormat"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.Book, sSheetName, bOverwrite:=True)
    
    With wsTmp
        Set rTarget = .Range(.Cells(1, 1), .Cells(1, 1))
        Set rSource = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rTarget.Name = "target"
    rSource.Name = "source"

    SetBgColor sSheetName, rSource, 255, 255, 0, wbTmp:=clsAppRuntime.CacheBook
    CopyFormat clsAppRuntime.Book, clsAppRuntime.Book, _
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
    DeleteSheet ActiveWorkbook, sSheetName
    clsAppRuntime.Delete
    
End Function

Function Test_BgColor() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sResult As String
Dim rWidget As Range
Dim cRGB As rgbColor
Dim sSheetName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "BgColor"
    sSheetName = "test"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    With wsTmp
        Set rWidget = .Range(.Cells(1, 1), .Cells(1, 1))
    End With
    
main:

    SetBgColor sSheetName, rWidget, 255, 0, 0
    Set cRGB = GetBgColor(sSheetName, rWidget)
    
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


