format PE console
entry start

include 'win32a.inc' 

section '.data' data writeable readable
    keep_nums dd 5 dup(0)

section '.text' code readable executable

start:
mov ecx,5

read_one_number:
dec ecx
call read_hex
mov esi,ecx
shl esi,2
add esi,keep_nums
mov dword[esi], eax
test ecx,ecx
jnz read_one_number

mov edi,5d
mov ecx,0
print_one_number:
mov esi,ecx ; get index
shl esi,2 ; multiply by 4
add esi,keep_nums ; add base address
mov eax, dword[esi] ; store address
call print_eax ; print eax
inc ecx
cmp ecx,edi
jnz print_one_number

; Exit the process:

	push	0
	call	[ExitProcess]

include 'training.inc'
