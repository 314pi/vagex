Check_Ini() {
	vDefault_ini=
	( LTrim
	;pi tools
	[PiTools]
	FirefoxKeepRunning=1
	FirefoxRestart=1
	FirefoxRestartPeriod=3600
	FluidstackKeepRunning=1
	HitleapHided=1
	TrayShowHide=1
	HitleapKeepRunning=1
	HoneygainKeepRunning=1
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