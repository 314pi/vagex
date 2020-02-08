Check_Ini() {
	vDefault_ini=
	( LTrim
	;pi tools
	[PiTools]
	FirefoxKeepRunning=0
	FirefoxRestart=1
	FirefoxRestartPeriod=3600
	FirefoxSleepAfterRun=120123
	FluidstackKeepRunning=0
	HitleapHided=1
	HitleapKeepRunning=0
	HitleapSleepAfterRun=120123
	HoneygainHideTray=1
	HoneygainKeepRunning=0
	HoneygainSleepAfterRun=120123
	StartMinimized=0
	StartWithWindows=0
	TrayShowHide=1
	VagexAutoClickWatchButton=1
	VagexKeepRunning=0
	VagexSleepAfterRun=120123
	)
	IfNotExist, pi.ini
		FileAppend ,% vDefault_ini, pi.ini, UTF-8
	Return
}
General_Task() {
/*
	Close some error, alert, update nortify, ...
*/
	ControlSend, ,{Enter}, Script Error
	ControlSend, ,{Enter}, Update Available
	Process, Close, %ErrorLevel%
	WinActivate, Script Error
	WinClose Alert
	WinClose Vagex.exe - EXCEPTION
	Return
}
Check_Program_Installed(Program) {
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
Check_Service_Running(Service) {
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