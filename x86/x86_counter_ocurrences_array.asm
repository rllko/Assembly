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
most_used_number db 0
number_times_used db 0

; This is the bss section:
; ===============================================
section '.bss' readable writeable
arr db 100 dup(?)

; This is the text section:
; ===============================================
section '.text' code readable executable

start:
   call read_hex
   mov edi,eax  ;store n into ebx

   mov esi, arr ; get arr address
   xor ecx,ecx  ; counter

get_numbers:
   call read_hex
   ; i'm aware that 
   mov byte[esi + ecx * 2],al ; 0 <= input <= ff

   inc	    ecx
   cmp	    ecx,edi
   jnz	    get_numbers

   xor	    ebx,ebx  ; i = 0
   xor	    ecx,ecx  ; j = 0
outer_loop: ; BEGIN OUTER LOOP
   mov	    al, byte[esi + ebx * 2] ; al = arr[i]
   xor	    ecx,ecx
inner_loop: ; BEGIN INNER LOOP
   mov	    ah, byte[esi + ecx * 2] ; ah = arr[j] 
   
   cmp	    ah,al ; compare two numbers
   jne	    not_equal
   inc	    dl ; dl = counter
not_equal:
   inc	    ecx        ; j++
   cmp	    ecx,edi    ; j < n
   jne	    inner_loop ; END INNER LOOP

   cmp	    dl, byte[number_times_used] ; check if its most used
   jl	    not_most_used
   mov	    byte[most_used_number],al ; set new biggest num
   mov	    byte[number_times_used],dl ; set most used amount
      not_most_used:
   inc	    ebx        ; i++
   cmp	    ebx,edi    ; i < n
   jne	    outer_loop ; END OUTER LOOP

   movzx    eax, byte[most_used_number]
   call	    print_eax

   push	    0
   call	    [ExitProcess]


include 'training.inc'
