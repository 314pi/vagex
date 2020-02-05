#Persistent
period = 1000 
SetBatchLines, -1 
SetFormat, float, 0.0 
CoordMode, ToolTip, screen 
SetTimer, CheckCPULoad, %period%
return

CheckCPULoad:
   start := a_TickCount 
   elapsed := start - Laststart
   
   GetIdleTime( Low, High ) 
    
   If Laststart
     {
       Idle_ticks := ( High - Lasthigh ) << 32 
       Idle_ticks := ( Idle_ticks + ( Low - Lastlow ) ) * 0.0001 
       ppu_idle := Idle_ticks / elapsed * 100 
     
       total := elapsed - Idle_ticks 
       ppu := 100 - ppu_idle 

       ToolTip,
         (LTrim
           period = %period% (ideal)
           elapsed = %elapsed% (actual)
         
           ppu = %total% ms (%ppu%`%)
           idle = %Idle_ticks% ms (%ppu_idle%`%)
         ), 10, 10 
     }
   Laststart := start
   Lastlow := Low
   Lasthigh := High
return

GetIdleTime( ByRef Low, ByRef High ) 
  { 
    VarSetCapacity( Ticks, 4+4 ) 
    success := DllCall( "kernel32.dll\GetSystemTimes", "uint", &Ticks, "uint", 0, "uint", 0 ) 
    if ( ! success ) 
      { 
        MsgBox, GetSystemTimes failed! 
        ExitApp 
      } 
        
    Low := ReadInteger( &Ticks, 0, 4 ) 
    High := ReadInteger( &Ticks, 4, 4 )
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