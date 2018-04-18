Attribute VB_Name = "App_Schedule"
'Public Function GetScheduleDataFromDB
'Public Function GetScheduleCellColWidths
'Public Function GetScheduleCellFormat
'Function GetScheduleDataHelpers
'Public Function BuildSchedule
'Public Function BuildScheduleView

Option Explicit
Const C_MODULE_NAME = "App_Schedule"

Public Function BuildSchedule(clsQuadRuntime As Quad_Runtime, _
                              eQuadSubDataType As QuadSubDataType, _
                              iPersonID As Integer) As Worksheet
'"""Using data from the database, and a format template, create a visual schedule on a new sheet
'param:sScheduleType, string, either student or teacher
'param:iPersonalId, integer, value of the student or teacher to retreive the schedule for
'rtype:Worksheet, the sheet object where the schedule view has been written
'"""
Dim sResultFileName As String, sFuncName As String, sTemplateRangeName As String, sCacheSheetName As String
Dim aSchedule() As String
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildSchedule"
    sTemplateRangeName = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"
    FuncLogIt sFuncName, "Template range name not set so defaulting to  [" & sTemplateRangeName & "]", C_MODULE_NAME, LogMsgType.INFO
    
main:
    If IsDataCached(clsQuadRuntime, QuadDataType.schedule, eQuadSubDataType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results
        GetScheduleDataFromDB clsQuadRuntime, iPersonID, eQuadSubDataType
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, QuadDataType.schedule, _
                            eQuadSubDataType, iPersonID)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, QuadDataType.schedule, eQuadSubDataType, _
                            iPersonID, bCacheNameOnly:=True)
    End If
    ' get the template widths and heights
    GetScheduleCellFormat clsQuadRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' store the data needed to build the schedules as a module member variable for easy access
    GetScheduleDataHelpers clsQuadRuntime, sCacheSheetName
    ' draw the schedule
    Set BuildSchedule = BuildScheduleView(clsQuadRuntime, aColumnWidths, iFormatWidth, iFormatHeight, eQuadSubDataType, iPersonID)
  
End Function
Public Sub GetScheduleDataFromDB(clsQuadRuntime As Quad_Runtime, _
                                 sPersonId As Integer, _
                                 eQuadSubDataType As QuadSubDataType, _
                        Optional sPeriod As String, _
                        Optional sDay As String)

Dim sResultFileName As String, sSpName As String, sResults As String, sFuncName As String
Dim dSpArgs As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleDataFromDB"
    
    ' Assertions --------------------------------
    If IsValidPersonID(clsQuadRuntime, sPersonId, eQuadSubDataType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
    Else
         FuncLogIt sFuncName, "[" & EnumQuadSubDataType(eQuadSubDataType) & "] id[" & CStr(sPersonId) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
    End If
    ' END Assertions ----------------------------

main:
    If eQuadSubDataType = QuadSubDataType.Student Then
        sSpName = "student_schedule"
        dSpArgs.Add "students", InitVariantArray(Array(sPersonId))
    ElseIf eQuadSubDataType = QuadSubDataType.teacher Then
        sSpName = "teacher_schedule"
        dSpArgs.Add "teachers", InitVariantArray(Array(sPersonId))
    End If
    FuncLogIt sFuncName, "schedule type is [" & EnumQuadSubDataType(eQuadSubDataType) & "] using sp [" & sSpName & "]", C_MODULE_NAME, LogMsgType.INFO
    
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
Dim rSource As Range
    ' Assertions --------------------------------
    ' END Assertions ----------------------------
    
    Set rSource = clsQuadRuntime.CacheBook.Sheets(sCacheSheetName).Range(clsQuadRuntime.CacheRangeName)
    iScheduleWidth = rSource.Columns.Count
    iScheduleHeight = rSource.Rows.Count

    clsQuadRuntime.CurrentSheetColumns = rSource.Rows(1)
    clsQuadRuntime.CurrentSheetSource = rSource.Resize(rSource.Rows.Count - 1).Offset(1)
    
End Function


Public Sub GetScheduleCellFormat(clsQuadRuntime As Quad_Runtime, ByRef iFormatWidth As Integer, _
                                 ByRef iFormatHeight As Integer, sScheduleFormatRangeName As String)
'gets the template for the cell and puts it into the clipboard
'param: sSourceBookName, string, the book that holds the templates (vba_source_new.xlsm)
'param: sSourceSheetName, string, the sheet in sSourceBookName that holds the templates (FormStyles)
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell

Dim rScheduleFormatRange As Range
    With clsQuadRuntime.TemplateSheet
        '.Activate
        'Set rScheduleFormatRange = .Range(sScheduleFormatRangeName)
        'rScheduleFormatRange.Select
        'Selection.Copy
        .Range(sScheduleFormatRangeName).Copy
        
    'End With
        
    'iFormatWidth = Selection.Columns.Count
    'iFormatHeight = Selection.Rows.Count
    
        iFormatWidth = .Range(sScheduleFormatRangeName).Columns.Count
        iFormatHeight = .Range(sScheduleFormatRangeName).Rows.Count
    
    End With
    
End Sub
        
Public Function GetScheduleCellColWidths(clsQuadRuntime As Quad_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim aColumnWidths() As Integer
Dim rCell As Range

    ReDim aColumnWidths(0 To 20)
    With clsQuadRuntime.TemplateSheet
        '.Activate
        For Each rCell In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rCell.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rCell
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetScheduleCellColWidths = aColumnWidths
End Function

Function BuildScheduleCellView(clsQuadRuntime As Quad_Runtime, _
                          wsSchedule As Worksheet, _
                          dValues As Dictionary, _
                          iFormatWidth As Integer, iFormatHeight As Integer, _
                          aColumnWidths() As Integer, _
                Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student, _
                Optional iViewRowOffset As Integer = 0, _
                Optional iViewColOffset As Integer = 2) As Range

Dim iScheduleCurrentRow As Integer, iScheduleCurrentCol As Integer, iColWidthCount As Integer
Dim rScheduleFormatTargetRange As Range, rCell As Range
Dim sFormatTemplateRange As String

    sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"
    With wsSchedule
        ' paste the formats into the corresponding cell on the "grid"
        iScheduleCurrentRow = iFormatHeight * CInt(dValues("idTimePeriod")) + iViewRowOffset
        iScheduleCurrentCol = 2 + (iFormatWidth * (CInt(IndexArray(Split(clsQuadRuntime.DayEnum, COMMA), _
                                        dValues("cdDay"))))) + iViewColOffset
        
        Set rScheduleFormatTargetRange = wsSchedule.Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), _
                    .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
        
        rScheduleFormatTargetRange.PasteSpecial Paste:=xlPasteAll, operation:=xlNone, SkipBlanks:=False, Transpose:=False
        FormatColRowSize clsQuadRuntime.TemplateBook, clsQuadRuntime.ScheduleBook, _
                wsSchedule.Name, clsQuadRuntime.TemplateSheetName, sFormatTemplateRange, _
                iTargetFirstRow:=iScheduleCurrentRow, iTargetFirstCol:=iScheduleCurrentCol
        
        ' evaluate the data functions to get the content
        For Each rCell In rScheduleFormatTargetRange.Cells
            If Left(rCell.value, 1) = "&" Then
                rCell.value = Application.Run(Right(rCell.value, Len(rCell.value) - 1), dValues)
            End If
        Next rCell
    End With
    
    Set BuildScheduleCellView = rScheduleFormatTargetRange
End Function
Function BuildScheduleView(clsQuadRuntime As Quad_Runtime, _
                           aColumnWidths() As Integer, _
                           iFormatWidth As Integer, _
                           iFormatHeight As Integer, _
                           eQuadSubDataType As QuadSubDataType, _
                           iPersonID As Integer) As Worksheet
Dim wsSchedule As Worksheet
Dim sScheduleSheetName As String
Dim dValues As Dictionary
Dim i As Integer, j As Integer

    DoEventsOff
    
    sScheduleSheetName = "view_" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID)
    
    Set wsSchedule = CreateSheet(clsQuadRuntime.ScheduleBook, sScheduleSheetName, bOverwrite:=True)

    For i = 1 To UBound(clsQuadRuntime.CurrentSheetSource)
    
        ' generate a dictionary of the details
        Set dValues = New Dictionary
        For j = 1 To UBound(clsQuadRuntime.CurrentSheetSource, 2)
            dValues.Add clsQuadRuntime.CurrentSheetColumns(1, j), clsQuadRuntime.CurrentSheetSource(i, j)
        Next j
        
        BuildScheduleCellView clsQuadRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths
    Next i
    
    Set BuildScheduleView = wsSchedule
DoEventsOn
End Function

Function BuildScheduleHeaderView(clsQuadRuntime As Quad_Runtime, _
                          wsSchedule As Worksheet, _
                          sEnums As String, _
                          iFormatWidth As Integer, iFormatHeight As Integer, _
                Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student, _
                Optional iStartRow As Integer = 3, _
                Optional iStartCol As Integer = 1, _
                Optional bVz As Boolean = True) As Range

Dim iScheduleCurrentRow As Integer, iColWidthCount As Integer, i As Integer, iScheduleCurrentCol As Integer
Dim rScheduleFormatTargetRange As Range, rCell As Range
Dim sFormatTemplateRange As String
Dim iNumValues As Integer
Dim vEnumValues() As String

    vEnumValues = Split(sEnums, COMMA)

    iNumValues = UBound(vEnumValues) + 1
    
    If bVz = True Then
        sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleRowLabel"
    Else
        sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleColLabel"
    End If
    
    With wsSchedule
        For i = 1 To iNumValues

            ' paste the formats into the corresponding cell on the "grid"
            If bVz = True Then
                iScheduleCurrentRow = iStartRow + (iFormatHeight * (i - 1))
                iScheduleCurrentCol = iStartCol
            Else
                iScheduleCurrentRow = iStartRow
                iScheduleCurrentCol = iStartCol + (iFormatWidth * (i - 1))
            End If
            
            'Set rScheduleFormatTargetRange = .Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
            Set rScheduleFormatTargetRange = wsSchedule.Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
            '.Activate
            'HERE
            'rScheduleFormatTargetRange.Select
            '.Activate
            rScheduleFormatTargetRange.PasteSpecial Paste:=xlPasteAll, operation:=xlNone, SkipBlanks:=False, Transpose:=False
            
            FormatColRowSize clsQuadRuntime.TemplateBook, clsQuadRuntime.ScheduleBook, _
                    wsSchedule.Name, clsQuadRuntime.TemplateSheetName, sFormatTemplateRange, _
                    iTargetFirstRow:=iScheduleCurrentRow, iTargetFirstCol:=iScheduleCurrentCol
        
            ' evaluate the data functions to get the content
            For Each rCell In rScheduleFormatTargetRange.Cells
                If Left(rCell.value, 1) = "&" Then
                    rCell.value = Application.Run(Right(rCell.value, Len(rCell.value) - 1), vEnumValues(i - 1))
                End If
            Next rCell
        Next i
    End With
    
    Set BuildScheduleHeaderView = rScheduleFormatTargetRange
End Function

