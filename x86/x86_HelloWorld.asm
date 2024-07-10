format PE console
entry start

include 'win32a.inc' 

section '.data' data readable writeable
output_text db 'Hello World!',13,10,0
; ===============================================
section '.text' code readable executable

start:
   push output_text
   call	 [printf]
   add	 esp,8

   push	 0
   call	 [ExitProcess] 

section '.idata' import data readable

library	 kernel,'kernel32.dll', \
	 msvcrt, 'msvcrt.dll'

import	 msvcrt,\ 
	 printf, 'printf'

import	 kernel, \
	 ExitProcess, 'ExitProcess'
