Attribute VB_Name = "App_Person"
'Public Function GetPersonDataFromDB
'Public Function GetPersonData

Option Explicit

Public Function GetPersonData(sBookName As String, _
                              sBookPath As String, _
                              sDataSubType As String, _
                     Optional sScope As String = "specified", _
                     Optional sCacheBookName As String) As Worksheet
Dim sDataType As String, sResultFileName As String, sCacheSheetName As String
Dim aSchedule() As String

    sDataType = "person"
    If sCacheBookName = "" Then
        sCacheBookName = sBookName
    End If
    
    If IsDataCached(Quad_Utils.sCacheBookPath, sCacheBookName, sDataType, sDataSubType) = False Then
        sResultFileName = GetPersonDataFromDB(sDataSubType, sScope:=sScope)
        aSchedule = ParseRawData(ReadFile(sResultFileName))
        sCacheSheetName = CacheData(Quad_Utils.sCacheBookPath, sCacheBookName, aSchedule, sDataType, sDataSubType)
    Else
        sCacheSheetName = CacheData(Quad_Utils.sCacheBookPath, sCacheBookName, aSchedule, sDataType, sDataSubType, bCacheNameOnly:=True)
    End If
    
    Set GetPersonData = Workbooks(sCacheBookName).Sheets(sCacheSheetName)
    
End Function

Public Function GetPersonDataFromDB(sPersonType As String, _
                           Optional sScope As String = "specified", _
                           Optional iPersonID As String) As String
Dim sDatabasePath As String, sResultFileName As String, sSpName As String, sResults As String
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

    GetQuadDataFromDB cDatabasePath, sSpName, bHeaderFlag:=True, sResultFileName:=cResultFileName, _
                    dSpArgs:=dSpArgs
    
    GetPersonDataFromDB = cResultFileName
End Function

