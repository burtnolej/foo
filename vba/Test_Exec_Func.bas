Attribute VB_Name = "Test_Exec_Func"
Option Explicit

Const C_MODULE_NAME = "Test_Exec_Func"

' Books, modules, procs used by tests
'-----------------------------------------------------------------------------------
'Book:test_procs.xlsm : Module:tmp1
'Public Function DummyCreateSheet(dArgs As Dictionary) As Worksheet
'Public Function Quad__DummyCreateSheet(dArgs As Dictionary) As Worksheet
'Public Function DummyCreateSheet_DoesNotEndWith(dArgs As Dictionary) As Worksheet
'Public Function No_Base_Case(dArgs As Dictionary) As Worksheet
'Public Function Quad__WithoutBase(dArgs As Dictionary) As Worksheet
'Public Function DummyCreateBook(dArgs As Dictionary) As Workbook
'Module:tmp2
'Public Function Quad__DummyCreateBook(dArgs As Dictionary) As Workbook
'Public Function DummyCreateFile(dArgs As Dictionary) As Object

'Book:test_procs2.xlsm : Module:tmp1
'Public Function Quad__DummyCreateFile(dArgs As Dictionary) As Worksheet

' Test description
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Version
' Purpose  : Test that in a 1 book / 1 module scenario that a version can be called
'          : For test to be successful base case must exist
' Approach : ver_series=Quad & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Exec_Wrong_Version_Call_Base
' Purpose  : Test that in a 1 book / 1 module scenario that the base will be called
'          : implicitly if the version cannot be found
' Approach : ver_series=Foo & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Base
' Purpose  : Test that in a 1 book / 1 module scenario that we can explitly call the
'          : bases
' Approach : proc_name=DummyCreateSheet (ver_series arg not set)
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Fail_No_Base_Nothing_Similar
' Purpose  : Test that in a 1 book / 1 module scenario that an error return if no
'          : base exists when a version cannot be found
' Approach : ver_series=Quad  & proc_name=WithoutBase
' ExpResult: Fail
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Version_Multi_Module
' Purpose  : Test that in a 1 book / 2 module scenario that a version can be called
'          : explicitly
' Approach : ver_series=Quad  & proc_name=DummyCreateBook
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Exec_Wrong_Version_Call_Base_Multi_Module
' Purpose  : Test that in a 1 book / 2 module scenario that the base is called
'          : if the version does not exist
' Approach : ver_series=Foo  & proc_name=DummyCreateBook
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Version_Multi_Book
' Purpose  : Test that in a 2 book / 2 module scenario that a version can be called
'          : explicitly
' Approach : ver_series=Quad  & proc_name=DummyCreateFile
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Exec_Wrong_Version_Call_Base_Multi_Book
' Purpose  : Test that in a 2 book / 2 module scenario that the base is called
'          : if the version does not exist
' Approach : ver_series=Foo  & proc_name=DummyCreateFile
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Test_Exec_Proc_Version_RealWorld
' Purpose  : Test that in a 1 book / 1 module scenario that a version can be called
'          : For test to be successful base case must exist
'          : Use the prod code base vba_source_new.xlsm to provide an at scale test
' Approach : ver_series=Quad & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Test_Exec_Proc_Version_RealWorld_MultiBook
' Purpose  : Test that in a 2 book / 2 module scenario that a version can be called
'          : For test to be successful base case must exist
'          : Use the prod code base vba_source_new.xlsm to provide an at scale test
' Approach : ver_series=Quad & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
' Name     : Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError
' Purpose  : Test that in a 2 book / 2 module scenario that an error is properly handled from inside
'          : called function
'          : Use the prod code base vba_source_new.xlsm to provide an at scale test
' Approach : ver_series=Error & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------

Function SetUpTestProcs() As TestResult
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary

main:
    sModuleName = "tmp1"
    sRootDirectory = "C:\Users\burtnolej\Documents"
    sBookName = "test_procs.xlsm"
    Set wbTmp = CreateBook(sRootDirectory & "\" & sBookName)

    'sCode = "Option Explicit" & vbNewLine
    
    sCode = sCode & "Public Function DummyCreateSheet(dArgs as dictionary) as worksheet" & vbNewLine
    sCode = sCode & "Dim sSheetName as string" & vbNewLine
    sCode = sCode & "Dim wbTmp As workbook" & vbNewLine
    sCode = sCode & "" & vbNewLine
    sCode = sCode & "set wbTmp = dArgs.item(" & DOUBLEQUOTE & "wbTmp" & DOUBLEQUOTE & ")" & vbNewLine
    sCode = sCode & "sSheetName = dArgs.item(" & DOUBLEQUOTE & "sSheetName" & DOUBLEQUOTE & ")" & vbNewLine
    sCode = sCode & "Set DummyCreateSheet = wbTmp.Sheets.Add()" & vbNewLine
    sCode = sCode & "DummyCreateSheet.Name = sSheetName" & vbNewLine
    sCode = sCode & "End Function" & vbNewLine
    
    sCode = sCode & "Public Function Quad__2_DummyCreateSheet(dArgs as dictionary) as worksheet" & vbNewLine
    sCode = sCode & "Dim sSheetName as string" & vbNewLine
    sCode = sCode & "Dim wbTmp As workbook" & vbNewLine
    sCode = sCode & "" & vbNewLine
    sCode = sCode & "set wbTmp = dArgs.item(" & DOUBLEQUOTE & "wbTmp" & DOUBLEQUOTE & ")" & vbNewLine
    sCode = sCode & "sSheetName = dArgs.item(" & DOUBLEQUOTE & "sSheetName" & DOUBLEQUOTE & ")" & vbNewLine
    sCode = sCode & "Set DummyCreateSheet = wbTmp.Sheets.Add()" & vbNewLine
    sCode = sCode & "DummyCreateSheet.Name = sSheetName" & vbNewLine
    sCode = sCode & "End Function" & vbNewLine

    Set VBComp = CreateModule(wbTmp, sModuleName, sCode)

    CloseBook wbTmp, bSaveFlag:=True
    
End Function

Function Test_Exec_Proc_Version() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Version
' Purpose  : Test that in a 1 book / 1 module scenario that a version can be called
'          : For test to be successful base case must exist
' Approach : ver_series=Quad & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sSheetName", "foo"
    dArgs.Add "wbTmp", wbTmp
    dArgs.Add "ver_series", "Quad"

    clsExecProc.ExecProc "DummyCreateSheet", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Proc_Version = TestResult.Failure
        GoTo teardown
    End If

    If dArgs.Item("exec_version") <> "Quad" Then
        Test_Exec_Proc_Version = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_book") <> "test_procs.xlsm" Then
        Test_Exec_Proc_Version = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_module") <> "tmp1" Then
        Test_Exec_Proc_Version = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Version = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    'DeleteBook sBookName
    
End Function

Function Test_Exec_Wrong_Version_Call_Base() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Wrong_Version_Call_Base
' Purpose  : Test that in a 1 book / 1 module scenario that the base will be called
'          : implicitly if the version cannot be found
' Approach : ver_series=Foo & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sSheetName", "foo"
    dArgs.Add "wbTmp", wbTmp
    dArgs.Add "ver_series", "Foo"

    clsExecProc.ExecProc "DummyCreateSheet", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Wrong_Version_Call_Base = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_version") <> "" Then
        Test_Exec_Wrong_Version_Call_Base = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Wrong_Version_Call_Base = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    'DeleteBook sBookName
    
End Function
Function Test_Exec_Proc_Base() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Base
' Purpose  : Test that in a 1 book / 1 module scenario that we can explitly call the
'          : bases
' Approach : proc_name=DummyCreateSheet (ver_series arg not set)
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Base"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sSheetName", "foo_base"
    dArgs.Add "wbTmp", wbTmp
    
    clsExecProc.ExecProc "DummyCreateSheet", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Proc_Base = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("result").Name <> "foo_base" Then
        Test_Exec_Proc_Base = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_version") <> "" Then
        Test_Exec_Proc_Base = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Base = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    'DeleteBook sBookName
    
End Function

Function Test_Exec_Proc_Fail_No_Base_Nothing_Similar() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Fail_No_Base_Nothing_Similar
' Purpose  : Test that in a 1 book / 1 module scenario that an error return if no
'          : base exists when a version cannot be found
' Approach : ver_series=Quad  & proc_name=WithoutBase
' ExpResult: Fail
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Fail_No_Base_Nothing_Similar"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sSheetName", "foo_no_base"
    dArgs.Add "wbTmp", wbTmp
    dArgs.Add "ver_series", "Quad_"
    
    On Error GoTo err
    clsExecProc.ExecProc "WithoutBase", dArgs
    On Error GoTo 0
    
    Test_Exec_Proc_Fail_No_Base_Nothing_Similar = TestResult.Failure
    GoTo teardown

err:
    If err.Number <> ExecProcErrorMsgType.BASE_VERSION_DOES_NOT_EXIST Then
        Test_Exec_Proc_Fail_No_Base_Nothing_Similar = TestResult.Failure
        GoTo teardown
    End If
    If dArgs.Item("result") <> -1 Then
        Test_Exec_Proc_Fail_No_Base_Nothing_Similar = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Fail_No_Base_Nothing_Similar = TestResult.OK
    GoTo teardown
    
teardown:
    CloseBook wbTmp
    'DeleteBook sBookName
    
End Function

Function Test_Exec_Proc_Version_Multi_Module() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Version_Multi_Module
' Purpose  : Test that in a 1 book / 2 module scenario that a version can be called
'          : explicitly
' Approach : ver_series=Quad  & proc_name=DummyCreateBook
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sBookName", "foo.xls"
    dArgs.Add "sBookPath", GetHomePath
    dArgs.Add "ver_series", "Quad"

    clsExecProc.ExecProc "DummyCreateBook", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Proc_Version_Multi_Module = TestResult.Failure
        GoTo teardown
    End If

    If dArgs.Item("exec_version") <> "Quad" Then
        Test_Exec_Proc_Version_Multi_Module = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_module") <> "tmp2" Then
        Test_Exec_Proc_Version_Multi_Module = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Version_Multi_Module = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    CloseBook Workbooks("foo.xls")
    DeleteBook "foo.xls"
    
End Function

Function Test_Exec_Wrong_Version_Call_Base_Multi_Module() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Wrong_Version_Call_Base_Multi_Module
' Purpose  : Test that in a 1 book / 2 module scenario that the base is called
'          : if the version does not exist
' Approach : ver_series=Foo  & proc_name=DummyCreateBook
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sBookName", "foo.xls"
    dArgs.Add "sBookPath", GetHomePath
    dArgs.Add "ver_series", "Foo"

    clsExecProc.ExecProc "DummyCreateBook", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Wrong_Version_Call_Base_Multi_Module = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_version") <> "" Then
        Test_Exec_Wrong_Version_Call_Base_Multi_Module = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Wrong_Version_Call_Base_Multi_Module = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    CloseBook Workbooks("foo.xls")
    DeleteBook "foo.xls"
    
End Function

Function Test_Exec_Proc_Version_Multi_Book() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Proc_Version_Multi_Book
' Purpose  : Test that in a 2 book / 2 module scenario that a version can be called
'          : explicitly
' Approach : ver_series=Quad  & proc_name=DummyCreateFile
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook, wbTmp2 As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")
    Set wbTmp2 = OpenBook("test_procs2.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp, wbTmp2:=wbTmp2
    
    dArgs.Add "sFileName", "foo.txt"
    dArgs.Add "sFilePath", GetHomePath
    dArgs.Add "ver_series", "Quad"

    clsExecProc.ExecProc "DummyCreateFile", dArgs
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Proc_Version_Multi_Book = TestResult.Failure
        GoTo teardown
    End If

    If dArgs.Item("exec_version") <> "Quad" Then
        Test_Exec_Proc_Version_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_book") <> "test_procs2.xlsm" Then
        Test_Exec_Proc_Version_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_module") <> "tmp1" Then
        Test_Exec_Proc_Version_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Version_Multi_Book = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    CloseBook wbTmp2
    DeleteFile GetHomePath & "\foo.txt"
    
End Function

Function Test_Exec_Wrong_Version_Call_Base_Multi_Book() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Exec_Wrong_Version_Call_Base_Multi_Book
' Purpose  : Test that in a 2 book / 2 module scenario that the base is called
'          : if the version does not exist
' Approach : ver_series=Foo  & proc_name=DummyCreateFile
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook, wbTmp2 As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("test_procs.xlsm", sPath:="C:\Users\burtnolej\Documents")
    Set wbTmp2 = OpenBook("test_procs2.xlsm", sPath:="C:\Users\burtnolej\Documents")
    
main:
    clsExecProc.InitProperties wbTmp:=wbTmp, wbTmp2:=wbTmp2
    
    dArgs.Add "sFileName", "foo.txt"
    dArgs.Add "sFilePath", GetHomePath
    dArgs.Add "ver_series", "Foo"

    clsExecProc.ExecProc "DummyCreateFile", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Wrong_Version_Call_Base_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_version") <> "" Then
        Test_Exec_Wrong_Version_Call_Base_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_book") <> "test_procs.xlsm" Then
        Test_Exec_Wrong_Version_Call_Base_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_module") <> "tmp1" Then
        Test_Exec_Wrong_Version_Call_Base_Multi_Book = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Wrong_Version_Call_Base_Multi_Book = TestResult.OK
    GoTo teardown

teardown:
    CloseBook wbTmp
    CloseBook wbTmp2
    DeleteFile GetHomePath & "\foo.txt"
    
End Function
Function Test_Exec_Proc_Version_RealWorld() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Test_Exec_Proc_Version_RealWorld
' Purpose  : Test that in a 1 book / 1 module scenario that a version can be called
'          : For test to be successful base case must exist
'          : Use the prod code base vba_source_new.xlsm to provide an at scale test
' Approach : ver_series=Version & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("vba_source_new.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp
    
    dArgs.Add "sFileName", "foo.txt"
    dArgs.Add "sFilePath", GetHomePath
    dArgs.Add "ver_series", "Version"
    

    clsExecProc.ExecProc "DummyCreateFile", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Proc_Version_RealWorld = TestResult.Failure
        GoTo teardown
    End If

    If dArgs.Item("exec_version") <> "Version" Then
        Test_Exec_Proc_Version_RealWorld = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_book") <> "vba_source_new.xlsm" Then
        Test_Exec_Proc_Version_RealWorld = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_module") <> "File_Utils_EPrc" Then
        Test_Exec_Proc_Version_RealWorld = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Version_RealWorld = TestResult.OK
    GoTo teardown

teardown:
    'CloseBook wbTmp
    'DeleteBook sBookName
    DeleteFile GetHomePath & "\foo.txt"
    
End Function

Function Test_Exec_Proc_Version_RealWorld_MultiBook() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Test_Exec_Proc_Version_RealWorld_MultiBook
' Purpose  : Test that in a 2 book / 2 module scenario that a version can be called
'          : For test to be successful base case must exist
'          : Use the prod code base vba_source_new.xlsm to provide an at scale test
' Approach : ver_series=Quad & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook, wbTmp2 As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("vba_source_new.xlsm", sPath:="C:\Users\burtnolej\Documents")
    Set wbTmp2 = OpenBook("test_procs2.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp, wbTmp2:=wbTmp2
    
    dArgs.Add "sFileName", "foo.txt"
    dArgs.Add "sFilePath", GetHomePath
    dArgs.Add "ver_series", "Quad"
    

    clsExecProc.ExecProc "DummyCreateFile", dArgs
    
    If MyVarType(dArgs.Item("result")) <> 9 Then
        Test_Exec_Proc_Version_RealWorld_MultiBook = TestResult.Failure
        GoTo teardown
    End If

    If dArgs.Item("exec_version") <> "Quad" Then
        Test_Exec_Proc_Version_RealWorld_MultiBook = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_book") <> "test_procs2.xlsm" Then
        Test_Exec_Proc_Version_RealWorld_MultiBook = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("exec_module") <> "tmp1" Then
        Test_Exec_Proc_Version_RealWorld_MultiBook = TestResult.Failure
        GoTo teardown
    End If
    
    Test_Exec_Proc_Version_RealWorld_MultiBook = TestResult.OK
    GoTo teardown

teardown:
    'CloseBook wbTmp
    'DeleteBook sBookName
    CloseBook wbTmp2
    DeleteFile GetHomePath & "\foo.txt"
    
End Function

Function Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError() As TestResult
'-----------------------------------------------------------------------------------
' Name     : Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError
' Purpose  : Test that in a 2 book / 2 module scenario that an error is properly handled from inside
'          : called function
'          : Use the prod code base vba_source_new.xlsm to provide an at scale test
' Approach : ver_series=Error & proc_name=DummyCreateSheet
' ExpResult: Pass
'-----------------------------------------------------------------------------------
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim wbTmp As Workbook, wbTmp2 As Workbook
Dim sBookName As String, sRootDirectory As String, sCode As String, sModuleName As String, sFuncName As String
Dim eTestResult As TestResult
Dim clsExecProc As New Exec_Proc
Dim vResults As Variant
Dim dArgs As New Dictionary
    
setup:
    sFuncName = C_MODULE_NAME & "." & "Exec_Proc_Run"
    Set wbTmp = OpenBook("vba_source_new.xlsm", sPath:="C:\Users\burtnolej\Documents")
    Set wbTmp2 = OpenBook("test_procs2.xlsm", sPath:="C:\Users\burtnolej\Documents")

main:
    clsExecProc.InitProperties wbTmp:=wbTmp, wbTmp2:=wbTmp2
    
    dArgs.Add "sFileName", "foo.txt"
    dArgs.Add "sFilePath", GetHomePath
    dArgs.Add "ver_series", "Error"

    On Error GoTo err
    clsExecProc.ExecProc "DummyCreateFile", dArgs
    On Error GoTo 0
    
    Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError = TestResult.Failure
    GoTo teardown
    
err:

    If err.Number <> 13 Then
        Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError = TestResult.Failure
        GoTo teardown
    End If
    
    If dArgs.Item("error_desc") <> "Type mismatch" Then
        Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError = TestResult.Failure
        GoTo teardown
    End If
    

    
    Test_Exec_Proc_Version_RealWorld_MultiBook_FuncError = TestResult.OK
    GoTo teardown

teardown:
    'CloseBook wbTmp
    'DeleteBook sBookName
    CloseBook wbTmp2
    DeleteFile GetHomePath & "\foo.txt"
    
End Function
