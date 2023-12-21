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
waitingForLeft db 0
waitingForRight db 0
waitingForUp db 0
waitingForDown db 0
xPos dw 156       ;tunnel left = 72 (x) 96y            ;tunnel right = 240 (x)96y              
xVelocity dw 1
yPos dw 144                 
old_XPOS dw 0            ;Pac-man's XPOS
old_YPOS dw 0            ;Pac-man's YPOS
xPosSpawn dw 156
yPosSpawn dw 144
currentSprite dd pacman_right_2
xPoslives dw 264
yPoslives dw 65
old_XPOSlives dw 0          
old_YPOSlives dw 0  
lives_sprite dd pacman_left_1

actualKeystroke dw 0
waitingKeystroke dw 0
framerate db 0
gameStart db 0
lives db 4
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
                db 14,54,54,54,40,54,54,54,54,54,49,49,54,54,54,54,54,40,54,54,54,15
                db 53,28,29,54,41,54,39,54,27,28,32,33,28,29,54,39,54,41,54,27,28,52
                db 14,54,54,54,54,54,40,54,54,54,46,47,54,54,54,40,54,54,54,54,54,15
                db 14,55,27,28,28,28,48,28,29,54,44,45,54,27,28,48,28,28,28,29,55,15
                db 14,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,54,15
                db 12, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,13

Column dw 22
Row dw 22
PixelPerTileRow dw 7752

%include "scoring.asm"
section .bss
keyPressed resb 1
section .text
start_game:
     mov ah, 0x00    ; BIOS function code for setting video mode
     mov al, 0x13    ; Video mode 0x13 
     int 0x10        ; Call BIOS interrupt to set video mode
     call clearScreen
     call display_score
     call display_lives
     call Maze
     call SetSpawnPosition
     call gameloop
    
gameloop:
     call checkPelletNumber
     call clearSprite
     call draw_sprite
     
     call check_collision_ghost_Blinky
     call check_collision_Touch_Blinky
     call blinky_switch_direction
     call clearGhostB
     call draw_blinky
     
     call check_collision_ghost_Inky
     call check_collision_Touch_Inky
     call inky_switch_direction 
     call clearGhostI
     call draw_inky

     call check_collision_ghost_Clyde
     call check_collision_Touch_Clyde
     call clyde_switch_direction
     call clearGhostC
     call draw_clyde

     call check_collision_ghost_Pinky
     call check_collision_Touch_Pinky
     call pinky_switch_direction
     call clearGhostP
     call draw_pinky

     
     call check_number_lives
     call check_collision_pacman
     call checkWaitingKeystroke
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
    
SetSpawnPosition:
     mov ax, [xPosSpawn]
     mov [xPos], ax 
     mov ax, [yPosSpawn]
     mov [yPos], ax

     mov ax, [xPosSpawnBlinky]
     mov [xPosBlinky], ax
     mov ax, [yPosSpawnBlinky]
     mov [yPosBlinky], ax 

     mov ax, [xPosSpawnInky]
     mov [xPosInky], ax 
     mov ax, [yPosSpawnInky]
     mov [yPosInky], ax

     mov ax, [xPosSpawnClyde]
     mov [xPosClyde], ax
     mov ax, [yPosSpawnClyde]
     mov [yPosClyde], ax
     
     mov ax, [xPosSpawnPinky]
     mov [xPosPinky], ax
     mov ax, [yPosSpawnPinky]
     mov [yPosPinky], ax
     
     mov ax, 0
     mov [actualKeystroke], ax ; pacman respawn
     mov ax, pacman_right_2
     mov [currentSprite], ax
     call clearSprite
     call draw_sprite

     mov ax, blinky_right_1
     mov [currentSpriteBlinky], ax  ; blinky respawn
     call clearGhostB
     call draw_blinky

     mov ax, inky_right_1
     mov [currentSpriteInky], ax  ; inky respawn
     call clearGhostI
     call draw_inky

     mov ax, clyde_right_1
     mov [currentSpriteClyde], ax  ;clyde respawn
     call clearGhostC
     call draw_clyde

     mov ax, pinky_right_1
     mov [currentSpritePinky], ax  ;pinky respawn
     call clearGhostP
     call draw_pinky

     ret

check_number_lives:
     mov ax, [lives]
     cmp ax, 0
     je .deathf
     jne .return
     .deathf:
          call death
          ret
     .return:
          call check_lives
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
     
death:
     cmp word [currentSprite], pacman1_death_1
     je .pacmanB
     cmp word [currentSprite], pacman1_death_2
     je .pacmanC
     cmp word [currentSprite], pacman1_death_3
     je .pacmanD
     cmp word [currentSprite], pacman1_death_4
     je .pacmanE
     cmp word [currentSprite], pacman1_death_5
     je .pacmanF
     call .pacmanZ
     ret
     .pacmanZ:
          mov word [currentSprite], pacman1_death_1
          mov si, [currentSprite]
          call draw_sprite
          jmp death
     .pacmanA:
          mov word [currentSprite], pacman1_death_1
          mov si, [currentSprite]
          call draw_sprite
          jmp death
     .pacmanB:
          mov word [currentSprite], pacman1_death_2
          mov si, [currentSprite]
          call draw_sprite
          jmp death
     .pacmanC:
          mov word [currentSprite], pacman1_death_3
          mov si, [currentSprite]
          call draw_sprite
          jmp death
     .pacmanD:
          mov word [currentSprite], pacman1_death_4
          mov si, [currentSprite]
          call draw_sprite
          jmp death
     .pacmanE:
          mov word [currentSprite], pacman1_death_5
          mov si, [currentSprite]
          call draw_sprite
          jmp death
     .pacmanF:
          mov word [currentSprite], pacman1_death_6
          mov si, [currentSprite]
          call draw_sprite
          jmp resetMapPellet


read_character_key_was_pressed:
     mov ah, 01h
     int 16h
     jz continue_movement

    ; Read the keystroke
     mov ah, 00h
     int 16h
     mov [waitingKeystroke], ah
     cmp word [waitingKeystroke], 4Dh  ; Right arrow
     je checkNextPosition
     cmp word [waitingKeystroke], 4Bh  ; Left arrow
     je checkNextPosition
     cmp word [waitingKeystroke], 48h  ; Up arrow
     je checkNextPosition
     cmp word [waitingKeystroke], 50h  ; Down arrow
     je checkNextPosition
     .readMovement:
     cmp ah, 4Dh  ; Right arrow
     je setDirectionAndMove
     cmp ah, 4Bh  ; Left arrow
     je setDirectionAndMove
     cmp ah, 48h  ; Up arrow
     je setDirectionAndMove
     cmp ah, 50h  ; Down arrow
     je setDirectionAndMove

     ; Other keys
     cmp ah, 19h  ; Pause
     je pause
     cmp ah, 01h  ; Exit
     je exit_menu
     jmp continue_movement

setDirectionAndMove:
     mov [actualKeystroke], ah
     jmp continue_movement

checkNextPosition:
     ; Check collision on the right side
     call check_collision_pacman_waitingKeystroke
     cmp byte [detectCollision], 0
     je .noCollision
     jne .collision
     ; Collision, change actualKeystroke and continue movement
     .noCollision:
     mov al, [waitingKeystroke]
     mov [actualKeystroke], al

     .collision:
     jmp continue_movement

checkWaitingKeystroke:
     mov al, [waitingKeystroke]
     cmp al, [actualKeystroke]
     je .noChange

     .change:
     call checkNextPosition

     .noChange:
     ret

pause:
     mov ah, 00h
     int 16h
     cmp ah, 1Ch
     je .update_pause
     jmp pause
     .update_pause:
          jmp read_character_key_was_pressed

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
     call check_detection_pellets_right
     call check_detection_SuperPellets_right
     call tunnel_horizontal
     mov ax, [framerate]                       ; can reduce the frame rate
     cmp ax, 4                               ; can reduce the frame rate
     jne .skip_move_right                    ; can reduce the frame rate
     call pacman_Right                       
     xor ax, ax                              ; can reduce the frame rate
     mov [framerate], ax                       ; can reduce the frame rate
     ret
     .skip_move_right:
          inc ax                             ; can reduce the frame rate
          mov [framerate], ax                  ; can reduce the frame rate
          ret
move_left:
     call check_detection_pellets_left
     call check_detection_SuperPellets_left
     call tunnel_horizontal
     mov ax, [framerate]                       ; can reduce the frame rate
     cmp ax, 4                               ; can reduce the frame rate
     jne .skip_move_left                   ; can reduce the frame rate
     call pacman_Left
     xor ax, ax                             ; can reduce the frame rate
     mov [framerate], ax                       ; can reduce the frame rate
     ret
     .skip_move_left:
          inc ax                             ; can reduce the frame rate
          mov [framerate], ax                  ; can reduce the frame rate
          ret
    

move_up:
     call check_detection_pellets_up
     call check_detection_SuperPellets_up
     call tunnel_horizontal
     mov ax, [framerate]                       ; can reduce the frame rate
     cmp ax, 4                               ; can reduce the frame rate
     jne .skip_move_up                ; can reduce the frame rate
     call pacman_Up
     xor ax, ax                             ; can reduce the frame rate
     mov [framerate], ax 
     ret
     .skip_move_up:
          inc ax                             ; can reduce the frame rate
          mov [framerate], ax                  ; can reduce the frame rate
          ret

move_down:
     call check_detection_pellets_down
     call check_detection_SuperPellets_down
     call tunnel_horizontal
     mov ax, [framerate]                       ; can reduce the frame rate
     cmp ax, 4                               ; can reduce the frame rate
     jne .skip_move_down                ; can reduce the frame rate
     call pacman_Down
     xor ax, ax                             ; can reduce the frame rate
     mov [framerate], ax 
     ret
     .skip_move_down:
          inc ax                             ; can reduce the frame rate
          mov [framerate], ax                  ; can reduce the frame rate
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
          
check_lives:
     mov ax, [lives]
     cmp ax, 4
     je .olives
     cmp ax, 3
     je .flives
     cmp ax, 2
     je .thlives
     cmp ax, 1
     je .tlives
     cmp ax, 0
     je .olives
     .flives:
          mov word [xLivesPos], 288
          call clear_life
          ret          
     .thlives:
          mov word [xLivesPos], 280
          call clear_life
          ret
     .tlives:
          mov word [xLivesPos], 272
          call clear_life
          ret
     .olives:
          ret
     ret

clear_life:
     mov ax, 0A000h
     mov es, ax
     mov ax, [yLivesPos]     ; Get the old Y position
     imul ax, 320           ; Multiply Y position by screen width to get the offset
     add ax, [xLivesPos]     ; Add the old X position to the offset
     mov di, ax             ; DI = starting address for erasure
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
%include "collisions.asm"