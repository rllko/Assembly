format PE console
entry start
; shout out xorpd for the exercise idea
include 'win32a.inc' 

; ===============================================
;section '.data' data readable writeable

; ===============================================
section '.text' code readable executable

start:

    call read_hex
    mov ecx,eax
    call prime_amount_n

    call print_eax
    
    ; Exit the process:
	push	0
	call	[ExitProcess]

;input: ecx -> number
;operation: displays amount of prime numbers from 1 to n
;output: eax -> amount
;
prime_amount_n:
    push    ebx
    jecxz   .end_func
    xor	    ebx,ebx
.next_number:
    call    check_prime
    add	    ebx,eax
    xor	    eax,eax
    dec ecx
    cmp ecx,1
    jnz .next_number

.end_func:
    mov	    eax,ebx
    pop	    ebx
    ret

; input: ecx -> number
; output: eax -> is prime
;
check_prime:
    push ebx ; store registers
    push esi
    push edx

    jecxz .end_func
    mov ebx,1 ; iterator 
    mov esi,1 ; is prime
    ;xor edx,edx ; remainder
.next_number:
    test esi,esi
    jz .end_func

    xor edx,edx
    inc ebx ; increase iterator
    cmp ebx,ecx ; check if done
    jz .end_func ; finish

    mov eax,ecx ; store n to divide
    div ebx ; divide by iterator
    test edx,edx ; check if has remainder
    jnz .skip_number
    xor esi,esi ; n is not prime
.skip_number:
    jmp .next_number

.end_func:
    mov eax,esi
    pop edx
    pop esi
    pop ebx ; restore registers
    ret

include 'training.inc'
