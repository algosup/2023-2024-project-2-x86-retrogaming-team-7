org 100h

section .data
    welcomeMessage db 'Welcome to Pac-Man!', 0Dh, 0Ah, '$'
    startGame db 'S - Start', 0Dh, 0Ah, '$'
    gamemodeMessage db 'G - Gamemode', 0Dh, 0Ah, '$'
    optionMessage db 'O - Option', 0Dh, 0Ah, '$'
    exitGame db 'Echap - Exit', 0Dh, 0Ah, '$'
    levelMessage db 'Level 1', 0Dh, 0Ah, '$'
    CapsLockMessage db '/!\ You must turn ON your Caps Lock', 0Dh, 0Ah, '$'

section .text
    global _start

_start:
    ; Set video mode to 80x25 color text (mode 03h)
    mov ax, 0x0003
    int 0x10
    ; Print the welcome message
    mov ah, 0x0E
    mov si, welcomeMessage
    call print_string
    mov si, startGame
    call print_string
    mov si, gamemodeMessage
    call print_string
    mov si, optionMessage
    call print_string
    mov si, exitGame
    call print_string
    mov si, CapsLockMessage
    call print_string

    ; Wait for key press
    mov ah, 0x00
    int 0x16  ; BIOS keyboard service

    ; Check if 'b' was pressed
    cmp al, 'b'
    je debug_option
    cmp al, 0x1B
    je exit_program
    cmp al, '1'
    je start_game
    cmp al, '2'
    je select_game_mode
    cmp al, '3'
    je option_setting

hang:
    jmp hang

debug_option:
    ; Clear the screen
    call clear_screen
    mov ax, 0x0003
    int 0x10

    ; Print level message
    mov ah, 0x0E
    mov si, levelMessage
    call print_string

    jmp hang  ; Hang after displaying level message

start_game:
    call clear_screen
    mov ax, 0x0003
    int 0x10
    mov ah, 0x0E
    mov si, startGame
    call print_string
    ; Wait for key press
    mov ah, 0x00
    int 0x16  ; BIOS keyboard service
    cmp al, 0x1B
    je _start

select_game_mode:
    call clear_screen
    mov ax, 0x0003
    int 0x10
    mov ah, 0x0E
    mov si, gamemodeMessage
    call print_string
    ; Wait for key press
    mov ah, 0x00
    int 0x16  ; BIOS keyboard service
    cmp al, 0x1B
    je _start

option_setting:
    call clear_screen
    mov ax, 0x0003
    int 0x10
    mov ah, 0x0E
    mov si, optionMessage
    call print_string
    ; Wait for key press
    mov ah, 0x00
    int 0x16  ; BIOS keyboard service
    cmp al, 0x1B
    je _start

print_string:
    next_char:
        lodsb
        cmp al, '$'
        je end_string
        int 0x10
        jmp next_char
    end_string:
        ret

clear_screen:
    mov ah, 0x00
    mov al, 0
    mov bh, 0x07
    mov cx, 0
    mov dx, 184Fh
    int 0x10
    ret

; Function to exit the program and return to DOS
exit_program:
    mov ax, 0x4C00  ; Function 4Ch of interrupt 21h: Exit with return code
    int 0x21        ; Call DOS interrupt
    ret             ; The ret instruction here is for safety, but it should never be reached
