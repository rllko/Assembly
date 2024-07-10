;weird bug on the micro processor 8086
;if you push a value after doing an operation in a special process/on the special segment
;the instruction pointer will point to that pushed value and not the one desired

.model small
.data

.stack 100h
.code

;what this program does

main proc

mov dx,3
mov cx,5
mov bp,sp
;bp = Base pointer
;sp = Stack pointer

push dx
push cx

call addition

pop dx
hlt
endp  

addition proc
    
    
    mov ax,[bp-2]             
    mov bx,[bp-4]
    
    add bx,ax
    push bx
    
    push 13
    
    
    ret         
addition endp

end
