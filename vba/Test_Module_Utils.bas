Attribute VB_Name = "Test_Module_Utils"
Option Explicit
'Sub    TestExportModules()
Const CsModuleName = "Test_Module_Utils"
Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    TestExportModules
    TestImportModules
    TestGetProcsInModules
    
    'GetLogFile "test.log"
End Sub
Sub TestImportModules()
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
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "ImportModules"
    sModuleName = "tmp1"
    sRootDirectory = "C:\Users\burtnolej"
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
        GoTo fail
    End If
    
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteModule(wbTmp, sModuleName)
    Call CloseBook(wbTmp)
    Call RemoveDir(sExportModuleDirPath)
    Call DeleteBook(sRootDirectory & "\" & sBookName)
    
    
End Sub

Sub TestExportModules()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sResult As String
Dim sDirectory As String
Dim sResultFileName As String
Dim sSuffix As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "ExportModules"
    sDirectory = "C:\Users\burtnolej\"
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
        GoTo fail
    End If

Success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteModule(Application.ActiveWorkbook, sModuleName)
    Call DeleteFile(sResultFileName)
End Sub
Sub TestGetProcsInModules()
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sCode As String, sCode2 As String
Dim sModuleName As String
Dim bTestPassed As Boolean
Dim dProc As Dictionary, dDetail As Dictionary
Dim sProc As Variant
Dim wb As Workbook
Dim wbName As String

setup:
    sFuncName = CsModuleName & "." & "GetProcsInModules"
    wbName = "foobar"
    
    sCode = "public function test(sFoo as string, optional sBar as string) as String" & vbNewLine & _
            "'foo1 test function" & vbNewLine & _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function" & vbNewLine & _
            "" & vbNewLine & _
            "public sub test2(aTmp() as integer)" & vbNewLine & _
            "'foo1 test2 sub" & vbNewLine & _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function"
    sCode2 = "public function test3(sFoo as string, optional sBar as string) as String" & vbNewLine & _
            "'foo2 test3 function" & vbNewLine & _
            "'comment line 2" & vbNewLine & _
            "    test=" & """barfoo""" & vbNewLine & _
            "end function" & vbNewLine

    Set wb = CreateBook(wbName)
    CreateModule wb, "foo1", sCode
    CreateModule wb, "foo2", sCode2
    
main:

    Set dProc = GetProcsInModules(wb)
    
    Set dProc = GetProcAnalysis(wb, dProc)
    
    If dProc.Exists("test") = False Then
        GoTo fail
    End If
    If dProc.Exists("test2") = False Then
        GoTo fail
    End If
    If dProc.Exists("test3") = False Then
        GoTo fail
    End If

    If dProc.Item("test3").Item("Args") <> "Public Function test3(sFoo As String, Optional sBar As String) As String" Then
        GoTo fail
    End If
    
    If Split(dProc.Item("test3").Item("Comments"), vbNewLine)(1) <> "'comment line 2" Then
        GoTo fail
    End If
    
Success:
    
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call CloseBook(wb)
    Call DeleteBook(wbName & ".xlsx")
    Call TestLogIt(sFuncName, bTestPassed)
End Sub
