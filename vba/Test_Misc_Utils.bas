Attribute VB_Name = "Test_Misc_Utils"
Const CsModuleName = "Test_Misc_Utils"

Sub TestRunner()
    'GetLogFile
    Log_Utils.LogFilter = "8,9"
    Test_UUEncode
    Test_IsInstanceExceptionFail
    Test_IsInstanceExceptionPass
    Test_IsInstanceFail
    Test_IsInstancePass
    Test_IsEqual
    Test_IsDict
    Test_IsDictFail
    Test_MyVarTypeEnumDict
    Test_MyVarTypeEnum
    Test_MyVarTypeEnumStrArray4Columns
    Test_MyVarTypeStringArray3Columns
    
    'GetLogFile
    
End Sub


Sub Test_MyVarTypeEnum()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim sTmp As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnum"
    
main:
    If EnumVarType(MyVarType(sTmp)) <> "vbString" Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_MyVarTypeEnumStrArray4Columns()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim aTmp() As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnumStrArray4Columns"
    aTmp = Init2DStringArray([{"col1", "col2","col3";"val1","val2","val3"}])
    
main:
    If EnumVarType(MyVarType(aTmp)) <> "vb2DStringArray4Columns" Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_MyVarTypeEnumDict()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim dTmp As New Dictionary

setup:
    sFuncName = CsModuleName & ".MyVarTypeEnumDict"
    
main:
    If EnumVarType(MyVarType(dTmp)) <> "vbDict" Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub


Sub Test_MyVarTypeDict()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim dTmp As New Dictionary

setup:
    sFuncName = CsModuleName & ".IsDict"
    
main:
    If MyVarType(dTmp) <> 21 Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_MyVarTypeStringArray()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim aTmp() As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeStringArray"
    aTmp = InitStringArray(Array("foo", "bar"))
main:
    If MyVarType(aTmp) <> 23 Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_MyVarTypeStringArray3Columns()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim aTmp() As String

setup:
    sFuncName = CsModuleName & ".MyVarTypeStringArray3Columns"
    aTmp = Init2DStringArray([{"col1", "col2","col3";"val1","val2","val3"}])
main:
    If MyVarType(aTmp) <> 48 Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub
Sub Test_IsDict()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim dTmp As New Dictionary

setup:
    sFuncName = CsModuleName & ".IsDict"
    
main:
    If IsDict(dTmp) = False Then
        GoTo fail
    End If
    
    If dTmp.Count <> 0 Then
        GoTo fail
    End If
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_IsDictFail()
Dim sFuncName As String
Dim bTestPassed As Boolean
Dim dTmp As String

setup:
    sFuncName = CsModuleName & ".IsDictFail"
    
main:
    If IsDict(dTmp) = True Then
        GoTo fail
    End If
    
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_IsInstanceExceptionFail()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & ".IsInstanceExceptionFail"
    
main:
    On Error GoTo err
    IsInstance "foobar", vbBoolean, sFuncName:=sFuncName
    On Error GoTo 0
    GoTo fail
err:
    GoTo success

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub


Sub Test_IsInstanceExceptionPass()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & ".IsInstanceExceptionPass"
    
main:
    On Error GoTo err
    IsInstance True, vbBoolean, sFuncName:=sFuncName
    On Error GoTo 0
    GoTo success
err:
    GoTo fail

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_IsInstanceFail()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & ".IsInstanceFail"
    
main:
    If IsInstance("foobar", vbBoolean, sFuncName:=sFuncName, bAssert:=False) = True Then
        GoTo fail
    End If

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub


Sub Test_IsInstancePass()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & ".IsInstancePass"
    
main:
    If IsInstance(True, vbBoolean, sFuncName:=sFuncName, bAssert:=False) = False Then
        GoTo fail
    End If

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_IsEqual()
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & ".IsEqual"
    
main:
    If IsEqual(10, 10, sFuncName:=sFuncName, bAssert:=False) = False Then
        GoTo fail
    End If

success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
End Sub

Sub Test_UUEncode()
Dim sFuncName As String, sTmp As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "UUEncode"
    sTmp = "C:\\Users\\burtnolej''''"
main:

    If UUDecode(UUEncode(sTmp)) <> sTmp Then
        GoTo fail
    End If
    
    
success:
    bTestPassed = True
    GoTo teardown
    
fail:
    bTestPassed = False
    
teardown:
    Call TestLogIt(sFuncName, bTestPassed)

End Sub
