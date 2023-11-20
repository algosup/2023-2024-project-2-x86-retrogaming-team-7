org 100h
section .data
    ; set all the printed strings ont the mai
    mainWelcome db 'Welcome to Pac-Man', 0x0D, 0x0A, '$'
    playChoice db 'Play', 0x0D, 0x0A, '$'
    helpChoice db 'Help', 0x0D, 0x0A, '$'
    exitChoice db 'Exit', 0x0D, 0x0A, '$'
    arrow db '->', 0x0d, 0x0A, '$'
section .bss
section .text
    global _start
_start:
    call display_main_menu_one
display_main_menu_one:
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
    mov si, helpChoice
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
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 9           ; dh = row
    mov dl, 30          ; dl = column
    int 0x10            ; set cursor position
    mov si, arrow
    mov ah, 0x0E
    call print_string
    call wait_for_key_one
display_main_menu_two:
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
    mov si, helpChoice
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
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 11           ; dh = row
    mov dl, 30          ; dl = column
    int 0x10            ; set cursor position
    mov si, arrow
    mov ah, 0x0E
    call print_string
    call wait_for_key_two
display_main_menu_three:
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
    mov si, helpChoice
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
    mov ah, 0x02        ; set cursor position
    mov bh, 0x00        ; page number
    mov dh, 13           ; dh = row
    mov dl, 30          ; dl = column
    int 0x10            ; set cursor position
    mov si, arrow
    mov ah, 0x0E
    call print_string
    call wait_for_key_third
print_string:
    next_char:
        lodsb
        cmp al, '$'
        je end_string
        int 0x10
        jmp next_char
    end_string:
        ret
wait_for_key_one:
    wait_loop:
        mov ah, 0x00
        int 0x16          ; BIOS keyboard service to wait for a keypress
        cmp ah, 48h     ; Compare the scan code in AH with the UP key's scan code
        je wait_loop    ; If UP key is pressed, and we are on page one, jump into the loop again
        cmp ah, 50h     ; Compare the scan code in AH with the DOWN key's scan code
        je display_main_menu_two    ; If DOWN key is pressed, and we are on page one, jump page two
        ; cmp ah, 4Bh     ; Compare the scan code in AH with the LEFT key's scan code
        ; je display_main_menu_two     ; If LEFT key is pressed,
        ; cmp ah, 4Dh     ; Compare the scan code in AH with the RIGHT key's scan code
        ; je     ; If RIGHT key is pressed,
        cmp ah, 0x01    ; Compare the scan code in AH with the Escape key's scan code
        je done           ; If Escape key is pressed, exit the loop
        jmp wait_loop     ; Otherwise, keep waiting
wait_for_key_two:
    wait_loop_two:
        mov ah, 0x00
        int 0x16                        ; BIOS keyboard service to wait for a keypress
        cmp ah, 48h                     ; Compare the scan code in AH with the UP key's scan code
        je display_main_menu_one        ; If UP key is pressed, and we are on page one, jump into the loop again
        cmp ah, 50h                     ; Compare the scan code in AH with the DOWN key's scan code
        je display_main_menu_three      ; If DOWN key is pressed, and we are on page one, jump page three
        cmp ah, 0x01                    ; Compare the scan code in AH with the Escape key's scan code
        je done                         ; If Escape key is pressed, exit the loop
        jmp wait_loop_two               ; Otherwise, keep waiting
wait_for_key_third:
    wait_loop_third:
        mov ah, 0x00
        int 0x16                    ; BIOS keyboard service to wait for a keypress
        cmp ah, 48h                 ; Compare the scan code in AH with the UP key's scan code
        je display_main_menu_two    ; If UP key is pressed, and we are on page one, jump into the loop again
        cmp ah, 50h                 ; Compare the scan code in AH with the DOWN key's scan code
        je wait_loop_third                ; If DOWN key is pressed, and we are on page one, jump page two
        cmp ah, 0x01                ; Compare the scan code in AH with the Escape key's scan code
        je done                     ; If Escape key is pressed, exit the loop
        jmp wait_loop_third               ; Otherwise, keep waiting

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
done:
    mov ax, 03h
    int 21h
    int 20h