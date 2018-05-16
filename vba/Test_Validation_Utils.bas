Attribute VB_Name = "Test_Validation_Utils"
Option Explicit
Const C_MODULE_NAME = "Test_Validation_Utils"

Function TestIsMemberOfTable() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As Variant
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsAppRuntime As New App_Runtime
 
setup:
    'On Error GoTo err:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = C_MODULE_NAME & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsAppRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember";"AddFoo","Foo","FooAge","Integer","IsValidInteger";"AddBar","Bar","BarName","List","IsMember";"AddBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DVariantArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    CreateTables clsAppRuntime.CacheBook
    AddTableRecordAuto clsAppRuntime.CacheBook, "foo", vColNames, vRows, bBulkLoad:=True
    
main:
   
    If IsMember(clsAppRuntime, "Jon", Array("Foo", "FooName")) <> True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsMemberOfTable = eTestResult
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.AddBook, "Foo"
    DeleteSheet clsAppRuntime.AddBook, "Bar"
    clsAppRuntime.Delete
    
 End Function

Function TestIsMemberOfTableFailure() As TestResult
Dim sFuncName As String, sSheetName As String, sTableName As String
Dim eTestResult As TestResult
Dim vSource() As String, vColNames() As String, vRows() As String
Dim wsTmp As Worksheet
Dim rTarget As Range, rInput As Range
Dim bTestPassed As Boolean
Dim clsAppRuntime As New App_Runtime
 
setup:
    On Error GoTo err:
    clsAppRuntime.InitProperties bInitializeCache:=True
    sSheetName = "test"
    sFuncName = C_MODULE_NAME & "." & "IsMemberOfTable"
    Set wsTmp = CreateSheet(clsAppRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddFoo","Foo","FooName","List","IsMember";"AddFoo","Foo","FooAge","Integer","IsValidInteger";"AddBar","Bar","BarName","List","IsMember";"AddBar","Bar","BarAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    vRows = Init2DStringArray([{"Jon","43";"Quinton","6"}])
    vColNames = InitStringArray(Array("FooName", "FooAge"))
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    CreateTables clsAppRuntime.CacheBook
    AddTableRecordAuto clsAppRuntime.CacheBook, "foo", vColNames, vRows
    
main:
    If IsMember(clsAppRuntime, "Nancy", Array("Foo", "FooName")) <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsMemberOfTableFailure = eTestResult
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    DeleteSheet clsAppRuntime.AddBook, "Foo"
    DeleteSheet clsAppRuntime.AddBook, "Bar"
    clsAppRuntime.Delete
    
End Function

Function TestValidations() As TestResult

Dim sFuncName As String
Dim sSheetName As String
Dim bResult As Boolean
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim eTestResult As TestResult
Dim rInput As Range
Dim clsAppRuntime As New App_Runtime

setup:
    clsAppRuntime.InitProperties bInitializeCache:=True
    'On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "Validations"
    sSheetName = "test"
    Set wsTmp = CreateSheet(clsAppRuntime.AddBook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"AddStudent","Student","StudentAge","Integer","IsValidInteger";"AddStudent","Student","StudentAge","Integer","IsValidInteger"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget, bIgnoreWidgetType:=True)
    
main:
    With wsTmp
        Set rInput = .Range(.Cells(2, 1), .Cells(2, 1))
    End With
    
    rInput.value = 123
    rInput.name = "eAddStudent_StudentAge"
    bResult = Validate(clsAppRuntime.AddBook, "test", rInput)
    
    If bResult = False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    rInput.value = "ABC"
    rInput.name = "eAddStudent_StudentAge"
    bResult = Validate(clsAppRuntime.AddBook, "test", rInput)
    
    If bResult = True Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestValidations = eTestResult
    DeleteSheet clsAppRuntime.AddBook, sSheetName
    clsAppRuntime.Delete

End Function

Function TestIsValidInteger() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "IsValidInteger"

main:
    If IsValidInteger(clsAppRuntime, 123) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(clsAppRuntime, "ABC") <> False Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidInteger(clsAppRuntime, 123) = True Then
    Else
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
 
    If IsValidInteger(clsAppRuntime, "ABC") = False Then
        eTestResult = TestResult.OK
    Else
        eTestResult = TestResult.Failure
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsValidInteger = eTestResult
    clsAppRuntime.Delete
    
End Function

Function TestIsValidPrep() As TestResult
Dim sFuncName As String
Dim eTestResult As TestResult
Dim clsAppRuntime As New App_Runtime

setup:
    ResetAppRuntimeGlobal
    clsAppRuntime.InitProperties bInitializeCache:=True
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "IsValidPrep"

main:
    If IsValidPrep(clsAppRuntime, 1) <> True Then
        eTestResult = TestResult.Failure
        GoTo teardown
    End If
    
    If IsValidPrep(clsAppRuntime, 11) <> False Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestIsValidPrep = eTestResult
    clsAppRuntime.Delete
    
End Function


