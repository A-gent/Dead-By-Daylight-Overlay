#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
OnExit, ExitSubb


IniRead, bHookCounter, config.cfg, SWITCHES, HookCounter, 1
IniRead, bCountDNCounter, config.cfg, SWITCHES, CountDown, 1
IniRead, bStopWHCounter, config.cfg, SWITCHES, StopWatch, 1


IniRead, CFGdir, config.cfg, CONFIG, ConfigPath, 1

GLOBAL ConfigPath := CFGdir . "\config.cfg"


If(bHookCounter="1")
{
    Run, %A_ScriptDir%\DBDHooks.exe
}
If(bCountDNCounter="1")
{
    Run, %A_ScriptDir%\CounterTimer.exe
}
If(bStopWHCounter="1")
{
    Run, %A_ScriptDir%\StopWatch.exe
}


; Gui, -dpiscale +ToolWindow +LastFound +E0x20 +HwndHwnd
Gui, -dpiscale +LastFound
Gui, Add, Text, w335 center, CLOSE THIS WINDOW TO EXIT DBD OVERLAY
Gui, Add, Button, x136 w80 h20 gReset, RELOAD
Gui, Add, Button, x136 w80 h20 gConfig, SETTINGS
Gui, Add, Button, x136 w80 h20 gGuiClose, EXIT
Gui, Show,, DBD Overlay Active
Return

Reset:
Reload
Return

Config:
Run, notepad.exe %ConfigPath%
Return

Return
GuiClose:
GuiEscape:
ExitSubb:

WinClose, Countdown Timer
WinClose, Stopwatch
WinClose, Hook Counter Overlay
; Process, Close, StopWatch.exe
; Process, Close, DBDHooks.exe
; Process, Close, CounterTimer.exe
ExitApp