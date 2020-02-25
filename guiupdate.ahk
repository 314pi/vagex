GuiUpdate() {
	Global IniFile
	Loop, Read, %IniFile%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControl,, %magic1% , %magic2%
		}
	}
	GuiControl,, VagexClickButtons , % Trim(VagexClickButtons)
	If TrayShowHide
		Menu, Tray, Icon
	Else
		Menu, Tray, NoIcon
	If CheckProgramInstalled("Vagex Viewer")
	{
		GuiControl,, TxtVagexInstalled , Yes
		GuiControl,Disable, VagexInstall
		GuiControl,Enable, VagexAutoClickWatchButton
		GuiControl,Enable, VagexClickButtons
		GuiControl,Enable, VagexKeepRunning
	}
	Else
	{
		GuiControl,, TxtVagexInstalled , No
		GuiControl,Disable, VagexAutoClickWatchButton
		GuiControl,Disable, VagexClickButtons
		GuiControl,Disable, VagexKeepRunning
		GuiControl,Enable, VagexInstall
	}
	If CheckProgramInstalled("Mozilla Firefox")
	{
		GuiControl,, FirefoxAddon, &Addon
		GuiControl,, TxtFirefoxInstalled , Yes
		GuiControl,Enable, FirefoxKeepRunning
		GuiControl,Enable, FirefoxRestart
		GuiControl,Enable, FirefoxRestartPeriod
	}
	Else
	{
		GuiControl,, FirefoxAddon, &Install
		GuiControl,, TxtFirefoxInstalled , No
		GuiControl,Disable, FirefoxKeepRunning
		GuiControl,Disable, FirefoxRestart
		GuiControl,Disable, FirefoxRestartPeriod
	}
	If CheckProgramInstalled("Hitleap Viewer")
	{
		GuiControl,, TxtHitleapInstalled , Yes
		GuiControl,Disable, HitleapInstall
		GuiControl,Enable, HitleapKeepRunning
		GuiControl,Enabled, HitleapHided
	}
	Else {
		GuiControl,, TxtHitleapInstalled , No
		GuiControl,Enable, HitleapInstall
		GuiControl,Disable, HitleapHided
		GuiControl,Disable, HitleapKeepRunning
	}
	If CheckProgramInstalled("Honeygain")
	{
		GuiControl,, TxtHoneygainInstalled , Yes
		GuiControl,Disable, HoneygainInstall
		GuiControl,Enable, HoneygainHideTray
		GuiControl,Enable, HoneygainKeepRunning
	}
	Else
	{
		GuiControl,, TxtHoneygainInstalled , No
		GuiControl,Enable, HoneygainInstall
		GuiControl,Disable, HoneygainHideTray
		GuiControl,Disable, HoneygainKeepRunning
	}
	FluidstackSvcStatus :=CheckServiceRunning("FluidStackNode")
	GuiControl,, FluidstackSvcStatus, %FluidstackSvcStatus%
	If CheckProgramInstalled("FluidStack Node")
	{
		GuiControl,, TxtFluidstackInstalled , Yes
		GuiControl,Disable, FluidstackInstall
		GuiControl,Enable, FluidstackKeepRunning
		IfInString, FluidstackSvcStatus, Stop
			GuiControl,Enable, FluidstackStartStop
		Else
			GuiControl,Disable, FluidstackStartStop
	}
	Else
	{
		GuiControl,, TxtFluidstackInstalled , No
		GuiControl,Disable, FluidstackKeepRunning
		GuiControl,Disable, FluidstackStartStop
		GuiControl,Enable, FluidstackInstall
	}
	Return
}