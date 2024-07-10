format PE console
entry start

include 'win32a.inc' 
section '.data' data readable writeable
 exe_name	db		'AssaultCube',0
 hwnd		dd		0
 procid		dd		0
 prochandle	dd		0
 msg		db		'Assault cube PID: %llu',0
; ===============================================
section '.text' code readable executable

start:

invoke FindWindowA,0,exe_name ; get window
mov dword [hwnd],eax ; store handle value
invoke GetWindowThreadProcessId,[hwnd],procid ; get proc id
invoke OpenProcess,PROCESS_ALL_ACCESS, 0, [procid] ; get handle to the process
mov dword[prochandle],eax ; score handle

cinvoke printf,msg,[procid] ; print pid
invoke ExitProcess,0 ; exit
; i need to finish this later, add read process memory
;==========================================
section '.idata' data import readable writeable

library kernel,'kernel32.dll', \
	user, 'user32.dll', \
	crtdll,'crtdll.dll'

import user, \
	MessageBox,'MessageBoxA', \
	FindWindowA,'FindWindowA', \
	GetWindowThreadProcessId, 'GetWindowThreadProcessId'

import kernel, \
	ExitProcess,'ExitProcess', \
	OpenProcess, 'OpenProcess'

import crtdll, printf,'printf'
