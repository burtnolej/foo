Attribute VB_Name = "Workbook_Utils"
Option Explicit

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
Sub CloseBook(wbTmp As Workbook, Optional bSaveFlag As Boolean)
    Application.DisplayAlerts = False
    If bSaveFlag = True Then
        Call wbTmp.Save
    End If
    Call wbTmp.Close
    Application.DisplayAlerts = True
End Sub
Public Sub DeleteSheet(wb As Workbook, sSheetName As String)
    Application.DisplayAlerts = False
    wb.Sheets(sSheetName).Delete
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
