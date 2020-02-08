#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance Force
DetectHiddenWindows, On
FileInstall, mmo.ico, mmo.ico
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%	 ; Ensures a consistent starting directory.
;======================================================================
#Include variables.ahk
IniRead, FirefoxShow, pi.ini, PiTools, FirefoxShow, 1
IniRead, VagexShow, pi.ini, PiTools, VagexShow, 0
Check_Ini()
SetTimer, FirefoxRestartTimmer, 3600000
SetTimer, General_Task, 15123
SetTimer, Main_Timmer, 312345
;======================================================================
Menu, Tray, Add, %Tray_Menu_2%, ShowTool
Menu, Tray, Add, %Tray_Menu_1% , ExitTool
Menu, Tray, Click, 1
Menu, Tray, Default, %Tray_Menu_Default%
Menu, Tray, Icon, %Favi%
Menu, Tray, NoStandard
Menu, Tray, Tip , %Tray_Tip%
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
Gui Add, CheckBox, hStartMinimized vStartMinimized gStartMinimized x15 y90 w200 h20, Start minimized
Gui Add, CheckBox, hWndhStartWithWindows vStartWithWindows gStartWithWindows x15 y70 w200 h20, Start with Windows
Gui Add, CheckBox, hWndhTrayShowHide vTrayShowHide gTrayShowHide x15 y110 w200 h20, Show/Hide tray icon (Ctrl + 0)
Gui Add, Text, x15 y50 w200 h20 +0x200, Press Ctrl+1 Show Main Windows
;======================================================================
Gui Tab, Vagex
Gui Add, Button, hWndhFirefoxAddon vFirefoxAddon gFirefoxAddon x160 y190 w60 h20, &Addon
Gui Add, Button, hWndhVagexInstall vVagexInstall gVagexInstall x160 y90 w60 h20, &Install
Gui Add, Button, hWndhVagexReg vVagexReg gVagexReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhFirefoxKeepRunning vFirefoxKeepRunning gFirefoxKeepRunning x15 y210 w200 h20, Keep Firefox running
Gui Add, CheckBox, hWndhFirefoxRestart vFirefoxRestart gFirefoxRestart x25 y230 w110 h20, Restart affter every
Gui Add, CheckBox, hWndhVagexAutoClickWatchButton vVagexAutoClickWatchButton gVagexAutoClickWatchButton x15 y130 w200 h20, Auto click Watch button
Gui Add, CheckBox, hWndhVagexKeepRunning vVagexKeepRunning gVagexKeepRunning x15 y110 w200 h20, Keep Vagex running
Gui Add, Edit, hWndhFirefoxRestartPeriod vFirefoxRestartPeriod gFirefoxRestartPeriod x140 y230 w40 h20 +Right, 3600
Gui Add, GroupBox, x10 y170 w215 h90, Firefox Addons Viewer
Gui Add, GroupBox, x10 y70 w215 h90, Vagex Viewer
Gui Add, Text, x15 y190 w125 h20 +0x200, Firefox Installed:
Gui Add, Text, x15 y90 w125 h20 +0x200, Vagex Installed:
Gui Add, Text, x180 y230 w15 h20 +0x200, (s)
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtFirefoxInstalled vTxtFirefoxInstalled  x130 y190 w25 h20 +0x200, No
Gui Add, Text, hWndhTxtVagexInstalled vTxtVagexInstalled x130 y90 w25 h20 +0x200, No
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
IniRead, StartMinimized, pi.ini, PiTools, StartMinimized
If !StartMinimized
{
	Gui_Update()
	Gui Show, %ToolSize%, %ToolName%
}
GoSub, Main_Timmer
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
Main_Timmer:
	SetTimer, Main_Timmer, Off
	Main_Fluidstack()
	Main_Honeygain()
	Main_Hitleap()
	Main_Vagex()
	Main_Firefox()
	SetTimer, Main_Timmer, On
Return
BtnHide:
GuiClose:
GuiEscape:
	Gui, Submit
	Gui_Submit()
Return
FirefoxKeepRunning:
FirefoxRestart:
FirefoxRestartPeriod:
FluidstackKeepRunning:
HitleapHided:
HitleapKeepRunning:
HoneygainHideTray:
HoneygainKeepRunning:
StartMinimized:
StartWithWindows:
TrayShowHide:
VagexAutoClickWatchButton:
VagexKeepRunning:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, pi.ini, PiTools, %GuiName%
	Gui_Submit()
	Gui_Update()
Return
ExitTool:
^`::
	Gui, Submit
	Gui_Submit()
	MsgBox , , %ToolName%, You are Exiting %ToolName%, 3

	ExitApp
Return
^0::
	If A_IconHidden
	{
		Menu, Tray, Icon
		GuiControl,, TrayShowHide, 1
	}
	Else {
		Menu, Tray, NoIcon
		GuiControl,, TrayShowHide, 0
	}
Return
ShowTool:
^1::
	Menu, Tray, Icon
	Gui_Update()
	Gui Show, %ToolSize%, %ToolName%
Return
^2::
	Process, Exist , vagex.exe
	if ErrorLevel
	{
		VagexShow:=!VagexShow
		If VagexShow
		{
			WinShow, Vagex Viewer
			Sleep, 1123
			WinRestore, Vagex Viewer
		}
		Else
			WinMinimize, Vagex Viewer
	}
Return
^3::
	Process, Exist , firefox.exe
	if ErrorLevel
	{
		FirefoxShow:=!FirefoxShow
		If FirefoxShow
			WinShow, Mozilla Firefox
		Else
			WinHide, Mozilla Firefox
	}
Return