; Basic Assembly
; ==============
; 
; Memory
; ------
;
; Template
; @@@@@@@@
;

format PE console
entry start

include 'win32a.inc' 


; This is the data section:
; ===============================================
section '.data' data readable writeable
  nums  dd  23h,75h,111h,0abch,443h,1000h,5h,2213h,433a34h,0deadbeafh
  end_of_nums:
; This is the bss section:
; ===============================================
section '.bss' readable writeable
  closest_number dd ?

; This is the text section:
; ===============================================
section '.text' code readable executable

start:
   mov	    edi, (end_of_nums - nums) / 4 ; size of array
   mov	    esi,1 ; index 
   
   call	    read_hex ; eax has the input
   mov	    ebx,eax ; store the input 
   
   mov ecx,dword[nums]
   mov dword[closest_number],ecx ; set first number as closest

   ; setting it to -1 didnt work, im going insane
   sub eax, ecx ; subtract input
   test eax,eax ; check if negative
   jns is_positive
   neg eax ; turn positive
   is_positive:
   mov edx,eax ; store
    
check_nums:
   mov	    eax,ebx ; get input number
   mov	    ecx,dword[nums + 4*esi] ; get curr number
   
   sub	    eax,ecx ; get difference
   cmp	    eax,0 ; check if negative
   jge	    is_not_negative
   neg	    eax ; get absolute value
is_not_negative:
   cmp	    eax,edx
   jg	    is_not_smaller
   mov	    edx,eax ; set the new difference
   mov	    dword [closest_number],ecx ; set new closest num
is_not_smaller:
   inc	    esi ; increment index
   cmp	    esi,edi ; check is arr ended
   jne	    check_nums ; continue loop

   mov	    eax,dword[closest_number] ; print closest value
   call	    print_eax

   ; Exit the process:
   push	    0
   call	    [ExitProcess]


include 'training.inc'
