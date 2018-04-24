VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Quad_Runtime"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Const C_MODULE_NAME = "Quad_Runtime"

Private pBookPath As String
Private pBookName As String
Private pBook As Workbook

Private pCacheBookName As String
Private pCacheBookPath As String
Private pCacheRangeName As String
Private pCacheBook As Workbook

Private pTemplateBookPath As String
Private pTemplateBookName As String
Private pTemplateSheetName As String
Private pTemplateCellSheetName As String
Private pTemplateBook As Workbook
Private pTemplateSheet As Worksheet
Private pTemplateCellSheet As Worksheet

Private pScheduleBook As Workbook
Private pScheduleBookPath As String
Private pScheduleBookName As String

Private pEntryBook As Workbook
Private pEntryBookPath As String
Private pEntryBookName As String

Private pDatabasePath As String
Private pResultFileName As String

Private pExecPath As String
Private pRuntimeDir As String
Private pFileName As String
Private pDayEnum As String
Private pPeriodEnum As String

Private pCurrentSheetSource As Variant
Private pCurrentSheetColumns As Variant

Private pQuadRuntimeCacheFile As Object
Private pQuadRuntimeCacheFileName As String
Private pQuadRuntimeCacheFileArray() As String

Private pDefinitionSheetName As String

Private pWindowSettings As Quad_WindowSettings

Private cHomeDir As String
Private cAppDir As String
Private cExecPath  As String
Private cRuntimeDir  As String
Private cBookPath As String
Private cBookName As String
Private cNewBookPath As String
Private cCacheBookName  As String
Private cCacheBookPath  As String
Private cCacheRangeName  As String
Private cTemplateBookPath  As String
Private cTemplateBookName As String
Private cTemplateSheetName  As String
Private cTemplateCellSheetName  As String
Private cScheduleBookPath As String
Private cScheduleBookName As String
Private cEntryBookPath As String
Private cEntryBookName As String
Private cDefinitionSheetName   As String
Private cDatabasePath  As String
Private cResultFileName  As String
Private cFileName  As String
Private cQuadRuntimeEnum  As String
Private cDayEnum  As String
Private cPeriodEnum  As String
Private cQuadRuntimeCacheFileName  As String

' Book -----------------------
Public Property Get Book() As Workbook
    Set Book = pBook
End Property
Public Property Let Book(value As Workbook)
    Set pBook = value
End Property
Public Property Get BookPath() As String
    BookPath = pBookPath
End Property
Public Property Let BookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "BookPath"
    sConstValue = cBookPath
    
main:
    pBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get BookName() As String
    BookName = pBookName
End Property
Public Property Let BookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "BookName"
    sConstValue = cBookName

main:

    pBookName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If Me.BookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="BookPath needs to be set before BookName"
    End If
    
    If FileExists(Me.BookPath & "\\" & pBookName) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="BookName file does not exist [" & value & "]"
    End If
    
    Me.Book = OpenBook(pBookName, sPath:=Me.BookPath)
    
End Property
'END Book ----------------------


' Cache ----------------------
Public Property Get CacheBook() As Workbook
    Set CacheBook = pCacheBook
End Property
Public Property Let CacheBook(value As Workbook)
    Set pCacheBook = value
End Property

Public Property Get CacheBookPath() As String
    CacheBookPath = pCacheBookPath
End Property
Public Property Let CacheBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "CacheBookPath"
    sConstValue = cCacheBookPath
    
    'If DirExists(value) <> True Then
    '     err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    'End If
    
    pCacheBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    'If DirExists(value) <> True Then
    '     err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    'End If
    

End Property
Public Property Get CacheBookName() As String
    
    CacheBookName = pCacheBookName
End Property
Public Property Let CacheBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "CacheBookName"
    sConstValue = cCacheBookName
    
    'If Me.CacheBookPath = "" Then
    '     err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="CacheBookPath needs to be set before CacheBookName"
    'End If
    
    'If FileExists(Me.CacheBookPath & "\\" & value) = False Then
    '    err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="CacheBookName file does not exist [" & value & "]"
    'End If
    pCacheBookName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    'Me.CacheBook = OpenBook(Me.CacheBookName, sPath:=Me.CacheBookPath)
    
End Property
Public Property Get CacheRangeName() As String
    CacheRangeName = pCacheRangeName
End Property
Public Property Let CacheRangeName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "CacheRangeName"
    sConstValue = cCacheRangeName
    
    pCacheRangeName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If Me.CacheBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="CacheBookName needs to be set before CacheBookRangeName"
    End If
    
    
    
End Property
' END Cache ------------------

' Template ----------------------
Public Property Get TemplateSheet() As Worksheet
    Set TemplateSheet = pTemplateSheet
End Property
Public Property Let TemplateSheet(value As Worksheet)
    Set pTemplateSheet = value
End Property
Public Property Get TemplateCellSheet() As Worksheet
    Set TemplateCellSheet = pTemplateCellSheet
End Property
Public Property Let TemplateCellSheet(value As Worksheet)
    Set pTemplateCellSheet = value
End Property
Public Property Get TemplateBook() As Workbook
    Set TemplateBook = pTemplateBook
End Property
Public Property Let TemplateBook(value As Workbook)
    Set pTemplateBook = value
End Property
Public Property Get TemplateBookPath() As String
    TemplateBookPath = pTemplateBookPath
End Property
Public Property Let TemplateBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateBookPath"
    sConstValue = cTemplateBookPath
    
    pTemplateBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    

End Property
Public Property Get TemplateBookName() As String
    
    TemplateBookName = pTemplateBookName
End Property
Public Property Let TemplateBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateBookName"
    sConstValue = cTemplateBookName
    
    pTemplateBookName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If Me.TemplateBookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookPath needs to be set before CacheBookName"
    End If
    
    If FileExists(Me.TemplateBookPath & "\\" & value) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="TemplateBookName file does not exist [" & value & "]"
    End If
    
    
    Me.TemplateBook = OpenBook(Me.TemplateBookName, sPath:=Me.TemplateBookPath)
    
End Property
Public Property Get TemplateSheetName() As String
    TemplateSheetName = pTemplateSheetName
End Property
Public Property Let TemplateSheetName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateSheetName"
    sConstValue = cTemplateSheetName
    
    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateSheetName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    Me.TemplateSheet = GetSheet(Me.TemplateBook, TemplateSheetName)
    
End Property
Public Property Get TemplateCellSheetName() As String
    TemplateCellSheetName = pTemplateCellSheetName
End Property
Public Property Let TemplateCellSheetName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateCellSheetName"
    sConstValue = cTemplateCellSheetName
    
    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateCellSheetName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    Me.TemplateCellSheet = GetSheet(Me.TemplateBook, TemplateCellSheetName)
    
End Property
' END Template ------------------

' Schedule -----------------------------------------
Public Property Get ScheduleBook() As Workbook
    Set ScheduleBook = pScheduleBook
End Property
Public Property Let ScheduleBook(value As Workbook)
    Set pScheduleBook = value
End Property
Public Property Get ScheduleBookPath() As String
    ScheduleBookPath = pScheduleBookPath
End Property
Public Property Let ScheduleBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "ScheduleBookPath"
    sConstValue = cScheduleBookPath
    
    pScheduleBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get ScheduleBookName() As String
    
    ScheduleBookName = pScheduleBookName
End Property
Public Property Let ScheduleBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "ScheduleBookName"
    sConstValue = cScheduleBookName
    
    pScheduleBookName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
' END schedule -------------------------------------

' Entry -----------------------------------------
Public Property Get EntryBook() As Workbook
    Set EntryBook = pEntryBook
End Property
Public Property Let EntryBook(value As Workbook)
    Set pEntryBook = value
End Property
Public Property Get EntryBookPath() As String
    EntryBookPath = pEntryBookPath
End Property
Public Property Let EntryBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "EntryBookPath"
    sConstValue = cEntryBookPath
    
    pEntryBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get EntryBookName() As String
    
    EntryBookName = pEntryBookName
End Property
Public Property Let EntryBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "EntryBookName"
    sConstValue = cEntryBookName
    
    pEntryBookName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
' END Entry -------------------------------------

' misc ---------------------------------------------
Public Property Get DayEnum() As String
    DayEnum = pDayEnum
End Property
Public Property Let DayEnum(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "DayEnum"
    sConstValue = cDayEnum
main:
    pDayEnum = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
Public Property Get PeriodEnum() As String
    PeriodEnum = pPeriodEnum
End Property
Public Property Let PeriodEnum(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "PeriodEnum"
    sConstValue = cPeriodEnum
main:
    pPeriodEnum = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
Public Property Get DefinitionSheetName() As String
    DefinitionSheetName = pDefinitionSheetName
End Property
Public Property Let DefinitionSheetName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "DefinitionSheetName"
    sConstValue = cDefinitionSheetName
    
main:
    pDefinitionSheetName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
Public Property Get FileName() As String
    FileName = pFileName
End Property
Public Property Let FileName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "FileName"
    sConstValue = cFileName
    
    pFileName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If FileExists(value) = False Then
        FuncLogIt "Let_FileName", "file currently does not exist to [" & value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    
End Property
Public Property Get DatabasePath() As String
    DatabasePath = pDatabasePath
End Property
Public Property Let DatabasePath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String

setup:
    sFuncName = "DatabasePath"
    sConstValue = cDatabasePath
    
    pDatabasePath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If Right(pDatabasePath, 6) <> ".sqlite" Then
        sTmpValue = pDatabasePath & ".sqlite"
    End If
    
    If FileExists(sTmpValue) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="Database file does not exist [" & pDatabasePath & "]"
    End If
main:

End Property
Public Property Get ResultFileName() As String
    ResultFileName = pResultFileName
End Property
Public Property Let ResultFileName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "ResultFileName"
    sConstValue = cResultFileName
    
    pResultFileName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If FileExists(pResultFileName) = False Then
        FuncLogIt "Let_ResultFileName", "file currently does not exist to [" & value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    
End Property
Public Property Get QuadRuntimeCacheFileName() As String
    QuadRuntimeCacheFileName = pQuadRuntimeCacheFileName
End Property
Public Property Let QuadRuntimeCacheFileName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "QuadRuntimeCacheFileName"
    sConstValue = cQuadRuntimeCacheFileName
main:
    pQuadRuntimeCacheFileName = GetUpdatedValue(sFuncName, sConstValue, value)
    
End Property
Public Property Get QuadRuntimeCacheFile() As Object
    Set QuadRuntimeCacheFile = pQuadRuntimeCacheFile
End Property
Public Property Let QuadRuntimeCacheFile(value As Object)
    Set pQuadRuntimeCacheFile = value
End Property
' END Misc -------------------------------------------

' runtime variables ----------------------------------
Public Property Get CurrentSheetSource() As Variant
    CurrentSheetSource = pCurrentSheetSource
End Property
Public Property Let CurrentSheetSource(value As Variant)
    pCurrentSheetSource = value
End Property
Public Property Get CurrentSheetColumns() As Variant
    CurrentSheetColumns = pCurrentSheetColumns
End Property
Public Property Let CurrentSheetColumns(value As Variant)
    pCurrentSheetColumns = value
End Property
' END runtime variables

' default directories
Public Property Get RuntimeDir() As String
    RuntimeDir = pRuntimeDir
End Property
Public Property Let RuntimeDir(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "RuntimeDir"
    sConstValue = cRuntimeDir
    
    pRuntimeDir = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) = False Then
        FuncLogIt "Let_RuntimeDir", "file currently does not exist to [" & value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    

End Property
Public Property Get ExecPath() As String
    ExecPath = pExecPath
End Property
Public Property Let ExecPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "ExecPath"
    sConstValue = cExecPath
    
    pExecPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) = False Then
        FuncLogIt "Let_ExecPath", "file currently does not exist to [" & value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    

End Property
' END default directories


Function GetUpdatedValue(sFuncName As String, sConstValue As String, value As String) As Variant
'<<<
' purpose: parses passed value, with default (stored as Const) and any prev update retreived from
'        : from cache to calc current value (cached val > passed arg > default const val)
' param  : sFuncName, String
' param  : sConstValue, String
' param  : Value, String
' returns: value to set member attr to , variant
'>>>
Dim sCachedValue As String, sOrigValue As String

    sCachedValue = RetreiveOverride(sFuncName)
    If sCachedValue <> " " Then
        sOrigValue = value
        value = sCachedValue
        FuncLogIt "Let_" & sFuncName, "retreived value from overide cache file to [" & sCachedValue & "] instead of [" & sOrigValue & "]", C_MODULE_NAME, LogMsgType.INFO
    Else
        If value = "" Then
            'using default value
            value = sConstValue
        ElseIf value <> sConstValue Then
            FuncLogIt "Let_" & sFuncName, "overidden to [" & value & "] default was [" & sConstValue & "]", C_MODULE_NAME, LogMsgType.INFO
            PersistOverride sFuncName, value
        End If
    End If
    
    GetUpdatedValue = value
End Function

Function GetAttrEnum(sAttrName As String) As Integer
    GetAttrEnum = IndexArray(Split(cQuadRuntimeEnum, COMMA), sAttrName)
    If GetAttrEnum = -1 Then
        err.Raise ErrorMsgType.BAD_ENUM, Description:="value [" & sAttrName & "] is not a member of enum [cQuadRuntimeEnum]"
    End If
End Function

Public Property Get QuadRuntimeCacheFileArray() As String()
    QuadRuntimeCacheFileArray = pQuadRuntimeCacheFileArray
End Property
Public Property Let QuadRuntimeCacheFileArray(value() As String)
    pQuadRuntimeCacheFileArray = value
End Property


Sub PersistOverride(sFuncName As String, sValue As String)
Dim iRow As Integer
Dim vCurrentState() As String
Dim sCurrentValue As String

    iRow = GetAttrEnum(sFuncName)
    vCurrentState = ReadFile2Array(Me.QuadRuntimeCacheFileName, bSingleCol:=True)
    sCurrentValue = vCurrentState(iRow)
    vCurrentState(iRow) = sValue
    WriteArray2File vCurrentState, Me.QuadRuntimeCacheFileName

    FuncLogIt "PersistOverride", "updated QuadRuntime persist file [" & Me.QuadRuntimeCacheFileName & "] for [" & sFuncName & "] from [" & sCurrentValue & "] to [" & sValue & "]", C_MODULE_NAME, LogMsgType.INFO

End Sub

'write some tests for this
'then put into each Letter
'then create a rehydrate option for QuadRuntime
'then call rehydrate from validate
Function RetreiveOverride(sFuncName As String) As String
Dim iRow As Integer
Dim vResults() As String

    iRow = GetAttrEnum(sFuncName)
    vResults = Me.QuadRuntimeCacheFileArray
    RetreiveOverride = vResults(iRow)
End Function

Sub InitOveride(Optional bRecover As Boolean = True)
Dim vResults() As String
'purpose: if bRecover is True, parse and store cache file contents, otherwise
'       : initialize; each Let'er will use cached value if not explicitly overidden
    
    If bRecover = False Then
        Me.QuadRuntimeCacheFile = InitFileArray(cQuadRuntimeCacheFileName, 30)
    End If
    
    If FileExists(cQuadRuntimeCacheFileName) = False Then
        Me.QuadRuntimeCacheFile = InitFileArray(cQuadRuntimeCacheFileName, 30)
    Else
        'Me.QuadRuntimeCacheFile = OpenFile(cQuadRuntimeCacheFileName, 8)
    End If

    vResults = ReadFile2Array(cQuadRuntimeCacheFileName, bSingleCol:=True)
    Me.QuadRuntimeCacheFileArray = vResults

End Sub
Public Function IsAQuadRuntime() As Boolean
    IsAQuadRuntime = True
End Function

Sub SetDefaults()
    cHomeDir = GetHomePath
    cAppDir = cHomeDir & "\GitHub\quadviewer\"
    cExecPath = cAppDir & "app\\quad\utils\excel\"
    cRuntimeDir = cHomeDir & "\runtime\"
    cBookPath = cRuntimeDir
    cBookName = "cache.xlsm"
    cCacheBookName = "cache.xlsm"
    cCacheBookPath = cRuntimeDir
    cCacheRangeName = "data"
    cNewBookPath = cRuntimeDir & "archive\"
    
    cTemplateBookPath = cAppDir
    cTemplateBookName = "vba_source_new.xlsm"

    cTemplateSheetName = "FormStyles"
    cTemplateCellSheetName = "CellStyles"
    cScheduleBookPath = cRuntimeDir
    cScheduleBookName = "schedule.xlsm"
    
    cEntryBookPath = cRuntimeDir
    cEntryBookName = "entry.xlsm"
    
    cDefinitionSheetName = "Definitions"
    cDatabasePath = cAppDir & "app\quad\utils\excel\test_misc\QuadQA.db"
    cResultFileName = cRuntimeDir & "pyshell_results.txt"
    cFileName = cRuntimeDir & "uupyshell.args.txt"
    cQuadRuntimeEnum = "BookPath,BookName,CacheBookName,CacheBookPath,CacheRangeName,TemplateBookPath,TemplateBookName,TemplateSheetName,TemplateCellSheetName,DatabasePath,ResultFileName,ExecPath,RuntimeDir,FileName,DayEnum,PeriodEnum,CurrentSheetSource,CurrentSheetColumns,QuadRuntimeCacheFileName,DefinitionSheetName,ScheduleBookPath,ScheduleBookName,EntryBookPath,EntryBookName"
    cDayEnum = "M,T,W,R,F"
    cPeriodEnum = "1,2,3,4,5,6,7,8,9,10,11"
    cQuadRuntimeCacheFileName = cHomeDir & "\quad_runtime_cache.txt"
End Sub

Sub SetWindows()
Dim vWindowNames As Variant, vWindow As Variant
Dim vWindowCol1() As String, vWindowCol2() As String
Dim winsetTmp As Quad_WindowSettings
Dim dWindows As New Dictionary
Dim sBookName As Variant

    ReDim vWindowCol1(0 To 1)
    ReDim vWindowCol2(0 To 1)
    ReDim vWindow(0 To 1)
    
    vWindowNames = Array(Me.BookName, Me.ScheduleBookName, Me.CacheBookName, Me.EntryBookName)
    
    For Each sBookName In vWindowNames
        Set winsetTmp = New Quad_WindowSettings
        winsetTmp.InitProperties
        If dWindows.Exists(sBookName) = False Then
            dWindows.Add sBookName, winsetTmp
        End If
    Next sBookName
    
    vWindowCol1(0) = Me.BookName
    vWindowCol1(1) = Me.ScheduleBookName
    vWindowCol2(0) = Me.CacheBookName
    vWindowCol2(1) = Me.EntryBookName
    vWindow(0) = vWindowCol1 'row 1
    vWindow(1) = vWindowCol2 'row 1
    
    SetWindowScheme dWindows, vWindow
End Sub
    
Public Sub InitProperties( _
                 Optional sBookPath As String, _
                 Optional sBookName As String, _
                 Optional sCacheBookPath As String, _
                 Optional sCacheBookName As String, _
                 Optional sCacheRangeName As String, _
                 Optional sTemplateBookPath As String, Optional sTemplateBookName As String, _
                 Optional sTemplateSheetName As String, Optional sTemplateCellSheetName As String, _
                 Optional sScheduleBookPath As String, Optional sScheduleBookName As String, _
                 Optional sEntryBookPath As String, Optional sEntryBookName As String, _
                 Optional sDatabasePath As String, _
                 Optional sResultFileName As String, _
                 Optional sExecPath As String, _
                 Optional sRuntimeDir As String, _
                 Optional sFileName As String, _
                 Optional sDayEnum As String, _
                 Optional sPeriodEnum As String, _
                 Optional sDefinitionSheetName As String, _
                 Optional sQuadRuntimeCacheFileName As String, _
                 Optional bInitializeCache As Boolean = True, _
                 Optional bInitializeOveride As Boolean = True, _
                 Optional bHydrateFromCache As Boolean = False, _
                 Optional bSetWindows = False)

    SetDefaults
    
    If bInitializeOveride = True Then
        Me.InitOveride
    End If
    
    Me.QuadRuntimeCacheFileName = sQuadRuntimeCacheFileName
    
    Me.CacheBookPath = sCacheBookPath
    Me.CacheBookName = sCacheBookName
    Me.CacheRangeName = sCacheRangeName
    Me.ScheduleBookPath = sScheduleBookPath
    Me.ScheduleBookName = sScheduleBookName
    Me.EntryBookPath = sEntryBookPath
    Me.EntryBookName = sEntryBookName
    
    If bInitializeCache = True Then
        FileCopy cCacheBookName, cNewBookPath, cRuntimeDir
        FileCopy cScheduleBookName, cNewBookPath, cRuntimeDir
        FileCopy cEntryBookName, cNewBookPath, cRuntimeDir
    Else
        If BookExists(Me.CacheBookPath & "\" & Me.CacheBookName) = False Then
            FileCopy cCacheBookName, cNewBookPath, cRuntimeDir
            FileCopy cScheduleBookName, cNewBookPath, cRuntimeDir
            FileCopy cEntryBookName, cNewBookPath, cRuntimeDir
        End If
    End If
    
    Me.CacheBook = OpenBook(Me.CacheBookName, sPath:=Me.CacheBookPath)
    Me.ScheduleBook = OpenBook(Me.ScheduleBookName, sPath:=Me.ScheduleBookPath)
    Me.EntryBook = OpenBook(Me.EntryBookName, sPath:=Me.EntryBookPath)
    
    Me.BookPath = sBookPath
    Me.BookName = sBookName

    Me.TemplateBookPath = sTemplateBookPath
    Me.TemplateBookName = sTemplateBookName
    Me.TemplateSheetName = sTemplateSheetName
    Me.TemplateCellSheetName = sTemplateCellSheetName
    
    Me.DefinitionSheetName = sDefinitionSheetName
    
    Me.DatabasePath = sDatabasePath
    Me.ResultFileName = sResultFileName
    Me.ExecPath = sExecPath
    Me.RuntimeDir = sRuntimeDir
    Me.FileName = sFileName
    Me.DayEnum = sDayEnum
    Me.PeriodEnum = sPeriodEnum
    
    If bSetWindows = True Then
        SetWindows
    End If
    
    ' added on 4/17/18 to get dynamic menus to work
    Me.TemplateBook.Activate

End Sub

Public Sub CloseRuntimeCacheFile()
Dim oFile As Object
    Set oFile = Me.QuadRuntimeCacheFile
    On Error Resume Next
    oFile.Close
    On Error GoTo 0
End Sub
Public Sub CleanUpTmpBooks()
    CloseBook Me.CacheBook
    DeleteBook Me.CacheBookName, Me.CacheBookPath
    CloseBook Me.ScheduleBook
    DeleteBook Me.ScheduleBookName, Me.ScheduleBookPath
    CloseBook Me.EntryBook
    DeleteBook Me.EntryBookName, Me.EntryBookPath
End Sub
Public Sub Delete()
    Me.CloseRuntimeCacheFile
    DeleteFile Me.QuadRuntimeCacheFileName
    Me.CleanUpTmpBooks
End Sub



