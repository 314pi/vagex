IniRead, FirefoxRestartPeriod, %Ini_File%, %Ini_Section%, FirefoxRestartPeriod, 3600
IniRead, FirefoxShow, %Ini_File%, %Ini_Section%, FirefoxShow, 1
IniRead, VagexShow, %Ini_File%, %Ini_Section%, VagexShow, 0
SetTimer, FirefoxRestartTimmer, % FirefoxRestartPeriod*1000
FirefoxKeepRunning:
	GuiControlGet, OutVal ,, %A_GuiControl%
	IniWrite, %OutVal%, %Ini_File%, %Ini_Section%, %A_GuiControl%
	MainFirefox()
Return
FirefoxRestart:
	IniRead, FirefoxKeepRunning, %Ini_File%, %Ini_Section%, FirefoxKeepRunning, 0
	IniRead, FirefoxRestart, %Ini_File%, %Ini_Section%, FirefoxRestart, 0
	IniRead, FirefoxRestartPeriod, %Ini_File%, %Ini_Section%, FirefoxRestartPeriod, 3600
	If FirefoxRestart & FirefoxKeepRunning
		SetTimer, FirefoxRestartTimmer, % FirefoxRestartPeriod*1000
	Else
		SetTimer, FirefoxRestartTimmer, Off
Return
FirefoxRestartPeriod:
	GuiControlGet, OutVal ,, %A_GuiControl%
	IniWrite, %OutVal%, %Ini_File%, %Ini_Section%, %A_GuiControl%
Return
VagexAutoClickWatchButton:
	GuiControlGet, OutVal ,, %A_GuiControl%
	IniWrite, %OutVal%, %Ini_File%, %Ini_Section%, %A_GuiControl%
Return
VagexClickButtons:
	GuiControlGet, OutVal ,, %A_GuiControl%
	IniWrite, %OutVal%, %Ini_File%, %Ini_Section%, %A_GuiControl%
Return
VagexKeepRunning:
	GuiControlGet, OutVal ,, %A_GuiControl%
	IniWrite, %OutVal%, %Ini_File%, %Ini_Section%, %A_GuiControl%
	MainVagex()
Return
^2::
	Process, Exist , vagex.exe
	If ErrorLevel
	{
		VagexShow:=!VagexShow
		If VagexShow
		{
			WinShow, Vagex Viewer,, Loading
			Sleep, 1123
			WinMove, Vagex Viewer, , A_ScreenWidth/2, A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2, Loading
		}
		Else
			WinMinimize, Vagex Viewer,, Loading
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
			WinSet, TransColor, Off, Mozilla Firefox
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
	GuiControl,, VagexClickButtons , % Trim(VagexClickButtons)
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
			Sleep, % VagexSleepAfterRun * 1000
			WinMove, Vagex Viewer, , A_ScreenWidth/2, A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2, Loading
		}
		Else
		{
			If VagexAutoClickWatchButton
			{
				GuiControlGet, BtnList ,, VagexClickButtons
				Loop, Parse, BtnList , `,
				{
					WinClose , ahk_exe Vagex.exe, You must login
					WinShow, Vagex Viewer,, Loading
					Sleep, 1123
					WinActivate, Vagex Viewer,, Loading
					WinMove, Vagex Viewer, , A_ScreenWidth/2, A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2, Loading
					ControlGet, Btn2Clk, Visible ,, % Trim(A_LoopField) , Vagex Viewer,, Loading
					If Btn2Clk
					{
						ControlClick, % Trim(A_LoopField) , Vagex Viewer
						FileAppend, %A_DD%/%A_MM%/%A_YYYY%@%A_Hour%:%A_Min%:%A_Sec%: Clicked %A_LoopField%.`n, %A_MM%%A_YYYY%.log
					}
				}
			}
		}
	}
	If !VagexShow
		WinMinimize, Vagex Viewer, , Loading
	Return
}
MainFirefox() {
	Global Ini_File, Ini_Section
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
			Sleep, % FirefoxSleepAfterRun * 1000
		}
		WinMove, Mozilla Firefox, , A_ScreenWidth/2 + 50 , A_ScreenHeight/2 , A_ScreenWidth/2, A_ScreenHeight/2
		WinSet, Transparent , 2, Mozilla Firefox
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
			Sleep, % FirefoxSleepAfterRun * 1000
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
