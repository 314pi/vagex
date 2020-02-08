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
	If TrayShowHide
	{
		Menu, Tray, Icon
		GuiControl,, TrayShowHide, 1
	}
	Else {
		Menu, Tray, NoIcon
		GuiControl,, TrayShowHide, 0
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
			GuiControl,, FirefoxRestart,0
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
		Process, Exist , simplewrapper.exe
		If ErrorLevel
			GuiControl,Enabled, HitleapHided
		Else {
			GuiControl,Disable, HitleapHided
		}
	}
	Else {
		GuiControl,, HitleapKeepRunning,0
		GuiControl,Disable, HitleapHided
		GuiControl,Disable, HitleapKeepRunning
	}
	If Check_Program_Installed("Honeygain")
	{
		GuiControl,, TxtHoneygainInstalled , Yes
		GuiControl,Disable, HoneygainInstall
		GuiControl,Enable, HoneygainKeepRunning
		Process, Exist , Honeygain.exe
		If !ErrorLevel
		{
			GuiControl,Disable, HoneygainHideTray
		}
		Else {
			GuiControl,Enable, HoneygainHideTray
			HoneygainTray := TrayIcon_GetInfo("Honeygain.exe")
			HoneygainTrayID  := HoneygainTray[1].IDcmd
			TrayIcon_Hide(HoneygainTrayID, , HoneygainHideTray)
			Tray_Refresh()
		}
	}
	Else {
		GuiControl,, HoneygainKeepRunning, 0
		GuiControl,Disable, HoneygainHideTray
		GuiControl,Disable, HoneygainKeepRunning
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
	Else {
		GuiControl,, FluidstackKeepRunning,0
		GuiControl,Disable, FluidstackKeepRunning
		GuiControl,Disable, FluidstackStartStop
	}
	Gui_Submit()
	Return
}