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
	IniRead, HitleapHided, pi.ini, PiTools, HitleapHided, 1
	IniRead, HitleapKeepRunning, pi.ini, PiTools, HitleapKeepRunning, 1
	IniRead, HitleapSleepAfterRun, pi.ini, PiTools, HitleapSleepAfterRun, 120123
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
			Sleep, %HitleapSleepAfterRun%
		}
	}
	If HitleapHided
	{
		WinMinimize, HitLeap Viewer
		WinHide, HitLeap Viewer
	}
	Else {
		WinShow, HitLeap Viewer
		WinRestore, HitLeap Viewer
	}
	Return
}
HitleapReg() {
	HitleapRegUrl :="https://hitleap.com/by/kmc44210"
	Run %HitleapRegUrl%
	Return
}