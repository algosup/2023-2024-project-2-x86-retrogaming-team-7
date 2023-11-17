org 100h

section .data
    mainWelcome db 'Welcome to Pac-Man$'

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
