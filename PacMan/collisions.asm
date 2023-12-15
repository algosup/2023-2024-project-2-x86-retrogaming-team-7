check_right:
     .check_right_1:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          call check_detection_walls
          cmp cl, 0
          je .check_right_2
          ret
     .check_right_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_right_3
          ret
     .check_right_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH + 1 ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_right_4
          ret
     .check_right_4: 
          mov ax, [xPos]
          mov bx, [yPos]
          add bx, SPRITEW     ;    + this check hitbox bottom right
          call check_detection_walls
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
          call check_detection_walls
          cmp cl, 0
          je .check_left_2
          ret
     .check_left_2:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 3
          call check_detection_walls
          cmp cl, 0
          je .check_left_3
          ret
     .check_left_3:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 2
          add bx, 4
          call check_detection_walls
          cmp cl, 0
          je .check_left_4
          ret
     .check_left_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add bx, SPRITEW     ;    + this check hitbox bottom left
          call check_detection_walls
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
          sub bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_up_2
          ret
     .check_up_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 2
          sub bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_up_3
          ret
     .check_up_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 3
          sub bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_up_4
          ret
     .check_up_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp cl, 0
          je .check_up_over
          ret
     .check_up_over:
          mov bx, [yPos]
          sub bx, 1
          mov [yPos], bx
          ret
check_down:
    .check_down_0:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_2
        ret
    .check_down_1:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 1
        call check_detection_walls
        cmp cl, 0
        je .check_down_2
        ret
    .check_down_2:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 2
        call check_detection_walls
        cmp cl, 0
        je .check_down_3
        ret
    .check_down_3:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 3
        call check_detection_walls
        cmp cl, 0
        je .check_down_4
        ret
    .check_down_4:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 4
        call check_detection_walls
        cmp cl, 0
        je .check_down_5
        ret
    .check_down_5:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 5
        call check_detection_walls
        cmp cl, 0
        je .check_down_6
        ret
    .check_down_6:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW + 1
        add ax, 6
        call check_detection_walls
        cmp cl, 0
        je .check_down_7
        ret
    
    .check_down_7:
        mov ax, [xPos]
        mov bx, [yPos]
        add bx, SPRITEW + 1     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp cl, 0
        je .check_down_over
        ret
    .check_down_over:
        mov bx, [yPos]
        add bx, 1
        mov [yPos], bx
        ret

    


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

