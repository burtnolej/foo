Attribute VB_Name = "Test_Events"
Option Explicit

Sub test_action()
    Debug.Print "dfsdsdsd"
End Sub
Sub test()

    Dim var As Quad_Event_Handler
    Dim tst As Quad_AddNew_Event

    Set var = New Quad_Event_Handler
    Set tst = New Quad_AddNew_Event
    var.EventVariable = tst

    tst.value = 1

End Sub
