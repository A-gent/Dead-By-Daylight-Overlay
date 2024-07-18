#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;Stopwatch



#NoEnv
#SingleInstance force
SetDefaultMouseSpeed, 70
; SetTimer, QuerySettings, -200

; IniRead, AntiAFKStatus, settings.cfg, SETTINGS, AutoAFKHandler,0
; GLOBAL StateAutoAFK := AntiAFKStatus

timerm := "00"
timers := "00"
stopped := "0"

GLOBAL windowstatus := "0"
GLOBAL FirstToggleColdboot := "1"



Gui, -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd


Gui, Add, CheckBox, vAntiAFKControl gCheckAutoAFK, anti-afk
Gui, Add, CheckBox, x120 y5 vAlwaysOnTopControl gCheckTopmostLevelGUI, Topmost

GuiControl, hide, AntiAFKControl
GuiControl, hide, AlwaysOnTopControl


; Gui, Add, Button, x2 y42 w80 h20 vPause gButtonToggle, Toggle
Gui, Add, Button, x2 y42 w80 h20 vPause, Toggle
; Gui, Add, Button, x2 y42 w80 h20 vPause, Pause
Gui, Add, Button, x82 y42 w80 h20 vReset, Reset
; Gui, Add, CheckBox, vAntiAFKControl gCheckAutoAFK , -fixed


DetermineTextProcessing()
IniRead, cStopWatchColor, config.cfg, TEXT, StopWatchColor, Blue
Gui, Font, s25 c%cStopWatchColor% %MasterTextProcessingValue%, Impact     ;;;;; FIRST TEXT COLOR CALL
Gui, Add, Text, x10 y7 w80 h80 vTText, %timerm%:%timers%
Gui, Font, s25 c%cStopWatchColor% %MasterTextProcessingValue%, Impact     ;;;;; FIRST TEXT COLOR CALL
; Gui, Add, Text, x10 y7 w80 h80 vTText c%StopWatchColor%, %timerm%:%timers%



GuiControl, hide, Pause
GuiControl, hide, Reset


Gui, Color, 000000 ; Background color
WinSet, TransColor, 000000 255 ; Transparency color and level


DetermineCountTimerPosition()
Gui, Show, x%StopWatchPOSx% y%StopWatchPOSy% h175 w185, Stopwatch
CheckMarkGivenControls()


; Settimer, Stopwatch, 1000
; SetTimer, QuerySettings, -250
; SetTimer, QuerySettings, 1800

IniRead, TogglePauseShortcut, config.cfg, HOTKEYS, ToggleStopwatchTicker, PgUp
IniRead, ResetShortcut, config.cfg, HOTKEYS, ResetStopwatchTicker, PgDn
GLOBAL TogglePauseKey := TogglePauseShortcut
GLOBAL ResetKey := ResetShortcut
Hotkey, %TogglePauseKey%, ButtonToggle
Hotkey, %ResetKey%, ButtonReset
Return



Stopwatch:
timers += 1
if(timers > 59)
{
	timerm += 1
	timers := "0"
	GuiControl, , TText ,  %timerm%:%timers%
}
if(timers < 10)
{
	GuiControl, , TText ,  %timerm%:0%timers%
}
else
{
	GuiControl, , TText ,  %timerm%:%timers%
}
return

ButtonToggle:
Gui, -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
DetermineCountTimerPosition()
DetermineTextProcessing()
IniRead, cStopWatchColor, config.cfg, TEXT, StopWatchColor, Blue
Gui, Font, s25 c%cStopWatchColor% %MasterTextProcessingValue%, Impact     ;;;;; FIRST TEXT COLOR CALL
GuiControl, +c%cStopWatchColor%, TText


Gui, Show, x%StopWatchPOSx% y%StopWatchPOSy% h175 w185, Stopwatch
; Gui , Submit , NoHide
If(FirstToggleColdboot="1")
{
	Settimer, Stopwatch, -1
	stopped = 0
	Sleep, 50
	stopped = 1
	Settimer, Stopwatch, Off
	GLOBAL FirstToggleColdboot := "0"
}
if(stopped = 0)
{
	Settimer, Stopwatch, off
	stopped = 1
If(StateAutoAFK) = (1)
{
	SetTimer, AntiIDLE, off
	Return
}
}
else
{
	Settimer, Stopwatch, 999
	stopped = 0
If(StateAutoAFK) = (1)
{
	SetTimer, AntiIDLE, %AntiAFKDelayTime%
	Return
}
}
return

ButtonReset:
Gui, -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
DetermineCountTimerPosition()
DetermineTextProcessing()
IniRead, cStopWatchColor, config.cfg, TEXT, StopWatchColor, Blue
Gui, Font, s25 c%cStopWatchColor% %MasterTextProcessingValue%, Impact     ;;;;; FIRST TEXT COLOR CALL
GuiControl, +c%cStopWatchColor%, TText


Gui, Show, x%StopWatchPOSx% y%StopWatchPOSy% h175 w185, Stopwatch
; Gui , Submit , NoHide
timerm := "00"
timers := "00"
GuiControl, , TText ,  %timerm%:%timers%
return

GuiClose:
GuiEscape:
ExitApp
return

; QuerySettings:
; IniRead, AntiAFKStatus, settings.cfg, SETTINGS, AutoAFKHandler,0
; IniRead, AntiAFKDelayT, settings.cfg, SETTINGS, AutoAFKDelay,0
; IniRead, TopmostGUIPriority, settings.cfg, SETTINGS, StayTopmost,0
; IniRead, TogglePauseShortcut, settings.cfg, SETTINGS, TogglePauseHotkey, PgUp
; IniRead, ResetShortcut, settings.cfg, SETTINGS, ResetHotkey, PgDn
; GLOBAL StateAutoAFK := AntiAFKStatus
; GLOBAL AntiAFKDelayTime := AntiAFKDelayT
; GLOBAL TopmostGUI := TopmostGUIPriority
; GLOBAL TogglePauseKey := TogglePauseShortcut
; GLOBAL ResetKey := ResetShortcut
; Gui, Submit, NoHide
; Return


CheckAutoAFK:
Gui, Submit, NoHide
IniWrite, %AntiAFKControl%, settings.cfg, SETTINGS, AutoAFKHandler
; IniWrite, Value, Filename, Section, Key
Return

CheckTopmostLevelGUI:
GuiControlGet, AlwaysOnTopVar,, AlwaysOnTopControl
Sleep, 50
IniWrite, %AlwaysOnTopVar%, settings.cfg, SETTINGS, StayTopmost
ToggleAlwaysOnTop()
Return

AntiIDLE:
MouseGetPos, CurrentMouseX, CurrentMouseY, CurrentMouseWin
Random, MouseMoveCoordinatesX, 200, 400
Random, MouseMoveCoordinatesY, 100, 400
; MouseMove, %MouseMoveCoordinatesX%, %MouseMoveCoordinatesY%    ;;;;  working (but untested for long term use) interrupt using AHK directly
; run, nircmd.exe setcursor %MouseMoveCoordinatesX% %MouseMoveCoordinatesY%    ;;;;  working nircmd version (to be sure its interrupting the system sleep adequately)
Sleep, 100
MouseMove, %MouseMoveCoordinatesX%, %MouseMoveCoordinatesY%
Sleep, 1000
MouseMove, %CurrentMouseX%, %CurrentMouseY%
; MsgBox,, ANTI-IDLE DEBUG, ANTI-IDLE LABEL FIRED!, 3
Return



CheckMarkGivenControls()
{
IniRead, AntiAFKStatus, settings.cfg, SETTINGS, AutoAFKHandler,0
GLOBAL StateAutoAFK := AntiAFKStatus
IniRead, TopmostGUIPriority, settings.cfg, SETTINGS, StayTopmost,0
GLOBAL TopmostGUI := TopmostGUIPriority
If(StateAutoAFK) = (1)
{
	GuiControl,,AntiAFKControl, 1
	; MsgBox, 11111
}
If(StateAutoAFK) = (0)
{
	GuiControl,,AntiAFKControl, 0
	; MsgBox, 22222
}
If(TopmostGUI="1")
{
	GuiControl,,AlwaysOnTopControl, 1
	ToggleAlwaysOnTop()
}
If(TopmostGUI="0")
{
	GuiControl,,AlwaysOnTopControl, 0
}
Return
}


Return
ToggleAlwaysOnTop()
{
	If (windowstatus = 0) {
	WinSet,AlwaysOnTop,On, Stopwatch
	GLOBAL windowstatus = 1
	} else {
	WinSet,AlwaysOnTop,Off, Stopwatch
	; WinSet,Bottom,, Stopwatch
	GLOBAL windowstatus = 0
	}
}


Return
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


Return
DetermineCountTimerPosition()
         {
IniRead, StopWatchPOS, config.cfg, POS, StopWatchPosition, TopLeft
;;;;;;
IniRead, StopWPOSLeftX, config.cfg, POS, MasterTopLeftX, TopLeft
IniRead, StopWPOSLeftY, config.cfg, POS, MasterTopLeftY, TopLeft
;;;;;;
IniRead, StopWPOSRightX, config.cfg, POS, MasterTopRightX, TopLeft
IniRead, StopWPOSRightY, config.cfg, POS, MasterTopRightY, TopLeft
;;;;;;
;;;;;;
IniRead, StopWPOSRight2X, config.cfg, POS, MasterTopRight2X, TopLeft
IniRead, StopWPOSRight2Y, config.cfg, POS, MasterTopRight2Y, TopLeft
;;;;;;
IniRead, StopWPOSLeft2X, config.cfg, POS, MasterTopLeft2X, TopLeft
IniRead, StopWPOSLeft2Y, config.cfg, POS, MasterTopLeft2Y, TopLeft
;;;;;;
IniRead, StopWPOSBotRightX, config.cfg, POS, MasterBottomRightX, TopLeft
IniRead, StopWPOSBotRightY, config.cfg, POS, MasterBottomRightY, TopLeft

GLOBAL MasterTopLeftX := StopWPOSLeftX
GLOBAL MasterTopLeftY := StopWPOSLeftY
;;;;;;
GLOBAL MasterTopRightX := StopWPOSRightX
GLOBAL MasterTopRightY := StopWPOSRightY
;;;;;;
GLOBAL MasterTopLeft2X := StopWPOSLeft2X
GLOBAL MasterTopLeft2Y := StopWPOSLeft2Y
;;;;;;
GLOBAL MasterTopRight2X := StopWPOSRight2X
GLOBAL MasterTopRight2Y := StopWPOSRight2Y
;;;;;;
GLOBAL MasterBottomRightX := StopWPOSBotRightX
GLOBAL MasterBottomRightY := StopWPOSBotRightY
;;;;;;
If(StopWatchPOS="TopLeft")
{
   GLOBAL StopWatchPOSx := MasterTopLeftX
   GLOBAL StopWatchPOSy := MasterTopLeftY
}
If(StopWatchPOS="TopRight")
{
   GLOBAL StopWatchPOSx := MasterTopRightX
   GLOBAL StopWatchPOSy := MasterTopRightY
}
If(StopWatchPOS="TopLeft2")
{
   GLOBAL StopWatchPOSx := MasterTopLeft2X
   GLOBAL StopWatchPOSy := MasterTopLeft2Y
}
If(StopWatchPOS="TopRight2")
{
   GLOBAL StopWatchPOSx := MasterTopRight2X
   GLOBAL StopWatchPOSy := MasterTopRight2Y
}
If(StopWatchPOS="BottomRight")
{
   GLOBAL StopWatchPOSx := MasterBottomRightX
   GLOBAL StopWatchPOSy := MasterBottomRightY
}
         }