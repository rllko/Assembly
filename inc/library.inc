;this macro adds two numbers
;@params num1,num2 word
;@return word

addtwo MACRO num1, num2

LOCAL lab

    lab:mov al,num2
        add num1,al   
     
    addtwo endm   

;this macro prints a char using DOS
;@params char byte

printc MACRO char 
    
    mov ah,2
    mov dl,char
    int 21h
        
    printc endm