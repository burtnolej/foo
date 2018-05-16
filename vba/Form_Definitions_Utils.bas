Attribute VB_Name = "Form_Definitions_Utils"
Option Explicit
Const C_MODULE_NAME = "Form_Definitions_Utils"

Enum DefnType
    Lesson = 1
End Enum

Public Const C_DEFN_TYPE = "AddLesson"

Function EnumDefnType(i As Long) As String
    EnumDefnType = Split(C_DEFN_TYPE, COMMA)(i - 1)
End Function

Sub GetDefinition(clsAppRuntime As App_Runtime, eDefnType As DefnType, sSheetName As String, Optional wbTmp As Workbook)
'<<<
'purpose: load definitions required to support the Add Lesson workflow
'param  : clsAppRuntime, App_Runtime; App defaults
'param  : sSheetName, string; where to store the excel representation of the definition
'>>>
Dim sFuncName As String, sDefn As String
Dim vSource() As String
Dim wsTmp As Worksheet
Dim rTarget As Range
Dim lStartTick As Long

setup:
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    sFuncName = C_MODULE_NAME & "." & "GetAddLessonDefinition"
    
    If IsSet(wbTmp) = False Then
        Set wbTmp = clsAppRuntime.TemplateBook
    End If
    
    Set wsTmp = CreateSheet(wbTmp, sSheetName, bOverwrite:=True)
    
main:

    If eDefnType = DefnType.Lesson Then
        ' table: Add lesson
        ' --------------------------------------------------------------------------------
        ' attr : student name
        sDefn = "AddLesson^schedule_student^sStudentFirstNm^String^IsMember^&get_person_student^sStudentFirstNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddLesson^schedule_student^sStudentLastNm^String^IsMember^&get_person_student^sStudentLastNm^^Entry" & DOUBLEDOLLAR
        ' attr : teacher_name
        sDefn = sDefn & "AddLesson^schedule_student^sFacultyFirstNm^String^IsMember^&get_person_teacher^sFacultyFirstNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddLesson^schedule_student^sFacultyLastNm^String^IsMember^&get_person_teacher^sFacultyLastNm^^Entry" & DOUBLEDOLLAR
        ' attr : ref data
        sDefn = sDefn & "AddLesson^schedule_student^sCourseNm^Integer^IsMember^&get_courses_course^sCourseNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddLesson^schedule_student^sSubjectLongDesc^Integer^IsMember^&get_courses_subject^sSubjectLongDesc^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddLesson^schedule_student^idPrep^Integer^IsMember^&get_misc_prep^sPrepNm^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddLesson^schedule_student^idTimePeriod^Integer^IsMember^&get_misc_timeperiod^idTimePeriod^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddLesson^schedule_student^cdDay^Integer^IsMember^&get_misc_day^cdDay^^Entry" & DOUBLEDOLLAR
        
        ' Add student
        sDefn = sDefn & "AddStudent^person_student^sStudentFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddStudent^person_student^sStudentLastNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddStudent^person_student^idStudent^Integer^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddStudent^person_student^idPrep^Integer^IsValidPrep^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddStudent^person_student^sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
        ' Add teacher
        sDefn = sDefn & "AddStudent^person_teacher^sFacultyFirstNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddStudent^person_teacher^sFacultyLastNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddStudent^person_teacher^idFaculty^Integer^^^^^Entry" & DOUBLEDOLLAR
        ' table: Add subject ---------------------------------------------------------------
        sDefn = sDefn & "AddSubject^courses_subject^sSubjectLongDesc^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddSubject^courses_subject^idSubject^String^^^^^Entry" & DOUBLEDOLLAR
        ' table: Add course ---------------------------------------------------------------
        sDefn = sDefn & "AddCourse^courses_course^sCourseNm^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddCourse^courses_course^idCourse^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddCourse^courses_course^idSubject^String^^^^^Entry" & DOUBLEDOLLAR
        ' table: Add timeperiod ---------------------------------------------------------------
        sDefn = sDefn & "AddTimePeriod^misc_timeperiod^idTimePeriod^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddTimePeriod^misc_timeperiod^dtPeriodStart^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddTimePeriod^misc_timeperiod^dtPeriodEnd^String^^^^^Entry" & DOUBLEDOLLAR
        ' table: Add prep ---------------------------------------------------------------
        sDefn = sDefn & "AddPrep^misc_prep^idPrep^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddPrep^misc_prep^sPrepNm^String^^^^^Entry" & DOUBLEDOLLAR
        ' table: Add day ---------------------------------------------------------------
        sDefn = sDefn & "AddDay^misc_day^idDay^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddDay^misc_day^sDayDesc^String^^^^^Entry" & DOUBLEDOLLAR
        sDefn = sDefn & "AddDay^misc_day^cdDay^String^^^^^Entry" & DOUBLEDOLLAR
        ' button: Add lesson ---------------------------------------------------------------
        sDefn = sDefn & "AddLesson^^COMMIT^^^AddLesson^^^Button"
    Else
        err.Raise ErrorMsgType.INVALID_DEFN_TYPE, Description:="[DefnType=" & EnumDefnType(eDefnType) & "]"
    End If
    
    vSource = Init2DStringArrayFromString(sDefn)

    Set rTarget = RangeFromStrArray(vSource, wsTmp, 0, 1)
    CreateNamedRange wbTmp, rTarget.Address, sSheetName, "Definitions", "True"
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource:=rTarget)

cleanup:
    FuncLogIt sFuncName, "Loaded [num defns=" & CStr(UBound(Split(sDefn, DOUBLEDOLLAR))) & "] [sSheetName=" & sSheetName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Sub
        
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Sub

Public Function GetCacheTableName(sRangeName As String) As String
'<<<
'purpose:
'param  :
'param  :
'rtype  : String; i.e. person_student
'>>>
Dim dDetailDefn As Dictionary
Dim sFuncName As String
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "GetCacheTableName"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
    On Error GoTo err
    
main:

    If InStr(sRangeName, BANG) <> 0 Then
        sRangeName = Split(sRangeName, BANG)(1)
    End If
    Set dDetailDefn = dDefinitions.Item(sRangeName)
    GetCacheTableName = dDetailDefn.Item("CacheTableName")
    
    If GetCacheTableName = "" Then
        err.Raise ErrorMsgType.CACHE_TABLE_NAME_CANNOT_BE_BLANK, Description:="[GetCacheTableName=" & GetCacheTableName & "]"
    End If
    
cleanup:
    FuncLogIt sFuncName, "[sRangeName=" & sRangeName & "] [Result=" & GetCacheTableName & "]", C_MODULE_NAME, LogMsgType.DEBUGGING2
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    Exit Function
     
err:
    FuncLogIt sFuncName, "[" & err.Description & "]  raised", C_MODULE_NAME, LogMsgType.Error
    err.Raise err.Number, err.Source, err.Description ' cannot recover from this

End Function
Public Function LoadDefinitions(wsTmp As Worksheet, _
                       Optional rSource As Range = Nothing, _
                       Optional bIgnoreWidgetType As Boolean = False) As Dictionary
'<<<
'purpose: loads the configuration that defines what forms to construct, what widgets to put on the forms
'       : how to validate entries and what actions to take on user input
'param  : wsTmp, worksheet; location of the config
'param  : rSource, range (Optional); where to find config on sheet (defaults to the range named "Definitions" if not specified"
'param  : bIgnoreWidgetType, boolean (Optional); if True then assumes everything is an Entry;
'       : this is to allow for backwards compatability of tests written before WidgetTypes was specified in the config
'rtype  : dictionary;
'>>>
                     
Dim dDefinitions As New Dictionary, dDefnDetail As Dictionary, dDefnActions As New Dictionary, dDefnTables As New Dictionary
Dim rRow As Range
Dim sCacheTableName As String, sFieldname As String, sActionName As String, sValidationType As String, sActionFunc As String
Dim eWidgetType As WidgetType
Dim sValidationParam As String, sFuncName As String, sKey As String
Dim vValidationParams() As String
Dim iCol As Integer, iValidationParamCount As Integer
Dim lStartTick As Long

setup:
    sFuncName = C_MODULE_NAME & "." & "LoadDefinitions"
    lStartTick = FuncLogIt(sFuncName, "", C_MODULE_NAME, LogMsgType.INFUNC)
main:
    If rSource Is Nothing Then
        Set rSource = Range("rDefinitions")
    End If
    
    With wsTmp
        For Each rRow In rSource.Rows
            ReDim vValidationParams(0 To 3)
            'rSource.Select
            iValidationParamCount = 0
            sActionName = rRow.Columns(1)
            sCacheTableName = rRow.Columns(2)
            sFieldname = rRow.Columns(3)
            sValidationType = rRow.Columns(4)
            sValidationParam = rRow.Columns(5)
            sActionFunc = rRow.Columns(8)
            
            If bIgnoreWidgetType = False Then
                eWidgetType = GetWidgetTypeFromValue(rRow.Columns(9))
            Else
                eWidgetType = WidgetType.Entry
            End If
            
            If sCacheTableName = BLANK Then
                If eWidgetType <> WidgetType.Button Then
                    err.Raise ErrorMsgType.CACHE_TABLE_NAME_CANNOT_BE_BLANK, Description:="[sFieldName=" & sFieldname & "] [sCacheTableName=" & sCacheTableName & "]"
                End If
            End If
            
            If sFieldname = BLANK Then
                err.Raise ErrorMsgType.FIELD_NAME_CANNOT_BE_BLANK, Description:="[sFieldName=" & sFieldname & "]"
            End If
            
            Set dDefnDetail = New Dictionary
            dDefnDetail.Add "validation_type", sValidationType
            dDefnDetail.Add "validation_param", sValidationParam
            dDefnDetail.Add "CacheTableName", sCacheTableName
            dDefnDetail.Add "FieldName", sFieldname
            dDefnDetail.Add "WidgetType", eWidgetType
            dDefnDetail.Add "ActionName", sActionFunc
            
            For iCol = 6 To 7
                If rRow.Columns(iCol).value <> "" Then
                    vValidationParams(iValidationParamCount) = rRow.Columns(iCol).value
                    iValidationParamCount = iValidationParamCount + 1
                End If
            Next iCol
            
            If iValidationParamCount > 0 Then
                ReDim Preserve vValidationParams(0 To iValidationParamCount - 1)
                dDefnDetail.Add "validation_args", vValidationParams
            End If
            
            sKey = GetKey(sActionName, sFieldname, eWidgetType)
            
            If dDefinitions.Exists(sKey) = True Then
                FuncLogIt sFuncName, "definition for [" & sKey & "] already loaded", C_MODULE_NAME, LogMsgType.INFO
            Else
                dDefinitions.Add sKey, dDefnDetail
            End If
            
            If dDefnActions.Exists(sActionName) = False Then
                'rRow.Select
                dDefnActions.Add sActionName, Nothing
            End If

            If dDefnTables.Exists(sCacheTableName) = False Then
                dDefnTables.Add sCacheTableName, Nothing
            End If
            
        Next rRow
    End With
    
    dDefinitions.Add "actions", dDefnActions
    dDefinitions.Add "tables", dDefnTables
    
exitfunc:
    Set LoadDefinitions = dDefinitions
    FuncLogIt sFuncName, "", C_MODULE_NAME, LogMsgType.OUTFUNC, lLastTick:=lStartTick
    FuncLogIt sFuncName, "Loaded in [" & CStr(UBound(dDefinitions.Keys())) & "] definitions", C_MODULE_NAME, LogMsgType.DEBUGGING2
    Exit Function

err:
    Set LoadDefinitions = Nothing
    FuncLogIt sFuncName, "loading in definitions in [" & err.Description & "] definitions", C_MODULE_NAME, LogMsgType.Failure

End Function

Public Sub DoLoadDefinitions(Optional clsAppRuntime As App_Runtime)
Dim rSource As Range
Dim wsTmp As Worksheet
Dim wbTmp As Workbook

    If IsSet(clsAppRuntime) = True Then
        Set wbTmp = clsAppRuntime.TemplateBook
        Set wsTmp = wbTmp.Sheets(clsAppRuntime.DefinitionSheetName)
    Else
        Set wbTmp = ActiveWorkbook
        Set wsTmp = wbTmp.Sheets(clsAppRuntime.DefinitionSheetName)
    End If
    
    Set rSource = wsTmp.Range("Definitions")
    Set Form_Utils.dDefinitions = LoadDefinitions(wsTmp, rSource)
    
    End Sub

Public Sub DumpDefinitions(Optional bLog As Boolean = True, Optional bWorksheet As Boolean = False)
Dim sKey As Variant
Dim vDetail As Variant
Dim sFuncName As String, sDetail As String
Dim dDefnDetail As Dictionary
Dim sOutput As String

    sFuncName = C_MODULE_NAME & "." & "DumpDefinitions"
    
    For Each sKey In dDefinitions.Keys
        If sKey <> "actions" And sKey <> "tables" Then
            Set dDefnDetail = dDefinitions.Item(sKey)
            sOutput = sOutput & vbNewLine & sKey & vbNewLine
            For Each vDetail In dDefnDetail.Keys
                If MyVarType(dDefnDetail.Item(vDetail)) = 46 Then
                    sDetail = "[" & Join(dDefnDetail.Item(CStr(vDetail)), COMMA) & "]"
                Else
                    sDetail = dDefnDetail.Item(vDetail)
                End If
                sOutput = sOutput & PadStr(CStr(vDetail), "left", 20, " ") & " = " & PadStr(sDetail, "right", 20, " ") & vbNewLine
            Next vDetail
        End If
        Debug.Print sOutput
        sOutput = ""
    Next sKey
    
    Debug.Print sOutput
End Sub
