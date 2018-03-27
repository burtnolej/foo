Attribute VB_Name = "App_Schedule"
'Public Function GetScheduleDataFromDB
'Public Function GetScheduleCellColWidths
'Public Function GetScheduleCellFormat
'Function GetScheduleDataHelpers
'Public Function BuildSchedule
'Public Function BuildScheduleView

Option Explicit
Const C_MODULE_NAME = "App_Schedule"
Public vSource As Variant
Public vColumns As Variant

Public Const cCacheRangeName = "data"
Public Const cTemplateSheetName = "FormStyles"
Public Const cDatabasePath = "C:\Users\burtnolej\Documents\GitHub\quadviewer\app\quad\utils\excel\test_misc\QuadQA.db"
Public Const cResultFileName = "C:\\Users\\burtnolej\\Documents\\runtime\\pyshell_results.txt"


Public Function BuildSchedule(sBookName As String, _
                              sBookPath As String, _
                              sScheduleType As String, _
                              iPersonID As Integer, _
                              Optional sTemplateRangeName As String, _
                              Optional sCacheBookName As String, _
                              Optional sCacheBookPath As String) As Worksheet
'"""Using data from the database, and a format template, create a visual schedule on a new sheet
'param:sBookName, string, workbook where the template's reside and where the cache and view will go if not overwritten
'param:sScheduleType, string, either student or teacher
'param:iPersonalId, integer, value of the student or teacher to retreive the schedule for
'param:sTemplateRangeName, if the template range cannot be calculated f[schedule_type]ScheduleCell its passed here
'param:sCacheBookName, if you dont want the cache sheet to reside in the current activebook, will create a new book (good for testing)
'rtype:Worksheet, the sheet object where the schedule view has been written
'"""
Dim sResultFileName As String, sTemplateBookName As String, sCacheSheetName As String, sDataType As String, sFuncName As String
Dim aSchedule() As String
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildSchedule"

    ' Assertions --------------------------------
    If InArray(Array("student", "teacher"), sScheduleType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sScheduleType needs to be in [student|teacher] got [" & sScheduleType & "]"
    End If
    
    If FileExists(sBookPath & "/" & sBookName) <> True Then
         err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="workbook [" & sBookName & "] does not exist"
    End If
    
    If sTemplateRangeName <> "" Then
        If NamedRangeExists(Workbooks(sBookName), cTemplateSheetName, sTemplateRangeName) <> True Then
            err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="named range [" & sTemplateRangeName & "] does not exist in [" & sBookName & "]"
        End If
    End If
    ' END Assertions --------------------------------
    
    sDataType = "schedule"
    sTemplateBookName = sBookName 'for now just assume that the templates reside in the main workbook
    
    If sTemplateRangeName = "" Then
        sTemplateRangeName = "f" & sScheduleType & "ScheduleCell"
        FuncLogIt sFuncName, "Template range name not set so defaulting to  [" & sTemplateRangeName & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    SetCacheBook sCacheBookName, sCacheBookPath
main:
    If IsDataCached(sCacheBookPath, sCacheBookName, sDataType, sScheduleType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & sScheduleType & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results
        sResultFileName = GetScheduleDataFromDB(iPersonID, sScheduleType, sCacheBookName:=sCacheBookName, sCacheBookPath:=sCacheBookPath)
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(sResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(sCacheBookPath, sCacheBookName, aSchedule, sDataType, sScheduleType, iPersonID)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & sScheduleType & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(sCacheBookPath, sCacheBookName, aSchedule, sDataType, sScheduleType, iPersonID, _
                    bCacheNameOnly:=True)
    End If
    ' copy the template format to the clipboard
    GetScheduleCellFormat iFormatWidth, iFormatHeight, sTemplateBookName, cTemplateSheetName, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(sTemplateBookName, cTemplateSheetName, sTemplateRangeName, iColWidthCount)
    ' store the data needed to build the schedules as a module member variable for easy access
    GetScheduleDataHelpers sCacheBookPath, sCacheBookName, sCacheSheetName
    ' draw the schedule
    Set BuildSchedule = BuildScheduleView(sCacheBookName, aColumnWidths, iFormatWidth, iFormatHeight, sScheduleType, iPersonID)
  
End Function
Public Function GetScheduleDataFromDB(sPersonId As Integer, _
                                      sScheduleType As String, _
                             Optional sPeriod As String, _
                             Optional sDay As String, _
                             Optional sCacheBookName As String = Quad_Utils.sCacheBookName, _
                             Optional sCacheBookPath As String) As String

Dim sDatabasePath As String, sResultFileName As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary
Dim sFuncName As String

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleDataFromDB"
    
    ' Assertions --------------------------------
    If InArray(Array("student", "teacher"), sScheduleType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sScheduleType needs to be in [student|teacher] got [" & sScheduleType & "]"
    End If
    
    If IsValidPersonID(sPersonId, sScheduleType, sCacheBookName:=sCacheBookName) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
    Else
         FuncLogIt sFuncName, "[" & sScheduleType & "] id[" & CStr(sPersonId) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
    End If
    ' END Assertions ----------------------------
    
    SetCacheBook sCacheBookName, sCacheBookPath

main:
    If sScheduleType = "student" Then
        sSpName = "student_schedule"
        dSpArgs.Add "students", InitVariantArray(Array(sPersonId))
    ElseIf sScheduleType = "teacher" Then
        sSpName = "teacher_schedule"
        dSpArgs.Add "teachers", InitVariantArray(Array(sPersonId))
    End If
    FuncLogIt sFuncName, "schedule type is [" & sScheduleType & "] using sp [" & sSpName & "]", C_MODULE_NAME, LogMsgType.INFO
    
    If sPeriod <> "" Then
        dSpArgs.Add "periods", InitVariantArray(Split(sPeriod, ","))
        FuncLogIt sFuncName, "Period WHERE clause specified  [" & sPeriod & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

    If sDay <> "" Then
        dSpArgs.Add "days", InitVariantArray(Split(sDay, ","))
        FuncLogIt sFuncName, "Day WHERE clause specified  [" & sDay & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    GetQuadDataFromDB cDatabasePath, sSpName, dSpArgs:=dSpArgs, sResultFileName:=cResultFileName, bHeaderFlag:=True
                        
    GetScheduleDataFromDB = cResultFileName
End Function
Function GetScheduleDataHelpers(Optional sCacheBookPath As String, _
                                Optional sCacheBookName As String, _
                                Optional sCacheSheetName As String, _
                                Optional sCacheRangeName As String = cCacheRangeName)
Dim iScheduleWidth As Integer, iScheduleHeight As Integer

    ' Assertions --------------------------------
    SetCacheBook sCacheBookName, sCacheBookPath
    
    If SheetExists(Workbooks(sCacheBookName), sCacheSheetName) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sCacheSheetName does not exist in [" & sCacheBookName & "]"
    End If
    If NamedRangeExists(Workbooks(sCacheBookName), sCacheSheetName, sCacheRangeName) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sCacheRangeName does not exist in [" & sCacheRangeName & "]"
    End If
    ' END Assertions ----------------------------
    
    With Workbooks(sCacheBookName).Sheets(sCacheSheetName)
        .Activate
        With .Range(sCacheRangeName)
            iScheduleWidth = .Columns.Count
            iScheduleHeight = .Rows.Count
            
            ReDim vSource(1 To iScheduleHeight - 1, 1 To iScheduleWidth)
            ReDim vColumns(1 To 1, 1 To iScheduleWidth)

            .Rows(1).Select
            vColumns = .Resize(1)
            vSource = .Resize(.Rows.Count - 1).Offset(1)
        End With
    End With

End Function
Public Sub GetScheduleCellFormat(ByRef iFormatWidth As Integer, _
                                 ByRef iFormatHeight As Integer, _
                                 sSourceBookName As String, _
                                 sSourceSheetName As String, _
                                 sScheduleFormatRangeName As String)
'gets the template for the cell and puts it into the clipboard
'param: sSourceBookName, string, the book that holds the templates (vba_source_new.xlsm)
'param: sSourceSheetName, string, the sheet in sSourceBookName that holds the templates (FormStyles)
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell


'this is where i had got up to .. adding assertions and logging ....
'need to go through and default cache book to Quad_Utils in the signature
Dim rScheduleFormatRange As Range
    With Workbooks(sSourceBookName).Sheets(sSourceSheetName)
        .Activate
        Set rScheduleFormatRange = .Range(sScheduleFormatRangeName)
        rScheduleFormatRange.Select
        Selection.Copy
    End With
        
    iFormatWidth = rScheduleFormatRange.Columns.Count
    iFormatHeight = rScheduleFormatRange.Rows.Count
    
End Sub
        
Public Function GetScheduleCellColWidths(sSourceBookName As String, _
                                         sSourceSheetName As String, _
                                         sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sSourceBookName, string, the book that holds the templates (vba_source_new.xlsm)
'param: sSourceSheetName, string, the sheet in sSourceBookName that holds the templates (FormStyles)
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim aColumnWidths() As Integer
Dim rCell As Range

    ReDim aColumnWidths(0 To 20)
    With Workbooks(sSourceBookName).Sheets(sSourceSheetName)
        .Activate
        For Each rCell In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rCell.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rCell
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetScheduleCellColWidths = aColumnWidths
End Function

Function BuildScheduleView(sSourceBookName As String, _
                           aColumnWidths() As Integer, _
                           iFormatWidth As Integer, _
                           iFormatHeight As Integer, _
                           sScheduleType As String, _
                           iPersonID As Integer) As Worksheet
Dim rScheduleFormatTargetRange As Range, rCell As Range
Dim wsCache As Worksheet
Dim wbCache As Workbook
Dim sScheduleSheetName As String
Dim dValues As Dictionary
Dim i As Integer, j As Integer, iScheduleCurrentRow As Integer, iScheduleCurrentCol As Integer, iColWidthCount As Integer

    DoEventsOff
    
    sScheduleSheetName = "view_" & sScheduleType & "_" & CStr(iPersonID)
    
    Set wbCache = Workbooks(sSourceBookName)
    Set wsCache = CreateSheet(wbCache, sScheduleSheetName, bOverwrite:=True)

    With wbCache.Sheets(sScheduleSheetName)
        ' for each data row (1 row is 1 day / period pair)
        For i = 1 To UBound(vSource)
        
            ' generate a dictionary of the details
            Set dValues = New Dictionary
            For j = 1 To UBound(vSource, 2)
                dValues.Add vColumns(1, j), vSource(i, j)
            Next j
            
            ' paste the formats into the corresponding cell on the "grid"
            iScheduleCurrentRow = iFormatHeight * CInt(dValues("idTimePeriod"))
            iScheduleCurrentCol = iFormatWidth * (CInt(IndexArray(Split(sDayEnum, COMMA), dValues("cdDay"))) + 1)
            Set rScheduleFormatTargetRange = .Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), .Cells(iScheduleCurrentRow + iFormatHeight, iScheduleCurrentCol + iFormatWidth))
            rScheduleFormatTargetRange.Select
            Selection.PasteSpecial Paste:=xlPasteAll, Operation:=xlNone, SkipBlanks:=False, Transpose:=False
            
            ' if this is the first period for a column, set the column widths
            If dValues.Item("idTimePeriod") = "1" Then
                For iColWidthCount = 0 To UBound(aColumnWidths)
                    rScheduleFormatTargetRange.Columns(iColWidthCount + 1).EntireColumn.ColumnWidth = aColumnWidths(iColWidthCount)
                Next iColWidthCount
            End If
            
            ' evaluate the data functions to get the content
            For Each rCell In rScheduleFormatTargetRange.Cells
                If Left(rCell.Value, 1) = "&" Then
                    rCell.Value = Application.Run(Right(rCell.Value, Len(rCell.Value) - 1), dValues)
                End If
            Next rCell
        Next i
    End With
    
    Set BuildScheduleView = wsCache
DoEventsOn
End Function
