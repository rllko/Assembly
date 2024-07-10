format PE console
entry start

include 'win32a.inc' 

; write a program that takes a number m as input, and prints back 1 to the console if m is a prime number. Otherwise, it prints 0.
section '.text' code readable executable

start:
call read_hex
mov ebx,eax

mov esi,2

mov ecx,2
xor edx,edx
l1:
    cmp ecx,ebx
	je l4

    xor eax,eax
    mov eax,ecx
    div esi
    test edx,edx
	jnz l2
    	
    inc ecx
    jmp l1

l2:
    mov eax,ecx
    call print_eax
    inc ecx
    jmp l1

l4:
    mov eax,0
    call print_eax

l3:
push 0
call [ExitProcess]

include 'training.inc'
