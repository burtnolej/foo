Attribute VB_Name = "Quad_Person_Validations"
Option Explicit
Const C_MODULE_NAME = "Quad_Person_Validations"
Const cTeacherLookUpCol = "idFaculty"
Const cStudentLookUpCol = "idStudent"

Public Function IsValidPersonID(clsAppRuntime As App_Runtime, _
                                iPersonID As Integer, _
                                eQuadSubDataType As QuadSubDataType) As Boolean
'<<<
' purpose: tests if the given person ID exists; retreives data to perform the test
'        : currently uses the non table mechanism for storing data and looking up
' param  : clsAppRuntime, App_Runtime; all config controlling names of books, sheets, ranges for
'        :                 also contains any variables that need to be passed continually
' param  : eQuadSubDataType, QuadSubDataType; what type of person are we querying
' param  : iPersonID, Integer; id to be checked
' returns: boolean
'>>>

Dim sFuncName As String, sLookUpCol As String
Dim wsPersonDataCache As Worksheet
Dim vStudentIDs() As String

setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidPersonID"
    FuncLogIt sFuncName, "[iPersonID=" & iPersonID & "] [eQuadSubDataType=" & eQuadSubDataType & "]", C_MODULE_NAME, LogMsgType.INFUNC
    On Error GoTo err

main:
    Set wsPersonDataCache = GetPersonData(clsAppRuntime, QuadDataType.Person, eQuadSubDataType, _
                eQuadScope:=QuadScope.all, bInTable:=True)

    If eQuadSubDataType = QuadSubDataType.Teacher Then
        sLookUpCol = cTeacherLookUpCol
    Else
        sLookUpCol = cStudentLookUpCol
    End If

    'clsAppRuntime.InitProperties bInitializeCache:=False
    vStudentIDs = GetColumnValues(clsAppRuntime, QuadDataType.Person, QuadSubDataType.Student, "idStudent")

    If InArray(vStudentIDs, CStr(iPersonID)) Then
        IsValidPersonID = True
        FuncLogIt sFuncName, "Student ID [" & CStr(iPersonID) & "] is VALID", C_MODULE_NAME, LogMsgType.INFO
        Exit Function
    End If
    
    IsValidPersonID = False
    FuncLogIt sFuncName, "Student ID [" & CStr(iPersonID) & "] is INVALID ", C_MODULE_NAME, LogMsgType.INFO
    
cleanup:
    On Error GoTo 0
    Exit Function

err:
    FuncLogIt sFuncName, "[iPersonID=" & iPersonID & "] [eQuadSubDataType=" & eQuadSubDataType & "]", C_MODULE_NAME, LogMsgType.Error

End Function

