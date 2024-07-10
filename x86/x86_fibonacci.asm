format PE console
entry start

include 'win32a.inc' 

; this is a demo with a library
section '.text' code readable executable
start:
    ;first number
    mov ebx,0
    ;second number
    mov edx,1 
    
    ;get user input for n
    call read_hex
    mov esi,eax
    
    ;clear fib index
    xor ecx,ecx

next_fibo:
    ; result
    mov edi,0
   
    ; add both to result
    add edi,ebx
    add edi,edx

    ; set first number to second
    mov ebx,edx

    ; set second to result
    mov edx,edi
    
    ; add one to the index
    inc ecx
    
    ;compare index to user input
    cmp esi,ecx
    jne next_fibo

    mov eax,ebx

print:
    call print_eax

	push	0
	call	[ExitProcess]

print_numbers:
    mov eax,ecx
    call print_eax
    
    ret

include 'training.inc'
