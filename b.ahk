;EDIT : modified 20180405 , user tank >>  "wb.silent := true"

;-------- saved at Mittwoch, 18. Februar 2015 19:45:55 XP netbook
;-------- https://autohotkey.com/boards/viewtopic.php?f=5&t=6445 -----------
;-- a browser  from user 'Soft' and 'Lexikos'
;===========================================================================

f1=https://autohotkey.com/boards/
filename1=Browser SOFT

Gui,2: Add, Edit, w930 r1 vURL,%f1%
Gui,2: Add, Button, x5 y25  gBrB, <
Gui,2: Add, Button, x+1 y25 gBrF, >
Gui,2: Add, Button, x+6 yp w44 Default gA1, Go
;Gui,2: Add, ActiveX, xm w980 h640 vWB, Shell.Explorer
Gui,2: Add, ActiveX, xm w1080 h720 vWB, Mozilla.Browser
wb.silent := true
ComObjConnect(WB, WB_events)    ;- Connect WB's events to the WB_events class object.
Gui,2: Show,,%filename1%
gosub,a1
return

a1:
Gui,2: Submit, NoHide
try {WB.Navigate(URL)
}catch e{
xxx:=e.Message
msgbox, 262208,ERROR,Error=`n%xxx%`n------------------------------------------`n
return
}
return

Brb:
try{WB.GoBack()
}catch e{
xxx:=e.Message
;msgbox, 262208,ERROR,Error=`n%xxx%`n------------------------------------------`n
return
}
return

BrF:
try{WB.GoForward()
}catch e{
xxx:=e.Message
;msgbox, 262208,ERROR,Error=`n%xxx%`n------------------------------------------`n
return
}
return

class WB_events
{
NavigateComplete2(wb, NewURL)
  {
  GuiControl,2:, URL, %NewURL%  ;- Update the URL edit control.
  }
}

2GuiClose:
ExitApp
