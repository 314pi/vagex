#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance Force
DetectHiddenWindows, On
FileInstall, mmo.ico, mmo.ico
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%	 ; Ensures a consistent starting directory.
If Not A_IsAdmin
	Run *RunAs "%A_ScriptFullPath%"
;======================================================================
#Include variables.ahk
Startup()
IniRead, MainTimmer, %Ini_File%, %Ini_Section%, MainTimmer, 300
SetTimer, GeneralTask, 15123
SetTimer, RunMainTimmer, % MainTimmer*1000
;======================================================================
Menu, Tray, Add, %TrayMenu2%, ShowTool
Menu, Tray, Add, %TrayMenu1% , ExitTool
Menu, Tray, Click, 1
Menu, Tray, Default, %TrayMenuDefault%
Menu, Tray, Icon, %Favi%
Menu, Tray, NoStandard
Menu, Tray, Tip , %TrayTip%
Gui -MinimizeBox -MaximizeBox +AlwaysOnTop
Gui Add, Button, hWndhBtnHide vBtnHide gBtnHide x75 y265 w80 h20, &Hide
Gui Add, Tab3, x5 y5 w225 h260, General|Vagex|Hitleap|HoneyGain|FluidStack|About
;======================================================================
Gui Tab, FluidStack
Gui Add, Button, hWndhFluidstackInstall vFluidstackInstall gFluidstackInstall x160 y80 w60 h20, &Install
Gui Add, Button, hWndhFluidstackReg vFluidstackReg gFluidstackReg x160 y50 w60 h20, &Register
Gui Add, Button, hWndhFluidstackStartStop vFluidstackStartStop gFluidstackStartStop x160 y130 w60 h20, &Start
Gui Add, CheckBox, hWndhFluidstackKeepRunning vFluidstackKeepRunning gFluidstackKeepRunning x15 y130 w145 h20, Keep Service running
Gui Add, Text, x15 y110 w130 h20, Fluidstack Service status
Gui Add, Text, x15 y80 w125 h20 +0x200, Fluidstack Installed:
Gui Font, Bold cRed
Gui Add, Text, vTxtFluidstackInstalled x130 y80 w25 h20 +0x200, No
Gui Add, Text, vFluidstackSvcStatus x160 y110 w60 h20 +Center, No
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
;======================================================================
Gui Tab, HoneyGain
Gui Add, Button, hWndhHoneygainInstall vHoneygainInstall gHoneygainInstall x160 y80 w60 h20, &Install
Gui Add, Button, hWndhHoneygainReg vHoneygainReg gHoneygainReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhHoneygainHideTray vHoneygainHideTray gHoneygainHideTray x15 y120 w200 h20, Hide tray icon
Gui Add, CheckBox, hWndhHoneygainKeepRunning vHoneygainKeepRunning gHoneygainKeepRunning x15 y100 w200 h20, Keep Honeygain running
Gui Add, Text, x15 y80 w125 h20 +0x200, HoneyGain Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtHoneygainInstalled vTxtHoneygainInstalled x130 y80 w25 h20 +0x200, No
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
;======================================================================
Gui Tab, General
Gui Add, CheckBox, hStartMinimized vStartMinimized gStartMinimized x15 y110 w200 h20, Start minimized
Gui Add, CheckBox, hWndhStartWithWindows vStartWithWindows gStartWithWindows x15 y90 w200 h20, Start with Windows
Gui Add, CheckBox, hWndhTrayShowHide vTrayShowHide gTrayShowHide x15 y130 w200 h20, Show/Hide tray icon (Ctrl + 0)
Gui Add, Edit, hWndhMainTimmer vMainTimmer gMainTimmer x95 y70 w40 h20 +Right, 300
Gui Add, Text, x15 y50 w200 h20 +0x200, Press Ctrl+1 Show Main Windows
Gui Add, Text, x15 y70 w80 h20 +0x200, Main Timmer (s)
;======================================================================
Gui Tab, Vagex
Gui Add, Button, hWndhFirefoxAddon vFirefoxAddon gFirefoxAddon x160 y190 w60 h20, &Addon
Gui Add, Button, hWndhVagexInstall vVagexInstall gVagexInstall x160 y70 w60 h20, &Install
Gui Add, Button, hWndhVagexReg vVagexReg gVagexReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhFirefoxKeepRunning vFirefoxKeepRunning gFirefoxKeepRunning x15 y210 w200 h20, Keep Firefox running
Gui Add, CheckBox, hWndhFirefoxRestart vFirefoxRestart gFirefoxRestart x15 y230 w100 h20, Restart every (s)
Gui Add, CheckBox, hWndhVagexAutoClickWatchButton vVagexAutoClickWatchButton gVagexAutoClickWatchButton x15 y110 w80 h20, Click buttons:
Gui Add, CheckBox, hWndhVagexKeepRunning vVagexKeepRunning gVagexKeepRunning x15 y90 w200 h20, Keep Vagex running
Gui Add, Edit,  hWndhVagexClickButtons vVagexClickButtons gVagexClickButtons x100 y110 w110 h20, Watch
Gui Add, Edit, hWndhFirefoxRestartPeriod vFirefoxRestartPeriod gFirefoxRestartPeriod x115 y230 w40 h20 +Right, 3600
Gui Add, Text, x15 y190 w125 h20 +0x200, Firefox Installed:
Gui Add, Text, x15 y70 w125 h20 +0x200, Vagex Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtFirefoxInstalled vTxtFirefoxInstalled  x130 y190 w25 h20 +0x200, No
Gui Add, Text, hWndhTxtVagexInstalled vTxtVagexInstalled x130 y70 w25 h20 +0x200, No
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
;======================================================================
Gui Tab, Hitleap
Gui Add, Button, hWndhHitleapInstall vHitleapInstall gHitleapInstall x160 y80 w60 h20, &Install
Gui Add, Button, hWndhHitleapReg vHitleapReg gHitleapReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhHitleapHided vHitleapHided gHitleapHided x15 y120 w200 h20, Hide / Show
Gui Add, CheckBox, hWndhHitleapKeepRunning vHitleapKeepRunning gHitleapKeepRunning x15 y100 w200 h20, Keep Hitleap running
Gui Add, Text, x15 y80 w125 h20 +0x200, Hitleap Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtHitleapInstalled vTxtHitleapInstalled x130 y80 w25 h20 +0x200, No
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
;======================================================================
IniRead, StartMinimized, %Ini_File%, %Ini_Section%, StartMinimized
If !StartMinimized
{
	GuiUpdate()
	Gui Show, %ToolSize%, %ToolName%
}
GoSub, RunMainTimmer
Return
#Include cpuload.ahk
#Include download.ahk
#Include fluidstack.ahk
#Include general.ahk
#Include guisubmit.ahk
#Include guiupdate.ahk
#Include hitleap.ahk
#Include honeygain.ahk
#Include tray.ahk
#Include vagex.ahk
RunMainTimmer:
	SetTimer, RunMainTimmer, Off
	MainFluidstack()
	MainHoneygain()
	MainHitleap()
	MainVagex()
	MainFirefox()
	SetTimer, RunMainTimmer, On
Return
BtnHide:
GuiClose:
GuiEscape:
	Gui, Submit
	GuiSubmit()
Return
StartMinimized:
StartWithWindows:
TrayShowHide:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, %Ini_File%, %Ini_Section%, %GuiName%
	GuiSubmit()
	GuiUpdate()
Return
ExitTool:
^`::
	Gui, Submit
	GuiSubmit()
	MsgBox , , %ToolName%, You are Exiting %ToolName%, 3
	ExitApp
Return
^0::
	If A_IconHidden
	{
		Menu, Tray, Icon
		GuiControl,, TrayShowHide, 1
	}
	Else
	{
		Menu, Tray, NoIcon
		GuiControl,, TrayShowHide, 0
	}
Return
ShowTool:
^1::
	GuiUpdate()
	Gui Show, %ToolSize%, %ToolName%
Return
MainTimmer:

Return
