Main_Vagex() {
	VagexShow = 0
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
		}
	}
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
		Else
		{
			If VagexAutoClickWatchButton
			{
				WinShow, Vagex Viewer
				Sleep, 1123
				ControlGet, PauseBtnVis, Visible,, %VagexPauseBtn% , Vagex Viewer
				If PauseBtnVis
				{
					If !VagexShow
						WinMinimize, Vagex Viewer
					Return
				}
				ControlGet, WatchBtnVis, Visible,, %VagexWatchBtn% , Vagex Viewer
				ControlGet, WatchXBtnVis, Visible,, %VagexWatchXBtn% , Vagex Viewer
				If ( WatchBtnVis or WatchXBtnVis )
				{
					ControlClick, %VagexWatchBtn% , Vagex Viewer
					Sleep, 1123
					ControlClick, %WatchXBtnVis% , Vagex Viewer
					FileAppend, %A_DD%/%A_MM%/%A_YYYY%@%A_Hour%:%A_Min%:%A_Sec%: Pressed Watch Button.`n, %A_MM%%A_YYYY%.log
					If !VagexShow
						WinMinimize, Vagex Viewer
					Return
				}
			}
		}
	}
	Return
}
Main_Firefox() {
	FirefoxShow = 1
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
		}
	}
	If FirefoxKeepRunning
	{
		Process, Exist , firefox.exe
		If !ErrorLevel
		{
			RunWait, "firefox.exe"
			Sleep, %FirefoxSleepAfterRun%
		}
	}
	If !FirefoxShow
		WinHide, Mozilla Firefox
	Return
}
FirefoxRestartTimmer:
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
		}
	}
	If FirefoxRestart & FirefoxKeepRunning
	{
		Process, Exist , firefox.exe
		If ErrorLevel
		{
			GroupAdd MyGroup, ahk_class MozillaWindowClass
			WinClose ahk_group MyGroup
			Sleep, %FirefoxSleepAfterRun%
		}
		Main_Firefox()
	}
Return
VagexReg() {
	VagexRegUrl :="http://vagex.com/`?ref=458167"
	Run %VagexRegUrl%
	Return
}
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
	Else
	{
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
		Else
		{
			Clipboard:=FirefoxDownloadURl
			MsgBox Link copied, paste (Ctrl+V) into your browser to download Firefox setup file.
		}
	}
	Else
	{
		FirefoxAddonUrl :="https://addons.mozilla.org/addon/vagex2"
		RunWait, firefox.exe %FirefoxAddonUrl%
	}
	Gui_Update()
	Return
}
