;;;; https://www.autohotkey.com/boards/viewtopic.php?t=87367
fsize:=32

#NoEnv
#SingleInstance force





IniRead, DefaultTime, config.cfg, TIME, Default, 20
GLOBAL e1 := 0
; GLOBAL e2 := 20
GLOBAL e2 := DefaultTime
GLOBAL e3 := 0





DetermineCountTimerPosition()

IniRead, ToggleCDKey, config.cfg, HOTKEYS, ToggleCountdownTicker, F3
IniRead, ResetCDKey, config.cfg, HOTKEYS, ResetCountdownTicker, F4
Hotkey, %ResetCDKey%, start
Hotkey, %ToggleCDKey%, resume




; Gui , TimerBaseWin : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +parent%Win_Hwnd% +E0x20 +HwndHwnd
; Gui , TimerBaseWin : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
; Gui, TimerBaseWin:Default
Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
Gui, Timer:Color, 000000 ; Background color
WinSet, TransColor, 000000 255 ; Transparency color and level

; Gui, Timer:Show, x0 y0 w350 h350
Gui, Timer:Show, x%CounterPOSx% y%CounterPOSy% w350 h350


Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
; Gui , Timer :  +AlwaysOnTop -dpiscale +resize +toolwindow +LastFound

Gui, Timer:Default

Gui , Timer:add , text , x0 y0  w20 h20 gtog +backgroundtrans ,
Gui , Timer:add , text , x0 y0  w20 h20 gstart vires +backgroundtrans -border ,

IniRead, CountdownColor, config.cfg, TEXT, CountdownColor, Blue
; Gui , Timer:Font , s%fsize% cBlue , Impact
; Gui, Font, S30 Q4  ;;;;; ANTI-ALIASING
DetermineTextProcessing()
Gui , Timer:Font , s%fsize% c%CountdownColor% %MasterTextProcessingValue%, Impact     ;;;;; FIRST TEXT COLOR CALL
Gui , Timer:add , text , x8 yp  h38 left  vdispt gresume, 00:00:00
Gui , Timer:Font
Gui , Timer:Font , s10 , Trebuchet MS

;	===========================================================
Gui , Timer:Add , Button , % "gstart x4 y+2 h22 center vbStart w83" +backgroundtrans Hidden, Re/Start
Gui , Timer:Add , Button , % "gresume x+2 yp h22 vbres center w83" +backgroundtrans Hidden, P/Resume
GuiControl, hide, bStart
GuiControl, hide, bres
;	===========================================================

;	===========================================================
; Gui , Timer:add , Text , x4 y+2 w55 -border center , Hrs
; Gui , Timer:add , Text , x+1 yp w55 -border center , Min
; Gui , Timer:add , Text , x+1 yp w57 -border center , Sec
Gui , Timer:add , Text , x4 y+2 w55 -border center , Hrs
Gui , Timer:add , Text , x+1 yp w55 -border center , Min
Gui , Timer:add , Text , x+1 yp w57 -border center , Sec
;	===========================================================

;	===========================================================
Gui , Timer:Font , s10 , Trebuchet MS
; Gui , Timer:Add , Edit , x4 y+2 w55 h20 center ve3
; Gui , Timer:Add , UpDown ,  yp w55 h20 -VScroll , 0
; Gui , Timer:Add , Edit ,  x+2 yp w55 h20 center ve2
; Gui , Timer:Add , UpDown ,   w55 h20 -VScroll , 0
; Gui , Timer:Add , Edit ,  x+2 yp w55 h20 center ve1
; Gui , Timer:Add , UpDown ,  w55 h20 -VScroll vud, 10

;	===========================================================
Gui , Timer:add, text , vTIdle x4 y+3 -border w58 gopa7 section , 00:00:00     
Gui , Timer:add, text , vTStart x4 y+2 w58 -border gSTTTT,  00:00:00
;	===========================================================

Gui, Timer:Add, DropDownList, vtimer_options Choose1 altsubmit x+2 ys+10 w110 gset_option_func Hidden, no_option|open file|system beep|message box|hybernate/sleep|shutdown|start_after_idle
GuiControl, hide, timer_options

Gui, Timer:Color, 000000 ; Background color
WinSet, TransColor, 000000 255 ; Transparency color and level

STTTT:

; Gui, Show, % " w" getcontrol("bres", "xw")+2 " h" getcontrol("timer_options", "yh")+2, Countdown Timer
Gui, Show, % " w" getcontrol("bres", "xw")+2 " h" getcontrol("timer_options", "yh")+2, Countdown Timer

; GuiControl, Movedraw, ires, % " x0 " "y " getcontrol("dispt", "yh")-20
GuiControl, Movedraw, ires, % " x0 " "y " getcontrol("dispt", "yh")-20
GuiControl, Move, Countdown Timer, x0 y0


return
ires:
return
tog:
toggleb:=!toggleb

if toggleb {
Gui, Show, % " w" getcontrol("dispt", "xw")+4 " h" getcontrol("bres", "y")
}
else
Gui, Show, %  " w" getcontrol("ud", "xw")+4 " h" getcontrol("timer_options", "yh")+2

return

start:
IniRead, ToggleCDKey, config.cfg, HOTKEYS, ToggleCountdownTicker, F3
IniRead, ResetCDKey, config.cfg, HOTKEYS, ResetCountdownTicker, F4
Hotkey, %ResetCDKey%, start
Hotkey, %ToggleCDKey%, resume
DetermineCountTimerPosition()
Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
Gui, Timer:Show, x%CounterPOSx% y%CounterPOSy% w350 h350
;   Pause , 0
   Toggle:=1
   Gui , Submit , NoHide
   ;Gui , Timer:Font , s26 cBlue , Segoe UI
   IniRead, CountdownColor, config.cfg, TEXT, CountdownColor, Blue
   DetermineTextProcessing()
   Gui , Timer:Font , s%fsize% c%CountdownColor% %MasterTextProcessingValue%, Impact
   ; Gui , Timer:Font , s%fsize% cBlue , Impact
   GuiControl , Timer:Font , dispt
;  If e3 is not number
; 	e3:=0
;  If e2 is not number
; 	e2:=0
;  If e1 is not number
; 	e1:=0

   secsLeft :=  e3*3600+e2*60+e1
   seconds := Format("{:02}" , floor(mod(secsLeft , 60)))	
   minutes := Format("{:02}" , mod(floor(secsLeft/60) , 60))
   hours  :=  floor(secsLeft/3600)
   
   hur := Format("{:02}" , floor(abs(secsleft)/3600))
   min := Format("{:02}" , floor(mod(abs(secsLeft/60),60)))
   sec := Format("{:02}" , floor(mod(abs(secsLeft), 60)))
   
   GuiControl , Timer:text , dispt , %hur%:%min%:%sec% 
   FormatTime , TimeString, , HH:mm:ss				 
   GuiControl , Timer:text , TStart , %TimeString%
   SetTimer , CDTimer , 1000
return

resume:
IniRead, ToggleCDKey, config.cfg, HOTKEYS, ToggleCountdownTicker, F3
IniRead, ResetCDKey, config.cfg, HOTKEYS, ResetCountdownTicker, F4
Hotkey, %ResetCDKey%, start
Hotkey, %ToggleCDKey%, resume
DetermineCountdownTime()
DetermineCountTimerPosition()
Gui , Timer: -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
IniRead, CountdownColor, config.cfg, TEXT, CountdownColor, Blue
DetermineTextProcessing()
Gui , Timer:Font , s%fsize% c%CountdownColor% %MasterTextProcessingValue%, Impact
GuiControl, Timer:+c%CountdownColor%, dispt

Gui, Timer:Show, x%CounterPOSx% y%CounterPOSy% w350 h350
  if (hours+minutes+seconds < -1) {
   IniRead, CountdownColor, config.cfg, TEXT, CountdownColor, Blue
   GuiControl, Timer:+c%CountdownColor%, dispt
  gosub start
  return
  }
	Toggle:=!Toggle
	if (toggle) {  
		SetTimer, CDTimer, on
      IniRead, CountdownColor, config.cfg, TEXT, CountdownColor, Blue
      GuiControl, Timer:+c%CountdownColor%, dispt
	 }
    else
		SetTimer, CDTimer, off
   GuiControl , , e3 , %hours%
   GuiControl , , e2 , %minutes%
   GuiControl , , e1 , %seconds%
   GuiControl , , dispt , %hur%:%min%:%sec%
   IniRead, CountdownColor, config.cfg, TEXT, CountdownColor, Blue
   GuiControl, Timer:+c%CountdownColor%, dispt
return

CDTimer:
DetermineCountdownTime()
DetermineCountTimerPosition()
Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
;   Gui , Submit , NoHide
   secsLeft--
   hur := Format("{:02}" , floor(abs(secsleft)/3600))
   min := Format("{:02}" , floor(mod(abs(secsLeft/60),60)))
   sec := Format("{:02}" , floor(mod(abs(secsLeft), 60)))
   GuiControl , Timer:text , dispt, %hur%:%min%:%sec%
   IfEqual , secsLeft , 0
   {
      ;Gui , Timer:Font , s26 cRed , Segoe UI
      Gui , Timer:Font , s%fsize% cRed , Impact
      GuiControl , Timer:Font , dispt  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; THIS IS THE PART WHERE THE TIMER ENDS AND CALLS THE LABEL NAMED OPB7, BELOW
;;;;;; This points to the label OPB7 at the end of the timer sequence which starts the timer sequence up again but instead of counting down its backwards
;;;; whenever the timer gets to zero.
;; Uncomment to enable
; GLOBAL timer_options = "7"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; This points to the label OPB1 at the end of the timer sequence 
GLOBAL timer_options = "1"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ; goto  opb%timer_options%  ;;;; USE THIS TO MAKE THE COUNTDOWN TIMER REPEAT ITSELF WHEN THE TIME RUNS OUT, BUT MAKE IT COUNT UP INSTEAD OF DOWN
      ; MsgBox, , Title, END OF TIMER HAS BEEN REACHED,
      goto  opb1
      ; goto  opa7
      return
   }
   Else	
      Return
   
set_option_func:
DetermineCountdownTime()
DetermineCountTimerPosition()
   Gui , Submit , NoHide
   goto  opa%timer_options%
opa1:
opb1:
      ; MsgBox, , Title, THIS IS LABEL OPB1 / OPA1 SPEAKING,
reload
return

opa2:
	FileSelectFile, SelectedFile, 3, , Open a file, Open After Countdown (*.*)
return
opb2:
	run, %SelectedFile%
return
   
opb3:
	 SoundBeep, 360, 1000
opa3:
return

opb4:
   msgbox , 262144 , Timer, Time's Up !
opa4:
return

opb5:
   run, rundll32.exe powrprof.dll`,SetSuspendState Sleep
opa5:
return

opb6:
   run, shutdown.exe /s
opa6:
return

Check4Idle:
Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
	if (IdleTCd < 1){
    SetTimer Check4Idle, Off
	return
	}
	If (A_TimeIdle > IdleTCd*1000){
    SetTimer Check4Idle, Off
	gosub start
	return
	}
return

opa7: 
Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
   Gui , Submit , NoHide
   inputbox, IdleTCd, Idle Time , Please enter minutes for PC to idle before auto countdown. 0 to disable, ,180 ,160
   SetTimer , Check4Idle , 1000
    idlhur := Format("{:02}" , floor(abs(IdleTCd)/60))
	idlmin := Format("{:02}" , floor(mod(abs(IdleTCd), 60)))
	idlsec := Format("{:02}" , floor(mod(abs(IdleTCd*60), 60)))
	IdleTCd := floor(IdleTCd*60)
	
	GuiControl , Timer:text , TIdle , %idlhur%:%idlmin%:%idlsec%
opb7:
Gui , Timer : -dpiscale +AlwaysOnTop -Caption +ToolWindow +LastFound +E0x20 +HwndHwnd
return 

TimerGuiClose:
ExitApp


getcontrol(crtname, what)
{
 guicontrolget, out,  Pos, %crtname%

 if (what="x")
 return % outx

 if (what="y")
 return % outy

 if (what="w")
 return % outW

 if (what="h")
 return % outH

 if (what="yh")
 return % outy + outH 

 if (what="xw")
 return % outx + outW
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

DetermineCountTimerPosition()
         {
IniRead, CountDownPOS, config.cfg, POS, CountdownPosition, TopLeft
;;;;;;
IniRead, CountDnPOSLeftX, config.cfg, POS, MasterTopLeftX, TopLeft
IniRead, CountDnPOSLeftY, config.cfg, POS, MasterTopLeftY, TopLeft
;;;;;;
IniRead, CountDnPOSRightX, config.cfg, POS, MasterTopRightX, TopLeft
IniRead, CountDnPOSRightY, config.cfg, POS, MasterTopRightY, TopLeft
;;;;;;
;;;;;;
IniRead, CountDnPOSRight2X, config.cfg, POS, MasterTopRight2X, TopLeft
IniRead, CountDnPOSRight2Y, config.cfg, POS, MasterTopRight2Y, TopLeft
;;;;;;
IniRead, CountDnPOSLeft2X, config.cfg, POS, MasterTopLeft2X, TopLeft
IniRead, CountDnPOSLeft2Y, config.cfg, POS, MasterTopLeft2Y, TopLeft
;;;;;;
IniRead, CountDnPOSBotRightX, config.cfg, POS, MasterBottomRightX, TopLeft
IniRead, CountDnPOSBotRightY, config.cfg, POS, MasterBottomRightY, TopLeft
; GLOBAL MasterTopLeftX := "0"
; GLOBAL MasterTopLeftY := "-1"
; GLOBAL MasterTopLeft2X := "0"
; GLOBAL MasterTopLeft2Y := "175"
; GLOBAL MasterTopRightX := "2385"
; GLOBAL MasterTopRightY := "-1"
; GLOBAL MasterTopRight2X := "2385"
; GLOBAL MasterTopRight2Y := "175"
; GLOBAL MasterBottomRightX := "2385"
; GLOBAL MasterBottomRightY := "1394"
GLOBAL MasterTopLeftX := CountDnPOSLeftX
GLOBAL MasterTopLeftY := CountDnPOSLeftY
;;;;;;
GLOBAL MasterTopRightX := CountDnPOSRightX
GLOBAL MasterTopRightY := CountDnPOSRightY
;;;;;;
GLOBAL MasterTopLeft2X := CountDnPOSLeft2X
GLOBAL MasterTopLeft2Y := CountDnPOSLeft2Y
;;;;;;
GLOBAL MasterTopRight2X := CountDnPOSRight2X
GLOBAL MasterTopRight2Y := CountDnPOSRight2Y
;;;;;;
GLOBAL MasterBottomRightX := CountDnPOSBotRightX
GLOBAL MasterBottomRightY := CountDnPOSBotRightY
;;;;;;
If(CountDownPOS="TopLeft")
{
   GLOBAL CounterPOSx := MasterTopLeftX
   GLOBAL CounterPOSy := MasterTopLeftY
}
If(CountDownPOS="TopRight")
{
   GLOBAL CounterPOSx := MasterTopRightX
   GLOBAL CounterPOSy := MasterTopRightY
}
If(CountDownPOS="TopLeft2")
{
   GLOBAL CounterPOSx := MasterTopLeft2X
   GLOBAL CounterPOSy := MasterTopLeft2Y
}
If(CountDownPOS="TopRight2")
{
   GLOBAL CounterPOSx := MasterTopRight2X
   GLOBAL CounterPOSy := MasterTopRight2Y
}
If(CountDownPOS="BottomRight")
{
   GLOBAL CounterPOSx := MasterBottomRightX
   GLOBAL CounterPOSy := MasterBottomRightY
}
         }


DetermineCountdownTime()
{
   IniRead, DefaultTime, config.cfg, TIME, Default, 20
   GLOBAL e1 := 0
   ; GLOBAL e2 := 20
GLOBAL e2 := DefaultTime
GLOBAL e3 := 0
}