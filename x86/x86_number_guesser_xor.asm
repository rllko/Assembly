format PE console
entry start

include 'win32a.inc' 

XOR_KEY_ADDY EQU xord_num - 4
XOR_KEY = 6
XORD_VAR = 1
SUCCESS_CODE = 1

section '.data' data writeable readable
                dd XOR_KEY
    xord_num    dd XORD_VAR
section '.text' code readable executable

start:
mov ebx,dword[xord_num]
xor ebx,dword[XOR_KEY_ADDY]
try_again:
call read_hex
cmp eax,ebx
jne try_again
mov eax,SUCCESS_CODE
call print_eax

; Exit the process:

	push	0
	call	[ExitProcess]

include 'training.inc'
