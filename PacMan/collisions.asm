;=================================================
;          WALLS COLLISIONS TEST
;=================================================
check_detection_walls:
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


check_detection_empty:
     ; Convert position to screen buffer index
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x00
     je .collision
     xor cl, cl
     ret
     .collision: ; Collision do not exist
          mov cl, 1 ; Collision detected
          ret
;=================================================
;              PACMAN COLLISIONS
;=================================================



check_collision_pacman:
     cmp word [actualKeystroke], 4Dh  ; Right
     je check_right_pac
     cmp word [actualKeystroke], 4Bh  ; Left
     je check_left_pac
     cmp word [actualKeystroke], 48h  ; Up
     je check_up_pac
     cmp word [actualKeystroke], 50h  ; Down
     je check_down_pac
     ret



check_right_pac:
     .check_right_pac_0:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_1
          ret
     .check_right_pac_1:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_2
          ret
     .check_right_pac_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_3
          ret
     .check_right_pac_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_4
          ret 
     .check_right_pac_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_5
          ret
     .check_right_pac_5: 
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEW + 1
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_6
          ret
     .check_right_pac_6:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_7
          ret
     .check_right_pac_7:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_right_pac_over
          ret         
     .check_right_pac_over:
          mov bx, [xPos]
          add bx, 1
          mov [xPos], bx
          ret
     
     return:
          ret
check_left_pac:
     .check_left_pac_0:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_1
          ret
     .check_left_pac_1:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_2
          ret
     .check_left_pac_2:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_3
          ret
     .check_left_pac_3:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_4
          ret

     .check_left_pac_4:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_5
          ret
     .check_left_pac_5:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 5
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_6
          ret
     .check_left_pac_6:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_7
          ret
     .check_left_pac_7:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_left_pac_over
          ret
     
     .check_left_pac_over:
          mov bx, [xPos]
          sub bx, 1
          mov [xPos], bx
          ret
check_up_pac:
     .check_up_pac_0:
          mov ax, [xPos]
          mov bx, [yPos]
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_1
          ret
     .check_up_pac_1:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 1
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_2
          ret
     .check_up_pac_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 2
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_3
          ret
     .check_up_pac_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 3
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_4
          ret
     .check_up_pac_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_5
          ret
     .check_up_pac_5:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_6
          ret
     .check_up_pac_6:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_7
          ret
     .check_up_pac_7:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pac_over
          ret
          
     .check_up_pac_over:
          mov bx, [yPos]
          sub bx, 1
          mov [yPos], bx
          ret
check_down_pac:
    .check_down_pac_0:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_1
        ret
    .check_down_pac_1:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_2
        ret
    .check_down_pac_2:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 2
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_3
        ret
    .check_down_pac_3:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 3
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_4
        ret
    .check_down_pac_4:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 4
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_5
        ret
    .check_down_pac_5:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 5
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_6
        ret
    .check_down_pac_6:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 6
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_7
        ret
    
    .check_down_pac_7:
        mov ax, [xPos]
        mov bx, [yPos]
        add bx, SPRITEW + 1     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp cl, 0
        je .check_down_pac_over
        ret

    .check_down_pac_over:
        mov bx, [yPos]
        add bx, 1
        mov [yPos], bx
        ret

    


;=================================================
;              BlINKY COLLISIONS
;=================================================


check_collision_ghost_Blinky:
     cmp word [actualBDirection], 4Dh  ; Right
     je check_right_blinky
     cmp word [actualBDirection], 4Bh  ; Left
     je check_left_blinky
     cmp word [actualBDirection], 48h  ; Up
     je check_up_blinky
     cmp word [actualBDirection], 50h  ; Down
     je check_down_blinky
     ret


     

check_right_blinky:
     .check_right_blinky_0:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_1
          ret
     .check_right_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_2
          ret
     .check_right_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_3
          ret
     .check_right_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_4
          ret 
     .check_right_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_5
          ret
     .check_right_blinky_5: 
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEW + 1
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_6
          ret
     .check_right_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_7
          ret
     .check_right_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_right_blinky_over
          ret
     
     .check_right_blinky_over:
          mov bx, [xPosBlinky]
          add bx, 1
          mov [xPosBlinky], bx
          ret  
     
check_left_blinky:
     .check_left_blinky_0:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_1
          ret
     .check_left_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_2
          ret
     .check_left_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_3
          ret
     .check_left_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_4
          ret

     .check_left_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_5
          ret
     .check_left_blinky_5:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 5
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_6
          ret
     .check_left_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_7
          ret
     .check_left_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 2
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_left_blinky_over
          ret
     
     .check_left_blinky_over:
          mov bx, [xPosBlinky]
          sub bx, 1
          mov [xPosBlinky], bx
          ret
check_up_blinky:
     .check_up_blinky_0:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_1
          ret
     .check_up_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 1
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_2
          ret
     .check_up_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 2
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_3
          ret
     .check_up_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 3
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_4
          ret
     .check_up_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_5
          ret
     .check_up_blinky_5:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_6
          ret
     .check_up_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_7
          ret
     .check_up_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_blinky_over
          ret
          
     .check_up_blinky_over:
          mov bx, [yPosBlinky]
          sub bx, 1
          mov [yPosBlinky], bx
          ret
check_down_blinky:
    .check_down_blinky_0:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_1
        ret
    .check_down_blinky_1:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        add ax, 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_2
        ret
    .check_down_blinky_2:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        add ax, 2
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_3
        ret
    .check_down_blinky_3:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        add ax, 3
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_4
        ret
    .check_down_blinky_4:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        add ax, 4
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_5
        ret
    .check_down_blinky_5:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        add ax, 5
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_6
        ret
    .check_down_blinky_6:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW + 1
        add ax, 6
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_7
        ret
    
    .check_down_blinky_7:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky]
        add bx, SPRITEW + 1     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp cl, 0
        je .check_down_blinky_over
        ret
    .check_down_blinky_over:
        mov bx, [yPosBlinky]
        add bx, 1
        mov [yPosBlinky], bx
        ret




;=================================================
;              INKY COLLISIONS
;=================================================



check_collision_ghost_Inky:
     cmp word [actualIDirection], 4Dh  ; Right
     je check_right_inky
     cmp word [actualIDirection], 4Bh  ; Left
     je check_left_inky
     cmp word [actualIDirection], 48h  ; Up
     je check_up_inky
     cmp word [actualIDirection], 50h  ; Down
     je check_down_inky
     ret




check_right_inky:
     .check_right_inky_0:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_1
          ret
     .check_right_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_2
          ret
     .check_right_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_3
          ret
     .check_right_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_4
          ret 
     .check_right_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_5
          ret
     .check_right_inky_5: 
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEW + 1
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_6
          ret
     .check_right_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_7
          ret
     .check_right_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_right_inky_over
          ret
     
     .check_right_inky_over:
          mov bx, [xPosInky]
          add bx, 1
          mov [xPosInky], bx
          ret  
     
check_left_inky:
     .check_left_inky_0:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_1
          ret
     .check_left_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_2
          ret
     .check_left_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_3
          ret
     .check_left_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_4
          ret

     .check_left_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_5
          ret
     .check_left_inky_5:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 5
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_6
          ret
     .check_left_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_7
          ret
     .check_left_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 2
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_left_inky_over
          ret
     
     .check_left_inky_over:
          mov bx, [xPosInky]
          sub bx, 1
          mov [xPosInky], bx
          ret
check_up_inky:
     .check_up_inky_0:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_1
          ret
     .check_up_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 1
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_2
          ret
     .check_up_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 2
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_3
          ret
     .check_up_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 3
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_4
          ret
     .check_up_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_5
          ret
     .check_up_inky_5:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_6
          ret
     .check_up_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_7
          ret
     .check_up_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_inky_over
          ret
          
     .check_up_inky_over:
          mov bx, [yPosInky]
          sub bx, 1
          mov [yPosInky], bx
          ret
check_down_inky:
    .check_down_inky_0:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_1
        ret
    .check_down_inky_1:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        add ax, 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_2
        ret
    .check_down_inky_2:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        add ax, 2
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_3
        ret
    .check_down_inky_3:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        add ax, 3
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_4
        ret
    .check_down_inky_4:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        add ax, 4
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_5
        ret
    .check_down_inky_5:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        add ax, 5
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_6
        ret
    .check_down_inky_6:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW + 1
        add ax, 6
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_7
        ret
    
    .check_down_inky_7:
        mov ax, [xPosInky]
        mov bx, [yPosInky]
        add bx, SPRITEW + 1     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp cl, 0
        je .check_down_inky_over
        ret
    .check_down_inky_over:
        mov bx, [yPosInky]
        add bx, 1
        mov [yPosInky], bx
        ret



;=================================================
;              CLYDE COLLISIONS
;=================================================



check_collision_ghost_Clyde:
     cmp word [actualCDirection], 4Dh  ; Right
     je check_right_clyde
     cmp word [actualCDirection], 4Bh  ; Left
     je check_left_clyde
     cmp word [actualCDirection], 48h  ; Up
     je check_up_clyde
     cmp word [actualCDirection], 50h  ; Down
     je check_down_clyde
     ret



check_right_clyde:
     .check_right_clyde_0:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_1
          ret
     .check_right_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_2
          ret
     .check_right_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_3
          ret
     .check_right_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_4
          ret 
     .check_right_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_5
          ret
     .check_right_clyde_5: 
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEW + 1
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_6
          ret
     .check_right_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_7
          ret
     .check_right_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_right_clyde_over
          ret
     
     .check_right_clyde_over:
          mov bx, [xPosClyde]
          add bx, 1
          mov [xPosClyde], bx
          ret  
     
check_left_clyde:
     .check_left_clyde_0:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_1
          ret
     .check_left_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_2
          ret
     .check_left_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_3
          ret
     .check_left_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_4
          ret

     .check_left_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_5
          ret
     .check_left_clyde_5:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 5
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_6
          ret
     .check_left_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_7
          ret
     .check_left_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 2
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_left_clyde_over
          ret
     
     .check_left_clyde_over:
          mov bx, [xPosClyde]
          sub bx, 1
          mov [xPosClyde], bx
          ret
check_up_clyde:
     .check_up_clyde_0:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_1
          ret
     .check_up_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 1
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_2
          ret
     .check_up_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 2
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_3
          ret
     .check_up_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 3
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_4
          ret
     .check_up_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_5
          ret
     .check_up_clyde_5:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_6
          ret
     .check_up_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_7
          ret
     .check_up_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_clyde_over
          ret
          
     .check_up_clyde_over:
          mov bx, [yPosClyde]
          sub bx, 1
          mov [yPosClyde], bx
          ret
check_down_clyde:
    .check_down_clyde_0:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_1
        ret
    .check_down_clyde_1:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        add ax, 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_2
        ret
    .check_down_clyde_2:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        add ax, 2
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_3
        ret
    .check_down_clyde_3:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        add ax, 3
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_4
        ret
    .check_down_clyde_4:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        add ax, 4
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_5
        ret
    .check_down_clyde_5:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        add ax, 5
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_6
        ret
    .check_down_clyde_6:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW + 1
        add ax, 6
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_7
        ret
    
    .check_down_clyde_7:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde]
        add bx, SPRITEW + 1     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp cl, 0
        je .check_down_clyde_over
        ret
    .check_down_clyde_over:
        mov bx, [yPosClyde]
        add bx, 1
        mov [yPosClyde], bx
        ret




;=================================================
;              PINKY COLLISIONS
;=================================================



check_collision_ghost_Pinky:
     cmp word [actualPDirection], 4Dh  ; Right
     je check_right_pinky
     cmp word [actualPDirection], 4Bh  ; Left
     je check_left_pinky
     cmp word [actualPDirection], 48h  ; Up
     je check_up_pinky
     cmp word [actualPDirection], 50h  ; Down
     je check_down_pinky
     ret



check_right_pinky:
     .check_right_pinky_0:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_1
          ret
     .check_right_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_2
          ret
     .check_right_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_3
          ret
     .check_right_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_4
          ret 
     .check_right_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_5
          ret
     .check_right_pinky_5: 
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEW + 1
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_6
          ret
     .check_right_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_7
          ret
     .check_right_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_right_pinky_over
          ret
     
     .check_right_pinky_over:
          mov bx, [xPosPinky]
          add bx, 1
          mov [xPosPinky], bx
          ret  
     
check_left_pinky:
     .check_left_pinky_0:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_1
          ret
     .check_left_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_2
          ret
     .check_left_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_3
          ret
     .check_left_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_4
          ret

     .check_left_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_5
          ret
     .check_left_pinky_5:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 5
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_6
          ret
     .check_left_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 6
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_7
          ret
     .check_left_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 2
          add bx, 7
          call check_detection_walls
          cmp cl, 0
          je .check_left_pinky_over
          ret
     
     .check_left_pinky_over:
          mov bx, [xPosPinky]
          sub bx, 1
          mov [xPosPinky], bx
          ret
check_up_pinky:
     .check_up_pinky_0:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_1
          ret
     .check_up_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 1
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_2
          ret
     .check_up_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 2
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_3
          ret
     .check_up_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 3
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_4
          ret
     .check_up_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_5
          ret
     .check_up_pinky_5:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_6
          ret
     .check_up_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_7
          ret
     .check_up_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 2
          call check_detection_walls
          cmp cl, 0
          je .check_up_pinky_over
          ret
          
     .check_up_pinky_over:
          mov bx, [yPosPinky]
          sub bx, 1
          mov [yPosPinky], bx
          ret
check_down_pinky:
    .check_down_pinky_0:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_1
        ret
    .check_down_pinky_1:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        add ax, 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_2
        ret
    .check_down_pinky_2:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        add ax, 2
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_3
        ret
    .check_down_pinky_3:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        add ax, 3
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_4
        ret
    .check_down_pinky_4:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        add ax, 4
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_5
        ret
    .check_down_pinky_5:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        add ax, 5
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_6
        ret
    .check_down_pinky_6:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW + 1
        add ax, 6
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_7
        ret
    
    .check_down_pinky_7:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky]
        add bx, SPRITEW + 1     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp cl, 0
        je .check_down_pinky_over
        ret
    .check_down_pinky_over:
        mov bx, [yPosPinky]
        add bx, 1
        mov [yPosPinky], bx
        ret

tunnel_horizontal:
     mov ax, [xPos]
     cmp ax, 66
     jb .to_right
     cmp ax, 246
     ja .to_left
     ret
     .to_right:
          mov word [xPos], 244
          ret
     .to_left:
          mov word [xPos], 70
          ret

tunnel_horizontal_blinky:
     mov ax, [xPosBlinky]
          cmp ax, 66
          jb .to_right
          cmp ax, 246
          ja .to_left
          ret
          .to_right:
               mov word [xPosBlinky], 244
               ret
          .to_left:
               mov word [xPosBlinky], 70
               ret
tunnel_horizontal_inky:
     mov ax, [xPosInky]
     cmp ax, 66
     jb .to_right
     cmp ax, 246
     ja .to_left
     ret
     .to_right:
          mov word [xPosInky], 244
          ret
     .to_left:
          mov word [xPosInky], 70
          ret
tunnel_horizontal_clyde:
     mov ax, [xPosClyde]
     cmp ax, 66
     jb .to_right
     cmp ax, 246
     ja .to_left
     ret
     .to_right:
          mov word [xPosClyde], 244
          ret
     .to_left:
          mov word [xPosClyde], 70
          ret
tunnel_horizontal_pinky:
     mov ax, [xPosPinky]
     cmp ax, 66
     jb .to_right
     cmp ax, 246
     ja .to_left
     ret
     .to_right:
          mov word [xPosPinky], 244
          ret
     .to_left:
          mov word [xPosPinky], 70
          ret