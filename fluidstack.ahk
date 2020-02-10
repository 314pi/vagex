Main_Fluidstack() {
	Global Cfg_File
	IniRead, FluidstackKeepRunning, %Cfg_File%, PiTools, FluidstackKeepRunning, 1
	If FluidstackKeepRunning
	{
		FluidstackSvcStatus :=Check_Service_Running("FluidStackNode")
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
	MsgBox , % 4096+64 , Fluidstack Notes, Copy your token before running Fluidstack Setup, 10
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
	Gui_Update()
	Return
}
FluidstackStartStop() {
	Run startfs.exe
	Sleep, 15123
	Gui_Update()
	Return
}