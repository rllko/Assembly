format PE console
entry start
;introduce syntax
include 'win32a.inc' 

section '.data' data readable writeable
my_nums dd 1,6,3,2,11h,3,9,17h,5h,14h
ARR_SIZE = ($ - my_nums) / 4 
;for the actual code
section '.text' code readable executable

start: ; get arr size
   mov esi,ARR_SIZE
   
   lea edi,[my_nums] ; get array base
   xor ecx,ecx ; 0 is the biggest number
   xor edx,edx ; index

check_num: ; START LOOP 
   mov ebx,dword[edi + 4*edx] ; calculate current number
   cmp ecx,ebx ; compare to biggest number
   jae not_biggest_number ; if smaller, take the jump
   mov ecx,ebx ; if not, make that the new biggest
not_biggest_number:
   inc edx ; increment index
   cmp edx,esi ; compare to arr size
   jnz check_num ; continue loop if not
   ; END LOOP

   mov eax, ecx
   call print_eax

   push 0 ; leave 
   call [ExitProcess]

include 'training.inc'
