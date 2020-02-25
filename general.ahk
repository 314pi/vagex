Startup() {
	Global IniFile, vgClose, vgNext
	DefaultINI=
	( LTrim
	;pi tools
	[PiTools]
	FirefoxKeepRunning=0
	FirefoxResize=1
	FirefoxRestart=1
	FirefoxRestartPeriod=1800
	FirefoxShow=1
	FirefoxSleepAfterRun=15
	FirefoxTransparent=1
	FirefoxTransparentLevel=50
	FluidstackKeepRunning=0
	GeneralTaskTimmer=15
	HitleapHided=1
	HitleapKeepRunning=0
	HitleapSleepAfterRun=5
	HoneygainHideTray=1
	HoneygainKeepRunning=0
	HoneygainSleepAfterRun=5
	MainTimmer=300
	StartMinimized=0
	StartWithWindows=0
	TrayShowHide=1
	VagexAutoClickWatchButton=1
	VagexClickButtons=Watch, Xem
	VagexKeepRunning=0
	VagexResize=1
	VagexShow=1
	VagexSleepAfterRun=30
	)
	IfNotExist, %IniFile%
		FileAppend ,% DefaultINI, %IniFile%, UTF-8
	IfNotExist, %vgClose%
		FileAppend ,, %vgClose%, UTF-8
	IfNotExist, %vgNext%
		FileAppend ,, %vgNext%, UTF-8
	Return
}
GeneralTask() {
/*
	Close some error, alert, update nortify, ...
*/
	Global IniFile, IniSection
	Loop, Read, %IniFile%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
		}
	}
	ControlSend, ,{Enter}, Update Available
	Process, Close, WerFault.exe
	WinClose, , Your connection speed is less than
	WinClose, Alert
	WinClose, Cannot Start Application, Application download did not succeed
	WinClose, Script Error
	WinClose, Vagex Viewer, Error connecting to Youtube
	WinClose, Vagex.exe - EXCEPTION
	WinClose, ahk_exe Vagex.exe, You must login
	If FirefoxTransparent
		WinSet, Transparent , % FirefoxTransparentLevel * 255 / 100, Mozilla Firefox
	Else
		WinSet, TransColor, Off, Mozilla Firefox
	If FirefoxResize
		WinMove, Mozilla Firefox, , A_ScreenWidth/2 + 50 , A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2
	If VagexResize
		WinMove, Vagex Viewer, , A_ScreenWidth/2, A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2, Loading	
	WinHide, Vagex Viewer Loading

	Return
}
CheckProgramInstalled(Program) {
	shell := ComObjCreate("Shell.Application")
	programsFolder := shell.NameSpace("::{26EE0668-A00A-44D7-9371-BEB064C98683}\8\::{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}")
	items := programsFolder.Items()
	programList := ""
	Loop, % items.Count
	{
	  this_item := items.Item(A_Index - 1)
	  programList .= this_item.Name . "`n"
	}
	IfInString, programList, %Program%
		Return True
	Else
		Return False
}
CheckServiceRunning(Service) {
	ServiceChk = sc query %Service% >"ServiceCheck.txt"
	runwait, %COMSPEC% /C %ServiceChk%, ,Hide
	ServerStatus :="No Svc"
	Loop, Read, ServiceCheck.txt
	{
		If InStr(A_LoopReadLine, "STATE")
		{
			StringGetPos, pointer, A_LoopReadLine, :
			StringRight, ServerStatus, A_LoopReadLine, StrLen(A_LoopReadLine) - pointer - 5
		}
	}
	StringLower, OutputVar, ServerStatus, T
	FileDelete, ServiceCheck.txt
	Return %OutputVar%
}