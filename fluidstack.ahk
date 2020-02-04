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
	Gui_Update()
	Return
}
FluidstackReg() {
	FluidstackRegUrl :="https://provider.fluidstack.io/`#ref=5JDIOSDCc1"
	Run %FluidstackRegUrl%
	Return
}
Main_Fluidstack() {
	Return
}