Attribute VB_Name = "App_Macros"
Option Explicit
Const CsModuleName = "App_Macros"

Public Sub DoGeneratePersonView()
'<<<
'purpose: simple wrapper to launch a Student View workflow
'>>>
Dim clsQuadRuntime As New Quad_Runtime
Dim sSheetName As String, sFuncName As String
Dim wsView As Worksheet
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String

setup:
    sFuncName = CsModuleName & "." & "DoGeneratePersonView"
    GetLogFile ' write stdout to a logfile
    FuncLogIt sFuncName, "", CsModuleName, LogMsgType.INFUNC
    sFuncName = CsModuleName & "." & "GeneratePersonView"
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
    FuncLogIt sFuncName, "", CsModuleName, LogMsgType.OUTFUNC
    
End Sub

Public Sub DoAddAddScheduleAdd()
Dim clsQuadRuntime As New Quad_Runtime
Dim sSheetName As String
Dim sScheduleName As String, sSchedulePath As String, sNewSchedulePath As String

    DoEventsOn
        
    ResetQuadRuntimeGlobal
    sFuncName = CsModuleName & "." & "DoAddAddScheduleAdd"
    sSheetName = "test"
    clsQuadRuntime.InitProperties bInitializeCache:=True, _
                                  sDefinitionSheetName:=sSheetName, _
                                  sBookName:="vba_source_new.xlsm", _
                                  sBookPath:="C:\Users\burtnolej\Documents\GitHub\quadviewer", _
                                  bSetWindows:=False

main:
    GenerateScheduleAdd clsQuadRuntime
End Sub

