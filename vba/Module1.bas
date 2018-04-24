Attribute VB_Name = "Module1"
Option Explicit
Option Compare Text

Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function DrawMenuBar Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long

Private Const GWL_STYLE  As Long = (-16)      'The offset of a window's style
Private Const GWL_EXSTYLE As Long = (-20)      'The offset of a window's extended style
Private Const WS_CAPTION As Long = &HC00000      'Style to add a titlebar
Private Const WS_SYSMENU As Long = &H80000      'Style to add a system menu
Private Const WS_THICKFRAME As Long = &H40000      'Style to add a sizable frame
Private Const WS_MINIMIZEBOX As Long = &H20000      'Style to add a Minimize box on the title bar
Private Const WS_MAXIMIZEBOX As Long = &H10000      'Style to add a Maximize box to the title bar
Private Const WS_EX_APPWINDOW As Long = &H40000      'Application Window: shown on taskbar
Private Const WS_EX_TOOLWINDOW As Long = &H80      'Tool Window: small titlebar


'Procedure to set the form's window style
Public Sub ShowCaption(bShow As Boolean)

   Dim lStyle As Long
   Dim hMenu As Long
   
   Dim mhWndForm As Long
   
   mhWndForm = FindWindow(vbNullString, Application.Caption)
   
   'Have we got a window to set?
   If mhWndForm = 0 Then Exit Sub

   'Get the basic window style
   lStyle = GetWindowLong(mhWndForm, GWL_STYLE)

   'Build up the basic window style flags for the form
   SetBit lStyle, WS_CAPTION, bShow

   'Set the basic window styles
   SetWindowLong mhWndForm, GWL_STYLE, lStyle


   'Update the window with the changes
   DrawMenuBar mhWndForm
   SetFocus mhWndForm

End Sub

'Procedure to set or clear a bit from a style flag
Private Sub SetBit(ByRef lStyle As Long, ByVal lBit As Long, ByVal bOn As Boolean)
   If bOn Then
      lStyle = lStyle Or lBit
   Else
      lStyle = lStyle And Not lBit
   End If
End Sub
