Attribute VB_Name = "Quad_Person_Add"
Option Explicit
Const C_MODULE_NAME = "Quad_Person_Add"

Public Sub GeneratePersonAdd(clsAppRuntime As App_Runtime, Optional sSubDataType As String = "Student", Optional sSheetName As String = "test")
Dim sFuncName As String, sDefn As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult

setup:
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleAdd"
    GetDefinition clsAppRuntime, "Person", sSubDataType, sSheetName, FormType.Add

main:
    GenerateForms clsAppRuntime, bLoadRefData:=True
    
End Sub

Public Sub AddPerson(clsAppRuntime, Optional sSubDataType As String = "Student", Optional sSheetName As String = "test")
Dim dEntryValues As Dictionary
Dim wsTable As Worksheet
Dim sTableName As String, sFormName As String

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    sTableName = GetTableName(EnumQuadDataType(QuadDataType.Person), sSubDataType)

    sFormName = GetFormName(FormType.Add, WorksheetFunction.Proper(EnumQuadDataType(QuadDataType.Person)), sSubDataType)
    
    Set dEntryValues = GetRecordValuesAsDict(clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, sFormName)
    
    ' if Table does not exist
    If SheetExists(clsAppRuntime.CacheBook, sTableName) = False Then
        Set wsTable = CreateTable(sTableName, wbTmp:=clsAppRuntime.CacheBook)
    Else
        Set wsTable = GetSheet(clsAppRuntime.CacheBook, sTableName)
    End If

    AddTableRecordFromDict wsTable, sTableName, dEntryValues
        
End Sub
        
