ServiceChk = sc query "Spooler" >"ServiceCheck.txt"
runwait, %COMSPEC% /C %ServiceChk%, ,Hide  

Loop, read, ServiceCheck.txt
{
    if InStr(A_LoopReadLine, "STATE")
	{
		StringGetPos, pointer, A_LoopReadLine, :
		StringRight, ServerStatus, A_LoopReadLine, StrLen(A_LoopReadLine) - pointer - 5
		MsgBox %ServerStatus%
	}
}

Return