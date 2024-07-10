;MaxNumTwoDimensionArray.asm
;Made by Ricardo/Ricko
;2021

.model small

.data

;Example array in decimal
; _______________
;| 2 | 5 | 6 | 8 |
;|16 | 9 | 4 | 5 |
;|21 |20 | 12| 1 |
;|___|___|___|___|

arr db 2h,5h,6h,8h
    db 10h,9h,4h,5h
    db 15h,14h,10h,1h
    len = ($-arr)

maxElement db ?
      
.code

proc main

mov ax,@data
mov ds,ax

;clears reg max(AL), row(BX) and collumn(SI)
xor al,al
xor bx,bx

for_setcol:
;checks collumn out of bounds
cmp bx,len 
je endf

xor si,si

for:
;checks row out of bounds    
cmp si,4
je w_changecol

cmp arr[bx][si],al
jna lp

;sets the max
mov al,arr[bx][si]
lp:inc si
   jmp for

w_changecol:
add bx,si
jmp for_setcol

endf:
mov maxElement,al
hlt

main endp    

end