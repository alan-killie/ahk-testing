; Use the mouse wheel to switch between virtual desktops while hovered over the task view button on the windows taskbar
; Stops working when taskview is clicked, possibly needing a window refocus.
#Persistent
SetTitleMatchMode, 2 ; Makes matching titles and text easier
CoordMode, Mouse, Screen

; Define a timer that will run the check every 100ms
SetTimer, CheckMouseOverTaskView, 100

; Initialize flag
isHotkeyActive := false
return

CheckMouseOverTaskView:
{
    ; Get mouse cursor position
    MouseGetPos, xpos, ypos, id, control

    ; Check if the control under the mouse is within the Shell_TrayWnd class
    if (control = "TrayButton1" and WinExist("ahk_class Shell_TrayWnd"))
    {
        ; Register the hotkeys if not already active
        if (!isHotkeyActive)
        {
            Hotkey, WheelUp, ScrollRight, On
            Hotkey, WheelDown, ScrollLeft, On
            isHotkeyActive := true
        }
    }
    else
    {
        ; Unregister the hotkeys if they are active
        if (isHotkeyActive)
        {
            Hotkey, WheelUp, Off
            Hotkey, WheelDown, Off
            isHotkeyActive := false
        }
    }
}
return

ScrollRight:
    Send, ^#{Right}
return

ScrollLeft:
    Send, ^#{Left}
return

; Exit the script with Escape key
Esc::ExitApp

