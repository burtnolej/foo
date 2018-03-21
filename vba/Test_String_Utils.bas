Attribute VB_Name = "Test_String_Utils"
Option Explicit
'Sub TestPadStr_Left
'Sub TestPadStr_Right
'Sub TestStr2Array_Small()
'Sub TestStr2Array_NotEven()

Const CsModuleName = "Test_String_Utils"

Sub TestRunner()
    Call TestPadStr_Left
    Call TestPadStr_Right
    Call TestStr2Array
    Call TestStr2Array_Small
    Call TestStr2Array_NotEven
    Call TestCleanString
    Call TestReplaceSpace
    Call TestPadStr_Ascii ' create n * some ascii number
    Call TestAsciiReplace
    Call TestAsciiReplaceMulti
End Sub
Sub TestStr2Array()
Dim sInputStr As String
Dim iChunkLen As Integer
Dim sResult() As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "Str2Array"
    sInputStr = "0123456789"
    iChunkLen = 3
    sExpectedResult = "012,345,678,9"
    
main:
    sResult = Str2Array(sInputStr, iChunkLen)
    
    If Join(sResult, ",") <> sExpectedResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
    Exit Sub
End Sub
Sub TestStr2Array_NotEven()
Dim sInputStr As String
Dim iChunkLen As Integer
Dim sResult() As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "Str2Array_NotEven"
    sInputStr = "01234"
    iChunkLen = 3
    sExpectedResult = "012,34"
    
main:
    sResult = Str2Array(sInputStr, iChunkLen)
    
    If Join(sResult, ",") <> sExpectedResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
    Exit Sub
End Sub
Sub TestStr2Array_Small()
' input str is smaller or equal to the chunk length
Dim sInputStr As String
Dim iChunkLen As Integer
Dim sResult() As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "Str2Array_Small"
    sInputStr = "0123"
    iChunkLen = 4
    sExpectedResult = "0123"
    
main:
    sResult = Str2Array(sInputStr, iChunkLen)
    
    If Join(sResult, ",") <> sExpectedResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    
    Exit Sub
End Sub
Sub TestPadStr_Left()
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadChar As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "PadStr_Left"
    sInputStr = "foobar"
    iPadLength = 20
    sDirection = "left"
    sPadChar = "*"
    sExpectedResult = "**************foobar"
main:
    sResult = PadStr(sInputStr, sDirection, iPadLength, sPadChar)

    If sResult <> sExpectedResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
    Debug.Print sResult
End Sub
Sub TestPadStr_Ascii()
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadAscii As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "PadStr_Left"
    sInputStr = ""
    iPadLength = 3
    sDirection = "left"
    sPadAscii = 43
    sExpectedResult = "+++"
main:
    sResult = PadStr(sInputStr, sDirection, iPadLength, sPadAscii, bAsciiFlag:=True, iAscii:=43)

    If sResult <> sExpectedResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
    Debug.Print sResult
End Sub
Sub TestPadStr_Right()
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadChar As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean


setup:
    sFuncName = CsModuleName & "." & "PadStr_Right"
    sInputStr = "foobar"
    iPadLength = 20
    sDirection = "right"
    sPadChar = "*"
    sExpectedResult = "foobar**************"
main:
    sResult = PadStr(sInputStr, sDirection, iPadLength, sPadChar)

    If sResult <> sExpectedResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
    Debug.Print sResult
End Sub

Sub TestCleanString()
Dim sInputStr As String
Dim sDirection As String
Dim iPadLength As Integer
Dim sPadChar As String
Dim sResult As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sFuncName = CsModuleName & "." & "CleanString"
    sInputStr = "foo" & Chr(10) & Chr(13) & "bar" & Chr(10) & Chr(13)
    sExpectedResult = GetStrAscii("foo" & Chr(10) & Chr(13) & "bar")
main:
    sResult = GetStrAscii(CleanString(sInputStr))
    If sExpectedResult <> sResult Then
        GoTo fail
    End If
 
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
End Sub

Sub TestReplaceSpace()
Dim sInputStr As String
Dim sOutputStr As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sInputStr = "abc def"
    sExpectedResult = "abc%sdef"
    sFuncName = CsModuleName & "." & "ReplaceSpace"
    
main:
    sOutputStr = Replace(sInputStr, " ", "%s")
    If sExpectedResult <> sOutputStr Then
        GoTo fail
    End If
    
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
End Sub


Sub TestAsciiReplace()
Dim sInputStr As String
Dim sOutputStr As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sInputStr = "abc def"
    sExpectedResult = "abc+def"
    sFuncName = CsModuleName & "." & "AsciiReplace"
    
main:
    sOutputStr = AsciiReplace(sInputStr, 32, 43)
    If sExpectedResult <> sOutputStr Then
        GoTo fail
    End If
    
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
End Sub

Sub TestAsciiReplaceMulti()
Dim sInputStr As String
Dim sOutputStr As String
Dim sExpectedResult As String
Dim sFuncName As String
Dim bTestPassed As Boolean

setup:
    sInputStr = "abc def"
    sExpectedResult = "abc+++def"
    sFuncName = CsModuleName & "." & "AsciiReplaceMulti"
    
main:
    sOutputStr = AsciiReplace(sInputStr, 32, 43, iToCount:=3)
    If sExpectedResult <> sOutputStr Then
        GoTo fail
    End If
    
Success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Exit Sub
    
End Sub
