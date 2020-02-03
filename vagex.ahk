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
VagexReg() {
	Global VagexRegUrl
	Run %VagexRegUrl%
	Return
}