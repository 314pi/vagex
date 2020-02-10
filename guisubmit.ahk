FirefoxKeepRunning:
FirefoxRestart:
FirefoxRestartPeriod:
FluidstackKeepRunning:
HitleapHided:
HitleapKeepRunning:
HoneygainHideTray:
HoneygainKeepRunning:
StartMinimized:
StartWithWindows:
TrayShowHide:
VagexAutoClickWatchButton:
VagexKeepRunning:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, %Cfg_File%, PiTools, %GuiName%
	Gui_Update()
Return

Gui_Submit() {
	Global Cfg_File
	Loop, Read, %Cfg_File%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControlGet, %magic1% ,, %magic1%
			If !ErrorLevel
				IniWrite, % %magic1%, %Cfg_File%, PiTools, %magic1%
		}
	}
	If FirefoxRestart & FirefoxKeepRunning
		SetTimer, FirefoxRestartTimmer, % FirefoxRestartPeriod*1000
	Else
		SetTimer, FirefoxRestartTimmer, Off
	Return
}