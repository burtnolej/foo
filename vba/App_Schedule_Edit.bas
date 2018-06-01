Attribute VB_Name = "App_Schedule_Edit"
Option Explicit
Const C_MODULE_NAME = "App_Schedule_Edit"

Public Sub EditLesson(iPersonID As Integer, _
                      sDayCd As String, _
                      iPeriodID As Integer, _
             Optional eQuadSubDataType As QuadSubDataType = QuadSubDataType.Student)
Dim vPeriodIds() As String, vDayCds() As String
Dim vTmp() As Integer
Dim sCacheSheetName As String
Dim wsCache As Worksheet
Dim iIndex As Integer
Dim dAllDefaultValues As New Dictionary, dDefaultValues As New Dictionary
Dim clsAppRuntime As New App_Runtime

    clsAppRuntime.InitProperties bInitializeCache:=False
    'Set Form_Utils.dDefinitions = LoadDefinitions(clsAppRuntime.TemplateBook.Sheets("Definitions"), _
    '            rSource:=clsAppRuntime.TemplateBook.Sheets("Definitions").Range("Definitions"))
            
    'currently just pulling in studentid 70 by default
    
    Set wsCache = GetScheduleData(clsAppRuntime, iPersonID, QuadDataType.Schedule, eQuadSubDataType, bInTable:=True)
        
    vPeriodIds = GetColumnValues(clsAppRuntime, QuadDataType.Schedule, QuadSubDataType.Lesson, _
                "idTimePeriod", iPersonID:=iPersonID)
    vTmp = IndexArrayMulti(vPeriodIds, CStr(iPeriodID))
    vDayCds = GetColumnValues(clsAppRuntime, QuadDataType.Schedule, QuadSubDataType.Lesson, _
                    "idDay", iPersonID:=iPersonID)

    iIndex = IndexArray(vDayCds, sDayCd, vWhere:=vTmp)
    dDefaultValues.Add "Add_Schedule_Lesson", Row2Dict(wsCache, clsAppRuntime.CacheRangeName, iIndex + 1)

    GenerateForms clsAppRuntime, sFormName:="Add_Schedule_Lesson", dDefaultValues:=dDefaultValues, _
        bSetAsValid:=True

End Sub

