Attribute VB_Name = "Format_Utils"

Sub FormatParagraph(rTargetRange As Range)
    With rTargetRange
        .Columns.AutoFit
        .Rows.AutoFit
    End With
End Sub
Sub SetWrapOn(rTargetRange As Range)
    With rTargetRange
        .Select
        .WrapText = True
    End With
End Sub
Sub SetTopLeftAlignOn(rTargetRange As Range)
    With rTargetRange
        .Select
        .HorizontalAlignment = xlLeft
        .VerticalAlignment = xlTop
    End With
End Sub
Sub SetColumnWidth(iColIdx As Integer, iColWidth As Integer, sSheetName As String)
Dim rColumn As Range
    With GetSheet(Application.ActiveWorkbook, sSheetName)
        Set rColumn = .Columns(iColIdx)
        rColumn.ColumnWidth = iColWidth
    End With
End Sub
Sub SetAllRowsHeight(iRowHeight As Integer, sSheetName As String, Optional rSource As Range)
Dim rColumn As Range
    With GetSheet(Application.ActiveWorkbook, sSheetName)
        .Activate
        If rSource Is Nothing Then
            Cells.Select
        Else
            rSource.Select
        End If
        Selection.RowHeight = iRowHeight
    End With
End Sub
Sub CopyFormat(wbSourceBook As Workbook, wbTargetbook As Workbook, sSourceSheetName As String, _
              sTargetSheetName As String, sSourceAddress As String, sTargetAddress As String)

    On Error GoTo 0
    
    With wbSourceBook.Sheets(sSourceSheetName)
        .Range(sSourceAddress).Copy
    End With
    
    With wbTargetbook.Sheets(sTargetSheetName)
        .Range(sTargetAddress).PasteSpecial Paste:=xlPasteFormats, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
        Application.CutCopyMode = False
    End With

End Sub

Sub CopyFormatRange(rSourceRange As Range, rTargetRange As Range)
    rSourceRange.Select
    Selection.Copy
    
    rTargetRange.Worksheet.Activate
    rTargetRange.Select
    'Application.CutCopyMode = False
    
    Selection.PasteSpecial Paste:=xlPasteFormats, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
            
End Sub
Sub SetBgColor(sSheetName As String, rTarget As Range, iRed As Integer, iGreen As Integer, iBlue As Integer)
    With GetSheet(Application.ActiveWorkbook, sSheetName)
        With rTarget.Interior
            .Color = RGB(iRed, iGreen, iBlue)
        End With
    End With
End Sub
Sub SetBgColorFromString(sSheetName As String, rTarget As Range, sRGB As String)
Dim aRGBElements() As String

    aRGBElements = Split(sRGB, ",")
    SetBgColor sSheetName, rTarget, CInt(aRGBElements(0)), CInt(aRGBElements(1)), CInt(aRGBElements(2))

End Sub
Function GetBgColor(sSheetName As String, rTarget As Range) As RGBColor
Dim vColorVal As Variant
Dim cRGB As New RGBColor

    vColorVal = rTarget.Interior.Color
    
    cRGB.Red = (vColorVal Mod 256)
    cRGB.Green = ((vColorVal \ 256) Mod 256)
    cRGB.Blue = (vColorVal \ 65536)
    
    Set GetBgColor = cRGB

End Function

