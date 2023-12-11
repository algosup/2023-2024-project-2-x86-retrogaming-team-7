org 100h

[map all pacman.map]

%define SCREEN_WIDTH 320
%define SCREEN_HEIGHT 200


%define SPRITEW 8
%define SPRITEH 8
section .data

xPosBlinky dw 80
xPosInky dw 71
xPosClyde dw 89
xPosPinky dw 98

yPosBlinky dw 80
yPosInky dw 80
yPosClyde dw 80
yPosPinky dw 80

xGVelocity dw 0

spriteBw dw 8
spriteBh dw 8

old_XPOSBlinky dw 0
old_XPOSInky dw 0
old_XPOSClyde dw 0
old_XPOSPinky dw 0

old_YPOSBlinky dw 0
old_YPOSInky dw 0
old_YPOSClyde dw 0
old_YPOSPinky dw 0


currentSpriteBlinky dd blinky_right_1
currentSpriteInky dd inky_right_1
currentSpriteClyde dd clyde_right_1
currentSpritePinky dd pinky_right_1

actualBDirection dw 0
actualIDirection dw 0
actualCDirection dw 0
actualPDirection dw 0

section .text
startG:
    ; Initialize video mode
    mov ah, 00h
    mov al, 13h
    int 10h
    ; main gameloop

    gameloopG:
    call read_character_key_was_pressedG

    ; Delay to slow down the animation
    mov cx, 64000
    waitloopG:
        loop waitloopG
    jmp gameloopG
    ; End game back to text mode
    mov ax, 03h
    int 10h
    mov ax, 4C00h
    int 21h

; Label for read the pressed key
read_character_key_was_pressedG:
    mov ah, 01h        ; Check if a key has been pressed (non-blocking)
    int 16h
    jz continue_movementB ; If no key pressed, continue current movement
    jz continue_movementI ; If no key pressed, continue current movement
    jz continue_movementC ; If no key pressed, continue current movement
    jz continue_movementP ; If no key pressed, continue current movement


clearGhost:
    ; Set up the graphics segment
    mov ax, 0A000h
    mov es, ax

    ; Calculate the screen offset for the old position of the sprite
    mov ax, [old_YPOSBlinky]     ; Get the old Y position
    imul ax, 320           ; Multiply Y position by screen width to get the offset
    add ax, [old_XPOSBlinky]     ; Add the old X position to the offset
    mov di, ax             ; DI = starting address for erasure

    ; Define the height and width of the sprite
    mov cx, SPRITEH        ; Sprite height
.clear_line:
    push cx                ; Save CX as it is modified by the loop
    mov cx, SPRITEW        ; Sprite width for a single line
    mov al, 0              ; Background color (usually black for Pac-Man)
    rep stosb              ; Clear pixels with background color
    pop cx                 ; Restore CX for the next line
    add di, 320 - SPRITEW  ; Adjust DI to the start of the next line
    loop .clear_line       ; Repeat for each line of the sprite
    ret
    
; ==================================================
;               BLINKY MOVEMENTS
; ==================================================

move_rightB:
    mov word [actualBDirection], 4Dh
    call blinky_right
    mov bx, [xPosBlinky]
    add bx, 1
    cmp bx, SCREEN_WIDTH - SPRITEW 
    jae .skip_move_right
    mov [xPosBlinky], bx
.skip_move_right:
    ret

move_leftB:
    mov word [actualBDirection], 4Bh
    call blinky_left
    mov bx, [xPosBlinky]
    sub bx, 1
    cmp bx, 0
    jbe .skip_move_left
    mov [xPosBlinky], bx
.skip_move_left:
    ret

move_upB:
    mov word [actualBDirection], 48h
    call blinky_up
    mov bx, [yPosBlinky]
    sub bx, 1
    cmp bx, 0
    jbe .skip_move_up
    mov [yPosBlinky], bx
.skip_move_up:
    ret

move_downB:
    call blinky_down
    mov bx, [yPosBlinky]
    add bx, 1
    cmp bx, SCREEN_HEIGHT - SPRITEH 
    jae .skip_move_down
    mov [yPosBlinky], bx
.skip_move_down:
    ret

continue_movementB:
    mov al, [actualBDirection]
    cmp al, 4Dh
    je .move_right
    cmp al, 4Bh
    je .move_left
    cmp al, 48h
    je .move_up
    cmp al, 50h
    je .move_down
    ret
    .move_right:
        call move_rightB
        ret
    .move_left:
        call move_leftB
        ret
    .move_up:
        call move_upB
        ret
    .move_down:
        call move_downB
        ret
    ret

; ==================================================
;               BLINKY ANIMATIONS
; ==================================================

blinky_right:
    cmp word [currentSpriteBlinky], blinky_right_1
    je .blinkyRightSemiOpen
    cmp word [currentSpriteBlinky], blinky_right_2
    je .blinkyRightOpen
    cmp word [currentSpriteBlinky], blinky_right_3
    je .blinkyRightClose

    .blinkyRightOpen:
       mov word [currentSpriteBlinky], blinky_right_1
       mov si, [currentSpriteBlinky]
       ret
    .blinkyRightSemiOpen:
        mov word [currentSpriteBlinky], blinky_right_2
        mov si, [currentSpriteBlinky]
        ret
    .blinkyRightClose:
        mov word [currentSpriteBlinky], blinky_right_3
        mov si, [currentSpriteBlinky]
        ret

blinky_left:
    cmp word [currentSpriteBlinky], blinky_left_1
    je .blinkyLeftSemiOpen
    cmp word [currentSpriteBlinky], blinky_left_2
    je .blinkyLeftClose
    cmp word [currentSpriteBlinky], blinky_left_3
    je .blinkyLeftOpen

    .blinkyLeftOpen:
       mov word [currentSpriteBlinky], blinky_left_1
       mov si, [currentSpriteBlinky]
       ret
    .blinkyLeftSemiOpen:
        mov word [currentSpriteBlinky], blinky_left_2
        mov si, [currentSpriteBlinky]
        ret
    .blinkyLeftClose:
        mov word [currentSpriteBlinky], blinky_left_3
        mov si, [currentSpriteBlinky]
        ret

blinky_up:
    cmp word [currentSpriteBlinky], blinky_up_1
    je .blinkyUpSemiOpen
    cmp word [currentSpriteBlinky], blinky_up_2
    je .blinkyUpClose
    cmp word [currentSpriteBlinky], blinky_up_3
    je .blinkyUpOpen

    .blinkyUpOpen:
       mov word [currentSpriteBlinky], blinky_up_1
       mov si, [currentSpriteBlinky]
       ret
    .blinkyUpSemiOpen:
        mov word [currentSpriteBlinky], blinky_up_2
        mov si, [currentSpriteBlinky]
        ret
    .blinkyUpClose:
        mov word [currentSpriteBlinky], blinky_up_3
        mov si, [currentSpriteBlinky]
        ret
    
blinky_down:
    cmp word [currentSpriteBlinky], blinky_down_1
    je .blinkyDownSemiOpen
    cmp word [currentSpriteBlinky], blinky_down_2
    je .blinkyDownClose
    cmp word [currentSpriteBlinky], blinky_down_3
    je .blinkyDownOpen

    .blinkyDownOpen:
       mov word [currentSpriteBlinky], blinky_down_1
       mov si, [currentSpriteBlinky]
       ret
    .blinkyDownSemiOpen:
        mov word [currentSpriteBlinky], blinky_down_2
        mov si, [currentSpriteBlinky]
        ret
    .blinkyDownClose:
        mov word [currentSpriteBlinky], blinky_down_3
        mov si, [currentSpriteBlinky]
        ret

; ==================================================
;               INKY MOVEMENTS
; ==================================================

move_rightI:
    mov word [actualIDirection], 4Dh
    call inky_right
    mov bx, [xPosInky]
    add bx, 1
    cmp bx, SCREEN_WIDTH - SPRITEW 
    jae .skip_move_right
    mov [xPosInky], bx
.skip_move_right:
    ret

move_leftI:
    mov word [actualIDirection], 4Bh
    call inky_left
    mov bx, [xPosInky]
    sub bx, 1
    cmp bx, 0
    jbe .skip_move_left
    mov [xPosInky], bx
.skip_move_left:
    ret

move_upI:
    mov word [actualIDirection], 48h
    call inky_up
    mov bx, [yPosInky]
    sub bx, 1
    cmp bx, 0
    jbe .skip_move_up
    mov [yPosInky], bx
.skip_move_up:
    ret

move_downI:
    call inky_down
    mov bx, [yPosInky]
    add bx, 1
    cmp bx, SCREEN_HEIGHT - SPRITEH 
    jae .skip_move_down
    mov [yPosInky], bx
.skip_move_down:
    ret

continue_movementI:
    mov al, [actualIDirection]
    cmp al, 4Dh
    je .move_right
    cmp al, 4Bh
    je .move_left
    cmp al, 48h
    je .move_up
    cmp al, 50h
    je .move_down
    ret
    .move_right:
        call move_rightI
        ret
    .move_left:
        call move_leftI
        ret
    .move_up:
        call move_upI
        ret
    .move_down:
        call move_downI
        ret
    ret
    
; ==================================================
;               INKY ANIMATIONS
; ==================================================

inky_right:
    cmp word [currentSpriteInky], inky_right_1
    je .inkyRightSemiOpen
    cmp word [currentSpriteInky], inky_right_2
    je .inkyRightOpen
    cmp word [currentSpriteInky], inky_right_3
    je .inkyRightClose

    .inkyRightOpen:
       mov word [currentSpriteInky], inky_right_1
       mov si, [currentSpriteInky]
       ret
    .inkyRightSemiOpen:
        mov word [currentSpriteInky], inky_right_2
        mov si, [currentSpriteInky]
        ret
    .inkyRightClose:
        mov word [currentSpriteInky], inky_right_3
        mov si, [currentSpriteInky]
        ret

inky_left:
    cmp word [currentSpriteInky], inky_left_1
    je .inkyLeftSemiOpen
    cmp word [currentSpriteInky], inky_left_2
    je .inkyLeftClose
    cmp word [currentSpriteInky], inky_left_3
    je .inkyLeftOpen

    .inkyLeftOpen:
       mov word [currentSpriteInky], inky_left_1
       mov si, [currentSpriteInky]
       ret
    .inkyLeftSemiOpen:
        mov word [currentSpriteInky], inky_left_2
        mov si, [currentSpriteInky]
        ret
    .inkyLeftClose:
        mov word [currentSpriteInky], inky_left_3
        mov si, [currentSpriteInky]
        ret

inky_up:
    cmp word [currentSpriteInky], inky_up_1
    je .inkyUpSemiOpen
    cmp word [currentSpriteInky], inky_up_2
    je .inkyUpClose
    cmp word [currentSpriteInky], inky_up_3
    je .inkyUpOpen

    .inkyUpOpen:
       mov word [currentSpriteInky], inky_up_1
       mov si, [currentSpriteInky]
       ret
    .inkyUpSemiOpen:
        mov word [currentSpriteInky], inky_up_2
        mov si, [currentSpriteInky]
        ret
    .inkyUpClose:
        mov word [currentSpriteInky], inky_up_3
        mov si, [currentSpriteInky]
        ret
        
inky_down:
    cmp word [currentSpriteInky], inky_down_1
    je .inkyDownSemiOpen
    cmp word [currentSpriteInky], inky_down_2
    je .inkyDownClose
    cmp word [currentSpriteInky], inky_down_3
    je .inkyDownOpen

    .inkyDownOpen:
       mov word [currentSpriteInky], inky_down_1
       mov si, [currentSpriteInky]
       ret
    .inkyDownSemiOpen:
        mov word [currentSpriteInky], inky_down_2
        mov si, [currentSpriteInky]
        ret
    .inkyDownClose:
        mov word [currentSpriteInky], inky_down_3
        mov si, [currentSpriteInky]
        ret

; ==================================================
;                CLYDE MOVEMENTS  
; ==================================================

move_rightC:
    mov word [actualCDirection], 4Dh
    call inky_right
    mov bx, [xPosClyde]
    add bx, 1
    cmp bx, SCREEN_WIDTH - SPRITEW 
    jae .skip_move_right
    mov [xPosClyde], bx
.skip_move_right:
    ret

move_leftC:
    mov word [actualCDirection], 4Bh
    call inky_left
    mov bx, [xPosClyde]
    sub bx, 1
    cmp bx, 0
    jbe .skip_move_left
    mov [xPosClyde], bx
.skip_move_left:
    ret

move_upC:
    mov word [actualCDirection], 48h
    call inky_up
    mov bx, [yPosClyde]
    sub bx, 1
    cmp bx, 0
    jbe .skip_move_up
    mov [yPosClyde], bx
.skip_move_up:
    ret

move_downC:
    mov word [actualCDirection], 50h
    call inky_down
    mov bx, [yPosClyde]
    add bx, 1
    cmp bx, SCREEN_HEIGHT - SPRITEH 
    jae .skip_move_down
    mov [yPosClyde], bx
.skip_move_down:
    ret

continue_movementC:
    mov al, [actualCDirection]
    cmp al, 4Dh
    je .move_right
    cmp al, 4Bh
    je .move_left
    cmp al, 48h
    je .move_up
    cmp al, 50h
    je .move_down
    ret
    .move_right:
        call move_rightC
        ret
    .move_left:
        call move_leftC
        ret
    .move_up:
        call move_upC
        ret
    .move_down:
        call move_downC
        ret
    ret
; ==================================================
;                CLYDE ANIMATIONS  
; ==================================================

clyde_right:
    cmp word [currentSpriteInky], clyde_right_1
    je .clydeRightSemiOpen
    cmp word [currentSpriteInky], clyde_right_2
    je .clydeRightOpen
    cmp word [currentSpriteInky], clyde_right_3
    je .clydeRightClose

    .clydeRightOpen:
       mov word [currentSpriteInky], clyde_right_1
       mov si, [currentSpriteInky]
       ret
    .clydeRightSemiOpen:
        mov word [currentSpriteInky], clyde_right_2
        mov si, [currentSpriteInky]
        ret
    .clydeRightClose:
        mov word [currentSpriteInky], clyde_right_3
        mov si, [currentSpriteInky]
        ret

clyde_left:
    cmp word [currentSpriteInky], clyde_left_1
    je .clydeLeftSemiOpen
    cmp word [currentSpriteInky], clyde_left_2
    je .clydeLeftClose
    cmp word [currentSpriteInky], clyde_left_3
    je .clydeLeftOpen

    .clydeLeftOpen:
       mov word [currentSpriteInky], clyde_left_1
       mov si, [currentSpriteInky]
       ret
    .clydeLeftSemiOpen:
        mov word [currentSpriteInky], clyde_left_2
        mov si, [currentSpriteInky]
        ret
    .clydeLeftClose:
        mov word [currentSpriteInky], clyde_left_3
        mov si, [currentSpriteInky]
        ret

clyde_up:
    cmp word [currentSpriteInky], clyde_up_1
    je .clydeUpSemiOpen
    cmp word [currentSpriteInky], clyde_up_2
    je .clydeUpClose
    cmp word [currentSpriteInky], clyde_up_3
    je .clydeUpOpen

    .clydeUpOpen:
       mov word [currentSpriteInky], clyde_up_1
       mov si, [currentSpriteInky]
       ret
    .clydeUpSemiOpen:
        mov word [currentSpriteInky], clyde_up_2
        mov si, [currentSpriteInky]
        ret
    .clydeUpClose:
        mov word [currentSpriteInky], clyde_up_3
        mov si, [currentSpriteInky]
        ret
        
clyde_down:
    cmp word [currentSpriteInky], clyde_down_1
    je .clydeDownSemiOpen
    cmp word [currentSpriteInky], clyde_down_2
    je .clydeDownClose
    cmp word [currentSpriteInky], clyde_down_3
    je .clydeDownOpen

    .clydeDownOpen:
       mov word [currentSpriteInky], clyde_down_1
       mov si, [currentSpriteInky]
       ret
    .clydeDownSemiOpen:
        mov word [currentSpriteInky], clyde_down_2
        mov si, [currentSpriteInky]
        ret
    .clydeDownClose:
        mov word [currentSpriteInky], clyde_down_3
        mov si, [currentSpriteInky]
        ret
        
; ==================================================
;                PINKY MOVEMENTS
; ==================================================

    move_rightP:
        mov word [actualPDirection], 4Dh
        call pinky_right
        mov bx, [xPosBlinky]
        add bx, 1
        cmp bx, SCREEN_WIDTH - SPRITEW 
        jae .skip_move_right
        mov [xPosPinky], bx
    .skip_move_right:
        ret

    move_leftP:
        mov word [actualPDirection], 4Bh
        call pinky_left
        mov bx, [xPosPinky]
        sub bx, 1
        cmp bx, 0
        jbe .skip_move_left
        mov [xPosPinky], bx
    .skip_move_left:
        ret

    move_upP:
        mov word [actualPDirection], 48h
        call pinky_up
        mov bx, [yPosPinky]
        sub bx, 1
        cmp bx, 0
        jbe .skip_move_up
        mov [yPosPinky], bx
    .skip_move_up:
        ret

    move_downP:
        call pinky_down
        mov bx, [yPosPinky]
        add bx, 1
        cmp bx, SCREEN_HEIGHT - SPRITEH 
        jae .skip_move_down
        mov [yPosPinky], bx
    .skip_move_down:
        ret

    continue_movementP:
        mov al, [actualPDirection]
        cmp al, 4Dh
        je .move_right
        cmp al, 4Bh
        je .move_left
        cmp al, 48h
        je .move_up
        cmp al, 50h
        je .move_down
        ret
        .move_right:
            call move_rightP
            ret
        .move_left:
            call move_leftP
            ret
        .move_up:
            call move_upP
            ret
        .move_down:
            call move_downP
            ret
        ret

; ==================================================
;               PINKY ANIMATIONS
; ==================================================

pinky_right:
    cmp word [currentSpritePinky], pinky_right_1
    je .pinkyRightSemiOpen
    cmp word [currentSpritePinky], pinky_right_2
    je .pinkyRightOpen
    cmp word [currentSpriteInky], pinky_right_3
    je .pinkyRightClose

    .pinkyRightOpen:
       mov word [currentSpritePinky], pinky_right_1
       mov si, [currentSpritePinky]
       ret
    .pinkyRightSemiOpen:
        mov word [currentSpritePinky], pinky_right_2
        mov si, [currentSpritePinky]
        ret
    .pinkyRightClose:
        mov word [currentSpritePinky], pinky_right_3
        mov si, [currentSpritePinky]
        ret

pinky_left:
    cmp word [currentSpritePinky], pinky_left_1
    je .pinkyLeftSemiOpen
    cmp word [currentSpritePinky], pinky_left_2
    je .pinkyLeftClose
    cmp word [currentSpritePinky], pinky_left_3
    je .pinkyLeftOpen

    .pinkyLeftOpen:
       mov word [currentSpritePinky], pinky_left_1
       mov si, [currentSpritePinky]
       ret
    .pinkyLeftSemiOpen:
        mov word [currentSpritePinky], pinky_left_2
        mov si, [currentSpritePinky]
        ret
    .pinkyLeftClose:
        mov word [currentSpritePinky], pinky_left_3
        mov si, [currentSpritePinky]
        ret

pinky_up:
    cmp word [currentSpritePinky], pinky_up_1
    je .pinkyUpSemiOpen
    cmp word [currentSpritePinky], pinky_up_2
    je .pinkyUpClose
    cmp word [currentSpritePinky], pinky_up_3
    je .pinkyUpOpen

    .pinkyUpOpen:
       mov word [currentSpritePinky], pinky_up_1
       mov si, [currentSpriteInky]
       ret
    .pinkyUpSemiOpen:
        mov word [currentSpritePinky], pinky_up_2
        mov si, [currentSpritePinky]
        ret
    .pinkyUpClose:
        mov word [currentSpritePinky], pinky_up_3
        mov si, [currentSpritePinky]
        ret
        
pinky_down:
    cmp word [currentSpritePinky], pinky_down_1
    je .pinkyDownSemiOpen
    cmp word [currentSpritePinky], pinky_down_2
    je .pinkyDownClose
    cmp word [currentSpritePinky], pinky_down_3
    je .pinkyDownOpen

    .pinkyDownOpen:
       mov word [currentSpritePinky], pinky_down_1
       mov si, [currentSpritePinky]
       ret
    .pinkyDownSemiOpen:
        mov word [currentSpritePinky], pinky_down_2
        mov si, [currentSpritePinky]
        ret
    .pinkyDownClose:
        mov word [currentSpritePinky], pinky_down_3
        mov si, [currentSpritePinky]
        ret
        
; ==================================================
;                DRAW GHOSTS
; ==================================================

; Label to erase the screen
draw_blinky:
    mov si, [currentSpriteBlinky]
    ; Before draw the sprite, save the current position
    mov ax, [xPosBlinky]
    mov [old_XPOSBlinky], ax  ;Save the old position of X
    mov ax, [yPosBlinky]
    mov [old_YPOSBlinky], ax  ;Save the old position of Y
    ; Reset the graphic segment
    mov ax, 0A000h
    mov es, ax
    ; Cacul the addresse to the screen where the sprite will be draw
    mov ax, [yPosBlinky]
    imul ax, 320       ;  Multiply yPos par the width of screen to get the offset
    add ax, [xPosBlinky]     ; Add xPos to the offset
    mov di, ax         ; DI = address for the draw 
    ; Get the addresses's sprite to draw
    mov cx, SPRITEH     ; Define the sprite's height
.draw_line:
    push cx     ; Save CX else modify by rep
    mov cx, SPRITEW     ; Define the width for the current row
    rep movsb  ; Print the sprite's row
    pop cx  ; Restore CX for the next sprite's row
    ; Adjust DI for the next rows and take in account the width offset
    add di, 320 - SPRITEW
    loop .draw_line  ; Repeat the draw for each sprite's rows
    ret

draw_inky:
    mov si, [currentSpriteInky]
    ; Before draw the sprite, save the current position
    mov ax, [xPosInky]
    mov [old_XPOSInky], ax  ;Save the old position of X
    mov ax, [yPosInky]
    mov [old_YPOSInky], ax  ;Save the old position of Y
    ; Reset the graphic segment
    mov ax, 0A000h
    mov es, ax
    ; Cacul the addresse to the screen where the sprite will be draw
    mov ax, [yPosInky]
    imul ax, 320       ;  Multiply yPos par the width of screen to get the offset
    add ax, [xPosInky]     ; Add xPos to the offset
    mov di, ax         ; DI = address for the draw
    ; Get the addresses's sprite to draw
    mov cx, SPRITEH     ; Define the sprite's height
.draw_line:
    push cx     ; Save CX else modify by rep
    mov cx, SPRITEW     ; Define the width for the current row
    rep movsb  ; Print the sprite's row
    pop cx  ; Restore CX for the next sprite's row
    ; Adjust DI for the next rows and take in account the width offset
    add di, 320 - SPRITEW
    loop .draw_line  ; Repeat the draw for each sprite's rows
    ret
    
draw_clyde:
    mov si, [currentSpriteClyde]
    ; Before draw the sprite, save the current position
    mov ax, [xPosClyde]
    mov [old_XPOSClyde], ax  ;Save the old position of X
    mov ax, [yPosClyde]
    mov [old_YPOSClyde], ax  ;Save the old position of Y
    ; Reset the graphic segment
    mov ax, 0A000h
    mov es, ax
    ; Cacul the address to the screen where the sprite will be draw
    mov ax, [yPosClyde]
    imul ax, 320       ;  Multiply yPos par the width of screen to get the offset
    add ax, [xPosClyde]     ; Add xPos to the offset
    mov di, ax         ; DI = address for the draw
    ; Get the addresses's sprite to draw
    mov cx, SPRITEH     ; Define the sprite's height
.draw_line:
    push cx     ; Save CX else modify by rep
    mov cx, SPRITEW     ; Define the width for the current row
    rep movsb  ; Print the sprite's row
    pop cx  ; Restore CX for the next sprite's row
    ; Adjust DI for the next rows and take in account the width offset
    add di, 320 - SPRITEW
    loop .draw_line  ; Repeat the draw for each sprite's rows
    ret

draw_pinky:
    mov si, [currentSpritePinky]
    ; Before draw the sprite, save the current position
    mov ax, [xPosPinky]
    mov [old_XPOSPinky], ax  ;Save the old position of X
    mov ax, [yPosPinky]
    mov [old_YPOSPinky], ax  ;Save the old position of Y
    ; Reset the graphic segment
    mov ax, 0A000h
    mov es, ax
    ; Cacul the addresse to the screen where the sprite will be draw
    mov ax, [yPosPinky]
    imul ax, 320       ;  Multiply yPos par the width of screen to get the offset
    add ax, [xPosPinky]     ; Add xPos to the offset
    mov di, ax         ; DI = address for the draw
    ; Get the addresses's sprite to draw
    mov cx, SPRITEH     ; Define the sprite's height
.draw_line:
    push cx     ; Save CX else modify by rep
    mov cx, SPRITEW     ; Define the width for the current row
    rep movsb  ; Print the sprite's row
    pop cx  ; Restore CX for the next sprite's row
    ; Adjust DI for the next rows and take in account the width offset
    add di, 320 - SPRITEW
    loop .draw_line  ; Repeat the draw for each sprite's rows
    ret
    


; random_event_ghost:
    


