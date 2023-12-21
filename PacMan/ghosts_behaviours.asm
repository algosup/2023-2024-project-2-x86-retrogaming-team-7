section .data

inkyStep db 0
blinkyStep db 0
clydeStep db 0
pinkyStep db 0
blinkyInitialized db 0
inkyInitialized db 0
clydeInitialized db 0
pinkyInitialized db 0
randomSeed dw 34201

update_prng:
    ; Formule simple pour le PRNG : seed = (seed * 32719 + 3) % 32768
    mov ax, [randomSeed]
    imul ax, 32719
    add ax, 3
    and ax, 0x7FFF  ; Garde seulement les 15 bits inférieurs
    mov [randomSeed], ax
    ret

blinky_switch_direction:
    cmp byte [blinkyInitialized], 0
    je .notInitialized
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision

.try_direction:
    call update_prng   ; Mettre à jour le PRNG et obtenir un nouveau nombre aléatoire dans AX
    mov dx, ax         ; Utiliser DX pour le calcul de la direction

    cmp dx, 8191
    jbe .go_up
    cmp dx, 16383
    jbe .go_left
    cmp dx, 24575
    jbe .go_down
    jmp .go_right

.go_right:
    mov ax, 4Dh
    jmp .set_direction
.go_up:
    mov ax, 48h
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    jmp .set_direction
.go_down:
    mov ax, 50h

.set_direction:
    mov [actualBDirection], ax
    call continue_movementB
    jmp .end

.notInitialized:
    mov byte [blinkyInitialized], 1
    mov ax, 4Dh
    mov [actualBDirection], ax
    call continue_movementB

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret


clyde_switch_direction:
    cmp byte [clydeInitialized], 0
    je .notInitialized
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision

.try_direction:
    call update_prng   ; Mettre à jour le PRNG et obtenir un nouveau nombre aléatoire dans AX
    mov dx, ax         ; Utiliser DX pour le calcul de la direction

    cmp dx, 8191
    jbe .go_up
    cmp dx, 16383
    jbe .go_left
    cmp dx, 24575
    jbe .go_down
    jmp .go_right

.go_right:
    mov ax, 4Dh
    jmp .set_direction
.go_up:
    mov ax, 48h
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    jmp .set_direction
.go_down:
    mov ax, 50h

.set_direction:
    mov [actualCDirection], ax
    call continue_movementC
    jmp .end

.notInitialized:
    mov byte [clydeInitialized], 1
    mov ax, 4Dh
    mov [actualCDirection], ax
    call continue_movementC

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret

inky_switch_direction:
    cmp byte [inkyInitialized], 0
    je .notInitialized
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision

.try_direction:
    call update_prng   ; Mettre à jour le PRNG et obtenir un nouveau nombre aléatoire dans AX
    mov dx, ax         ; Utiliser DX pour le calcul de la direction

    cmp dx, 8191
    jbe .go_up
    cmp dx, 16383
    jbe .go_left
    cmp dx, 24575
    jbe .go_down
    jmp .go_right

.go_right:
    mov ax, 4Dh
    jmp .set_direction
.go_up:
    mov ax, 48h
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    jmp .set_direction
.go_down:
    mov ax, 50h

.set_direction:
    mov [actualIDirection], ax
    call continue_movementB
    jmp .end

.notInitialized:
    mov byte [inkyInitialized], 1
    mov ax, 4Dh
    mov [actualIDirection], ax
    call continue_movementI

.end:
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret
    
pinky_switch_direction:
    cmp byte [pinkyInitialized], 0
    je .notInitialized
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision

.try_direction:
    call update_prng   ; Mettre à jour le PRNG et obtenir un nouveau nombre aléatoire dans AX
    mov dx, ax         ; Utiliser DX pour le calcul de la direction

    cmp dx, 8191
    jbe .go_up
    cmp dx, 16383
    jbe .go_left
    cmp dx, 24575
    jbe .go_down
    jmp .go_right

.go_right:
    mov ax, 4Dh
    mov byte [pinkyStep], 1
    jmp .set_direction
.go_up:
    mov ax, 48h
    mov byte [pinkyStep], 2
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    mov byte [pinkyStep], 3
    jmp .set_direction
.go_down:   
    mov ax, 50h
    mov byte [pinkyStep], 4

.set_direction:
    mov [actualPDirection], ax
    call continue_movementP
    ; Incrémenter blinkyStep et le réinitialiser si nécessaire
    cmp byte [pinkyStep], 4
    jne .end
    mov byte [pinkyStep], 0
    jmp .end

.notInitialized:
    mov byte [pinkyInitialized], 1
    mov ax, 50h
    mov [actualPDirection], ax
    call continue_movementP

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret