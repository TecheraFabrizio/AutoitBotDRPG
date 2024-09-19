#include <WinAPI.au3>

Func HexToDec($hex)
    ; Remove the '0x' prefix if present
    If StringLeft($hex, 2) = "0x" Then
        $hex = StringMid($hex, 3)
    EndIf
    
    ; Ensure the hex string is in uppercase and does not contain any spaces
    $hex = StringUpper(StringStripWS($hex, 3))

    ; Convert hex string to decimal
    Local $decimal = 0
    Local $length = StringLen($hex)
    For $i = 1 To $length
        Local $char = StringMid($hex, $i, 1)
        Local $value = 0
        If $char >= "0" And $char <= "9" Then
            $value = Asc($char) - Asc("0")
        ElseIf $char >= "A" And $char <= "F" Then
            $value = Asc($char) - Asc("A") + 10
        EndIf
        $decimal = $decimal * 16 + $value
    Next

    Return $decimal
EndFunc

; Constants
Global $PROCESS_ALL_ACCESS = 0x1F0FFF

; Define the Windows API functions
Func _ReadMemory($hProcess, $address, $size)
    Local $buffer = DllStructCreate("byte[" & $size & "]")
    Local $result = DllCall("kernel32.dll", "int", "ReadProcessMemory", "ptr", $hProcess, "ptr", $address, "ptr", DllStructGetPtr($buffer), "uint", $size, "ptr", 0)
    If @error Then Return SetError(@error, 0, 0)
    Return DllStructGetData($buffer, 1)
EndFunc

; Find the window handle by title
Local $hWnd = WinGetHandle("Digimon RPG")
If @error Then
    MsgBox(16, "Error", "Failed to find the window.") ; 16 is for Error icon
    Exit
EndIf

; Get the process ID from the window handle
Local $pid = WinGetProcess($hWnd)
If @error Then
    MsgBox(16, "Error", "Failed to get the process ID.") ; 16 is for Error icon
    Exit
EndIf

func doLecture()
; Open the process
Local $hProcess = _WinAPI_OpenProcess($PROCESS_ALL_ACCESS, False, $pid)
If @error Then
    MsgBox(16, "Error", "Failed to open process.") ; 16 is for Error icon
    Exit
EndIf

; Read the value from the address
Local $address = 0x1C4C9368 ; Replace with your address
Local $value = _ReadMemory($hProcess, $address, 1) ; Adjust size as needed

Local $res = HexToDec($value)


If @error Then
    MsgBox(16, "Error", "Failed to read memory.") ; 16 is for Error icon
Else
    ConsoleWrite($res)
EndIf

; Close the process handle
_WinAPI_CloseHandle($hProcess)
; Press Esc to terminate script, Pause/Break to "pause"
EndFunc


Global $g_bPaused = False

HotKeySet("{p}", "TogglePause")
HotKeySet("{ESC}", "Terminate")
HotKeySet("+!d", "ShowMessage") ; Shift-Alt-d

While 1
        Sleep(100)
		doLecture()
WEnd



Func TogglePause()
        $g_bPaused = Not $g_bPaused
        While $g_bPaused
			Sleep(50)
			; Simulate Key Down
			Send("{F2 down}")
			; Add a dwelay (e.g., 500 milliseconds)
			Sleep(50)
			; Simulate Key Up to release the key
			Send("{F2 up}")
			Sleep(50)

			; Simulate Key Down
			Send("{1 down}")
			; Add a dwelay (e.g., 500 milliseconds)
			Sleep(50)
			; Simulate Key Up to release the key
			Send("{1 up}")
			Sleep(50)

			; Simulate Key Down
			Send("{1 down}")
			; Add a dwelay (e.g., 500 milliseconds)
			Sleep(50)
			; Simulate Key Up to release the key
			Send("{1 up}")
			Sleep(50)

			; Simulate Key Down
			Send("{2 down}")
			; Add a dwelay (e.g., 500 milliseconds)
			Sleep(50)
			; Simulate Key Up to release the key
		    Send("{2 up}")
			Sleep(50)

			; Simulate Key Down
			Send("{2 down}")
			; Add a dwelay (e.g., 500 milliseconds)
			Sleep(50)
			; Simulate Key Up to release the key
		    Send("{2 up}")
			Sleep(50)


			$g_bPaused = Not $g_bPaused

        WEnd
        ToolTip("")
EndFunc   ;==>TogglePause

Func Terminate()
        Exit
EndFunc   ;==>Terminate

Func ShowMessage()
        MsgBox($MB_SYSTEMMODAL, "", "This is a message.")
EndFunc   ;==>ShowMessage

















