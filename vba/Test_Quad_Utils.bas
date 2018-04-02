Attribute VB_Name = "Test_Quad_Utils"
Option Explicit
'Function TestSheetTableLookup()
'Function TestRowAsDict()

Const CsModuleName = "Test_Quad_Utils"

Function TestGetAndInitQuadRuntimeNoVals() As TestResult
Dim clsQuadRuntime As Quad_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & "." & "GetAndInitQuadRuntimeNoVals"
    
    Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True)
    
    If clsQuadRuntime.DayEnum <> "M,T,W,R,F" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitQuadRuntimeNoVals = eTestResult
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    ResetQuadRuntimeGlobal

End Function
Function TestGetAndInitQuadRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsQuadRuntime As Quad_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & "." & "TestGetAndInitQuadRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsQuadRuntime = GetQuadRuntimeGlobal(bInitFlag:=True, dQuadRuntimeValues:=dValues)
    
    If clsQuadRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestGetAndInitQuadRuntime = eTestResult
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    ResetQuadRuntimeGlobal

End Function
Function TestInitQuadRuntime() As TestResult
Dim dValues As New Dictionary
Dim clsQuadRuntime As Quad_Runtime
Dim eTestResult As TestResult
Dim sFuncName As String

setup:
    sFuncName = CsModuleName & "." & "InitQuadRuntime"
    
    dValues.Add "DayEnum", "foobar"
    
    Set clsQuadRuntime = InitQuadRuntimeGlobal(dQuadRuntimeValues:=dValues)
    
    If clsQuadRuntime.DayEnum <> "foobar" Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestInitQuadRuntime = eTestResult
    CloseBook clsQuadRuntime.CacheBook
    DeleteBook clsQuadRuntime.CacheBookName, clsQuadRuntime.CacheBookPath
    ResetQuadRuntimeGlobal

End Function
Function TestSheetTableLookup() As TestResult

Dim sInputStr As String, sRangeName As String, sFuncName As String, sSheetName As String
Dim iChunkLen As Integer
Dim vSource() As String
Dim eTestResult As TestResult
Dim wsTmp As Worksheet
Dim rTarget As Range

setup:
    sFuncName = CsModuleName & "." & "SheetTableLookup"
    sSheetName = "test"
    sRangeName = "data"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A", "B", "C";"a1","a2","a3";"b1","b2","b3"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRange ActiveWorkbook, rTarget.Address, sSheetName, sRangeName, "True"
    
main:

    If SheetTableLookup(wsTmp, sRangeName, "B", "b2") <> 3 Then
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    TestSheetTableLookup = eTestResult
End Function
Function TestRowAsDict() As TestResult

Dim sInputStr As String, sRangeName As String, sFuncName As String, sSheetName As String
Dim iChunkLen As Integer
Dim vSource() As String
Dim eTestResult As TestResult
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim dResult As New Dictionary

setup:
    sFuncName = CsModuleName & "." & "TestRowAsDict"
    sSheetName = "test"
    sRangeName = "data"
    Set wsTmp = CreateSheet(ActiveWorkbook, sSheetName, bOverwrite:=True)
    vSource = Init2DStringArray([{"A", "B", "C";"a1","a2","a3";"b1","b2","b3"}])
    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 0)
    CreateNamedRange ActiveWorkbook, rTarget.Address, sSheetName, sRangeName, "True"
    
main:

    Set dResult = Row2Dict(wsTmp, sRangeName, 3)
    
    If dResult.Count <> 3 Then
        eTestResult = TestResult.Failure
        GoTo teardown
    ElseIf dResult.Item("C") <> "b3" Then
        eTestResult = TestResult.Failure
        GoTo teardown
        eTestResult = TestResult.Failure
    Else
        eTestResult = TestResult.OK
    End If
    On Error GoTo 0
    GoTo teardown
    
err:
    eTestResult = TestResult.Error
    
teardown:
    DeleteSheet ActiveWorkbook, sSheetName
    TestRowAsDict = eTestResult
End Function
