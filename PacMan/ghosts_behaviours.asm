section .data

blinkyOut db 0
inkyOut db 1
clydeOut db 0
pinkyOut db 0
inkyStep db 0


ghosts_out_check:
    mov al, [blinkyOut]
    cmp al, 0
    je blinky_out_spawn
    mov al, [inkyOut]
    cmp al, 0
    je inky_out_spawn
    mov al, [clydeOut]
    cmp al, 0
    je clyde_out_spawn
    mov al, [pinkyOut]
    cmp al, 0
    je pinky_out_spawn
    ret


blinky_out_spawn:
    mov al, [xPosBlinky]
    cmp al, 156
    jne .right
    cmp al, 156
    je .up
    ret
    .right:
        call blinky_right
        mov al, [xPosBlinky]
        inc al
        mov [xPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret
    .up:
        call blinky_up
        mov al, [yPosBlinky]
        dec al
        mov [yPosBlinky], al
        call clearGhostB
        call draw_blinky
        mov al, [yPosBlinky]
        cmp al, 80
        je .done
        ret
    .done:
        mov al, [blinkyOut]
        inc al
        mov [blinkyOut], al
        ret

inky_out_spawn:
    mov al, [xPosInky]
    cmp al, 156
    jne .right
    cmp al, 156
    je .up
    ret
    .right:
        call inky_right
        mov al, [xPosInky]
        inc al
        mov [xPosInky], al
        call clearGhostI
        call draw_inky
        ret
    .up:
        call inky_up
        mov al, [yPosInky]
        dec al
        mov [yPosInky], al
        call clearGhostI
        call draw_inky
        mov al, [yPosInky]
        cmp al, 80
        je .done
        ret
    .done:
        mov al, [inkyOut]
        inc al
        mov [inkyOut], al
        ret


clyde_out_spawn:
    mov al, [xPosClyde]
    cmp al, 156
    jne .left
    cmp al, 156
    je .up
    ret
    .left:
        call clyde_left
        mov al, [xPosClyde]
        dec al
        mov [xPosClyde], al
        call clearGhostC
        call draw_clyde
        ret
    .up:
        call clyde_up
        mov al, [yPosClyde]
        dec al
        mov [yPosClyde], al
        call clearGhostC
        call draw_clyde
        mov al, [yPosClyde]
        cmp al, 80
        je .done
        ret
    .done:
        mov al, [clydeOut]
        inc al
        mov [clydeOut], al
        ret


pinky_out_spawn:
    mov al, [xPosPinky]
    cmp al, 156
    jne .left
    cmp al, 156
    je .up
    ret
    .left:
        call pinky_left
        mov al, [xPosPinky]
        dec al
        mov [xPosPinky], al
        call clearGhostP
        call draw_pinky
        ret
    .up:
        call pinky_up
        mov al, [yPosPinky]
        dec al
        mov [yPosPinky], al
        call clearGhostP
        call draw_pinky
        mov al, [yPosPinky]
        cmp al, 80
        je .done
        ret
    .done:
        mov al, [pinkyOut]
        inc al
        mov [pinkyOut], al
        ret
reset_ghosts_out:
    mov al, [blinkyOut]
    dec al
    mov [blinkyOut], al

    mov al, [inkyOut]
    dec al
    mov [inkyOut], al

    mov al, [clydeOut]
    dec al
    mov [clydeOut], al

    mov al, [pinkyOut]
    dec al
    mov [pinkyOut], al

    ret

; ===============================================
; ================+ RANDOMIZER ==================
; ===============================================

randomizer_direction_blinky:
    mov AH, 00h  ; interrupts to get system time        
    int 1Ah      ; CX:DX now hold number of clock ticks since midnight      
    mov  ax, dx
    xor  dx, dx
    mov  cx, 10    
    div  cx       ; here dx contains the remainder of the division - from 0 to 9

    cmp dx, 2
    jle .set_right
    cmp dx, 5
    jle .set_left
    cmp dx, 7
    jle .set_up
    cmp dx, 9
    jle .set_down

    .set_right:
        mov ax, 4Dh
        mov [actualBDirection], ax
        ret
    .set_left:
        mov ax, 4Bh
        mov [actualBDirection], ax
        ret
    .set_up:
        mov ax, 48h
        mov [actualBDirection], ax
        ret
    .set_down:
        mov ax, 50h
        mov [actualBDirection], ax
        ret

randomizer_direction_inky:
    mov AH, 00h  ; interrupts to get system time        
    int 1Ah      ; CX:DX now hold number of clock ticks since midnight      
    mov  ax, dx
    xor  dx, dx
    mov  cx, 10    
    div  cx       ; here dx contains the remainder of the division - from 0 to 9

    cmp dx, 2
    jle .set_right
    cmp dx, 5
    jle .set_left
    cmp dx, 7
    jle .set_up
    cmp dx, 9
    jle .set_down

    .set_right:
        mov ax, 4Dh
        mov [actualIDirection], ax
        ret
    .set_left:
        mov ax, 4Bh
        mov [actualIDirection], ax
        ret
    .set_up:
        mov ax, 48h
        mov [actualIDirection], ax
        ret
    .set_down:
        mov ax, 50h
        mov [actualIDirection], ax
        ret

randomizer_direction_clyde:
   mov AH, 00h  ; interrupts to get system time        
    int 1Ah      ; CX:DX now hold number of clock ticks since midnight      
    mov  ax, dx
    xor  dx, dx
    mov  cx, 10    
    div  cx       ; here dx contains the remainder of the division - from 0 to 9

    cmp dx, 2
    jle .set_right
    cmp dx, 5
    jle .set_left
    cmp dx, 7
    jle .set_up
    cmp dx, 9
    jle .set_down

    .set_right:
        mov ax, 4Dh
        mov [actualCDirection], ax
        ret
    .set_left:
        mov ax, 4Bh
        mov [actualCDirection], ax
        ret
    .set_up:
        mov ax, 48h
        mov [actualCDirection], ax
        ret
    .set_down:
        mov ax, 50h
        mov [actualCDirection], ax
        ret

randomizer_direction_pinky:
    mov AH, 00h  ; interrupts to get system time        
    int 1Ah      ; CX:DX now hold number of clock ticks since midnight      
    mov  ax, dx
    xor  dx, dx
    mov  cx, 10    
    div  cx       ; here dx contains the remainder of the division - from 0 to 9

    cmp dx, 2
    jle .set_right
    cmp dx, 5
    jle .set_left
    cmp dx, 7
    jle .set_up
    cmp dx, 9
    jle .set_down

    .set_right:
        mov ax, 4Dh
        mov [actualPDirection], ax
        ret
    .set_left:
        mov ax, 4Bh
        mov [actualPDirection], ax
        ret
    .set_up:
        mov ax, 48h
        mov [actualPDirection], ax
        ret
    .set_down:
        mov ax, 50h
        mov [actualPDirection], ax
        ret




blinky_swith_direction:
    mov al, [blinkyOut]
    cmp al, 1
    je .valid_check
    ret
    .valid_check:
        mov ah, [xPosBlinky]
        and ah, 7
        cmp ah, 0
        je .confirm
        ret
    .valid_check2:
        mov ah, [yPosBlinky]
        and ah, 7
        cmp ah, 0
        je .confirm
        ret
    .confirm:
        call randomizer_direction_blinky
        ret

inky_switch_direction:
    ; Vérifier s'il y a eu une collision
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision  ; S'il n'y a pas de collision, ne rien faire

    ; Gérer le changement de direction en fonction de l'étape actuelle
    cmp byte [inkyStep], 0
    je .go_right
    cmp byte [inkyStep], 1
    je .go_up
    cmp byte [inkyStep], 2
    je .go_left
    cmp byte [inkyStep], 3
    je .go_down

.go_right:
    mov ax, 4Dh
    mov byte [inkyStep], 1
    jmp .set_direction
.go_up:
    mov ax, 48h
    mov byte [inkyStep], 2
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    mov byte [inkyStep], 3
    jmp .set_direction
.go_down:
    mov ax, 50h
    mov byte [inkyStep], 4

.set_direction:
    mov [actualIDirection], ax
    call continue_movementI
    ; Incrémenter blinkyStep et le réinitialiser si nécessaire
    cmp byte [inkyStep], 4
    jne .end
    mov byte [inkyStep], 0

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret

clyde_swith_direction:
pinky_swith_direction: