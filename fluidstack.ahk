FluidstackKeepRunning:
	GuiControlGet, OutVal ,, %A_GuiControl%
	IniWrite, %OutVal%, %IniFile%, %IniSection%, %A_GuiControl%
	MainFluidstack()
Return
MainFluidstack() {
	Global IniFile, IniSection
	IniRead, FluidstackKeepRunning, %IniFile%, %IniSection%, FluidstackKeepRunning, 1
	If FluidstackKeepRunning
	{
		FluidstackSvcStatus :=CheckServiceRunning("FluidStackNode")
		IfInString, FluidstackSvcStatus, Stop
			FluidstackStartStop()
	}
	Return
}
FluidstackReg() {
	FluidstackRegUrl :="https://provider.fluidstack.io/`#ref=5JDIOSDCc1"
	Run %FluidstackRegUrl%
	Return
}
FluidstackInstall() {
	MsgBox , , Fluidstack Notes, Copy your token before running Fluidstack Setup, 10
	FluidstackDownloadURl :="https://provider.api.fluidstack.io/download"
	FluidstackMsg :="Copy your token from: https://provider.fluidstack.io/dashboard/download/get-started to use in Setup"
	save = FluidstackSetup.exe
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(FluidstackDownloadUrl, save, message, 50)
	Progress, Off
	IfExist %save%
		RunWait, %save%
	Else {
		Clipboard:=FluidstackDownloadUrl
		MsgBox Link copied, paste (Ctrl+V) into your browser to download Fluidstack setup file.
	}
	GuiUpdate()
	Return
}
FluidstackStartStop() {
	RunWait,sc start "FluidStackNode",,hide
	Sleep, 15123
	GuiUpdate()
	Return
}