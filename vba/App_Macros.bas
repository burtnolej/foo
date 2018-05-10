Attribute VB_Name = "App_Macros"
Option Explicit
Const C_MODULE_NAME = "App_Macros"

Public Sub DoGeneratePersonView()
'<<<
'purpose: simple wrapper to launch a Student View workflow
'>>>
Dim clsQuadRuntime As New Quad_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String
Dim lStartTick As Long

setup:
    ChDir "C:\Users\burtnolej\Documents\runtime"
    
    sFuncName = C_MODULE_NAME & "." & "DoGeneratePersonView"
    CloseLogFile
    GetLogFile ' write stdout to a logfile
    'Log_Utils.LogFilter = "0,1,2,3"
        
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    GeneratePersonView clsQuadRuntime

cleanup:
    Set wsView = clsQuadRuntime.ViewBook.Sheets("ViewStudent")
    wsView.Visible = xlSheetVisible
    wsView.Activate
    DoEventsOn
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub

Public Sub DoAddAddScheduleAdd()
Dim clsQuadRuntime As New Quad_Runtime
Dim sSheetName As String
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String

    DoEventsOn
        
    ResetQuadRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "DoAddAddScheduleAdd"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    GenerateScheduleAdd clsQuadRuntime
End Sub

