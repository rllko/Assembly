.model small

.data

msg db 10,13,'please enter a char',10,13,'>','$'
msgfoun db 10,13,10,13,'you lucky, you found the number ','$'
msgwrong db 10,13,10,13,'unlucky, wrong char',10,13,'$'
msgquit db 10,13,'do you wanna quit?',10,13,'>','$'
msgerror db 10,13,'invalid char, type again',10,13,'$'
msgclose db 10,13,10,13,'--Program ended--','$'

.code

proc main
    
mov ax,@data
mov ds,ax

;program loop
repeat:

;display initial msg
mov ah,9
lea dx,msg
int 21h

;user input
mov ah,1
int 21h
mov bl,al

;check if valid
cmp al,30h
jna else
cmp al,35h
jna else

mov ah,9
lea dx,msgfoun
int 21h

;final screen
jmp quit

quit:
mov ah,9
lea dx,msgquit
int 21h

;asks the user to leave
mov ah,1
int 21h

;if 
cmp al,'0'
je repeat
cmp al,'1'
je endf

;else
mov ah,9
lea dx,msgerror
int 21h

jmp quit


;wrong guess 
else:     
mov ah,9
lea dx,msgwrong
int 21h
jmp quit

endf: 
mov ah,9
lea dx,msgclose
int 21h

mov ah,4ch
int 21h
ret

main endp    

end