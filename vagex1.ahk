#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;=====================================
#SingleInstance Force
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetTitleMatchMode, slow
;=====================================

#Persistent
SetTimer, RunVagex, 123580
Return

RunVagex:
IfWinExist, Vagex.exe - EXCEPTION
{
    WinClose
}

IfWinExist,Script Error
{
    ControlSend, ,{Enter},Script Error
}

IfWinExist,Update Available
{
    ControlSend, ,{Enter},Update Available
	Sleep, 120000
}

IfWinExist, Alert
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
	RunWait, "%A_Programs%\Vagex\Vagex Viewer.appref-ms"
	Sleep, 60000
	WinMinimize,Vagex Viewer
	;WinHide,Vagex Viewer
}

Process, Exist , firefox.exe
if !ErrorLevel
{
	RunWait, "firefox.exe"
	Sleep, 30000
	;WinMinimize,Mozilla Firefox
	;WinHide,Mozilla Firefox
	;WinMinimizeAll
}
Return

^1:: WinHide,Vagex Viewer
^2:: WinShow,Vagex Viewer
^3:: WinHide,Mozilla Firefox
^4:: WinShow,Mozilla Firefox
Return