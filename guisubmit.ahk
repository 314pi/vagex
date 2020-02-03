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