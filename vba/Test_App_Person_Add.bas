Attribute VB_Name = "Test_App_Person_Add"
Option Explicit
Const C_MODULE_NAME = "Test_App_Person_Add"

Function Test_AddPerson_Student() As TestResult
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime
Dim sFuncName As String, sSheetName As String, sTargetSheetName As String, sDataType As String, sSubDataType As String, sTableName As String
Dim rTarget As Range, rWidget As Range
Dim dEntryValues As Dictionary, dRecordValues As Dictionary
Dim iStudentID As Integer
Dim wsTable As Worksheet

setup:
    ResetAppRuntimeGlobal
    sFuncName = C_MODULE_NAME & "." & "Test_AddPerson_Student"
    sSheetName = "test"
    sDataType = "Person"
    sSubDataType = "Student"
    
    'clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    clsAppRuntime.InitProperties bInitializeCache:=True, sDefinitionSheetName:=sSheetName
    GetDefinition clsAppRuntime, sDataType, sSubDataType, sSheetName, FormType.View
    
    sTargetSheetName = "Add_Person_Student"

main:
    GeneratePersonAdd clsAppRuntime
    
    EventsToggle True
    Set Form_Utils.dDefinitions = Nothing
    clsAppRuntime.CloseRuntimeCacheFile
    
    With clsAppRuntime.AddBook.Sheets(sTargetSheetName)
    
        ' SFirstName
        Set rTarget = .Range(.Cells(2, 2), .Cells(2, 2))
        rTarget = "Bruno"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' SLastName
        Set rTarget = .Range(.Cells(3, 2), .Cells(3, 2))
        rTarget = "Raskin"
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' idStudent
        Set rTarget = .Range(.Cells(4, 2), .Cells(4, 2))
        rTarget = 666
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' iPrep
        Set rTarget = .Range(.Cells(5, 2), .Cells(5, 2))
        rTarget = 5
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        ' iGradeLevel
        Set rTarget = .Range(.Cells(6, 2), .Cells(6, 2))
        rTarget = 7
        ValidateWidget clsAppRuntime.AddBook, sTargetSheetName, rTarget
    
        If GetBgColor(sTargetSheetName, rTarget).AsString <> "0,255,0" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        IsRecordValid clsAppRuntime.TemplateBook, clsAppRuntime.AddBook, sTargetSheetName, clsAppRuntime.TemplateWidgetSheetName
        AddPerson clsAppRuntime

        sTableName = GetTableName(sDataType, sSubDataType)
        Set dRecordValues = GetTableRecord(sTableName, 1, wbTmp:=clsAppRuntime.CacheBook)
        
        If dRecordValues.Exists("idPrep") = False Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If dRecordValues.Item("iGradeLevel") <> "7" Then
        eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        GoTo teardown
    End With

err:
    eTestResult = TestResult.Error
    
teardown:
    Test_AddPerson_Student = eTestResult
    clsAppRuntime.Delete
    
End Function
