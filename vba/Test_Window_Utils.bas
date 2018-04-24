Attribute VB_Name = "Test_Window_Utils"
Option Explicit
'Sub Test_GetScreenDimensions()
'Function Test_GetDpi() As TestResult
'Function Test_SetWindowLocation() As TestResult
'Function Test_SetWindowLocation_MultipleWindows() As TestResult
'Test_SetWindowSLocation_Quadrants
'Test_SetWindowSize

Const C_MODULE_NAME = "Test_Window_Utils"

Function Test_GetScreenDimensions() As TestResult
Dim lWidth As Long, lHeight As Long
Dim eTestResult As TestResult
Dim sBookName As String
Dim wbTmp As Workbook

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)

main:
    lWidth = -1
    lHeight = -1
    GetScreenDimensions lWidth, lHeight
    
    If lWidth = -1 Or lHeight = -1 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetScreenDimensions = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
End Function

Function Test_GetDpi() As TestResult
Dim eTestResult As TestResult
main:

    If GetDpi = 1 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_GetDpi = eTestResult
End Function
Function Test_SetWindowLocation() As TestResult
Dim wbTmp As Workbook
Dim sBookName As String, sFuncName As String
Dim lTop As Long, lLeft As Long
Dim eTestResult As TestResult

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
 
main:
    SetWindowLocation 200, 400, wbTmp:=wbTmp
    GetWindowLocation lTop, lLeft, wbTmp:=wbTmp
    
    If lTop <> 200 Or lLeft <> 400 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SetWindowLocation = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
    
End Function
Function Test_SetWindowLocation_MultipleWindows() As TestResult
Dim wbTmp As Workbook, wbTmp2 As Workbook, wbTmp3 As Workbook
Dim sBookName As String, sFuncName As String, sBookName2 As String, sBookName3 As String
Dim lTop As Long, lLeft As Long
Dim eTestResult As TestResult

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
    sBookName2 = "tmp2.xls"
    Set wbTmp2 = CreateBook(sBookName2, GetHomePath)
    sBookName3 = "tmp3.xls"
    Set wbTmp3 = CreateBook(sBookName3, GetHomePath)
 
main:
    SetWindowLocation 0, 0, wbTmp:=wbTmp
    SetWindowLocation 100, 100, wbTmp:=wbTmp2
    SetWindowLocation 200, 200, wbTmp:=wbTmp3
    
    GetWindowLocation lTop, lLeft, wbTmp:=wbTmp
    
    If lTop <> 0 Or lLeft <> 0 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    GetWindowLocation lTop, lLeft, wbTmp:=wbTmp2
    
    If lTop <> 100 Or lLeft <> 100 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    GetWindowLocation lTop, lLeft, wbTmp:=wbTmp3
    
    If lTop <> 200 Or lLeft <> 200 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SetWindowLocation_MultipleWindows = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
    CloseBook Workbooks(sBookName2)
    DeleteBook CStr(sBookName2), GetHomePath
    CloseBook Workbooks(sBookName3)
    DeleteBook CStr(sBookName3), GetHomePath
End Function
Function Test_SetWindowSLocation_Quadrants() As TestResult
Dim wbTmp As Workbook, wbTmp2 As Workbook, wbTmp3 As Workbook, wbTmp4 As Workbook
Dim sBookName As String, sFuncName As String, sBookName2 As String, sBookName3 As String, sBookName4 As String, sSheetName As String
Dim lTop As Long, lLeft As Long, lUsableHeight As Long, lUsableWidth As Long, lHeight As Long, lWidth As Long, lNewHeight As Long, lNewWidth As Long
Dim eTestResult As TestResult

setup:
    sSheetName = "Sheet1"
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
    sBookName2 = "tmp2.xls"
    Set wbTmp2 = CreateBook(sBookName2, GetHomePath)
    sBookName3 = "tmp3.xls"
    Set wbTmp3 = CreateBook(sBookName3, GetHomePath)
    sBookName4 = "tmp4.xls"
    Set wbTmp4 = CreateBook(sBookName4, GetHomePath)
 
main:
    GetScreenDimensions lUsableWidth, lUsableHeight
    lHeight = lUsableHeight / 3
    lWidth = lUsableWidth / 3
    
    SetWindowSize lWidth, lHeight, wbTmp:=wbTmp
    SetWindowSize lWidth, lHeight, wbTmp:=wbTmp2
    SetWindowSize lWidth, lHeight, wbTmp:=wbTmp3
    SetWindowSize lWidth, lHeight, wbTmp:=wbTmp4
    
    SetWindowLocation 0, 0, wbTmp:=wbTmp
    SetWindowLocation 0, lWidth, wbTmp:=wbTmp2
    SetWindowLocation lHeight, 0, wbTmp:=wbTmp3
    SetWindowLocation lHeight, lWidth, wbTmp:=wbTmp4
    
    GetWindowLocation lNewHeight, lNewWidth, wbTmp:=wbTmp4
    
    If lNewHeight <> lHeight Or lNewWidth <> lWidth Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SetWindowSLocation_Quadrants = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
    CloseBook Workbooks(sBookName2)
    DeleteBook CStr(sBookName2), GetHomePath
    CloseBook Workbooks(sBookName3)
    DeleteBook CStr(sBookName3), GetHomePath
    CloseBook Workbooks(sBookName4)
    DeleteBook CStr(sBookName4), GetHomePath
End Function
Function Test_SetWindowSize() As TestResult
Dim wbTmp As Workbook
Dim sBookName As String, sFuncName As String
Dim lHeight As Long, lWidth As Long
Dim eTestResult As TestResult

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
 
main:
    SetWindowSize 250, 350, wbTmp:=wbTmp
    GetWindowSize lHeight, lWidth, wbTmp:=wbTmp
    
    If lHeight <> 250 Or lWidth <> 350 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SetWindowSize = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
    
End Function

Function Test_MakeLabel() As TestResult
Dim wbTmp As Workbook
Dim rTmp As Range
Dim sBookName As String, sFuncName As String, sLabelAddress As String, sSheetName As String
Dim eTestResult As TestResult
Dim rgbTmp As RGBColor
Dim winsetTmp As New Quad_WindowSettings

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
    sLabelAddress = "$A$1:$B$2"
    sSheetName = "Sheet1"
    Set rTmp = wbTmp.Sheets(sSheetName).Range(sLabelAddress)
    winsetTmp.InitProperties
    winsetTmp.WindowTitle = "FOOBAR"
    
main:
    MakeLabel winsetTmp, rTmp, sSheetName
    
    If wbTmp.Sheets(sSheetName).Range("A1:A1").MergeArea.Address <> sLabelAddress Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    Set rgbTmp = GetBgColor(sSheetName, rTmp)
    
    If rgbTmp.Blue <> 0 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If wbTmp.Sheets(sSheetName).Range("A1:A1").value <> "FOOBAR" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If rTmp.VerticalAlignment <> xlCenter Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MakeLabel = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
End Function

Function Test_SimplifyWindow_1Sheet() As TestResult
Dim wbTmp As Workbook
Dim sBookName As String, sFuncName As String
Dim eTestResult As TestResult
Dim winsetTmp As New Quad_WindowSettings

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
    winsetTmp.InitProperties
    
    SimplifyWindow winsetTmp, wbTmp:=wbTmp
    
    If wbTmp.Windows(1).DisplayWorkbookTabs <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If wbTmp.Windows(1).DisplayGridlines <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Application.DisplayFormulaBar <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If winsetTmp.BottomLabel.Address <> "$A$47:$O$48" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If winsetTmp.TopLabel.Address <> "$A$1:$Q$2" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If winsetTmp.Button1.Address <> "$P$47:$P$48" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If winsetTmp.Button2.Address <> "$Q$47:$Q$48" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If

    eTestResult = TestResult.OK

    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SimplifyWindow_1Sheet = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
End Function

Function Test_SimplifyWindow_MultiSheet() As TestResult
Dim wbTmp As Workbook
Dim sBookName As String, sFuncName As String
Dim eTestResult As TestResult
Dim wsTmp As Worksheet
Dim winsetTmp As New Quad_WindowSettings

setup:
    sBookName = "tmp1.xls"
    winsetTmp.InitProperties
    
    Set wbTmp = CreateBook(sBookName, GetHomePath)
    
    SimplifyWindow winsetTmp, wbTmp:=wbTmp
    Set wsTmp = CreateWindowSheet("Sheet2", wbTmp:=wbTmp)
    
    If wsTmp.ScrollArea = "" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SimplifyWindow_MultiSheet = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
End Function

Function Test_SetupWindowPanel() As TestResult
Dim wbTmp As Workbook
Dim lScreenWidth As Long, lScreenHeight As Long, iWindowWidth As Long, iWindowHeight As Long, iWindowLeft As Long, iWindowTop As Long
Dim iRow As Integer, iCol As Integer, iWindowCount As Integer
Dim vWindowNames As Variant, vWindowSheets As Variant
Dim sBookName As Variant
Dim dWindows As New Dictionary
Dim vWindowCol1() As String, vWindowCol2() As String
Dim winsetTmp As Quad_WindowSettings
Dim vWindow() As Variant ' row 1
Dim eTestResult As TestResult

    ' top_left,top_right,bottom_left,bottom_right
    vWindowNames = Array("tmp1.xls", "tmp2.xls", "tmp3.xls", "tmp4.xls")
    ReDim vWindowCol1(0 To 1)
    ReDim vWindowCol2(0 To 1)
    ReDim vWindow(0 To 1)
    
    For Each sBookName In vWindowNames
       CreateBook CStr(sBookName), GetHomePath
       Set winsetTmp = New Quad_WindowSettings
       winsetTmp.InitProperties
       dWindows.Add sBookName, winsetTmp
    Next sBookName
    
    vWindowCol1(0) = "tmp1.xls"
    vWindowCol1(1) = "tmp2.xls"
    vWindowCol2(0) = "tmp3.xls"
    vWindowCol2(1) = "tmp4.xls"
    vWindow(0) = vWindowCol1 'row 1
    vWindow(1) = vWindowCol2 'row 1
    
    SetWindowScheme dWindows, vWindow
    
    For Each sBookName In dWindows.Keys
        Set winsetTmp = dWindows.Item(sBookName)
    Next sBookName
    
    Set winsetTmp = dWindows.Item("tmp4.xls")
    If winsetTmp.Left <> 673 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If winsetTmp.Top <> 420 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error

teardown:
    Test_SetupWindowPanel = eTestResult
    For Each sBookName In vWindowNames
        CloseBook Workbooks(sBookName)
        DeleteBook CStr(sBookName), GetHomePath
    Next sBookName
End Function
Function Test_SetupWindowPanel_3and1() As TestResult
Dim wbTmp As Workbook
Dim lScreenWidth As Long, lScreenHeight As Long, iWindowWidth As Long, iWindowHeight As Long, iWindowLeft As Long, iWindowTop As Long
Dim iRow As Integer, iCol As Integer, iWindowCount As Integer
Dim vWindowNames As Variant, vWindowSheets As Variant
Dim sBookName As Variant
Dim dWindows As New Dictionary
Dim vWindowCol1() As String, vWindowCol2() As String
Dim winsetTmp As Quad_WindowSettings
Dim vWindow() As Variant ' row 1
Dim eTestResult As TestResult

    ' top_left,top_right,bottom_left,bottom_right
    vWindowNames = Array("tmp1.xls", "tmp2.xls", "tmp3.xls", "tmp4.xls")
    ReDim vWindowCol1(0 To 2)
    ReDim vWindowCol2(0 To 0)
    ReDim vWindow(0 To 1)
    
    For Each sBookName In vWindowNames
       CreateBook CStr(sBookName), GetHomePath
       Set winsetTmp = New Quad_WindowSettings
       winsetTmp.InitProperties
       dWindows.Add sBookName, winsetTmp
    Next sBookName
    
    vWindowCol1(0) = "tmp1.xls"
    vWindowCol1(1) = "tmp2.xls"
    vWindowCol1(2) = "tmp3.xls"
    vWindowCol2(0) = "tmp4.xls"
    vWindow(0) = vWindowCol1 'row 1
    vWindow(1) = vWindowCol2 'row 1
    
    SetWindowScheme dWindows, vWindow
    
    For Each sBookName In dWindows.Keys
        Set winsetTmp = dWindows.Item(sBookName)
    Next sBookName
    
    Set winsetTmp = dWindows.Item("tmp4.xls")
    If winsetTmp.Left <> 673 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If winsetTmp.Top <> 0 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If winsetTmp.Height <> 840 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error

teardown:
    Test_SetupWindowPanel_3and1 = eTestResult
    For Each sBookName In vWindowNames
        CloseBook Workbooks(sBookName)
        DeleteBook CStr(sBookName), GetHomePath
    Next sBookName
End Function
Public Function Test_SimplifyWindow_Reset() As TestResult
Dim sBookName As String
Dim wbTmp As Workbook
Dim eTestResult As TestResult
Dim winsetTmp As New Quad_WindowSettings

setup:
    sBookName = "tmp1.xls"
    Set wbTmp = CreateBook(sBookName, GetHomePath)
    winsetTmp.InitProperties
    
    SimplifyWindow winsetTmp, wbTmp:=wbTmp
    
    SimplifyWindow winsetTmp, bReset:=True
    
    If wbTmp.Windows(1).DisplayWorkbookTabs <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If wbTmp.Windows(1).DisplayGridlines <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Application.DisplayFormulaBar <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_SimplifyWindow_Reset = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook CStr(sBookName), GetHomePath
    
End Function

Sub test()
Dim winsetTmp As New Quad_WindowSettings
    winsetTmp.InitProperties
    
    SimplifyWindow winsetTmp, wbTmp:=Workbooks("vba_source_new.xlsm"), _
    bReset:=True
End Sub
