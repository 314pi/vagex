Main_Honeygain() {
	Global Cfg_File
	Loop, Read, %Cfg_File%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
		}
	}
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
			Sleep, %HoneygainSleepAfterRun%
		}
	}
	Return
}
HoneygainReg() {
	HoneygainRegUrl :="https://dashboard.honeygain.com/ref/TUONGE2B"
	Run %HoneygainRegUrl%
	Return
}
HoneygainInstall() {
	HoneygainDownloadUrl :="https://download.honeygain.com/windows-app/Honeygain_install.exe"
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