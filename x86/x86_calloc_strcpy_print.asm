format PE console
entry start

include 'win32a.inc' 

section '.data' data readable writeable
output_text db 'Dwuck likes boys!',13,10,0
output_text_len = $ - output_text
str_format1 db '%s',0
; ===============================================
section '.text' code readable executable

start:
   xor eax,eax

   push output_text_len
   call [malloc]
   mov esp,ebp

   mov esi,output_text
   mov edi,eax
   mov ecx,output_text_len
   rep movsb

   push eax
   push str_format1
   call	 [printf]
   add	 sp,8

   push eax
   call [free]
   add esp,8

   push	 0
   call	 [ExitProcess] 

section '.idata' import data readable

library	 kernel,'kernel32.dll', \
	 msvcrt, 'msvcrt.dll'

import	 msvcrt,\ 
	 malloc, 'malloc', \
	 printf, 'printf', \
	 free, 'free'

import	 kernel, \
	 ExitProcess, 'ExitProcess'
