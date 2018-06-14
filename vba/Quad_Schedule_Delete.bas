Attribute VB_Name = "Quad_Schedule_Delete"
Option Explicit

Const C_MODULE_NAME = "Quad_Schedule_Delete"

Public Sub DeleteClassLectureDataFromDB(clsAppRuntime As App_Runtime, _
                               iClassLectureID As String)
'<<<
'>>>
Dim sDatabasePath As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary

    sSpName = "delete_classlecture"
    dSpArgs.Add "classlectures", InitVariantArray(Array(iClassLectureID))

    GetQuadDataFromDB clsAppRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs

End Sub

