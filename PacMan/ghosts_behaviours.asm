section .data

inkyStep db 0
blinkyStep db 0
clydeStep db 0
pinkyStep db 0

blinky_switch_direction:
    ; Vérifier s'il y a eu une collision
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision  ; S'il n'y a pas de collision, ne rien faire

    ; Gérer le changement de direction en fonction de l'étape actuelle
    cmp byte [blinkyStep], 0
    je .go_left
    cmp byte [blinkyStep], 1
    je .go_down
    cmp byte [blinkyStep], 2
    je .go_right
    cmp byte [blinkyStep], 3
    je .go_up

.go_right:
    mov ax, 4Dh
    mov byte [blinkyStep], 1
    jmp .set_direction
.go_up:
    mov ax, 48h
    mov byte [blinkyStep], 2
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    mov byte [blinkyStep], 3
    jmp .set_direction
.go_down:
    mov ax, 50h
    mov byte [blinkyStep], 4

.set_direction:
    mov [actualBDirection], ax
    call continue_movementB
    ; Incrémenter blinkyStep et le réinitialiser si nécessaire
    cmp byte [blinkyStep], 4
    jne .end
    mov byte [blinkyStep], 0

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret

clyde_switch_direction:
    ; Vérifier s'il y a eu une collision
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision  ; S'il n'y a pas de collision, ne rien faire

    ; Gérer le changement de direction en fonction de l'étape actuelle
    cmp byte [clydeStep], 0
    je .go_up
    cmp byte [clydeStep], 1
    je .go_down
    cmp byte [clydeStep], 2
    je .go_right
    cmp byte [clydeStep], 3
    je .go_left

.go_right:
    mov ax, 4Dh
    mov byte [clydeStep], 1
    jmp .set_direction
.go_up:
    mov ax, 48h
    mov byte [clydeStep], 2
    jmp .set_direction
.go_left:
    mov ax, 4Bh
    mov byte [clydeStep], 3
    jmp .set_direction
.go_down:
    mov ax, 50h
    mov byte [clydeStep], 4

.set_direction:
    mov [actualCDirection], ax
    call continue_movementC
    ; Incrémenter blinkyStep et le réinitialiser si nécessaire
    cmp byte [clydeStep], 4
    jne .end
    mov byte [clydeStep], 0

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
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
    call continue_movementB
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
    
pinky_switch_direction:
    ; Vérifier s'il y a eu une collision
    mov al, [detectCollision]
    cmp al, 0
    je .no_collision  ; S'il n'y a pas de collision, ne rien faire

    ; Gérer le changement de direction en fonction de l'étape actuelle
    cmp byte [pinkyStep], 0
    je .go_right
    cmp byte [pinkyStep], 1
    je .go_up
    cmp byte [pinkyStep], 2
    je .go_left
    cmp byte [pinkyStep], 3
    je .go_down

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

.end:
    ; Réinitialiser l'indicateur de collision après avoir géré le changement de direction
    mov byte [detectCollision], 0
    ret

.no_collision:
    ret