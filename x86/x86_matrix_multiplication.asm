format PE console
entry start

include 'win32a.inc' 

MATRIX_HEIGHT EQU 2
MATRIX_WIDTH EQU 2

struct MATRIX
   a11 dd ?
   a12 dd ?
   a21 dd ?
   a22 dd ?
ends

section '.data' data readable writeable
 matrix1 MATRIX 1,1,1,0
 matrix2 MATRIX 1,1,1,0

; ===============================================
section '.text' code readable executable

start:
push matrix2
push matrix1
call multiply_matrix
add esp,8

push 0
call [ExitProcess]
;input: matrix1, matrix2
;multiply_matrix(matrix1,matrix2)
;output: need to find a way to store it later, ran out of registers
multiply_matrix:
push ebp
mov ebp,esp
sub esp,4

mov esi, dword[ebp + 8   + 4] ; matrix1
mov edi, dword[ebp + 4   + 4] ; matrix2
.firstloop:
xor ecx,ecx
xor ebx,ebx

.secondloop:
xor edx,edx

mov eax,dword [esi + 4*ecx] ; mov first column
mul dword[edi + 4*ecx] ; mov second column

add dword [ebp-4],eax ; store result

inc ecx
cmp ecx,MATRIX_WIDTH
jnz .secondloop

inc ebx
cmp ebx,MATRIX_HEIGHT
jnz .firstloop

mov esp,ebp
pop ebp
ret 

include 'training.inc'
