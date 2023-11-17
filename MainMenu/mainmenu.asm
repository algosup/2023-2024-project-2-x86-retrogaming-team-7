org 100h

section .data
    ; set all the printed strings ont the mai
    mainWelcome db 'Welcome to Pac-Man$'
    settingsChoice db 'Settings$'
    startChoice db 'Start$'
    exitChoice db 'Exit$'
    
section .bss

section .text
    global _start

_start:
    call main_menu
    
main_menu:
    mov ax, 0x0003
    int 0x10
    mov ah, 0x0E
    mov si, mainWelcome
    call print_string
    call wait_for_escape
    ret

print_string:
    next_char:
        lodsb
        cmp al, '$'
        je end_string
        int 0x10
        jmp next_char
    end_string:
        ret

wait_for_escape:
    ; Wait for key press in a loop until 'Escape' is pressed
    wait_loop:
        mov ah, 0x00
        int 0x16  ; BIOS keyboard service
        cmp al, 0x1B
        je _start  ; Jump to start if Escape key is pressed
        jmp wait_loop  ; Otherwise, keep waiting

; clear_screen:
;     mov ah, 0x00
;     mov al, 0
;     mov bh, 0x07
;     mov cx, 0
;     mov dx, 184Fh
;     int 0x10
;     ret

; startGame:


; settings:


; keyBinding:


; programEnd:
;     mov ah, 4Ch     
;     xor al, al      
;     int 21h