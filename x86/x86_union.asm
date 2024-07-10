format PE console
entry start
;introduce syntax
include 'win32a.inc' 
; for initialized data

;struct -> size 8 bytes
struct PNT
   x dd ? ; 4 bytes / dword / unsigned long
   y dd ? ; 4 bytes / dword / unsigned long
ends
; union -> size 4 bytes
struct PNTU
   union ; its a union, so it can only be one
      x dd ? ; x = 4 ; y = 0
      y dd ? ; x = 0; y = 4
   ends
ends

section '.data' data readable writeable	
   unionu1 PNTU ?
   union1 PNT ?
;for uninitialized data
;section '.bss' readable writeable

;for the actual code
section '.text' code readable executable

start: ; test
   ; set union x to 2
   mov dword [unionu1.x],2
   ; will print just fine
   mov eax,dword [unionu1.x]
   call print_eax

   ; set union y to 4
   mov dword[unionu1.y],4
   ; now union x is 4
   mov eax, dword [unionu1.x]
   call print_eax
   ;working as intended
   push 0
   call [ExitProcess]

include 'training.inc'
