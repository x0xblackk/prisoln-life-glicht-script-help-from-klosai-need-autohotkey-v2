#Requires AutoHotkey v2.0
#SingleInstance Force

SetWorkingDir(A_ScriptDir)
SendMode("Input")
DllCall("Winmm\timeBeginPeriod", "UInt", 1)

; ========= STOP-SIGNAL =========
SetTimer(CheckStop, 100)

CheckStop() {
    if FileExist("stop.flag") {
        FileDelete("stop.flag")
        DllCall("Winmm\timeEndPeriod", "UInt", 1)
        ExitApp()
    }
}

; ========= DEIN MAKRO =========
CS := 0.36
Spin := Round(180 * 2.5 / CS)

FREEZE := False
Spins := 20

Q::{
    Send("c")

    Send("{Space down}")
    if FREEZE
        DllCall("Sleep", "UInt", 20)
    else
        DllCall("Sleep", "UInt", 50)

    Send("{Space up}")

    if FREEZE
    {
        DllCall("mouse_event", "UInt", 0x0020, "UInt", 0, "UInt", 0, "UInt", 0, "UPtr", 0)
        DllCall("Sleep", "UInt", 100)
        DllCall("mouse_event", "UInt", 0x0040, "UInt", 0, "UInt", 0, "UInt", 0, "UPtr", 0)
    }

    DllCall("Sleep", "UInt", 14)

    Loop Spins
    {
        DllCall("mouse_event", "UInt", 0x0001, "Int", Spin, "Int", 0, "UInt", 0, "UPtr", 0)
        DllCall("Sleep", "UInt", 8)
    }
}

F3::{
    DllCall("Winmm\timeEndPeriod", "UInt", 1)
    ExitApp()
}