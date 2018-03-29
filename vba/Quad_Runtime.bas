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

Const cAppDir = "C:\\Users\\burtnolej\\Documents\\GitHub\\quadviewer\\"
Const cExecPath = cAppDir & "app\\quad\\utils\\excel\\"
Const cRuntimeDir = "C:\\Users\\burtnolej\\Documents\\runtime\\"

'Const cBookPath = cAppDir
'Const cBookName = "vba_source_new.xlsm"

Const cBookPath = cRuntimeDir
Const cBookName = "cache.xlsm"

Const cCacheBookName = "cache.xlsm"
Const cCacheBookPath = cRuntimeDir
Const cCacheRangeName = "data"

Const cTemplateBookPath = cAppDir
Const cTemplateBookName = "vba_source_new.xlsm"
Const cTemplateSheetName = "FormStyles"
Const cTemplateCellSheetName = "CellStyles"

Const cDatabasePath = cAppDir & "app\\quad\\utils\\excel\\test_misc\\QuadQA.db"
Const cResultFileName = cRuntimeDir & "pyshell_results.txt"
Const cFileName = cRuntimeDir & "uupyshell.args.txt"

Const cDayEnum = "M,T,W,R,F"

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
    
    If DirExists(Value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & Value & "] does not exist"
    End If
    
    pBookPath = Value
    
    If Me.BookPath <> cBookPath Then
        FuncLogIt "Let_BookPath", "overidden to [" & Value & "] default was [" & cBookPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
End Property
Public Property Get BookName() As String
    BookName = pBookName
End Property
Public Property Let BookName(Value As String)

    If Me.BookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="BookPath needs to be set before BookName"
    End If
    
    If FileExists(Me.BookPath & "\\" & Value) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="BookName file does not exist [" & Value & "]"
    End If
    
    pBookName = Value
    
    If Me.BookName <> cBookName Then
        FuncLogIt "Let_BookName", "overidden to [" & Value & "] default was [" & cBookName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    Me.Book = OpenBook(Me.BookName, sPath:=Me.BookPath)
    
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
    If DirExists(Value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & Value & "] does not exist"
    End If
    pCacheBookPath = Value
    
    If Me.CacheBookPath <> cCacheBookPath Then
        FuncLogIt "Let_CacheBookPath", "overidden to [" & Value & "] default was [" & cCacheBookPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

End Property
Public Property Get CacheBookName() As String
    
    CacheBookName = pCacheBookName
End Property
Public Property Let CacheBookName(Value As String)

    If Me.CacheBookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="CacheBookPath needs to be set before CacheBookName"
    End If
    
    If FileExists(Me.CacheBookPath & "\\" & Value) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="CacheBookName file does not exist [" & Value & "]"
    End If
    pCacheBookName = Value
    
    
    If Me.CacheBookPath <> cCacheBookPath Then
        FuncLogIt "Let_CacheBookPath", "overidden to [" & Value & "] default was [" & CacheBookPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    Me.CacheBook = OpenBook(Me.CacheBookName, sPath:=Me.CacheBookPath)
    
End Property
Public Property Get CacheRangeName() As String
    CacheRangeName = pCacheRangeName
End Property
Public Property Let CacheRangeName(Value As String)

    If Me.CacheBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="CacheBookName needs to be set before CacheBookRangeName"
    End If
    
    pCacheRangeName = Value
    
    
    If Me.CacheRangeName <> cCacheRangeName Then
        FuncLogIt "Let_CacheRangeName", "overidden to [" & Value & "] default was [" & CacheRangeName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
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
    If DirExists(Value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & Value & "] does not exist"
    End If
    pTemplateBookPath = Value
    
    If Me.TemplateBookPath <> cTemplateBookPath Then
        FuncLogIt "Let_TemplateBookPath", "overidden to [" & Value & "] default was [" & cTemplateBookPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

End Property
Public Property Get TemplateBookName() As String
    
    TemplateBookName = pTemplateBookName
End Property
Public Property Let TemplateBookName(Value As String)

    If Me.TemplateBookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookPath needs to be set before CacheBookName"
    End If
    
    If FileExists(Me.TemplateBookPath & "\\" & Value) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="TemplateBookName file does not exist [" & Value & "]"
    End If
    pTemplateBookName = Value
    
    
    If Me.TemplateBookPath <> cTemplateBookPath Then
        FuncLogIt "Let_TemplateBookPath", "overidden to [" & Value & "] default was [" & cTemplateBookName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    Me.TemplateBook = OpenBook(Me.TemplateBookName, sPath:=Me.TemplateBookPath)
    
End Property
Public Property Get TemplateSheetName() As String
    TemplateSheetName = pTemplateSheetName
End Property
Public Property Let TemplateSheetName(Value As String)

    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateSheetName = Value
    
    If Me.TemplateSheetName <> cTemplateSheetName Then
        FuncLogIt "Let_TemplateSheetName", "overidden to [" & Value & "] default was [" & cTemplateSheetName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    Me.TemplateSheet = GetSheet(Me.TemplateBook, TemplateSheetName)
    
End Property
Public Property Get TemplateCellSheetName() As String
    TemplateCellSheetName = pTemplateCellSheetName
End Property
Public Property Let TemplateCellSheetName(Value As String)

    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateCellSheetName = Value
    
    If Me.TemplateCellSheetName <> cTemplateCellSheetName Then
        FuncLogIt "Let_TemplateCellSheetName", "overidden to [" & Value & "] default was [" & cTemplateCellSheetName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    Me.TemplateCellSheet = GetSheet(Me.TemplateBook, TemplateCellSheetName)
    
End Property
' END Template ------------------

' misc ---------------------------------------------
Public Property Get DayEnum() As String
    DayEnum = pDayEnum
End Property
Public Property Let DayEnum(Value As String)
    pDayEnum = Value
    If Me.DayEnum <> cDayEnum Then
        FuncLogIt "Let_DayEnum", "overidden to [" & Value & "] default was [" & cDayEnum & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Property
Public Property Get FileName() As String
    FileName = pFileName
End Property
Public Property Let FileName(Value As String)
    If FileExists(Value) = False Then
        FuncLogIt "Let_FileName", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

    pFileName = Value
    
    If Me.FileName <> cFileName Then
        FuncLogIt "Let_FileName", "overidden to [" & Value & "] default was [" & cFileName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Property
Public Property Get DatabasePath() As String
    DatabasePath = pDatabasePath
End Property
Public Property Let DatabasePath(Value As String)
Dim sTmpValue As String
    If Right(Value, 6) <> ".sqlite" Then
        sTmpValue = Value & ".sqlite"
    End If
    If FileExists(sTmpValue) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="Database file does not exist [" & Value & "]"
    End If
    pDatabasePath = Value

    If Me.DatabasePath <> cDatabasePath Then
        FuncLogIt "Let_DatabasePath", "overidden to [" & Value & "] default was [" & cDatabasePath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Property
Public Property Get ResultFileName() As String
    ResultFileName = pResultFileName
End Property
Public Property Let ResultFileName(Value As String)
    If FileExists(Value) = False Then
        FuncLogIt "Let_ResultFileName", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    pResultFileName = Value
    
    If Me.ResultFileName <> cResultFileName Then
        FuncLogIt "Let_ResultFileName", "overidden to [" & Value & "] default was [" & cResultFileName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
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
    If DirExists(Value) = False Then
        FuncLogIt "Let_RuntimeDir", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    pRuntimeDir = Value
    If Me.RuntimeDir <> cRuntimeDir Then
        FuncLogIt "Let_RuntimeDir", "overidden to [" & Value & "] default was [" & cRuntimeDir & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Property
Public Property Get ExecPath() As String
    ExecPath = pExecPath
End Property
Public Property Let ExecPath(Value As String)
    If DirExists(Value) = False Then
        FuncLogIt "Let_ExecPath", "file currently does not exist to [" & Value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    pExecPath = Value
    If Me.ExecPath <> cExecPath Then
        FuncLogIt "Let_ExecPath", "overidden to [" & Value & "] default was [" & cExecPath & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
End Property
' END default directories

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
                 Optional sFileName As String = cFileName, _
                 Optional sDayEnum As String = cDayEnum, _
                 Optional bInitializeCache As Boolean = True)

    If bInitializeCache = True Then
        CreateBook sCacheBookName, sBookPath:=sCacheBookPath
    End If
    
    Me.BookPath = sBookPath
    Me.BookName = sBookName
    
    Me.CacheBookPath = sCacheBookPath
    Me.CacheBookName = sCacheBookName
    Me.CacheRangeName = sCacheRangeName
    
    Me.TemplateBookPath = sTemplateBookPath
    Me.TemplateBookName = sTemplateBookName
    Me.TemplateSheetName = sTemplateSheetName
    Me.TemplateCellSheetName = sTemplateCellSheetName
    Me.DatabasePath = sDatabasePath
    Me.ResultFileName = sResultFileName
    Me.ExecPath = sExecPath
    Me.RuntimeDir = sRuntimeDir
    Me.FileName = sFileName
    Me.DayEnum = sDayEnum
    
End Sub




