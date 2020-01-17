#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent
#SingleInstance Force
DetectHiddenWindows, On
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetBatchLines -1
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;======================================================================
Main_Toggle=1
Tray_Toggle=1
Check_Ini()
Gosub, Startup
SetTimer, Main_Timmer, 312345
SetTimer, Firefox_Restart_Timmer, %RestartFirefoxPeriod%
Gui Add, Button, hWndhBtnHide vBtnHide gBtnHide x65 y278 w80 h23, &Hide
Gui Add, CheckBox, hWndhAutoClickWatchButton vAutoClickWatchButton gAutoClickWatchButton x18 y116 w158 h23, Auto click Watch button
Gui Add, CheckBox, hWndhKeepFirefoxRunning vKeepFirefoxRunning gKeepFirefoxRunning x18 y186 w158 h25, Keep Firefox running
Gui Add, CheckBox, hWndhKeepVagexRunning vKeepVagexRunning gKeepVagexRunning x18 y90 w158 h23, Keep Vagex running
Gui Add, CheckBox, hWndhRestartFirefox vRestartFirefox gRestartFirefox x38 y211 w141 h23, Restart affter every
Gui Add, CheckBox, hWndhStartWithWindows vStartWithWindows gStartWithWindows x18 y29 w120 h23, Start with Windows
Gui Add, Edit, hWndhRestartFirefoxPeriod vRestartFirefoxPeriod gRestartFirefoxPeriod x62 y237 w50 h23 +Right, 3600
Gui Add, GroupBox, x10 y154 w187 h117, Firefox Addons Viewer
Gui Add, GroupBox, x10 y54 w187 h92, Vagex Viewer
Gui Add, Text, hWndhTxtFirefoxInstalled vTxtFirefoxInstalled  x115 y169 w38 h23 +0x200, NO
Gui Add, Text, hWndhTxtVagexInstalled vTxtVagexInstalled x115 y69 w38 h23 +0x200, NO
Gui Add, Text, x117 y237 w50 h23 +0x200, second(s)
Gui Add, Text, x18 y169 w88 h23 +0x200, Firefox Installed
Gui Add, Text, x18 y69 w88 h23 +0x200, Vagex Installed
Gui Add, Text, x5 y4 w188 h23 +0x200 +Center, Press Ctrl+0 to Hide/Unhide tray icon
Check_Program_Installed()

GuiControl,, AutoClickWatchButton , %AutoClickWatchButton%
GuiControl,, KeepFirefoxRunning , %KeepFirefoxRunning%
GuiControl,, KeepVagexRunning , %KeepVagexRunning%
GuiControl,, RestartFirefox , %RestartFirefox%
GuiControl,, StartWithWindows , %StartWithWindows%
GuiControl,, RestartFirefoxPeriod , %RestartFirefoxPeriod%

SetTimer, Main_Timmer, Off
Gui Show, w210 h318, Pi Tools
Return
Firefox_Restart_Timmer:
	IniRead, RestartFirefox, pi.ini, Vagex, RestartFirefox,0
	If RestartFirefox
	{
		Process, Exist , firefox.exe
		If ErrorLevel
		{
			WinClose, Mozilla Firefox
			Sleep, 5000
		}
		RunWait, "firefox.exe"
	}
Return
Main_Timmer:
	General_Task()
	If KeepFirefoxRunning
	{
		Process, Exist , firefox.exe
		If !ErrorLevel
			RunWait, "firefox.exe"
	}
	If KeepVagexRunning
	{
		Process, Exist , vagex.exe
		If !ErrorLevel
		{
			RunWait, "%A_Programs%\Vagex\Vagex Viewer.appref-ms",,Hide
		}
		Else {
			If AutoClickWatchButton
			{
			}
		}
	}
Return
Check_Ini() {
vDefault_ini=
(
;pi tools
[General]`nStartWithWindows=1`n
[Vagex]`nAutoClickWatchButton=1`nKeepFirefoxRunning=1`nKeepVagexRunning=1`nRestartFirefox=1`nRestartFirefoxPeriod=3600`n
)
IfNotExist, pi.ini
	FileAppend ,% vDefault_ini, pi.ini, UTF-8
}
Check_Program_Installed() {
	shell := ComObjCreate("Shell.Application")
	programsFolder := shell.NameSpace("::{26EE0668-A00A-44D7-9371-BEB064C98683}\8\::{7B81BE6A-CE2B-4676-A29E-EB907A5126C5}")
	items := programsFolder.Items()
	programList := ""
	Loop, % items.Count
	{
	  this_item := items.Item(A_Index - 1)
	  programList .= this_item.Name . "`n"
	}
	IfInString, programList, Mozilla Firefox
		GuiControl,, TxtFirefoxInstalled , YES
	Else {
		IniWrite, 0, pi.ini, Vagex, KeepFirefoxRunning
		IniWrite, 0, pi.ini, Vagex, RestartFirefox
		GuiControl,Disable, KeepFirefoxRunning
		GuiControl,Disable, RestartFirefox
	}
	IfInString, programList, Vagex Viewer
		GuiControl,, TxtVagexInstalled , YES
	Else {
		IniWrite, 0, pi.ini, Vagex, KeepVagexRunning
		IniWrite, 0, pi.ini, Vagex, AutoClickWatchButton
		GuiControl,Disable, KeepVagexRunning
		GuiControl,Disable, AutoClickWatchButton
	}
	Return
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
Startup:
IniRead, AutoClickWatchButton, pi.ini, Vagex, AutoClickWatchButton,1
IniRead, KeepFirefoxRunning, pi.ini, Vagex, KeepFirefoxRunning,1
IniRead, KeepVagexRunning, pi.ini, Vagex, KeepVagexRunning,1
IniRead, RestartFirefox, pi.ini, Vagex, RestartFirefox,1
IniRead, RestartFirefoxPeriod, pi.ini, Vagex, RestartFirefoxPeriod,3600
IniRead, StartWithWindows, pi.ini, General, StartWithWindows,1
If StartWithWindows
{
	SplitPath, A_Scriptname, , , , OutNameNoExt
	LinkFile=%A_Startup%\%OutNameNoExt%.lnk
	IfNotExist, %LinkFile%
		FileCreateShortcut, %A_ScriptFullPath%, %LinkFile% ; Admin right ?
}
Else {
	FileDelete, %LinkFile%
}
Return
GuiClose:
    ExitApp
Return
BtnHide:
GuiEscape:
	Gui, Submit
	Tray_Toggle=1
	Menu, Tray, Icon
	SetTimer, Main_Timmer, 312345
	
Return
^0::
	Tray_Toggle:=!Tray_Toggle
	If Tray_Toggle
		Menu, Tray, Icon
	Else
		Menu, Tray, NoIcon
Return
^1::
	SetTimer, Main_Timmer, Off
	Tray_Toggle=1
	Menu, Tray, Icon
	Gui, Show
Return
StartWithWindows:
	GuiControlGet, GuiName , Name , %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, pi.ini, General, %GuiName%
	If GuiValue
	{
		SplitPath, A_Scriptname, , , , OutNameNoExt
		LinkFile=%A_Startup%\%OutNameNoExt%.lnk
		IfNotExist, %LinkFile%
		  FileCreateShortcut, %A_ScriptFullPath%, %LinkFile% ; Admin right ?
	}
	Else {
		FileDelete, %LinkFile%
	}
Return
AutoClickWatchButton:
KeepFirefoxRunning:
KeepVagexRunning:
RestartFirefox:
RestartFirefoxPeriod:
	GuiControlGet, GuiName ,Name, %A_GuiControl%
	GuiControlGet, GuiValue ,, %A_GuiControl%
	IniWrite, %GuiValue%, pi.ini, Vagex, %GuiName%
	IniRead, RestartFirefox, pi.ini, Vagex, RestartFirefox,1
	If RestartFirefox
	{
		IniRead, RestartFirefoxPeriod, pi.ini, Vagex, RestartFirefoxPeriod,3600
		SetTimer, Firefox_Restart_Timmer, % RestartFirefoxPeriod*1000
	}
	Else {
		SetTimer, Firefox_Restart_Timmer, Off
	}
Return
Tray_Refresh() {
/*		Remove any dead icon from the tray menu
 *		Should work both for W7 & W10
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
; Parameters ....: sExeName  - The exe for which we are searching the tray icon data. Leave it empty to receive data for
; ...............:             all tray icons.
; Return ........: oTrayIcon_GetInfo - An array of objects containing tray icons data. Any entry is structured like this:
; ...............:             oTrayIcon_GetInfo[A_Index].idx     - 0 based tray icon index.
; ...............:             oTrayIcon_GetInfo[A_Index].IDcmd   - Command identifier associated with the button.
; ...............:             oTrayIcon_GetInfo[A_Index].pID     - Process ID.
; ...............:             oTrayIcon_GetInfo[A_Index].uID     - Application defined identifier for the icon.
; ...............:             oTrayIcon_GetInfo[A_Index].msgID   - Application defined callback message.
; ...............:             oTrayIcon_GetInfo[A_Index].hIcon   - Handle to the tray icon.
; ...............:             oTrayIcon_GetInfo[A_Index].hWnd    - Window handle.
; ...............:             oTrayIcon_GetInfo[A_Index].Class   - Window class.
; ...............:             oTrayIcon_GetInfo[A_Index].Process - Process executable.
; ...............:             oTrayIcon_GetInfo[A_Index].Tray    - Tray Type (Shell_TrayWnd or NotifyIconOverflowWindow).
; ...............:             oTrayIcon_GetInfo[A_Index].tooltip - Tray icon tooltip.
; Info ..........: TB_BUTTONCOUNT message - http://goo.gl/DVxpsg
; ...............: TB_GETBUTTON message   - http://goo.gl/2oiOsl
; ...............: TBBUTTON structure     - http://goo.gl/EIE21Z
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
		pRB   := DllCall("VirtualAllocEx", Ptr, hProc, Ptr, 0, UPtr, 20, UInt, 0x1000, UInt, 0x4)
		SendMessage, 0x418, 0, 0, ToolbarWindow32%idxTB%, ahk_class %sTray%   ; TB_BUTTONCOUNT
		szBtn := VarSetCapacity(btn, (A_Is64bitOS ? 32 : 20), 0)
		szNfo := VarSetCapacity(nfo, (A_Is64bitOS ? 32 : 24), 0)
		szTip := VarSetCapacity(tip, 128 * 2, 0)
		Loop, %ErrorLevel%
		{
			SendMessage, 0x417, A_Index - 1, pRB, ToolbarWindow32%idxTB%, ahk_class %sTray%   ; TB_GETBUTTON
			DllCall("ReadProcessMemory", Ptr, hProc, Ptr, pRB, Ptr, &btn, UPtr, szBtn, UPtr, 0)
			iBitmap := NumGet(btn, 0, "Int")
			IDcmd   := NumGet(btn, 4, "Int")
			statyle := NumGet(btn, 8)
			dwData  := NumGet(btn, (A_Is64bitOS ? 16 : 12))
			iString := NumGet(btn, (A_Is64bitOS ? 24 : 16), "Ptr")
			DllCall("ReadProcessMemory", Ptr, hProc, Ptr, dwData, Ptr, &nfo, UPtr, szNfo, UPtr, 0)
			hWnd  := NumGet(nfo, 0, "Ptr")
			uID   := NumGet(nfo, (A_Is64bitOS ? 8 : 4), "UInt")
			msgID := NumGet(nfo, (A_Is64bitOS ? 12 : 8))
			hIcon := NumGet(nfo, (A_Is64bitOS ? 24 : 20), "Ptr")
			WinGet, pID, PID, ahk_id %hWnd%
			WinGet, sProcess, ProcessName, ahk_id %hWnd%
			WinGetClass, sClass, ahk_id %hWnd%
			If !sExeName || (sExeName = sProcess) || (sExeName = pID)
			{
				DllCall("ReadProcessMemory", Ptr, hProc, Ptr, iString, Ptr, &tip, UPtr, szTip, UPtr, 0)
				Index := (oTrayIcon_GetInfo.MaxIndex()>0 ? oTrayIcon_GetInfo.MaxIndex()+1 : 1)
				oTrayIcon_GetInfo[Index,"idx"]     := A_Index - 1
				oTrayIcon_GetInfo[Index,"IDcmd"]   := IDcmd
				oTrayIcon_GetInfo[Index,"pID"]     := pID
				oTrayIcon_GetInfo[Index,"uID"]     := uID
				oTrayIcon_GetInfo[Index,"msgID"]   := msgID
				oTrayIcon_GetInfo[Index,"hIcon"]   := hIcon
				oTrayIcon_GetInfo[Index,"hWnd"]    := hWnd
				oTrayIcon_GetInfo[Index,"Class"]   := sClass
				oTrayIcon_GetInfo[Index,"Process"] := sProcess
				oTrayIcon_GetInfo[Index,"Tooltip"] := StrGet(&tip, "UTF-16")
				oTrayIcon_GetInfo[Index,"Tray"]    := sTray
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
		NumPut(uID  , NID, (A_PtrSize == 4 ? 8  : 16 ))
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
; Parameters ...: hWnd       - Window handle.
; ..............: uId        - Application defined identifier for the icon.
; ..............: hIcon      - Handle to the tray icon.
; ..............: hIconSmall - Handle to the small icon, for window menubar. Optional.
; ..............: hIconBig   - Handle to the big icon, for taskbar. Optional.
; Return .......: True on success, false on failure.
; Info .........: NOTIFYICONDATA structure  - https://goo.gl/1Xuw5r
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
    NumPut( szNID, NID, 0                           )
    NumPut( hWnd,  NID, (A_PtrSize == 4) ? 4   : 8  )
    NumPut( uId,   NID, (A_PtrSize == 4) ? 8   : 16 )
    NumPut( 2,     NID, (A_PtrSize == 4) ? 12  : 20 )
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
	Return  idxTB
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
; ..............: index    - Index of tray icon to click if more than one match.
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
	uID    := oIcons[index].uID
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