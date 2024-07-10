format PE console
entry start
;introduce syntax
include 'win32a.inc' 
; for initialized data

ARR_LEN EQU 3

section '.data' data readable writeable	
var dd 2

;for uninitialized data
section '.bss' readable writeable
	arr dd ARR_LEN dup(?)

;for the actual code
section '.text' code readable executable

start:
	xor ebx,ebx
	lea esi,[arr]
lp:
	call read_hex
	mov dword [esi+ebx*4],eax
	
	inc ebx
	cmp ebx,ARR_LEN
	jne lp

	sub esi,4
print_numbers:
	mov eax, dword[esi+ebx*4]
	call print_eax
	
	dec ebx
	cmp ebx,0
	jne print_numbers

	push 0
	call [ExitProcess]

include 'training.inc'
