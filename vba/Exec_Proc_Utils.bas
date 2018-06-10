Attribute VB_Name = "Exec_Proc_Utils"
Option Explicit

Public Function New_Exec_Proc() As Exec_Proc
    Set New_Exec_Proc = New Exec_Proc
End Function

Public Function AddArgs(ByRef dArgs As Dictionary, bReset As Boolean, ParamArray X()) As Dictionary
Dim i As Integer
    If bReset = True Then
        Set dArgs = New Dictionary
    End If
    For i = 0 To UBound(X) Step 2
        If dArgs.Exists(X(i)) Then
            dArgs.Remove X(i)
        End If
        dArgs.Add X(i), X(i + 1)
    Next i
    
    Set AddArgs = dArgs
End Function


Public Sub AddErrorToDict(ByRef dTmp As Dictionary, Optional iErrorCode As Integer, _
                    Optional sErrorDesc As String, Optional vResult As Variant = -1)
    
    dTmp.Add "result", vResult
    
    If iErrorCode <> 0 Then
        dTmp.Add "error_code", iErrorCode
    End If
    
    If sErrorDesc <> "" Then
        dTmp.Add "error_desc", sErrorDesc
    End If
    
End Sub

