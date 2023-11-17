org 100h

section .data
    ; set all the printed strings ont the mai
    mainWelcome db 'Welcome to Pac-Man', 0x0D, 0x0A, '$'
    playChoice db 'Play', 0x0D, 0x0A, '$'
    helpChoice db 'Help', 0x0D, 0x0A, '$'
    exitChoice db 'Exit', 0x0D, 0x0A, '$'
    
section .bss

section .text
    global _start

_start:
    call initialization_menu
    call display_main_menu

initialization_menu:
    mov ax, 0x3         ; set video mode to 80x25 16 colors
    int 0x10            ; set video mode to 80x25 16 colors
    ret

display_main_menu:
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

    call wait_for_escape
    
wait_for_escape:
    wait_loop:
        mov ah, 0x00
        int 0x16          ; BIOS keyboard service to wait for a keypress

        cmp ah, 0x01      ; Compare the scan code in AH with the Escape key's scan code
        je done           ; If Escape key is pressed, exit the loop

        jmp wait_loop     ; Otherwise, keep waiting

print_string:
    next_char:
        lodsb
        cmp al, '$'
        je end_string
        mov ah, 0x0C     ; Default color attribute (red)
        int 0x10
        jmp next_char
    end_string:
        ret

done:
    mov ax, 03h
    int 21h

    int 20h
