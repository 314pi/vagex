#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;=====================================
#SingleInstance Force
DetectHiddenWindows, On
;=====================================

#Persistent
SetTimer, RunVagex, 123580
Return

RunVagex:
IfWinExist, Vagex.exe - EXCEPTION
{
    WinClose
}

Process, Exist , WerFault.exe
if ErrorLevel
{
	Process, Close, %ErrorLevel%
}

Process, Exist , vagex.exe
if !ErrorLevel
{
	RunWait, "C:\Users\kmc\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Vagex\Vagex Viewer.appref-ms"
	Sleep, 60000
	WinMinimizeAll
}

Process, Exist , firefox.exe
if !ErrorLevel
{
	RunWait, "firefox.exe"
	Sleep, 30000
	WinMinimizeAll
}
Return
