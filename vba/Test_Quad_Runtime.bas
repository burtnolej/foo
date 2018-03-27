Attribute VB_Name = "Test_Quad_Runtime"
Option Explicit

Const CsModuleName = "Test_Quad_Runtime"

Sub terst()
    'check to see if overridden goes into log
    GetLogFile
    Test_Init_Quad_Runtime_Override_Database
End Sub
Function Test_Init_Quad_Runtime_Default() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    clsQuadRuntime.InitProperties
    If clsQuadRuntime.BookPath <> "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_Quad_Runtime_Default = eTestResult
    
    Exit Function
End Function
Function Test_Init_Quad_Runtime_Override_BookPath() As TestResult
Dim sFuncName As String, sTmpBookName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime
Dim wbTmp As Workbook
setup:
    sTmpBookName = "tmp.xls"
    Set wbTmp = CreateBook(sTmpBookName)
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    clsQuadRuntime.InitProperties sBookPath:=wbTmp.Path, sBookName:=wbTmp.Name
    If clsQuadRuntime.BookPath <> wbTmp.Path Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_Quad_Runtime_Override_BookPath = eTestResult
    CloseBook wbTmp
    DeleteBook sTmpBookName
    Exit Function
End Function
Function Test_Init_Quad_Runtime_Override_BookPath_Invalid() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    On Error GoTo err
    clsQuadRuntime.InitProperties sBookPath:="C:\\Users\\foobar"
    eTestResult = TestResult.Failure
    GoTo teardown
    On Error GoTo 0
    
err:
    If err.Number = 555 Then
        eTestResult = TestResult.OK
    Else
        eTestResult = TestResult.Failure
    End If
    
teardown:
    Test_Init_Quad_Runtime_Override_BookPath_Invalid = eTestResult
    
    Exit Function
End Function

Function Test_Init_Quad_Runtime_Override_BookName() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    clsQuadRuntime.InitProperties sBookPath:=ActiveWorkbook.Path, sBookName:=ActiveWorkbook.Name
    If clsQuadRuntime.BookName <> ActiveWorkbook.Name Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_Quad_Runtime_Override_BookName = eTestResult
    
    Exit Function
End Function

Function Test_Init_Quad_Runtime_Override_CacheBookRangeName() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    clsQuadRuntime.InitProperties sCacheBookPath:=ActiveWorkbook.Path, _
                                  sCacheBookName:=ActiveWorkbook.Name, _
                                  sCacheRangeName:="foo"
    If clsQuadRuntime.CacheRangeName <> "foo" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_Quad_Runtime_Override_CacheBookRangeName = eTestResult
    clsQuadRuntime.CacheBook.Close
    
    Exit Function
End Function

Function Test_Init_Quad_Runtime_Override_Template() As TestResult
Dim sFuncName As String, sTemplateName As String, sTemplatePath As String, sTemplateSheetName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime
Dim wbTmp As Workbook

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
    sTemplateName = "tmp.xls"
    sTemplateSheetName = "foo"
    Set wbTmp = CreateBook(sTemplateName)
    CreateSheet wbTmp, sTemplateSheetName
    
main:
    clsQuadRuntime.InitProperties sTemplateBookPath:=ActiveWorkbook.Path, _
                                  sTemplateBookName:=ActiveWorkbook.Name, _
                                  sTemplateSheetName:=sTemplateSheetName
                                  
    If clsQuadRuntime.TemplateSheetName <> sTemplateSheetName Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsInstance(clsQuadRuntime.TemplateSheet, vbObject) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    On Error GoTo 0

    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_Quad_Runtime_Override_Template = eTestResult
    CloseBook wbTmp
    DeleteBook sTemplateName
    clsQuadRuntime.CacheBook.Close
    Exit Function
End Function

Function Test_Init_Quad_Runtime_Override_Database() As TestResult
Dim sFuncName As String, sDatabasePath As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
    sDatabasePath = "C:\\Users\\burtnolej\\foo.db"
    CreateFile sDatabasePath & ".sqlite"
    
main:
    clsQuadRuntime.InitProperties sDatabasePath:=sDatabasePath
                                  
    If clsQuadRuntime.DatabasePath <> sDatabasePath Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    On Error GoTo 0

    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_Quad_Runtime_Override_Database = eTestResult
    DeleteFile sDatabasePath
    clsQuadRuntime.CacheBook.Close
    
    Exit Function
End Function


