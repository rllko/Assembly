.model small

.data

msg db 'decimal: ','$' 
 
num db 1 dup(0)

.code 
 
proc main
    
mov ax,@data
mov ds,ax    

xor bl,bl
mov ah,1

while:

int 21h

cmp al,13
je endf

;converts into binary
mov cl,al
sub cl, 30h 

;shifts and adds binary
shl bl,1
or bl,cl

jmp while


endf:
;converts number
add bl,30h
mov num,bl

;displays final msg
mov ah,9
lea dx,msg
int 21h
mov ah,2
mov dl,num 
int 21h
mov dl,'d'
int 21h
    

end