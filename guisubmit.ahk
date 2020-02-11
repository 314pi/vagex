GuiSubmit() {
	Global Ini_File, Ini_Section
	Loop, Read, %Ini_File%
	{
		IfInString, A_LoopReadLine, =
		{
			StringSplit, magic, A_LoopReadLine, =
			%magic1% := magic2
			GuiControlGet, %magic1% ,, %magic1%
			If !ErrorLevel
				IniWrite, % %magic1%, %Ini_File%, %Ini_Section%, %magic1%
		}
	}
	Return
}