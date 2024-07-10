;AlphabetUpperAndLower.asm
;Made by Ricko/Ricardo 
;2021

include C:\Users\ricar\Desktop\emu8086\inc\emu8086.inc

.model small

.data

temp db 26 dup(0)

.code

; this macro closes the program using the DOS
closeprogram MACRO
    
    ;could use hlt      
    mov ah,4ch
    int 21h          
          
closeprogram endm    

proc main
    mov ax,@data
    mov ds,ax
    mov es,ax
    
    cld
    
    mov ah,2
    
    ;prints from A to Z
    mov al,'A'
    
    mov cx,26
    
    lea di,temp
     
    forUpper:stosb
            inc al 
            loop forUpper
    
    call print_string
    
    ;adds new line
    putc 10
    putc 13
    
    ;prints from a to z
    mov al,'a'
    mov cx,26
    
    lea di,temp
    
    forLower:stosb
            inc al
            loop forLower

    call print_string
    
    closeprogram
     
main endp    

DEFINE_PRINT_STRING

end