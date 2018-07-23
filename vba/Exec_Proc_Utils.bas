Attribute VB_Name = "Exec_Proc_Utils"
Option Explicit
    
Const C_MODULE_NAME = "Exec_Proc_Utils"
Private clsExecProcGlobal As Exec_Proc

#If VBA7 Then
    Declare PtrSafe Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
        ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
#Else
    Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( _
        ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
#End If


Public Function New_Exec_Proc() As Exec_Proc
    Set New_Exec_Proc = New Exec_Proc
End Function

#If VBA7 Then
Function GetExecProcObj(ByVal lExecProcPointer As LongPtr) As Object
#Else
Function GetExecProcObj(ByVal lExecProcPointer As Long) As Object
#End If

    Dim objExecProc As Object

    Call CopyMemory(objExecProc, lExecProcPointer, LenB(lExecProcPointer))

    Set GetExecProcObj = objExecProc
    Set objExecProc = Nothing
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
    
    AddDict dTmp, "result", vResult, bUpdate:=True
    
    If iErrorCode <> 0 Then
        dTmp.Add "error_code", iErrorCode
    End If
    
    If sErrorDesc <> "" Then
        dTmp.Add "error_desc", sErrorDesc
    End If
    
End Sub

Public Sub ResetExecProcGlobal()
    Set clsExecProcGlobal = Nothing
End Sub
Public Sub LetExecProcGlobal(clsExecProc As Exec_Proc)
Dim sFuncName As String
    sFuncName = C_MODULE_NAME & "." & "LetExecProcGlobal"
    If IsInstance(clsExecProc, vbExecProc) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg is not of type Exec_Proc"
    End If
    
    Set clsExecProcGlobal = clsExecProc
    FuncLogIt sFuncName, "Setting GLOBAL Exec_Proc.clsAppRuntimeGlobal", C_MODULE_NAME, LogMsgType.INFO
End Sub
Public Function GetExecProcGlobal(Optional wbTmp As Workbook, Optional wbTmp2 As Workbook) As Exec_Proc
Dim sFuncName As String
Dim clsExecProc As New Exec_Proc
Dim lExecProcPointer As Long


    sFuncName = C_MODULE_NAME & "." & "GetExecProcGlobal"
    
    If IsSet(clsExecProcGlobal) = True Then
        FuncLogIt sFuncName, "GETTING GLOBAL Exec_Proc.clsAppRuntimeGlobal", C_MODULE_NAME, LogMsgType.INFO
        Set GetExecProcGlobal = clsExecProcGlobal
        Exit Function
    Else
        'FuncLogIt sFuncName, "clsExecProcGlobal is NOT SET retreiving pointer", C_MODULE_NAME, LogMsgType.INFO
        'On Error GoTo err
        'lExecProcPointer = wbTmp.Sheets("config").Cells(2, 10).value
        'If lExecProcPointer <> 0 Then
        '    Set GetExecProcGlobal = GetExecProcObj(lExecProcPointer)
        'End If
        'On Error GoTo 0
        
        FuncLogIt sFuncName, "Reloading clsExecProcGlobal from scratch", C_MODULE_NAME, LogMsgType.INFO
        If IsSet(wbTmp2) Then
            clsExecProc.InitProperties wbTmp:=wbTmp, wbTmp2:=wbTmp2
        Else
            clsExecProc.InitProperties wbTmp:=wbTmp
        End If
        
        Set clsExecProcGlobal = clsExecProc
    End If
    
'err:
    'If IsSet(GetExecProcGlobal) = False Then
    '    FuncLogIt sFuncName, "Reloading clsExecProcGlobal from scratch", C_MODULE_NAME, LogMsgType.INFO
    '    clsExecProc.InitProperties wbTmp:=wbTmp
    '    Set clsExecProcGlobal = clsExecProc
    'End If
    
    Set GetExecProcGlobal = clsExecProc
    
End Function
