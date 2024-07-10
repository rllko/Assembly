format PE console
entry start

include 'win32a.inc' 
section '.text' code readable executable

start:
    xor dx,dx
    ;reading number a
    ; a < 2^5 = 32
    call    read_hex
    mov     bl,al
    ;reading number b
    ; b < 2^3 = 8
    call    read_hex
    
    mov     dl,bl ; store number a
    shl     dl,3 ; shift to get space for b
    or      dl,al ; insert number b

    movzx   eax,dl ; print packed number
    call    print_eax_binary

    mov     cl,dl ; backup the packed data
    
    and     dl,111b ; retrieve number b
    mov     bl,dl ; store it in bl

    mov     al,cl ; get packed number
    shr     al,3 ; remove number b
    
    cwde ; extend ax to eax
    call    print_eax

    movzx   eax,bl ; print number b
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
