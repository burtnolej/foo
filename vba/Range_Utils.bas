Attribute VB_Name = "Range_Utils"
Const C_MODULE_NAME = "Range_Utils"
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

Public Function GetRange(sBookName As String, sSheetName As String, sAddress As String, _
                    Optional bNamedRange As Boolean = False) As Range
Dim wbTmp As Workbook
Dim wsTmp As Worksheet
Dim sFuncName As String, sDebugStr As String
Dim nName As Name

setup:
    sFuncName = C_MODULE_NAME & "." & "GetRange"
    FuncLogIt sFuncName, "[sBookName=" & sBookName & "] [sSheetName=" & sSheetName & "] [sAddress=" & sAddress & "]", C_MODULE_NAME, LogMsgType.INFUNC
    On Error GoTo err

    Set wbTmp = Workbooks(sBookName)
    Set wsTmp = wbTmp.Sheets(sSheetName)
    
    If bNamedRange = True Then
        If NamedRangeExists(wbTmp, sSheetName, sAddress) = False Then
            err.Raise ErrorMsgType.NAMED_RANGE_NOT_EXIST, Description:="named range does not exist"
        End If
    End If
    
    Set GetRange = wsTmp.Range(sAddress)
    
endfunc:
    On Error GoTo 0
    Exit Function

err:
    FuncLogIt sFuncName, "[" & err.Description & "] [sBookName=" & sBookName & "] [sSheetName=" & sSheetName & "] [sAddress=" & sAddress & "]", C_MODULE_NAME, LogMsgType.Error

End Function
Public Function ListFromRange(wsTmp As Worksheet, sSourceAddress As String, _
                    Optional bNamedRange As Boolean = False, Optional bBreakOnSpace As Boolean = True) As String()
Dim vTmpRange As Variant
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "ListFromRange"
    FuncLogIt sFuncName, "[wsTmp=" & wsTmp.Name & "] [sSourceAddress=" & sSourceAddress & "]", C_MODULE_NAME, LogMsgType.INFUNC
    On Error GoTo errorhandler
    
main:
    vTmpRange = GetRange(wsTmp.Parent.Name, wsTmp.Name, sSourceAddress, bNamedRange:=bNamedRange)
    
    For i = 1 To UBound(vTmpRange)
        If vTmpRange(i, 1) = "" Then
            vTmpRange = ReDim2DArray(vTmpRange, i - 1, 1, iStartRow:=1, iStartCol:=1)
            
            If bBreakOnSpace = True Then
                GoTo lastvaluefound
            End If
        End If
    Next i
    
lastvaluefound:
    ListFromRange = ConvertArrayFromRangeto1D(vTmpRange)
    On Error GoTo 0
    Exit Function

errorhandler:
    FuncLogIt sFuncName, "[" & err.Description & "] [sSourceAddress=" & sSourceAddress & "]", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description
    
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
    ElseIf rCell.value <> BLANK Then
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
    ElseIf rCell.value = BLANK Then
        IsNonBlankCell = False
    End If
End Function
Public Function RangeFromStrArray(vSource As Variant, wsTarget As Worksheet, _
            iRowOffset As Integer, iColOffset As Integer) As Range
'<<<
'purpose: put a string array into a range on a worksheet; uses variant to maintain datatypes in cells
'param  : vSource, variant; array of input values
'param  : wsTarget, worksheet; which sheet to use
'param  : iRowOffset/iColOffset, integer; where on sheet to put 1st cell
'rtype  : range; created range
'>>>
Dim wsTmp As Worksheet
Dim rRange As Range
Dim iRows As Integer, iCols As Integer
Dim sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = CsModuleName & "." & "RangeFromStrArray"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)

main:
    iRows = iRowOffset + UBound(vSource) + 1 - LBound(vSource)
    iCols = iColOffset + UBound(vSource, 2) + 1 - LBound(vSource, 2)
    
    With wsTarget
        Set rRange = .Range(.Cells(1 + iRowOffset, 1 + iColOffset), .Cells(iRows, iCols))
        rRange = vSource
    End With
    
    Set RangeFromStrArray = rRange
    
cleanup:
    FuncLogIt sFuncName, "[iRowOffset=" & CStr(iRowOffset) & "] [iColOffset=" & CStr(iColOffset) & "] [vSource=" & CStr(UBound(vSource) + 1) & " Rows]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Function
Public Sub FillDown(rSource As Range, rTarget As Range)
Dim sFuncName As String

init:
    sFuncName = C_MODULE_NAME & "." & "FillDown"

main:

    rSource.Select
    Selection.AutoFill Destination:=rTarget, Type:=xlFillDefault

cleanup:
    
End Sub


Public Function GetSheetNamedRanges(wbTmp As Workbook, sSheetName As String, Optional sStartsWith As String = "") As String()
Dim aNames() As String
Dim iCount As Integer
Dim sTmp As String
Dim sFuncName As String

init:
    sFuncName = C_MODULE_NAME & "." & "DeleteNamedRange"
    ReDim aNames(0 To 100)

main:

    For Each name_ In wbTmp.Sheets(sSheetName).Names
        sTmp = Split(name_.Name, "!")(1)
        If Left(sTmp, Len(sStartsWith)) = sStartsWith Then
            aNames(iCount) = sTmp
            iCount = iCount + 1
        End If
    Next name_
    
    If iCount = 0 Then
        'FuncLogIt sFuncName, "no named ranges found [" & sSheetName & "] [sStartsWith=" & sStartsWith & "]", C_MODULE_NAME, LogMsgType.INFO
        ReDim aNames(0)
    Else
        ReDim Preserve aNames(0 To iCount - 1)
    End If
    GetSheetNamedRanges = aNames
End Function
Public Function NamedRangeExists(wbTmp As Workbook, sSheetName As String, sRangeName As String) As Boolean
Dim nTmp As Name

    If sSheetName = "" Then
        With wbTmp
            On Error GoTo err
            Set nTmp = .Names.Item(sRangeName)
            On Error GoTo 0
            NamedRangeExists = True
            Exit Function
        End With
    Else
        With wbTmp.Sheets(sSheetName)
        
            On Error GoTo err
            Set nTmp = .Names.Item(sRangeName)
            On Error GoTo 0
            NamedRangeExists = True
            Exit Function
    
        End With
    End If
err:
    NamedRangeExists = False

End Function

Public Sub DeleteNamedRange(wbTmp As Workbook, sSheetName As String, sRangeName As String)
Dim nTmp As Name
Dim sFuncName As String

init:
    sFuncName = C_MODULE_NAME & "." & "DeleteNamedRange"

main:
    With wbTmp.Sheets(sSheetName)
        On Error GoTo err
        Set nTmp = .Names.Item(sRangeName)
        On Error GoTo 0
        If nTmp Is Nothing Then
            FuncLogIt sFuncName, "Could not find name [" & sRangeName & "]", C_MODULE_NAME, LogMsgType.Failure
        Else
            On Error GoTo err
            nTmp.Delete
            On Error GoTo 0
            Exit Sub
        End If
    End With
err:
    FuncLogIt sFuncName, "Could not delete name [" & sRangeName & "] [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
Public Sub CreateNamedRange(wbTmp As Workbook, sAddress As String, sSheetName As String, sRangeName As String, sLocalScope As String)
'<<<
'purpose: create a "Named" range in the workbook
'param  : wbTmp, workbook; target Book
'param  : sAddress, string; co-ordinates of the range to be names
'param  : sSheetName, string; target sheet
'param  : sRangeName, string; what to call it
'param  : sLocalScope, string; scoped to this worksheet or entire book "True"|"False"
'>>>
Dim rData As Range
Dim nrTmp As Name
Dim sFuncName As String, sLogMsg As String
Dim lStartTick As Long

setup:
    sFuncName = CsModuleName & "." & "CreateNamedRange"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)

init:
    Set nrTmp = Nothing

main:
    With wbTmp.Sheets(sSheetName)
        On Error GoTo err
        Set rData = .Range(sAddress)
        On Error GoTo 0
    End With
    
    If sLocalScope = "True" Then
        On Error Resume Next
        Set nrTmp = wbTmp.Sheets(sSheetName).Names.Item(sRangeName)
        On Error GoTo 0
        
        If nrTmp Is Nothing Then
            wbTmp.Sheets(sSheetName).Names.Add Name:=sRangeName, RefersTo:=rData
            GoTo cleanup
        End If
        
        If nrTmp.RefersToRange.Address <> rData.Address Then
            nrTmp.RefersTo = rData
        End If
    Else:
        wbTmp.Names.Add Name:=sRangeName, RefersTo:=rData
    End If
    
    
cleanup:
    FuncLogIt sFuncName, "Create range [sRangeName=" & sRangeName & "] [" & sAddress & "] in [" & sSheetName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Sub

err:
    FuncLogIt sFuncName, "Could not create range named [" & sAddress & "] in [" & sSheetName & "] [" & err.Description & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
Public Function GetRangeDimensions(rSource As Range, ByRef iWidth As Integer, ByRef iHeight As Integer)
Dim rMerge As Range

    If rSource.MergeCells Then
        ' of a merged cell, you can only reference the merged range from the top left cell
        Set rSource = rSource.Resize(1, 1)
        On Error GoTo err
        Set rMerge = rSource.MergeArea
        On Error Resume Next
        iWidth = rMerge.Columns.Count
        iHeight = rMerge.Rows.Count
    Else
        iWidth = rSource.Columns.Count
        iHeight = rSource.Rows.Count
    End If
    
    Exit Function

err:
    
    err.Raise ErrorMsgType.NOT_SINGLE_WIDGET_RANGE, "range [" & rSource.Address & "] might not be a single cell"
End Function


