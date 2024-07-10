;StackExercise.asm
;Made by Ricko/Ricardo
;2021

.model small

.data
arr dw 1,2,3,4,5,6,7
       len = ($-arr)/2

.stack 100h

.code 
 
main proc

mov ax,@data
mov ds,ax

xor si,si

mov cx,len/2

;pushes array to stack 

for_send:push arr[si]
add si,2
loop for_send

mov cx,len
xor si,si

;takes numbers from stack 

for_retrieve:pop arr[si]
add si,2
loop for_retrieve

ret

end