format PE console
entry start

include 'win32a.inc' 

struct PNT
    x dd ?
    y dd ?
ends

struct rectangle
    A PNT ?
    C PNT ?
    area dd ?
ends

section '.bss' readable writeable
   rec1 rectangle <?,?>,<?,?>
   rec2 rectangle <?,?>,<?,?>

; ===============================================
section '.text' code readable executable

start:
    ; Get coordinates for first rectangle
	call read_hex
	mov dword[rec1.A.x],eax
	call read_hex
	mov dword[rec1.A.y],eax
	
	call read_hex
	mov dword[rec1.C.x],eax
	call read_hex
	mov dword[rec1.C.y],eax
    
    ; in this exercise i was forced
    ; to only use 2 points, so i
    ; got the difference between them

    ; get height
	mov ebx, dword [rec1.C.y]
	sub ebx, dword [rec1.A.y]
    ; get width
	mov eax, dword [rec1.C.x]
	sub eax, dword [rec1.A.x]

    ; store area, could also use esi/edi
	mul ebx
	mov dword[rec1.area], eax

    ; Get coordinates for second rectangle
	call read_hex
	mov dword[rec2.A.x],eax
	call read_hex
	mov dword[rec2.A.y],eax
	
	call read_hex
	mov dword[rec2.C.x],eax
	call read_hex
	mov dword[rec2.C.y],eax
    
    ; get height
	mov ebx, dword [rec2.C.y]
	sub ebx, dword [rec2.A.y]
    ; get width
	mov eax, dword [rec2.C.x]
	sub eax, dword [rec2.A.x]

    ; store area, could also use esi/edi
	mul ebx
	mov dword[rec2.area], eax
    
	call print_delimiter

    ; eax has rec2's area, set it to the biggest
	cmp eax,dword[rec1.area]
	jl print_rec1_area
	mov ebx,eax	; store rec2's area

	mov eax,0
	call print_eax ; print 0
	
	mov eax,ebx
	call print_eax ; print rec2'x area
    
	jmp end_program

print_rec1_area:
	mov eax,1
	call print_eax

	mov eax, dword[rec1.area]
	call print_eax

end_program:
    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
