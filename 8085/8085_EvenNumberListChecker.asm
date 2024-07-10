;EvenNumberListChecker.asm

.model small

.data
welcomemsg db 'write 5 numbers: ',10,13,'>','$'

finalmsg db 10,13,'the even numbers are: ','$'         

input db 5 dup(?)
  len = ($-input)

output db 1 dup(?)

.stack 100h
.code

;this macro prints a char using DOS interrupt

;@params msg

displaymsg MACRO msg
  
    mov ah,9
    lea dx, msg
    int 21h 
    
    endm

main proc
    mov ax,@data
    mov ds,ax
    
    call user_req
    call user_input
    call test_even
    call user_output  
    
    ;stops program
    mov ah,4ch
    int 21h
    
    endp  

;--------------------------

user_req proc near
    
    displaymsg welcomemsg
    
    ret   
    user_req endp 

;--------------------------

user_input proc near

    mov cx,len
    xor si,si
    mov ah,1
    xor bl,bl
   
    ;asks and stores input
    forinput:int 21h        
         mov bl,al 
         sub bl,30h
         mov input[si],bl
         inc si
         loop forinput
    ret       
    user_input endp 

;--------------------------

test_even proc near
    
    xor bl,bl
    xor si,si
    xor di,di
    mov cx,len
   
    for_eventest:
        ;AND bitmask without storing
        test input[si],1h
        jnz ifeven
        
        mov bl,input[si]
        mov output[di],bl
        inc di
    
    ifeven:
    
    loop_test_even:
        inc si
        loop for_eventest
    
    ret
    
    test_even endp

;--------------------------

user_output proc near
                                         
    xor si,si
    xor bl,bl
    mov cx,len
    
    displaymsg finalmsg
     
    outputfor:cmp output[si],0
              jne print
        
    outputloop:inc si
               loop outputfor
    
    ret
    
    ;prints even results
    print:
    mov ah,2
    
    mov bl,output[si]
    add bl,30h
    
    mov dl,bl
    int 21h
    
    jmp outputloop
        
    user_output endp

end