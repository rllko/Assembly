;HelloWorld.asm
;Made by Ricardo/Ricko

include C:\Users\ricar\Desktop\emu8086\inc\emu8086.inc

.model small

.data
;could achieve the expected result using lea or mov
word db 'H','E','L','L','O',' ','W','O','R','L','D','!'
        len = ($-word)
.code

proc main
    
    ;loads data
    mov ax,@data
    mov ds,ax
    
    lea si,word
    
    mov cx,len

    call print_string
    
    ;stops program 
    mov ah,4ch
    int 21h
    
main endp    
DEFINE_PRINT_STRING
end

    ;>a manual way without using the library<
    
    ;printc MACRO char
    
    ;mov ah,2
    ;mov dx,char
    ;int 21h

    ;printc endm
    
    ;xor si,si
    
        ;for:printc word[si]
            ;inc si
            ;loop for
     