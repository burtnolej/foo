Attribute VB_Name = "Window_Utils"
Option Explicit
'Public Function GetDpi() As Long
'Public Sub SetScrollAreaToVisibleRange(Optional wTmp As Window, Optional sSheetName As String)
'Public Sub SimplifyWindow(Optional wbTmp As Workbook, Optional sSheetName As String, _Optional iWindowID As Integer = 1, Optional bReset As Boolean = False, Optional iZoom As Integer = 70)
'Public Function GetScreenDimensions(ByRef lWidth As Long, ByRef lHeight As Long)
'Public Sub SetWindowLocation(lTop As Long, lLeft As Long, Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
'Public Sub GetWindowLocation(ByRef lTop As Long, ByRef lLeft As Long, _Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
'Public Sub GetWindowSize(ByRef lWidth As Long, ByRef lHeight As Long, Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
'Public Sub SetWindowSize(ByRef lWidth As Long, ByRef lHeight As Long, Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
             
'Public Type WindowSettings
'     rgbFg As RGBColor
'     rgbBg As RGBColor
'     sFont As String
'     sFontStyle As String
'     iFontSize As Integer
'     rTopLabel As Range
'     rBottomLabel As Range
'     rButton1 As Range
'     rButton2 As Range
'     iHeight As Long
'     iWidth As Long
'     iLeft As Long
'     iRight As Long
'     sWindowTitle As String
'     iWindowID As Integer
'     iZoom As Integer
'End Type


Enum WindowScheme
    quadrant = 1
End Enum

Const C_MODULE_NAME = "Window_Utils"
Public Declare Function GetSystemMetrics Lib "user32.dll" (ByVal index As Long) As Long
Public Const SM_CXSCREEN = 0
Public Const SM_CYSCREEN = 1
Private Const LOGPIXELSX As Long = 88

Private Declare Function GetDeviceCaps Lib "gdi32.dll" ( _
ByVal hdc As Long, _
ByVal nIndex As Long) As Long

Private Declare Function GetDC Lib "user32.dll" ( _
ByVal hwnd As Long) As Long

Declare Function ReleaseDC Lib "user32.dll" ( _
ByVal hwnd As Long, _
ByVal hdc As Long) As Long

Public Function GetDpi() As Long
Dim hdcScreen As Long
Dim iDPI As Long
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetDpi"
    On Error GoTo err

main:
    iDPI = -1
    hdcScreen = GetDC(0)
    If (hdcScreen) Then
        iDPI = GetDeviceCaps(hdcScreen, LOGPIXELSX)
        ReleaseDC 0, hdcScreen
    End If

    GetDpi = iDPI

    On Error GoTo 0
    Exit Function
    
err:
    FuncLogIt sFuncName, "could not get screnn DPI", C_MODULE_NAME, LogMsgType.INFO

End Function

Public Function CreateWindowSheet(sSheetName As String, _
                        Optional wbTmp As Workbook, _
                        Optional wID As Integer = 1) As Worksheet
Dim wsTmp As Worksheet
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "CreateWindowSheet"
    'On Error GoTo err

main:
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    Set wsTmp = CreateSheet(wbTmp, sSheetName)
    SetScrollAreaToVisibleRange sSheetName:=sSheetName, wbTmp:=wbTmp
    
    Set CreateWindowSheet = wsTmp

    On Error GoTo 0
    Exit Function
    
err:
    FuncLogIt sFuncName, "could not create window sheet [" & sSheetName & "]", C_MODULE_NAME, LogMsgType.INFO


End Function

Public Function SetScrollAreaToVisibleRange(Optional sSheetName As String, _
                Optional wbTmp As Workbook, Optional wID As Integer = 1) As Range
Dim iVisibleCols As Integer, iVisibleRows As Integer
Dim rVisible As Range
Dim sFuncName As String
Dim wTmp As Window

setup:
    sFuncName = C_MODULE_NAME & "." & "SetScrollAreaToVisibleRange"

main:

    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    Set wTmp = wbTmp.Windows(wID)

    If sSheetName = "" Then
        sSheetName = "Sheet1"
    End If

    Set rVisible = wTmp.VisibleRange
    Sheets(sSheetName).ScrollArea = rVisible.Address

    Set SetScrollAreaToVisibleRange = rVisible
    On Error GoTo 0
    Exit Function
    
err:
    FuncLogIt sFuncName, "could not set scroll area range not simplify window [wTmp=" & CStr(wTmp.index) & "] [rVisible=" & rVisible.Address & "]", C_MODULE_NAME, LogMsgType.INFO

End Function

Public Sub MakeLabel(ByRef winsetTmp As Quad_WindowSettings, _
                     rLabel As Range, _
                     sSheetName As String, _
            Optional wbTmp As Workbook)
Dim sFuncName As String

setup:
    'On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "MakeLabel"

main:
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If

    rLabel.Merge
    SetBgColorByRGB sSheetName, rLabel, winsetTmp.rgbBg, wbTmp:=wbTmp
    SetFgColorByRGB sSheetName, rLabel.Address, winsetTmp.rgbFg, wbTmp:=wbTmp
    SetCenterAlignOn rLabel, wbTmp:=wbTmp, sSheetName:=sSheetName
    rLabel.value = winsetTmp.WindowTitle
    SetFont sSheetName, rLabel.Address, winsetTmp.Font, winsetTmp.FontSize, _
            winsetTmp.FontStyle, wbTmp:=wbTmp
    
    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not make label  [rLabel=" & rLabel.Address & "] [wbTmp=" & wbTmp.name & "]", C_MODULE_NAME, LogMsgType.INFO
    
End Sub
Public Sub SimplifyWindow(winsetTmp As Quad_WindowSettings, _
                 Optional wbTmp As Workbook, _
                 Optional bReset As Boolean = False)
Dim sFuncName As String
Dim wTmp As Window
Dim wsTmp As Worksheet
Dim rVisible As Range, rTopRow As Range, rBottomRow As Range, rStatus As Range, rButton1 As Range, rButton2 As Range
Dim iLabelWidth As Integer, iLabelCol1 As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "SimplifyWindow"

main:
    'On Error GoTo err
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
        
    ShowCaption bReset
    
    wbTmp.Activate
    NormalWindowState wbTmp
    
    Application.ExecuteExcel4Macro "SHOW.TOOLBAR(""Ribbon""," & CStr(bReset) & ")"
    Set wTmp = wbTmp.Windows(winsetTmp.WindowID)
    wTmp.DisplayHorizontalScrollBar = bReset
    wTmp.DisplayVerticalScrollBar = bReset
    wTmp.DisplayWorkbookTabs = bReset
    wTmp.DisplayHeadings = bReset
    wTmp.DisplayGridlines = bReset
    
    Application.DisplayFormulaBar = bReset
    Application.DisplayStatusBar = bReset
    Application.Caption = ""

    wbTmp.Windows(winsetTmp.WindowID).Zoom = winsetTmp.Zoom
    
    For Each wsTmp In wbTmp.Sheets
    
        If bReset = True Then
            wsTmp.ScrollArea = "A1:ZA1000"
        Else
            If winsetTmp.WindowTitle = "" Then
                winsetTmp.WindowTitle = "[" & wsTmp.name & "]"
            End If
        
            Set rVisible = SetScrollAreaToVisibleRange(wbTmp:=wbTmp, sSheetName:=wsTmp.name)
            
            ' top label
            Set rTopRow = rVisible.Rows(1).Resize(2)
            MakeLabel winsetTmp, rTopRow, wsTmp.name
            winsetTmp.TopLabel = rTopRow
            
            ' bottom label
            iLabelWidth = rTopRow.Columns.Count - 2

            Set rBottomRow = rVisible.Rows(rVisible.Rows.Count).Offset(-1).Resize(2, iLabelWidth)
            winsetTmp.WindowTitle = "STATUS BAR"
            MakeLabel winsetTmp, rBottomRow, wsTmp.name
            winsetTmp.BottomLabel = rBottomRow
            
            ' first bottom button
            Set rButton1 = rBottomRow.Offset(, 1).Resize(2, 1)
            winsetTmp.WindowTitle = "X"
            MakeLabel winsetTmp, rButton1, wsTmp.name
            winsetTmp.Button1 = rButton1
                    
            ' second bottom button
            Set rButton2 = rButton1.Offset(, 1).Resize(2)
            winsetTmp.WindowTitle = "Y"
            MakeLabel winsetTmp, rButton2, wsTmp.name
            winsetTmp.Button2 = rButton2
            
        End If
                
    Next wsTmp
    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not simplify window [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(winsetTmp.WindowID) & "]", C_MODULE_NAME, LogMsgType.INFO

End Sub
Public Function GetScreenDimensions(ByRef lWidth As Long, ByRef lHeight As Long)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScreenDimensions"

main:
    On Error GoTo err
    lHeight = GetSystemMetrics(SM_CYSCREEN)
    lWidth = GetSystemMetrics(SM_CXSCREEN)

    On Error GoTo 0
    Exit Function
    
err:
    FuncLogIt sFuncName, "could not get screen dimensions", C_MODULE_NAME, LogMsgType.INFO

End Function
Public Sub MinimumWindowState(Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "MinimizeWindow"

main:
    On Error GoTo err
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If

    wbTmp.Windows(iWindowID).WindowState = xlMinimized

    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not set  window state to normal [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(iWindowID) & "]", C_MODULE_NAME, LogMsgType.Error

End Sub

Public Sub NormalWindowState(Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "MinimizeWindow"

main:
    On Error GoTo err
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If

    wbTmp.Windows(iWindowID).WindowState = xlNormal

    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not set  window state to normal [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(iWindowID) & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
Public Sub SetWindowLocation(lTop As Long, lLeft As Long, _
                           Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SetWorkbookScreenLocation"

main:
    On Error GoTo err
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If

    ' window cannot move if maximized or minimized
    NormalWindowState wbTmp:=wbTmp
    
    wbTmp.Windows(iWindowID).Top = lTop
    wbTmp.Windows(iWindowID).Left = lLeft
    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not set window location [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(iWindowID) & "]", C_MODULE_NAME, LogMsgType.Error

End Sub

Public Sub GetWindowLocation(ByRef lTop As Long, ByRef lLeft As Long, _
                           Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SetWorkbookScreenLocation"

main:
    On Error GoTo err
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    lTop = wbTmp.Windows(iWindowID).Top
    lLeft = wbTmp.Windows(iWindowID).Left
    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not get window location [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(iWindowID) & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
Public Sub SetWindowSize(lWidth As Long, lHeight As Long, _
                           Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "SetWorkbookSize"
    
main:
    On Error GoTo err
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If

    ' window cannot move if maximized or minimized
    NormalWindowState wbTmp:=wbTmp
    
    wbTmp.Windows(iWindowID).Width = lWidth
    wbTmp.Windows(iWindowID).Height = lHeight
    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not set window size [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(iWindowID) & "]", C_MODULE_NAME, LogMsgType.Error

End Sub

Public Sub GetWindowSize(ByRef lWidth As Long, ByRef lHeight As Long, _
                           Optional wbTmp As Workbook, Optional iWindowID As Integer = 1)
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetWindowSize"
    
main:
    On Error GoTo err
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = ActiveWorkbook
    End If
    
    lWidth = wbTmp.Windows(iWindowID).Width
    lHeight = wbTmp.Windows(iWindowID).Height
    On Error GoTo 0
    Exit Sub
    
err:
    FuncLogIt sFuncName, "could not get window size [wbTmp=" & wbTmp.name & "] [iWindowID=" & CStr(iWindowID) & "]", C_MODULE_NAME, LogMsgType.Error

End Sub
Public Sub SetWindowScheme(ByRef dWindows As Dictionary, _
                                vWindow As Variant, _
                       Optional eWindowScheme As WindowScheme = WindowScheme.quadrant)
Dim lTop As Long, lLeft As Long, lUsableHeight As Long, lUsableWidth As Long, lHeight As Long, lWidth As Long, lNewHeight As Long, lNewWidth As Long
Dim iWindowCount As Integer, iRow As Integer, iCol As Integer
Dim vColumn() As String
Dim wbTmp As Workbook
Dim sBookName As String
Dim winsetTmp As Quad_WindowSettings
    GetScreenDimensions lUsableWidth, lUsableHeight
    
    For iRow = 0 To UBound(vWindow)
        lWidth = lUsableWidth / (UBound(vWindow) + 1) ' +1 to force too small windows
        lWidth = lWidth * 0.7
        vColumn = vWindow(iRow)
        For iCol = 0 To UBound(vColumn)
            lHeight = lUsableHeight / (UBound(vColumn) + 1)
            
            lHeight = lHeight * 0.7
            lLeft = (iRow * lWidth) + 1
            lTop = lHeight * iCol
            
            sBookName = CStr(vColumn(iCol))
            Set wbTmp = Workbooks(sBookName)

            SetWindowLocation lTop, lLeft, wbTmp:=wbTmp
            SetWindowSize lWidth, lHeight, wbTmp:=wbTmp
            
            Set winsetTmp = dWindows.Item(sBookName)
            winsetTmp.Left = lLeft
            winsetTmp.Top = lTop
            winsetTmp.Width = lWidth
            winsetTmp.Height = lHeight
            
            SimplifyWindow winsetTmp, wbTmp:=wbTmp
            Set dWindows.Item(sBookName) = winsetTmp
            
            iWindowCount = iWindowCount + 1
        Next iCol
    Next iRow
    
End Sub
