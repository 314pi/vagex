; Prompt to 'Run as Admin', i.e. show UAC dialog
If Not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
RunWait,sc start "FluidStackNode",,hide
Return
