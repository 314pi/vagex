GuiUpdate() {
	Global Ini_File
	Loop, Read, %Ini_File%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControl,, %magic1% , %magic2%
		}
	}
	If TrayShowHide
	{
		Menu, Tray, Icon
		GuiControl,, TrayShowHide, 1
	}
	Else
	{
		Menu, Tray, NoIcon
		GuiControl,, TrayShowHide, 0
	}
	If CheckProgramInstalled("Vagex Viewer")
	{
		GuiControl,, TxtVagexInstalled , Yes
		GuiControl,Disable, VagexInstall
		GuiControl,Enable, VagexKeepRunning
		If VagexKeepRunning
		{
			GuiControl,Enable, VagexAutoClickWatchButton
			GuiControl,Enable, VagexClickButtons
		}
		Else
		{
			GuiControl,Disable, VagexAutoClickWatchButton
			GuiControl,Disable, VagexClickButtons
		}
	}
	Else
	{
		GuiControl,Disable, VagexKeepRunning
		GuiControl,Disable, VagexAutoClickWatchButton
		GuiControl,Disable, VagexClickButtons
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
	GuiSubmit()
	Return
}