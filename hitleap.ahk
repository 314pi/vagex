HitleapInstall() {
	HitleapDownloadUrl :="https://hitleap.com/viewer/download`?platform=Windows"
	save = HitleapViewer.exe
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(HitleapDownloadUrl, save, message, 50)
	Progress, Off
	RunWait, %save%
	Gui_Update()
	Return
}
Main_Hitleap() {
	IniRead, HitleapHided, pi.ini, PiTools, HitleapHided
	IniRead, HitleapKeepRunning, pi.ini, PiTools, HitleapKeepRunning
	IniRead, HitleapMinimized, pi.ini, PiTools, HitleapMinimized
	If HitleapKeepRunning
	{
		Process, Exist , simplewrapper.exe
		If !ErrorLevel
		{
			IfNotExist Hitleap.lnk
			{
				SplitPath, A_AppData, , Hitleappath
				Hitleappath := Hitleappath . "\Local\HitLeap Viewer\app\lua.exe"
				SplitPath, Hitleappath, , Hitleapdir
				FileCreateShortcut, %Hitleappath%, Hitleap.lnk, %Hitleapdir%, HitLeap-Viewer.lua Windows
			}
			Run, Hitleap.lnk
			Sleep, 15123
		}
	}
	If HitleapMinimized
		WinMinimize, HitLeap Viewer
	If HitleapHided
		WinHide, HitLeap Viewer
	Return
}
HitleapReg() {
	HitleapRegUrl :="https://hitleap.com/by/kmc44210"
	Run %HitleapRegUrl%
	Return
}