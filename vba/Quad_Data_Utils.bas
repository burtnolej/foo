Attribute VB_Name = "Quad_Data_Utils"
Option Explicit

Public Function GetStudentNameFromID(iPersonID As Integer) As String
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties bInitializeCache:=False
    GetStudentNameFromID = CrossRefQuadData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.student, _
            "idStudent", iPersonID, "sStudentLastNm")
End Function
