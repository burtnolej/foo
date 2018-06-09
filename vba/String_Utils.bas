Attribute VB_Name = "String_Utils"



Function InParagraph(sSearchParagraphs As String, sSourceParagraph) As Boolean
    InParagraph = True
    If InStr(sSourceParagraph, sSearchParagraphs) = 0 Then
        InParagraph = False
    End If
End Function

Function StartsWith(sValue As String, sStartsWith As String) As Boolean

    If Left(sValue, Len(sStartsWith)) = sStartsWith Then
        StartsWith = True
        End Function
    End If
    
    StartsWith = False
        
End Function
Function EndsWith(sValue As String, sEndsWith As String) As Boolean

    If Right(sValue, Len(sEndsWith)) = sEndsWith Then
        EndsWith = True
        Exit Function
    End If
    
    EndsWith = False
        
End Function
Function PadStr(sInputStr As String, sDirection As String, iPadLength As Integer, sPadChar As String, _
        Optional bAsciiFlag As Boolean = False, Optional iAscii As Integer) As String
Dim iInputLen As Integer
Dim sOutputStr As String
Dim sTmpPad As String

    iInputLen = Len(sInputStr)
    iPadLen = iPadLength - iInputLen
    sTmpPad = ""
    
    If bAsciiFlag = True Then
        sPadChar = Chr(iAscii)
    End If
    
    For i = 0 To iPadLen - 1
        sTmpPad = sTmpPad + sPadChar
    Next i
    
    If sDirection = "right" Then
        PadStr = sInputStr + sTmpPad
    Else
        PadStr = sTmpPad + sInputStr
    End If
    
End Function
Function Str2Array(sInputStr As String, iChunkLen As Integer) As String()
Dim aChunks() As String
ReDim aChunks(0 To GetNumChunks(sInputStr, iChunkLen) - 1)
Dim iChunk As Integer

    If Len(sInputStr) <= iChunkLen Then
        aChunks(0) = sInputStr
        GoTo end_func
    End If
    
    For i = 1 To Len(sInputStr) Step iChunkLen
    
        If i + iChunkLen > Len(sInputStr) Then
            aChunks(iChunk) = Mid(sInputStr, i, Len(sInputStr) - i + 1)
        Else
        
            aChunks(iChunk) = Mid(sInputStr, i, iChunkLen)
        End If
        
        iChunk = iChunk + 1
    Next i

end_func:

    Str2Array = aChunks
End Function
'Function GetNumChunks(sInputStr As String, iChunkLen As Integer) As Integer

Function GetNumChunks(sInputStr As String, iChunkLen As Integer) As Integer
' given a max len how many bits will the input str be broken into
Dim iResult As Integer
Dim iRemainder As Integer

    iResult = Len(sInputStr) \ iChunkLen
    iRemainder = Len(sInputStr) Mod iChunkLen
    
    If iRemainder <> 0 Then
        iResult = iResult + 1
    End If
    
    GetNumChunks = iResult
End Function


Public Function AsciiReplace(sInputStr As String, iFromAscii As Integer, iToAscii As Integer, _
                Optional iToCount As Integer = 1) As String
Dim sResult As String
Dim sChar As String

    sChar = PadStr("", "Left", iToCount, "", bAsciiFlag:=True, iAscii:=43)

    For iter = 1 To Len(sInputStr)
        If Asc(Mid(sInputStr, iter, 1)) = iFromAscii Then
            'sResult = sResult + Chr(iToAscii)
            sResult = sResult + sChar
        Else
            sResult = sResult + Mid(sInputStr, iter, 1)
        End If
    Next
    AsciiReplace = sResult
End Function
Public Function GetStrAscii(sInputStr As String) As String
Dim sResult As String
Dim i As Long
Dim cTmp As String 'Char
    For iter = 1 To Len(sInputStr)
        cTmp = Mid(sInputStr, iter, 1)
        sResult = sResult & cTmp & ":" & Asc(cTmp) & vbCrLf
    Next
    GetStrAscii = sResult
End Function
Public Function GetEndOfString(sInputStr As String) As Long
Dim i As Long
    For i = Len(sInputStr) To 0 Step -1
        If Asc(Mid(sInputStr, i, 1)) <> 10 And Asc(Mid(sInputStr, i, 1)) <> 13 Then
            GetEndOfString = i
            Exit Function
        End If
    Next i
End Function
Public Function GetLastChar(sInputStr As String) As String
Dim iLen As Integer
    GetLastChar = Right(sInputStr, 1)
End Function

Public Function RemoveEndSpaces(sInputStr As String) As String
    RemoveEndSpaces = RTrim(LTrim(sInputStr))
End Function
Public Function CleanString(sInputStr As String) As String
Dim sResult As String
Dim iEndOfStr As Long

    iEndOfStr = GetEndOfString(sInputStr)
    
    For iter = 1 To iEndOfStr
        sResult = sResult & Mid(sInputStr, iter, 1)
    Next
    CleanString = sResult
End Function

