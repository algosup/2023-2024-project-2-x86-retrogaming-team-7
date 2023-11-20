org 100h
 
%define SPRITEW 8
section .data

xPos dw 0 
xVelocity dw 1


pacman_right_1  db 0xFF, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04
                db 0x0C, 0x0C, 0xFF, 0x0C, 0x0C, 0x0C, 0x04, 0xFF
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF, 0xFF
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF, 0xFF, 0xFF
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0xFF
                db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF
                db 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C

pacman_right_2  db 0xFF, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0xFF
                db 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF
                db 0x0C, 0x0C, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0x04, 0x04, 0x04
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04
                db 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF

pacman_right_3  db 0xFF, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0xFF
                db 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF
                db 0x0C, 0x0C, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04
                db 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF

pacman_left_1   db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0xFF
                db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF
                db 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0xFF, 0x0C, 0x0C
                db 0xFF, 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0xFF, 0xFF, 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C
                db 0xFF, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF

pacman_left_2   db 0xFF, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0xFF
                db 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x04, 0x04, 0x04, 0x04, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04
                db 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF

pacman_left_3   db 0xFF, 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0xFF
                db 0xFF, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0xFF, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C
                db 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x04
                db 0xFF, 0x04, 0x0C, 0x0C, 0x0C, 0x0C, 0x04, 0xFF

section .text
 
   mov ah, 00h  ; Set video mode
   mov al, 13h  ; Set video mode 13h (320x200 256 colors)
   int 10h       ; Call BIOS interrupt

    ; Clear the screen to black
    mov al, 0xFF        ;Color to fill
    call clearScreen    ;Call the function

gameloop:

    ; If ghost goes to the right, then display pacman_right_1
    cmp word [xVelocity], 1
    jne .ghost_left
    mov si, pacman_right_1
    jmp .display_ghost
    
    .ghost_left:
    mov si, pacman_left_1

    .display_ghost:
    mov di, [xPos]
    mov bx, 0x0C
    call displayGhost
;waiting...
    mov cx, 0xFFFF  ;wait 1/10 of a second
    waitloop1:      ;this is a loop label
    loop waitloop1  ;loop until cx = 0
    mov cx, 0x0001  ;wait 1/10 of a second
    waitloop2:      ;this is a loop label
    loop waitloop2  ;loop until cx = 0
    mov cx, 0x0001  ;wait 1/10 of a second
    waitloop3:      ;this is a loop label
    loop waitloop3  ;loop until cx = 0
    mov cx, 0x0001  ;wait 1/10 of a second
    waitloop4:      ;this is a loop label
    loop waitloop4  ;loop until cx = 0
    

;erase the ghost
    mov al, 0xFF
    call clearGhost

;change the position
    mov bx, [xPos]
    add bx, [xVelocity]
    mov [xPos], bx

;change direction
    cmp word [xPos],320 - SPRITEW
    jb .noflip
    neg word [xVelocity]
    .noflip:
    jmp gameloop


;reset the keyboard buffer and then wait for a keypress :
   mov ax, 0C01h ;
   int 21h
 
;dos box default video mode
   mov ax, 03h
   int 21h
 
   int 20h ;quit





;THE FUNCTIONS :

;!!!PARAMETERS!!!;
;to select the color to use to fill, you need this color into 'al'
clearScreen:
mov bx, 0xA000
mov es, bx
mov di, 0
mov cx, 200*320
rep stosb
ret 

;!!!PARAMETERS!!!;
;to select the color to use to fill, you need this color into 'al'
;to select the sprite to print, you need to put the sprite address in 'si'
clearGhost:
mov di, [xPos]
push ax
mov ax, 0xA000
mov es, ax
pop ax
mov dx, 8
.eachLine:
    mov cx, 8
    rep stosb
    add di, 320-8
    dec dx
    jnz .eachLine
ret

;!!!PARAMETERS!!!;
;to select the sprite to print, you need to put the sprite address in 'si'
;to select the position to display, you need to put the position in 'di'
;to select the color of the ghost , you need to put the color into 'bx'
displayGhost:
mov ax, 0xA000
mov es, ax
mov dx, 8
       eachLine:
       mov cx, 8
       rep movsb
       add di, 320-8
       dec dx
       jnz eachLine
ret