Attribute VB_Name = "Test_Quad_Runtime"
Option Explicit

Const CsModuleName = "Test_Quad_Runtime"

Function Test_Init_Quad_Runtime_Default() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    clsQuadRuntime.InitProperties
    If clsQuadRuntime.BookPath <> "C:\\Users\\burtnolej\\Documents\\runtime\\" Then
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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
    Exit Function
End Function
Function Test_Init_Quad_Runtime_Override_BookPath() As TestResult
Dim sFuncName As String, sTmpBookName As String, sTmpBookPath As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime
Dim wbTmp As Workbook
setup:
    sTmpBookPath = "C:\Users\burtnolej"
    sTmpBookName = "tmp.xls"
    Set wbTmp = CreateBook(sTmpBookName, sBookPath:=sTmpBookPath)
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
main:
    clsQuadRuntime.InitProperties sBookPath:=sTmpBookPath, sBookName:=wbTmp.Name
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
    DeleteBook sTmpBookName, sTmpBookPath
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
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
    clsQuadRuntime.InitProperties sBookPath:="C:\\Users\\burtnolej", bInitializeCache:=False
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
    'CloseBook clsQuadRuntime.CacheBook
    'DeleteBook clsQuadRuntime.CacheBookName
    Exit Function
End Function

Function Test_Init_Quad_Runtime_Override_BookName() As TestResult
Dim sFuncName As String, sBookName As String, sBookPath As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
    sBookPath = "C:\\Users\\burtnolej"
    sBookName = "tmp2.xls"
    'ChDir sBookPath
    CreateBook sBookName, sBookPath:=sBookPath
    CloseBook Workbooks(sBookName)
    
main:
    clsQuadRuntime.InitProperties sBookPath:=sBookPath, sBookName:=sBookName
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
    CloseBook Workbooks(sBookName)
    DeleteBook sBookName, sPath:=sBookPath
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
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
    clsQuadRuntime.InitProperties sCacheRangeName:="foo"
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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    Exit Function
End Function

Function Test_Init_Quad_Runtime_Override_Template() As TestResult
Dim sFuncName As String, sTemplateName As String, sTemplatePath As String, sTemplateSheetName As String, sTemplateCellSheetName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As Quad_Runtime
Dim wbTmp As Workbook

setup:
    sFuncName = CsModuleName & "." & "Init_Quad_Runtime"
    Set clsQuadRuntime = New Quad_Runtime
    sTemplatePath = "c:\\users\\burtnolej\\"
    
    sTemplateName = "tmp2.xlsx"
    sTemplateSheetName = "foo"
    sTemplateCellSheetName = "foocell"
    Set wbTmp = CreateBook(sTemplateName, sBookPath:=sTemplatePath)
    CreateSheet wbTmp, sTemplateSheetName
    CreateSheet wbTmp, sTemplateCellSheetName
    CloseBook wbTmp, bSaveFlag:=True
    
main:
    clsQuadRuntime.InitProperties sTemplateBookPath:=sTemplatePath, _
                                  sTemplateBookName:=sTemplateName, _
                                  sTemplateSheetName:=sTemplateSheetName, _
                                  sTemplateCellSheetName:=sTemplateCellSheetName
                                  
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
    CloseBook clsQuadRuntime.TemplateBook
    DeleteBook sTemplateName, sPath:=sTemplatePath
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
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
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    
    Exit Function
End Function


