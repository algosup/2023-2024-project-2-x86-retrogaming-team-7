org 100h
section .data
    ; set all the printed strings ont the mai
    mainWelcome db 'Welcome to Pac-Man', 0x0D, 0x0A, '$'
    playChoice db 'Play', 0x0D, 0x0A, '$'
    settingsChoice db 'Settings', 0x0D, 0x0A, '$'
    exitChoice db 'Exit', 0x0D, 0x0A, '$'
    arrow db '->', 0x0d, 0x0A, '$'
    delArrow db '  ', 0x0d, 0x0A, '$' ; Can we avoid that ???? I don't know but that work :D

section .bss
section .text
    global _start
_start:

;=======================================================
;                   MAIN MENU
;=======================================================
main_menu:
    call initialize_part
    call display_main_menu

initialize_part:
    mov ah, 0x00
    mov al, 0x03
    int 0x10
    mov ah, 06h  ; Function: Scroll up window
    xor al, al   ; Clear entire window
    xor cx, cx   ; Upper left corner (row, column = 0, 0)
    mov dx, 184Fh ; Lower right corner (row, column = 24, 79)
    mov bh, 07h  ; Attribute (7 = light gray on black)
    int 10h      ; Call interrupt
    ret
display_main_menu:
    call initialize_part
    ; Display Pac-Man Menu
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 3           ; dh = row
    mov dl, 31          ; dl = column
    int 0x10            ; set cursor position
    mov si, mainWelcome
    mov ah, 0x0E
    call print_string
    ; Display Start Menu
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 9          ; dh = row
    mov dl, 38          ; dl = column
    int 0x10            ; set cursor position
    mov si, playChoice
    mov ah, 0x0E
    call print_string
    ; Display Settings Menu
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 11           ; dh = row
    mov dl, 38          ; dl = column
    int 0x10            ; set cursor position
    mov si, settingsChoice
    mov ah, 0x0E
    call print_string
    ; Display Exit Menu
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 13          ; dh = row
    mov dl, 38          ; dl = column
    int 0x10            ; set cursor position
    mov si, exitChoice
    mov ah, 0x0E
    call print_string
    ; Display Arrow
    call display_arrow_menu
;--------
; Display Arrow
display_arrow_menu:
        cmp cl, 5
        jb .set_arrow
        cmp cl, 7
        je .execpt_back
        cmp cl, 9
        je .display_arrow_wait
        cmp cl, 11
        je .display_arrow_wait
        cmp cl, 13
        je .display_arrow_wait
        cmp cl, 15
        je .execpt_front

        .execpt_back:
            add cl, 6
            jmp .display_arrow_wait
        .execpt_front:
            add cl, -6
            jmp .display_arrow_wait

        .set_arrow:
            mov ah, 0x02        ; set cursor position
            mov bh, 0x00 
            mov dh, 9          ; dh = row 
            mov cl, dh          ; save 9 in sp
            mov dl, 30          ; dl = column
            int 0x10            ; set cursor position
            mov si, arrow
            mov ah, 0x0E
            call print_string
            jmp .wait_for_key

        .display_arrow_wait:
            mov ah, 0x02        ; set cursor position
            mov bh, 0x00 
            mov dh, cl          ; dh = row 
            mov dl, 30          ; dl = column
            int 0x10            ; set cursor position
            mov si, arrow
            mov ah, 0x0E
            call print_string
            jmp .wait_for_key

        .remove_arrow:               ; Can we avoid that ???? I don't know but that work :D
            mov ah, 0x02        ; set cursor position
            mov bh, 0x00 
            mov dh, cl          ; dh = row 
            mov dl, 30          ; dl = column
            int 0x10            ; set cursor position
            mov si, delArrow
            mov ah, 0x0E
            call print_string
            ret 
        .add_arrow:    
            call .remove_arrow
            add cl, 2
            jmp display_arrow_menu

        .sub_arrow:
            call .remove_arrow
            add cl, -2
            jmp display_arrow_menu

        .equal_arrow:
            cmp cl, 9
            je game_start
            cmp cl, 11
            je settings_menu
            cmp cl, 13
            je exit_menu
            jmp .wait_for_key

        .wait_for_key:
            mov ah, 0x00
            int 0x16                        ; BIOS keyboard service to wait for a keypress
            cmp ah, 48h                     ; Compare the scan code in AH with the UP key's scan code
            je  .sub_arrow     ; If UP key is pressed, and we are on page one, jump into the loop again
            cmp ah, 50h                     ; Compare the scan code in AH with the DOWN key's scan code       
            je  .add_arrow
            cmp ah, 0x1C      ; Compare the scan code in AH with the Enter key's scan code
            je .equal_arrow                
            jmp .wait_for_key                ; Otherwise, keep waiting

        
display_arrow_option:
    cmp cl, 5
    jb .set_arrow
    cmp cl, 7
    je .execpt_back
    cmp cl, 9
    je .display_arrow_wait
    cmp cl, 11
    je .display_arrow_wait
    cmp cl, 13
    je .display_arrow_wait
    cmp cl, 15
    je .display_arrow_wait
    cmp cl, 17
    je .display_arrow_wait
    cmp cl, 19
    je .execpt_front

    .execpt_back:
        add cl, 10
        jmp .display_arrow_wait
    .execpt_front:
        add cl, -10
        jmp .display_arrow_wait

    .set_arrow:
        mov ah, 0x02        ; set cursor position
        mov bh, 0x00 
        mov dh, 9          ; dh = row 
        mov cl, dh          ; save 9 in sp
        mov dl, 15          ; dl = column
        int 0x10            ; set cursor position
        mov si, arrow
        mov ah, 0x0E
        call print_string
        jmp .wait_for_key

    .display_arrow_wait:
        mov ah, 0x02        ; set cursor position
        mov bh, 0x00 
        mov dh, cl          ; dh = row 
        mov dl, 15          ; dl = column
        int 0x10            ; set cursor position
        mov si, arrow
        mov ah, 0x0E
        call print_string
        jmp .wait_for_key

    .remove_arrow:               ; Can we avoid that ???? I don't know but that work :D
        mov ah, 0x02        ; set cursor position
        mov bh, 0x00 
        mov dh, cl          ; dh = row 
        mov dl, 15          ; dl = column
        int 0x10            ; set cursor position
        mov si, delArrow
        mov ah, 0x0E
        call print_string
        ret 

    .add_arrow:    
        call .remove_arrow
        add cl, 2
        jmp display_arrow_option

    .sub_arrow:
        call .remove_arrow
        add cl, -2
        jmp display_arrow_option

    .equal_arrow:
        ; cmp cl, 9
        ; je game_start
        ; cmp cl, 11
        ; je settings_menu
        ; cmp cl, 13
        ; je exit_menu
        cmp cl, 17
        je main_menu
        jmp .wait_for_key

    .wait_for_key:
        mov ah, 0x00
        int 0x16                        ; BIOS keyboard service to wait for a keypress
        cmp ah, 48h                     ; Compare the scan code in AH with the UP key's scan code
        je  .sub_arrow     ; If UP key is pressed, and we are on page one, jump into the loop again
        cmp ah, 50h                     ; Compare the scan code in AH with the DOWN key's scan code       
        je  .add_arrow
        cmp ah, 0x1C      ; Compare the scan code in AH with the Enter key's scan code
        je .equal_arrow                
        jmp .wait_for_key                ; Otherwise, keep waiting



print_string:
    next_char:
        lodsb
        cmp al, '$'
        je end_string
        int 0x10
        jmp next_char
    end_string:
        ret



;=======================================================
;                   START THE GAME
;=======================================================
game_start:
    call done

;=======================================================
;                   SETTINGS MENU
;=======================================================
section .data
    ; set all the printed strings on the mai
    mainSettings db 'Settings of the game', 0x0D, 0x0A, '$'
    musicSetting db 'Music', 0x0D, 0x0A, '$'
    soundSetting db 'Sound Effect', 0x0D, 0x0A, '$'
    skinsSetting db 'Skins', 0x0D, 0x0A, '$'
    keybindSetting db 'Keybinding', 0x0D, 0x0A, '$'
    backButton db 'Back', 0x0D, 0x0A, '$'
settings_menu: ; ip = cs:0296
    call initialize_part
    ; Display Settngs Menu
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 3           ; dh = row
    mov dl, 31          ; dl = column
    int 0x10            ; set cursor position
    mov si, mainSettings
    mov ah, 0x0E
    call print_string
    ; Display Musci Setting
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 9          ; dh = row
    mov dl, 20         ; dl = column
    int 0x10            ; set cursor position
    mov si, musicSetting
    mov ah, 0x0E
    call print_string
    ; Display Soud Setting
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 11           ; dh = row
    mov dl, 20          ; dl = column
    int 0x10            ; set cursor position
    mov si, soundSetting
    mov ah, 0x0E
    call print_string
    ; Display Skins
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 13           ; dh = row
    mov dl, 20          ; dl = column
    int 0x10            ; set cursor position
    mov si, skinsSetting
    mov ah, 0x0E
    call print_string
    ; Display Keybinding
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 15          ; dh = row
    mov dl, 20          ; dl = column
    int 0x10            ; set cursor position
    mov si, keybindSetting
    mov ah, 0x0E
    call print_string
    ; Display Back Button
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 17          ; dh = row
    mov dl, 20          ; dl = column
    int 0x10            ; set cursor position
    mov si, backButton
    mov ah, 0x0E
    call print_string
    ; Display Arrow
    call display_arrow_option

        

;=======================================================
;                   EXIT MENU
;=======================================================
exit_menu:
    call initialize_part
    call done

done:
    mov ax, 03h
    int 21h
    int 20h