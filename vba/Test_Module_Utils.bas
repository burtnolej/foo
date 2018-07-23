Attribute VB_Name = "Test_Module_Utils"
Option Explicit
'Sub    TestExportModules()
Const C_MODULE_NAME = "Test_Module_Utils"


Function TestAddCodeToProc() As TestResult
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sExportModuleDir As String, sCode As String, sModuleCode As String, sModuleName As String, sFuncName As String, sParagraph As String
Dim eTestResult As TestResult
Dim vCodeToAdd() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetCode"
    sModuleName = "tmp1"
    sRootDirectory = Environ("MYHOME")
    sBookName = "tmp.xls"
    Set wbTmp = CreateBook(sRootDirectory & "\" & sBookName)
    vCodeToAdd = InitStringArray(Array("public function test() as String", "    test=" & """barfoo""", "end function"))
            
    sCode = "Option Explicit" & vbNewLine
    sCode = sCode & "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine
    sCode = sCode & "Dim wbTarget As Workbook, wbSource As Workbook" & vbNewLine
    sCode = sCode & "Dim sSourceSheetName As String" & vbNewLine
    sCode = sCode & "Set wbSource = Workbooks(""vba_source_new.xlsm"")" & vbNewLine
    sCode = sCode & "Set wbTarget = Workbooks(""menu.xlsm"")" & vbNewLine
    sCode = sCode & "sSourceSheetName = ""WidgetStyles""" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ValidateWidget"", Application.ActiveWorkbook, Application.ActiveSheet.Name, Target" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!IsRecordValid"", wbSource, wbTarget, ""MenuMain"", sSourceSheetName" & vbNewLine
    sCode = sCode & "End Sub" & vbNewLine

    Set VBComp = CreateModule(wbTmp, sModuleName, sCode)
    Call CloseBook(wbTmp, bSaveFlag:=True)
    
main:
    Set wbTmp = OpenBook(sBookName, sRootDirectory)
    InsertProcCode wbTmp, sModuleName, "Worksheet_Change", vCodeToAdd

    sModuleCode = GetProcCode(wbTmp, sModuleName, "Worksheet_Change")
    If InParagraph("Public Function test() As String", sModuleCode) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    If InParagraph("    test = " & """barfoo""", sModuleCode) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAddCodeToProc = eTestResult
    Call DeleteModule(wbTmp, sModuleName)
    Call CloseBook(wbTmp)
    Call DeleteBook(sRootDirectory & "\" & sBookName)
    
End Function


Function TestGetCode() As TestResult
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sExportModuleDir As String, sCode As String, sModuleCode As String, sModuleName As String, sFuncName As String, sParagraph As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "GetCode"
    sModuleName = "tmp1"
    sRootDirectory = Environ("MYHOME")
    sBookName = "tmp.xls"
    Set wbTmp = CreateBook(sRootDirectory & "\" & sBookName)
    sCode = "public function test() as String" & vbNewLine & _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function"

    sCode = "Option Explicit" & vbNewLine
    sCode = sCode & "Private Sub Worksheet_Change(ByVal Target As Range)" & vbNewLine
    sCode = sCode & "Dim wbTarget As Workbook, wbSource As Workbook" & vbNewLine
    sCode = sCode & "Dim sSourceSheetName As String" & vbNewLine
    sCode = sCode & "Set wbSource = Workbooks(""vba_source_new.xlsm"")" & vbNewLine
    sCode = sCode & "Set wbTarget = Workbooks(""menu.xlsm"")" & vbNewLine
    sCode = sCode & "sSourceSheetName = ""WidgetStyles""" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ValidateWidget"", Application.ActiveWorkbook, Application.ActiveSheet.Name, Target" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!IsRecordValid"", wbSource, wbTarget, ""MenuMain"", sSourceSheetName" & vbNewLine
    sCode = sCode & "End Sub" & vbNewLine
    sCode = sCode & "Public Sub Worksheet_SelectionChange(ByVal Target As Range)" & vbNewLine
    sCode = sCode & "If Target.Column = 2 And Target.Row = 2 Then" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ToggleScheduleWindow"" & vbNewLine"
    sCode = sCode & "End If" & vbNewLine
    
    sCode = sCode & "If Target.Column = 4 And Target.Row = 2 Then" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ToggleEntryWindow"" & vbNewLine"
    sCode = sCode & "End If" & vbNewLine
    
    sCode = sCode & "If Target.Column = 6 And Target.Row = 2 Then" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ToggleCacheWindow"" & vbNewLine"
    sCode = sCode & "End If" & vbNewLine
    
    sCode = sCode & "If Target.Column = 2 And Target.Row = 5 Then" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ShowNewStudent"" & vbNewLine"
    sCode = sCode & "End If" & vbNewLine
    
    sCode = sCode & "If Target.Column = 4 And Target.Row = 5 Then" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ShowNewTeacher"" & vbNewLine"
    sCode = sCode & "End If" & vbNewLine
    
    sCode = sCode & "End Sub" & vbNewLine

    Set VBComp = CreateModule(wbTmp, sModuleName, sCode)
    
main:
    sParagraph = "If Target.Column = 2 And Target.Row = 5 Then" & vbNewLine
    sCode = sCode & "Application.Run ""vba_source_new.xlsm!ShowNewStudent"" & vbNewLine"
    sCode = sCode & "End If" & vbNewLine

    sModuleCode = GetProcCode(wbTmp, sModuleName, "Worksheet_SelectionChange")
    
    If InParagraph(sParagraph, sModuleCode) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    If InParagraph("foobar", sModuleCode) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetCode = eTestResult
    Call DeleteModule(wbTmp, sModuleName)
    Call CloseBook(wbTmp)
    Call DeleteBook(sRootDirectory & "\" & sBookName)
    
End Function

Function TestImportModules() As TestResult
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String
Dim sFileDir As String
Dim sRootDirectory As String
Dim sExportModuleDir As String
Dim sCode As String
Dim sSuffix As String
Dim sExportModuleDirPath As String
Dim sModuleName As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "ImportModules"
    sModuleName = "tmp1"
    sRootDirectory = Environ("MYHOME")
    sBookName = "tmp.xls"
    sSuffix = "_" & GetDateString(Now(), "mmddyy")
    Set wbTmp = CreateBook(sRootDirectory & "\" & sBookName)
    sExportModuleDir = "tmp_exported_modules"
    sCode = "public function test() as String" & vbNewLine & _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function"
    
    sExportModuleDirPath = sRootDirectory & "\" & sExportModuleDir
    Call CreateDir(sExportModuleDirPath & "\")
    Set VBComp = CreateModule(wbTmp, sModuleName, sCode)
    
    Call ExportModules(wbTmp, sExportModuleDirPath & "\", sSuffix, sModuleName)
    Call DeleteModule(wbTmp, sModuleName)
    
main:
    Call ImportModules(wbTmp, sExportModuleDirPath)
    
    If ModuleExists(wbTmp, sModuleName) <> True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestImportModules = eTestResult
    Call DeleteModule(wbTmp, sModuleName)
    Call CloseBook(wbTmp)
    Call RemoveDir(sExportModuleDirPath)
    Call DeleteBook(sRootDirectory & "\" & sBookName)
    
    
End Function

Function TestExportModules() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sResult As String
Dim sDirectory As String
Dim sResultFileName As String
Dim sSuffix As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "ExportModules"
    sDirectory = Environ("MYHOME") & "\"
    sText = "public function test() as String" & vbNewLine & _
            "   test=" & """barfoo""" & vbNewLine & _
            "end function"
            
    sModuleName = "foobar"
    sSuffix = "_" & GetDateString(Now())
    
    sResultFileName = sDirectory & sModuleName & sSuffix & ".bas"

    CreateModule ActiveWorkbook, sModuleName, sText


main:
    Call ExportModules(Application.ActiveWorkbook, sDirectory, sSuffix, sModuleName)
    
    If FileExists(sResultFileName) <> True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestExportModules = eTestResult
    Call DeleteModule(Application.ActiveWorkbook, sModuleName)
    Call DeleteFile(sResultFileName)
End Function

Function TestGetProcsInModules() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sCode As String, sCode2 As String
Dim sModuleName As String
Dim eTestResult As TestResult
Dim dProc As Dictionary, dDetail As Dictionary
Dim sProc As Variant
Dim wb As Workbook
Dim wbName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetProcsInModules"
    wbName = "foobar"
    
    sCode = "public function test(sFoo as string, optional sBar as string) as String" & vbNewLine & _
 _
            "'<<<" & vbNewLine & _
            "'param:sFoo, string" & vbNewLine & _
            "'param:sBar, string" & vbNewLine & _
            "'>>>" & vbNewLine & _
 _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function" & vbNewLine & _
            "" & vbNewLine & _
 _
            "public sub test2(aTmp() as integer)" & vbNewLine & _
 _
            "'<<<" & vbNewLine & _
            "'param:aTmp, integer array" & vbNewLine & _
            "'>>>" & vbNewLine & _
 _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function"
    sCode2 = "public function test3(sFoo as string, optional sBar as string) as String" & vbNewLine & _
            "'<<<" & vbNewLine & _
 _
            "'foo2 test3 function" & vbNewLine & _
            "'comment line 2" & vbNewLine & _
            "'>>>" & vbNewLine & _
 _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function" & vbNewLine

    Set wb = CreateBook(wbName)
    CreateModule wb, "foo1", sCode
    CreateModule wb, "foo2", sCode2
    
main:

    Set dProc = GetProcsInModules(wb)
    
    Set dProc = GetProcAnalysis(wb, dProc)
    
    If dProc.Exists("test") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If dProc.Exists("test2") = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    If dProc.Exists("test3") = False Then
       eTestResult = TestResult.Failure
       GoTo teardown
    End If

    If dProc.Item("test3").Item("Args") <> "Public Function test3(sFoo As String, Optional sBar As String) As String" Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If Split(dProc.Item("test3").Item("Comments"), vbNewLine)(1) <> "'comment line 2" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetProcsInModules = eTestResult
    Call CloseBook(wb)
    Call DeleteBook(wbName & ".xlsx")
End Function
