section .data
current_score dd 0
point_pellet db 10
point_super_pellet db 30
point_ghost_ db 200
point_cherry db 100
point_strawberry db 300
point_orange db 500
point_apple db 700
point_melon db 1000
point_ship db 2000
point_bell db 3000
point_key db 5000

section .text

check_point_collision:
    
    .check_point_collision_right
    .check_point_collision_left
    .check_point_collision_up
    .check_point_collision_down
    mov ax, [xPos]
    mov bx, [yPos]
    mov ah, 0Dh
    mov cx, ax
    mov dx, bx
    int 10h
    cmp al, 0x0E ;colors
    
    cmp al, ;colors
    cmp al, ;colors
    cmp al, ;colors
    cmp al, ;colors
    cmp al, ;colors
    cmp al, ;colors
    cmp al, ;colors

count_point:
    .count_pellet: