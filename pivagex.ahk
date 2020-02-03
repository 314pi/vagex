#Include checkinstall.ahk
#Include download.ahk
#Include tray.ahk
FileInstall, mmo.ico, mmo.ico
#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance Force
DetectHiddenWindows, On
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%	 ; Ensures a consistent starting directory.
;======================================================================
OS :=A_Is64bitOS ? 64 : 32
Favi :="mmo.ico"
FirefoxAddonUrl :="https://addons.mozilla.org/addon/vagex2"
FirefoxDownloadURl :="https://download.mozilla.org/`?product=firefox-latest`&os=win" . OS
HitleapDownloadUrl :="https://hitleap.com/viewer/download`?platform=Windows"
HitleapRegUrl :="https://hitleap.com/by/kmc44210"
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
Gui Add, Tab3, x5 y5 w220 h260, General|Vagex|Hitleap|About
Gui Tab, General
Gui Add, CheckBox, hStartMinimized vStartMinimized gStartMinimized x15 y110 w120 h20, Start Minimized
Gui Add, CheckBox, hWndhStartWithWindows vStartWithWindows gStartWithWindows x15 y90 w120 h20, Start with Windows
Gui Add, Text, x15 y50 w180 h20 +0x200, Press Ctrl+0 to Hide/Unhide tray icon
Gui Add, Text, x15 y70 w180 h20 +0x200, Press Ctrl+1 Show Main Windows
Gui Tab, Vagex
Gui Add, Button, hWndhFirefoxAddon vFirefoxAddon gFirefoxAddon x135 y190 w60 h20, &Addon
Gui Add, Button, hWndhVagexInstall vVagexInstall gVagexInstall x135 y90 w60 h20, &Install
Gui Add, Button, x150 y50 w70 h20, &Register
Gui Add, CheckBox, hWndhFirefoxKeepRunning vFirefoxKeepRunning gFirefoxKeepRunning x15 y210 w160 h20, Keep Firefox running
Gui Add, CheckBox, hWndhFirefoxRestart vFirefoxRestart gFirefoxRestart x25 y230 w110 h20, Restart affter every
Gui Add, CheckBox, hWndhVagexAutoClickWatchButton vVagexAutoClickWatchButton gVagexAutoClickWatchButton x15 y130 w160 h20, Auto click Watch button
Gui Add, CheckBox, hWndhVagexKeepRunning vVagexKeepRunning gVagexKeepRunning x15 y110 w160 h20, Keep Vagex running
Gui Add, Edit, hWndhFirefoxRestartPeriod vFirefoxRestartPeriod gFirefoxRestartPeriod x140 y230 w40 h20 +Right, 3600
Gui Add, GroupBox, x10 y170 w210 h90, Firefox Addons Viewer
Gui Add, GroupBox, x10 y70 w210 h90, Vagex Viewer
Gui Add, Text, x15 y190 w85 h20 +0x200, Firefox Installed:
Gui Add, Text, x15 y90 w85 h20 +0x200, Vagex Installed:
Gui Add, Text, x180 y230 w15 h20 +0x200, (s)
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtFirefoxInstalled vTxtFirefoxInstalled  x100 y190 w30 h20 +0x200, NO
Gui Add, Text, hWndhTxtVagexInstalled vTxtVagexInstalled x100 y90 w30 h20 +0x200, NO
Gui Add, Text, x15 y50 w135 h20 +0x200, Do not have Account?
Gui Font
Gui Tab, Hitleap
Gui Add, Button, hWndhHitleapInstall vHitleapInstall gHitleapInstall x135 y80 w60 h20, &Install
Gui Add, Button, x150 y50 w70 h20, &Register
Gui Add, CheckBox, hWndhHitleapHided vHitleapHided gHitleapHided x15 y140 w160 h20, Hided
Gui Add, CheckBox, hWndhHitleapKeepRunning vHitleapKeepRunning gHitleapKeepRunning x15 y100 w160 h20, Keep Hitleap running
Gui Add, CheckBox, hWndhHitleapMinimized vHitleapMinimized gHitleapMinimized x15 y120 w160 h20, Minimized
Gui Add, Text, x15 y80 w85 h20 +0x200, Hitleap Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtHitleapInstalled vTxtHitleapInstalled x100 y80 w30 h20 +0x200, NO
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
Main_Timmer:
	General_Task()
	Main_Hitleap()
	Main_Vagex()
	Main_Firefox()
	General_Task()
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
Gui_Update() {
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControl,, %magic1% , %magic2%
		}
	}
	If Check_Program_Installed("Vagex Viewer")
	{
		GuiControl,, TxtVagexInstalled , YES
		GuiControl,Disable, VagexInstall
		GuiControl,Enable, VagexKeepRunning
		If VagexKeepRunning
			GuiControl,Enable, VagexAutoClickWatchButton
		Else
			GuiControl,Disable, VagexAutoClickWatchButton
	}
	Else {
		GuiControl,, VagexKeepRunning,0
		GuiControl,, VagexAutoClickWatchButton,0
		GuiControl,Disable, VagexKeepRunning
		GuiControl,Disable, VagexAutoClickWatchButton
	}
	If Check_Program_Installed("Mozilla Firefox")
	{
		GuiControl,, TxtFirefoxInstalled , YES
		GuiControl,, FirefoxAddon, &Addon
		GuiControl,Enable, FirefoxKeepRunning
		If FirefoxKeepRunning
		{
			GuiControl,Enable, FirefoxRestart
			If FirefoxRestart
				GuiControl,Enable, FirefoxRestartPeriod
			Else
				GuiControl,Disable, FirefoxRestartPeriod
		} Else {
			GuiControl,Disable, FirefoxRestart
			GuiControl,Disable, FirefoxRestartPeriod
		}
	}
	Else {
		GuiControl,, FirefoxKeepRunning,0
		GuiControl,, FirefoxRestart,0
		GuiControl,, FirefoxAddon, &Install
		GuiControl,Disable, FirefoxKeepRunning
		GuiControl,Disable, FirefoxRestart
		GuiControl,Disable, FirefoxRestartPeriod
	}
	If Check_Program_Installed("Hitleap Viewer")
	{
		GuiControl,, TxtHitleapInstalled , YES
		GuiControl,Disable, HitleapInstall
		GuiControl,Enable, HitleapKeepRunning
		If HitleapKeepRunning
		{
			GuiControl,Enable, HitleapHided
			GuiControl,Enable, HitleapMinimized
		}
		Else {
			GuiControl,Disable, HitleapHided
			GuiControl,Disable, HitleapMinimized
		}
	}
	Else {
		GuiControl,, HitleapHided,0
		GuiControl,, HitleapKeepRunning,0
		GuiControl,, HitleapMinimized,0
		GuiControl,Disable, HitleapHided
		GuiControl,Disable, HitleapKeepRunning
		GuiControl,Disable, HitleapMinimized
	}
	Gui_Submit()
	Return
}
Gui_Submit() {
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControlGet, %magic1% ,, %magic1%
			IniWrite, % %magic1%, pi.ini, PiTools, %magic1%
		}
	}
	If StartWithWindows
	{
		SplitPath, A_Scriptname, , , , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		IfNotExist, %LinkFile%
			FileCreateShortcut, %A_ScriptFullPath%, %LinkFile% ; Admin right ?
	}
	Else {
		SplitPath, A_Scriptname, , , , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		FileDelete, %LinkFile%
	}
	If FirefoxRestart
		SetTimer, FirefoxRestartTimmer, % FirefoxRestartPeriod*1000
	Else
		SetTimer, FirefoxRestartTimmer, Off
	Return
}
Check_Ini() {
	vDefault_ini=
	( LTrim
	;pi tools
	[PiTools]
	FirefoxKeepRunning=1
	FirefoxRestart=1
	FirefoxRestartPeriod=3600
	HitleapHided=1
	HitleapKeepRunning=1
	HitleapMinimized=1
	StartMinimized=0
	StartWithWindows=0
	VagexAutoClickWatchButton=1
	VagexKeepRunning=1
	)
	IfNotExist, pi.ini
		FileAppend ,% vDefault_ini, pi.ini, UTF-8
	Return
}
General_Task() {
/*	Close some error, alert, update nortify, ...
 *
 */
	IfWinExist, Vagex.exe - EXCEPTION
	{
		WinActivate, Vagex.exe - EXCEPTION
		WinClose
	}
	IfWinExist, Script Error
	{
		WinActivate, Script Error
		ControlSend, ,{Enter}, Script Error
	}
	IfWinExist, Update Available
	{
		WinActivate, Update Available
		ControlSend, ,{Enter}, Update Available
		Sleep, 121234
	}
	IfWinExist, Alert
	{
		WinActivate, Alert
		WinClose
	}
	Process, Exist , WerFault.exe
	if ErrorLevel
		Process, Close, %ErrorLevel%
	Tray_Refresh()
	Return
}
HitleapInstall() {
	Global HitleapDownloadUrl
	save = HitleapViewer.exe
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(HitleapDownloadUrl, save, message, 50)
	Progress, Off
	RunWait, %save%
	Gui_Update()
	Return
}
VagexInstall() {
	Global VagexDownloadUrl
	save = Vagex.application
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(VagexDownloadUrl, save, message, 50)
	Progress, Off
	IfExist %save%
		RunWait, %save%
	Else {
		Clipboard:=VagexDownloadUrl
		MsgBox Link copied, paste (Ctrl+V) into your browser to download Vagex setup file.
	}
	Gui_Update()
	Return
}
FirefoxAddon() {
	GuiControlGet, FirefoxAddon ,, FirefoxAddon
	IfInString, FirefoxAddon, Install
	{
		Global FirefoxDownloadURl
		save = FirefoxSetup.exe
		FileDelete, %save%
		message = 0x1100
		Progress, M H80, , .
		OnMessage(message, "SetCounter")
		DownloadProgress(FirefoxDownloadURl, save, message, 50)
		Progress, Off
		IfExist %save%
			RunWait, %save%
		Else {
			Clipboard:=FirefoxDownloadURl
			MsgBox Link copied, paste (Ctrl+V) into your browser to download Firefox setup file.
		}
	}
	Else {
		Global FirefoxAddonUrl
		RunWait, firefox.exe %FirefoxAddonUrl%
	}
	Gui_Update()
	Return
}
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
Main_Vagex() {
	WatchButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad15
	WatchButtonx = WindowsForms10.BUTTON.app.0.34f5582_r9_ad12
	PauseButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad14
	AccButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad16
	IniRead, VagexAutoClickWatchButton, pi.ini, PiTools, VagexAutoClickWatchButton
	IniRead, VagexKeepRunning, pi.ini, PiTools, VagexKeepRunning
	IniRead, VagexShow, pi.ini, PiTools, VagexShow,0
	If VagexKeepRunning
	{
		Process, Exist , vagex.exe
		If !ErrorLevel
		{
			IfNotExist Vagex.application
			{
				Global VagexDownloadUrl
				UrlDownloadToFile, %VagexDownloadUrl%, Vagex.application
			}
			RunWait, Vagex.application
			Sleep, 15123
		}
		Else {
			If VagexAutoClickWatchButton
			{
				WinShow, Vagex Viewer
				Sleep, 1123
				WinRestore, Vagex Viewer
				Sleep, 3123
				ControlGet, OutputVar, Visible,, %WatchButtonx% , Vagex Viewer
				If (OutputVar)
				{
					WinClose, Vagex Viewer
					FileAppend, %A_DD%/%A_MM%/%A_YYYY%@%A_Hour%:%A_Min%:%A_Sec%: Close Vagex.`n, %A_MM%%A_YYYY%.log
				}
				ControlGet, OutputVar, Visible,, %WatchButton% , Vagex Viewer
				If (OutputVar)
				{
					ControlClick, %WatchButton% , Vagex Viewer
					FileAppend, %A_DD%/%A_MM%/%A_YYYY%@%A_Hour%:%A_Min%:%A_Sec%: Pressed Watch Button.`n, %A_MM%%A_YYYY%.log
				}
			}
		}
		If !VagexShow
			WinMinimize, Vagex Viewer
	}
	Return
}
Main_Firefox() {
	IniRead, FirefoxKeepRunning, pi.ini, PiTools, FirefoxKeepRunning
	IniRead, FirefoxRestart, pi.ini, PiTools, FirefoxRestart
	IniRead, FirefoxRestartPeriod, pi.ini, PiTools, FirefoxRestartPeriod
	IniRead, FirefoxShow, pi.ini, PiTools, FirefoxShow,1
	If FirefoxKeepRunning
	{
		Process, Exist , firefox.exe
		If !ErrorLevel
		{
			RunWait, "firefox.exe"
			Sleep, 15123
			If !FirefoxShow
				WinHide, Mozilla Firefox
		}
	}
	Return
}
Main_Hitleap() {
	IniRead, HitleapHided, pi.ini, PiTools, HitleapHided
	IniRead, HitleapKeepRunning, pi.ini, PiTools, HitleapKeepRunning
	IniRead, HitleapMinimized, pi.ini, PiTools, HitleapMinimized
	If HitleapKeepRunning
	{
		Process, Exist , simplewrapper.exe
		If !ErrorLevel
		{
			IfNotExist Hitleap.lnk
			{
				SplitPath, A_AppData, , Hitleappath
				Hitleappath := Hitleappath . "\Local\HitLeap Viewer\app\lua.exe"
				SplitPath, Hitleappath, , Hitleapdir
				FileCreateShortcut, %Hitleappath%, Hitleap.lnk, %Hitleapdir%, HitLeap-Viewer.lua Windows
			}
			Run, Hitleap.lnk
			Sleep, 15123
		}
	}
	If HitleapMinimized
		WinMinimize, HitLeap Viewer
	If HitleapHided
		WinHide, HitLeap Viewer
	Return
}
FirefoxRestartTimmer:
	IniRead, FirefoxRestart, pi.ini, PiTools, FirefoxRestart,0
	If FirefoxRestart
	{
		Process, Exist , firefox.exe
		If ErrorLevel
		{
			WinClose, Mozilla Firefox
			Sleep, 15123
		}
		RunWait, "firefox.exe"
		Sleep, 15123
		If !FirefoxShow
			WinHide, Mozilla Firefox
	}
Return