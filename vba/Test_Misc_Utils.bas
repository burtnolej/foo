Attribute VB_Name = "Test_Misc_Utils"
Const C_MODULE_NAME = "Test_Misc_Utils"


Function Test_IsAppRuntime() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    sFuncName = C_MODULE_NAME & ".MyVarTypeEnum"
    
main:
    If IsAppRuntime(clsAppRuntime) = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsAppRuntime = eTestResult
    
End Function
Function Test_IsAppRuntime_False() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New rgbColor

setup:
    sFuncName = C_MODULE_NAME & ".MyVarTypeEnum"
    
main:
    If IsAppRuntime(clsAppRuntime) = True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    eTestResult = TestResult.OK
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_IsAppRuntime_False = eTestResult
    
End Function

Function Test_MyVarTypeEnum() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim sTmp As String

setup:
    sFuncName = C_MODULE_NAME & ".MyVarTypeEnum"
    
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
    sFuncName = C_MODULE_NAME & ".MyVarTypeEnumStrArray4Columns"
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
    sFuncName = C_MODULE_NAME & ".MyVarTypeEnumDict"
    
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

Function Test_MyVarTypeEnumAppRuntime() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As New App_Runtime

setup:
    sFuncName = C_MODULE_NAME & ".MyVarTypeEnumAppRuntime"
    
main:
    If EnumVarType(MyVarType(dTmp)) <> "vbAppRuntime" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test_MyVarTypeEnumAppRuntime = eTestResult
    
    
End Function


Function Test_MyVarTypeDict() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim dTmp As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & ".IsDict"
    
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
    sFuncName = C_MODULE_NAME & ".MyVarTypeStringArray"
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
    sFuncName = C_MODULE_NAME & ".MyVarTypeStringArray3Columns"
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
    sFuncName = C_MODULE_NAME & ".IsDict"
    
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
    sFuncName = C_MODULE_NAME & ".IsDictFail"
    
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
    sFuncName = C_MODULE_NAME & ".IsInstanceExceptionFail"
    
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
    sFuncName = C_MODULE_NAME & ".IsInstanceExceptionPass"
    
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
    sFuncName = C_MODULE_NAME & ".IsInstanceFail"
    
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
    sFuncName = C_MODULE_NAME & ".IsInstancePass"
    
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
    sFuncName = C_MODULE_NAME & ".IsEqual"
    
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
    sFuncName = C_MODULE_NAME & "." & "UUEncode"
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
