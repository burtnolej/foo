Attribute VB_Name = "Test_Filter_Utils"
Const CsModuleName = "Test_Filter_Utils"

Sub TestRunner()
    Call TestDoFilter2FiltersOverlapping
    Call TestDoFilterBasic
    Call TestDoFilterNot
    Call TestDoFilter2ColumnOr
    Call TestDoFilterResetLastFilter
    Call TestDoFilterResetNotLastFilter
    Call Test3FiltersMiddleReset
    Call Test3FiltersFirstReset
End Sub
Sub TestDoFilterBasic()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilterBasic"
    
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
        Set rCell = .Range(.Cells(1, 2), .Cells(1, 2))
        rCell.Value = "a"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        ' row 3 and 6 should be visible
        If .Rows(3).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Rows(4).EntireRow.Hidden = False Then
            GoTo fail
        End If
        
        If .Rows(5).EntireRow.Hidden = False Then
            GoTo fail
        End If
        
        If .Rows(6).EntireRow.Hidden = True Then
            GoTo fail
        End If

        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> "^2" Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> "^2" Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> BLANK Then
            GoTo fail
        End If
        
    End With
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub

Sub TestDoFilterNot()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilterNot"
    
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
        Set rCell = .Range(.Cells(1, 2), .Cells(1, 2))
        rCell.Value = "!a"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        ' row 3 and 6 should be visible
        If .Rows(3).EntireRow.Hidden = False Then
            GoTo fail
        End If
        
        If .Rows(4).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Rows(5).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Rows(6).EntireRow.Hidden = False Then
            GoTo fail
        End If

        
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> "^2" Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> "^2" Then
            GoTo fail
        End If
        
    End With

success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub
Sub TestDoFilterResetLastFilter()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilterResetLastFilter"
    
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
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "y"
        DoFilter ActiveWorkbook, sSheetName, rCell
        

        ' filter by the letter z
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "z"
        DoFilter ActiveWorkbook, sSheetName, rCell

        ' filter by the letter a
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "x"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        If .Rows(3).EntireRow.Hidden <> True Then
            GoTo fail
        End If
        
        If .Rows(4).EntireRow.Hidden <> False Then
            GoTo fail
        End If
        
        If .Rows(5).EntireRow.Hidden <> False Then
            GoTo fail
        End If
        
        If .Rows(6).EntireRow.Hidden <> True Then
            GoTo fail
        End If
    
        
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> "^3" Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> "^3" Then
            GoTo fail
        End If
        
    End With
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub

Sub TestDoFilterResetNotLastFilter()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilterResetNotLastFilter"
    
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
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "y"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        ' filter by the letter z
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "z"
        DoFilter ActiveWorkbook, sSheetName, rCell

        'Exit Sub
        
        ' filter by the letter a
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "x"
        DoFilter ActiveWorkbook, sSheetName, rCell

        If .Rows(3).EntireRow.Hidden <> True Then
            GoTo fail
        End If
        
        If .Rows(4).EntireRow.Hidden <> False Then
            GoTo fail
        End If
        
        If .Rows(5).EntireRow.Hidden <> True Then
            GoTo fail
        End If
        
        If .Rows(6).EntireRow.Hidden <> False Then
            GoTo fail
        End If
    
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> "^4" Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> "^4" Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> BLANK Then
            GoTo fail
        End If

    End With
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub


Sub TestDoFilterResetLastFilterAddNewFilter()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilterResetLastFilterAddNewFilter"
    
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
        
        ' filter by the letter y
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "y"
        DoFilter ActiveWorkbook, sSheetName, rCell
        

        ' filter by the letter z
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "z"
        DoFilter ActiveWorkbook, sSheetName, rCell


        ' filter by the letter x
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "x"
        DoFilter ActiveWorkbook, sSheetName, rCell
        

        ' filter by the letter a
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "a"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        
        If .Rows(3).EntireRow.Hidden <> True Then
            GoTo fail
        End If
        
        If .Rows(4).EntireRow.Hidden <> True Then
            GoTo fail
        End If
        
        If .Rows(5).EntireRow.Hidden <> False Then
            GoTo fail
        End If
        
        If .Rows(6).EntireRow.Hidden <> True Then
            GoTo fail
        End If
    
        
        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> "^3" Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> "^4" Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> "^3" Then
            GoTo fail
        End If
        
    End With
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub

Sub TestDoFilter2ColumnOr()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilter2ColumnOr"
    
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
        Set rCell = .Range(.Cells(1, 2), .Cells(1, 2))
        rCell.Value = "a"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        ' filter by the letter z
        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "^z"
        DoFilter ActiveWorkbook, sSheetName, rCell

        ' row 4,5 and 6 should be visible
        If .Rows(3).EntireRow.Hidden <> False Then
            GoTo fail
        End If
        
        If .Rows(4).EntireRow.Hidden <> False Then
            GoTo fail
        End If
        
        If .Rows(5).EntireRow.Hidden <> True Then
            GoTo fail
        End If
        
        If .Rows(6).EntireRow.Hidden <> False Then
            GoTo fail
        End If

        ' then checking the filter history
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> "^4" Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> "^2" Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> "^2^4" Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> BLANK Then
            GoTo fail
        End If
    End With
    
success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub
Sub TestDoFilter2FiltersOverlapping()
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
Dim bTestPassed As Boolean
Dim rCell As Range

setup:
    sFuncName = CsModuleName & "." & "DoFilter2FiltersOverlapping"
    
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
        
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "y"
        DoFilter ActiveWorkbook, sSheetName, rCell

        Set rCell = .Range(.Cells(1, 4), .Cells(1, 4))
        rCell.Value = "z"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        If .Rows(4).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Range(.Cells(3, 25), .Cells(3, 25)).Value <> "^3^4" Then
            GoTo fail
        End If
        If .Range(.Cells(4, 25), .Cells(4, 25)).Value <> BLANK Then
            GoTo fail
        End If
        If .Range(.Cells(5, 25), .Cells(5, 25)).Value <> "^4" Then
            GoTo fail
        End If
        If .Range(.Cells(6, 25), .Cells(6, 25)).Value <> "^3" Then
            GoTo fail
        End If

    End With

success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub

Sub Test3FiltersMiddleReset()

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
Dim bTestPassed As Boolean
Dim rCell As Range
Dim aTmp() As String, aTmp1() As String, aTmp2() As String, aTmp3() As String

setup:
    sFuncName = CsModuleName & "." & "DoFilter2Filters"
    
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
          
        Set rCell = .Range(.Cells(1, 1), .Cells(1, 1))
        rCell.Value = "Boris"
        DoFilter ActiveWorkbook, sSheetName, rCell
    
        Set rCell = .Range(.Cells(1, 2), .Cells(1, 2))
        rCell.Value = "Latvia"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "Right"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        Set rCell = .Range(.Cells(1, 2), .Cells(1, 2))
        rCell.Value = "x"
        DoFilter ActiveWorkbook, sSheetName, rCell
    
        If .Rows(8).EntireRow.Hidden = True Then
            GoTo fail
        End If
    
        If .Rows(9).EntireRow.Hidden = True Then
            GoTo fail
        End If
    
        If .Rows(16).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Rows(18).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        DoEvents
    End With
        

success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub


Sub Test3FiltersFirstReset()

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
Dim bTestPassed As Boolean
Dim rCell As Range
Dim aTmp() As String, aTmp1() As String, aTmp2() As String, aTmp3() As String

setup:
    sFuncName = CsModuleName & "." & "DoFilter2Filters"
    
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
          
        Set rCell = .Range(.Cells(1, 1), .Cells(1, 1))
        rCell.Value = "Boris"
        DoFilter ActiveWorkbook, sSheetName, rCell
    
        Set rCell = .Range(.Cells(1, 2), .Cells(1, 2))
        rCell.Value = "Latvia"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        Set rCell = .Range(.Cells(1, 3), .Cells(1, 3))
        rCell.Value = "Right"
        DoFilter ActiveWorkbook, sSheetName, rCell
        
        Set rCell = .Range(.Cells(1, 1), .Cells(1, 1))
        rCell.Value = "x"
        DoFilter ActiveWorkbook, sSheetName, rCell
    
        If .Rows(8).EntireRow.Hidden = True Then
            GoTo fail
        End If
    
        If .Rows(10).EntireRow.Hidden = True Then
            GoTo fail
        End If
    
        If .Rows(11).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Rows(18).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        If .Rows(19).EntireRow.Hidden = True Then
            GoTo fail
        End If
        
        DoEvents
    End With
        

success:
    bTestPassed = True
    GoTo teardown

fail:
    bTestPassed = False

teardown:
    Call TestLogIt(sFuncName, bTestPassed)
    Call DeleteSheet(Application.ActiveWorkbook, sSheetName)
    Exit Sub

End Sub
