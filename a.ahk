#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance Force
DetectHiddenWindows, On
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%	 ; Ensures a consistent starting directory.
;======================================================================
WatchButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad15
WatchButtonx = WindowsForms10.BUTTON.app.0.34f5582_r9_ad12
PauseButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad14
AccButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad16

ControlGet, OutputVar, Visible,, %WatchButtonx% , Vagex Viewer
If (OutputVar)
{
	WinClose, Vagex Viewer
	FileAppend, %A_Now%: Close Vagex.`n, %A_MM%%A_YYYY%.log
}
ControlGet, OutputVar, Visible,, %WatchButton% , Vagex Viewer
If (OutputVar)
{
	ControlClick, %WatchButton% , Vagex Viewer
	FileAppend, %A_Now%: Pressed Watch Button.`n, %A_MM%%A_YYYY%.log
}