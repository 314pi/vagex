Gui_Update() {
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControl,, %magic1% , %magic2%
		}
	}
	If Check_Program_Installed("Vagex Viewer")
	{
		GuiControl,, TxtVagexInstalled , Yes
		GuiControl,Disable, VagexInstall
		GuiControl,Enable, VagexKeepRunning
		If VagexKeepRunning
			GuiControl,Enable, VagexAutoClickWatchButton
		Else
			GuiControl,Disable, VagexAutoClickWatchButton
	}
	Else {
		GuiControl,, VagexKeepRunning,0
		GuiControl,, VagexAutoClickWatchButton,0
		GuiControl,Disable, VagexKeepRunning
		GuiControl,Disable, VagexAutoClickWatchButton
	}
	If Check_Program_Installed("Mozilla Firefox")
	{
		GuiControl,, TxtFirefoxInstalled , Yes
		GuiControl,, FirefoxAddon, &Addon
		GuiControl,Enable, FirefoxKeepRunning
		If FirefoxKeepRunning
		{
			GuiControl,Enable, FirefoxRestart
			If FirefoxRestart
				GuiControl,Enable, FirefoxRestartPeriod
			Else
				GuiControl,Disable, FirefoxRestartPeriod
		} Else {
			GuiControl,Disable, FirefoxRestart
			GuiControl,Disable, FirefoxRestartPeriod
		}
	}
	Else {
		GuiControl,, FirefoxKeepRunning,0
		GuiControl,, FirefoxRestart,0
		GuiControl,, FirefoxAddon, &Install
		GuiControl,Disable, FirefoxKeepRunning
		GuiControl,Disable, FirefoxRestart
		GuiControl,Disable, FirefoxRestartPeriod
	}
	If Check_Program_Installed("Hitleap Viewer")
	{
		GuiControl,, TxtHitleapInstalled , Yes
		GuiControl,Disable, HitleapInstall
		GuiControl,Enable, HitleapKeepRunning
	}
	Else {
		GuiControl,, HitleapHided,0
		GuiControl,, HitleapKeepRunning,0
		GuiControl,, HitleapMinimized,0
		GuiControl,Disable, HitleapHided
		GuiControl,Disable, HitleapKeepRunning
		GuiControl,Disable, HitleapMinimized
	}
	If Check_Program_Installed("Honeygain")
	{
		GuiControl,, TxtHoneygainInstalled , Yes
		GuiControl,Disable, HoneygainInstall
		GuiControl,Enable, HoneygainKeepRunning
	}
	Else {
		GuiControl,, HoneygainKeepRunning,0
		GuiControl,Disable, HoneygainKeepRunning
	}
	If Check_Program_Installed("FluidStack Node")
	{
		GuiControl,, TxtFluidstackInstalled , Yes
		GuiControl,Disable, FluidstackInstall
		GuiControl,Enable, FluidstackKeepRunning
	}
	Else {
		GuiControl,, FluidstackKeepRunning,0
		GuiControl,Disable, FluidstackKeepRunning
	}
	Gui_Submit()
	Return
}