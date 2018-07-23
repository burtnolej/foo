Attribute VB_Name = "Add_Utils"
Const C_LIST_TYPE_SHEET = "list_types"

Enum FieldType
    Number = 1
    NumberFormula = 2
    Text = 3
    List = 4
End Enum

Enum NumberRangeType
    gt0lt100 = 1
    gt10lte20 = 2
End Enum

Enum ErrorType
    NotAnInteger = 1
    NotValidPrep = 2
End Enum

Public Const C_RGB_CONFLICT = "255,255,0"
Public Const C_RGB_VALID = "0,255,0"
Public Const C_RGB_INVALID = "255,0,0"
Public Const C_RGB_ERROR = "242,242,242"
