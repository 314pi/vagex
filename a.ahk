#Include tray.ahk
pi:=TrayIcon_GetInfo("NetTime.exe")
pi2 :=pi[1].IDcmd
TrayIcon_Hide(pi2, , False)
Return
