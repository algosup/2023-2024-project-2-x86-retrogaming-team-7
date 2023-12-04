org 100h

[map all pacman.map]

%define SCREEN_WIDTH 320
%define SCREEN_HEIGHT 200


%define SPRITEW 8
%define SPRITEH 8
section .data

xPos dw 100
xVelocity dw 1
yPos dw 100

spritew dw 8

spriteh dw 8

old_XPOS dw 0

old_YPOS dw 0

currentSprite dd blinky_up_1
actualKeystroke dw 4Dh

; ====================
;   blinky sprites
; ====================
;   blinky look up
; ====================
blinky_up_1     db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x0F, 0x00, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x0F, 0x0F, 0x28, 0x0F, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x04

blinky_up_2     db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x0F, 0x00, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x0F, 0x0F, 0x28, 0x0F, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x04

blinky_up_3     db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x0F, 0x00, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x0F, 0x0F, 0x28, 0x0F, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x28, 0x04
; ====================
;   blinky look left
; ====================
blinky_left_1   db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x00, 0x0F, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x00, 0x0F, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x04

blinky_left_2   db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x00, 0x0F, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x00, 0x0F, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x04

blinky_left_3   db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x00, 0x0F, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x00, 0x0F, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x28, 0x04
; ====================
;   blinky look right
; ====================
blinky_right_1  db 0xFF, 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0xFF
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x0F, 0xFF, 0x28, 0x0F, 0xFF, 0x28
                db 0x04, 0x28, 0x0F, 0xFF, 0x28, 0x0F, 0xFF, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28

blinky_right_2  db 0xFF, 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0xFF
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x0F, 0xFF, 0x28, 0x0F, 0xFF, 0x28
                db 0x04, 0x28, 0x0F, 0xFF, 0x28, 0x0F, 0xFF, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF

blinky_right_3  db 0xFF, 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0xFF
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x0F, 0xFF, 0x28, 0x0F, 0xFF, 0x28
                db 0x04, 0x28, 0x0F, 0xFF, 0x28, 0x0F, 0xFF, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28
                db 0x04, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x28
; ====================
;   BLINKY LOOK DOWN
; ====================
blinky_down_1   db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x0F, 0x0F, 0x28, 0x0F, 0x0F, 0x28, 0x04
                db 0x28, 0x0F, 0x00, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x04

blinky_down_2   db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x0F, 0x0F, 0x28, 0x0F, 0x0F, 0x28, 0x04
                db 0x28, 0x0F, 0x00, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x04

blinky_down_3   db 0xFF, 0xFF, 0x28, 0x28, 0x28, 0x28, 0x04, 0xFF
                db 0xFF, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x0F, 0x0F, 0x28, 0x0F, 0x0F, 0x28, 0x04
                db 0x28, 0x0F, 0x00, 0x28, 0x00, 0x0F, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x04
                db 0xFF, 0x28, 0xFF, 0x28, 0xFF, 0x28, 0x28, 0x04

section .bss
keyPressed resb 1  ; Réserve un byte pour l'état de la touche
section .text
start:
    ; Initialisation du mode vidéo
    mov ah, 00h
    mov al, 13h
    int 10h
    ; Boucle principale du jeu
    mov si, [currentSprite]

       
    
    gameloop:
    xor al, al
    call clearScreen  ; Clear the entire screen
    call clearSprite  ; Clear the old sprite before drawing a new one
    call draw_sprite
    call read_character_key_was_pressed

    ; Delay to slow down the animation
    mov cx, 64000
    waitloop:
        loop waitloop
    jmp gameloop
    ; Fin du jeu, retour au mode texte
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

; Fonction pour lire la touche pressée
read_character_key_was_pressed:
    mov ah, 01h        ; Check if a key has been pressed (non-blocking)
    int 16h
    jz continue_movement ; If no key pressed, continue current movement

    ; Read the keystroke
    mov ah, 00h
    int 16h
    mov [actualKeystroke], ah  ; Store the new direction

clearSprite:
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

move_right:
    mov word [actualKeystroke], 4Dh
    call blinky_right
    mov bx, [xPos]
    add bx, 2
    cmp bx, SCREEN_WIDTH - SPRITEW 
    jae .skip_move_right
    mov [xPos], bx
.skip_move_right:
    ret
move_left:
    mov word [actualKeystroke], 4Bh
    call blinky_left
    mov bx, [xPos]
    sub bx, 2
    cmp bx, 0
    jbe .skip_move_left
    mov [xPos], bx
.skip_move_left:
    ret

move_up:
    mov word [actualKeystroke], 48h
    call blinky_up
    mov bx, [yPos]
    sub bx, 2
    cmp bx, 0
    jbe .skip_move_up
    mov [yPos], bx
.skip_move_up:
    ret

move_down:
    mov word [actualKeystroke], 50h
    call blinky_down
    mov bx, [yPos]
    add bx, 2
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

blinky_right:
    cmp word [currentSprite], blinky_right_1
    je .blinkyRightSemiOpen
    cmp word [currentSprite], blinky_right_2
    je .blinkyRightOpen
    cmp word [currentSprite], blinky_right_3
    je .blinkyRightClose

    .blinkyRightOpen:
       mov word [currentSprite], blinky_right_1
       mov si, [currentSprite]
       ret
    .blinkyRightSemiOpen:
        mov word [currentSprite], blinky_right_2
        mov si, [currentSprite]
        ret
    .blinkyRightClose:
        mov word [currentSprite], blinky_right_3
        mov si, [currentSprite]
        ret

    blinky_left:
    cmp word [currentSprite], blinky_left_1
    je .blinkyLeftSemiOpen
    cmp word [currentSprite], blinky_left_2
    je .blinkyLeftClose
    cmp word [currentSprite], blinky_left_3
    je .blinkyLeftOpen

    .blinkyLeftOpen:
       mov word [currentSprite], blinky_left_1
       mov si, [currentSprite]
       ret
    .blinkyLeftSemiOpen:
        mov word [currentSprite], blinky_left_2
        mov si, [currentSprite]
        ret
    .blinkyLeftClose:
        mov word [currentSprite], blinky_left_3
        mov si, [currentSprite]
        ret

    blinky_up:
    cmp word [currentSprite], blinky_up_1
    je .blinkyUpSemiOpen
    cmp word [currentSprite], blinky_up_2
    je .blinkyUpClose
    cmp word [currentSprite], blinky_up_3
    je .blinkyUpOpen

    .blinkyUpOpen:
       mov word [currentSprite], blinky_up_1
       mov si, [currentSprite]
       ret
    .blinkyUpSemiOpen:
        mov word [currentSprite], blinky_up_2
        mov si, [currentSprite]
        ret
    .blinkyUpClose:
        mov word [currentSprite], blinky_up_3
        mov si, [currentSprite]
        ret
    
    blinky_down:
    cmp word [currentSprite], blinky_down_1
    je .blinkyDownSemiOpen
    cmp word [currentSprite], blinky_down_2
    je .blinkyDownClose
    cmp word [currentSprite], blinky_down_3
    je .blinkyDownOpen

    .blinkyDownOpen:
       mov word [currentSprite], blinky_down_1
       mov si, [currentSprite]
       ret
    .blinkyDownSemiOpen:
        mov word [currentSprite], blinky_down_2
        mov si, [currentSprite]
        ret
    .blinkyDownClose:
        mov word [currentSprite], blinky_down_3
        mov si, [currentSprite]
        ret

; Fonction pour effacer l'écran
draw_sprite:
    ; Avant de dessiner le sprite, sauvegardez la position actuelle
    mov ax, [xPos]
    mov [old_XPOS], ax  ; Sauvegarde l'ancienne position X
    mov ax, [yPos]
    mov [old_YPOS], ax  ; Sauvegarde l'ancienne position Y
    ; Réinitialise le segment graphique
    mov ax, 0A000h
    mov es, ax
    ; Calcule l'adresse à l'écran où le sprite sera dessiné
    mov ax, [yPos]
    imul ax, 320       ; Multiplie yPos par la largeur de l'écran pour obtenir l'offset
    add ax, [xPos]     ; Ajoute xPos à l'offset
    mov di, ax         ; DI = adresse de départ pour le dessin
    ; Obtient l'adresse du sprite à dessiner
    ; Définit la hauteur du sprite
    mov cx, SPRITEH
.draw_line:
    ; Sauvegarde CX car il est modifié par REP MOVSB
    push cx
    ; Définit la largeur du sprite pour la ligne actuelle
    mov cx, SPRITEW
    rep movsb  ; Dessine la ligne du sprite à l'écran
    ; Restaure CX pour la prochaine ligne
    pop cx
    ; Ajuste DI pour la ligne suivante en prenant en compte l'offset de la largeur de l'écran
    add di, 320 - SPRITEW
    loop .draw_line  ; Répète le dessin pour chaque ligne du sprite
    ret