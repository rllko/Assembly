format PE console
entry start

include 'win32a.inc' 

; Write a program that takes the value n as input, and finds the sum of all the odd numbers between 1 and 2n+1, inclusive.
section '.text' code readable executable

start:
    ; The program begins here:
    call read_hex

    shl eax,1
    inc eax

    call print_eax

    ;ecx = 2n+1
    mov ecx,eax

    ;counter
    xor esi,esi
    ;sum
    xor ebx,ebx	
    ;placeholder for even num
    mov edi,2
lp:
    ;exit condition
    cmp esi,ecx
        jae exit

    inc esi
    mov eax,esi
    div edi

    ;check rest
    test edx,1
      	jz lp
  
    add ebx,esi
    mov eax,ebx
    call print_eax
    
jmp lp

exit:
    ; Exit the process:
	mov eax,0
	call print_eax

	push	0
	call	[ExitProcess]

include 'training.inc'
