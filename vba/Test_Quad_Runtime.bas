Attribute VB_Name = "Test_Quad_Runtime"
Option Explicit

Const C_MODULE_NAME = "Test_App_Runtime"

Function Test_Init_App_Runtime_MultiUpdate_Cached_Values() As TestResult
' updating the cache multiple times
Dim sFuncName As String, sTmpBookName As String, sTmpBookPath As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime
Dim wbTmp As Workbook
Dim vResultArray() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    sTmpBookPath = Environ("MYHOME") & ""
    sTmpBookName = "tmp.xls"
    Set wbTmp = CreateBook(sTmpBookName, sBookPath:=sTmpBookPath)
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sFilePath = Environ("MYHOME") & "\app_runtime_cache.txt"
main:
    clsAppRuntime.InitProperties sBookPath:=sTmpBookPath, sBookName:=sTmpBookName, sDayEnum:="foobar"
    clsAppRuntime.DayEnum = "barfoo"
    
    vResultArray = ReadFile2Array(sFilePath, bSingleCol:=True)
    
    If vResultArray(0) <> sTmpBookPath Then
        eTestResult = TestResult.Failure
    End If
    
    If vResultArray(14) <> "barfoo" Then
        eTestResult = TestResult.Failure
    End If
    
    If vResultArray(1) <> sTmpBookName Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If


teardown:
    Test_Init_App_Runtime_MultiUpdate_Cached_Values = eTestResult
    CloseBook wbTmp
    DeleteBook sTmpBookName, sTmpBookPath
    clsAppRuntime.Delete

End Function


Function Test_Init_App_Runtime_Retreive_Cached_Values() As TestResult
Dim sFuncName As String, sTmpBookName As String, sTmpBookPath As String, sCacheFilePath As String
Dim wbTmp As Workbook
Dim oFile As Object
Dim vArray() As String
Dim i As Integer
Dim clsAppRuntime As App_Runtime
Dim eTestResult As TestResult

setup:
    'On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "Test_Init_App_Runtime_Retreive_Cached_Values"
    sTmpBookPath = Environ("MYHOME") & ""
    sTmpBookName = "tmp.xls"
    Set wbTmp = CreateBook(sTmpBookName, sBookPath:=sTmpBookPath)
    
    sCacheFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    Set oFile = CreateFile(sCacheFilePath)
    oFile.Close

    ReDim vArray(0 To 49)
    For i = 0 To 49
        vArray(i) = SPACE
    Next i
    
    vArray(0) = sTmpBookPath
    vArray(1) = sTmpBookName
    
    WriteArray2File vArray, sCacheFilePath
    Set clsAppRuntime = New App_Runtime
    
main:
    clsAppRuntime.InitProperties sBookPath:=sTmpBookPath, sBookName:=sTmpBookName
    If clsAppRuntime.BookPath <> wbTmp.Path Then
        eTestResult = TestResult.Failure
    End If
    
    If clsAppRuntime.BookName <> wbTmp.name Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
    
teardown:
    Test_Init_App_Runtime_Retreive_Cached_Values = eTestResult
    CloseBook wbTmp
    DeleteBook sTmpBookName, sTmpBookPath
    clsAppRuntime.Delete
    
End Function
Function Test_Init_App_Runtime_Persist_Cache() As TestResult
Dim sFuncName As String, sTmpBookName As String, sTmpBookPath As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime
Dim wbTmp As Workbook
Dim vResultArray() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    sTmpBookPath = Environ("MYHOME")
    sTmpBookName = "tmp.xls"
    Set wbTmp = CreateBook(sTmpBookName, sBookPath:=sTmpBookPath)
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
main:
    clsAppRuntime.InitProperties sBookPath:=sTmpBookPath, sBookName:=sTmpBookName

    vResultArray = ReadFile2Array(sFilePath, bSingleCol:=True)
    
    If vResultArray(0) <> sTmpBookPath Then
        eTestResult = TestResult.Failure
    End If
    
    If vResultArray(1) <> sTmpBookName Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If


teardown:
    Test_Init_App_Runtime_Persist_Cache = eTestResult
    CloseBook wbTmp
    DeleteBook sTmpBookName, sTmpBookPath
    clsAppRuntime.Delete
    
End Function

Function Test_Init_App_Runtime_Default() As TestResult
Dim sFuncName As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    clsAppRuntime.InitProperties
    If clsAppRuntime.BookPath <> Environ("MYHOME") & "\runtime\" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_App_Runtime_Default = eTestResult
    clsAppRuntime.Delete
End Function

Function Test_Init_App_Runtime_Override_BookPath() As TestResult
Dim sFuncName As String, sTmpBookName As String, sTmpBookPath As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime
Dim wbTmp As Workbook
setup:
    sTmpBookPath = Environ("MYHOME")
    sTmpBookName = "tmp.xls"
    Set wbTmp = CreateBook(sTmpBookName, sBookPath:=sTmpBookPath)
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    clsAppRuntime.InitProperties sBookPath:=sTmpBookPath, sBookName:=wbTmp.name
    If clsAppRuntime.BookPath <> wbTmp.Path Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_App_Runtime_Override_BookPath = eTestResult
    CloseBook wbTmp
    DeleteBook sTmpBookName, sTmpBookPath
    clsAppRuntime.Delete
End Function
Function Test_Init_App_Runtime_Override_BookPath_Invalid() As TestResult
Dim sFuncName As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    On Error GoTo err
    clsAppRuntime.InitProperties sBookPath:=Environ("MYHOME"), bInitializeCache:=False
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
    Test_Init_App_Runtime_Override_BookPath_Invalid = eTestResult
    clsAppRuntime.Delete
End Function

Function Test_Init_App_Runtime_Override_BookName() As TestResult
Dim sFuncName As String, sBookName As String, sBookPath As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sBookPath = Environ("MYHOME")
    sBookName = "tmp2.xls"
    'ChDir sBookPath
    CreateBook sBookName, sBookPath:=sBookPath
    CloseBook Workbooks(sBookName)
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    clsAppRuntime.InitProperties sBookPath:=sBookPath, sBookName:=sBookName
    If clsAppRuntime.BookName <> sBookName Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_App_Runtime_Override_BookName = eTestResult
    CloseBook Workbooks(sBookName)
    DeleteBook sBookName, sPath:=sBookPath
    clsAppRuntime.Delete
End Function

Function Test_Init_App_Runtime_Override_CacheBookRangeName() As TestResult
Dim sFuncName As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    clsAppRuntime.InitProperties sCacheRangeName:="foo"
    If clsAppRuntime.CacheRangeName <> "foo" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_App_Runtime_Override_CacheBookRangeName = eTestResult
    clsAppRuntime.Delete
End Function

Function Test_Init_App_Runtime_Override_Template() As TestResult
Dim sFuncName As String, sTemplateName As String, sTemplatePath As String, sTemplateSheetName As String, sTemplateWidgetSheetName As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime
Dim wbTmp As Workbook

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sTemplatePath = Environ("MYHOME") & "\\"
    
    sTemplateName = "tmp2.xlsx"
    sTemplateSheetName = "foo"
    sTemplateWidgetSheetName = "foocell"
    Set wbTmp = CreateBook(sTemplateName, sBookPath:=sTemplatePath)
    CreateSheet wbTmp, sTemplateSheetName
    CreateSheet wbTmp, sTemplateWidgetSheetName
    CloseBook wbTmp, bSaveFlag:=True
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    clsAppRuntime.InitProperties sTemplateBookPath:=sTemplatePath, _
                                  sTemplateBookName:=sTemplateName, _
                                  sTemplateSheetName:=sTemplateSheetName, _
                                  sTemplateWidgetSheetName:=sTemplateWidgetSheetName
                                  
    Debug.Print clsAppRuntime.TemplateBook.name
    If clsAppRuntime.TemplateBook.name <> sTemplateName Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsInstance(clsAppRuntime.TemplateSheet, vbObject) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    On Error GoTo 0

    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_App_Runtime_Override_Template = eTestResult
    CloseBook clsAppRuntime.TemplateBook
    DeleteBook sTemplateName, sPath:=sTemplatePath
    clsAppRuntime.Delete
End Function

Function Test_Init_App_Runtime_Override_Database() As TestResult
Dim sFuncName As String, sDatabasePath As String, sFilePath As String
Dim eTestResult As TestResult
Dim clsAppRuntime As App_Runtime

setup:
    sFuncName = C_MODULE_NAME & "." & "Init_App_Runtime"
    Set clsAppRuntime = New App_Runtime
    sDatabasePath = Environ("MYHOME") & "\\foo.db"
    CreateFile sDatabasePath & ".sqlite"
    sFilePath = Environ("MYHOME") & "\\app_runtime_cache.txt"
    
main:
    clsAppRuntime.InitProperties sDatabasePath:=sDatabasePath
                                  
    If clsAppRuntime.DatabasePath <> sDatabasePath Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    On Error GoTo 0

    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_Init_App_Runtime_Override_Database = eTestResult
    DeleteFile sDatabasePath
    clsAppRuntime.Delete
End Function


