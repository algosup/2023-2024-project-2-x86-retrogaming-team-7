org 100h

[map all pacman.map]
%include "sprite.asm"

%define SCREEN_WIDTH 320
%define SCREEN_HEIGHT 200


%define SPRITEW 8
%define SPRITEH 8
section .data

xPos dw 0
xVelocity dw 1
yPos dw 80

spritew dw 8

spriteh dw 8

old_XPOS dw 0

old_YPOS dw 0

currentSprite dd pacman_right_1
actualKeystroke dw 4Dh

mazeSprite      db 0,2,2,2,2,2,2,2,2,2,1,0,2,2,2,2,2,2,2,2,2,1
                db 14,49,49,49,49,49,49,49,49,49,14,15,49,49,49,49,49,49,49,49,49,15
                db 14,49,24,25,26,49,24,25,26,49,14,15,49,24,25,26,49,24,25,26,49,15
                db 14,49,36,37,38,49,36,37,38,49,12,13,49,36,37,38,49,36,37,38,49,15
                db 14,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,15
                db 14,49,27,28,29,49,39,49,27,28,32,33,28,29,49,39,49,27,28,29,49,15
                db 14,49,49,49,49,49,40,49,49,49,46,47,49,49,49,40,49,49,49,49,49,15
                db 12,3,3,3,0,49,4,28,29,49,44,45,49,27,28,16,49,0,3,3,3,13
                db 49,49,49,49,14,49,40,49,49,49,49,49,49,49,49,40,49,15,49,49,49,49
                db 2,2,2,2,18,49,41,49,9,10,34,35,10,11,49,41,49,17,2,2,2,2
                db 49,49,49,49,49,49,49,49,15,49,49,49,49,14,49,49,49,49,49,49,49,49
                db 3,3,3,3,6,49,39,49,21,22,22,22,22,23,49,39,49,5,3,3,3,3
                db 49,49,49,49,14,49,40,49,49,49,49,49,49,49,49,40,49,15,49,49,49,49
                db 0,2,2,2,18,49,41,49,27,28,32,33,28,29,49,41,49,17,2,2,2,1
                db 14,49,49,49,49,49,49,49,49,49,46,47,49,49,49,49,49,49,49,49,49,15
                db 14,49,27,28,31,49,27,28,29,49,44,45,49,27,28,29,49,30,28,29,49,15
                db 14,49,49,49,40,49,49,49,49,49,49,49,49,49,49,49,49,40,49,49,49,15
                db 4,28,29,49,41,49,39,49,27,28,32,33,28,29,49,39,49,41,49,27,28,15
                db 14,49,49,49,49,49,40,49,49,49,46,47,49,49,49,40,49,49,49,49,49,15
                db 14,49,27,28,28,28,48,28,29,49,44,45,49,27,28,48,28,28,28,29,49,15
                db 14,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,49,15
                db 12,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,13

    Column dw 22
    Row dw 22
    PixelPerTileRow dw 2560

section .bss
keyPressed resb 1
section .text
start:
    mov ah, 00h
    mov al, 13h
    int 10h
    call clearScreen
    call Maze
    mov si, [currentSprite]
    
    gameloop:
    call clearSprite
    call draw_sprite
    call read_character_key_was_pressed

    mov cx, 64000
    waitloop:
        loop waitloop
    jmp gameloop
    mov ax, 03h
    int 10h
    mov ax, 4C00h
    int 21h


clearScreen:
    mov bx, 0xA000
    mov es, bx
    mov di, 0
    mov cx, 200*320
    rep stosb
    ret 
    
read_character_key_was_pressed:
    mov ah, 01h
    int 16h
    jz continue_movement

    ; Read the keystroke
    mov ah, 00h
    int 16h
    cmp ah, 4Dh
    je update_keystroke
    cmp ah, 4Bh
    je update_keystroke
    cmp ah, 48h
    je update_keystroke
    cmp ah, 50h
    je update_keystroke
    jmp continue_movement

update_keystroke:
    mov [actualKeystroke], ah  ; Store the new direction
    jmp continue_movement

clearSprite:
    ; Set up the graphics segment
    mov ax, 0A000h
    mov es, ax

    ; Calculate the screen offset for the old position of the sprite
    mov ax, [old_YPOS]     ; Get the old Y position
    imul ax, 320           ; Multiply Y position by screen width to get the offset
    add ax, [old_XPOS]     ; Add the old X position to the offset
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

move_right:
    mov word [actualKeystroke], 4Dh
    call pacman_Right
    mov bx, [xPos]
    add bx, 3/2
    cmp bx, SCREEN_WIDTH - SPRITEW 
    jae .skip_move_right
    mov [xPos], bx
.skip_move_right:
    ret
move_left:
    mov word [actualKeystroke], 4Bh
    call pacman_Left
    mov bx, [xPos]
    sub bx, 3/2
    cmp bx, 0
    jbe .skip_move_left
    mov [xPos], bx
.skip_move_left:
    ret

move_up:
    mov word [actualKeystroke], 48h
    call pacman_Up
    mov bx, [yPos]
    sub bx, 3/2
    cmp bx, 0
    jbe .skip_move_up
    mov [yPos], bx
.skip_move_up:
    ret

move_down:
    mov word [actualKeystroke], 50h
    call pacman_Down
    mov bx, [yPos]
    add bx, 3/2
    cmp bx, SCREEN_HEIGHT - SPRITEH 
    jae .skip_move_down
    mov [yPos], bx
.skip_move_down:
    ret

continue_movement:
    mov al, [actualKeystroke]
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
        call move_right
        ret
    .move_left:
        call move_left
        ret
    .move_up:
        call move_up
        ret
    .move_down:
        call move_down
        ret
    ret

pacman_Right:
    cmp word [currentSprite], pacman_right_1
    je .pacmanRightSemiOpen
    cmp word [currentSprite], pacman_right_3
    je .pacmanRightOpen
    cmp word [currentSprite], pacman_right_2
    je .pacmanRightClose

    .pacmanRightOpen:
       mov word [currentSprite], pacman_right_1
       mov si, [currentSprite]
       ret
    .pacmanRightSemiOpen:
        mov word [currentSprite], pacman_right_2
        mov si, [currentSprite]
        ret
    .pacmanRightClose:
        mov word [currentSprite], pacman_right_3
        mov si, [currentSprite]
        ret

    pacman_Left:
    cmp word [currentSprite], pacman_left_1
    je .pacmanLeftSemiOpen
    cmp word [currentSprite], pacman_left_2
    je .pacmanLeftClose
    cmp word [currentSprite], pacman_left_3
    je .pacmanLeftOpen

    .pacmanLeftOpen:
       mov word [currentSprite], pacman_left_1
       mov si, [currentSprite]
       ret
    .pacmanLeftSemiOpen:
        mov word [currentSprite], pacman_left_2
        mov si, [currentSprite]
        ret
    .pacmanLeftClose:
        mov word [currentSprite], pacman_left_3
        mov si, [currentSprite]
        ret

    pacman_Up:
    cmp word [currentSprite], pacman_up_1
    je .pacmanUpSemiOpen
    cmp word [currentSprite], pacman_up_2
    je .pacmanUpClose
    cmp word [currentSprite], pacman_up_3
    je .pacmanUpOpen

    .pacmanUpOpen:
       mov word [currentSprite], pacman_up_1
       mov si, [currentSprite]
       ret
    .pacmanUpSemiOpen:
        mov word [currentSprite], pacman_up_2
        mov si, [currentSprite]
        ret
    .pacmanUpClose:
        mov word [currentSprite], pacman_up_3
        mov si, [currentSprite]
        ret
    
    pacman_Down:
    cmp word [currentSprite], pacman_down_1
    je .pacmanDownSemiOpen
    cmp word [currentSprite], pacman_down_2
    je .pacmanDownClose
    cmp word [currentSprite], pacman_down_3
    je .pacmanDownOpen

    .pacmanDownOpen:
       mov word [currentSprite], pacman_down_1
       mov si, [currentSprite]
       ret
    .pacmanDownSemiOpen:
        mov word [currentSprite], pacman_down_2
        mov si, [currentSprite]
        ret
    .pacmanDownClose:
        mov word [currentSprite], pacman_down_3
        mov si, [currentSprite]
        ret

draw_sprite:
    mov ax, [xPos]
    mov [old_XPOS], ax
    mov ax, [yPos]
    mov [old_YPOS], ax
    mov ax, 0A000h
    mov es, ax
    mov ax, [yPos]
    imul ax, 320
    add ax, [xPos] 
    mov di, ax
    mov cx, SPRITEH
.draw_line:
    push cx
    mov cx, SPRITEW
    rep movsb
    pop cx
    add di, 320 - SPRITEW
    loop .draw_line
    ret
    
drawWalls:
        mov dx, 8
        .eachLine:  
            mov cx, 8
            rep movsb
            add di, 320-8
            dec dx
            jnz .eachLine
            call nextColumn
        inc bx
        ret
    nextColumn:
        mov ax, [Column]
        dec ax
        mov [Column], ax
        cmp ax, 0
        je nextRow
        sub di, 2552
        ret
        
    nextRow:
        mov ax, [Row]
        dec ax
        mov [Row], ax
        cmp ax, 0
        je gameloop
        mov ax, 22
        mov [Column], ax
        mov ax, [PixelPerTileRow] 
        mov di, ax
        add ax, 2560
        mov [PixelPerTileRow], ax  
        ret
    Maze:
        mov di, 0
        mov bx, mazeSprite
        wallchoice:
            mov al, [bx]
            cmp al,  49         
            je drawEmpty        
            cmp al, 0
            je DrawEXT_ANGLE_TL
            cmp al, 1
            je DrawEXT_ANGLE_TR
            cmp al, 2
            je DrawEXT_BORDER_STRAIT_UP
            cmp al, 3
            je DrawEXT_BORDER_STRAIT_DOWN
            cmp al, 4
            je DrawTRIANGLE_RIGHT
            cmp al, 5
            je DrawEXT_BORDER_SQUARE_TL
            cmp al, 6
            je DrawEXT_BORDER_SQUARE_TR
            cmp al, 7
            je DrawEXT_BORDER_CIRCLE_TL
            cmp al, 8
            je DrawEXT_BORDER_CIRCLE_TR
            cmp al, 9
            je DrawINT_GHOST_SPAWN_TL
            cmp al, 10
            je DrawINT_GHOST_SPAWN_MIDDLE_TOP
            cmp al, 11
            je DrawINT_GHOST_SPAWN_TR
            cmp al, 12
            je DrawEXT_ANGLE_BL
            cmp al, 13
            je DrawEXT_ANGLE_BR
            cmp al, 14
            je DrawEXT_BORDER_STRAIT_LEFT
            cmp al, 15
            je DrawEXT_BORDER_STRAIT_RIGHT
            cmp al, 16
            je DrawTRIANGLE_LEFT
            cmp al, 17
            je DrawEXT_BORDER_SQUARE_BL
            cmp al, 18
            je DrawEXT_BORDER_SQUARE_BR
            cmp al, 19
            je DrawEXT_BORDER_CIRCLE_BL
            cmp al, 20
            je DrawEXT_BORDER_CIRCLE_BR
            cmp al, 21
            je DrawINT_GHOST_SPAWN_BL
            cmp al, 22
            je DrawINT_GHOST_SPAWN_MIDDLE_DOWN
            cmp al, 23
            je DrawINT_GHOST_SPAWN_BR
            cmp al, 24
            je DrawINT_BIG_RECTANGLE_TL
            cmp al, 25
            je DrawINT_BIG_RECTANGLE_MIDDLE_TOP
            cmp al, 26
            je DrawINT_BIG_RECTANGLE_TR
            cmp al, 27
            je DrawINT_SLIM_HORI_LEFT
            cmp al, 28
            je DrawINT_SLIM_HORI_MIDDLE
            cmp al, 29
            je DrawINT_SLIM_HORI_RIGHT
            cmp al, 30
            je DrawINT_ANGLE_TL
            cmp al, 31
            je DrawINT_ANGLE_TR
            cmp al, 32
            je DrawINT_BIG_CORNER_TL
            cmp al, 33
            je DrawINT_BIG_CORNER_TR
            cmp al, 34
            je DrawINT_GHOST_OUT_LEFT
            cmp al, 35
            je DrawINT_GHOST_OUT_RIGHT
            cmp al, 36
            je DrawINT_BIG_RECTANGLE_BL
            cmp al, 37
            je DrawINT_BIG_RECTANGLE_MIDDLE_DOWN
            cmp al, 38
            je DrawINT_BIG_RECTANGLE_BR
            cmp al, 39
            je DrawINT_SLIM_VERTI_UP
            cmp al, 40
            je DrawINT_SLIM_VERTI_MIDDLE
            cmp al, 41
            je DrawINT_SLIM_VERTI_DOWN
            cmp al, 42
            je DrawINT_ANGLE_BL
            cmp al, 43
            je DrawINT_ANGLE_BR
            cmp al, 44
            je DrawINT_BIG_CORNER_BL
            cmp al, 45
            je DrawINT_BIG_CORNER_BR
            cmp al, 46
            je DrawINT_BIG_RECTANGLE_MIDDLE_LEFT
            cmp al, 47
            je DrawINT_BIG_RECTANGLE_MIDDLE_RIGHT
            cmp al, 48
            je DrawTRIANGLE_UP
            cmp al, 51
            je DrawINT_GHOST_SPAWN_STRAIT_LEFT
            cmp al, 50
            je DrawINT_GHOST_SPAWN_STRAIT_RIGHT
            ret
          ; ===================================
    
          drawEmpty:
               mov si, empty
               call drawWalls
               jmp wallchoice
          DrawEXT_ANGLE_TL:
               mov si, ext_angle_tl
               call drawWalls
               jmp wallchoice
          DrawEXT_ANGLE_TR:
               mov si, ext_angle_tr
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_STRAIT_UP:
               mov si, ext_border_strait_up
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_STRAIT_DOWN:
               mov si, ext_border_strait_down
               call drawWalls
               jmp wallchoice
          DrawTRIANGLE_RIGHT:
               mov si, triangle_right
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_SQUARE_TL:
               mov si, ext_border_square_tl
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_SQUARE_TR:
               mov si, ext_border_square_tr
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_CIRCLE_TL:
               mov si, ext_border_circle_tl
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_CIRCLE_TR:
               mov si, ext_border_circle_tr
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_TL:
               mov si, int_ghost_spawn_tl
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_MIDDLE_TOP:
               mov si, int_ghost_spawn_middle_top
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_TR:
               mov si, int_ghost_spawn_tr
               call drawWalls
               jmp wallchoice
          DrawEXT_ANGLE_BL:
               mov si, ext_angle_bl
               call drawWalls
               jmp wallchoice
          DrawEXT_ANGLE_BR:
               mov si, ext_angle_br
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_STRAIT_LEFT:
               mov si, ext_border_strait_left
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_STRAIT_RIGHT:
               mov si, ext_border_strait_right
               call drawWalls
               jmp wallchoice
          DrawTRIANGLE_LEFT:
               mov si, triangle_left
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_SQUARE_BL:
               mov si, ext_border_square_bl
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_SQUARE_BR:
               mov si, ext_border_square_br
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_CIRCLE_BL:
               mov si, ext_border_circle_bl
               call drawWalls
               jmp wallchoice
          DrawEXT_BORDER_CIRCLE_BR:
               mov si, ext_border_circle_br
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_BL:
               mov si, int_ghost_spawn_bl
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_MIDDLE_DOWN:
               mov si, int_ghost_spawn_middle_down
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_BR:
               mov si, int_ghost_spawn_br
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_RECTANGLE_TL:
               mov si, int_big_rectangle_tl
               call drawWalls
               jmp wallchoice
          ; ====================================
            DrawINT_BIG_RECTANGLE_MIDDLE_TOP:
                mov si, int_big_rectangle_middle_top
                call drawWalls
                jmp wallchoice
          DrawINT_BIG_RECTANGLE_TR:
               mov si, int_big_rectangle_tr
               call drawWalls
               jmp wallchoice
          DrawINT_SLIM_HORI_LEFT:
               mov si, int_slim_hori_left
               call drawWalls
               jmp wallchoice
          DrawINT_SLIM_HORI_MIDDLE:
               mov si, int_slim_hori_middle
               call drawWalls
               jmp wallchoice
          DrawINT_SLIM_HORI_RIGHT:
               mov si, int_slim_hori_right
               call drawWalls
               jmp wallchoice
          DrawINT_ANGLE_TL:
               mov si, int_angle_tl
               call drawWalls
               jmp wallchoice
          DrawINT_ANGLE_TR:
               mov si, int_angle_tr
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_CORNER_TL:
               mov si, int_big_corner_tl
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_CORNER_TR:
               mov si, int_big_corner_tr
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_OUT_LEFT:
               mov si, int_ghost_out_left
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_OUT_RIGHT:
               mov si, int_ghost_out_right
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_RECTANGLE_BL:
               mov si, int_big_rectangle_bl
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_RECTANGLE_MIDDLE_DOWN:
               mov si, int_big_rectangle_middle_down
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_RECTANGLE_BR:
               mov si, int_big_rectangle_br
               call drawWalls
               jmp wallchoice
          DrawINT_SLIM_VERTI_UP:
               mov si, int_slim_verti_up
               call drawWalls
               jmp wallchoice
          DrawINT_SLIM_VERTI_MIDDLE:
               mov si, int_slim_verti_middle
               call drawWalls
               jmp wallchoice
          DrawINT_SLIM_VERTI_DOWN:
               mov si, int_slim_verti_down
               call drawWalls
               jmp wallchoice
          DrawINT_ANGLE_BL:
               mov si, int_angle_bl
               call drawWalls
               jmp wallchoice
          DrawINT_ANGLE_BR:
               mov si, int_angle_br
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_CORNER_BL:
               mov si, int_big_corner_bl
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_CORNER_BR:
               mov si, int_big_corner_br
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_RECTANGLE_MIDDLE_LEFT:
               mov si, int_big_rectangle_middle_left
               call drawWalls
               jmp wallchoice
          DrawINT_BIG_RECTANGLE_MIDDLE_RIGHT:
               mov si, int_big_rectangle_middle_right
               call drawWalls
               jmp wallchoice
          DrawTRIANGLE_UP:
               mov si, triangle_up
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_STRAIT_LEFT:
               mov si, int_ghost_spawn_strait_left
               call drawWalls
               jmp wallchoice
          DrawINT_GHOST_SPAWN_STRAIT_RIGHT:
               mov si, int_ghost_spawn_strait_right
               call drawWalls
               jmp wallchoice