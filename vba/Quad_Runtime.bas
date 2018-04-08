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

Private pDatabasePath As String
Private pResultFileName As String

Private pExecPath As String
Private pRuntimeDir As String
Private pFileName As String
Private pDayEnum As String

Private pCurrentSheetSource As Variant
Private pCurrentSheetColumns As Variant

Private pQuadRuntimeCacheFile As Object
Private pQuadRuntimeCacheFileName As String
Private pQuadRuntimeCacheFileArray() As String

Private pDefinitionSheetName As String

Const cAppDir = "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\"
Const cExecPath = cAppDir & "app\\quad\\utils\\excel\\"
Const cRuntimeDir = "C:\\Users\\burtnolej\\Documents\\runtime\\"

Const cBookPath = cRuntimeDir
Const cBookName = "cache.xlsm"

Const cCacheBookName = "cache.xlsm"
Const cCacheBookPath = cRuntimeDir
Const cCacheRangeName = "data"

Const cTemplateBookPath = cAppDir
Const cTemplateBookName = "vba_source_new.xlsm"
Const cTemplateSheetName = "FormStyles"
Const cTemplateCellSheetName = "CellStyles"

Const cDefinitionSheetName = "Definitions"

Const cDatabasePath = cAppDir & "app\\quad\\utils\\excel\\test_misc\\QuadQA.db"
Const cResultFileName = cRuntimeDir & "pyshell_results.txt"
Const cFileName = cRuntimeDir & "uupyshell.args.txt"
Const cQuadRuntimeEnum = "BookPath,BookName,CacheBookName,CacheBookPath,CacheRangeName,TemplateBookPath,TemplateBookName,TemplateSheetName,TemplateCellSheetName,DatabasePath,ResultFileName,ExecPath,RuntimeDir,FileName,DayEnum,CurrentSheetSource,CurrentSheetColumns,QuadRuntimeCacheFileName,DefinitionSheetName"

Const cDayEnum = "M,T,W,R,F"
Const cQuadRuntimeCacheFileName = "C:\\Users\\burtnolej\\quad_runtime_cache.txt"

' Book -----------------------
Public Property Get Book() As Workbook
    Set Book = pBook
End Property
Public Property Let Book(Value As Workbook)
    Set pBook = Value
End Property
Public Property Get BookPath() As String
    BookPath = pBookPath
End Property
Public Property Let BookPath(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "BookPath"
    sConstValue = cBookPath
    
main:
    If DirExists(Value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & Value & "] does not exist"
    End If
    
    pBookPath = GetUpdatedValue(sFuncName, sConstValue, Value)
    
End Property
Public Property Get BookName() As String
    BookName = pBookName
End Property
Public Property Let BookName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "BookName"
    sConstValue = cBookName

main:
    If Me.BookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="BookPath needs to be set before BookName"
    End If
    
    pBookName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
    If FileExists(Me.BookPath & "\\" & pBookName) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="BookName file does not exist [" & Value & "]"
    End If
    
    Me.Book = OpenBook(pBookName, sPath:=Me.BookPath)
    
End Property
'END Book ----------------------


' Cache ----------------------
Public Property Get CacheBook() As Workbook
    Set CacheBook = pCacheBook
End Property
Public Property Let CacheBook(Value As Workbook)
    Set pCacheBook = Value
End Property

Public Property Get CacheBookPath() As String
    CacheBookPath = pCacheBookPath
End Property
Public Property Let CacheBookPath(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "CacheBookPath"
    sConstValue = cCacheBookPath
    
    If DirExists(Value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & Value & "] does not exist"
    End If
    
    pCacheBookPath = GetUpdatedValue(sFuncName, sConstValue, Value)

End Property
Public Property Get CacheBookName() As String
    
    CacheBookName = pCacheBookName
End Property
Public Property Let CacheBookName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "CacheBookName"
    sConstValue = cCacheBookName
    
    If Me.CacheBookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="CacheBookPath needs to be set before CacheBookName"
    End If
    
    If FileExists(Me.CacheBookPath & "\\" & Value) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="CacheBookName file does not exist [" & Value & "]"
    End If
    pCacheBookName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
    Me.CacheBook = OpenBook(Me.CacheBookName, sPath:=Me.CacheBookPath)
    
End Property
Public Property Get CacheRangeName() As String
    CacheRangeName = pCacheRangeName
End Property
Public Property Let CacheRangeName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "CacheRangeName"
    sConstValue = cCacheRangeName
    
    If Me.CacheBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="CacheBookName needs to be set before CacheBookRangeName"
    End If
    
    pCacheRangeName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
End Property
' END Cache ------------------

' Template ----------------------
Public Property Get TemplateSheet() As Worksheet
    Set TemplateSheet = pTemplateSheet
End Property
Public Property Let TemplateSheet(Value As Worksheet)
    Set pTemplateSheet = Value
End Property
Public Property Get TemplateCellSheet() As Worksheet
    Set TemplateCellSheet = pTemplateCellSheet
End Property
Public Property Let TemplateCellSheet(Value As Worksheet)
    Set pTemplateCellSheet = Value
End Property
Public Property Get TemplateBook() As Workbook
    Set TemplateBook = pTemplateBook
End Property
Public Property Let TemplateBook(Value As Workbook)
    Set pTemplateBook = Value
End Property
Public Property Get TemplateBookPath() As String
    TemplateBookPath = pTemplateBookPath
End Property
Public Property Let TemplateBookPath(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateBookPath"
    sConstValue = cTemplateBookPath
    
    If DirExists(Value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & Value & "] does not exist"
    End If
    pTemplateBookPath = GetUpdatedValue(sFuncName, sConstValue, Value)

End Property
Public Property Get TemplateBookName() As String
    
    TemplateBookName = pTemplateBookName
End Property
Public Property Let TemplateBookName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateBookName"
    sConstValue = cTemplateBookName
    
    If Me.TemplateBookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookPath needs to be set before CacheBookName"
    End If
    
    If FileExists(Me.TemplateBookPath & "\\" & Value) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="TemplateBookName file does not exist [" & Value & "]"
    End If
    pTemplateBookName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
    Me.TemplateBook = OpenBook(Me.TemplateBookName, sPath:=Me.TemplateBookPath)
    
End Property
Public Property Get TemplateSheetName() As String
    TemplateSheetName = pTemplateSheetName
End Property
Public Property Let TemplateSheetName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateSheetName"
    sConstValue = cTemplateSheetName
    
    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateSheetName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
    Me.TemplateSheet = GetSheet(Me.TemplateBook, TemplateSheetName)
    
End Property
Public Property Get TemplateCellSheetName() As String
    TemplateCellSheetName = pTemplateCellSheetName
End Property
Public Property Let TemplateCellSheetName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "TemplateCellSheetName"
    sConstValue = cTemplateCellSheetName
    
    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateCellSheetName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
    Me.TemplateCellSheet = GetSheet(Me.TemplateBook, TemplateCellSheetName)
    
End Property
' END Template ------------------

' misc ---------------------------------------------
Public Property Get DayEnum() As String
    DayEnum = pDayEnum
End Property
Public Property Let DayEnum(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "DayEnum"
    sConstValue = cDayEnum
main:
    pDayEnum = GetUpdatedValue(sFuncName, sConstValue, Value)
End Property
Public Property Get DefinitionSheetName() As String
    DefinitionSheetName = pDefinitionSheetName
End Property
Public Property Let DefinitionSheetName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "DefinitionSheetName"
    sConstValue = cDefinitionSheetName
    
main:
    pDefinitionSheetName = GetUpdatedValue(sFuncName, sConstValue, Value)
End Property
Public Property Get FileName() As String
    FileName = pFileName
End Property
Public Property Let FileName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "FileName"
    sConstValue = cFileName
    
    If FileExists(Value) = False Then
        FuncLogIt "Let_FileName", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    pFileName = GetUpdatedValue(sFuncName, sConstValue, Value)
End Property
Public Property Get DatabasePath() As String
    DatabasePath = pDatabasePath
End Property
Public Property Let DatabasePath(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String

setup:
    sFuncName = "DatabasePath"
    sConstValue = cDatabasePath
    If Right(Value, 6) <> ".sqlite" Then
        sTmpValue = Value & ".sqlite"
    End If
    If FileExists(sTmpValue) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="Database file does not exist [" & Value & "]"
    End If
main:
    pDatabasePath = GetUpdatedValue(sFuncName, sConstValue, Value)

End Property
Public Property Get ResultFileName() As String
    ResultFileName = pResultFileName
End Property
Public Property Let ResultFileName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "ResultFileName"
    sConstValue = cResultFileName
    If FileExists(Value) = False Then
        FuncLogIt "Let_ResultFileName", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    pResultFileName = GetUpdatedValue(sFuncName, sConstValue, Value)
End Property
Public Property Get QuadRuntimeCacheFileName() As String
    QuadRuntimeCacheFileName = pQuadRuntimeCacheFileName
End Property
Public Property Let QuadRuntimeCacheFileName(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "QuadRuntimeCacheFileName"
    sConstValue = cQuadRuntimeCacheFileName
main:
    pQuadRuntimeCacheFileName = GetUpdatedValue(sFuncName, sConstValue, Value)
    
End Property
Public Property Get QuadRuntimeCacheFile() As Object
    Set QuadRuntimeCacheFile = pQuadRuntimeCacheFile
End Property
Public Property Let QuadRuntimeCacheFile(Value As Object)
    Set pQuadRuntimeCacheFile = Value
End Property
' END Misc -------------------------------------------

' runtime variables ----------------------------------
Public Property Get CurrentSheetSource() As Variant
    CurrentSheetSource = pCurrentSheetSource
End Property
Public Property Let CurrentSheetSource(Value As Variant)
    pCurrentSheetSource = Value
End Property
Public Property Get CurrentSheetColumns() As Variant
    CurrentSheetColumns = pCurrentSheetColumns
End Property
Public Property Let CurrentSheetColumns(Value As Variant)
    pCurrentSheetColumns = Value
End Property
' END runtime variables

' default directories
Public Property Get RuntimeDir() As String
    RuntimeDir = pRuntimeDir
End Property
Public Property Let RuntimeDir(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "RuntimeDir"
    sConstValue = cRuntimeDir
    
    If DirExists(Value) = False Then
        FuncLogIt "Let_RuntimeDir", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    pRuntimeDir = GetUpdatedValue(sFuncName, sConstValue, Value)

End Property
Public Property Get ExecPath() As String
    ExecPath = pExecPath
End Property
Public Property Let ExecPath(Value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = "ExecPath"
    sConstValue = cExecPath
    
    If DirExists(Value) = False Then
        FuncLogIt "Let_ExecPath", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    pExecPath = GetUpdatedValue(sFuncName, sConstValue, Value)

End Property
' END default directories


Function GetUpdatedValue(sFuncName As String, sConstValue As String, Value As String) As Variant
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
        sOrigValue = Value
        Value = sCachedValue
        FuncLogIt "Let_" & sFuncName, "retreived value from overide cache file to [" & sCachedValue & "] instead of [" & sOrigValue & "]", C_MODULE_NAME, LogMsgType.INFO
    Else
        If Value <> sConstValue Then
            FuncLogIt "Let_" & sFuncName, "overidden to [" & Value & "] default was [" & sConstValue & "]", C_MODULE_NAME, LogMsgType.INFO
            PersistOverride sFuncName, Value
        End If
    End If
    
    GetUpdatedValue = Value
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
Public Property Let QuadRuntimeCacheFileArray(Value() As String)
    pQuadRuntimeCacheFileArray = Value
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
Public Sub InitProperties( _
                 Optional sBookPath As String = cBookPath, _
                 Optional sBookName As String = cBookName, _
                 Optional sCacheBookPath As String = cCacheBookPath, _
                 Optional sCacheBookName As String = cCacheBookName, _
                 Optional sCacheRangeName As String = cCacheRangeName, _
                 Optional sTemplateBookPath As String = cTemplateBookPath, _
                 Optional sTemplateBookName As String = cTemplateBookName, _
                 Optional sTemplateSheetName As String = cTemplateSheetName, _
                 Optional sTemplateCellSheetName As String = cTemplateCellSheetName, _
                 Optional sDatabasePath As String = cDatabasePath, _
                 Optional sResultFileName As String = cResultFileName, _
                 Optional sExecPath As String = cExecPath, _
                 Optional sRuntimeDir As String = cRuntimeDir, _
                 Optional sFilename As String = cFileName, _
                 Optional sDayEnum As String = cDayEnum, _
                 Optional sDefinitionSheetName As String = cDefinitionSheetName, _
                 Optional sQuadRuntimeCacheFileName As String = cQuadRuntimeCacheFileName, _
                 Optional bInitializeCache As Boolean = True, _
                 Optional bHydrateFromCache As Boolean = False)

    Me.InitOveride
    
    If bInitializeCache = True Then
        CreateBook sCacheBookName, sBookPath:=sCacheBookPath
    End If
    
    Me.QuadRuntimeCacheFileName = sQuadRuntimeCacheFileName
    
    Me.BookPath = sBookPath
    Me.BookName = sBookName
    
    Me.CacheBookPath = sCacheBookPath
    Me.CacheBookName = sCacheBookName
    Me.CacheRangeName = sCacheRangeName
    
    Me.TemplateBookPath = sTemplateBookPath
    Me.TemplateBookName = sTemplateBookName
    Me.TemplateSheetName = sTemplateSheetName
    Me.TemplateCellSheetName = sTemplateCellSheetName
    
    Me.DefinitionSheetName = sDefinitionSheetName
    
    Me.DatabasePath = sDatabasePath
    Me.ResultFileName = sResultFileName
    Me.ExecPath = sExecPath
    Me.RuntimeDir = sRuntimeDir
    Me.FileName = sFilename
    Me.DayEnum = sDayEnum

End Sub

Public Sub CloseRuntimeCacheFile()
Dim oFile As Object
    Set oFile = Me.QuadRuntimeCacheFile
    oFile.Close
End Sub
Public Sub Delete()
    Me.CloseRuntimeCacheFile
    DeleteFile Me.QuadRuntimeCacheFileName
End Sub



