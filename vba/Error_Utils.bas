Attribute VB_Name = "Error_Utils"
Option Explicit
Sub Test()

1    On Error GoTo err
2    Debug.Print 10 / 0
3    On Error GoTo 0

err:
    err.Raise Number:=66, Description:="foobar"
End Sub
Sub test2()

On Error GoTo err
Call Test

err:
    Debug.Print err.Description, Erl
    Debug.Print err.HelpContext
    Debug.Print err.HelpFile
    Debug.Print err.LastDllError
    Debug.Print err.Source
    Debug.Print err.Description & " [" & CStr(err.Number) & "]"

End Sub


