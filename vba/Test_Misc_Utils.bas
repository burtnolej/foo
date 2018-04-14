Attribute VB_Name = "Test_Misc_Utils"
Const CsModuleName = "Test_Misc_Utils"


Function Test_IsQuadRuntime() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New Quad_Runtime

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnum"
    
main:
    If IsQuadRuntime(clsQuadRuntime) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsQuadRuntime = eTestResult
    
End Function
Function Test_IsQuadRuntime_False() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsQuadRuntime As New RGBColor

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnum"
    
main:
    If IsQuadRuntime(clsQuadRuntime) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsQuadRuntime_False = eTestResult
    
End Function

Function Test_MyVarTypeEnum() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim sTmp As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnum"
    
main:
    If EnumVarType(MyVarType(sTmp)) <> "vbString" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeEnum = eTestResult
    
End Function

Function Test_MyVarTypeEnumStrArray4Columns() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aTmp() As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnumStrArray4Columns"
    aTmp = Init2DStringArray([{"col1", "col2","col3";"val1","val2","val3"}])
    
main:
    If EnumVarType(MyVarType(aTmp)) <> "vb2DStringArray4Columns" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeEnumStrArray4Columns = eTestResult
    
    
End Function

Function Test_MyVarTypeEnumDict() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As New Dictionary

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnumDict"
    
main:
    If EnumVarType(MyVarType(dTmp)) <> "vbDict" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeEnumDict = eTestResult
    
    
End Function

Function Test_MyVarTypeEnumQuadRuntime() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As New Quad_Runtime

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnumQuadRuntime"
    
main:
    If EnumVarType(MyVarType(dTmp)) <> "vbQuadRuntime" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeEnumQuadRuntime = eTestResult
    
    
End Function


Function Test_MyVarTypeDict() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As New Dictionary

setup:
    sFuncName = CsModuleName & ".IsDict"
    
main:
    If MyVarType(dTmp) <> 21 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeDict = eTestResult
    
End Function

Function Test_MyVarTypeStringArray() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aTmp() As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeStringArray"
    aTmp = InitStringArray(Array("foo", "bar"))
main:
    If MyVarType(aTmp) <> 23 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeStringArray = eTestResult
    
    
End Function

Function Test_MyVarTypeStringArray3Columns() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim aTmp() As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeStringArray3Columns"
    aTmp = Init2DStringArray([{"col1", "col2","col3";"val1","val2","val3"}])
main:
    If MyVarType(aTmp) <> 48 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeStringArray3Columns = eTestResult
    
    
End Function
Function Test_IsDict() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As New Dictionary

setup:
    sFuncName = CsModuleName & ".IsDict"
    
main:
    If IsDict(dTmp) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If dTmp.Count <> 0 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsDict = eTestResult
    
    
End Function

Function Test_IsDictFail() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As String

setup:
    sFuncName = CsModuleName & ".IsDictFail"
    
main:
    If IsDict(dTmp) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsDictFail = eTestResult
    
End Function

Function Test_IsInstanceExceptionFail() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = CsModuleName & ".IsInstanceExceptionFail"
    
main:
    On Error GoTo err
    IsInstance "foobar", vbBoolean, sFuncName:=sFuncName
    On Error GoTo 0
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsInstanceExceptionFail = eTestResult
    
End Function


Function Test_IsInstanceExceptionPass() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = CsModuleName & ".IsInstanceExceptionPass"
    
main:
    On Error GoTo err
    IsInstance True, vbBoolean, sFuncName:=sFuncName
    On Error GoTo 0
    eTestResult = TestResult.OK
    GoTo teardown
    
    
err:
    eTestResult = TestResult.Error
        
teardown:
    Test_IsInstanceExceptionPass = eTestResult
    
End Function

Function Test_IsInstanceFail() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = CsModuleName & ".IsInstanceFail"
    
main:
    If IsInstance("foobar", vbBoolean, sFuncName:=sFuncName, bAssert:=False) = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsInstanceFail = eTestResult
    
End Function


Function Test_IsInstancePass() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = CsModuleName & ".IsInstancePass"
    
main:
    If IsInstance(True, vbBoolean, sFuncName:=sFuncName, bAssert:=False) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsInstancePass = eTestResult
    
End Function

Function Test_IsEqual() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = CsModuleName & ".IsEqual"
    
main:
    If IsEqual(10, 10, sFuncName:=sFuncName, bAssert:=False) = False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsEqual = eTestResult
    
End Function

Function Test_UUEncode() As TestResult
Dim sFuncName As String, sTmp As String
Dim eTestResult As TestResult

setup:
    sFuncName = CsModuleName & "." & "UUEncode"
    sTmp = Environ("MYHOME") & "''''"
main:

    If UUDecode(UUEncode(sTmp)) <> sTmp Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_UUEncode = eTestResult
End Function
