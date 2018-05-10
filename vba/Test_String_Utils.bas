Attribute VB_Name = "Test_String_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_String_Utils"

Function TestStr2Array() As TestResult
Dim sInputStr As String
Dim iChunkLen As Integer
Dim sResult() As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "Str2Array"
    sInputStr = "0123456789"
    iChunkLen = 3
    sExpectedResult = "012,345,678,9"
    
main:
    sResult = Str2Array(sInputStr, iChunkLen)
    
    If Join(sResult, ",") <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestStr2Array = eTestResult
    
    Exit Function
End Function
Function TestStr2Array_NotEven() As TestResult
Dim sInputStr As String
Dim iChunkLen As Integer
Dim sResult() As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "Str2Array_NotEven"
    sInputStr = "01234"
    iChunkLen = 3
    sExpectedResult = "012,34"
    
main:
    sResult = Str2Array(sInputStr, iChunkLen)
    
    If Join(sResult, ",") <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestStr2Array_NotEven = eTestResult
    
    Exit Function
End Function
Function TestStr2Array_Small() As TestResult
' input str is smaller or equal to the chunk length
Dim sInputStr As String
Dim iChunkLen As Integer
Dim sResult() As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "Str2Array_Small"
    sInputStr = "0123"
    iChunkLen = 4
    sExpectedResult = "0123"
    
main:
    sResult = Str2Array(sInputStr, iChunkLen)
    
    If Join(sResult, ",") <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestStr2Array_Small = eTestResult
    
    Exit Function
End Function
Function TestPadStr_Left() As TestResult
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadChar As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "PadStr_Left"
    sInputStr = "foobar"
    iPadLength = 20
    sDirection = "left"
    sPadChar = "*"
    sExpectedResult = "**************foobar"
main:
    sResult = PadStr(sInputStr, sDirection, iPadLength, sPadChar)

    If sResult <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestPadStr_Left = eTestResult
End Function
Function TestPadStr_Ascii() As TestResult
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadAscii As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "PadStr_Left"
    sInputStr = ""
    iPadLength = 3
    sDirection = "left"
    sPadAscii = 43
    sExpectedResult = "+++"
main:
    sResult = PadStr(sInputStr, sDirection, iPadLength, sPadAscii, bAsciiFlag:=True, iAscii:=43)

    If sResult <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestPadStr_Ascii = eTestResult
End Function
Function TestPadStr_Right() As TestResult
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadChar As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult


setup:
    sFuncName = C_MODULE_NAME & "." & "PadStr_Right"
    sInputStr = "foobar"
    iPadLength = 20
    sDirection = "right"
    sPadChar = "*"
    sExpectedResult = "foobar**************"
main:
    sResult = PadStr(sInputStr, sDirection, iPadLength, sPadChar)

    If sResult <> sExpectedResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestPadStr_Right = eTestResult
End Function

Function TestCleanString() As TestResult
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadChar As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult
setup:
    sFuncName = C_MODULE_NAME & "." & "CleanString"
    sInputStr = "foo" & Chr(10) & Chr(13) & "bar" & Chr(10) & Chr(13)
    sExpectedResult = GetStrAscii("foo" & Chr(10) & Chr(13) & "bar")
main:
    sResult = GetStrAscii(CleanString(sInputStr))
    If sExpectedResult <> sResult Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestCleanString = eTestResult
    
End Function

Function TestReplaceSpace() As TestResult
Dim sInputStr As String
Dim sOutputStr As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sInputStr = "abc def"
    sExpectedResult = "abc%sdef"
    sFuncName = C_MODULE_NAME & "." & "ReplaceSpace"
    
main:
    sOutputStr = Replace(sInputStr, " ", "%s")
    If sExpectedResult <> sOutputStr Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestReplaceSpace = eTestResult
    
End Function


Function TestAsciiReplace() As TestResult
Dim sInputStr As String
Dim sOutputStr As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sInputStr = "abc def"
    sExpectedResult = "abc+def"
    sFuncName = C_MODULE_NAME & "." & "AsciiReplace"
    
main:
    sOutputStr = AsciiReplace(sInputStr, 32, 43)
    If sExpectedResult <> sOutputStr Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAsciiReplace = eTestResult
    
End Function

Function TestAsciiReplaceMulti() As TestResult
Dim sInputStr As String
Dim sOutputStr As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim eTestResult As TestResult

setup:
    sInputStr = "abc def"
    sExpectedResult = "abc+++def"
    sFuncName = C_MODULE_NAME & "." & "AsciiReplaceMulti"
    
main:
    sOutputStr = AsciiReplace(sInputStr, 32, 43, iToCount:=3)
    If sExpectedResult <> sOutputStr Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestAsciiReplaceMulti = eTestResult
    
End Function
