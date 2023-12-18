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
scoreCurrentSprite dd 0

yScorePos dw 0
xScorePos dw 0
%define SPRITEW 8
%define SPRITEH 8

section .text

display_score:
    ; Affiche "S"
    mov word [scoreCurrentSprite], alphabetS
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 264
    mov word [yScorePos], 21
    call scoringDraw

    ; Affiche "C"
    mov word [scoreCurrentSprite], alphabetC
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 272  ; 10 + 8
    call scoringDraw

    ; Affiche "O"
    mov word [scoreCurrentSprite], alphabetO
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 280  ; 18 + 8
    call scoringDraw

    ; Affiche "R"
    mov word [scoreCurrentSprite], alphabetR
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 288  ; 26 + 8
    call scoringDraw

    ; Affiche "E"
    mov word [scoreCurrentSprite], alphabetE
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 296  ; 34 + 8
    call scoringDraw
    
    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 264
    call scoringDraw

    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 272
    call scoringDraw

    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 280
    call scoringDraw

    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 288
    call scoringDraw

    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 296
    call scoringDraw

    ret

scoringDraw:
    mov ax, [xScorePos]
    mov ax, [yScorePos]
    ; Reset the graphic segment
    mov ax, 0A000h
    mov es, ax
    ; Cacul the addresse to the screen where the sprite will be draw
    mov ax, [yScorePos]
    imul ax, 320       ;  Multiply yPos par the width of screen to get the offset
    add ax, [xScorePos]     ; Add xPos to the offset
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