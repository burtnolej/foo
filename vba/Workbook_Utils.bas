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
Dim w As Variant

    For Each w In Workbooks
        If w.Name = sName Then
            Set OpenBook = w
            Exit Function
        End If
    Next w
    If sPath <> "" Then
        sName = sPath & "\\" & sName
    End If
    Set OpenBook = Workbooks.Open(sName)
End Function
Public Function BookExists(sName As String) As Boolean
    BookExists = FileExists(sName)
End Function
Public Function CreateBook(sName As String, Optional sBookPath As String) As Workbook
Dim sCwd As String
Dim ffFileFormat As XlFileFormat

    If sBookPath <> "" Then
        sCwd = GetHomePath
        ChDir sBookPath
    End If
    
    If Right(sName, 5) = ".xlsm" Then
        ffFileFormat = xlOpenXMLWorkbookMacroEnabled
    ElseIf Right(sName, 5) = ".xlsx" Then
        ffFileFormat = xlOpenXMLWorkbook
    ElseIf Right(sName, 4) = ".xls" Then
        ffFileFormat = xlExcel12
    ElseIf InStr(sName, ".") = 0 Then
        sName = sName & ".xls"
        ffFileFormat = xlExcel12
    Else
        err.Raise Error_Utils.BAD_FILE_EXTENSION, "unsupported file extension"
    End If
    
    Set CreateBook = Workbooks.Add
    
    Application.DisplayAlerts = False
    CreateBook.SaveAs sName, FileFormat:=ffFileFormat
    Application.DisplayAlerts = True
        
    If sBookPath <> "" Then
        ChDir sCwd
    End If
End Function
Sub DeleteBook(sName As String, Optional sPath As String)
    'Application.DisplayAlerts = False
    Call DeleteFile(sName, sPath:=sPath)
    'Application.DisplayAlerts = True
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
    If IsSet(wbTmp) Then
        If bSaveFlag = True Then
            Call wbTmp.Save
        End If
        Call wbTmp.Close
    Else
        err.Raise ErrorMsgType.NULL_OBJECT, Description:="nothing workbook obj passed"
    End If
    Application.DisplayAlerts = True
End Sub
Public Sub DeleteSheet(wb As Workbook, sSheetName As String)
Dim sFuncName As String
Dim wsTmp As Worksheet

setup:
    sFuncName = C_MODULE_NAME & "." & "DeleteSheet"
    Application.DisplayAlerts = False

main:
    If wb.Sheets.Count = 1 Then
        FuncLogIt sFuncName, "Could not delete sheet as its the only 1 left in the workbook", C_MODULE_NAME, LogMsgType.Error
    Else
        If SheetExists(wb, sSheetName) = True Then
            For Each wsTmp In wb.Sheets
                If wsTmp.Name = sSheetName Then
                    wsTmp.Visible = True
                    wsTmp.Delete
                End If
            Next wsTmp
            'wb.Sheets(sSheetName).Delete
        Else
            FuncLogIt sFuncName, "Trying to delete a sheet that does not exist [" & sSheetName & "]", C_MODULE_NAME, LogMsgType.Failure
        End If
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
