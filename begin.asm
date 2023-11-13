org 100h

section .data
    welcomeMessage db 'Welcome to Pac-Man!', 0Dh, 0Ah, '$'
    startGame db '1 - Start', 0Dh, 0Ah, '$'
    gamemodeMessage db '2 - Gamemode', 0Dh, 0Ah, '$'
    optionMessage db '3 - Option', 0Dh, 0Ah, '$'
    exitGame db 'Echap - Exit', 0Dh, 0Ah, '$'
    levelMessage db 'Debugging Panel', 0Dh, 0Ah, '$'
    CapsLockMessage db '/!\ You must turn ON your Caps Lock', 0Dh, 0Ah, '$'

    filename db 'SETTINGS.TXT', 0 ; DOS file names are uppercase
    newLine db 13, 10, '$'  ; Carriage return, line feed, and DOS string terminator

section .bss
    fileHandle resw 1 ; Reserve word for file handle
    buffer resb 1024 ; Reserve 1024 bytes for buffer
    readBytes resw 1 ; Reserve word for number of bytes read

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


waiting_for_key:
    ; Wait for key press
    mov ah, 0x00
    int 0x16  ; BIOS keyboard service

    ; Check if 'B' was pressed
    cmp al, 'B'
    je debug_option
    cmp al, 0x1B
    je exit_program
    cmp al, '1'
    je start_game
    cmp al, '2'
    je select_game_mode
    cmp al, '3'
    je option_setting

    jmp waiting_for_key
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
    call wait_for_escape

select_game_mode:
    call clear_screen
    mov ax, 0x0003
    int 0x10
    mov ah, 0x0E
    mov si, gamemodeMessage
    call print_string
    call wait_for_escape

option_setting:
    call clear_screen
    ; Open the file
    mov ax, 0x0003
    int 0x10
    mov ah, 0x3D ; Function: Open existing file
    mov al, 0    ; Access mode: Read only
    lea dx, filename
    int 0x21
    jc error ; Jump if carry flag is set (error)
    mov [fileHandle], ax

    ; Read from the file
    mov ah, 0x3F ; Function: Read from file or device
    mov bx, [fileHandle]
    lea dx, [buffer]
    mov cx, 1024 ; Number of bytes to read
    int 0x21
    jc error ; Jump if carry flag is set (error)
    mov [readBytes], ax

    ; Check if file is empty
    cmp ax, 0
    je close_file

    ; Process and display the buffer content
    mov si, 0         ; Source index for buffer iteration
    mov cx, [readBytes]  ; Number of bytes to process

process_buffer:
    dec cx           ; Decrement remaining byte count
    jz finished_processing ; Jump if all bytes are processed

    mov ah, 0x02     ; Function to display character
    mov dl, [buffer + si] ; Load current character from buffer into DL
    int 0x21         ; Call interrupt to display the character

    cmp byte [buffer + si], '=' ; Check if current character is '='
    jne increment_si   ; Jump if not '='

    ; Output newline when '=' is found
    lea dx, newLine
    mov ah, 0x09     ; Function to display string
    int 0x21         ; Call interrupt

increment_si:
    inc si           ; Move to the next character
    jmp process_buffer

finished_processing:
    call wait_for_escape

close_file:
    ; Close the file
    mov ah, 0x3E
    mov bx, [fileHandle]
    int 0x21
    jc error

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

error:
    ; Handle error (for now, just exit)
    mov ax, 0x4C01
    int 0x21

wait_for_escape:
    ; Wait for key press in a loop until 'Escape' is pressed
    wait_loop:
        mov ah, 0x00
        int 0x16  ; BIOS keyboard service
        cmp al, 0x1B
        je _start  ; Jump to start if Escape key is pressed
        jmp wait_loop  ; Otherwise, keep waiting

; Function to exit the program and return to DOS
exit_program:
    mov ax, 0x4C00  ; Function 4Ch of interrupt 21h: Exit with return code
    int 0x21        ; Call DOS interrupt
    ret             ; The ret instruction here is for safety, but it should never be reached
