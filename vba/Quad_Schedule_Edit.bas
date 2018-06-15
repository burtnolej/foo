Attribute VB_Name = "Quad_Schedule_Edit"
Option Explicit
Const C_MODULE_NAME = "Quad_Schedule_Edit"

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
Dim dArgs As New Dictionary

    clsAppRuntime.InitProperties bInitializeCache:=False
    
    AddArgs dArgs, False, "clsAppRuntime", clsAppRuntime, "iStudentID", iPersonID, "eQuadDataType", QuadDataType.Schedule, _
                    "eQuadSubDataType", eQuadSubDataType, "bInTable", True
    'Set wsCache = GetScheduleData(clsAppRuntime, iPersonID, QuadDataType.Schedule, eQuadSubDataType, bInTable:=True)
    Set wsCache = GetScheduleData(dArgs)
    
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

