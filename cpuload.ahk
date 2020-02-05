/*
This helpful script didn't count with multi core CPU. I have included 1 line, where I've found out number of
(logical, I hope that it is correct) processors and then only I'v divided total_idle_ticks by this
-EnvGet, ProcessorCount, NUMBER_OF_PROCESSORS
-load := 100 - 0.01*(IdleTime - IdleTime0)/(Tick - Tick0) / ProcessorCount
;-- http://www.autohotkey.com/forum/post-334034.html#334034
*/
;-- http://www.autohotkey.com/forum/post-226003.html#226003
;-- http://www.autohotkey.com/forum/topic17234.html             ;-- number of CPU cores
;-- http://www.autohotkey.com/forum/viewtopic.php?t=6144#36851  ;-- memgetstats
;-----------------
cpuload() {
   EnvGet, ProcessorCount, NUMBER_OF_PROCESSORS
   static o_ITime, n_ITime, o_Tick, n_Tick
   n_ITime := o_ITime,    n_Tick := o_Tick
   dllCall( "GetSystemTimes", uInt64P, o_ITime
							, int, 0, int, 0 )
   return round( 100 - .01*( n_ITime - o_ITime ) / ProcessorCount  ; -- modified /processorcount
		  / ( n_Tick - o_Tick := a_tickCount ) )
}
GetCPULoad()
{
	Static LastStartTickCount, LastLowTickCounts, LastHighTickCounts
	SetBatchLines, -1
	;get tickcounts between this and the last call of the subroutine
	StartTickCount    := A_TickCount
	ElapsedTickCounts := StartTickCount - LastStartTickCount
	;assume CPU load is zero
	CPULOAD = 0
	;get information from system idle time (i.e., the OS idle process)
	VarSetCapacity( Ticks, 4+4 )
	DllCall( "kernel32.dll\GetSystemTimes", "uint", &Ticks, "uint", 0, "uint", 0 )
	LowTickCounts  := ReadInteger( &Ticks, 0, 4 )
	HighTickCounts := ReadInteger( &Ticks, 4, 4 )
	;calculate CPU load after second call
	If LastStartTickCount
	{
		Idle_ticks := ( HighTickCounts - LastHighTickCounts ) << 32
		Idle_ticks := Idle_ticks + LowTickCounts - LastLowTickCounts
		CPULOAD    := 100 - Idle_ticks / ElapsedTickCounts / 100
	}
	;remember current values for next call
	LastStartTickCount := StartTickCount
	LastLowTickCounts  := LowTickCounts
	LastHighTickCounts := HighTickCounts
	Return, CPULOAD
}
ReadInteger( Address, Offset, Size )
{
	old_FormatInteger := A_FormatInteger
	SetFormat, Integer, hex
	value = 0
	Loop, %Size%
		value := value + ( *( ( Address + Offset ) + ( A_Index - 1 ) ) << ( 8 * ( A_Index - 1 ) ) )
	SetFormat, Integer, %old_FormatInteger%
	Return, value
}