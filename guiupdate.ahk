Gui_Update() {
	Global Cfg_File
	Loop, Read, %Cfg_File%
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
	Else
	{
		GuiControl,, TxtVagexInstalled , No
		GuiControl,Disable, VagexAutoClickWatchButton
		GuiControl,Disable, VagexKeepRunning
		GuiControl,Enable, VagexInstall
	}
	If Check_Program_Installed("Mozilla Firefox")
	{
		GuiControl,, FirefoxAddon, &Addon
		GuiControl,, TxtFirefoxInstalled , Yes
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
	Else
	{
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
		GuiControl,Enabled, HitleapHided
	}
	Else
	{
		GuiControl,, TxtHitleapInstalled , No
		GuiControl,Disable, HitleapHided
		GuiControl,Disable, HitleapKeepRunning
		GuiControl,Enable, HitleapInstall
	}
	If Check_Program_Installed("Honeygain")
	{
		GuiControl,, TxtHoneygainInstalled , Yes
		GuiControl,Disable, HoneygainInstall
		GuiControl,Enable, HoneygainHideTray
		GuiControl,Enable, HoneygainKeepRunning
	}
	Else
	{
		GuiControl,, TxtHoneygainInstalled , No
		GuiControl,Disable, HoneygainHideTray
		GuiControl,Disable, HoneygainKeepRunning
		GuiControl,Enable, HoneygainInstall
	}
	FluidstackSvcStatus :=Check_Service_Running("FluidStackNode")
	GuiControl,, FluidstackSvcStatus, %FluidstackSvcStatus%
	If Check_Program_Installed("FluidStack Node")
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