format PE console
entry start

include 'win32a.inc' 

section '.data' data readable writeable
 my_arr dd 4,8,1,9,23h,41h,15h,13h,44h
 MY_ARR_LEN = ($ - my_arr) / 4
; ===============================================
section '.text' code readable executable

start:
   push		my_arr
   push		MY_ARR_LEN
   call 	sort_array

   push 	0
   call 	[ExitProcess]

; input: [ebp+8] = len , [ebp + c] = array
; operation: sorts an array using bubblesort
; calling convention: stdcall
;
sort_array:
push 	ebp ; could be achieved using 'enter 0,0'
mov 	ebp,esp
sub 	esp,4 ; create room for temp variable

push 	ebx ; ebp - 4  = ebx -> going to be used for i
push 	edi ; ebp - 8  = edi
push 	esi ; ebp - c = esi
push	edx
cmp 	dword[ebp+8],0
jz 	.end_func

mov 	ebx,[ebp+0ch] ; arr
xor 	eax,eax ; clear j
xor 	edx,edx
jmp 	.second_loop
.first_loop:
xor 	eax,eax

inc  	edx ; i += 1
cmp edx,[ebp+8]
jz .end_func

add 	ebx,4 ; i = i + 1

.second_loop:
cmp 	eax,[ebp+8] ; check if done
jz 	.first_loop

mov 	esi,[ebx + 4*eax] ; arr[j] 
mov 	edi,[ebx + 4*eax +4] ; arr[j+1]

cmp 	esi,edi ; if arr[j] > arr[j+1]
jng 	.next_element ; jump if not
 
mov 	dword [ebx+4*eax+4],esi ; arr[j+1] = arr[j]
mov 	dword [ebx+4*eax],edi ; arr[j] = arr[j+1]

.next_element:
inc 	eax ; inc j
jmp 	.second_loop

.end_func:
pop	edx
pop	esi
pop 	edi
pop 	ebx ; restore registers

mov 	esp,ebp
pop 	ebp ; could be achieved using 'leave'
ret

include 'training.inc'
