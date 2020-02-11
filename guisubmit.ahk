GuiSubmit() {
	Global Ini_File, Ini_Section
	Loop, Read, %Ini_File%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControlGet, %magic1% ,, %magic1%
			If !ErrorLevel
				IniWrite, % %magic1%, %Ini_File%, %Ini_Section%, %magic1%
		}
	}
	If StartWithWindows
	{
		SplitPath, A_ScriptFullPath, , OutDir, , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		IfNotExist, %LinkFile%
			FileCreateShortcut, %A_ScriptFullPath%, %LinkFile%, %OutDir% ; Admin right ?
	}
	Else
	{
		SplitPath, A_Scriptname, , , , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		FileDelete, %LinkFile%
	}
	If FirefoxRestart & FirefoxKeepRunning
		SetTimer, FirefoxRestartTimmer, % FirefoxRestartPeriod*1000
	Else
		SetTimer, FirefoxRestartTimmer, Off
	Return
}