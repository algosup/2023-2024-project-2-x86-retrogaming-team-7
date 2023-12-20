section .data

blinkyfr db 0
inkyfr db 0
clydefr db 0
pinkyfr db 0

blinkyOut db 0
inkyOut db 0
clydeOut db 0
pinkyOut db 0

ghosts_behavior:
    call ghosts_out_check
    cmp byte [pinkyOut], 1
    je .setup
    ret
    .setup:
        call blinky_setup
        call inky_setup
        call clyde_setup
        call pinky_setup
        ret


ghosts_out_check:
    mov al, [blinkyfr]
    cmp al, 0
    je blinky_out_spawn
    mov al, [inkyfr]
    cmp al, 0
    je inky_out_spawn
    mov al, [clydefr]
    cmp al, 0
    je clyde_out_spawn
    mov al, [pinkyfr]
    cmp al, 0
    je pinky_out_spawn
    ret


blinky_out_spawn:
    mov al, [xPosBlinky]
    cmp al, 156
    jne .right
    cmp al, 156
    je .done
    ret
    .right:
        call blinky_right
        mov al, [xPosBlinky]
        inc al
        mov [xPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret
    .done:
        mov al, [blinkyfr]
        inc al
        mov [blinkyfr], al
        add byte [blinkyOut], 1
        ret

inky_out_spawn:
    mov al, [xPosInky]
    cmp al, 156
    jne .right
    cmp al, 156
    je .done
    ret
    .right:
        call inky_right
        mov al, [xPosInky]
        inc al
        mov [xPosInky], al
        call clearGhostI
        call draw_inky
        ret
    .done:
        mov al, [inkyfr]
        inc al
        mov [inkyfr], al
        add byte [inkyOut], 1
        ret


clyde_out_spawn:
    mov al, [xPosClyde]
    cmp al, 156
    jne .right
    cmp al, 156
    je .done
    ret
    .right:
        call clyde_right
        mov al, [xPosClyde]
        dec al
        mov [xPosClyde], al
        call clearGhostC
        call draw_clyde
        ret
    .done:
        mov al, [clydefr]
        inc al
        mov [clydefr], al
        add byte [clydeOut], 1
        ret

pinky_out_spawn:
    mov al, [xPosPinky]
    cmp al, 156
    jne .right
    cmp al, 156
    je .done
    ret
    .right:
        call pinky_right
        mov al, [xPosPinky]
        dec al
        mov [xPosPinky], al
        call clearGhostP
        call draw_pinky
        ret
    .done:
        mov al, [pinkyfr]
        inc al
        mov [pinkyfr], al
        add byte [pinkyOut], 1
        ret

reset_ghosts_out:
    mov al, [blinkyfr]
    dec al
    mov [blinkyfr], al
    mov al, [inkyfr]
    dec al
    mov [inkyfr], al
    mov al, [clydefr]
    dec al
    mov [clydefr], al
    mov al, [pinkyfr]
    dec al
    mov [pinkyfr], al
    mov al, [pinkyOut]
    dec al
    mov [pinkyOut], al
    ret

; ===============================================
; =================== BLINKY ====================
; ===============================================

blinky_setup:
    mov al, [yPosBlinky]
    cmp al, 80
    jne .up
    mov al, [xPosBlinky]
    cmp al, 144
    jne .left
    cmp al, 144
    je blinky_behavior
    ret
    .up:
        call blinky_up
        mov al, [yPosBlinky]
        dec al
        mov [yPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret
    .left:
        call blinky_left
        mov al, [xPosBlinky]
        dec al
        mov [xPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret


blinky_behavior:
    call blinky_up          ; loop point
    
    ret
    .right:
        call blinky_right
        mov al, [xPosBlinky]
        inc al
        mov [xPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret
    .left:
        call blinky_left
        mov al, [xPosBlinky]
        dec al
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
        ret
    .down:
        call blinky_down
        mov al, [yPosBlinky]
        inc al
        mov [yPosBlinky], al
        call clearGhostB
        call draw_blinky
        ret

; ===============================================
; ==================== INKY =====================
; ===============================================

inky_setup:
    mov al, [yPosInky]
    cmp al, 80
    jne .up
    mov al, [xPosInky]
    cmp al, 128
    jne .left
    cmp al, 128
    je inky_behavior
    .up:
        call inky_up
        mov al, [yPosInky]
        dec al
        mov [yPosInky], al
        call clearGhostI
        call draw_inky
        ret
    .left:
        call inky_left
        mov al, [xPosInky]
        dec al
        mov [xPosInky], al
        call clearGhostI
        call draw_inky
        ret
    ret

inky_behavior:
    call inky_down          ; loop point
    
    ret

; ===============================================
; =================== CLYDE =====================
; ===============================================

clyde_setup:
    mov al, [yPosClyde]
    cmp al, 80
    jne .up
    mov al, [xPosClyde]
    cmp al, 168
    jne .right
    cmp al, 168
    je clyde_behavior
    .up:
        call clyde_up
        mov al, [yPosClyde]
        dec al
        mov [yPosClyde], al
        call clearGhostC
        call draw_clyde
        ret
    .right:
        call clyde_left
        mov al, [xPosClyde]
        inc al
        mov [xPosClyde], al
        call clearGhostC
        call draw_clyde
        ret
    ret

clyde_behavior:
    call clyde_up          ; loop point
    
    ret

; ===============================================
; ==================== PINKY ====================
; ===============================================

pinky_setup:
    mov al, [yPosPinky]
    cmp al, 80
    jne .up
    mov al, [xPosPinky]
    cmp al, 184
    jne .right
    cmp al, 184
    je pinky_behavior
    .up:
        call pinky_up
        mov al, [yPosPinky]
        dec al
        mov [yPosPinky], al
        call clearGhostP
        call draw_pinky
        ret
    .right:
        call pinky_right
        mov al, [xPosPinky]
        inc al
        mov [xPosPinky], al
        call clearGhostP
        call draw_pinky
        ret
    ret

pinky_behavior:
    call pinky_down          ; loop point
    
    ret
