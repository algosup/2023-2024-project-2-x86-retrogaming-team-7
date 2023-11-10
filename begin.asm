section .data
    mainMenuText db 'Pac-Man Game', 0Ah, '$'
    startText db '1. Start Game', 0Ah, '$'
    optionsText db '2. Options', 0Ah, '$'
    exitText db '3. Exit', 0Ah, '$'
    userInput db 0

section .bss
    player_score resb 10
    player_lives resb 1

section .text
    global _start

setup_environment:
    mov ax, 0x0003  ; Set to text mode
    int 0x10
    ret

initialize_memory:
    mov ax, 0
    mov ds, ax
    mov es, ax
    ret

main_menu:
    mov ah, 0x0E    ; Teletype output function
    mov si, mainMenuText
    call print_string

    mov si, startText
    call print_string

    mov si, optionsText
    call print_string

    mov si, exitText
    call print_string

menu_loop:
    call wait_for_input

    cmp byte [userInput], '1'
    je start_game
    cmp byte [userInput], '2'
    je show_options
    cmp byte [userInput], '3'
    je exit_program
    jmp menu_loop   ; Loop back if input is invalid

    ret

wait_for_input:
    mov ah, 0x00
    int 0x16        ; Wait for keypress
    mov [userInput], al
    ret

print_string:
    next_character:
        lodsb
        cmp al, '$'
        je done_printing
        int 0x10
        jmp next_character
    done_printing:
        ret

start_game:
    ; Placeholder for starting the game
    jmp exit_program ; Temporarily exit after this placeholder

show_options:
    ; Placeholder for showing options
    jmp exit_program ; Temporarily exit after this placeholder

exit_program:
    mov ax, 0x4C00  ; Exit program
    int 0x21
    ret

_start:
    call setup_environment
    call initialize_memory
    call main_menu

    jmp exit_program ; Ensure the program exits properly
