format PE console
entry start

include 'win32a.inc' 
section '.text' code readable executable

start:
    call read_hex
    mov ebx,eax
    call read_hex
    mov esi,eax
    call read_hex
    
    ;if you xor a number by an odd number
    ;it will subtract the number
    xor eax,esi
    xor eax,ebx

    ;check if the result is even
    and eax,1

    call print_eax
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
