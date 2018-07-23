VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Quad_WindowSettings"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private prgbFg As rgbColor
Private prgbBg As rgbColor
Private pFont As String
Private pFontStyle As String
Private pFontSize As Integer
Private pTopLabel As Range
Private pBottomLabel As Range
Private pButton1 As Range
Private pButton2 As Range
Private pHeight As Long
Private pWidth As Long
Private pLeft As Long
Private pTop As Long
Private pWindowTitle As String
Private pWindowID As Integer
Private pZoom As Integer

Public Property Get rgbFg() As rgbColor
    Set rgbFg = prgbFg
End Property
Public Property Let rgbFg(value As rgbColor)
    Set prgbFg = value
End Property
Public Property Get rgbBg() As rgbColor
    Set rgbBg = prgbBg
End Property
Public Property Let rgbBg(value As rgbColor)
    Set prgbBg = value
End Property
Public Property Get Font() As String
    Font = pFont
End Property
Public Property Let Font(value As String)
    pFont = value
End Property
Public Property Get FontStyle() As String
    FontStyle = pFontStyle
End Property
Public Property Let FontStyle(value As String)
    pFontStyle = value
End Property
Public Property Get FontSize() As String
    FontSize = pFontSize
End Property
Public Property Let FontSize(value As String)
    pFontSize = value
End Property
Public Property Get TopLabel() As Range
    Set TopLabel = pTopLabel
End Property
Public Property Let TopLabel(value As Range)
    Set pTopLabel = value
End Property
Public Property Get BottomLabel() As Range
    Set BottomLabel = pBottomLabel
End Property
Public Property Let BottomLabel(value As Range)
    Set pBottomLabel = value
End Property
Public Property Get Button1() As Range
    Set Button1 = pButton1
End Property
Public Property Let Button1(value As Range)
    Set pButton1 = value
End Property
Public Property Get Button2() As Range
    Set Button2 = pButton2
End Property
Public Property Let Button2(value As Range)
    Set pButton2 = value
End Property
Public Property Get Height() As Long
    Height = pHeight
End Property
Public Property Let Height(value As Long)
    pHeight = value
End Property
Public Property Get Width() As Long
    Width = pWidth
End Property
Public Property Let Width(value As Long)
    pWidth = value
End Property
Public Property Get Left() As Long
    Left = pLeft
End Property
Public Property Let Left(value As Long)
    pLeft = value
End Property
Public Property Get Top() As Long
    Top = pTop
End Property
Public Property Let Top(value As Long)
    pTop = value
End Property
Public Property Get WindowTitle() As String
    WindowTitle = pWindowTitle
End Property
Public Property Let WindowTitle(value As String)
    pWindowTitle = value
End Property
Public Property Get WindowID() As Integer
    WindowID = pWindowID
End Property
Public Property Let WindowID(value As Integer)
    pWindowID = value
End Property
Public Property Get Zoom() As Integer
    Zoom = pZoom
End Property
Public Property Let Zoom(value As Integer)
    pZoom = value
End Property
Public Sub InitProperties( _
                Optional rgbBg As rgbColor, _
                Optional rgbFg As rgbColor, _
                Optional sFont As String = "Arial", _
                Optional sFontStyle As String = "Normal", _
                Optional iFontSize As Integer = 14, _
                Optional sWindowTitle As String = "Title1", _
                Optional sWindowID As Integer = 1, _
                Optional iZoom As Integer = 70)
Dim rgbBlack As New rgbColor
Dim rgbWhite As New rgbColor

    If IsSet(rgbBg) = False Then
        rgbBlack.InitProperties 0, 0, 0
        Me.rgbBg = rgbBlack
    End If
    
    If IsSet(rgbFg) = False Then
        rgbWhite.InitProperties 255, 255, 255
        Me.rgbFg = rgbWhite
    End If

    Me.Font = sFont
    Me.FontStyle = sFontStyle
    Me.FontSize = iFontSize
    Me.WindowTitle = sWindowTitle
    Me.WindowID = sWindowID
    Me.Zoom = iZoom
End Sub
