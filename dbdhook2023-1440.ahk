#Persistent
#SingleInstance Force
#NoEnv



; How to Use
; Add a number

; With the overlay open, you simply press 1, 2, 3 or 4 on your keyboard to increment the numbers. (the number keys above your letters, not the numberpad).

; Remove a number

; If you make a mistake and want to remove a number you can press SHIFT+1, 2, 3 or 4 to reduce the count by one. Though if you keep adding numbers past 3 it will loop back to 0.

; Clear the counter

; Press F12 to clear the counter and reset everything back to 0.

; Close the Overlay

; Shift+ESC will completely close the overlay. Otherwise you can right click the Green H tray icon to exit it as well.



FolderPath := "C:\temp"
IfNotExist, %FolderPath%
{
    FileCreateDir, %FolderPath%
}

FileDelete, C:\temp\hook.ini
Loop, 4 {
    IniWrite, 0, C:\temp\hook.ini, %A_Index%, %A_Index%
}

; Retrieve primary monitor's screen resolution
SysGet, ScreenWidth, 0  ; Retrieves the width of the primary monitor
SysGet, ScreenHeight, 1  ; Retrieves the height of the primary monitor

; Calculate X and Y position for the GUI based on the screen resolution
; Adjust these fractions to change the position relative to your screen
; GuiX := ScreenWidth * 0.005  ; Example: 13% of screen width  ;;;; this is for vanilla size GUI
; GuiY := ScreenHeight * 0.42  ; Example: 42% of screen height   ;;;; this is for vanilla size GUI
GuiX := ScreenWidth * 0.0001  ; Example: 13% of screen width   ;;;; this is for smallest size edited GUI
GuiY := ScreenHeight * 0.58  ; Example: 42% of screen height ;;;; this is for smallest size edited GUI


IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
DetermineTextProcessing()


; Gui Font, s12 cWhite ; Font size and color
; Gui Add, Text, vPlayerCount x355 y270, Player Count: Loading... ; Position of text
; Gui Show, x0 y0 w1920 h1080, Player Count Overlay ; Window size and position



; CustomColor = EEAA99
; Gui +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
Gui, Color, %CustomColor%
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana




yPos := 0  ; Initialize y-position variable
; xPos := 50  ; Set a fixed x-position  ;;;; this is for vanilla size GUI
xPos := 40  ; Set a fixed x-position
Loop, 4 {
    Gui, Add, Text, x%xPos% y%yPos% vnum%A_Index% c%CfgTextColor% +BackGroundTrans -border
    Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
    ; yPos += 120  ; Increase y-position by 120 for each new line  ;;;; this is for vanilla size GUI
    yPos += 80  ; Increase y-position by 120 for each new line  ;;;; this is for small size edited GUI
}
; Loop, 4 {
;     Gui, Add, Text, x%xPos% y%yPos% vnum%A_Index% cFFD166 BackGroundTrans
;     yPos += 120  ; Increase y-position by 120 for each new line
; }
Gui Color, 000000 ; Background color
WinSet, TransColor, 000000 255 ; Transparency color and level
; WinSet, TransColor, %CustomColor% 255
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD

; Use calculated position for GUI
; Gui, Show, x%GuiX% y%GuiY% w120 h450 NoActivate  ;;;; this is for vanilla size GUI
Gui, Show, x%GuiX% y%GuiY% w120 h450 NoActivate, Hook Counter Overlay  ;;;; this is for smallest size edited GUI
return

UpdateOSD:
Loop, 4 {
    number := IniReadValue(A_Index)
    GuiControl,, num%A_Index%, %number%
}
return

; ~1::Increment(1)
; ~2::Increment(2)
; ~3::Increment(3)
; ~4::Increment(4)
; ~+1::Decrement(1)
; ~+2::Decrement(2)
; ~+3::Decrement(3)
; ~+4::Decrement(4)
~1::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Increment(1)
Return

~2::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Increment(2)
Return

~3::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Increment(3)
Return

~4::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Increment(4)
Return

~+1::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Decrement(1)
Return

~+2::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Decrement(2)
Return

~+3::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Decrement(3)
Return

~+4::
DetermineTextProcessing()
Gui, Submit, NoHide
Gui +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CfgTextColor, config.cfg, TEXT, HookCountColor, e3050f
Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, verdana
; Gui, Font, s32 c%CfgTextColor% %MasterTextProcessingValue%, Impact
GuiControl, Font, num1
GuiControl, Font, num2
GuiControl, Font, num3
GuiControl, Font, num4
Decrement(4)
Return


^F12::Reload
+ESC::ExitApp

GuiClose:
GuiEscape:
ExitApp

; Functions
Increment(key) {
    UpdateIniFile(key, 1)
}

Decrement(key) {
    UpdateIniFile(key, -1)
}

UpdateIniFile(key, change) {
    number := IniReadValue(key)
    number += change
    if (number > 3) {
        number := 0
    } else if (number < 0) {
        number := 3
    }
    IniWrite, %number%, C:\temp\hook.ini, %key%, %key%
}

IniReadValue(key) {
    IniRead, number, C:\temp\hook.ini, %key%, %key%
    return number
}

DetermineTextProcessing()
{
   IniRead, TEXTprocessing, config.cfg, TEXT, Processing, ANTI-ALIAS
   If(TEXTprocessing="DEFAULT")
   {
      GLOBAL MasterTextProcessingValue := "Q0"
   }
   If(TEXTprocessing="DRAFT")
   {
      GLOBAL MasterTextProcessingValue := "Q1"
   }
   If(TEXTprocessing="PROOF")
   {
      GLOBAL MasterTextProcessingValue := "Q2"
   }
   If(TEXTprocessing="NO-ANTI-ALIAS")
   {
      GLOBAL MasterTextProcessingValue := "Q3"
   }
   If(TEXTprocessing="ANTI-ALIAS")
   {
      GLOBAL MasterTextProcessingValue := "Q4"
   }
   If(TEXTprocessing="CLEARTYPE")
   {
      GLOBAL MasterTextProcessingValue := "Q4"
   }
}