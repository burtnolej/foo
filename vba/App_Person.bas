Attribute VB_Name = "App_Person"
'Public Function GetPersonDataFromDB
'Public Function GetPersonData

Option Explicit
Const C_MODULE_NAME = "App_Person"
Const cTeacherLookUpCol = "idFaculty"
Const cStudentLookUpCol = "idStudent"

Public Function IsValidPersonID(clsQuadRuntime As Quad_Runtime, iPersonID As Integer, sDataSubType As String) As Boolean
Dim sFuncName As String, sLookUpCol As String
Dim wsPersonDataCache As Worksheet

setup:
    sFuncName = C_MODULE_NAME & "." & "IsValidPersonID"
    
    ' Assertions --------------------------------
    If InArray(Array("student", "teacher"), sDataSubType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sDataSubType needs to be in [student|teacher] got [" & sDataSubType & "]"
    End If
    ' END Assertions --------------------------------
    
main:
    Set wsPersonDataCache = GetPersonData(clsQuadRuntime, sDataSubType, sScope:="all")

    If sDataSubType = "teacher" Then
        sLookUpCol = cTeacherLookUpCol
    Else
        sLookUpCol = cStudentLookUpCol
    End If
    
    If SheetTableLookup(wsPersonDataCache, "data", sLookUpCol, iPersonID) <> -1 Then
        IsValidPersonID = True
        Exit Function
    End If
    
    IsValidPersonID = False
    
End Function
Public Function GetPersonData(clsQuadRuntime As Quad_Runtime, sDataSubType As String, _
                     Optional sScope As String = "specified") As Worksheet
Dim sDataType As String, sCacheSheetName As String
Dim aSchedule() As String

    sDataType = "person"
    
    If IsDataCached(clsQuadRuntime, sDataType, sDataSubType) = False Then
        GetPersonDataFromDB clsQuadRuntime, sDataSubType, sScope:=sScope
        aSchedule = ParseRawData(ReadFile(clsQuadRuntime.ResultFileName))
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, sDataType, sDataSubType)
    Else
        sCacheSheetName = CacheData(clsQuadRuntime, aSchedule, sDataType, sDataSubType, bCacheNameOnly:=True)
    End If
    
    Set GetPersonData = clsQuadRuntime.CacheBook.Sheets(sCacheSheetName)
    
End Function

Public Sub GetPersonDataFromDB(clsQuadRuntime As Quad_Runtime, sPersonType As String, _
                           Optional sScope As String = "specified", _
                           Optional iPersonID As String)
Dim sDatabasePath As String, sSpName As String, sResults As String
Dim dSpArgs As New Dictionary

    ' Assertions --------------------------------
    If InArray(Array("student", "teacher"), sPersonType) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sPersonType needs to be in [student|teacher] got [" & sPersonType & "]"
    End If
    
    If InArray(Array("all", "specified"), sScope) = False Then
        err.Raise ErrorMsgType.BAD_ARGUMENT, Description:="arg sScope needs to be in [all|specified] got [" & sScope & "]"
    End If
    
    sSpName = "basic_" & sPersonType & "_info"
    
    If sScope = "all" Then
        sSpName = "all_" & sSpName
    Else
        dSpArgs.Add sPersonType & "s", InitVariantArray(Array(iPersonID))
    End If

    GetQuadDataFromDB clsQuadRuntime, sSpName, bHeaderFlag:=True, dSpArgs:=dSpArgs

End Sub

