#NoEnv	; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance Force
DetectHiddenWindows, On
SendMode Input	; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%	 ; Ensures a consistent starting directory.
;======================================================================
TrayShow=1
IniRead, VagexShow, pi.ini, PiTools, VagexShow,0
IniRead, FirefoxShow, pi.ini, PiTools, FirefoxShow,1
IniRead, HitleapShow, pi.ini, PiTools, HitleapShow,0
Check_Ini()
SetTimer, Main_Timmer, 312345
SetTimer, Firefox_Restart_Timmer, 3600000
Gui Add, Button, hWndhBtnHide vBtnHide gBtnHide x65 y265 w80 h20, &Hide
Gui Add, Tab3, x5 y5 w200 h260, General|Vagex|Hitleap|About
Gui Tab, General
Gui Add, Text, x15 y50 w180 h20 +0x200, Press Ctrl+0 to Hide/Unhide tray icon
Gui Add, Text, x15 y70 w180 h20 +0x200, Press Ctrl+1 Show Main Windows
Gui Add, CheckBox, hWndhStartWithWindows vStartWithWindows gStartWithWindows x15 y90 w120 h20, Start with Windows
Gui Add, CheckBox, hStartMinimized vStartMinimized gStartMinimized x15 y110 w120 h20, Start Minimized
Gui Tab, Vagex
Gui Add, Button, hWndhFirefoxAddon vFirefoxAddon gFirefoxAddon x135 y170 w60 h20, &Addon
Gui Add, Button, hWndhVagexInstall vVagexInstall gVagexInstall x135 y70 w60 h20, &Install
Gui Add, CheckBox, hWndhVagexAutoClickWatchButton vVagexAutoClickWatchButton gVagexAutoClickWatchButton x15 y110 w160 h20, Auto click Watch button
Gui Add, CheckBox, hWndhFirefoxKeepRunning vFirefoxKeepRunning gFirefoxKeepRunning x15 y190 w160 h20, Keep Firefox running
Gui Add, CheckBox, hWndhVagexKeepRunning vVagexKeepRunning gVagexKeepRunning x15 y90 w160 h20, Keep Vagex running
Gui Add, CheckBox, hWndhFirefoxRestart vFirefoxRestart gFirefoxRestart x40 y210 w140 h20, Restart affter every
Gui Add, Edit, hWndhFirefoxRestartPeriod vFirefoxRestartPeriod gFirefoxRestartPeriod x60 y230 w50 h20 +Right, 3600
Gui Add, GroupBox, x10 y150 w190 h110, Firefox Addons Viewer
Gui Add, GroupBox, x10 y50 w190 h90, Vagex Viewer
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtFirefoxInstalled vTxtFirefoxInstalled  x100 y170 w30 h20 +0x200, NO
Gui Add, Text, hWndhTxtVagexInstalled vTxtVagexInstalled x100 y70 w30 h20 +0x200, NO
Gui Font
Gui Add, Text, x115 y230 w50 h20 +0x200, second(s)
Gui Add, Text, x15 y170 w85 h20 +0x200, Firefox Installed:
Gui Add, Text, x15 y70 w85 h20 +0x200, Vagex Installed:
Gui Tab, Hitleap
Gui Add, Button, hWndhHitleapInstall vHitleapInstall gHitleapInstall x135 y50 w60 h20, &Install
Gui Add, CheckBox, hWndhHitleapHided vHitleapHided gHitleapHided x15 y110 w160 h20, Hided
Gui Add, CheckBox, hWndhHitleapKeepRunning vHitleapKeepRunning gHitleapKeepRunning x15 y70 w160 h20, Keep Hitleap running
Gui Add, CheckBox, hWndhHitleapMinimized vHitleapMinimized gHitleapMinimized x15 y90 w160 h20, Minimized
Gui Add, Text, x15 y50 w85 h20 +0x200, Hitleap Installed:
Gui Font, Bold cRed
Gui Add, Text, hWndhTxtHitleapInstalled vTxtHitleapInstalled x100 y50 w30 h20 +0x200, NO
Gui Font
IniRead, StartMinimized, pi.ini, PiTools, StartMinimized
If !StartMinimized
{
	Gui_Update()
	Gui Show, w210 h290, Pi Tools
}
GoSub, Main_Timmer
Return
Main_Timmer:
	General_Task()
	Main_Hitleap()
	Main_Vagex()
	Main_Firefox()
	General_Task()
Return
GuiClose:
	Gui, Submit
	Gui_Submit()
	General_Task()
	ExitApp
Return
BtnHide:
GuiEscape:
	Gui, Submit
	Gui_Submit()
	General_Task()
	TrayShow=1
	Menu, Tray, Icon
Return
FirefoxKeepRunning:
FirefoxRestart:
FirefoxRestartPeriod:
HitleapHided:
HitleapKeepRunning:
HitleapMinimized:
StartMinimized:
StartWithWindows:
VagexAutoClickWatchButton:
VagexKeepRunning:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, pi.ini, PiTools, %GuiName%
	Gui_Submit()
	Gui_Update()
Return
Gui_Update() {
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControl,, %magic1% , %magic2%
		}
	}
	If FirefoxKeepRunning
	{
		GuiControl,Enable, FirefoxRestart
		GuiControl,Enable, FirefoxRestartPeriod
	} Else {
		GuiControl,Disable, FirefoxRestart
		GuiControl,Disable, FirefoxRestartPeriod
	}
	If Check_Program_Installed("Vagex Viewer")
	{
		GuiControl,, TxtVagexInstalled , YES
		GuiControl,Disable, VagexInstall
		GuiControl,Enable, VagexKeepRunning
		GuiControl,Enable, VagexAutoClickWatchButton
	}
	Else {
		GuiControl,, VagexKeepRunning,0
		GuiControl,, VagexAutoClickWatchButton,0
		GuiControl,Disable, VagexKeepRunning
		GuiControl,Disable, VagexAutoClickWatchButton
	}
	If Check_Program_Installed("Mozilla Firefox")
	{
		GuiControl,, TxtFirefoxInstalled , YES
		GuiControl,Enable, FirefoxKeepRunning
		GuiControl,Enable, FirefoxRestart
	}
	Else {
		GuiControl,, FirefoxKeepRunning,0
		GuiControl,, FirefoxRestart,0
		GuiControl,Disable, FirefoxKeepRunning
		GuiControl,Disable, FirefoxRestart
		GuiControl,, FirefoxAddon, Install
	}
	If Check_Program_Installed("Hitleap Viewer")
	{
		GuiControl,, TxtHitleapInstalled , YES
		GuiControl,Disable, HitleapInstall
		GuiControl,Enable, HitleapHided
		GuiControl,Enable, HitleapKeepRunning
		GuiControl,Enable, HitleapMinimized
	}
	Else {
		GuiControl,, HitleapHided,0
		GuiControl,, HitleapKeepRunning,0
		GuiControl,, HitleapMinimized,0
		GuiControl,Disable, HitleapHided
		GuiControl,Disable, HitleapKeepRunning
		GuiControl,Disable, HitleapMinimized
	}
	Gui_Submit()
	Return
}
Gui_Submit() {
	Loop, Read, pi.ini
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControlGet, %magic1% ,, %magic1%
			IniWrite, % %magic1%, pi.ini, PiTools, %magic1%
		}
	}
	If StartWithWindows
	{
		SplitPath, A_Scriptname, , , , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		IfNotExist, %LinkFile%
			FileCreateShortcut, %A_ScriptFullPath%, %LinkFile% ; Admin right ?
	}
	Else {
		SplitPath, A_Scriptname, , , , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		FileDelete, %LinkFile%
	}
	If FirefoxRestart
		SetTimer, Firefox_Restart_Timmer, % FirefoxRestartPeriod*1000
	Else
		SetTimer, Firefox_Restart_Timmer, Off
	SetTimer, Main_Timmer, 312345
	Return
}
Check_Ini() {
vDefault_ini=
(
;pi tools
[PiTools]
FirefoxKeepRunning=1
FirefoxRestart=1
FirefoxRestartPeriod=3600
HitleapHided=1
HitleapKeepRunning=1
HitleapMinimized=1
StartMinimized=0
StartWithWindows=0
VagexAutoClickWatchButton=1
VagexKeepRunning=1
)
IfNotExist, pi.ini
	FileAppend ,% vDefault_ini, pi.ini, UTF-8
}
General_Task() {
/*	Close some error, alert, update nortify, ...
 *
 */
	IfWinExist, Vagex.exe - EXCEPTION
	{
		WinActivate, Vagex.exe - EXCEPTION
		WinClose
	}
	IfWinExist, Script Error
	{
		WinActivate, Script Error
		ControlSend, ,{Enter}, Script Error
	}
	IfWinExist, Update Available
	{
		WinActivate, Update Available
		ControlSend, ,{Enter}, Update Available
		Sleep, 121234
	}
	IfWinExist, Alert
	{
		WinActivate, Alert
		WinClose
	}
	Process, Exist , WerFault.exe
	if ErrorLevel
		Process, Close, %ErrorLevel%
	Tray_Refresh()
	Return
}
Tray_Refresh() {
/*	Remove any dead icon from the tray menu
 *	Should work both for W7 & W10
 */
	WM_MOUSEMOVE := 0x200
	detectHiddenWin := A_DetectHiddenWindows
	DetectHiddenWindows, On
	allTitles := ["ahk_class Shell_TrayWnd"
			, "ahk_class NotifyIconOverflowWindow"]
	allControls := ["ToolbarWindow321"
				,"ToolbarWindow322"
				,"ToolbarWindow323"
				,"ToolbarWindow324"]
	allIconSizes := [24,32]
	for id, title in allTitles {
		for id, controlName in allControls
		{
			for id, iconSize in allIconSizes
			{
				ControlGetPos, xTray,yTray,wdTray,htTray,% controlName,% title
				y := htTray - 10
				While (y > 0)
				{
					x := wdTray - iconSize/2
					While (x > 0)
					{
						point := (y << 16) + x
						PostMessage,% WM_MOUSEMOVE, 0,% point,% controlName,% title
						x -= iconSize/2
					}
					y -= iconSize/2
				}
			}
		}
	}
	DetectHiddenWindows, %detectHiddenWin%
}
; ----------------------------------------------------------------------------------------------------------------------
; Name ..........: TrayIcon library
; Description ...: Provide some useful functions to deal with Tray icons.
; AHK Version ...: AHK_L 1.1.22.02 x32/64 Unicode
; Original Author: Sean (http://goo.gl/dh0xIX) (http://www.autohotkey.com/forum/viewtopic.php?t=17314)
; Update Author .: Cyruz (http://ciroprincipe.info) (http://ahkscript.org/boards/viewtopic.php?f=6&t=1229)
; Mod Author ....: Fanatic Guru
; License .......: WTFPL - http://www.wtfpl.net/txt/copying/
; Version Date...: 2019 04 04
; Note ..........: Many people have updated Sean's original work including me but Cyruz's version seemed the most straight
; ...............: forward update for 64 bit so I adapted it with some of the features from my Fanatic Guru version.
; Update 20160120: Went through all the data types in the DLL and NumGet and matched them up to MSDN which fixed IDcmd.
; Update 20160308: Fix for Windows 10 NotifyIconOverflowWindow
; Update 20180313: Fix problem with "VirtualFreeEx" pointed out by nnnik
; Update 20180313: Additional fix for previous Windows 10 NotifyIconOverflowWindow fix breaking non-hidden icons
; Update 20190404: Added TrayIcon_Set by Cyruz
; ----------------------------------------------------------------------------------------------------------------------
; ----------------------------------------------------------------------------------------------------------------------
; Function ......: TrayIcon_GetInfo
; Description ...: Get a series of useful information about tray icons.
; Parameters ....: sExeName	 - The exe for which we are searching the tray icon data. Leave it empty to receive data for
; ...............:			   all tray icons.
; Return ........: oTrayIcon_GetInfo - An array of objects containing tray icons data. Any entry is structured like this:
; ...............:			   oTrayIcon_GetInfo[A_Index].idx	  - 0 based tray icon index.
; ...............:			   oTrayIcon_GetInfo[A_Index].IDcmd	  - Command identifier associated with the button.
; ...............:			   oTrayIcon_GetInfo[A_Index].pID	  - Process ID.
; ...............:			   oTrayIcon_GetInfo[A_Index].uID	  - Application defined identifier for the icon.
; ...............:			   oTrayIcon_GetInfo[A_Index].msgID	  - Application defined callback message.
; ...............:			   oTrayIcon_GetInfo[A_Index].hIcon	  - Handle to the tray icon.
; ...............:			   oTrayIcon_GetInfo[A_Index].hWnd	  - Window handle.
; ...............:			   oTrayIcon_GetInfo[A_Index].Class	  - Window class.
; ...............:			   oTrayIcon_GetInfo[A_Index].Process - Process executable.
; ...............:			   oTrayIcon_GetInfo[A_Index].Tray	  - Tray Type (Shell_TrayWnd or NotifyIconOverflowWindow).
; ...............:			   oTrayIcon_GetInfo[A_Index].tooltip - Tray icon tooltip.
; Info ..........: TB_BUTTONCOUNT message - http://goo.gl/DVxpsg
; ...............: TB_GETBUTTON message	  - http://goo.gl/2oiOsl
; ...............: TBBUTTON structure	  - http://goo.gl/EIE21Z
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_GetInfo(sExeName := "")
{
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	oTrayIcon_GetInfo := {}
	For key, sTray in ["Shell_TrayWnd", "NotifyIconOverflowWindow"]
	{
		idxTB := TrayIcon_GetTrayBar(sTray)
		WinGet, pidTaskbar, PID, ahk_class %sTray%
		hProc := DllCall("OpenProcess", UInt, 0x38, Int, 0, UInt, pidTaskbar)
		pRB	  := DllCall("VirtualAllocEx", Ptr, hProc, Ptr, 0, UPtr, 20, UInt, 0x1000, UInt, 0x4)
		SendMessage, 0x418, 0, 0, ToolbarWindow32%idxTB%, ahk_class %sTray%	  ; TB_BUTTONCOUNT
		szBtn := VarSetCapacity(btn, (A_Is64bitOS ? 32 : 20), 0)
		szNfo := VarSetCapacity(nfo, (A_Is64bitOS ? 32 : 24), 0)
		szTip := VarSetCapacity(tip, 128 * 2, 0)
		Loop, %ErrorLevel%
		{
			SendMessage, 0x417, A_Index - 1, pRB, ToolbarWindow32%idxTB%, ahk_class %sTray%	  ; TB_GETBUTTON
			DllCall("ReadProcessMemory", Ptr, hProc, Ptr, pRB, Ptr, &btn, UPtr, szBtn, UPtr, 0)
			iBitmap := NumGet(btn, 0, "Int")
			IDcmd	:= NumGet(btn, 4, "Int")
			statyle := NumGet(btn, 8)
			dwData	:= NumGet(btn, (A_Is64bitOS ? 16 : 12))
			iString := NumGet(btn, (A_Is64bitOS ? 24 : 16), "Ptr")
			DllCall("ReadProcessMemory", Ptr, hProc, Ptr, dwData, Ptr, &nfo, UPtr, szNfo, UPtr, 0)
			hWnd  := NumGet(nfo, 0, "Ptr")
			uID	  := NumGet(nfo, (A_Is64bitOS ? 8 : 4), "UInt")
			msgID := NumGet(nfo, (A_Is64bitOS ? 12 : 8))
			hIcon := NumGet(nfo, (A_Is64bitOS ? 24 : 20), "Ptr")
			WinGet, pID, PID, ahk_id %hWnd%
			WinGet, sProcess, ProcessName, ahk_id %hWnd%
			WinGetClass, sClass, ahk_id %hWnd%
			If !sExeName || (sExeName = sProcess) || (sExeName = pID)
			{
				DllCall("ReadProcessMemory", Ptr, hProc, Ptr, iString, Ptr, &tip, UPtr, szTip, UPtr, 0)
				Index := (oTrayIcon_GetInfo.MaxIndex()>0 ? oTrayIcon_GetInfo.MaxIndex()+1 : 1)
				oTrayIcon_GetInfo[Index,"idx"]	   := A_Index - 1
				oTrayIcon_GetInfo[Index,"IDcmd"]   := IDcmd
				oTrayIcon_GetInfo[Index,"pID"]	   := pID
				oTrayIcon_GetInfo[Index,"uID"]	   := uID
				oTrayIcon_GetInfo[Index,"msgID"]   := msgID
				oTrayIcon_GetInfo[Index,"hIcon"]   := hIcon
				oTrayIcon_GetInfo[Index,"hWnd"]	   := hWnd
				oTrayIcon_GetInfo[Index,"Class"]   := sClass
				oTrayIcon_GetInfo[Index,"Process"] := sProcess
				oTrayIcon_GetInfo[Index,"Tooltip"] := StrGet(&tip, "UTF-16")
				oTrayIcon_GetInfo[Index,"Tray"]	   := sTray
			}
		}
		DllCall("VirtualFreeEx", Ptr, hProc, Ptr, pRB, UPtr, 0, Uint, 0x8000)
		DllCall("CloseHandle", Ptr, hProc)
	}
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	Return oTrayIcon_GetInfo
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_Hide
; Description ..: Hide or unhide a tray icon.
; Parameters ...: IDcmd - Command identifier associated with the button.
; ..............: bHide - True for hide, False for unhide.
; ..............: sTray - 1 or Shell_TrayWnd || 0 or NotifyIconOverflowWindow.
; Info .........: TB_HIDEBUTTON message - http://goo.gl/oelsAa
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_Hide(IDcmd, sTray := "Shell_TrayWnd", bHide:=True)
{
	(sTray == 0 ? sTray := "NotifyIconOverflowWindow" : sTray == 1 ? sTray := "Shell_TrayWnd" : )
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	idxTB := TrayIcon_GetTrayBar()
	SendMessage, 0x404, IDcmd, bHide, ToolbarWindow32%idxTB%, ahk_class %sTray% ; TB_HIDEBUTTON
	SendMessage, 0x1A, 0, 0, , ahk_class %sTray%
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_Delete
; Description ..: Delete a tray icon.
; Parameters ...: idx - 0 based tray icon index.
; ..............: sTray - 1 or Shell_TrayWnd || 0 or NotifyIconOverflowWindow.
; Info .........: TB_DELETEBUTTON message - http://goo.gl/L0pY4R
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_Delete(idx, sTray := "Shell_TrayWnd")
{
	(sTray == 0 ? sTray := "NotifyIconOverflowWindow" : sTray == 1 ? sTray := "Shell_TrayWnd" : )
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	idxTB := TrayIcon_GetTrayBar()
	SendMessage, 0x416, idx, 0, ToolbarWindow32%idxTB%, ahk_class %sTray% ; TB_DELETEBUTTON
	SendMessage, 0x1A, 0, 0, , ahk_class %sTray%
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_Remove
; Description ..: Remove a tray icon.
; Parameters ...: hWnd, uID.
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_Remove(hWnd, uID)
{
		NumPut(VarSetCapacity(NID,(A_IsUnicode ? 2 : 1) * 384 + A_PtrSize * 5 + 40,0), NID)
		NumPut(hWnd , NID, (A_PtrSize == 4 ? 4 : 8 ))
		NumPut(uID	, NID, (A_PtrSize == 4 ? 8	: 16 ))
		Return DllCall("shell32\Shell_NotifyIcon", "Uint", 0x2, "Uint", &NID)
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_Move
; Description ..: Move a tray icon.
; Parameters ...: idxOld - 0 based index of the tray icon to move.
; ..............: idxNew - 0 based index where to move the tray icon.
; ..............: sTray - 1 or Shell_TrayWnd || 0 or NotifyIconOverflowWindow.
; Info .........: TB_MOVEBUTTON message - http://goo.gl/1F6wPw
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_Move(idxOld, idxNew, sTray := "Shell_TrayWnd")
{
	(sTray == 0 ? sTray := "NotifyIconOverflowWindow" : sTray == 1 ? sTray := "Shell_TrayWnd" : )
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	idxTB := TrayIcon_GetTrayBar()
	SendMessage, 0x452, idxOld, idxNew, ToolbarWindow32%idxTB%, ahk_class %sTray% ; TB_MOVEBUTTON
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_Set
; Description ..: Modify icon with the given index for the given window.
; Parameters ...: hWnd		 - Window handle.
; ..............: uId		 - Application defined identifier for the icon.
; ..............: hIcon		 - Handle to the tray icon.
; ..............: hIconSmall - Handle to the small icon, for window menubar. Optional.
; ..............: hIconBig	 - Handle to the big icon, for taskbar. Optional.
; Return .......: True on success, false on failure.
; Info .........: NOTIFYICONDATA structure	- https://goo.gl/1Xuw5r
; ..............: Shell_NotifyIcon function - https://goo.gl/tTSSBM
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_Set(hWnd, uId, hIcon, hIconSmall:=0, hIconBig:=0)
{
	d := A_DetectHiddenWindows
	DetectHiddenWindows, On
	; WM_SETICON = 0x0080
	If ( hIconSmall )
		SendMessage, 0x0080, 0, hIconSmall,, ahk_id %hWnd%
	If ( hIconBig )
		SendMessage, 0x0080, 1, hIconBig,, ahk_id %hWnd%
	DetectHiddenWindows, %d%
	VarSetCapacity(NID, szNID := ((A_IsUnicode ? 2 : 1) * 384 + A_PtrSize*5 + 40),0)
	NumPut( szNID, NID, 0							)
	NumPut( hWnd,  NID, (A_PtrSize == 4) ? 4   : 8	)
	NumPut( uId,   NID, (A_PtrSize == 4) ? 8   : 16 )
	NumPut( 2,	   NID, (A_PtrSize == 4) ? 12  : 20 )
	NumPut( hIcon, NID, (A_PtrSize == 4) ? 20  : 32 )
	; NIM_MODIFY := 0x1
	Return DllCall("Shell32.dll\Shell_NotifyIcon", UInt,0x1, Ptr,&NID)
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_GetTrayBar
; Description ..: Get the tray icon handle.
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_GetTrayBar(Tray:="Shell_TrayWnd")
{
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	WinGet, ControlList, ControlList, ahk_class %Tray%
	RegExMatch(ControlList, "(?<=ToolbarWindow32)\d+(?!.*ToolbarWindow32)", nTB)
	Loop, %nTB%
	{
		ControlGet, hWnd, hWnd,, ToolbarWindow32%A_Index%, ahk_class %Tray%
		hParent := DllCall( "GetParent", Ptr, hWnd )
		WinGetClass, sClass, ahk_id %hParent%
		If !(sClass = "SysPager" or sClass = "NotifyIconOverflowWindow" )
			Continue
		idxTB := A_Index
		Break
	}
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	Return	idxTB
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_GetHotItem
; Description ..: Get the index of tray's hot item.
; Info .........: TB_GETHOTITEM message - http://goo.gl/g70qO2
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_GetHotItem()
{
	idxTB := TrayIcon_GetTrayBar()
	SendMessage, 0x447, 0, 0, ToolbarWindow32%idxTB%, ahk_class Shell_TrayWnd ; TB_GETHOTITEM
	Return ErrorLevel << 32 >> 32
}
; ----------------------------------------------------------------------------------------------------------------------
; Function .....: TrayIcon_Button
; Description ..: Simulate mouse button click on a tray icon.
; Parameters ...: sExeName - Executable Process Name of tray icon.
; ..............: sButton  - Mouse button to simulate (L, M, R).
; ..............: bDouble  - True to double click, false to single click.
; ..............: index	   - Index of tray icon to click if more than one match.
; ----------------------------------------------------------------------------------------------------------------------
TrayIcon_Button(sExeName, sButton := "L", bDouble := false, index := 1)
{
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	WM_MOUSEMOVE	  = 0x0200
	WM_LBUTTONDOWN	  = 0x0201
	WM_LBUTTONUP	  = 0x0202
	WM_LBUTTONDBLCLK = 0x0203
	WM_RBUTTONDOWN	  = 0x0204
	WM_RBUTTONUP	  = 0x0205
	WM_RBUTTONDBLCLK = 0x0206
	WM_MBUTTONDOWN	  = 0x0207
	WM_MBUTTONUP	  = 0x0208
	WM_MBUTTONDBLCLK = 0x0209
	sButton := "WM_" sButton "BUTTON"
	oIcons := {}
	oIcons := TrayIcon_GetInfo(sExeName)
	msgID  := oIcons[index].msgID
	uID	   := oIcons[index].uID
	hWnd   := oIcons[index].hWnd
	if bDouble
		PostMessage, msgID, uID, %sButton%DBLCLK, , ahk_id %hWnd%
	else
	{
		PostMessage, msgID, uID, %sButton%DOWN, , ahk_id %hWnd%
		PostMessage, msgID, uID, %sButton%UP, , ahk_id %hWnd%
	}
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	return
}
/* ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; HttpQueryInfo ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
QueryInfoFlag:
HTTP_QUERY_RAW_HEADERS = 21
Receives all the headers returned by the server.
Each header is terminated by "\0". An additional "\0" terminates the list of headers.
HTTP_QUERY_CONTENT_LENGTH = 5
Retrieves the size of the resource, in bytes.
HTTP_QUERY_CONTENT_TYPE = 1
Receives the content type of the resource (such as text/html).
Find more at: http://msdn.microsoft.com/library/en-us/wininet/wininet/query_info_flags.asp
Proxy Settings:
INTERNET_OPEN_TYPE_PRECONFIG                    0   // use registry configuration
INTERNET_OPEN_TYPE_DIRECT                       1   // direct to net
INTERNET_OPEN_TYPE_PROXY                        3   // via named proxy
INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY  4   // prevent using java/script/INS
*/ ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HttpQueryInfo(URL, QueryInfoFlag=21, Proxy="", ProxyBypass="") {
hModule := DllCall("LoadLibrary", "str", "wininet.dll")
If (Proxy != "")
AccessType=3
Else
AccessType=1
io_hInternet := DllCall("wininet\InternetOpenA"
, "str", "" ;lpszAgent
, "uint", AccessType
, "str", Proxy
, "str", ProxyBypass
, "uint", 0) ;dwFlags
If (ErrorLevel != 0 or io_hInternet = 0) {
DllCall("FreeLibrary", "uint", hModule)
return, -1
}
iou_hInternet := DllCall("wininet\InternetOpenUrlA"
, "uint", io_hInternet
, "str", url
, "str", "" ;lpszHeaders
, "uint", 0 ;dwHeadersLength
, "uint", 0x80000000 ;dwFlags: INTERNET_FLAG_RELOAD = 0x80000000 // retrieve the original item
, "uint", 0) ;dwContext
If (ErrorLevel != 0 or iou_hInternet = 0) {
DllCall("FreeLibrary", "uint", hModule)
return, -1
}
VarSetCapacity(buffer, 1024, 0)
VarSetCapacity(buffer_len, 4, 0)
Loop, 5
{
  hqi := DllCall("wininet\HttpQueryInfoA"
  , "uint", iou_hInternet
  , "uint", QueryInfoFlag ;dwInfoLevel
  , "uint", &buffer
  , "uint", &buffer_len
  , "uint", 0) ;lpdwIndex
  If (hqi = 1) {
	hqi=success
	break
  }
}
IfNotEqual, hqi, success, SetEnv, res, timeout
If (hqi = "success") {
p := &buffer
Loop
{
  l := DllCall("lstrlen", "UInt", p)
  VarSetCapacity(tmp_var, l+1, 0)
  DllCall("lstrcpy", "Str", tmp_var, "UInt", p)
  p += l + 1
  res := res  . "`n" . tmp_var
  If (*p = 0)
  Break
}
StringTrimLeft, res, res, 1
}
DllCall("wininet\InternetCloseHandle",  "uint", iou_hInternet)
DllCall("wininet\InternetCloseHandle",  "uint", io_hInternet)
DllCall("FreeLibrary", "uint", hModule)
return, res
}
DownloadProgress(url, save, msg = 0x1100, sleep = 250) {
	total := HttpQueryInfo(url, 5)
	SetTimer, _dlprocess, %sleep%
	UrlDownloadToFile, %url%, %save%
	SetTimer, _dlprocess, Off
	Return, ErrorLevel
	_dlprocess:
	FileGetSize, current, %save%, K
	Process, Exist
	PostMessage, msg, current * 1024, total, , ahk_pid %ErrorLevel%
	Exit
}
SetCounter(wParam, lParam) {
	global url
	progress := Round(wParam / lParam * 100)
	wParam := wParam // 1024
	lParam := lParam // 1024
	Progress, %progress%, %url%, Downloading %wParam%kb of %lParam%kb..., %progress%`% - Downloading...
}
HitleapInstall() {
	Global url
	url = https://hitleap.com/viewer/download`?platform=Windows
	save = HitleapViewer.exe
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(url, save, message, 50)
	Progress, Off
	RunWait, %save%
	Gui_Update()
	Return
}
Firefox_Restart_Timmer:
	IniRead, FirefoxRestart, pi.ini, PiTools, FirefoxRestart,0
	If FirefoxRestart
	{
		Process, Exist , firefox.exe
		If ErrorLevel
		{
			WinClose, Mozilla Firefox
			Sleep, 15123
		}
		RunWait, "firefox.exe"
		Sleep, 15123
		If !FirefoxShow
			WinHide, Mozilla Firefox
	}
Return
VagexInstall() {
	Global url
	url = https://vagex.com/Vagex4/Vagex.application
	save = Vagex.application
	FileDelete, %save%
	message = 0x1100
	Progress, M H80, , .
	OnMessage(message, "SetCounter")
	DownloadProgress(url, save, message, 50)
	Progress, Off
	IfExist %save%
		RunWait, %save%
	Else {
		Clipboard:="https://vagex.com/Vagex4/Vagex.application"
		MsgBox Link copied, paste (Ctrl+V) into your browser to download Vagex setup file.
	}
	Gui_Update()
	Return
}
FirefoxAddon() {
	GuiControlGet, FirefoxAddon ,, FirefoxAddon
	IfInString, FirefoxAddon, Install
	{
		Global url
		os :=A_Is64bitOS ? 64 : 32
		url := "https://download.mozilla.org/`?product=firefox-latest`&os=win" . os . "`&lang=en-US"
		save = FirefoxSetup.exe
		FileDelete, %save%
		message = 0x1100
		Progress, M H80, , .
		OnMessage(message, "SetCounter")
		DownloadProgress(url, save, message, 50)
		Progress, Off
		IfExist %save%
			RunWait, %save%
		Else {
			Clipboard:="https://download.mozilla.org/`?product=firefox-latest`&os=win`&lang=en-US"
			MsgBox Link copied, paste (Ctrl+V) into your browser to download Firefox setup file.
		}
	}
	Else {
		RunWait, firefox.exe https://addons.mozilla.org/addon/vagex2
	}
	Gui_Update()
	Return
}
^0::
	TrayShow:=!TrayShow
	If TrayShow
		Menu, Tray, Icon
	Else
		Menu, Tray, NoIcon
Return
^1::
	TrayShow=1
	Menu, Tray, Icon
	Gui_Update()
	Gui Show, w210 h290, Pi Tools
Return
^2::
	Process, Exist , vagex.exe
	if ErrorLevel
	{
		VagexShow:=!VagexShow
		If VagexShow
		{
			WinShow, Vagex Viewer
			Sleep, 1123
			WinRestore, Vagex Viewer
		}
		Else
			WinMinimize, Vagex Viewer
	}
Return
^3::
	Process, Exist , firefox.exe
	if ErrorLevel
	{
		FirefoxShow:=!FirefoxShow
		If FirefoxShow
			WinShow, Mozilla Firefox
		Else
			WinHide, Mozilla Firefox
	}
Return
^4::
	Process, Exist , simplewrapper.exe
	if ErrorLevel
	{
		HitleapShow:=!HitleapShow
		If HitleapShow
			WinShow, HitLeap Viewer
		Else
			WinHide, HitLeap Viewer
	}
Return
Check_Program_Installed(Program) {
	shell := ComObjCreate("Shell.Application")
	programsFolder := shell.NameSpace("::{26EE0668-A00A-44D7-9371-BEB064C98683}\8\::{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}")
	items := programsFolder.Items()
	programList := ""
	Loop, % items.Count
	{
	  this_item := items.Item(A_Index - 1)
	  programList .= this_item.Name . "`n"
	}
	IfInString, programList, %Program%
		Return True
	Else
		Return False
}
Main_Vagex() {
	static WatchButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad15
	static WatchButtonx = WindowsForms10.BUTTON.app.0.34f5582_r9_ad12
	static PauseButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad14
	static AccButton = WindowsForms10.BUTTON.app.0.34f5582_r10_ad16
	
	IniRead, VagexAutoClickWatchButton, pi.ini, PiTools, VagexAutoClickWatchButton
	IniRead, VagexKeepRunning, pi.ini, PiTools, VagexKeepRunning
	IniRead, VagexShow, pi.ini, PiTools, VagexShow,0
	If VagexKeepRunning
	{
		Process, Exist , vagex.exe
		If !ErrorLevel
		{
			IfNotExist Vagex.application
				UrlDownloadToFile, https://vagex.com/Vagex4/Vagex.application, Vagex.application
			RunWait, Vagex.application
			Sleep, 15123
		}
		Else {
			If VagexAutoClickWatchButton
			{
				WinShow, Vagex Viewer
				Sleep, 1123
				WinRestore, Vagex Viewer
				Sleep, 3123
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
			}
		}
		If !VagexShow
			WinMinimize, Vagex Viewer
	}
	Return
}
Main_Firefox() {
	IniRead, FirefoxKeepRunning, pi.ini, PiTools, FirefoxKeepRunning
	IniRead, FirefoxRestart, pi.ini, PiTools, FirefoxRestart
	IniRead, FirefoxRestartPeriod, pi.ini, PiTools, FirefoxRestartPeriod
	IniRead, FirefoxShow, pi.ini, PiTools, FirefoxShow,1
	If FirefoxKeepRunning
	{
		Process, Exist , firefox.exe
		If !ErrorLevel
		{
			RunWait, "firefox.exe"
			Sleep, 15123
			If !FirefoxShow
				WinHide, Mozilla Firefox
		}
	}
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