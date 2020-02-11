FirefoxKeepRunning:
FirefoxRestart:
FirefoxRestartPeriod:
VagexAutoClickWatchButton:
VagexClickButtons:
VagexKeepRunning:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, %Ini_File%, %Ini_Section%, %GuiName%
	GuiSubmit()
	GuiUpdate()
Return
^2::
	Process, Exist , vagex.exe
	If ErrorLevel
	{
		VagexShow:=!VagexShow
		If VagexShow
		{
			WinShow, Vagex Viewer
			Sleep, 1123
			WinMove, Vagex Viewer, , A_ScreenWidth/2, A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2
		}
		Else
			WinMinimize, Vagex Viewer
	}
Return
^3::
	Process, Exist , firefox.exe
	If ErrorLevel
	{
		FirefoxShow:=!FirefoxShow
		If FirefoxShow
		{
			WinShow, Mozilla Firefox
			WinMove, Mozilla Firefox, , A_ScreenWidth/2 + 50 , A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2
		}
		Else
			WinHide, Mozilla Firefox
	}
Return
MainVagex() {
	Global Ini_File, Ini_Section
	VagexShow = 0
	Loop, Read, %Ini_File%
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
MainFirefox() {
	FirefoxShow = 1
	Loop, Read, %Ini_File%
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
	Loop, Read, %Ini_File%
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
		MainFirefox()
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
	GuiUpdate()
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
	GuiUpdate()
	Return
}
