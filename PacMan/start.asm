org 100h

[map all pacman.map]
%include "sprite.asm"

%define SCREEN_WIDTH 320
%define SCREEN_HEIGHT 200

%define SPRITEW 8
%define SPRITEH 8

%define MAZE_WIDTH 176
%define MAZE_HEIGHT 176

section .data
xPos dw 160
xVelocity dw 1
yPos dw 144
old_XPOS dw 0            ;Pac-man's XPOS
old_YPOS dw 0            ;Pac-man's YPOS

currentSprite dd pacman_right_2
actualKeystroke dw 0

mazeSprite      db  0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1
                db 14,54,54,54,54,54,54,54,54,54,15,14,54,54,54,54,54,54,54,54,54,15
                db 14,55,24,25,26,54,24,25,26,54,15,14,54,24,25,26,54,24,25,26,55,15
                db 14,54,36,37,38,54,36,37,38,54,19,20,54,36,37,38,54,36,37,38,54,15
                db 14,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,15
                db 14,54,27,28,29,54,39,54,27,28,32,33,28,29,54,39,54,27,28,29,54,15
                db 14,54,54,54,54,54,40,54,54,54,46,47,54,54,54,40,54,54,54,54,54,15
                db 12, 3, 3, 3, 6,54, 4,28,29,54,44,45,54,27,28,16,54, 7, 3, 3, 3,13
                db 49,49,49,49,14,54,40,49,49,49,49,49,49,49,49,40,54,15,49,49,49,49
                db  2, 2, 2, 2,18,54,41,54, 9,10,34,35,10,11,54,41,54,17, 2, 2, 2, 2
                db 49,49,49,49,49,54,54,54,51,49,49,49,49,50,54,54,54,49,49,49,49,49
                db  3, 3, 3, 3, 6,54,39,54,21,22,22,22,22,23,54,39,54, 5, 3, 3, 3, 3
                db 49,49,49,49,14,54,40,54,54,54,54,54,54,54,54,40,54,15,49,49,49,49
                db  0, 2, 2, 2,18,54,41,54,27,28,32,33,28,29,54,41,54,17, 2, 2, 2, 1
                db 14,54,54,54,54,54,54,54,54,54,46,47,54,54,54,54,54,54,54,54,54,15
                db 14,54,27,28,31,54,27,28,29,54,44,45,54,27,28,29,54,30,28,29,54,15
                db 14,54,54,54,40,54,54,54,54,54,54,49,54,54,54,54,54,40,54,54,54,15
                db 53,28,29,54,41,54,39,54,27,28,32,33,28,29,54,39,54,41,54,27,28,52
                db 14,54,54,54,54,54,40,54,54,54,46,47,54,54,54,40,54,54,54,54,54,15
                db 14,55,27,28,28,28,48,28,29,54,44,45,54,27,28,48,28,28,28,29,55,15
                db 14,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,15
                db 12, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,13

Column dw 22
Row dw 22
PixelPerTileRow dw 7752

section .bss
keyPressed resb 1
section .text
start_game:
     mov ah, 0x00    ; BIOS function code for setting video mode
     mov al, 0x13    ; Video mode 0x13 
     int 0x10        ; Call BIOS interrupt to set video mode
     call clearScreen
     call Maze
     call gameloop
    
gameloop:
     call check_collision
     call clearSprite
     call draw_sprite

     ; call clearGhostB
     ; call draw_blinky
     
     ; call clearGhostI
     ; call draw_inky

     ; call clearGhostC
     ; call draw_clyde

     ; call clearGhostP
     ; call draw_pinky

     call direction_ghost
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
     mov al, 0xFF
     rep stosb
     ret 
    

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
     
read_character_key_was_pressed:
     mov ah, 01h
     int 16h
     jz continue_movement

    ; Read the keystroke
     mov ah, 00h
     int 16h
     cmp ah, 4Dh
     je .update_keystroke
     cmp ah, 4Bh
     je .update_keystroke
     cmp ah, 48h
     je .update_keystroke
     cmp ah, 50h
     je .update_keystroke
     cmp ah, 01h
     je exit_menu
     jmp continue_movement

     .update_keystroke:
          mov [actualKeystroke], ah  ; Store the new direction
          jmp continue_movement
          
continue_movement:
     mov al, [actualKeystroke]
     cmp al, 4Dh
     je move_right
     cmp al, 4Bh
     je move_left
     cmp al, 48h
     je move_up
     cmp al, 50h
     je move_down
     cmp al, 0
     je read_character_key_was_pressed

move_right:  
     call pacman_Right
     ret

move_left:
     call pacman_Left
     ret
    

move_up:
     call pacman_Up
     ret

move_down:
     call pacman_Down
     ret


check_collision:
     cmp word [actualKeystroke], 4Dh  ; Right
     je check_right
     cmp word [actualKeystroke], 4Bh  ; Left
     je check_left
     cmp word [actualKeystroke], 48h  ; Up
     je check_up
     cmp word [actualKeystroke], 50h  ; Down
     je check_down
     ret


check_right:
     .check_right_1:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection
          cmp cl, 0
          je .check_right_2
          ret
     .check_right_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection
          cmp cl, 0
          je .check_right_3
          ret
     .check_right_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection
          cmp cl, 0
          je .check_right_4
          ret
     .check_right_4: 
          mov ax, [xPos]
          mov bx, [yPos]
          add bx, SPRITEW     ;    + this check hitbox bottom right
          call check_detection
          cmp cl, 0
          je .check_right_over
          ret
     .check_right_over:
          mov bx, [xPos]
          add bx, 1
          mov [xPos], bx
          ret  
     
check_left:
     .check_left_1:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          call check_detection
          cmp cl, 0
          je .check_left_2
          ret
     .check_left_2:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 3
          call check_detection
          cmp cl, 0
          je .check_left_3
          ret
     .check_left_3:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 4
          call check_detection
          cmp cl, 0
          je .check_left_4
          ret
     .check_left_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add bx, SPRITEW     ;    + this check hitbox bottom left
          call check_detection
          cmp cl, 0
          je .check_left_over
          ret
     .check_left_over:
          mov bx, [xPos]
          sub bx, 1
          mov [xPos], bx
          ret
check_up:
     .check_up_1:
          mov ax, [xPos]
          mov bx, [yPos]
          sub bx, 2
          call check_detection
          cmp cl, 0
          je .check_up_2
          ret
     .check_up_2:
          mov ax, [xPos]
          mov bx, [yPos]
          sub bx, 2
          add ax, 3
          call check_detection
          cmp cl, 0
          je .check_up_3
          ret
     .check_up_3:
          mov ax, [xPos]
          mov bx, [yPos]
          sub bx, 2
          add ax, 4
          call check_detection
          cmp cl, 0
          je .check_up_4
          ret
     .check_up_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEW     ;    + this check hitbox top right
          call check_detection
          cmp cl, 0
          je .check_up_over
          ret
     .check_up_over:
          mov bx, [yPos]
          sub bx, 1
          mov [yPos], bx
          ret
check_down:
     .check_down_1:
          mov ax, [xPos]
          mov bx, [yPos] 
          add bx, SPRITEW + 1
          call check_detection
          cmp cl, 0
          je .check_down_2
          ret
     .check_down_2:
          mov ax, [xPos]
          mov bx, [yPos] 
          add bx, SPRITEW + 1
          add ax, 3
          call check_detection
          cmp cl, 0
          je .check_down_3
          ret
     .check_down_3:
          mov ax, [xPos]
          mov bx, [yPos] 
          add bx, SPRITEW + 1
          add ax, 4
          call check_detection
          cmp cl, 0
          je .check_down_4
          ret
     .check_down_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEW     ;    + this check hitbox top right
          call check_detection
          cmp cl, 0
          je .check_down_over
          ret
     .check_down_over:
          mov bx, [yPos]
          add bx, 1
          mov [yPos], bx
          ret

     


check_detection:
     ; Convert position to screen buffer index
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x37
     je .collision
     xor cl, cl
     ret
     .collision: ; Collision do not exist
          mov cl, 1 ; Collision detected
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
     mov si, [currentSprite]
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
     sub di, 2552   ;2552
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
     add ax, 2560             ;2560
     mov [PixelPerTileRow], ax  
     ret
Maze:
     mov di, 5192   ;0
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
     cmp al, 50
     je DrawINT_GHOST_SPAWN_STRAIT_RIGHT
     cmp al, 51
     je DrawINT_GHOST_SPAWN_STRAIT_LEFT
     cmp al, 52
     je DrawEXT_TRIANGLE_LEFT
     cmp al, 53
     je DrawEXT_TRIANGLE_RIGHT
     cmp al, 54
     je Draw_PELLET
     cmp al, 55
     je Draw_SUPER_PELLET
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
DrawEXT_TRIANGLE_LEFT:
     mov si, ext_triangle_left
     call drawWalls
     jmp wallchoice
DrawEXT_TRIANGLE_RIGHT:
     mov si, ext_triangle_right
     call drawWalls
     jmp wallchoice
Draw_PELLET:
     mov si, pellet
     call drawWalls
     jmp wallchoice
Draw_SUPER_PELLET:
     mov si, power_pellet
     call drawWalls
     jmp wallchoice



%include "Ghost.asm"