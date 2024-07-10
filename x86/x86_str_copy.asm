format PE console
entry start

include 'win32a.inc' 
include 'encoding/utf8.inc'

ROW_NUM = 9

section '.data' data readable writeable
    strtmp db "%s",0
    str1 db 'hello world',0
    STR_SIZE = ($ - str1)

section '.bss' readable writeable
    str2 db STR_SIZE dup(?)
; ===============================================
section '.text' code readable executable

start:
    cld ; clears direction flag
    lea esi,[str1] ; copies str1 to esi
    lea edi,[str2] ; copies str2 to edi
    mov ecx,STR_SIZE ; sets loop counter

    rep movsb ; move character from esi to edi
    
    mov esi,str2 ; prepare to print 
    call print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
