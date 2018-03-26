Attribute VB_Name = "Array_Utils"
' Errors
' ----------------------------------------------------------------------------------------------
Const CsModuleName = "Array_Utils"
Enum ArrayErrors
    ArgNot2DArray = 1
    NotArrayFromRange = 2
End Enum
Const C_ARRAY_ERROR = "ArgNot2DArray,NotArrayFromRange"
Const C_MODULE_NAME = "Array_Utils"
Const C_ERROR_RANGE = 500
Function ReDim2DArray(aInput As Variant, _
                      iTargetLength As Integer, _
                      iTargetWidth As Integer, _
                      Optional iStartRow As Integer = 0, _
                      Optional iStartCol As Integer = 0) As Variant
Dim aTmp() As String
Dim iOrigWidth As Integer
Dim iOrigLength As Integer

    iOrigLength = UBound(aInput)
    iOrigWidth = UBound(aInput, 2)
    
    ReDim aTmp(0 To iTargetLength - 1, 0 To iTargetWidth - 1)
    
    For i = iStartRow To iStartRow + iTargetLength - 1
        For j = iStartCol To iStartCol + iTargetWidth - 1
            aTmp(i - iStartRow, j - iStartCol) = aInput(i, j)
        Next j
    Next i
    ReDim2DArray = aTmp

End Function
Function IndexArray(aSearch As Variant, sValue As String) As Integer
    For i = 0 To UBound(aSearch)
        If aSearch(i) = sValue Then
            IndexArray = i
            Exit Function
        End If
    Next
    IndexArray = -1
End Function
Public Function AddArrays(iWidth As Integer, ParamArray X()) As Variant
Dim aTmp As Variant
Dim aResult As Variant
Dim iRowCount As Integer
Dim iRow As Integer, iCol As Integer

    ReDim aResult(0 To 10000, 0 To iWidth)
    For Each aTmp In X
        For iRow = LBound(aTmp) To UBound(aTmp)
            For iCol = LBound(aTmp, 2) To UBound(aTmp, 2)
                aResult(iRowCount, iCol - LBound(aTmp, 2)) = aTmp(iRow, iCol)
            Next iCol
            iRowCount = iRowCount + 1
        Next iRow
    Next aTmp
    
    AddArrays = ReDim2DArray(aResult, iRowCount, iWidth)
End Function
Public Function ArrayNDtoString(aRows As Variant, _
                                Optional bUUEncode As Boolean = False, _
                                Optional sRowDelim As String = "$$", _
                                Optional sFieldDelim As String = "^")
' convert a multi dimensional array to a single string; can specific type of delim and whether to
' uuencode or not
' {"A","B";"C","D"}                     = "A^B$$C^D" or "QQ==^Qg==$$Qw==^RA==" when encoded
' {"A","B","C";"C","D","E";"F","G","H"} = "A^B^C$$D^E^F$$G^H^I" or "A&B&C_D&E&F_G&H&I" with diff delims
' Array("A", "B")                       = "A$$B" or "QQ==$$Qg==" when encoded

Dim iLastCol As Integer
Dim iFirstCol As Integer
Dim sTableStr As String
Dim sRowStr As String
Dim vValue As Variant

    If Is2DArray(aRows) = True Then
        iLastCol = UBound(aRows, 2)
        iFirstCol = LBound(aRows, 2)
    Else
        iLastCol = 0
        iFirstCol = 0
    End If
        
    
    sTableStr = ""
    For i = LBound(aRows) To UBound(aRows)
        sRowStr = ""
        For j = iFirstCol To iLastCol
            If j = iFirstCol Then
                If iLastCol = 0 Then
                    vValue = aRows(i)
                Else
                    vValue = aRows(i, j)
                End If
                
                If bUUEncode = True Then
                    sRowStr = UUEncode(CStr(vValue))
                Else
                    sRowStr = CStr(vValue)
                End If
            Else
                If bUUEncode = True Then
                    sRowStr = sRowStr & sFieldDelim & UUEncode(CStr(aRows(i, j)))
                Else
                    sRowStr = sRowStr & sFieldDelim & CStr(aRows(i, j))
                End If
            End If
        Next j
        If i = LBound(aRows) Then
            sTableStr = sRowStr
        Else:
             sTableStr = sTableStr & sRowDelim & sRowStr
        End If
    Next i
    
    ArrayNDtoString = sTableStr
End Function

Function Is2DArray(aTmp As Variant) As Boolean
Dim iTmp As Integer

    On Error GoTo err
    iTmp = UBound(aTmp, 2)
    On Error GoTo 0
    Is2DArray = True
    Exit Function

err:
    Is2DArray = False

End Function

Function NumColumns(aTmp As Variant, Optional bAssert = True) As Integer
'''determine how many columns a 2 dimension array has. throw an exception if in array is not passed _
:param aTmp: array, 2D array of any type _
:rtype boolean
'''
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & ".NumColumns"

main:
    If Is2DArray(aTmp) = True Then
        NumColumns = UBound(aTmp, 2) + 1
    Else
        'FuncLogIt sFuncName, "not a 2d array", C_MODULE_NAME, LogMsgType.Error
        'If bAssert = True Then
        '    err.Raise 103, Description:=" not a 2d array"
        'End If
        NumColumns = 1
    End If
End Function
Function EqualsArray(aFirst As Variant, aSecond As Variant) As Boolean
    If UBound(aFirst) <> UBound(aSecond) Then
            EqualsArray = False
            Exit Function
        End If
    
    For i = 0 To UBound(aFirst)
        If CStr(aFirst(i)) <> CStr(aSecond(i)) Then
            EqualsArray = False
            Exit Function
        End If
    Next
    EqualsArray = True
End Function
Public Function HasNDimensions(aTmp As Variant, iNDims As Integer) As Boolean
' Check if an array has the right number of Dimensions
Dim sFuncName As String
Dim iDimSize As Integer
setup:
    sFuncName = C_MODULE_NAME & "." & "HasNDimensions"
    
main:
    On Error GoTo err
    iDimSize = UBound(aTmp, iNDims)
    On Error GoTo 0
    
    HasNDimensions = True
    Exit Function
err:
    HasNDimensions = False

End Function
Public Function ConvertArrayFromRangeto1D(a2DVals As Variant, _
                    Optional bHz As Boolean = False) As String()
Dim iTmp() As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "Convert2Dto1D"
    
    If LBound(a2DVals) <> 1 And LBound(a2DVals, 2) = 1 Then
        FuncLogIt sFuncName, "To be used with an array thats been converted from a range, so x dimension starts at 1 not 0", C_MODULE_NAME, LogMsgType.Error
        err.Raise Number:=C_ERROR_RANGE + ArrayErrors.NotArrayFromRange
    End If

    If LBound(a2DVals, 2) <> 1 And LBound(a2DVals) = 1 Then
        FuncLogIt sFuncName, "To be used with an array thats been converted from a range, so y dimension starts at 1 not 0", C_MODULE_NAME, LogMsgType.Error
        err.Raise Number:=C_ERROR_RANGE + ArrayErrors.NotArrayFromRange
    End If
    
    If HasNDimensions(a2DVals, 2) = False Then
         FuncLogIt sFuncName, "Convert2Dto1D requires a 2d array as an argument", C_MODULE_NAME, LogMsgType.Error
         err.Raise Number:=C_ERROR_RANGE + ArrayErrors.ArgNot2DArray
    End If
    
    If bHz = False Then
        ReDim iTmp(0 To UBound(a2DVals) - 1)
        For i = 0 To UBound(a2DVals) - 1
            For j = 0 To 0
                iTmp(i) = a2DVals(i + 1, j + 1)
            Next j
        Next i
    Else
        ReDim iTmp(0 To UBound(a2DVals, 2) - 1)
        For j = 0 To UBound(a2DVals, 2) - 1
            For i = 0 To 0
                iTmp(j) = a2DVals(i + 1, j + 1)
            Next i
        Next j
    End If
    
    
    ConvertArrayFromRangeto1D = iTmp
    
End Function
Function InArray(aSearch As Variant, iValue As Variant) As Boolean
' Determine if value [iValue] is a member of set [aSearch]; [aSearch] needs to be a 1 dimensional array
    For i = 0 To UBound(aSearch)
        If CStr(aSearch(i)) = CStr(iValue) Then
            InArray = True
            Exit Function
        End If
    Next
    InArray = False
End Function
Function Array2String(aVals() As String, Optional aWidths As Variant, Optional sDelim As String = "") As String
Dim sResult As String
Dim iWidth As Integer
Dim sPadChar As String

    sPadChar = " "
    For i = 0 To UBound(aVals)
        If IsArray(aWidths) = True Then
            iWidth = aWidths(i)
        Else
            iWidth = Len(aVals(i))
        End If
        
        sresult_ = PadStr(aVals(i), "right", iWidth, sPadChar)
        If sResult = "" Then
            sResult = sresult_
        Else
            sResult = sResult + sDelim + sresult_
        End If
    Next i
    
    Array2String = sResult
End Function
Public Function Init2DStringArray(aInitVals As Variant) As String()
Dim iTmp() As String
ReDim iTmp(0 To UBound(aInitVals) - 1, 0 To UBound(aInitVals, 2) - 1)
Dim i As Integer
Dim j As Integer

    For i = 0 To UBound(aInitVals) - 1
        For j = 0 To UBound(aInitVals, 2) - 1
            iTmp(i, j) = aInitVals(i + 1, j + 1)
        Next j
    Next i
    
    Init2DStringArray = iTmp
    
End Function
Public Function Init2DVariantArray(aInitVals As Variant) As Variant
Dim iTmp() As Variant
ReDim iTmp(LBound(aInitVals) To UBound(aInitVals), LBound(aInitVals, 2) To UBound(aInitVals, 2))
Dim i As Integer
Dim j As Integer

    For i = LBound(aInitVals) To UBound(aInitVals)
        For j = LBound(aInitVals, 2) To UBound(aInitVals, 2)
            iTmp(i, j) = aInitVals(i, j)
        Next j
    Next i
    
    Init2DVariantArray = iTmp
    
End Function
Public Function Init2DIntArray(aInitVals As Variant) As Integer()
Dim iTmp() As Integer
ReDim iTmp(0 To UBound(aInitVals) - 1, 0 To UBound(aInitVals, 2) - 1)
Dim i As Integer
Dim j As Integer

    For i = 0 To UBound(aInitVals) - 1
        For j = 0 To UBound(aInitVals, 2) - 1
            iTmp(i, j) = aInitVals(i + 1, j + 1)
        Next j
    Next i
    
    Init2DIntArray = iTmp
    
End Function
Function InitStringArray(aInitVals As Variant) As String()
Dim iTmp() As String
ReDim iTmp(0 To UBound(aInitVals))

    For i = 0 To UBound(aInitVals)
        iTmp(i) = aInitVals(i)
    Next i
    
    InitStringArray = iTmp
End Function
Function InitVariantArray(aInitVals As Variant) As Variant()
Dim iTmp() As Variant
ReDim iTmp(0 To UBound(aInitVals))

    For i = 0 To UBound(aInitVals)
        iTmp(i) = aInitVals(i)
    Next i
    
    InitVariantArray = iTmp
End Function
Function InitIntArray(aInitVals As Variant) As Integer()
Dim iTmp() As Integer
ReDim iTmp(0 To UBound(aInitVals))

    For i = 0 To UBound(aInitVals)
        iTmp(i) = aInitVals(i)
    Next i
    
    InitIntArray = iTmp
End Function
