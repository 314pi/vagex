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
OS :=A_Is64bitOS ? 64 : 32
Favi :="mmo.ico"
FirefoxAddonUrl :="https://addons.mozilla.org/addon/vagex2"
FirefoxDownloadURl :="https://download.mozilla.org/`?product=firefox-latest`&os=win" . OS
FluidstackDownloadURl :="https://provider.api.fluidstack.io/download"
FluidstackMsg :="Copy your token from: https://provider.fluidstack.io/dashboard/download/get-started to use in Setup"
FluidstackRegUrl :="https://provider.fluidstack.io/`#ref=5JDIOSDCc1"
HitleapDownloadUrl :="https://hitleap.com/viewer/download`?platform=Windows"
HitleapRegUrl :="https://hitleap.com/by/kmc44210"
HoneygainDownloadUrl :="https://download.honeygain.com/windows-app/Honeygain_install.exe"
HoneygainRegUrl :="https://dashboard.honeygain.com/ref/TUONGE2B"
ToolName :="MMO Tools"
ToolSize:="W230 H290"
VagexDownloadUrl :="https://vagex.com/Vagex4/Vagex.application"
VagexRegUrl :="http://vagex.com/`?ref=458167"
IniRead, FirefoxShow, pi.ini, PiTools, FirefoxShow, 1
IniRead, HitleapShow, pi.ini, PiTools, HitleapShow, 0
IniRead, VagexShow, pi.ini, PiTools, VagexShow, 0
Check_Ini()
SetTimer, Main_Timmer, 312345
SetTimer, FirefoxRestartTimmer, 3600000
Menu, Tray, Icon, %Favi%
Gui -MinimizeBox -MaximizeBox
Gui Add, Button, hWndhBtnHide vBtnHide gBtnHide x75 y265 w80 h20, &Hide
Gui Add, Tab3, x5 y5 w225 h260, General|Vagex|HoneyGain|FluidStack|Hitleap|About
Gui Tab, HoneyGain
Gui Add, Button, hWndhHoneygainInstall vHoneygainInstall gHoneygainInstall x160 y80 w60 h20, &Install
Gui Add, Button, hWndhHoneygainReg vHoneygainReg gHoneygainReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhHoneygainKeepRunning vHoneygainKeepRunning gHoneygainKeepRunning x15 y100 w160 h20, Keep Honeygain running
Gui Add, Text, x15 y80 w125 h20 +0x200, HoneyGain Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtHoneygainInstalled vTxtHoneygainInstalled x130 y80 w25 h20 +0x200, NO
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
Gui Tab, General
Gui Add, CheckBox, hStartMinimized vStartMinimized gStartMinimized x15 y110 w120 h20, Start Minimized
Gui Add, CheckBox, hWndhStartWithWindows vStartWithWindows gStartWithWindows x15 y90 w120 h20, Start with Windows
Gui Add, Text, x15 y50 w180 h20 +0x200, Press Ctrl+0 to Hide/Unhide tray icon
Gui Add, Text, x15 y70 w180 h20 +0x200, Press Ctrl+1 Show Main Windows
Gui Tab, Vagex
Gui Add, Button, hWndhFirefoxAddon vFirefoxAddon gFirefoxAddon x160 y190 w60 h20, &Addon
Gui Add, Button, hWndhVagexInstall vVagexInstall gVagexInstall x160 y90 w60 h20, &Install
Gui Add, Button, hWndhVagexReg vVagexReg gVagexReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhFirefoxKeepRunning vFirefoxKeepRunning gFirefoxKeepRunning x15 y210 w160 h20, Keep Firefox running
Gui Add, CheckBox, hWndhFirefoxRestart vFirefoxRestart gFirefoxRestart x25 y230 w110 h20, Restart affter every
Gui Add, CheckBox, hWndhVagexAutoClickWatchButton vVagexAutoClickWatchButton gVagexAutoClickWatchButton x15 y130 w160 h20, Auto click Watch button
Gui Add, CheckBox, hWndhVagexKeepRunning vVagexKeepRunning gVagexKeepRunning x15 y110 w160 h20, Keep Vagex running
Gui Add, Edit, hWndhFirefoxRestartPeriod vFirefoxRestartPeriod gFirefoxRestartPeriod x140 y230 w40 h20 +Right, 3600
Gui Add, GroupBox, x10 y170 w215 h90, Firefox Addons Viewer
Gui Add, GroupBox, x10 y70 w215 h90, Vagex Viewer
Gui Add, Text, x15 y190 w125 h20 +0x200, Firefox Installed:
Gui Add, Text, x15 y90 w125 h20 +0x200, Vagex Installed:
Gui Add, Text, x180 y230 w15 h20 +0x200, (s)
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtFirefoxInstalled vTxtFirefoxInstalled  x130 y190 w25 h20 +0x200, NO
Gui Add, Text, hWndhTxtVagexInstalled vTxtVagexInstalled x130 y90 w25 h20 +0x200, NO
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
Gui Tab, Hitleap
Gui Add, Button, hWndhHitleapInstall vHitleapInstall gHitleapInstall x160 y80 w60 h20, &Install
Gui Add, Button, hWndhHitleapReg vHitleapReg gHitleapReg x160 y50 w60 h20, &Register
Gui Add, CheckBox, hWndhHitleapHided vHitleapHided gHitleapHided x15 y140 w160 h20, Hided
Gui Add, CheckBox, hWndhHitleapKeepRunning vHitleapKeepRunning gHitleapKeepRunning x15 y100 w160 h20, Keep Hitleap running
Gui Add, CheckBox, hWndhHitleapMinimized vHitleapMinimized gHitleapMinimized x15 y120 w160 h20, Minimized
Gui Add, Text, x15 y80 w125 h20 +0x200, Hitleap Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtHitleapInstalled vTxtHitleapInstalled x130 y80 w25 h20 +0x200, NO
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
IniRead, StartMinimized, pi.ini, PiTools, StartMinimized
If !StartMinimized
{
	Gui_Update()
	Gui Show, %ToolSize%, %ToolName%
}
GoSub, Main_Timmer
Return
#Include checkinstall.ahk
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
	General_Task()
	Main_Hitleap()
	Main_Vagex()
	Main_Firefox()
	Main_Honeygain()
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
HitleapHided:
HitleapKeepRunning:
HoneygainKeepRunning:
HitleapMinimized:
StartMinimized:
StartWithWindows:
VagexAutoClickWatchButton:
VagexKeepRunning:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, pi.ini, PiTools, %GuiName%
	Gui_Submit()
	Gui_Update()
Return
^0::
	If A_IconHidden
		Menu, Tray, Icon
	Else
		Menu, Tray, NoIcon
Return
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
^4::
	Process, Exist , simplewrapper.exe
	if ErrorLevel
	{
		HitleapShow:=!HitleapShow
		If HitleapShow
			WinShow, HitLeap Viewer
		Else
			WinHide, HitLeap Viewer
	}
Return
