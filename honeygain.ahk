Main_Honeygain() {
	IniRead, HoneygainKeepRunning, pi.ini, PiTools, HoneygainKeepRunning
	If HoneygainKeepRunning
	{
		Process, Exist , Honeygain.exe
		If !ErrorLevel
		{
			IfNotExist Honeygain.lnk
			{
				FileCreateShortcut, %A_AppData%\Honeygain\Honeygain.exe, Honeygain.lnk, %A_AppData%\Honeygain\
			}
			Run, HoneyGain.lnk
			Sleep, 15123
		}
	}
	Return
}
HoneygainReg() {
	Global HoneygainRegUrl
	Run %HoneygainRegUrl%
	Return
}
HoneygainInstall() {
	Global HoneygainDownloadUrl
	save = HoneygainSetup.exe
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(HoneygainDownloadUrl, save, message, 50)
	Progress, Off
	IfExist %save%
		RunWait, %save%
	Else {
		Clipboard:=HoneygainDownloadUrl
		MsgBox Link copied, paste (Ctrl+V) into your browser to download HoneyGain setup file.
	}
	Gui_Update()
	Return
}