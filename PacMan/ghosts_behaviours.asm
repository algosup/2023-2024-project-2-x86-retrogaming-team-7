section .data


blinkyOut db 0

inkyOut db 0

clydeOut db 0

pinkyOut db 0


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
        mov al, [xPosBlinky]
        inc al
        mov [xPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret
    .up:
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
        mov al, [xPosInky]
        inc al
        mov [xPosInky], al
        call clearGhostI
        call draw_inky
        ret
    .up:
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
    jne .right
    cmp al, 156
    je .up
    ret
    .right:
        mov al, [xPosClyde]
        dec al
        mov [xPosClyde], al
        call clearGhostC
        call draw_clyde
        ret
    .up:
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
    jne .right
    cmp al, 156
    je .up
    ret
    .right:
        mov al, [xPosPinky]
        dec al
        mov [xPosPinky], al
        call clearGhostP
        call draw_pinky
        ret
    .up:
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