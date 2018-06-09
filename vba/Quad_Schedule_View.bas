Attribute VB_Name = "Quad_Schedule_View"
'Public Function GetScheduleDataFromDB
'Public Function GetScheduleWidgetColWidths
'Public Function GetScheduleWidgetFormat
'Function GetScheduleDataHelpers
'Public Function BuildSchedule
'Public Function BuildScheduleView

Option Explicit
Const C_MODULE_NAME = "Quad_Schedule_View"

Public Function GetNextClassLectureID() As Integer
' this should do a max on the table column
    GetNextClassLectureID = 10000
End Function

Function AddAddLesson(clsAppRuntime As App_Runtime, _
                dValues As Dictionary, sTemplateRangeName As String, _
                iStudentID As Integer, _
                Optional eQuadDataSubType As QuadSubDataType = QuadSubDataType.Student) As Range
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer
Dim aColumnWidths() As Integer
Dim sSheetName As String, sTableName As String, sTemplateRowRangeName As String, sTemplateColRangeName As String
Dim wsSchedule As Worksheet, wsTable As Worksheet
Dim rTemplateSource As Range
    
    ' this is about adding a new lesson to a schedule view
    clsAppRuntime.ScheduleBook.Windows(1).Visible = False
    
    sSheetName = "view_" & EnumQuadSubDataType(eQuadDataSubType) & "_" & CStr(iStudentID)
    If SheetExists(clsAppRuntime.ScheduleBook, sSheetName) = False Then
        Set wsSchedule = CreateSheet(clsAppRuntime.ScheduleBook, sSheetName)
        
        ' draw headers
        sTemplateRowRangeName = "f" & "student" & "ScheduleRowLabel"
        GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRowRangeName
        BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.PeriodEnum, iFormatWidth, iFormatHeight
    
        sTemplateColRangeName = "f" & "student" & "ScheduleColLabel"
        GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateColRangeName
        BuildScheduleHeaderView clsAppRuntime, wsSchedule, clsAppRuntime.DayEnum, iFormatWidth, iFormatHeight, iStartCol:=4, iStartRow:=2, bVz:=False

    Else
        Set wsSchedule = GetSheet(clsAppRuntime.ScheduleBook, sSheetName)
    End If
    
    sTableName = "schedule_" & EnumQuadSubDataType(eQuadDataSubType)
    
    ' if Table does not exist
    If SheetExists(clsAppRuntime.CacheBook, sTableName) = False Then
        Set wsTable = CreateTable(sTableName, wbTmp:=clsAppRuntime.CacheBook)
    Else
        Set wsTable = GetSheet(clsAppRuntime.CacheBook, sTableName)
    End If
    
    ' copy the template format to the clipboard
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' get the desired column widths from the template and return in an array
    aColumnWidths = GetScheduleCellColWidths(clsAppRuntime, sTemplateRangeName, iColWidthCount)
        
    Set AddAddLesson = BuildScheduleCellView(clsAppRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths)

    AddTableRecordFromDict wsTable, sTableName, dValues
    
    clsAppRuntime.ScheduleBook.Windows(1).Visible = True
End Function


Public Sub GenerateScheduleLessonListView(clsAppRuntime As App_Runtime, iStudentID As Integer)
'<<<
'purpose: Create a list view type form showing a persons scheduled events
'param  : clsAppRuntime,App_Runtime; all config controlling names of books, sheets, ranges for
'       :                 also contains any variables that need to be passed continually
'rtype  :
'>>>
Dim sFuncName As String, sSheetName As String, sDefn As String, sDataType As String, sSubDataType As String
Dim wsTmp As Worksheet
Dim eTestResult As TestResult
Dim lStartTick As Long
Dim vValues() As Variant
Dim rData As Range, rHeader As Range

setup:
    
    sFuncName = C_MODULE_NAME & "." & "GenerateScheduleListView"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    sSheetName = "test"
    CreateSheet clsAppRuntime.TemplateBook, sSheetName, bOverwrite:=True
    
main:
    sDataType = "Schedule"
    sSubDataType = "Lesson"
    GetDefinition clsAppRuntime, sDataType, sSubDataType, sSheetName, FormType.ViewList
    
      
    Set wsTmp = GetScheduleData(clsAppRuntime, iStudentID, QuadDataType.Schedule, QuadSubDataType.Lesson, bInTable:=True)
    Set rData = wsTmp.Range("data")
    Set rData = rData.Offset(1).Resize(rData.Rows.Count - 1)
    
    vValues = rData
    
    GenerateForms clsAppRuntime, vValues:=vValues, bLoadRefData:=True

cleanup:
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    
End Sub

Public Function BuildSchedule(clsAppRuntime As App_Runtime, _
                              eQuadSubDataType As QuadSubDataType, _
                              iPersonID As Integer) As Worksheet
'"""Using data from the database, and a format template, create a visual schedule on a new sheet
'param:sScheduleType, string, either student or teacher
'param:iPersonalId, integer, value of the student or teacher to retreive the schedule for
'rtype:Worksheet, the sheet object where the schedule view has been written
'"""
Dim sResultFileName As String, sFuncName As String, sTemplateRangeName As String, sCacheSheetName As String
Dim aSchedule() As Variant
Dim aColumnWidths() As Integer
Dim iFormatWidth As Integer, iFormatHeight As Integer, iColWidthCount As Integer

setup:
    sFuncName = C_MODULE_NAME & "." & "BuildSchedule"
    sTemplateRangeName = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"
    FuncLogIt sFuncName, "Template range name not set so defaulting to  [" & sTemplateRangeName & "]", C_MODULE_NAME, LogMsgType.INFO

        
main:
    If IsDataCached(clsAppRuntime, QuadDataType.Schedule, eQuadSubDataType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results
        GetPersonScheduleDataFromDB clsAppRuntime, iPersonID, eQuadSubDataType
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, _
                            eQuadSubDataType, iPersonID, bInTable:=True)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, eQuadSubDataType, _
                            iPersonID, bCacheNameOnly:=True)
    End If
    ' get the template widths and heights
    GetScheduleCellFormat clsAppRuntime, iFormatWidth, iFormatHeight, sTemplateRangeName
    ' store the data needed to build the schedules as a module member variable for easy access
    GetScheduleDataHelpers clsAppRuntime, sCacheSheetName
    ' draw the schedule
    Set BuildSchedule = BuildScheduleView(clsAppRuntime, aColumnWidths, iFormatWidth, iFormatHeight, eQuadSubDataType, iPersonID)
  
End Function

Public Function GetScheduleData(clsAppRuntime As App_Runtime, _
                                iPersonID As Integer, _
                              eQuadDataType As QuadDataType, _
                              eQuadSubDataType As QuadSubDataType, _
                     Optional eQuadScope As QuadScope = QuadScope.specified, _
                     Optional bInTable As Boolean = False) As Worksheet

Dim sCacheSheetName As String, sFuncName As String
Dim aSchedule() As Variant

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleData"
    
main:
    If IsDataCached(clsAppRuntime, QuadDataType.Schedule, eQuadSubDataType, iPersonID) = False Then
        FuncLogIt sFuncName, "Data cache NOT found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO

        ' get the raw data from the database and return the filename that holds the results
        GetScheduleLessonDataFromDB clsAppRuntime, iPersonID, eQuadSubDataType
                                     
        ' parse the raw data in the result file and return an array of the data
        aSchedule = ParseRawData(ReadFile(clsAppRuntime.ResultFileName))
        ' store the parsed raw data in a back sheet, return the sheet name
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, _
                            eQuadSubDataType, iDataID:=iPersonID, bInTable:=bInTable)
    Else
        FuncLogIt sFuncName, "Data cache found for [" & EnumQuadSubDataType(eQuadSubDataType) & "_" & CStr(iPersonID) & "]", C_MODULE_NAME, LogMsgType.INFO
        sCacheSheetName = CacheData(clsAppRuntime, aSchedule, QuadDataType.Schedule, eQuadSubDataType, _
                            iPersonID, bCacheNameOnly:=True, bInTable:=bInTable)
    End If
    
    Set GetScheduleData = clsAppRuntime.CacheBook.Sheets(sCacheSheetName)
End Function
    
Public Sub GetScheduleLessonDataFromDB(clsAppRuntime As App_Runtime, _
                                 sPersonId As Integer, _
                                 eQuadSubDataType As QuadSubDataType, _
                        Optional sPeriod As String, _
                        Optional sDay As String)

Dim sResultFileName As String, sSpName As String, sResults As String, sFuncName As String
Dim dSpArgs As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleLessonDataFromDB"
    
    ' Assertions --------------------------------
    If IsValidPersonID(clsAppRuntime, sPersonId, eQuadSubDataType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
    Else
         FuncLogIt sFuncName, "[" & EnumQuadSubDataType(eQuadSubDataType) & "] id[" & CStr(sPersonId) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
    End If
    ' END Assertions ----------------------------

main:
    sSpName = "schedule_lesson"

    dSpArgs.Add "students", InitVariantArray(Array(sPersonId))

    FuncLogIt sFuncName, "schedule type is [" & EnumQuadSubDataType(eQuadSubDataType) & "] using sp [" & sSpName & "]", C_MODULE_NAME, LogMsgType.INFO
    
    If sPeriod <> "" Then
        dSpArgs.Add "periods", InitVariantArray(Split(sPeriod, ","))
        FuncLogIt sFuncName, "Period WHERE clause specified  [" & sPeriod & "]", C_MODULE_NAME, LogMsgType.INFO
    End If

    If sDay <> "" Then
        dSpArgs.Add "days", InitVariantArray(Split(sDay, ","))
        FuncLogIt sFuncName, "Day WHERE clause specified  [" & sDay & "]", C_MODULE_NAME, LogMsgType.INFO
    End If
    
    GetQuadDataFromDB clsAppRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=True

End Sub

Public Sub GetPersonScheduleDataFromDB(clsAppRuntime As App_Runtime, _
                                 sPersonId As Integer, _
                                 eQuadSubDataType As QuadSubDataType, _
                        Optional sPeriod As String, _
                        Optional sDay As String)

Dim sResultFileName As String, sSpName As String, sResults As String, sFuncName As String
Dim dSpArgs As New Dictionary

setup:
    sFuncName = C_MODULE_NAME & "." & "GetScheduleLessonDataFromDB"
    
    ' Assertions --------------------------------
    If IsValidPersonID(clsAppRuntime, sPersonId, eQuadSubDataType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="not a valid person id"
    Else
         FuncLogIt sFuncName, "[" & EnumQuadSubDataType(eQuadSubDataType) & "] id[" & CStr(sPersonId) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
    End If
    ' END Assertions ----------------------------

main:
    If eQuadSubDataType = QuadSubDataType.Student Then
        sSpName = "student_schedule"
        dSpArgs.Add "students", InitVariantArray(Array(sPersonId))
    ElseIf eQuadSubDataType = QuadSubDataType.Teacher Then
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
    
    GetQuadDataFromDB clsAppRuntime, sSpName, dSpArgs:=dSpArgs, bHeaderFlag:=True

End Sub
Function GetScheduleDataHelpers(clsAppRuntime As App_Runtime, sCacheSheetName As String)
Dim iScheduleWidth As Integer, iScheduleHeight As Integer
Dim rSource As Range
    ' Assertions --------------------------------
    ' END Assertions ----------------------------
    
    Set rSource = clsAppRuntime.CacheBook.Sheets(sCacheSheetName).Range(clsAppRuntime.CacheRangeName)
    iScheduleWidth = rSource.Columns.Count
    iScheduleHeight = rSource.Rows.Count

    clsAppRuntime.CurrentSheetColumns = rSource.Rows(1)
    clsAppRuntime.CurrentSheetSource = rSource.Resize(rSource.Rows.Count - 1).Offset(1)
    
End Function


Public Sub GetScheduleCellFormat(clsAppRuntime As App_Runtime, ByRef iFormatWidth As Integer, _
                                 ByRef iFormatHeight As Integer, sScheduleFormatRangeName As String)
'gets the template for the cell and puts it into the clipboard
'param: sSourceBookName, string, the book that holds the templates (vba_source_new.xlsm)
'param: sSourceSheetName, string, the sheet in sSourceBookName that holds the templates (FormStyles)
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim rScheduleFormatRange As Range

    Set rScheduleFormatRange = clsAppRuntime.TemplateBook.Names(sScheduleFormatRangeName).RefersToRange
    rScheduleFormatRange.Copy
    iFormatWidth = rScheduleFormatRange.Range(sScheduleFormatRangeName).Columns.Count
    iFormatHeight = rScheduleFormatRange.Range(sScheduleFormatRangeName).Rows.Count

End Sub
        
Public Function GetScheduleCellColWidths(clsAppRuntime As App_Runtime, sScheduleFormatRangeName As String, _
                                         iColWidthCount As Integer) As Integer()
' get the column widths from the template and return in an integer array
'param: sScheduleFormatRangeName, string, named range that contains the specific format (fStudentScheduleCell
Dim aColumnWidths() As Integer
Dim rWidget As Range

    ReDim aColumnWidths(0 To 20)
    With clsAppRuntime.TemplateSheet
        '.Activate
        For Each rWidget In Selection.Rows(1).Cells
            aColumnWidths(iColWidthCount) = rWidget.EntireColumn.ColumnWidth
            iColWidthCount = iColWidthCount + 1
        Next rWidget
        ReDim Preserve aColumnWidths(0 To iColWidthCount - 1)
    End With
    
    GetScheduleCellColWidths = aColumnWidths
End Function

Function BuildScheduleCellView(clsAppRuntime As App_Runtime, _
                          wsSchedule As Worksheet, _
                          ByVal dValues As Dictionary, _
                          iFormatWidth As Integer, iFormatHeight As Integer, _
                          aColumnWidths() As Integer, _
                Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student, _
                Optional iViewRowOffset As Integer = 0, _
                Optional iViewColOffset As Integer = 2) As Range

Dim iScheduleCurrentRow As Integer, iScheduleCurrentCol As Integer, iColWidthCount As Integer
Dim rScheduleFormatTargetRange As Range, rWidget As Range
Dim sFormatTemplateRange As String, sDayCd As String

    sFormatTemplateRange = "f" & EnumQuadSubDataType(eQuadSubDataType) & "ScheduleCell"
    
    With wsSchedule
    
        iScheduleCurrentRow = iFormatHeight * CInt(dValues("idTimePeriod")) + iViewRowOffset
        
        If dValues.Exists("cdDay") Then
            iScheduleCurrentCol = 2 + (iFormatWidth * (CInt(IndexArray(Split(clsAppRuntime.DayEnum, COMMA), _
                                            dValues("cdDay"))))) + iViewColOffset
        Else
            sDayCd = CrossRefQuadData(clsAppRuntime, QuadDataType.Misc, QuadSubDataType.Day, _
                        "idDay", dValues("idDay"), "cdDay")
            iScheduleCurrentCol = 2 + (iFormatWidth * (CInt(IndexArray(Split(clsAppRuntime.DayEnum, COMMA), _
                                       sDayCd)))) + iViewColOffset
        End If
                                      
        Set rScheduleFormatTargetRange = wsSchedule.Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), _
                    .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
        
        rScheduleFormatTargetRange.PasteSpecial Paste:=xlPasteAll, operation:=xlNone, SkipBlanks:=False, Transpose:=False
        FormatColRowSize clsAppRuntime.TemplateBook, clsAppRuntime.ScheduleBook, _
                wsSchedule.Name, clsAppRuntime.TemplateSheetName, sFormatTemplateRange, _
                iTargetFirstRow:=iScheduleCurrentRow, iTargetFirstCol:=iScheduleCurrentCol
        
        
        ' evaluate the data functions to get the content
        For Each rWidget In rScheduleFormatTargetRange.Cells
            If Left(rWidget.value, 1) = "&" Then
                rWidget.value = Application.Run(Right(rWidget.value, Len(rWidget.value) - 1), dValues)
            End If
        Next rWidget
    End With
    
    Set BuildScheduleCellView = rScheduleFormatTargetRange
End Function
Function BuildScheduleView(clsAppRuntime As App_Runtime, _
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
    
    If SheetExists(clsAppRuntime.ScheduleBook, sScheduleSheetName) = True Then
        Set wsSchedule = GetSheet(clsAppRuntime.ScheduleBook, sScheduleSheetName)
    Else
        Set wsSchedule = CreateSheet(clsAppRuntime.ScheduleBook, sScheduleSheetName, bOverwrite:=True)
    End If
    
    For i = 1 To UBound(clsAppRuntime.CurrentSheetSource)
    
        ' generate a dictionary of the details
        Set dValues = New Dictionary
        For j = 1 To UBound(clsAppRuntime.CurrentSheetSource, 2)
            dValues.Add clsAppRuntime.CurrentSheetColumns(1, j), clsAppRuntime.CurrentSheetSource(i, j)
        Next j
        
        BuildScheduleCellView clsAppRuntime, wsSchedule, dValues, iFormatWidth, iFormatHeight, aColumnWidths
    Next i
    
    Set BuildScheduleView = wsSchedule
DoEventsOn
End Function

Function BuildScheduleHeaderView(clsAppRuntime As App_Runtime, _
                          wsSchedule As Worksheet, _
                          sEnums As String, _
                          iFormatWidth As Integer, iFormatHeight As Integer, _
                Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student, _
                Optional iStartRow As Integer = 3, _
                Optional iStartCol As Integer = 1, _
                Optional bVz As Boolean = True) As Range

Dim iScheduleCurrentRow As Integer, iColWidthCount As Integer, i As Integer, iScheduleCurrentCol As Integer
Dim rScheduleFormatTargetRange As Range, rWidget As Range, rMarker As Range
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
            
            Set rScheduleFormatTargetRange = wsSchedule.Range(.Cells(iScheduleCurrentRow, iScheduleCurrentCol), .Cells(iScheduleCurrentRow + iFormatHeight - 1, iScheduleCurrentCol + iFormatWidth - 1))
            rScheduleFormatTargetRange.PasteSpecial Paste:=xlPasteAll, operation:=xlNone, SkipBlanks:=False, Transpose:=False
            
            FormatColRowSize clsAppRuntime.TemplateBook, clsAppRuntime.ScheduleBook, _
                    wsSchedule.Name, clsAppRuntime.TemplateSheetName, sFormatTemplateRange, _
                    iTargetFirstRow:=iScheduleCurrentRow, iTargetFirstCol:=iScheduleCurrentCol
        
            ' evaluate the data functions to get the content
            For Each rWidget In rScheduleFormatTargetRange.Cells
                If Left(rWidget.value, 1) = "&" Then
                    rWidget.value = Application.Run(Right(rWidget.value, Len(rWidget.value) - 1), vEnumValues(i - 1))
                End If
            Next rWidget
            
            ' put inivisble markets in row 1 and col 1 so context menu's know what cell
            If bVz = True Then
                Set rMarker = wsSchedule.Range(.Cells(iScheduleCurrentRow, 1), .Cells(iScheduleCurrentRow + iFormatHeight - 1, 1))
            Else
                Set rMarker = wsSchedule.Range(.Cells(1, iScheduleCurrentCol), .Cells(1, iScheduleCurrentCol + iFormatWidth - 1))
            End If
            rMarker.value = vEnumValues(i - 1)
            SetFgColor wsSchedule.Name, rMarker.Address, 255, 255, 255, wbTmp:=clsAppRuntime.ScheduleBook
        Next i
    End With
    
    Set BuildScheduleHeaderView = rScheduleFormatTargetRange
End Function

