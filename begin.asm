org 100h

section .data
    welcomeMessage db 'Welcome to Pac-Man!', 0Dh, 0Ah, '$'
    startGame db '1 - Start', 0Dh, 0Ah, '$'
    gamemodeMessage db '2 - Gamemode', 0Dh, 0Ah, '$'
    optionMessage db '3 - Option', 0Dh, 0Ah, '$'
    exitGame db 'Echap - Exit', 0Dh, 0Ah, '$'
    levelMessage db 'Debugging Panel', 0Dh, 0Ah, '$'
    CapsLockMessage db '/!\ You must turn ON your Caps Lock', 0Dh, 0Ah, '$'
    invalid_input_msg db 'Invalid input, please try again.', 0Ah, 0
    prompt_new_key_msg db 'Enter new key for option ', 0
    filename db 'SETTINGS.TXT', 0 ; DOS file names are uppercase
    newLine db 13, 10, '$'  ; Carriage return, line feed, and DOS string terminator
    optionStrings db 'player1_up', 0, 'player1_left', 0, 'player1_down', 0, 'player1_right', 0, 'player2_up', 0, 'player2_left', 0, 'player2_down', 0, 'player2_right', 0
    optionLengths db 10, 12, 12, 13, 10, 12, 12, 13 ; Lengths of the option strings

section .bss
    fileHandle resw 1 ; Reserve word for file handle
    buffer resb 1024 ; Reserve 1024 bytes for buffer
    readBytes resw 1 ; Reserve word for number of bytes read
    choice resb 1
    newKey resb 1

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

;==================================================================
;                       OPTIONS SETTINGS
;==================================================================

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
    call get_choice
    call change_key_binding
    call update_settings
    jmp _start

get_choice:
    ; Read a single character from keyboard
    mov ah, 01h       ; Function number for reading character input
    int 21h           ; Call DOS interrupt
    mov [choice], al  ; Store the input character in 'choice'

    ; Validate input (assuming options are 1-8)
    cmp al, '1'       ; Compare with '1'
    jb invalid_input  ; Jump if below '1'
    cmp al, '8'       ; Compare with '8'
    ja invalid_input  ; Jump if above '8'

    ; Convert ASCII character to integer (subtract '0')
    sub al, '0'       
    mov [choice], al  ; Store the integer value back in 'choice'
    ret               ; Return from the function

invalid_input:
    ; Handle invalid input
    mov ah, 09h        ; Function number for displaying string
    lea dx, invalid_input_msg
    int 21h            ; Call DOS interrupt to display the message
    jmp get_choice     ; Prompt for input again

;==================================================================
;                       CHANGE KEY BINDING
;==================================================================
change_key_binding:
    ; Display prompt
    mov ah, 09h
    lea dx, prompt_new_key_msg
    int 21h
    ; Output the option name
    movzx bx, byte [choice]
    dec bx
    shl bx, 4
    lea si, [optionStrings + bx]
    call print_string
    ; Wait for key press and store the new key
    mov ah, 00h
    int 16h
    mov [newKey], al
    ret

;==================================================================
;                       UPDATE SETTINGS
;==================================================================
update_settings:
    ; Open the file in write mode
    mov ah, 0x3D ; Function: Open existing file
    mov al, 1    ; Access mode: Write only
    lea dx, filename
    int 0x21
    jc error ; Jump if carry flag is set (error)
    mov [fileHandle], ax

    ; Read current settings into buffer
    mov ah, 0x3F ; Function: Read from file or device
    mov bx, [fileHandle]
    lea dx, [buffer]
    mov cx, 1024 ; Number of bytes to read
    int 0x21
    jc error ; Jump if carry flag is set (error)
    mov [readBytes], ax

    ; Modify the appropriate line in the buffer
    mov si, 0         ; Source index for buffer iteration
    mov cx, [readBytes]  ; Number of bytes to process
    xor di, di        ; Destination index for buffer modification
    mov bl, [choice]  ; Option number
    mov bh, 0
    lea bp, [optionLengths] ; Address of option lengths array

    ; Loop through each character in the buffer
modify_loop:
    dec cx
    jz close_file

    ; Check if we are at the start of the relevant line
    cmp bl, 1
    jne check_next_line
    ; We are at the start of the line to modify
    ; Copy up to the '=' character
    mov al, [buffer + si]
    mov [buffer + di], al
    inc si
    inc di
    cmp al, '='
    je replace_key
    jmp modify_loop

check_next_line:
    ; Check if we are at a newline character
    cmp byte [buffer + si], 0x0D ; Carriage return
    jne skip_char
    inc si ; Skip newline
    cmp byte [buffer + si], 0x0A ; Line feed
    jne skip_char
    inc si ; Skip newline
    dec bl ; Decrement line number
    jmp modify_loop

skip_char:
    inc si ; Move to next character
    jmp modify_loop

replace_key:
    ; Replace the key
    mov al, [newKey]
    mov [buffer + di], al
    inc di
    ; Copy the rest of the line
copy_rest_of_line:
    mov al, [buffer + si]
    mov [buffer + di], al
    inc si
    inc di
    cmp al, 0x0D ; Carriage return
    jne copy_rest_of_line

    ; Write modified buffer back to file
    mov ah, 0x40 ; Function: Write to file or device
    mov bx, [fileHandle]
    lea dx, [buffer]
    mov cx, [readBytes] ; Write the same number of bytes as read
    int 0x21
    jc error ; Jump if carry flag is set (error)

close_file:
    ; Close the file
    mov ah, 0x3E
    mov bx, [fileHandle]
    int 0x21
    jc error

    ret

; Function to exit the program and return to DOS
exit_program:
    mov ax, 0x4C00  ; Function 4Ch of interrupt 21h: Exit with return code
    int 0x21        ; Call DOS interrupt
    ret             ; The ret instruction here is for safety, but it should never be reached