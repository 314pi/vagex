If (!A_IsAdmin)
{
    MsgBox You must run the script as Administrator
    ExitApp
}

DllCall("Ntdll.dll\RtlAdjustPrivilege", "UInt", 20, "UChar", TRUE, "UChar", FALSE, "IntP", t)
Return

Insert::
ToolTip Wait ...
TerminateWacomProcesses()
RestartService("WTabletServicePro")
ToolTip
Return

RestartService(ServiceName, NumServiceArgs := 0, ServiceArgVectors := 0, ByRef SERVICE_STATUS := "")
{
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms684323(v=vs.85).aspx
    Local hSCManager
    If (!(hSCManager := DllCall("Advapi32.dll\OpenSCManagerW", "Ptr", 0, "Ptr", 0, "UInt", 0xF003F, "Ptr")))
        Return -1

    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms684330(v=vs.85).aspx
    Local hService
    If (!(hService := DllCall("Advapi32.dll\OpenServiceW", "Ptr", hSCManager, "UPtr", &ServiceName, "UInt", 0x0020|0x0010, "Ptr")))    ; SERVICE_STOP|SERVICE_START
    {
        DllCall("AdvApi32.dll\CloseServiceHandle", "Ptr", hSCManager)
        Return -2
    }

    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms682108(v=vs.85).aspx
    VarSetCapacity(SERVICE_STATUS, 7 * 4, 0)
    Local R := DllCall("AdvApi32.dll\ControlService", "Ptr", hService, "UInt", 0x00000001, "UPtr", &SERVICE_STATUS) ? 0 : (A_LastError != 1062)    ; SERVICE_CONTROL_STOP = 0x00000001 | ERROR_SERVICE_NOT_ACTIVE = 1062
    
    Sleep 2000
    
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms686321(v=vs.85).aspx
    If (!R)
        R := DllCall("AdvApi32.dll\StartServiceW", "Ptr", hService, "UInt", NumServiceArgs, "UPtr", ServiceArgVectors) ? 0 : 2
    
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms682028(v=vs.85).aspx
    DllCall("AdvApi32.dll\CloseServiceHandle", "Ptr", hService, "UInt")
    DllCall("AdvApi32.dll\CloseServiceHandle", "Ptr", hSCManager, "UInt")

    Return R    ; 0 = ERROR_SUCCESS
}

TerminateWacomProcesses()
{
    For Each, Obj In EnumerateProcesses()
    {
        If (InStr(Obj.ProcessName, "Wacom"))
            Process Close, % Obj.ProcessId
    }
}

EnumerateProcesses()
{
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms682489(v=vs.85).aspx
    Local hSnapshot
    If ((hSnapshot := DLLCall("Kernel32.dll\CreateToolhelp32Snapshot", "UInt", 2, "UInt", 0, "Ptr")) == -1)    ; TH32CS_SNAPPROCESS = 2 | INVALID_HANDLE_VALUE = -1
        Return -1
    
    Local PROCESSENTRY32
    NumPut(VarSetCapacity(PROCESSENTRY32, A_PtrSize == 4 ? 556 : 568), &PROCESSENTRY32, "UInt")
    
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms684834(v=vs.85).aspx
    Local OutputVar := []
    If (DllCall("Kernel32.dll\Process32FirstW", "Ptr", hSnapshot, "UPtr", &PROCESSENTRY32))
        Loop
            OutputVar[A_Index] := {       ProcessId: NumGet(&PROCESSENTRY32 +                          8,   "UInt")
                                  , ParentProcessId: NumGet(&PROCESSENTRY32 + (A_PtrSize == 4 ? 24 : 32),   "UInt")
                                  , ProcessName    : StrGet(&PROCESSENTRY32 + (A_PtrSize == 4 ? 36 : 44), "UTF-16")
                                  , Threads        : NumGet(&PROCESSENTRY32 + (A_PtrSize == 4 ? 20 : 28),   "UInt") }
        ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms684836(v=vs.85).aspx
        Until (!DllCall("Kernel32.dll\Process32NextW", "Ptr", hSnapshot, "UPtr", &PROCESSENTRY32))
    
    ; https://msdn.microsoft.com/en-us/library/windows/desktop/ms724211(v=vs.85).aspx
    DllCall("Kernel32.dll\CloseHandle", "Ptr", hSnapshot)

    Return ObjLength(OutputVar) ? OutputVar : FALSE
} ;https://msdn.microsoft.com/en-us/library/windows/desktop/ms684834(v=vs.85).aspx





/*
    typedef struct tagPROCESSENTRY32W
    {
        DWORD   dwSize;
        DWORD   cntUsage;
        DWORD   th32ProcessID;          // this process
        ULONG_PTR th32DefaultHeapID;
        DWORD   th32ModuleID;           // associated exe
        DWORD   cntThreads;
        DWORD   th32ParentProcessID;    // this process's parent process
        LONG    pcPriClassBase;         // Base priority of process's threads
        DWORD   dwFlags;
        WCHAR   szExeFile[MAX_PATH];    // Path
    } PROCESSENTRY32W;

    
    MAX_PATH = 260 bytes (520 bytes UTF-16)


    32-bit
        -- TYPE -    ------ NAME -------    -- SIZE -    - TOTAL -
            DWORD                 dwSize      4 bytes      4 bytes    #1
            DWORD               cntUsage      4 bytes      8 bytes    #2
            DWORD          th32ProcessID      4 bytes     12 bytes    #3
        ULONG_PTR      th32DefaultHeapID      4 bytes     16 bytes    #4
            DWORD           th32ModuleID      4 bytes     20 bytes    #5
            DWORD             cntThreads      4 bytes     24 bytes    #6
            DWORD    th32ParentProcessID      4 bytes     28 bytes    #7
             LONG         pcPriClassBase      4 bytes     32 bytes    #8
            DWORD                dwFlags      4 bytes     36 bytes    #9
            WCHAR    szExeFile[MAX_PATH]    520 bytes    556 bytes


    64-bit
        -- TYPE -    ------ NAME -------    -- SIZE -    - TOTAL -
            DWORD                 dwSize      4 bytes      4 bytes    #1
            DWORD               cntUsage      4 bytes      8 bytes    #1
            DWORD          th32ProcessID      4 bytes     12 bytes    #2
          PADDING                             4 bytes     16 bytes    #2
        ULONG_PTR      th32DefaultHeapID      8 bytes     24 bytes    #3
            DWORD           th32ModuleID      4 bytes     28 bytes    #4
            DWORD             cntThreads      4 bytes     32 bytes    #4
            DWORD    th32ParentProcessID      4 bytes     36 bytes    #5
             LONG         pcPriClassBase      4 bytes     40 bytes    #5
            DWORD                dwFlags      4 bytes     44 bytes    #6
          PADDING                             4 bytes     48 bytes    #6
            WCHAR    szExeFile[MAX_PATH]    520 bytes    568 bytes
*/