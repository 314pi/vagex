VagexInstall() {
	VagexDownloadUrl :="https://vagex.com/Vagex4/Vagex.application"
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
		OS :=A_Is64bitOS ? 64 : 32
		FirefoxDownloadURl :="https://download.mozilla.org/`?product=firefox-latest`&os=win" . OS
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
		FirefoxAddonUrl :="https://addons.mozilla.org/addon/vagex2"
		RunWait, firefox.exe %FirefoxAddonUrl%
	}
	Gui_Update()
	Return
}
Main_Vagex() {
	WatchButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad15
	WatchButtonx = WindowsForms10.BUTTON.app.0.34f5582_r9_ad12
	PauseButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad14
	AccButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad16
	IniRead, VagexAutoClickWatchButton, pi.ini, PiTools, VagexAutoClickWatchButton, 1
	IniRead, VagexKeepRunning, pi.ini, PiTools, VagexKeepRunning, 1
	IniRead, VagexShow, pi.ini, PiTools, VagexShow, 0
	IniRead, VagexSleepAfterRun, pi.ini, PiTools, VagexSleepAfterRun, 120123
	If VagexKeepRunning
	{
		Process, Exist , vagex.exe
		If !ErrorLevel
		{
			IfNotExist Vagex.application
			{
				VagexDownloadUrl :="https://vagex.com/Vagex4/Vagex.application"
				UrlDownloadToFile, %VagexDownloadUrl%, Vagex.application
			}
			RunWait, Vagex.application
			Sleep, %VagexSleepAfterRun%
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
	IniRead, FirefoxKeepRunning, pi.ini, PiTools, FirefoxKeepRunning, 1
	IniRead, FirefoxRestart, pi.ini, PiTools, FirefoxRestart, 1
	IniRead, FirefoxRestartPeriod, pi.ini, PiTools, FirefoxRestartPeriod, 3600
	IniRead, FirefoxShow, pi.ini, PiTools, FirefoxShow, 1
	IniRead, FirefoxSleepAfterRun, pi.ini, PiTools, FirefoxSleepAfterRun, 120123
	If FirefoxKeepRunning
	{
		Process, Exist , firefox.exe
		If !ErrorLevel
		{
			RunWait, "firefox.exe"
			Sleep, %FirefoxSleepAfterRun%
			If !FirefoxShow
				WinHide, Mozilla Firefox
		}
	}
	Return
}
FirefoxRestartTimmer:
	IniRead, FirefoxRestart, pi.ini, PiTools, FirefoxRestart, 0
	IniRead, FirefoxSleepAfterRun, pi.ini, PiTools, FirefoxSleepAfterRun, 120123
	If FirefoxRestart
	{
		Process, Exist , firefox.exe
		If ErrorLevel
		{
			WinClose, Mozilla Firefox
			Sleep, %FirefoxSleepAfterRun%
		}
		RunWait, "firefox.exe"
		Sleep, %FirefoxSleepAfterRun%
		If !FirefoxShow
			WinHide, Mozilla Firefox
	}
Return
VagexReg() {
	VagexRegUrl :="http://vagex.com/`?ref=458167"
	Run %VagexRegUrl%
	Return
}