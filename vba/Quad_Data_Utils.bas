Attribute VB_Name = "Quad_Data_Utils"
Option Explicit

Public Function GetStudentNameFromID(iPersonID As Integer) As String
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties bInitializeCache:=False
    GetStudentNameFromID = CrossRefQuadData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, _
            "idStudent", iPersonID, "sStudentLastNm")
End Function

Public Function GetTableRecordID(vValue As Variant, sLookUpFieldName As String) As String
Dim clsQuadRuntime As New Quad_Runtime

    clsQuadRuntime.InitProperties bInitializeCache:=False
    'GetTableRecordID = CrossRefQuadData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, _
    '    sLookUpFieldName, vValue, "ID")
    GetTableRecordID = CrossRefQuadData(clsQuadRuntime, QuadDataType.person, QuadSubDataType.Student, _
        sLookUpFieldName, vValue, "RefNo")
End Function


'iperson_studentID

