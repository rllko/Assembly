format PE console
entry start
; shout out xorpd for the exercise idea
include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    space           db  ' ',0
    star            db  '*',0
    newline         db  13,10,0

    enter_wanted    db  'Enter wanted size of square: ',0

; ===============================================
section '.text' code readable executable

start:
    mov esi,enter_santed
    call print_str

    mov ecx,eax ; ecx is passed as parameter
    call print_square

    ; Exit the process:
	push	0
	call	[ExitProcess]

; ======================================================
; Input:
;   ecx -- size of square. (ecx >= 2)
; Operation:
;   Prints a square made of stars of size ecx to the console.
;
print_square:
  push	esi ; store registers
  push	edi

  cmp	ecx,2 ; if its smaller than two, leave
  jb	.end_loop

  mov	ecx,edi ; store ecx

  call	print_full_line ; print first line

  sub	edi,2
  test	edi,edi
  jz	.after_hollow ; if ecx is bigger than 2, print hollow

.next_hollow:
  call print_hollow_line
  dec edi
  jnz .next_hollow

.after_hollow:
  call	print_full_line ; print last line

.end_loop:
  pop	edi
  pop	esi
  ret
; ========================================================
; Input:
;   ecx -- size of line.
; Operation:
;   Prints a line of stars of size ecx to the console.
; 
print_full_line:
  push	esi
  push	ecx ; store registers

.next_line:
  mov	esi,star ; print each star
  call	print_str
  loop	.next_line

  mov	esi,newline ; print new line
  call	print_str

  pop	ecx 
  pop	esi ; restore registers
  ret
; ==========================================================
; Input: 
;   ecx -- size of line. (ecx >= 2)
; Operation:
;   Prints a hollow line of stars of size ecx to the console.
; 
print_hollow_line:
  push	ecx
  push	esi
  
  cmp	ecx,2
  jb	.end_func ; if ecx smaller than 2, leave

  mov	esi,star
  call	print_str ; print first star

  sub	ecx,2 ; if is exactly two, no spaces needed
  jecxz .after_spaces

.next_space: ; print spaces
  mov	esi,space
  call	print_str
  loop	.next_star

.after_spaces:
  mov	esi,star
  call	print_esi ; print last star

  mov	esi,newline
  call	print_str ; print new line

.end_func:
  pop	esi
  pop	ecx
  ret

include 'training.inc'
