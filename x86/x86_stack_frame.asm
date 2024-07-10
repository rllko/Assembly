format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
   push 	1
   push 	2
   call 	example_func

   push 	0
   call 	[ExitProcess]

example_func:
   enter 	0,0
; enter will replace the process of creating prologue
; push ebp
; mov ebp,esp
; add esp,4 * 3

; IMO using the ebp as a reference is easier
   push 	3
   push 	4
; [ebp] -> old EBP
; [ebp + 4 ] -> accessing return address
; [ebp + 4 + 4 * n ] -> accessing parameters

; [ebp - 4] accessing the first local variable
; [ebp - 4 * n] accessing the n local variable

; leave will replace the process of elilogue
; sub esp,4 * 3 or mov esp,ebp
; pop ebp
; ret
leave

include 'training.inc'
