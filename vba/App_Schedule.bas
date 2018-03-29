Attribute VB_Name = "App_Schedule"
'Public Function GetScheduleDataFromDB
'Public Function GetScheduleCellColWidths
'Public Function GetScheduleCellFormat
'Function GetScheduleDataHelpers
'Public Function BuildSchedule
'Public Function BuildScheduleView

Option Explicit
Const C_MODULE_NAME = "App_Schedule"

Public Function BuildSchedule(clsQuadRuntime As Quad_Runtime, sScheduleType As String, iPersonID As Integer) As Worksheet
'"""Using data from the database, and a format template, create a visual schedule on a new sheet
'param:sScheduleType, string, either student or teacher
'param:iPersonalId, integer, value of the student or teacher to retreive the schedule for
'rtype:Worksheet, the sheet object where the schedule view has been written
'"""
Dim sResultFileName As String, sDataType As String, sFuncName As String, sTemplateRangeName As String, sCacheSheetName As String
Dim aSchedule() As String
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildSchedule"

    ' Assertions --------------------------------
    If InArray(Array("student", "teacher"), sScheduleType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sScheduleType needs to be in [student|teacher] got [" & sScheduleType & "]"
    End If
    ' END Assertions --------------------------------
    
    sDataType = "schedule"
    sTemplateRangeName = "f" & sScheduleType & "ScheduleCell"
    FuncLogIt sFuncName, "Template range name not set so defaulting to  [" & sTemplateRangeName & "]", C_MODULE_NAME, LogMsgType.INFO
    
main:
    If IsDataCached(clsQuadRuntime, sDataType, sScheduleType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & sScheduleType & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results
        GetScheduleDataFromDB clsQuadRuntime, iPersonID, sScheduleType
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, sDataType, sScheduleType, iPersonID)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & sScheduleType & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, sDataType, sScheduleType, iPersonID, bCacheNameOnly:=True)
    End If
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsQuadRuntime, sTemplateRangeName, iColWidthCount)
    ' store the data needed to build the schedules as a module member variable for easy access
    GetScheduleDataHelpers clsQuadRuntime, sCacheSheetName
    ' draw the schedule
    Set BuildSchedule = BuildScheduleView(clsQuadRuntime, aColumnWidths, iFormatWidth, iFormatHeight, sScheduleType, iPersonID)
  
End Function
Public Sub GetScheduleDataFromDB(clsQuadRuntime As Quad_Runtime, sPersonId As Integer, sScheduleType As String, _
                             Optional sPeriod As String, _
                             Optional sDay As String)

Dim sResultFileName As String, sSpName As String, sResults As String, sFuncName As String
Dim dSpArgs As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleDataFromDB"
    
    ' Assertions --------------------------------
    If InArray(Array("student", "teacher"), sScheduleType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sScheduleType needs to be in [student|teacher] got [" & sScheduleType & "]"
    End If
    
    If IsValidPersonID(clsQuadRuntime, sPersonId, sScheduleType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
    Else
         FuncLogIt sFuncName, "[" & sScheduleType & "] id[" & CStr(sPersonId) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
    End If
    ' END Assertions ----------------------------

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
    
    GetQuadDataFromDB clsQuadRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=True

End Sub
Function GetScheduleDataHelpers(clsQuadRuntime As Quad_Runtime, sCacheSheetName As String)
Dim iScheduleWidth As Integer, iScheduleHeight As Integer

    ' Assertions --------------------------------
    ' END Assertions ----------------------------
    
    With clsQuadRuntime.CacheBook.Sheets(sCacheSheetName)
        .Activate
        With .Range(clsQuadRuntime.CacheRangeName)
            iScheduleWidth = .Columns.Count
            iScheduleHeight = .Rows.Count
            
            ReDim vSource(1 To iScheduleHeight - 1, 1 To iScheduleWidth)
            ReDim vColumns(1 To 1, 1 To iScheduleWidth)

            .Rows(1).Select
            clsQuadRuntime.CurrentSheetColumns = .Resize(1)
            clsQuadRuntime.CurrentSheetSource = .Resize(.Rows.Count - 1).Offset(1)
        End With
    End With

End Function
Public Sub GetScheduleCellFormat(clsQuadRuntime As Quad_Runtime, ByRef iFormatWidth As Integer, _
                                 ByRef iFormatHeight As Integer, sScheduleFormatRangeName As String)
'gets the template for the cell and puts it into the clipboard
'param: sSourceBookName, string, the book that holds the templates (vba_source_new.xlsm)
'param: sSourceSheetName, string, the sheet in sSourceBookName that holds the templates (FormStyles)
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell


'this is where i had got up to .. adding assertions and logging ....
'need to go through and default cache book to Quad_Utils in the signature
Dim rScheduleFormatRange As Range
    With clsQuadRuntime.TemplateSheet
        .Activate
        Set rScheduleFormatRange = .Range(sScheduleFormatRangeName)
        rScheduleFormatRange.Select
        Selection.Copy
    End With
        
    iFormatWidth = rScheduleFormatRange.Columns.Count
    iFormatHeight = rScheduleFormatRange.Rows.Count
    
End Sub
        
Public Function GetScheduleCellColWidths(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim aColumnWidths() As Integer
Dim rCell As Range

    ReDim aColumnWidths(0 To 20)
    With clsQuadRuntime.TemplateSheet
        .Activate
        For Each rCell In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rCell.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rCell
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetScheduleCellColWidths = aColumnWidths
End Function

Function BuildScheduleView(clsQuadRuntime As Quad_Runtime, aColumnWidths() As Integer, _
                           iFormatWidth As Integer, iFormatHeight As Integer, _
                           sScheduleType As String, iPersonID As Integer) As Worksheet
Dim rScheduleFormatTargetRange As Range, rCell As Range
Dim wsCache As Worksheet
Dim wbCache As Workbook
Dim sScheduleSheetName As String
Dim dValues As Dictionary
Dim i As Integer, j As Integer, iScheduleCurrentRow As Integer, iScheduleCurrentCol As Integer, iColWidthCount As Integer

    DoEventsOff
    
    sScheduleSheetName = "view_" & sScheduleType & "_" & CStr(iPersonID)
    
    Set wsCache = CreateSheet(clsQuadRuntime.Book, sScheduleSheetName, bOverwrite:=True)

    With clsQuadRuntime.Book.Sheets(sScheduleSheetName)
        .Activate
        ' for each data row (1 row is 1 day / period pair)
        For i = 1 To UBound(clsQuadRuntime.CurrentSheetSource)
        
            ' generate a dictionary of the details
            Set dValues = New Dictionary
            For j = 1 To UBound(clsQuadRuntime.CurrentSheetSource, 2)
                dValues.Add clsQuadRuntime.CurrentSheetColumns(1, j), clsQuadRuntime.CurrentSheetSource(i, j)
            Next j
            
            ' paste the formats into the corresponding cell on the "grid"
            iScheduleCurrentRow = iFormatHeight * CInt(dValues("idTimePeriod"))
            iScheduleCurrentCol = iFormatWidth * (CInt(IndexArray(Split(clsQuadRuntime.DayEnum, COMMA), dValues("cdDay"))) + 1)
            Set rScheduleFormatTargetRange = .Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
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
