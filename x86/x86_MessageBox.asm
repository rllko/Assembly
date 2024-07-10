format PE console
entry start

include 'win32a.inc' 

section '.data' data readable writeable
 txtTitle 	db 	'Testing testing',0
 txtMessage	db	'Hello From Message box!',0
; ===============================================
section '.text' code readable executable

start:
invoke MessageBox,0,txtMessage,txtTitle,0
invoke ExitProcess,0

;include 'training.inc'

section '.idata' data import readable writeable

library kernel,'kernel32.dll', \
	user, 'user32.dll'

import user, \
	MessageBox,'MessageBoxA' \

import kernel, \
	ExitProcess,'ExitProcess'
