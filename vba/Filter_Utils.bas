Attribute VB_Name = "Filter_Utils"
'"Private Sub Worksheet_Change(ByVal Target As Range)" & VbCrf & "DoFilter Target" & VbCrf & "end Sub"
Public Sub AddFilterIndexCol(wbTmp As Workbook, sSheetName As String, iLength As Integer)
Dim rSource As Range
Dim rTarget As Range
Dim iCol As Integer

init:
    iCol = 50

main:
    With wbTmp.Sheets(sSheetName)
        ' check to see if the index has already been set
        If .Cells(iLength, iCol).value <> iLength Then
            Set rSource = .Range(.Cells(1, iCol), .Cells(2, iCol))
            rSource.Rows(1).value = "1"
            rSource.Rows(2).value = "2"
            Set rTarget = .Range(.Cells(1, iCol), .Cells(iLength, iCol))
            
            FillDown rSource, rTarget
        End If
    End With
        
End Sub
Public Sub CreateFilter(wbTmp As Workbook, sSheetName As String, rFilter As Range, _
        iFilterCount As Integer)
Dim sText As String, sRangeName As String, sFilterCountName As String

    sText = "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine & _
           "DoFilter ActiveWorkbook, ActiveWorkbook.ActiveSheet.Name, Target" & vbNewLine & "end Sub"

    Set wsTmp = GetSheet(wbTmp, sSheetName)
    
    sRangeName = sSheetName & "_" & "VZFilter"
    sFilterCountName = sSheetName & "_" & "VZFilterCount"
    
    CreateNamedRange ActiveWorkbook, rFilter.Address, sSheetName, sRangeName, "True"
    CreateNamedRange ActiveWorkbook, "G1:G1", sSheetName, sFilterCountName, "True"
    
    Call AddCode2Module(Application.ActiveWorkbook, wsTmp.CodeName, sText)
    
    With wsTmp
        .Range(sFilterCountName).value = iFilterCount
    End With
End Sub
Public Sub DoFilter(wbTmp As Workbook, sSheetName As String, Target As Range)

    ' The Target range needs to be a cell so 1 by 1
    If IsNonBlankCell(Target) = False Then
        GoTo endsub
    End If
        
    DoEventsOff
    
    AddFilterIndexCol Application.ActiveWorkbook, ActiveWorkbook.ActiveSheet.Name, 1000
    
    sSheetName = Application.ActiveSheet.Name
    
    With wbTmp.Sheets(sSheetName)
        .Activate

        VZFilter wbTmp, sSheetName, Target.value, Target.Column, _
                    .Range(sSheetName & "_" & "VZFilterCount").value ' the height of the search grid

        ' now clear out any filter keys
        If Target.value = "reset" Then
            .Range(sSheetName & "_" & "VZFilter").ClearContents
        End If
        
    End With
    
endsub:
    DoEventsOn

End Sub

Function InFilterHist(vSearchFilteredCol As Variant, iRow As Integer, sValue As String) As Boolean

    InFilterHist = False
    If InStr(LCase(vSearchFilteredCol(iRow, 1)), LCase(sValue)) <> 0 Then
        InFilterHist = True
    End If
    
End Function
Sub AddToFilterHist(ByRef vFilterHist As Variant, iRowNum As Integer, iCol As Integer)
    vFilterHist(iRowNum, 1) = vFilterHist(iRowNum, 1) & "^" & CStr(iCol)
End Sub
Sub RemoveFromFilterHist(ByRef vFilterHist As Variant, iRowNum As Integer, iCol As Integer)
    vFilterHist(iRowNum, 1) = Replace(vFilterHist(iRowNum, 1), "^" & CStr(iCol), BLANK)
End Sub

Function AddToVisibleRange(ByRef rVisible As Range, iRowNum As Integer, sHist As String, wsTmp As Worksheet) As Boolean
    AddToVisibleRange = False
    With wsTmp
        If sHist = BLANK Then ' make visible as no active filter
           If rVisible Is Nothing Then
               Set rVisible = .Range(.Cells(iRowNum, 1), .Cells(iRowNum, 1))
            Else
               Set rVisible = Union(rVisible, .Range(.Cells(iRowNum, 1), _
                       .Cells(iRowNum, 1)))
           End If
           AddToVisibleRange = True
        End If
    End With
End Function

Sub VZFilter(wbTmp As Workbook, sSheetName As String, sValue As String, iCol As Integer, _
        iLength As Integer, Optional iFilterHistColumn As Integer = 25)
Dim rSearch As Range, rCell As Range, rHidden As Range, rArea As Range, rVisible As Range, rGroup As Range
Dim rSearchFilteredCol As Range, rSearchIndex As Range, rFilterHist As Range
Dim vSearch() As Variant, vSearchFilteredCol() As Variant, vSearchIndex() As Variant, vFilterHist() As Variant
Dim bNot As Boolean, bOr As Boolean, bVisible As Boolean
Dim sNewFilterHist As String, sFilterHistChunk As String, sFilterHist As String
Dim iRowNum As Integer

    bNot = False
    bOr = False
    
    With wbTmp.Sheets(sSheetName)
        Set rSearch = .Range(.Cells(2, 1), .Cells(iLength + 1, 50))
        
        ' determime any special operators in search term
        
        ' NOT operator
        If Left(sValue, 1) = "!" Then
            bNot = True
            sValue = Right(sValue, Len(sValue) - 1)
            
        ' COLUMN OR operator
        ElseIf Left(sValue, 1) = "^" Then
            bOr = True
            sValue = Right(sValue, Len(sValue) - 1)
            
        ' RESET ALL filters
        ElseIf sValue = "reset" Then
            rSearch.EntireRow.Hidden = False
            rSearch.Columns(iFilterHistColumn).ClearContents
            Exit Sub
            
        ' RESET JUST THIS COLUMN
        ElseIf sValue = "x" Then ' reset just this one filter
            Set rHidden = rSearch
            
            ' iterate over all the filter histories for the hidden rows
            ' and remove instances of this filter
            For j = 1 To rHidden.Areas.Count
                Set rSearchIndex = rSearch.Areas(j).Columns(50)
                Set rFilterHist = rSearch.Areas(j).Columns(iFilterHistColumn)
                vSearchIndex = rSearchIndex
                vFilterHist = rFilterHist
                
                For i = 1 To UBound(vFilterHist)
                    vRowFilterHist = Split(vFilterHist(i, 1), HAT)
                    iRowNum = Int(vSearchIndex(i, 1))
                    
                    If UBound(vRowFilterHist) <> 0 And .Rows(iRowNum).EntireRow.Hidden = True Then
                        If InFilterHist(vFilterHist, CInt(i), "^" & CStr(iCol)) = True Then
                            RemoveFromFilterHist vFilterHist, CInt(i), iCol
                            AddToVisibleRange rVisible, iRowNum, CStr(vFilterHist(i, 1)), wbTmp.Sheets(sSheetName)
                        End If
                    End If
                Next i
            Next j
        
            rFilterHist.value = vFilterHist
            
            If rVisible Is Nothing Then
            Else
                rVisible.EntireRow.Hidden = False
                Set rVisible = Nothing
            End If
            Application.StatusBar = "# Results : " & CStr(GetMultiAreaRowCount(rSearchIndex.Rows.SpecialCells(xlCellTypeVisible)))
            Exit Sub
        End If
        
        For j = 1 To rSearch.Areas.Count
        
            'in here create 2 columns 1 for the column being searched and 1 with the orig index
            Set rSearchFilteredCol = rSearch.Areas(j).Columns(iCol)
            Set rSearchIndex = rSearch.Areas(j).Columns(50)
            Set rFilterHist = rSearch.Areas(j).Columns(iFilterHistColumn)
            
            If rSearchFilteredCol.Rows.Count = 1 And rSearchFilteredCol.Columns.Count = 1 Then
                'special case where area is 1 cell
                ReDim vSearchFilteredCol(1 To 1, 1 To 1)
                vSearchFilteredCol(1, 1) = rSearchFilteredCol.value
                ReDim vSearchIndex(1 To 1, 1 To 1)
                vSearchIndex(1, 1) = rSearchIndex.value
            Else
                vSearchFilteredCol = rSearchFilteredCol
                vSearchIndex = rSearchIndex
                vFilterHist = rFilterHist
            End If
        
            For i = LBound(vSearchFilteredCol) To UBound(vSearchFilteredCol)
                bVisible = False

                iRowNum = Int(vSearchIndex(i, 1))
                
                If InFilterHist(vSearchFilteredCol, CInt(i), sValue) = True Then
                    If bNot = False Then
                        If .Rows(iRowNum).EntireRow.Hidden = False Then
                            bVisible = True
                        ElseIf bOr = True Then
                            bVisible = True
                        End If
                    End If
                Else
                    If bNot = True Then
                        bVisible = True
                    End If
                End If
                
                If bVisible = True Then
                    AddToVisibleRange rVisible, iRowNum, "", wbTmp.Sheets(sSheetName)
                ElseIf InFilterHist(vSearchFilteredCol, CInt(i), sValue) = False Then
                    AddToFilterHist vFilterHist, iRowNum - 1, iCol
                ElseIf bNot = True Then
                    If InFilterHist(vSearchFilteredCol, CInt(i), sValue) = True Then
                        AddToFilterHist vFilterHist, iRowNum - 1, iCol
                    End If
                End If
            Next i
        Next j

        rFilterHist.value = vFilterHist
        
        If rVisible Is Nothing Then
            'no hits found
        Else
            If bOr = False Then
                rSearch.EntireRow.Hidden = True
            End If
            rVisible.EntireRow.Hidden = False
        End If
    End With
    Application.StatusBar = "# Results : " & CStr(GetMultiAreaRowCount(rSearch.Rows.SpecialCells(xlCellTypeVisible)))
End Sub

Sub VZFilterOld(wbTmp As Workbook, sSheetName As String, sValue As String, iCol As Integer, _
        iLength As Integer, Optional iFilterHistColumn As Integer = 25)
Dim rSearch As Range, rCell As Range, rHidden As Range, rArea As Range, rVisible As Range, rGroup As Range
Dim rSearchFilteredCol As Range, rSearchIndex As Range, rFilterHist As Range
Dim vSearch() As Variant, vSearchFilteredCol() As Variant, vSearchIndex() As Variant, vFilterHist() As Variant
Dim bNot As Boolean, bOr As Boolean, bVisible As Boolean
Dim sNewFilterHist As String, sFilterHistChunk As String, sFilterHist As String
Dim iRowNum As Integer

    bNot = False
    bOr = False
    
    With wbTmp.Sheets(sSheetName)
        Set rSearch = .Range(.Cells(2, 1), .Cells(iLength + 1, 50))
        
        ' determime any special operators in search term
        
        ' NOT operator
        If Left(sValue, 1) = "!" Then
            bNot = True
            sValue = Right(sValue, Len(sValue) - 1)
            
        ' COLUMN OR operator
        ElseIf Left(sValue, 1) = "^" Then
            bOr = True
            sValue = Right(sValue, Len(sValue) - 1)
            
        ' RESET ALL filters
        ElseIf sValue = "reset" Then
            rSearch.EntireRow.Hidden = False
            rSearch.Columns(iFilterHistColumn).ClearContents
            Exit Sub
            
        ' RESET JUST THIS COLUMN
        ElseIf sValue = "x" Then ' reset just this one filter
            Set rHidden = rSearch
            
            ' iterate over all the filter histories for the hidden rows
            ' and remove instances of this filter
            For j = 1 To rHidden.Areas.Count
                Set rSearchIndex = rSearch.Areas(j).Columns(50)
                Set rFilterHist = rSearch.Areas(j).Columns(iFilterHistColumn)
                vSearchIndex = rSearchIndex
                vFilterHist = rFilterHist
                
                For i = 1 To UBound(vFilterHist)
                    iRowNum = Int(vSearchIndex(i, 1))
                    If vFilterHist(i, 1) <> "" And .Rows(iRowNum).EntireRow.Hidden = True Then
                        ' working backwards from most recent filter
                        For k = Len(vFilterHist(i, 1)) To 2 Step -2
                            sFilterHistChunk = Mid(vFilterHist(i, 1), k - 1, 2)
                            ' if a history matches the column being reset
                            If sFilterHistChunk = "^" & CStr(iCol) Then
                                'this line needs to take out the ^3 not just remove the last
                                vFilterHist(i, 1) = Replace(vFilterHist(i, 1), "^" & CStr(iCol), BLANK)
                                
                                If AddToVisibleRange(rVisible, iRowNum, CStr(vFilterHist(i, 1)), wbTmp.Sheets(sSheetName)) Then
                                Else
                                    sNextFilterColumn = Int(Right(vFilterHist(i, 1), 1))
                                    sNextFilterValue = .Range(sSheetName & "_VZFilter").Columns(sNextFilterColumn).value
                                    sNextValue = .Range(.Cells(iRowNum, sNextFilterColumn), .Cells(iRowNum, sNextFilterColumn)).value
                                    
                                    If InStr(sNextValue, sNextFilterValue) <> 0 Then
                                        ' take out of filter
                                         vFilterHist(i, 1) = Replace(vFilterHist(i, 1), "^" & CStr(sNextFilterColumn), BLANK)
                                        AddToVisibleRange rVisible, iRowNum, CStr(vFilterHist(i, 1)), wbTmp.Sheets(sSheetName)
                                    End If
                                End If
                            End If
                        Next k
                    End If
                Next i
            Next j
        
            rFilterHist.value = vFilterHist
            
            If rVisible Is Nothing Then
            Else
                rVisible.EntireRow.Hidden = False
                Set rVisible = Nothing
            End If
            Application.StatusBar = "# Results : " & CStr(GetMultiAreaRowCount(rSearchIndex.Rows.SpecialCells(xlCellTypeVisible)))
            Exit Sub
        End If
        
        For j = 1 To rSearch.Areas.Count
        
            'in here create 2 columns 1 for the column being searched and 1 with the orig index
            Set rSearchFilteredCol = rSearch.Areas(j).Columns(iCol)
            Set rSearchIndex = rSearch.Areas(j).Columns(50)
            Set rFilterHist = rSearch.Areas(j).Columns(iFilterHistColumn)
            
            If rSearchFilteredCol.Rows.Count = 1 And rSearchFilteredCol.Columns.Count = 1 Then
                'special case where area is 1 cell
                ReDim vSearchFilteredCol(1 To 1, 1 To 1)
                vSearchFilteredCol(1, 1) = rSearchFilteredCol.value
                ReDim vSearchIndex(1 To 1, 1 To 1)
                vSearchIndex(1, 1) = rSearchIndex.value
            Else
                vSearchFilteredCol = rSearchFilteredCol
                vSearchIndex = rSearchIndex
                vFilterHist = rFilterHist
            End If
        
            For i = LBound(vSearchFilteredCol) To UBound(vSearchFilteredCol)
                bVisible = False

                iRowNum = Int(vSearchIndex(i, 1))
                
                If InStr(LCase(vSearchFilteredCol(i, 1)), LCase(sValue)) <> 0 Then
                    If bNot = False Then
                        If .Rows(iRowNum).EntireRow.Hidden = False Then
                            bVisible = True
                        ElseIf bOr = True Then
                            bVisible = True
                        End If
                    End If
                Else
                    If bNot = True Then
                        bVisible = True
                    End If
                End If
                
                If bVisible = True Then
                    If rVisible Is Nothing Then
                        Set rVisible = .Range(.Cells(iRowNum, iCol), .Cells(iRowNum, iCol))
                    Else
                        Set rVisible = Union(rVisible, .Range(.Cells(iRowNum, iCol), .Cells(iRowNum, iCol)))
                    End If
                Else
                    vFilterHist(iRowNum - 1, 1) = vFilterHist(iRowNum - 1, 1) & "^" & CStr(iCol)
                End If
            Next i
        Next j

        rFilterHist.value = vFilterHist
        
        If rVisible Is Nothing Then
            'no hits found
        Else
            If bOr = False Then
                rSearch.EntireRow.Hidden = True
            End If
            rVisible.EntireRow.Hidden = False
        End If
    End With
    Application.StatusBar = "# Results : " & CStr(GetMultiAreaRowCount(rSearch.Rows.SpecialCells(xlCellTypeVisible)))
End Sub

