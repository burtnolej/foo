VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "App_Runtime"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Const C_MODULE_NAME = "App_Runtime"
Public Enum DataFamilyType
    Quad = 1
End Enum

Private pDataFamily As DataFamilyType

Private pBookPath As String
Private pBookName As String
Private pBook As Workbook

Private pMainBookPath As String
Private pMainBookName As String
Private pMainBook As Workbook

Private pCacheBookName As String
Private pCacheBookPath As String
Private pCacheRangeName As String
Private pCacheBook As Workbook

Private pTemplateBookPath As String
Private pTemplateBookName As String
Private pTemplateSheetName As String
Private pTemplateWidgetSheetName As String
Private pTemplateBook As Workbook
Private pTemplateSheet As Worksheet
Private pTemplateWidgetSheet As Worksheet

Private pScheduleBook As Workbook
Private pScheduleBookPath As String
Private pScheduleBookName As String

Private pAddBook As Workbook
Private pAddBookPath As String
Private pAddBookName As String

Private pViewBook As Workbook
Private pViewBookPath As String
Private pViewBookName As String

Private pMenuBook As Workbook
Private pMenuBookPath As String
Private pMenuBookName As String

Private pDatabasePath As String
Private pResultFileName As String

Private pExecPath As String
Private pRuntimeDir As String
Private pFileName As String
Private pDayEnum As String
Private pPeriodEnum As String
Private pBookEnum As String
Private pNewBookPath As String

Private pCurrentSheetSource As Variant
Private pCurrentSheetColumns As Variant

Private pAppRuntimeCacheFile As Object
Private pAppRuntimeCacheFileName As String
Private pAppRuntimeCacheFileArray() As String

Private pDefinitionSheetName As String

Private pWindowSettings As Quad_WindowSettings

Private cDataFamily As DataFamilyType
Private cHomeDir As String
Private cAppDir As String
Private cExecPath  As String
Private cRuntimeDir  As String
Private cBookPath As String
Private cBookName As String
Private cMainBookPath As String
Private cMainBookName As String
Private cNewBookPath As String
Private cCacheBookName  As String
Private cCacheBookPath  As String
Private cCacheRangeName  As String
Private cTemplateBookPath  As String
Private cTemplateBookName As String
Private cTemplateSheetName  As String
Private cTemplateWidgetSheetName  As String
Private cScheduleBookPath As String
Private cScheduleBookName As String
Private cAddBookPath As String
Private cAddBookName As String
Private cViewBookPath As String
Private cViewBookName As String
Private cMenuBookPath As String
Private cMenuBookName As String
Private cDefinitionSheetName   As String
Private cDatabasePath  As String
Private cResultFileName  As String
Private cFileName  As String
Private cAppRuntimeEnum  As String
Private cDayEnum  As String
Private cPeriodEnum  As String
Private cAppRuntimeCacheFileName  As String
Private cBookEnum As String

Const C_DATA_FAMILY_TYPE = "Quad"
Public dDefinitions As Dictionary

Function EnumDataFamilyType(i As Long) As String
    EnumDataFamilyType = Split(C_DATA_FAMILY, COMMA)(i - 1)
End Function
Function GetDataFamilyTypeEnumFromValue(sValue As String) As Long
    GetDataFamilyTypeEnumFromValue = IndexArray(C_DATA_FAMILY_TYPE, sValue)
End Function



' Data Family ----------------------------------
Public Property Get DataFamily() As DataFamilyType
    Set DataFamily = pDataFamily
End Property

Public Property Let DataFamily(value As DataFamilyType)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "DataFamily"
    sConstValue = cDataFamily

main:
    pDataFamily = GetUpdatedValue(sFuncName, sConstValue, value)
    
End Property
' END Data Family ----------------------------------

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
    sFuncName = C_MODULE_NAME & "." & "BookPath"
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

Public Property Get NewBookPath() As String
    NewBookPath = pNewBookPath
End Property
Public Property Let NewBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = "NewBookPath"
    sConstValue = cNewBookPath
    
main:
    pNewBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property


Public Property Let BookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "BookName"
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

' Main  Book -----------------------
Public Property Get MainBook() As Workbook
    Set MainBook = pMainBook
End Property
Public Property Let MainBook(value As Workbook)
    Set pMainBook = value
End Property
Public Property Get MainBookPath() As String
    MainBookPath = pMainBookPath
End Property
Public Property Let MainBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "MainBookPath"
    sConstValue = cMainBookPath
    
main:
    pMainBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get MainBookName() As String
    MainBookName = pMainBookName
End Property

Public Property Let MainBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "MainBookName"
    sConstValue = cMainBookName

main:

    pMainBookName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If Me.MainBookPath = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="MainBookPath needs to be set before MainBookName"
    End If
    
    If FileExists(Me.MainBookPath & "\\" & pMainBookName) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="MainBookName file does not exist [" & value & "]"
    End If
    
    Me.MainBook = OpenBook(pMainBookName, sPath:=Me.MainBookPath)
    
End Property
'END Main Book ----------------------

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
    sFuncName = C_MODULE_NAME & "." & "CacheBookPath"
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
    sFuncName = C_MODULE_NAME & "." & "CacheBookName"
    sConstValue = cCacheBookName
    
    pCacheBookName = GetUpdatedValue(sFuncName, sConstValue, value)
    
End Property
Public Property Get CacheRangeName() As String
    CacheRangeName = pCacheRangeName
End Property
Public Property Let CacheRangeName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "CacheRangeName"
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
Public Property Get TemplateWidgetSheet() As Worksheet
    Set TemplateWidgetSheet = pTemplateWidgetSheet
End Property
Public Property Let TemplateWidgetSheet(value As Worksheet)
    Set pTemplateWidgetSheet = value
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
    sFuncName = C_MODULE_NAME & "." & "TemplateBookPath"
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
    sFuncName = C_MODULE_NAME & "." & "TemplateBookName"
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
    sFuncName = C_MODULE_NAME & "." & "TemplateSheetName"
    sConstValue = cTemplateSheetName
    
    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateSheetName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    Me.TemplateSheet = GetSheet(Me.TemplateBook, TemplateSheetName)
    
End Property
Public Property Get TemplateWidgetSheetName() As String
    TemplateWidgetSheetName = pTemplateWidgetSheetName
End Property
Public Property Let TemplateWidgetSheetName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "TemplateWidgetSheetName"
    sConstValue = cTemplateWidgetSheetName
    
    If Me.TemplateBookName = "" Then
         err.Raise ErrorMsgType.DEPENDENT_ATTR_NOT_SET, Description:="TemplateBookName needs to be set before CacheBookRangeName"
    End If
    
    pTemplateWidgetSheetName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    Me.TemplateWidgetSheet = GetSheet(Me.TemplateBook, TemplateWidgetSheetName)
    
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
    sFuncName = C_MODULE_NAME & "." & "ScheduleBookPath"
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
    sFuncName = C_MODULE_NAME & "." & "ScheduleBookName"
    sConstValue = cScheduleBookName
    
    pScheduleBookName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
' END schedule -------------------------------------


' View -----------------------------------------
Public Property Get ViewBook() As Workbook
    Set ViewBook = pViewBook
End Property
Public Property Let ViewBook(value As Workbook)
    Set pViewBook = value
End Property
Public Property Get ViewBookPath() As String
    ViewBookPath = pViewBookPath
End Property
Public Property Let ViewBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "ViewBookPath"
    sConstValue = cViewBookPath
    
    pViewBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get ViewBookName() As String
    ViewBookName = pViewBookName
End Property
Public Property Let ViewBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "ViewBookName"
    sConstValue = cViewBookName
    
    pViewBookName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
' END View -------------------------------------

' Menu -----------------------------------------
Public Property Get MenuBook() As Workbook
    Set MenuBook = pMenuBook
End Property
Public Property Let MenuBook(value As Workbook)
    Set pMenuBook = value
End Property
Public Property Get MenuBookPath() As String
    MenuBookPath = pMenuBookPath
End Property
Public Property Let MenuBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "MenuBookPath"
    sConstValue = cMenuBookPath
    
    pMenuBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get MenuBookName() As String
    
    MenuBookName = pMenuBookName
End Property
Public Property Let MenuBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "MenuBookName"
    sConstValue = cMenuBookName
    
    pMenuBookName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
' END Menu -------------------------------------


' Add -----------------------------------------
Public Property Get AddBook() As Workbook
    Set AddBook = pAddBook
End Property
Public Property Let AddBook(value As Workbook)
    Set pAddBook = value
End Property
Public Property Get AddBookPath() As String
    AddBookPath = pAddBookPath
End Property
Public Property Let AddBookPath(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "AddBookPath"
    sConstValue = cAddBookPath
    
    pAddBookPath = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If DirExists(value) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & value & "] does not exist"
    End If
    
End Property
Public Property Get AddBookName() As String
    
    AddBookName = pAddBookName
End Property
Public Property Let AddBookName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "AddBookName"
    sConstValue = cAddBookName
    
    pAddBookName = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
' END Add -------------------------------------

' misc ---------------------------------------------
Public Property Get BookEnum() As String
    BookEnum = pBookEnum
End Property
Public Property Let BookEnum(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "BookEnum"
    sConstValue = cBookEnum
main:
    pBookEnum = GetUpdatedValue(sFuncName, sConstValue, value)
End Property
Public Property Get DayEnum() As String
    DayEnum = pDayEnum
End Property
Public Property Let DayEnum(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "DayEnum"
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
    sFuncName = C_MODULE_NAME & "." & "PeriodEnum"
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
    sFuncName = C_MODULE_NAME & "." & "DefinitionSheetName"
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
    sFuncName = C_MODULE_NAME & "." & "FileName"
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
    sFuncName = C_MODULE_NAME & "." & "DatabasePath"
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
    sFuncName = C_MODULE_NAME & "." & "ResultFileName"
    sConstValue = cResultFileName
    
    pResultFileName = GetUpdatedValue(sFuncName, sConstValue, value)
    
    If FileExists(pResultFileName) = False Then
        FuncLogIt "Let_ResultFileName", "file currently does not exist to [" & value & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
main:
    
End Property
Public Property Get AppRuntimeCacheFileName() As String
    AppRuntimeCacheFileName = pAppRuntimeCacheFileName
End Property
Public Property Let AppRuntimeCacheFileName(value As String)
Dim sCachedValue As String, sOrigValue As String, sConstValue As String, sTmpValue As String
Dim sFuncName As String
setup:
    sFuncName = C_MODULE_NAME & "." & "AppRuntimeCacheFileName"
    sConstValue = cAppRuntimeCacheFileName
main:
    pAppRuntimeCacheFileName = GetUpdatedValue(sFuncName, sConstValue, value)
    
End Property
Public Property Get AppRuntimeCacheFile() As Object
    Set AppRuntimeCacheFile = pAppRuntimeCacheFile
End Property
Public Property Let AppRuntimeCacheFile(value As Object)
    Set pAppRuntimeCacheFile = value
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
    sFuncName = C_MODULE_NAME & "." & "RuntimeDir"
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
    sFuncName = C_MODULE_NAME & "." & "ExecPath"
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
        FuncLogIt sFuncName, "retreived value from overide cache file to [" & sCachedValue & "] instead of [" & sOrigValue & "]", C_MODULE_NAME, LogMsgType.INFO
    Else
        If value = "" Then
            'using default value
            value = sConstValue
        ElseIf value <> sConstValue Then
            FuncLogIt sFuncName, "overidden to [" & value & "] default was [" & sConstValue & "]", C_MODULE_NAME, LogMsgType.INFO
            PersistOverride sFuncName, value
        End If
    End If
    
    GetUpdatedValue = value
End Function

Function GetAttrEnum(sAttrName As String) As Integer
    GetAttrEnum = IndexArray(Split(cAppRuntimeEnum, COMMA), sAttrName)
    If GetAttrEnum = -1 Then
        err.Raise ErrorMsgType.BAD_ENUM, Description:="value [" & sAttrName & "] is not a member of enum [cAppRuntimeEnum]"
    End If
End Function

Public Property Get AppRuntimeCacheFileArray() As String()
    AppRuntimeCacheFileArray = pAppRuntimeCacheFileArray
End Property
Public Property Let AppRuntimeCacheFileArray(value() As String)
    pAppRuntimeCacheFileArray = value
End Property


Sub PersistOverride(sFuncName As String, sValue As String)
Dim iRow As Integer
Dim vCurrentState() As String
Dim sCurrentValue As String

    If UBound(Split(sFuncName, PERIOD)) > 0 Then ' funcname can be of form Module.FuncName or just FuncName
        sFuncName = Split(sFuncName, PERIOD)(1)
    End If
    
    iRow = GetAttrEnum(sFuncName)
    vCurrentState = ReadFile2Array(Me.AppRuntimeCacheFileName, bSingleCol:=True)
    sCurrentValue = vCurrentState(iRow)
    vCurrentState(iRow) = sValue
    WriteArray2File vCurrentState, Me.AppRuntimeCacheFileName

    FuncLogIt sFuncName & ".PersistOverride", "updated AppRuntime persist file [" & Me.AppRuntimeCacheFileName & "] for [" & sFuncName & "] from [" & sCurrentValue & "] to [" & sValue & "]", C_MODULE_NAME, LogMsgType.INFO

End Sub

'write some tests for this
'then put into each Letter
'then create a rehydrate option for AppRuntime
'then call rehydrate from validate
Function RetreiveOverride(ByVal sFuncName As String) As String
Dim iRow As Integer
Dim vResults() As String

    If UBound(Split(sFuncName, PERIOD)) > 0 Then ' funcname can be of form Module.FuncName or just FuncName
        sFuncName = Split(sFuncName, PERIOD)(1)
    End If
    iRow = GetAttrEnum(sFuncName)
    vResults = Me.AppRuntimeCacheFileArray
    RetreiveOverride = vResults(iRow)
End Function

Sub InitOveride(Optional bRecover As Boolean = True)
Dim vResults() As String
'purpose: if bRecover is True, parse and store cache file contents, otherwise
'       : initialize; each Let'er will use cached value if not explicitly overidden
    
    If bRecover = False Then
        Me.AppRuntimeCacheFile = InitFileArray(cAppRuntimeCacheFileName, 50)
    End If
    
    If FileExists(cAppRuntimeCacheFileName) = False Then
        Me.AppRuntimeCacheFile = InitFileArray(cAppRuntimeCacheFileName, 50)
    Else
        'Me.AppRuntimeCacheFile = OpenFile(cAppRuntimeCacheFileName, 8)
    End If

    vResults = ReadFile2Array(cAppRuntimeCacheFileName, bSingleCol:=True)
    Me.AppRuntimeCacheFileArray = vResults

End Sub
Public Function IsAAppRuntime() As Boolean
    IsAAppRuntime = True
End Function

Sub SetDefaults()
    cDataFamily = DataFamilyType.Quad
    
    cHomeDir = GetHomePath
    cAppDir = cHomeDir & "\GitHub\quadviewer\"
    cExecPath = cAppDir & "app\\quad\utils\excel\"
    cRuntimeDir = cHomeDir & "\runtime\"
    
    cMainBookPath = cAppDir
    cMainBookName = "vba_source_new.xlsm"
    
    cBookPath = cRuntimeDir
    cBookName = "cache.xlsm"
    cCacheBookName = "cache.xlsm"
    cCacheBookPath = cRuntimeDir
    cCacheRangeName = "data"
    cNewBookPath = cRuntimeDir & "archive\"
    
    'cTemplateBookPath = cAppDir
    cTemplateBookPath = cRuntimeDir
    'cTemplateBookName = "vba_source_new.xlsm"
    cTemplateBookName = "quad.xlsm"

    cTemplateSheetName = "FormStyles"
    cTemplateWidgetSheetName = "WidgetStyles"
    
    cScheduleBookPath = cRuntimeDir
    cScheduleBookName = "schedule.xlsm"
    
    cMenuBookPath = cRuntimeDir
    cMenuBookName = "menu.xlsm"
    
    cAddBookPath = cRuntimeDir
    cAddBookName = "add.xlsm"
    
    cViewBookPath = cRuntimeDir
    cViewBookName = "view.xlsm"
    
    cDefinitionSheetName = "Definitions"
    cDatabasePath = cAppDir & "app\quad\utils\excel\test_misc\QuadQA.db"
    cResultFileName = cRuntimeDir & "pyshell_results.txt"
    cFileName = cRuntimeDir & "uupyshell.args.txt"
    cAppRuntimeEnum = "BookPath,BookName,CacheBookName,CacheBookPath,CacheRangeName,TemplateBookPath,TemplateBookName,TemplateSheetName,TemplateWidgetSheetName,DatabasePath,ResultFileName,ExecPath,RuntimeDir,FileName,DayEnum,PeriodEnum,CurrentSheetSource,CurrentSheetColumns,AppRuntimeCacheFileName,DefinitionSheetName,ScheduleBookPath,ScheduleBookName,AddBookPath,AddBookName,MenuBookPath,MenuBookName,ViewBookPath,ViewBookName,BookEnum,NewBookPath,DataFamily,MainBookPath,MainBookName,"
    cDayEnum = "M,T,W,R,F"
    cPeriodEnum = "1,2,3,4,5,6,7,8,9,10,11"
    cAppRuntimeCacheFileName = cHomeDir & "\app_runtime_cache.txt"
    cBookEnum = Join(Array(cCacheBookName, cScheduleBookName, cMenuBookName, cAddBookName, cViewBookName), COMMA)
    
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
    
    vWindowNames = Array(Me.BookName, Me.ScheduleBookName, Me.CacheBookName, Me.AddBookName)
    
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
    vWindowCol2(1) = Me.AddBookName
    vWindow(0) = vWindowCol1 'row 1
    vWindow(1) = vWindowCol2 'row 1
    
    SetWindowScheme dWindows, vWindow
End Sub
    
Public Sub InitProperties( _
                 Optional sDataFamily As DataFamilyType, _
                 Optional sMainBookPath As String, _
                 Optional sMainBookName As String, _
                 Optional sBookPath As String, _
                 Optional sBookName As String, _
                 Optional sCacheBookPath As String, _
                 Optional sCacheBookName As String, _
                 Optional sCacheRangeName As String, _
                 Optional sTemplateBookPath As String, Optional sTemplateBookName As String, _
                 Optional sTemplateSheetName As String, Optional sTemplateWidgetSheetName As String, _
                 Optional sScheduleBookPath As String, Optional sScheduleBookName As String, _
                 Optional sMenuBookPath As String, Optional sMenuBookName As String, _
                 Optional sAddBookPath As String, Optional sAddBookName As String, _
                 Optional sViewBookPath As String, Optional sViewBookName As String, _
                 Optional sNewBookPath As String, Optional sDatabasePath As String, _
                 Optional sResultFileName As String, Optional sExecPath As String, Optional sRuntimeDir As String, _
                 Optional sFileName As String, Optional sDayEnum As String, Optional sPeriodEnum As String, _
                 Optional sBookEnum As String, _
                 Optional sDefinitionSheetName As String, Optional sAppRuntimeCacheFileName As String, _
                 Optional bInitializeCache As Boolean = True, _
                 Optional bInitializeOveride As Boolean = True, _
                 Optional bHydrateFromCache As Boolean = False, _
                 Optional bSetWindows = False)

Dim lStartTick As Long
Dim sFuncName As String

setup:
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    
main:
    SetDefaults
    
    If bInitializeOveride = True Then
        Me.InitOveride
    End If
    
    Me.AppRuntimeCacheFileName = sAppRuntimeCacheFileName
    
    Me.CacheBookPath = sCacheBookPath
    Me.CacheBookName = sCacheBookName
    Me.CacheRangeName = sCacheRangeName
    Me.ScheduleBookPath = sScheduleBookPath
    Me.ScheduleBookName = sScheduleBookName
    Me.AddBookPath = sAddBookPath
    Me.AddBookName = sAddBookName
    Me.MenuBookPath = cMenuBookPath
    Me.MenuBookName = cMenuBookName
    Me.ViewBookName = cViewBookName
    Me.ViewBookPath = cViewBookPath
    
    Me.BookEnum = sBookEnum
    Me.RuntimeDir = sRuntimeDir

    Me.NewBookPath = sNewBookPath
    
    If bInitializeCache = True Then
        Me.OpenBooks
    Else
        If BookExists(Me.CacheBookPath & "\" & Me.CacheBookName) = False Then
            Me.OpenBooks
        End If
    End If
    
    Me.CacheBook = OpenBook(Me.CacheBookName, sPath:=Me.CacheBookPath)
    Me.ScheduleBook = OpenBook(Me.ScheduleBookName, sPath:=Me.ScheduleBookPath)
    Me.AddBook = OpenBook(Me.AddBookName, sPath:=Me.AddBookPath)
    Me.MenuBook = OpenBook(Me.MenuBookName, sPath:=Me.MenuBookPath)
    Me.ViewBook = OpenBook(Me.ViewBookName, sPath:=Me.ViewBookPath)
    
    Me.BookPath = sBookPath
    Me.BookName = sBookName
    
    Me.MainBookPath = sMainBookPath
    Me.MainBookName = sMainBookName

    Me.TemplateBookPath = sTemplateBookPath
    Me.TemplateBookName = sTemplateBookName
    'Me.TemplateSheetName = sTemplateSheetName
    Me.TemplateWidgetSheetName = sTemplateWidgetSheetName
    
    Me.DefinitionSheetName = sDefinitionSheetName
    
    Me.DatabasePath = sDatabasePath
    Me.ResultFileName = sResultFileName
    Me.ExecPath = sExecPath

    Me.FileName = sFileName
    Me.DayEnum = sDayEnum
    Me.PeriodEnum = sPeriodEnum

    If bSetWindows = True Then
        SetWindows
    End If
    
    ' added on 4/17/18 to get dynamic menus to work
    Me.TemplateBook.Activate

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
End Sub

Public Sub CloseRuntimeCacheFile()
Dim oFile As Object
    Set oFile = Me.AppRuntimeCacheFile
    On Error Resume Next
    oFile.Close
    On Error GoTo 0
End Sub

Function BookOpen(sBookName As String)

    On Error GoTo err
    If Workbooks(sBookName).name = sBookName Then
        BookOpen = True
        Exit Function
    End If
    On Error Resume Next

err:
    BookOpen = False

End Function
Public Sub CleanUpTmpBooks()
Dim sBook As Variant
Dim wbTmp As Workbook
Dim sBookName As String, sBookPath As String

    For Each sBook In Split(Me.BookEnum, COMMA)
        sBook = Split(sBook, PERIOD)(0)
        sBook = UCase(Left(sBook, 1)) & Right(sBook, Len(sBook) - 1)
        Set wbTmp = CallByName(Me, sBook & "Book", VbGet)
        CloseBook wbTmp
        sBookName = CallByName(Me, sBook & "BookName", VbGet)
        sBookPath = CallByName(Me, sBook & "BookPath", VbGet)
        DeleteBook sBookName, sBookPath
    Next sBook
    
    ' close whatever template book has been opened i.e. quad.xlsm
    If BookOpen(Me.TemplateBookName) = True Then
        CloseBook Me.TemplateBook
    End If
    
End Sub
Public Sub Delete()
    Me.CloseRuntimeCacheFile
    DeleteFile Me.AppRuntimeCacheFileName
    Me.CleanUpTmpBooks
End Sub
Public Sub OpenBooks()
Dim sBook As Variant
    For Each sBook In Split(Me.BookEnum, COMMA)
        sBook = Split(sBook, PERIOD)(0)
        sBook = UCase(Left(sBook, 1)) & Right(sBook, Len(sBook) - 1)
        FileCopy CallByName(Me, sBook & "BookName", VbGet), CallByName(Me, "NewBookPath", VbGet), Me.RuntimeDir
    Next sBook
End Sub




