format PE console
entry start

include 'win32a.inc' 

struct PNT
    x dd ?
    y dd ?
ends

section '.bss' readable writeable
p1 PNT ?,?
p2 PNT ?,?

; ===============================================
section '.text' code readable executable
;
;   For every two points (a,b), (c,d),
;    we say that (a,b) < (c,d) if:
;    -> (a < c) or (a = c and b < d)
; 
start:
    call read_hex
    mov dword [p1.x], eax
    call read_hex
    mov dword [p1.y],eax
    
    call read_hex
    mov dword [p2.x], eax
    call read_hex
    mov dword [p2.y],eax
    
    mov eax, dword[p1.x]
    mov ebx, dword[p2.x]

    mov ecx, dword[p1.y]
    mov edx, dword[p2.y]
    
    ; a < c
    cmp eax, ebx
    jl p1_larger
    ; a = c && b > d
    cmp eax,ebx
    jne p1_larger
    cmp ecx,edx
    jg p1_larger

    ; explicitly taking from ram
    ; for readability purposes
    mov eax, dword[p2.x]
    call print_eax
    mov eax, dword[p2.y]
    call print_eax
    call print_delimiter
    mov eax, dword[p1.x]
    call print_eax
    mov eax, dword[p1.y]
    call print_eax

    jmp exit_program

    p1_larger: ; eax was already p1.x
    call print_eax
    mov eax, dword [p1.y]
    call print_eax
    call print_delimiter
    mov eax, dword[p2.x]
    call print_eax
    mov eax, dword[p2.y]
    call print_eax

    exit_program:
    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
