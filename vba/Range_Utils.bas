Attribute VB_Name = "Range_Utils"
Const CsModuleName = "Range_Utils"
Public Sub RangeSort(sSheetName As String, rSort As Range, Optional iStartCol As Integer, Optional aSortColumns As Variant = Null)

    ActiveWorkbook.Worksheets(sSheetName).Sort.SortFields.Clear

    If IsNull(aSortColumns) Then
        If iStartCol = 0 Then
            iStartCol = 2
        End If
        
        ReDim aSortColumns(0 To rSort.Columns.Count - iStartCol)
        For i = iStartCol To rSort.Columns.Count
            aSortColumns(i - iStartCol) = i
        Next i
    
    End If

    For Each i In aSortColumns
    'For i = iStartCol To rSort.Columns.Count
        ActiveWorkbook.Worksheets(sSheetName).Sort.SortFields.Add key:=rSort.Columns(i), _
            SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:=xlSortNormal
    Next i
        
    With ActiveWorkbook.Worksheets(sSheetName).Sort
        .SetRange rSort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
End Sub
Public Function ListFromRange(wsTmp As Worksheet, sSourceAddress As String) As String()
Dim vTmpRange() As Variant
    With wsTmp
        vTmpRange = .Range(sSourceAddress)
    End With
    
    ListFromRange = ConvertArrayFromRangeto1D(vTmpRange)
End Function
Public Function IsCell(rCell As Range) As Boolean
' is rCell a cell, so 1 column and 1 row in size
    IsCell = True
    If rCell.Columns.Count > 1 Then
        IsCell = False
    ElseIf rCell.Rows.Count > 1 Then
        IsCell = False
    End If
End Function
Public Function IsBlankCell(rCell As Range) As Boolean
' is it a cell and is it also equal to ""
    IsBlankCell = True
    
    If IsCell(rCell) = False Then
        IsBlankCell = False
    ElseIf rCell.Value <> BLANK Then
        IsBlankCell = False
    End If
End Function
Public Function GetMultiAreaRowCount(rAreas As Range) As Integer
' take a range made up of multiple areas and return the total number of rows
Dim rArea As Range
Dim iCount As Integer
    For Each rArea In rAreas.Areas
        iCount = iCount + rArea.Rows.Count
    Next rArea
    
    GetMultiAreaRowCount = iCount
End Function
Public Function IsNonBlankCell(rCell As Range) As Boolean
' is it a cell and is it also equal to ""
    IsNonBlankCell = True
    
    If IsCell(rCell) = False Then
        IsNonBlankCell = False
    ElseIf rCell.Value = BLANK Then
        IsNonBlankCell = False
    End If
End Function
Public Function RangeFromStrArray(vSource() As String, wsTarget As Worksheet, _
            iRowOffset As Integer, iColOffset As Integer) As Range
            
Dim wsTmp As Worksheet
Dim rRange As Range
Dim iRows As Integer
Dim iCols As Integer

    iRows = iRowOffset + UBound(vSource) + 1
    iCols = iColOffset + UBound(vSource, 2) + 1
    
    With wsTarget
        Set rRange = .Range(.Cells(1 + iRowOffset, 1 + iColOffset), .Cells(iRows, iCols))
        rRange = vSource
    End With
    
    Set RangeFromStrArray = rRange
End Function
Public Sub FillDown(rSource As Range, rTarget As Range)
Dim sFuncName As String

init:
    sFuncName = CsModuleName & "." & "FillDown"

main:

    rSource.Select
    Selection.AutoFill Destination:=rTarget, Type:=xlFillDefault

cleanup:
    
End Sub
Public Function GetSheetNamedRanges(wbTmp As Workbook, sSheetName As String) As String()
Dim aNames() As String
Dim iCount As Integer

    ReDim aNames(0 To 100)
    For Each name_ In wbTmp.Sheets(sSheetName).Names
        aNames(iCount) = Split(name_.Name, "!")(1)
        iCount = iCount + 1
    Next name_
    ReDim Preserve aNames(0 To iCount - 1)
    GetSheetNamedRanges = aNames
End Function
Public Function NamedRangeExists(wbTmp As Workbook, sSheetName As String, sRangeName As String) As Boolean
Dim nTmp As Name

    With wbTmp.Sheets(sSheetName)
        On Error GoTo err
        Set nTmp = .Names.Item(sRangeName)
        On Error GoTo 0
        NamedRangeExists = True
        Exit Function
    End With
err:
    NamedRangeExists = False

End Function
Public Sub DeleteNamedRange(wbTmp As Workbook, sSheetName As String, sRangeName As String)
Dim nTmp As Name
Dim sFuncName As String

init:
    sFuncName = CsModuleName & "." & "DeleteNamedRange"

main:
    With wbTmp.Sheets(sSheetName)
        On Error GoTo err
        Set nTmp = .Names.Item(sRangeName)
        On Error GoTo 0
        If nTmp Is Nothing Then
            FuncLogIt sFuncName, "Could not find name [" & sRangeName & "]", C_MODULE_NAME, LogMsgType.FAILURE
        Else
            On Error GoTo err
            nTmp.Delete
            FuncLogIt sFuncName, "Deleted name [" & sRangeName & "]", C_MODULE_NAME, LogMsgType.OK
            On Error GoTo 0
            Exit Sub
        End If
    End With
err:
    FuncLogIt sFuncName, "Could not delete name [" & sRangeName & "] [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
Public Sub CreateNamedRange(wbTmp As Workbook, sAddress As String, sSheetName As String, sRangeName As String, sLocalScope As String)
Dim rData As Range
Dim nrTmp As Name
Dim sFuncName As String
Dim sLogMsg As String

init:
    sFuncName = CsModuleName & "." & "CreateNamedRange"
    Set nrTmp = Nothing

main:
    With wbTmp.Sheets(sSheetName)
        On Error GoTo err
        Set rData = Sheets(sSheetName).Range(sAddress)
        On Error GoTo 0
    End With
    
    If sLocalScope = "True" Then
        On Error Resume Next
        Set nrTmp = wbTmp.Sheets(sSheetName).Names.Item(sRangeName)
        On Error GoTo 0
        
        If nrTmp Is Nothing Then
            wbTmp.Sheets(sSheetName).Names.Add Name:=sRangeName, RefersTo:=rData
            Exit Sub
        End If
        
        If nrTmp.RefersToRange.Address <> rData.Address Then
            nrTmp.RefersTo = rData
        End If
    Else:
        wbTmp.Names.Update Name:=sRangeName, RefersTo:=rData
    End If
    
    FuncLogIt sFuncName, "Create range named [" & sAddress & "] in [" & sSheetName & "]", C_MODULE_NAME, LogMsgType.Error
    Exit Sub


err:
    FuncLogIt sFuncName, "Could not create range named [" & sAddress & "] in [" & sSheetName & "] [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
