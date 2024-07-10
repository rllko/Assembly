format PE console
entry start

include 'win32a.inc' 

section '.data' data readable writeable
    arr	    dd      5,8,143h,0,0fah,32h,45h,191h,14h,0,8h,13h,17h
    ARR_SIZE = ($ - arr) / 4

    curr_esp db 'current value of ESP:',0
    max_val_in_arr db 'max value in arr:',0

; ===============================================
section '.text' code readable executable

start:
    ; prints curr esp address
    mov esi, curr_esp
    call print_str 
    mov eax,esp
    call print_eax

    ; prints max value in arr
    mov esi,max_val_in_arr
    call print_str
    
    mov esi,arr
    mov ecx,ARR_SIZE 
    call get_max
    call print_eax
    
    ; prints curr esp address  
    mov esi, curr_esp
    call print_str 
    mov eax,esp
    call print_eax 
    
    ; Exit the process:
    push    0
    call    [ExitProcess]

; ==========================
; Input:
;   esi -- address of array of dwords.
;   ecx -- Amount of dwords in the array.
; Output:
;   eax -- Largest dword in the array (Maximum).
get_max:
    xor eax,eax
    push edx ; keep edx to stack
    xor edx,edx ; iterator
.iter:
    cmp dword [esi+4*edx],eax ; compares curr number with new max
    jbe .skip_new_max ; refers to get_max.skip_new_max
    mov eax,dword [esi+4*edx] ; set new max
.skip_new_max:
    inc edx ; increment index
    cmp edx,ecx ; check with array size
    jnz .iter ;  refers to get_max.iter
    pop edx ; restores edx
.end_func:
    ret

include 'training.inc'
