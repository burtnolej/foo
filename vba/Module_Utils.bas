Attribute VB_Name = "Module_Utils"
Const C_MODULE_NAME = "Module_Utils"

Public Function CreateModule(xlwb As Workbook, sModuleName As String, sCode As String) As VBComponent
Dim module As VBComponent
    Set module = xlwb.VBProject.VBComponents.Add(vbext_ct_StdModule)
    module.Name = sModuleName
    module.CodeModule.AddFromString sCode
    Set CreateModule = module
End Function
Public Sub AddCode2Module(xlwb As Workbook, sModuleName As String, sCode As String)
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
    
    Set VBProj = xlwb.VBProject
    Set VBComp = VBProj.VBComponents(sModuleName)
    VBComp.CodeModule.AddFromString sCode
    
    Set VBProj = Nothing
    Set VBComp = Nothing

End Sub

Sub DeleteModule(xlwb As Workbook, sModuleName As String)
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
    
    Set VBProj = xlwb.VBProject
    Set VBComp = VBProj.VBComponents(sModuleName)
    VBProj.VBComponents.Remove VBComp
End Sub
Function GetModule(xlwb As Workbook, sModuleName As String) As VBComponent
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
    
    Set VBProj = xlwb.VBProject
    
    On Error GoTo err
    Set VBComp = VBProj.VBComponents(sModuleName)
    Set GetModule = VBComp
    Exit Function
    
err:
    Debug.Print "here"
    Set GetModule = Nothing
    
End Function

Function ModuleExists(xlwb As Workbook, sModuleName As String) As Boolean
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
    
    Set VBProj = xlwb.VBProject
    
    On Error GoTo err
    Set VBComp = VBProj.VBComponents(sModuleName)
    ModuleExists = True
    Exit Function
    
err:
    ModuleExists = False
    
End Function
Function ExportModules(xlwb As Workbook, sDirectory As String, sSuffix As String, Optional sModuleName As String) As String()
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim vModulesNames() As String
Dim iCount As Integer
ReDim vModulesNames(0 To 100)
    
    If sModuleName <> "" Then
        vModulesNames(iCount) = sModuleName
        iCount = iCount + 1
    Else
        Set VBProj = xlwb.VBProject
        For Each VBComp In VBProj.VBComponents
            vModulesNames(iCount) = VBComp.Name
            iCount = iCount + 1
        Next VBComp
    End If
    ReDim Preserve vModulesNames(0 To iCount - 1)
    
    ExportModules = vModulesNames

    For i = 0 To UBound(vModulesNames)
        Set VBComp = GetModule(xlwb, vModulesNames(i))
        Path = sDirectory & vModulesNames(i) & sSuffix & ".bas"
        
        Call VBComp.Export(Path)
    Next i

End Function

Function ImportModules(xlwb As Workbook, sDirectory As String, _
                    Optional sModuleName As String, _
                    Optional bOverwrite As Boolean = True, _
                    Optional sIgnoreModules As String, _
                    Optional bDryRun As Boolean = False) As Integer
Dim VBProj As VBIDE.VBProject
Dim VBComps As VBIDE.VBComponents
Dim VBComp As VBIDE.VBComponent
Dim vFileNames() As String, vIgnoreModules() As String
Dim iCount As Integer
Dim sFuncName As String

    sFuncName = C_MODULE_NAME & "." & "ImportModules"
    If sModuleName <> "" Then
        ReDim vModulesNames(0 To 0)
        vFileNames(0) = sDirectory & "/" & sModuleName
    Else
        vFileNames = GetFolderFiles(sDirectory & "/")
    End If

    Set VBComps = xlwb.VBProject.VBComponents
    
    For Each sFile In vFileNames
        sModuleName = Split(sFile, ".")(0)
        vIgnoreModules = Split(sIgnoreModules, ",")
        If InArray(vIgnoreModules, sModuleName) = False Then
            If ModuleExists(xlwb, sModuleName) = True And bOverwrite = False Then
                FuncLogIt sFuncName, "skipping " & sModuleName & " as exists and bOverwrite = False", C_MODULE_NAME, LogMsgType.INFO
            ElseIf ModuleExists(xlwb, sModuleName) = True And bOverwrite = True Then
                FuncLogIt sFuncName, "deleting [" & sModuleName & "] as exists but overwrite=True", C_MODULE_NAME, LogMsgType.INFO
                If bDryRun = False Then
                    DeleteModule xlwb, sModuleName
                    VBComps.Import sDirectory & "/" & sFile
                End If
            Else
                On Error Resume Next
                If bDryRun = False Then
                    VBComps.Import sDirectory & "/" & sFile
                End If
                iCount = iCount + 1
                FuncLogIt sFuncName, "importing [" & sModuleName & "]", C_MODULE_NAME, LogMsgType.INFO
                On Error GoTo 0
            End If
        Else
            FuncLogIt sFuncName, "skipping [" & sFile & "] as in ignore list", C_MODULE_NAME, LogMsgType.INFO
        End If
    Next sFile
    ImportModules = iCount
    
End Function
Function GetProcsInModules(wb As Workbook, Optional sModuleName As String, _
            Optional bTestsOnly As Boolean = False) As Dictionary
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim vModuleNames() As String
Dim iCount As Integer
ReDim vModuleNames(0 To 100)
Dim sFuncName As String
Dim dProc As New Dictionary
Dim dDetails As Dictionary
Dim iNumProcs As Integer
Dim sProcName As String
Dim sModName As Variant
Dim sComments As String

setup:
    sFuncName = "GetProcsInModules"

main:

    If sModuleName <> "" Then
        vModuleNames = InitStringArray(Array(sModuleName))
    Else
        vModuleNames = GetModules(wb)
    End If
    
    For Each sModName In vModuleNames
        Set VBComp = GetModule(wb, CStr(sModName))
        
        For i = 1 To VBComp.CodeModule.CountOfLines
            sProcName = VBComp.CodeModule.ProcOfLine(i, vbext_pk_Proc)
            
            If bTestsOnly = True And Left(sProcName, 4) <> "Test" Then
                GoTo nextproc
            End If
                
            If sProcName = BLANK Then
                ' pass
            ElseIf VBComp.CodeModule.Lines(i, 1) <> BLANK Then ' official start of proc can be blank line above the proc
                If dProc.Exists(sProcName) = False Then
                    Set dDetails = New Dictionary
                    dDetails.Add "ModuleName", sModName
                    dDetails.Add "FirstLine", i
                    dDetails.Add "Args", VBComp.CodeModule.Lines(i, 1)
                    'dDetails.Add "BodyLine", VBComp.CodeModule.ProcBodyLine(sProcName, vbext_pk_Proc)
                    dDetails.Add "VBComp", VBComp
                    dDetails.Add "CodeModule", VBComp.CodeModule
                    dProc.Add sProcName, dDetails
                End If
            End If
nextproc:
        Next i
    Next sModName
    
    Set GetProcsInModules = dProc
    
End Function

Public Function GetProcAnalysis(wb As Workbook, dProc As Dictionary) As Dictionary
Dim sProcName As Variant
Dim sModuleName As String
Dim VBComp As VBIDE.VBComponent
Dim VBCodeModule As VBIDE.CodeModule
Dim iLineNum As Integer
Dim sComments As String
Dim dDetail As Dictionary

    For Each sProcName In dProc.Keys
        sComments = ""
        Set dDetail = dProc.Item(sProcName)
        sProcName = Replace(sProcName, SPACE, BLANK)
        sModuleName = Replace(dDetail.Item("ModuleName"), SPACE, BLANK)

        Set VBCodeModule = dDetail.Item("CodeModule")

        
        For iLineNum = dDetail.Item("FirstLine") To dDetail.Item("FirstLine") + 10
            If Left(VBCodeModule.Lines(iLineNum, 1), 1) = QUOTE Then
                If sComments = BLANK Then
                    sComments = VBCodeModule.Lines(iLineNum, 1)
                Else
                    sComments = vbCrLf & VBCodeModule.Lines(iLineNum, 1)

                End If
            Else
                ' we assume there are no comments after a non comment line
                ' even if its the first tested line
                GoTo nextilinenum
            End If

nextilinenum:
        Next iLineNum
        
    dDetail.Add "Comments", sComments
    dProc.Remove sProcName
    dProc.Add sProcName, dDetail

    Next sProcName
    

    Set GetProcAnalysis = dProc
End Function
Function GetModules(wb As Workbook) As String()
Dim VBProj As VBIDE.VBProject
Dim VBComp As VBIDE.VBComponent
Dim vModuleNames() As String
Dim iCount As Integer

setup:
    sFuncName = "GetModules"
    ReDim vModuleNames(0 To 100)

main:

    Set VBProj = wb.VBProject
    For Each VBComp In VBProj.VBComponents
        vModuleNames(iCount) = VBComp.Name
        iCount = iCount + 1
    Next VBComp

    ReDim Preserve vModuleNames(0 To iCount - 1)
    
    GetModules = vModuleNames
End Function
