format PE console
entry start

include 'win32a.inc' 

section '.data' data readable executable
 example_str db 'hi, im an example string',0
; ===============================================
section '.text' code readable executable

start:
   push 	example_str
   call 	example_func

   push 	0
   call 	[ExitProcess]

example_func:
   enter 	0,0

   mov 		esi,[ebp+8] ; get string from parameters
   push 	esi ; push string
   call 	[printf] ; print it
   leave 	; check stack frame file for more info
   ret

include 'training.inc'
