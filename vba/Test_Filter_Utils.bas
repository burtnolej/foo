Attribute VB_Name = "Test_Filter_Utils"
Const C_MODULE_NAME = "Test_Filter_Utils"

Function TestDoFilterBasic() As TestResult
' test 1 basic filter
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilterBasic"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"
            
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 4
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)

    '"id",  "col1", "col2", "col3"
    '"1",   "aa",   "bbb",  "cc"
    '"2",   "xx",   "yy",   "zz"
    '"3",   "xx",   "yy",   "aa"
    '"4",   "xax",  "ss",   "z"
    
main:

    With wsTmp
        DoEventsOn
        
        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 2), .Cells(1, 2))
        rWidget.value = "a"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        ' row 3 and 6 should be visible
        If .Rows(3).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
        End If
        
        If .Rows(4).EntireRow.Hidden = False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(5).EntireRow.Hidden = False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(6).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> "^2" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> "^2" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilterBasic = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function

Function TestDoFilterNot() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilterNot"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"
    
    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 5
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
        
        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 2), .Cells(1, 2))
        rWidget.value = "!a"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        ' row 3 and 6 should be visible
        If .Rows(3).EntireRow.Hidden = False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(4).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(5).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(6).EntireRow.Hidden = False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> "^2" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> "^2" Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilterNot = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function
Function TestDoFilterResetLastFilter() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilterResetLastFilter"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"
            
    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 5
    
    '"id",  "col1", "col2", "col3"
    '"1",   "aa",   "bbb",  "cc"
    '"2",   "xx",   "yy",   "zz"
    '"3",   "xx",   "yy",   "aa"
    '"4",   "xax",  "ss",   "z"
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
        
        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "y"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        

        ' filter by the letter z
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "z"
        DoFilter ActiveWorkbook, sSheetName, rWidget

        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "x"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        If .Rows(3).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(4).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(5).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(6).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> "^3" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> "^3" Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilterResetLastFilter = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function

Function TestDoFilterResetNotLastFilter() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilterResetNotLastFilter"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"
            
    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 5
    
    '"id",  "col1", "col2", "col3"
    '"1",   "aa",   "bbb",  "cc"
    '"2",   "xx",   "yy",   "zz"
    '"3",   "xx",   "yy",   "aa"
    '"4",   "xax",  "ss",   "z"
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
        
        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "y"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        ' filter by the letter z
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "z"
        DoFilter ActiveWorkbook, sSheetName, rWidget

        'Exit Sub
        
        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "x"
        DoFilter ActiveWorkbook, sSheetName, rWidget

        If .Rows(3).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(4).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(5).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(6).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> "^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> "^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilterResetNotLastFilter = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function


Function TestDoFilterResetLastFilterAddNewFilter() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilterResetLastFilterAddNewFilter"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"
            
    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 5
    
    '"id",  "col1", "col2", "col3"
    '"1",   "aa",   "bbb",  "cc"
    '"2",   "xx",   "yy",   "zz"
    '"3",   "xx",   "yy",   "aa"
    '"4",   "xax",  "ss",   "z"
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
        
        ' filter by the letter y
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "y"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        

        ' filter by the letter z
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "z"
        DoFilter ActiveWorkbook, sSheetName, rWidget


        ' filter by the letter x
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "x"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        

        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "a"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        
        If .Rows(3).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(4).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(5).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        If .Rows(6).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> "^3^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> "^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> "^3^4" Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilterResetLastFilterAddNewFilter = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
End Function

Function TestDoFilter2ColumnOr() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilter2ColumnOr"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"
            
    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 4
    
    '"id",  "col1", "col2", "col3"
    '"1",   "aa",   "bbb",  "cc"
    '"2",   "xx",   "yy",   "zz"
    '"3",   "xx",   "yy",   "aa"
    '"4",   "xax",  "ss",   "z"
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
        
        ' filter by the letter a
        Set rWidget = .Range(.Cells(1, 2), .Cells(1, 2))
        rWidget.value = "a"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        ' filter by the letter z
        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "^z"
        DoFilter ActiveWorkbook, sSheetName, rWidget

        ' row 4,5 and 6 should be visible
        If .Rows(3).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(4).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(5).EntireRow.Hidden <> True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(6).EntireRow.Hidden <> False Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If

        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> "^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> "^2" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> "^2^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> BLANK Then
        eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilter2ColumnOr = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Function

End Function
Function TestDoFilter2FiltersOverlapping() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilter2FiltersOverlapping"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"

    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 5
    
    aRows = Init2DStringArray([{"id","col1","col2","col3";"1","aa","bbb","cc";"2","xx","yy","zz";"3","xx","yy","aa";"4","xax","ss","z"}])
    Set rGrid = RangeFromStrArray(aRows, wsTmp, 1, 0)

    '"id",  "col1", "col2", "col3"
    '"1",   "aa",   "bbb",  "cc"
    '"2",   "xx",   "yy",   "zz"
    '"3",   "xx",   "yy",   "aa"
    '"4",   "xax",  "ss",   "z"
    
main:

    With wsTmp
        DoEventsOn
        
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "y"
        DoFilter ActiveWorkbook, sSheetName, rWidget

        Set rWidget = .Range(.Cells(1, 4), .Cells(1, 4))
        rWidget.value = "z"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        If .Rows(4).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Range(.Cells(3, 25), .Cells(3, 25)).value <> "^3^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).value <> BLANK Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).value <> "^4" Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).value <> "^3" Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    TestDoFilter2FiltersOverlapping = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function

Function Test3FiltersMiddleReset() As TestResult
Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range
Dim aTmp() As String, aTmp1() As String, aTmp2() As String, aTmp3() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilter2Filters"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"

    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 19
    
    aTmp1 = Init2DStringArray([{"Echo","Bahamas","Left","10";"Boris","Latvia","Left","10";"Boris","Qatar","Left","11";"Kiayada","Bahamas","Right","13";"Elaine","Bahamas","Right","11";"Ursula","Canada","Left","10";"Boris","Latvia","Right","13";"Boris","Canada","Right","14"}])
    aTmp2 = Init2DStringArray([{"James","Latvia","Right","10";"Wade","Latvia","Right","14";"Jerry","Seychelles","Left","10";"Daquan","Aruba","Right","12";"Wade","Aruba","Right","13";"Nichole","Bahamas","Left","13";"Boris","Aruba","Right","12";"Echo","Bahamas","Left","10"}])
    aTmp3 = Init2DStringArray([{"Boris","Latvia","Right","15";"Wade","Latvia","Right","15";"Timothy","Canada","Left","13"}])
    aTmp = AddArrays(4, aTmp1, aTmp2, aTmp3)
    
    Set rGrid = RangeFromStrArray(aTmp, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
          
        Set rWidget = .Range(.Cells(1, 1), .Cells(1, 1))
        rWidget.value = "Boris"
        DoFilter ActiveWorkbook, sSheetName, rWidget
    
        Set rWidget = .Range(.Cells(1, 2), .Cells(1, 2))
        rWidget.value = "Latvia"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "Right"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        Set rWidget = .Range(.Cells(1, 2), .Cells(1, 2))
        rWidget.value = "x"
        DoFilter ActiveWorkbook, sSheetName, rWidget
    
        If .Rows(8).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        If .Rows(9).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        If .Rows(16).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(18).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        
        DoEvents
        On Error GoTo 0
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test3FiltersMiddleReset = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function


Function Test3FiltersFirstReset() As TestResult

Dim sFuncName As String
Dim wsTmp As Worksheet
Dim sModuleName As String
Dim sText As String
Dim sSheetName As String
Dim sResult As String
Dim aRows() As String
Dim rGrid As Range
Dim sRangeName As String
Dim sFilterCountName As String
Dim eTestResult As TestResult
Dim rWidget As Range
Dim aTmp() As String, aTmp1() As String, aTmp2() As String, aTmp3() As String

setup:
    On Error GoTo err:
    sFuncName = C_MODULE_NAME & "." & "DoFilter2Filters"
    
    sModuleName = "foobar"
    sSheetName = "foobar"
    sRangeName = sSheetName & "_" & "VZFilter"

    'Set wsTmp = GetSheet(Application.ActiveWorkbook, sSheetName)
    Set wsTmp = CreateSheet(Application.ActiveWorkbook, sSheetName)
    CreateFilter Application.ActiveWorkbook, sSheetName, wsTmp.Range("A1:D1"), 19
    
    aTmp1 = Init2DStringArray([{"Echo","Bahamas","Left","10";"Boris","Latvia","Left","10";"Boris","Qatar","Left","11";"Kiayada","Bahamas","Right","13";"Elaine","Bahamas","Right","11";"Ursula","Canada","Left","10";"Boris","Latvia","Right","13";"Boris","Canada","Right","14"}])
    aTmp2 = Init2DStringArray([{"James","Latvia","Right","10";"Wade","Latvia","Right","14";"Jerry","Seychelles","Left","10";"Daquan","Aruba","Right","12";"Wade","Aruba","Right","13";"Nichole","Bahamas","Left","13";"Boris","Aruba","Right","12";"Echo","Bahamas","Left","10"}])
    aTmp3 = Init2DStringArray([{"Boris","Latvia","Right","15";"Wade","Latvia","Right","15";"Timothy","Canada","Left","13"}])
    aTmp = AddArrays(4, aTmp1, aTmp2, aTmp3)
    
    Set rGrid = RangeFromStrArray(aTmp, wsTmp, 1, 0)
    
main:

    With wsTmp
        DoEventsOn
          
        Set rWidget = .Range(.Cells(1, 1), .Cells(1, 1))
        rWidget.value = "Boris"
        DoFilter ActiveWorkbook, sSheetName, rWidget
    
        Set rWidget = .Range(.Cells(1, 2), .Cells(1, 2))
        rWidget.value = "Latvia"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        Set rWidget = .Range(.Cells(1, 3), .Cells(1, 3))
        rWidget.value = "Right"
        DoFilter ActiveWorkbook, sSheetName, rWidget
        
        Set rWidget = .Range(.Cells(1, 1), .Cells(1, 1))
        rWidget.value = "x"
        DoFilter ActiveWorkbook, sSheetName, rWidget
    
        If .Rows(8).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        If .Rows(10).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
    
        If .Rows(11).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(18).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
            GoTo teardown
        End If
        
        If .Rows(19).EntireRow.Hidden = True Then
            eTestResult = TestResult.Failure
        Else
            eTestResult = TestResult.OK
        End If
        On Error GoTo 0
        DoEvents
        GoTo teardown
    End With
    
err:
    eTestResult = TestResult.Error
    
teardown:
    Test3FiltersFirstReset = eTestResult
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)

End Function
