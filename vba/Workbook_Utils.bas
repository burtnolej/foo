Attribute VB_Name = "Workbook_Utils"
Option Explicit

' Sub       | MakeCellInteger       | (wsTmp As Worksheet, rCell As Range, Optional sTakeFocus As Boolean = False)
' ----------------------------------------------------------------------------------------------
' Make the format of cell [rCell] a number format of integer (so no decimal places)

' Sub       | MakeCellLongDate      | (wsTmp As Worksheet, rCell As Range, Optional sTakeFocus As Boolean = False)
' ----------------------------------------------------------------------------------------------
' Make the format of cell [rCell] a long date format "m/d/yyyy h:mm"

' Function  | CreateBook            | (sName) As Workbook
' Sub       | DeleteBook            | (sName As String)
' Function  | GetSheet              | (wb As Workbook, sSheetName As String, Optional bOverwrite As Boolean) As Worksheet
' Sub       | DeleteSheet           | (wb As Workbook, sSheetName As String)
' Function  | SheetExists           | (wb As Workbook, sSheetName As String) As Boolean
' Sub       | CloseBook             | (wbTmp As Workbook, Optional bSaveFlag As Boolean)
' Function  | ShowSheet             | (wb As Workbook, sSheetName As String) As Worksheet
' Sub       | HideSheet             | (wb As Workbook, sSheetName As String)
' Function  | ToggleSheet           | (wb As Workbook, sSheetName As String) As Worksheet
' Function  | SheetIsVisible        | (wb As Workbook, sSheetName As String) As Boolean
' Function  | CreateSheet           | (wb As Workbook, sSheetName As String, Optional bOverwrite As Boolean) As Worksheet

Const C_MODULE_NAME = "Workbook_Utils"
Public Function OpenBook(ByVal sName As String, Optional sPath As String) As Workbook
    If sPath <> "" Then
        sName = sPath & "\\" & sName
    End If
    Set OpenBook = Workbooks.Open(sName)
End Function
Public Function BookExists(sName As String) As Boolean
    BookExists = FileExists(sName)
End Function
Public Function CreateBook(sName) As Workbook
    Set CreateBook = Workbooks.Add
    CreateBook.SaveAs sName
End Function
Sub DeleteBook(sName As String)
    Application.DisplayAlerts = False
    Call DeleteFile(sName)
    Application.DisplayAlerts = True
End Sub
Public Sub MakeCellInteger(wsTmp As Worksheet, rCell As Range, Optional sTakeFocus As Boolean = False)
Dim rCurrentCell As Range
Dim wsCurrent As Worksheet

    Set rCurrentCell = Selection
    Set wsCurrent = rCurrentCell.Worksheet
    
    With wsTmp
        .Activate
        .Range(rCell.Address).Select
        Selection.NumberFormat = "0"
    End With
    
    If sTakeFocus = False Then
        With wsCurrent
            .Activate
            .Range(rCurrentCell.Address).Select
        End With
    End If
End Sub
Public Sub MakeCellLongDate(wsTmp As Worksheet, rCell As Range, Optional sTakeFocus As Boolean = False)
Dim rCurrentCell As Range
Dim wsCurrent As Worksheet

    Set rCurrentCell = Selection
    Set wsCurrent = rCurrentCell.Worksheet
    
    With wsTmp
        .Activate
        .Range(rCell.Address).Select
        Selection.NumberFormat = "m/d/yyyy h:mm"
    End With
    
    If sTakeFocus = False Then
        With wsCurrent
            .Activate
            .Range(rCurrentCell.Address).Select
        End With
    End If
End Sub
Public Function GetSheets(wb As Workbook) As String()
Dim aSheets() As String
Dim iCount As Integer
Dim iMaxSheets As Integer
Dim wsSheet As Worksheet

    iMaxSheets = wb.Sheets.Count
    ReDim aSheets(0 To iMaxSheets - 1)
    For iCount = 1 To iMaxSheets
        aSheets(iCount - 1) = wb.Sheets(iCount).Name
    Next iCount
    GetSheets = aSheets
End Function
Public Function GetSheet(wb As Workbook, sSheetName As String, Optional bOverwrite As Boolean) As Worksheet
    Set GetSheet = wb.Sheets(sSheetName)
End Function
Public Function CreateSheet(wb As Workbook, sSheetName As String, Optional bOverwrite As Boolean) As Worksheet

    If SheetExists(wb, sSheetName) = True And bOverwrite = True Then
        Call DeleteSheet(wb, sSheetName)
    End If
    
    Set CreateSheet = wb.Sheets.Add()
    CreateSheet.Name = sSheetName
End Function
Public Function SheetIsVisible(wb As Workbook, sSheetName As String) As Boolean
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SheetIsVisible"

    SheetIsVisible = False
    On Error GoTo err
    With wb.Sheets(sSheetName)
        SheetIsVisible = ActiveWorkbook.Sheets(sSheetName).Visible
    End With
    On Error GoTo 0
    Exit Function
err:
    FuncLogIt sFuncName, "Could not determine if sheet is visible [" & sSheetName & "] [ " & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
    
End Function
Public Function ToggleSheet(wb As Workbook, sSheetName As String) As Worksheet
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "ToggleSheet"

    On Error GoTo err
    If SheetIsVisible(wb, sSheetName) = True Then
        HideSheet wb, sSheetName
    Else
        ShowSheet wb, sSheetName
    End If

    On Error GoTo 0
    Set ToggleSheet = wb.Sheets(sSheetName)
    Exit Function
err:
    FuncLogIt sFuncName, "Could not toggle sheet [" & sSheetName & "] [ " & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
    
End Function
Public Sub HideSheet(wb As Workbook, sSheetName As String)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "HideSheet"

    On Error GoTo err
    With wb.Sheets(sSheetName)
        .Visible = False
    End With
    On Error GoTo 0
    Exit Sub
err:
    FuncLogIt sFuncName, "Could not hide sheet [" & sSheetName & "] [ " & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
    
End Sub
Public Function ShowSheet(wb As Workbook, sSheetName As String) As Worksheet
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "ShowSheet"

    On Error GoTo err
    With wb.Sheets(sSheetName)
        .Visible = True
    End With
    Set ShowSheet = wb.Sheets(sSheetName)
    On Error GoTo 0
    Exit Function
err:
    FuncLogIt sFuncName, "Could not make sheet visible[" & sSheetName & "] [ " & err.Description & "]", C_MODULE_NAME, LogMsgType.Error
End Function

Sub CloseBook(wbTmp As Workbook, Optional bSaveFlag As Boolean)
    Application.DisplayAlerts = False
    If bSaveFlag = True Then
        Call wbTmp.Save
    End If
    Call wbTmp.Close
    Application.DisplayAlerts = True
End Sub
Public Sub DeleteSheet(wb As Workbook, sSheetName As String)
Dim sFuncName As String
setup:
    sFuncName = C_MODULE_NAME & "." & "DeleteSheet"
    Application.DisplayAlerts = False

main:
    If wb.Sheets.Count = 1 Then
        FuncLogIt sFuncName, "Could not delete sheet as its the only 1 left in the workbook", C_MODULE_NAME, LogMsgType.Error
    Else
        wb.Sheets(sSheetName).Delete
    End If

cleanup:
    Application.DisplayAlerts = True
End Sub

Public Function SheetExists(wb As Workbook, sSheetName As String) As Boolean
Dim wsTmp As Worksheet
    On Error GoTo err
    Set wsTmp = wb.Sheets(sSheetName)
    SheetExists = True
    Exit Function
    
err:
    SheetExists = False
    Exit Function
End Function
