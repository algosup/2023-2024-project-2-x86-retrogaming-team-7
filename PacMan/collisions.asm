section .data
detectCollision db 0
hitPacMan db 0
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
     cmp al, 0xFF
     je .collision
     cmp al, 0x37
     je .collision
     mov byte [detectCollision], 0
     ret
     .collision: ; Collision do not exist
          mov byte [detectCollision], 1 ; Collision detected
          ret
          
;=================================
;      PACMAN DETECTION
;=================================
check_detection_pacman:
     ; Convert position to screen buffer index
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x0E
     je .collision
     ret
     .collision: ; Collision do not exist
          mov bx, [lives]
          dec bx
          mov [lives], bx
          jmp SetSpawnPosition
;=================================================
;              PELLETS COLLISIONS
;=================================================
check_detection_pellets_right:
     ; Convert position to screen buffer index
     mov ax, [xPos]
     mov bx, [yPos]
     add ax, SPRITEH
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_right
     call erase_pellet_right ; Effacer le pellet et compter les points
     jmp collisionP
no_collisionP_right:
     ret

erase_pellet_right:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_left:
     ; Convert position to screen buffer index
     mov ax, [xPos]
     mov bx, [yPos]
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_left
     call erase_pellet_left ; Effacer le pellet et compter les points
     jmp collisionP
no_collisionP_left:
     ret

erase_pellet_left:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 321
     mov es:[si], al
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_up:
     ; Convert position to screen buffer index
     mov ax, [xPos]
     mov bx, [yPos]
     add ax, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_up
     call erase_pellet_up ; Effacer le pellet et compter les points
     jmp collisionP
no_collisionP_up:
     ret

erase_pellet_up:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     sub si, 320
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_down:
     ; Convert position to screen buffer index
     mov ax, [xPos]
     mov bx, [yPos]
     add ax, 3
     add bx, SPRITEH
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_down
     call erase_pellet_down ; Effacer le pellet et compter les points
     jmp collisionP
no_collisionP_down:
     ret

erase_pellet_down:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel en dessous
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al   ;STOP HERE
     ret

collisionP:
     dec word [pelletsNumbers]
     call pelletsPoints
     call checkPelletNumber
     ret
collisionSP:
     dec word [superPelletsNumbers]
     call superPelletUpdate
     call checkSuperPelletNumber
     ret


;=================================================
;          BLINKY PELLETS
;=================================================
check_detection_pellets_rightBlinky:
     ; Convert position to screen buffer index
     mov ax, [xPosBlinky]
     mov bx, [yPosBlinky]
     add ax, SPRITEH
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_rightGhost
     call erase_pellet_rightGhost ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_rightGhost:
     ret

erase_pellet_rightGhost:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_leftBlinky:
     ; Convert position to screen buffer index
     mov ax, [xPosBlinky]
     mov bx, [yPosBlinky]
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_leftBlinky
     call erase_pellet_leftBlinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_leftBlinky:
     ret

erase_pellet_leftBlinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 321
     mov es:[si], al
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_upBlinky:
     ; Convert position to screen buffer index
     mov ax, [xPosBlinky]
     mov bx, [yPosBlinky]
     add ax, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_upBlinky
     call erase_pellet_upBlinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_upBlinky:
     ret

erase_pellet_upBlinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     sub si, 320
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_downBlinky:
     ; Convert position to screen buffer index
     mov ax, [xPosBlinky]
     mov bx, [yPosBlinky]
     add ax, 3
     add bx, SPRITEH
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_downBlinky
     call erase_pellet_downBlinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_downBlinky:
     ret

erase_pellet_downBlinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel en dessous
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al   ;STOP HERE
     ret

check_detection_SuperPellets_rightBlinky:
     ; Convert position to screen buffer index
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
          
check_detection_SuperPellets_leftBlinky:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
check_detection_SuperPellets_upBlinky:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 2
          sub bx, 3
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_upBlinky
          call erase_super_pellet_upBlinky
          jmp collisionSPGhost
          ret
no_collisionSP_upBlinky:
     ret
erase_super_pellet_upBlinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel en dessous
     sub si, 320
     mov es:[si], al
     sub si, 319
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add  si, 320
     mov es:[si], al
     inc si
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     add si, 321
     mov es:[si], al
     add si, 320
     mov es:[si], al
     ret
     
check_detection_SuperPellets_downBlinky:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 3
          add bx, SPRITEH
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_downBlinky
          call erase_super_pellet_downBlinky
          jmp collisionSPGhost
          ret

no_collisionSP_downBlinky:
     ret

erase_super_pellet_downBlinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     add si, 1
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 317
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     ret

;=================================================
;          INKY PELLETS
;=================================================

check_detection_pellets_rightInky:
     ; Convert position to screen buffer index
     mov ax, [xPosInky]
     mov bx, [yPosInky]
     add ax, SPRITEH
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_rightGhostInky
     call erase_pellet_rightGhostInky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_rightGhostInky:
     ret

erase_pellet_rightGhostInky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_LeftInky:
     ; Convert position to screen buffer index
     mov ax, [xPosInky]
     mov bx, [yPosInky]
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_LeftInky
     call erase_pellet_LeftInky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_LeftInky:
     ret

erase_pellet_LeftInky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 321
     mov es:[si], al
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_UpInky:
     ; Convert position to screen buffer index
     mov ax, [xPosInky]
     mov bx, [yPosInky]
     add ax, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_UpInky
     call erase_pellet_UpInky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_UpInky:
     ret

erase_pellet_UpInky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     sub si, 320
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_DownInky:
     ; Convert position to screen buffer index
     mov ax, [xPosInky]
     mov bx, [yPosInky]
     add ax, 3
     add bx, SPRITEH
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_DownInky
     call erase_pellet_DownInky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_DownInky:
     ret

erase_pellet_DownInky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel en dessous
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al   ;STOP HERE
     ret

check_detection_SuperPellets_rightInky:
     ; Convert position to screen buffer index
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
          
check_detection_SuperPellets_LeftInky:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
check_detection_SuperPellets_UpInky:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 2
          sub bx, 3
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_UpInky
          call erase_super_pellet_UpInky
          jmp collisionSPGhost
          ret
no_collisionSP_UpInky:
     ret
erase_super_pellet_UpInky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel en dessous
     sub si, 320
     mov es:[si], al
     sub si, 319
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add  si, 320
     mov es:[si], al
     inc si
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     add si, 321
     mov es:[si], al
     add si, 320
     mov es:[si], al
     ret
     
check_detection_SuperPellets_DownInky:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 3
          add bx, SPRITEH
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_DownInky
          call erase_super_pellet_DownInky
          jmp collisionSPGhost
          ret

no_collisionSP_DownInky:
     ret

erase_super_pellet_DownInky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     add si, 1
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 317
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     ret

;=================================================
;          CLYDE PELLETS
;=================================================

check_detection_pellets_rightClyde:
     ; Convert position to screen buffer index
     mov ax, [xPosClyde]
     mov bx, [yPosClyde]
     add ax, SPRITEH
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_rightGhostClyde
     call erase_pellet_rightGhostClyde ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_rightGhostClyde:
     ret

erase_pellet_rightGhostClyde:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_LeftClyde:
     ; Convert position to screen buffer index
     mov ax, [xPosClyde]
     mov bx, [yPosClyde]
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_LeftClyde
     call erase_pellet_LeftClyde ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_LeftClyde:
     ret

erase_pellet_LeftClyde:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 321
     mov es:[si], al
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_UpClyde:
     ; Convert position to screen buffer index
     mov ax, [xPosClyde]
     mov bx, [yPosClyde]
     add ax, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_UpClyde
     call erase_pellet_UpClyde ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_UpClyde:
     ret

erase_pellet_UpClyde:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     sub si, 320
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_DownClyde:
     ; Convert position to screen buffer index
     mov ax, [xPosClyde]
     mov bx, [yPosClyde]
     add ax, 3
     add bx, SPRITEH
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_DownClyde
     call erase_pellet_DownClyde ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_DownClyde:
     ret

erase_pellet_DownClyde:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel en dessous
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al   ;STOP HERE
     ret

check_detection_SuperPellets_rightClyde:
     ; Convert position to screen buffer index
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
          
check_detection_SuperPellets_LeftClyde:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
check_detection_SuperPellets_UpClyde:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 2
          sub bx, 3
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_UpClyde
          call erase_super_pellet_UpClyde
          jmp collisionSPGhost
          ret
no_collisionSP_UpClyde:
     ret
erase_super_pellet_UpClyde:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel en dessous
     sub si, 320
     mov es:[si], al
     sub si, 319
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add  si, 320
     mov es:[si], al
     inc si
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     add si, 321
     mov es:[si], al
     add si, 320
     mov es:[si], al
     ret
     
check_detection_SuperPellets_DownClyde:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 3
          add bx, SPRITEH
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_DownClyde
          call erase_super_pellet_DownClyde
          jmp collisionSPGhost
          ret

no_collisionSP_DownClyde:
     ret

erase_super_pellet_DownClyde:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     add si, 1
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 317
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     ret

;=================================================
;          PINKY PELLETS
;=================================================


check_detection_pellets_rightPinky:
     ; Convert position to screen buffer index
     mov ax, [xPosPinky]
     mov bx, [yPosPinky]
     add ax, SPRITEH
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_rightGhostPinky
     call erase_pellet_rightGhostPinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_rightGhostPinky:
     ret

erase_pellet_rightGhostPinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_LeftPinky:
     ; Convert position to screen buffer index
     mov ax, [xPosPinky]
     mov bx, [yPosPinky]
     add bx, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_LeftPinky
     call erase_pellet_LeftPinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_LeftPinky:
     ret

erase_pellet_LeftPinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel suivant
     add si, 321
     mov es:[si], al
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_UpPinky:
     ; Convert position to screen buffer index
     mov ax, [xPosPinky]
     mov bx, [yPosPinky]
     add ax, 3
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_UpPinky
     call erase_pellet_UpPinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_UpPinky:
     ret

erase_pellet_UpPinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel actuel
     sub si, 320
     mov es:[si], al ; Effacer le pixel actuel
     dec si
     mov es:[si], al ; Effacer le pixel actuel
     ret

check_detection_pellets_DownPinky:
     ; Convert position to screen buffer index
     mov ax, [xPosPinky]
     mov bx, [yPosPinky]
     add ax, 3
     add bx, SPRITEH
     imul bx, SCREEN_WIDTH
     add bx, ax
     mov si, bx
     mov ax, 0A000h
     mov es, ax
     mov al, es:[si]
     cmp al, 0x42
     jne no_collisionP_DownPinky
     call erase_pellet_DownPinky ; Effacer le pellet et compter les points
     jmp collisionPGhost
no_collisionP_DownPinky:
     ret

erase_pellet_DownPinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     inc si
     mov es:[si], al ; Effacer le pixel en dessous
     add si, 319
     mov es:[si], al
     inc si
     mov es:[si], al   ;STOP HERE
     ret

check_detection_SuperPellets_rightPinky:
     ; Convert position to screen buffer index
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
          
check_detection_SuperPellets_LeftPinky:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSPGhost
          ret
check_detection_SuperPellets_UpPinky:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 2
          sub bx, 3
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_UpPinky
          call erase_super_pellet_UpPinky
          jmp collisionSPGhost
          ret
no_collisionSP_UpPinky:
     ret
erase_super_pellet_UpPinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel en dessous
     sub si, 320
     mov es:[si], al
     sub si, 319
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add  si, 320
     mov es:[si], al
     inc si
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     add si, 321
     mov es:[si], al
     add si, 320
     mov es:[si], al
     ret
     
check_detection_SuperPellets_DownPinky:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 3
          add bx, SPRITEH
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_DownPinky
          call erase_super_pellet_DownPinky
          jmp collisionSPGhost
          ret

no_collisionSP_DownPinky:
     ret

erase_super_pellet_DownPinky:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     add si, 1
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 317
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     ret

collisionPGhost:
     dec word [pelletsNumbers]
     call checkPelletNumber
     ret

collisionSPGhost:
     dec word [superPelletsNumbers]
     call checkSuperPelletNumber
     ret
;=================================================
;             SUPER PELLETS COLLISIONS
;=================================================
check_detection_SuperPellets_right:
     ; Convert position to screen buffer index
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSP
          ret
          
check_detection_SuperPellets_left:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 4
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          je collisionSP
          ret
check_detection_SuperPellets_up:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 2
          sub bx, 3
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_up
          call erase_super_pellet_up
          jmp collisionSP
          ret
no_collisionSP_up:
     ret
erase_super_pellet_up:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel en dessous
     sub si, 320
     mov es:[si], al
     sub si, 319
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add si, 320
     mov es:[si], al
     add  si, 320
     mov es:[si], al
     inc si
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     sub si, 320
     mov es:[si], al
     add si, 321
     mov es:[si], al
     add si, 320
     mov es:[si], al
     ret
     
check_detection_SuperPellets_down:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 3
          add bx, SPRITEH
          imul bx, SCREEN_WIDTH
          add bx, ax
          mov si, bx
          mov ax, 0A000h
          mov es, ax
          mov al, es:[si]
          cmp al, 0x2B
          jne no_collisionSP_down
          call erase_super_pellet_down
          jmp collisionSP
          ret

no_collisionSP_down:
     ret

erase_super_pellet_down:
     ; Effacer le pellet de la carte
     mov al, 0 ; Couleur d'arrière-plan
     mov es:[si], al ; Effacer le pixel actuel
     add si, 1
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 317
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     inc si
     mov es:[si], al
     add si, 318
     mov es:[si], al
     inc si
     mov es:[si], al
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

check_collision_pacman_waitingKeystroke:
     cmp word [waitingKeystroke], 4Dh  ; Right
     je check_right_pac
     cmp word [waitingKeystroke], 4Bh  ; Left
     je check_left_pac
     cmp word [waitingKeystroke], 48h  ; Up
     je check_up_pac
     cmp word [waitingKeystroke], 50h  ; Down
     je check_down_pac
     ret


check_right_pac:
     .check_right_pac_0:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_1
          ret
     .check_right_pac_1:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_2
          ret
     .check_right_pac_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_3
          ret
     .check_right_pac_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_4
          ret 
     .check_right_pac_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_5
          ret
     .check_right_pac_5: 
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEW
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_6
          ret
     .check_right_pac_6:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_7
          ret
     .check_right_pac_7:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pac_over
          ret         
     .check_right_pac_over:
          mov bx, [xPos]
          add bx, 1
          mov [xPos], bx
          ret
     
check_left_pac:
     .check_left_pac_0:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_1
          ret
     .check_left_pac_1:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_2
          ret
     .check_left_pac_2:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_3
          ret
     .check_left_pac_3:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_4
          ret

     .check_left_pac_4:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_5
          ret
     .check_left_pac_5:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 5
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_6
          ret
     .check_left_pac_6:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pac_7
          ret
     .check_left_pac_7:
          mov ax, [xPos]
          mov bx, [yPos]
          sub ax, 1
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_1
          ret
     .check_up_pac_1:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 1
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_2
          ret
     .check_up_pac_2:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 2
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_3
          ret
     .check_up_pac_3:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 3
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_4
          ret
     .check_up_pac_4:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_5
          ret
     .check_up_pac_5:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_6
          ret
     .check_up_pac_6:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pac_7
          ret
     .check_up_pac_7:
          mov ax, [xPos]
          mov bx, [yPos]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
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
        add bx, SPRITEW
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_1
        ret
    .check_down_pac_1:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW
        add ax, 1
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_2
        ret
    .check_down_pac_2:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW
        add ax, 2
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_3
        ret
    .check_down_pac_3:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW
        add ax, 3
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_4
        ret
    .check_down_pac_4:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW
        add ax, 4
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_5
        ret
    .check_down_pac_5:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW
        add ax, 5
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_6
        ret
    .check_down_pac_6:
        mov ax, [xPos]
        mov bx, [yPos] 
        add bx, SPRITEW
        add ax, 6
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pac_7
        ret
    
    .check_down_pac_7:
        mov ax, [xPos]
        mov bx, [yPos]
        add bx, SPRITEW     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp byte [detectCollision], 0
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
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_1
          ret
     .check_right_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_2
          ret
     .check_right_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_3
          ret
     .check_right_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_4
          ret 
     .check_right_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_5
          ret
     .check_right_blinky_5: 
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEW
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_6
          ret
     .check_right_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_blinky_7
          ret
     .check_right_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub ax, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_1
          ret
     .check_left_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_2
          ret
     .check_left_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_3
          ret
     .check_left_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_4
          ret

     .check_left_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_5
          ret
     .check_left_blinky_5:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 5
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_6
          ret
     .check_left_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_blinky_7
          ret
     .check_left_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          sub ax, 1
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_1
          ret
     .check_up_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 1
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_2
          ret
     .check_up_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 2
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_3
          ret
     .check_up_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 3
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_4
          ret
     .check_up_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_5
          ret
     .check_up_blinky_5:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_6
          ret
     .check_up_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_blinky_7
          ret
     .check_up_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
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
        add bx, SPRITEW
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_1
        ret
    .check_down_blinky_1:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW
        add ax, 1
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_2
        ret
    .check_down_blinky_2:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW
        add ax, 2
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_3
        ret
    .check_down_blinky_3:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW
        add ax, 3
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_4
        ret
    .check_down_blinky_4:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW
        add ax, 4
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_5
        ret
    .check_down_blinky_5:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW
        add ax, 5
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_6
        ret
    .check_down_blinky_6:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEW
        add ax, 6
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_blinky_7
        ret
    
    .check_down_blinky_7:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky]
        add bx, SPRITEW     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp byte [detectCollision], 0
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
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_1
          ret
     .check_right_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_2
          ret
     .check_right_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_3
          ret
     .check_right_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_4
          ret 
     .check_right_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_5
          ret
     .check_right_inky_5: 
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEW
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_6
          ret
     .check_right_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_inky_7
          ret
     .check_right_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub ax, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_1
          ret
     .check_left_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_2
          ret
     .check_left_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_3
          ret
     .check_left_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_4
          ret

     .check_left_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_5
          ret
     .check_left_inky_5:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 5
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_6
          ret
     .check_left_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_inky_7
          ret
     .check_left_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          sub ax, 1
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_1
          ret
     .check_up_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 1
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_2
          ret
     .check_up_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 2
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_3
          ret
     .check_up_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 3
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_4
          ret
     .check_up_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_5
          ret
     .check_up_inky_5:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_6
          ret
     .check_up_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_inky_7
          ret
     .check_up_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
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
        add bx, SPRITEW
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_1
        ret
    .check_down_inky_1:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW
        add ax, 1
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_2
        ret
    .check_down_inky_2:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW
        add ax, 2
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_3
        ret
    .check_down_inky_3:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW
        add ax, 3
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_4
        ret
    .check_down_inky_4:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW
        add ax, 4
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_5
        ret
    .check_down_inky_5:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW
        add ax, 5
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_6
        ret
    .check_down_inky_6:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEW
        add ax, 6
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_inky_7
        ret
    
    .check_down_inky_7:
        mov ax, [xPosInky]
        mov bx, [yPosInky]
        add bx, SPRITEW     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp byte [detectCollision], 0
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
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_1
          ret
     .check_right_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_2
          ret
     .check_right_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_3
          ret
     .check_right_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_4
          ret 
     .check_right_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_5
          ret
     .check_right_clyde_5: 
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEW
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_6
          ret
     .check_right_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_clyde_7
          ret
     .check_right_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub ax, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_1
          ret
     .check_left_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_2
          ret
     .check_left_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_3
          ret
     .check_left_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_4
          ret

     .check_left_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_5
          ret
     .check_left_clyde_5:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 5
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_6
          ret
     .check_left_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_clyde_7
          ret
     .check_left_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          sub ax, 1
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_1
          ret
     .check_up_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 1
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_2
          ret
     .check_up_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 2
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_3
          ret
     .check_up_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 3
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_4
          ret
     .check_up_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_5
          ret
     .check_up_clyde_5:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_6
          ret
     .check_up_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_clyde_7
          ret
     .check_up_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
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
        add bx, SPRITEW
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_1
        ret
    .check_down_clyde_1:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW
        add ax, 1
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_2
        ret
    .check_down_clyde_2:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW
        add ax, 2
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_3
        ret
    .check_down_clyde_3:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW
        add ax, 3
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_4
        ret
    .check_down_clyde_4:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW
        add ax, 4
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_5
        ret
    .check_down_clyde_5:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW
        add ax, 5
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_6
        ret
    .check_down_clyde_6:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEW
        add ax, 6
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_clyde_7
        ret
    
    .check_down_clyde_7:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde]
        add bx, SPRITEW     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp byte [detectCollision], 0
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
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_1
          ret
     .check_right_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_2
          ret
     .check_right_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_3
          ret
     .check_right_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_4
          ret 
     .check_right_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_5
          ret
     .check_right_pinky_5: 
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEW
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_6
          ret
     .check_right_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_right_pinky_7
          ret
     .check_right_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub ax, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_1
          ret
     .check_left_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_2
          ret
     .check_left_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 2
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_3
          ret
     .check_left_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 3
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_4
          ret

     .check_left_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_5
          ret
     .check_left_pinky_5:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 5
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_6
          ret
     .check_left_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 6
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_left_pinky_7
          ret
     .check_left_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          sub ax, 1
          add bx, 7
          call check_detection_walls
          cmp byte [detectCollision], 0
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
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_1
          ret
     .check_up_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 1
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_2
          ret
     .check_up_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 2
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_3
          ret
     .check_up_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 3
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_4
          ret
     .check_up_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 4     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_5
          ret
     .check_up_pinky_5:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 5     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_6
          ret
     .check_up_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 6     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
          je .check_up_pinky_7
          ret
     .check_up_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 7     ;    + this check hitbox top right
          sub bx, 1
          call check_detection_walls
          cmp byte [detectCollision], 0
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
        add bx, SPRITEW
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_1
        ret
    .check_down_pinky_1:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW
        add ax, 1
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_2
        ret
    .check_down_pinky_2:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW
        add ax, 2
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_3
        ret
    .check_down_pinky_3:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW
        add ax, 3
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_4
        ret
    .check_down_pinky_4:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW
        add ax, 4
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_5
        ret
    .check_down_pinky_5:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW
        add ax, 5
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_6
        ret
    .check_down_pinky_6:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEW
        add ax, 6
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_7
        ret
    
    .check_down_pinky_7:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky]
        add bx, SPRITEW     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_walls
        cmp byte [detectCollision], 0
        je .check_down_pinky_over
        ret
    .check_down_pinky_over:
        mov bx, [yPosPinky]
        add bx, 1
        mov [yPosPinky], bx
        ret


;=================================================
;             GHOSTS TOUCH PACMAN
;=================================================
;=================================================
;        BlINKY COLLISIONS TOUCH PACMAN
;=================================================


check_collision_Touch_Blinky:
     
     call check_right_touch_blinky
     call check_left_touch_blinky
     call check_up_touch_blinky
     call check_down_touch_blinky
     ret


check_right_touch_blinky:
     .check_right_touch_blinky_0:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_1
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     .check_right_touch_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_2
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     .check_right_touch_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_3
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     .check_right_touch_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_4
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret 
     .check_right_touch_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_5
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     .check_right_touch_blinky_5: 
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_6
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     .check_right_touch_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_7
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     .check_right_touch_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_blinky_over
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret
     
     .check_right_touch_blinky_over:
          mov bx, [xPosBlinky]
          add bx, 1
          mov [xPosBlinky], bx
          call check_detection_pellets_rightBlinky
          call check_detection_SuperPellets_rightBlinky
          ret  
     
check_left_touch_blinky:
     .check_left_touch_blinky_0:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_1
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     .check_left_touch_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_2
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     .check_left_touch_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_3
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     .check_left_touch_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_4
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret

     .check_left_touch_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_5
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     .check_left_touch_blinky_5:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 5
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_6
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     .check_left_touch_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_7
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     .check_left_touch_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_blinky_over
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
     
     .check_left_touch_blinky_over:
          mov bx, [xPosBlinky]
          sub bx, 1
          mov [xPosBlinky], bx
          call check_detection_pellets_leftBlinky
          call check_detection_SuperPellets_leftBlinky
          ret
check_up_touch_blinky:
     .check_up_touch_blinky_0:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_1
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_1:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_2
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_2:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_3
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_3:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_4
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_4:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 4     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_5
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_5:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 5     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_6
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_6:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 6     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_7
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
     .check_up_touch_blinky_7:
          mov ax, [xPosBlinky]
          mov bx, [yPosBlinky]
          add ax, 7     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_blinky_over
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
          
     .check_up_touch_blinky_over:
          mov bx, [yPosBlinky]
          sub bx, 1
          mov [yPosBlinky], bx
          call check_detection_pellets_upBlinky
          call check_detection_SuperPellets_upBlinky
          ret
check_down_touch_blinky:
    .check_down_touch_blinky_0:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_1
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_1:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        add ax, 1
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_2
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_2:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        add ax, 2
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_3
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_3:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        add ax, 3
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_4
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_4:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        add ax, 4
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_5
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_5:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        add ax, 5
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_6
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_6:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky] 
        add bx, SPRITEH
        add ax, 6
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_7
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    
    .check_down_touch_blinky_7:
        mov ax, [xPosBlinky]
        mov bx, [yPosBlinky]
        add bx, SPRITEH     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_blinky_over
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret
    .check_down_touch_blinky_over:
        mov bx, [yPosBlinky]
        add bx, 1
        mov [yPosBlinky], bx
        call check_detection_pellets_downBlinky
     call check_detection_SuperPellets_downBlinky
        ret




;=================================================
;       INKY COLLISIONS TOUCH PACMAN
;=================================================



check_collision_Touch_Inky:
     call check_right_touch_inky
     call check_left_touch_inky
     call check_up_touch_inky
     call check_down_touch_inky
     ret




check_right_touch_inky:
     .check_right_touch_inky_0:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_1
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     .check_right_touch_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_2
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     .check_right_touch_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_3
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     .check_right_touch_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_4
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret 
     .check_right_touch_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_5
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     .check_right_touch_inky_5: 
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_6
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     .check_right_touch_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_7
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     .check_right_touch_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_inky_over
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret
     
     .check_right_touch_inky_over:
          mov bx, [xPosInky]
          add bx, 1
          mov [xPosInky], bx
          call check_detection_pellets_rightInky
          call check_detection_SuperPellets_rightInky
          ret  
     
check_left_touch_inky:
     .check_left_touch_inky_0:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_1
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     .check_left_touch_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_2
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     .check_left_touch_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_3
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     .check_left_touch_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_4
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret

     .check_left_touch_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_5
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     .check_left_touch_inky_5:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 5
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_6
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     .check_left_touch_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_7
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     .check_left_touch_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_inky_over
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
     
     .check_left_touch_inky_over:
          mov bx, [xPosInky]
          sub bx, 1
          mov [xPosInky], bx
          call check_detection_pellets_LeftInky
          call check_detection_SuperPellets_LeftInky
          ret
check_up_touch_inky:
     .check_up_touch_inky_0:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_1
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_1:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_2
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_2:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_3
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_3:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_4
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_4:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 4     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_5
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_5:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 5     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_6
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_6:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 6     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_7
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
     .check_up_touch_inky_7:
          mov ax, [xPosInky]
          mov bx, [yPosInky]
          add ax, 7     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_inky_over
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
          
     .check_up_touch_inky_over:
          mov bx, [yPosInky]
          sub bx, 1
          mov [yPosInky], bx
          call check_detection_pellets_UpInky
          call check_detection_SuperPellets_UpInky
          ret
check_down_touch_inky:
    .check_down_touch_inky_0:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_1
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_1:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        add ax, 1
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_2
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_2:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        add ax, 2
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_3
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_3:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        add ax, 3
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_4
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_4:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        add ax, 4
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_5
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_5:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        add ax, 5
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_6
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_6:
        mov ax, [xPosInky]
        mov bx, [yPosInky] 
        add bx, SPRITEH
        add ax, 6
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_7
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    
    .check_down_touch_inky_7:
        mov ax, [xPosInky]
        mov bx, [yPosInky]
        add bx, SPRITEH     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_inky_over
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret
    .check_down_touch_inky_over:
        mov bx, [yPosInky]
        add bx, 1
        mov [yPosInky], bx
          call check_detection_pellets_DownInky
          call check_detection_SuperPellets_DownInky
        ret



;=================================================
;        CLYDE COLLISIONS TOUCH PACMAN
;=================================================



check_collision_Touch_Clyde:
     call check_right_touch_clyde
     call check_left_touch_clyde
     call check_up_touch_clyde
     call check_down_touch_clyde
     ret



check_right_touch_clyde:
     .check_right_touch_clyde_0:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_1
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     .check_right_touch_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_2
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     .check_right_touch_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_3
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     .check_right_touch_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_4
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret 
     .check_right_touch_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_5
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     .check_right_touch_clyde_5: 
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_6
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     .check_right_touch_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_7
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     .check_right_touch_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_clyde_over
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret
     
     .check_right_touch_clyde_over:
          mov bx, [xPosClyde]
          add bx, 1
          mov [xPosClyde], bx
          call check_detection_pellets_rightClyde
          call check_detection_SuperPellets_rightClyde
          ret  
     
check_left_touch_clyde:
     .check_left_touch_clyde_0:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_1
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     .check_left_touch_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_2
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     .check_left_touch_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_3
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     .check_left_touch_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_4
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret

     .check_left_touch_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_5
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     .check_left_touch_clyde_5:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 5
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_6
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     .check_left_touch_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_7
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     .check_left_touch_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_clyde_over
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
     
     .check_left_touch_clyde_over:
          mov bx, [xPosClyde]
          sub bx, 1
          mov [xPosClyde], bx
          call check_detection_pellets_LeftClyde
          call check_detection_SuperPellets_LeftClyde
          ret
check_up_touch_clyde:
     .check_up_touch_clyde_0:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_1
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_1:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_2
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_2:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_3
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_3:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_4
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_4:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 4     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_5
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_5:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 5     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_6
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_6:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 6     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_7
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
     .check_up_touch_clyde_7:
          mov ax, [xPosClyde]
          mov bx, [yPosClyde]
          add ax, 7     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_clyde_over
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
          
     .check_up_touch_clyde_over:
          mov bx, [yPosClyde]
          sub bx, 1
          mov [yPosClyde], bx
          call check_detection_pellets_UpClyde
          call check_detection_SuperPellets_UpClyde
          ret
check_down_touch_clyde:
    .check_down_touch_clyde_0:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_1
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_1:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        add ax, 1
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_2
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_2:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        add ax, 2
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_3
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_3:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        add ax, 3
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_4
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_4:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        add ax, 4
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_5
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_5:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        add ax, 5
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_6
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_6:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde] 
        add bx, SPRITEH
        add ax, 6
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_7
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    
    .check_down_touch_clyde_7:
        mov ax, [xPosClyde]
        mov bx, [yPosClyde]
        add bx, SPRITEH     ;    + this check hitbox top right
        add ax, 7 
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_clyde_over
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret
    .check_down_touch_clyde_over:
        mov bx, [yPosClyde]
        add bx, 1
        mov [yPosClyde], bx
        call check_detection_pellets_DownClyde
     call check_detection_SuperPellets_DownClyde
        ret




;=================================================
;        PINKY COLLISIONS TOUCH PACMAN
;=================================================



check_collision_Touch_Pinky:
     call check_right_touch_pinky
     call check_left_touch_pinky
     call check_up_touch_pinky
     call check_down_touch_pinky
     ret



check_right_touch_pinky:
     .check_right_touch_pinky_0:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_1
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     .check_right_touch_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_2
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     .check_right_touch_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_3
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     .check_right_touch_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_4
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret 
     .check_right_touch_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 4
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_5
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     .check_right_touch_pinky_5: 
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH
          add bx, 5      ;    + this check hitbox bottom right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_6
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     .check_right_touch_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_7
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     .check_right_touch_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, SPRITEH ;    check hitbox top right
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_right_touch_pinky_over
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret
     
     .check_right_touch_pinky_over:
          mov bx, [xPosPinky]
          add bx, 1
          mov [xPosPinky], bx
          call check_detection_pellets_rightPinky
          call check_detection_SuperPellets_rightPinky
          ret  
     
check_left_touch_pinky:
     .check_left_touch_pinky_0:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_1
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     .check_left_touch_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_2
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     .check_left_touch_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_3
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     .check_left_touch_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_4
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret

     .check_left_touch_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 4    ;    + this check hitbox bottom left
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_5
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     .check_left_touch_pinky_5:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 5
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_6
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     .check_left_touch_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 6
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_7
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     .check_left_touch_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, 7
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_left_touch_pinky_over
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
     
     .check_left_touch_pinky_over:
          mov bx, [xPosPinky]
          sub bx, 1
          mov [xPosPinky], bx
          call check_detection_pellets_LeftPinky
          call check_detection_SuperPellets_LeftPinky
          ret
check_up_touch_pinky:
     .check_up_touch_pinky_0:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_1
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_1:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 1
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_2
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_2:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 2
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_3
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_3:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 3
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_4
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_4:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 4     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_5
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_5:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 5     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_6
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_6:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 6     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_7
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
     .check_up_touch_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add ax, 7     ;    + this check hitbox top right
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_up_touch_pinky_over
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
          
     .check_up_touch_pinky_over:
          mov bx, [yPosPinky]
          sub bx, 1
          mov [yPosPinky], bx
          call check_detection_pellets_UpPinky
          call check_detection_SuperPellets_UpPinky
          ret
check_down_touch_pinky:
    .check_down_touch_pinky_0:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_1
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    .check_down_touch_pinky_1:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        add ax, 1
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_2
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    .check_down_touch_pinky_2:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        add ax, 2
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_3
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    .check_down_touch_pinky_3:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        add ax, 3
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_4
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    .check_down_touch_pinky_4:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        add ax, 4
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_5
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    .check_down_touch_pinky_5:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        add ax, 5
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_6
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    .check_down_touch_pinky_6:
        mov ax, [xPosPinky]
        mov bx, [yPosPinky] 
        add bx, SPRITEH
        add ax, 6
        call check_detection_pacman
        cmp byte [detectCollision], 0
        je .check_down_touch_pinky_7
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
        ret
    
    .check_down_touch_pinky_7:
          mov ax, [xPosPinky]
          mov bx, [yPosPinky]
          add bx, SPRITEH     ;    + this check hitbox top right
          add ax, 7 
          call check_detection_pacman
          cmp byte [detectCollision], 0
          je .check_down_touch_pinky_over
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
          ret
    .check_down_touch_pinky_over:
          mov bx, [yPosPinky]
          add bx, 1
          mov [yPosPinky], bx
            call check_detection_pellets_DownPinky
               call check_detection_SuperPellets_DownPinky
          ret
;=============================================
;                TUNNEL
;=============================================
tunnel_horizontal:
     mov ax, [xPos]
     cmp ax, 74
     jb .to_right
     cmp ax, 238
     ja .to_left
     ret
     .to_right:
          mov word [xPos], 238
          ret
     .to_left:
          mov word [xPos], 74
          ret

tunnel_horizontal_blinky:
     mov ax, [xPosBlinky]
          cmp ax, 74
          jb .to_right
          cmp ax, 238
          ja .to_left
          ret
          .to_right:
               mov word [xPosBlinky], 238
               ret
          .to_left:
               mov word [xPosBlinky], 74
               ret
tunnel_horizontal_inky:
     mov ax, [xPosInky]
     cmp ax, 74
     jb .to_right
     cmp ax, 238
     ja .to_left
     ret
     .to_right:
          mov word [xPosInky], 238
          ret
     .to_left:
          mov word [xPosInky], 74
          ret
tunnel_horizontal_clyde:
     mov ax, [xPosClyde]
     cmp ax, 74
     jb .to_right
     cmp ax, 238
     ja .to_left
     ret
     .to_right:
          mov word [xPosClyde], 238
          ret
     .to_left:
          mov word [xPosClyde], 74
          ret
tunnel_horizontal_pinky:
     mov ax, [xPosPinky]
     cmp ax, 74
     jb .to_right
     cmp ax, 238
     ja .to_left
     ret
     .to_right:
          mov word [xPosPinky], 238
          ret
     .to_left:
          mov word [xPosPinky], 74
          ret