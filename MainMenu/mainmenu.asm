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
    mov ah, 00h
    mov al, 13h
    int 10h
    call clearScreen
    call main_menu

main_menu:
    mov al, mainWelcome
    int 0x10
    loop main_menu

clearScreen:
    mov bx, 0xA000
    mov es, bx
    mov di, 0
    mov cx, 200*320
    rep stosb 
    ret

startGame:


settings:


keyBinding:


programEnd:
    mov ah, 4Ch     
    xor al, al      
    int 21h