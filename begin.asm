org 100h ; Set the origin for the program, necessary for .COM files
section .data
    menu db 'Main Menu', 13, 10, 0  ; Menu title
    startOption db 'Start', 13, 10, 0
    gameModeOption db 'Game Mode', 13, 10, 0
    settingsOption db 'Settings', 13, 10, 0
    menuItems dw startOption, gameModeOption, settingsOption
    currentSelection db 0 ; Start with the first menu item selected
    menuItemCount db 3 ; Total number of menu items
section .bss
    ; No uninitialized data for now.
section .text
    global _start
_start:
initialize_game:
    ; Set up the video mode to 80x25 text mode
    mov ax, 0x0003
    int 0x10
    ; Display the menu
    call display_menu
main_game_loop:
    call handle_input   ; Get and handle user input
    jmp main_game_loop  ; Continue looping
; Function to display the menu
display_menu:
    mov ah, 0x02        ; Function for setting cursor position
    mov bh, 0x00        ; Page number
    mov dh, 2           ; Row (Y coordinate) for "Main Menu"
    mov dl, 35          ; Column (X coordinate) for "Main Menu"
    int 0x10            ; Call video interrupt
    ; Display "Main Menu"
    mov si, menu        ; Point SI to the start of the "Main Menu" text
    call print_string   ; Call print string function
    ; Display menu items
    call print_menu_items
    ret
print_menu_items:
    mov cl, [menuItemCount]  ; Number of menu items
    mov si, menuItems        ; Address of menu items
    mov dh, 4                ; Starting Row (Y coordinate) for menu items
print_next_item:
    mov ah, 0x02            ; Function for setting cursor position
    mov bh, 0x00            ; Page number
    mov dl, 35              ; Column (X coordinate) for menu items
    int 0x10                ; Call video interrupt
    mov bx, si              ; Save current position of SI
    lodsw                   ; Load word at SI into AX (address of the menu item string)
    mov si, ax              ; Point SI to our menu item string
    cmp cl, [currentSelection]
    jne print_item_normal   ; If this is not the current selection, print normally
    call print_string_highlighted
    jmp short print_next_item_continue
print_item_normal:
    call print_string       ; Call print string function
print_next_item_continue:
    mov si, bx              ; Restore SI position
    add si, 2               ; Move SI to the next word in the menuItems array
    add dh, 2               ; Move to the next line
    dec cl                  ; Decrement the menu item count
    jnz print_next_item     ; If there are more items, loop again
    ret
print_string_highlighted:  ; This function expects a string pointed to by SI
    mov ah, 0x09            ; BIOS function to write character and attribute
    mov bl, 0x70            ; Attribute for highlighted text
    mov cx, 1               ; Number of times to write the character
    print_highlighted_char:
        lodsb               ; Load string byte into AL
        or al, al           ; Check if it's zero (end of string)
        jz return_highlighted ; If zero, we are at the end
        int 0x10            ; Write character and attribute
        jmp print_highlighted_char
    return_highlighted:
    ret
; Print a null-terminated string pointed to by SI
print_string:
    next_char:
        lodsb               ; Load next byte from SI into AL
        or al, al           ; OR AL with itself to check if it's zero (null-terminator)
        jz return           ; If zero, we are at the end of the string
        mov ah, 0x0E        ; Teletype output function
        int 0x10            ; Call video interrupt to print AL
        jmp next_char       ; Loop to print next character
    return:
        ret
; Handle user input
handle_input:
    mov ah, 0x01           ; BIOS keyboard service - check for keystroke
    int 0x16             
 ; BIOS keyboard interrupt
    jz main_game_loop      ; If no key is pressed, just return to the main loop
    ; Read the key pressed
    mov ah, 0x00
    int 0x16
    cmp ah, 0x48           ; Check if the 'up arrow' was pressed
    je move_up
    cmp ah, 0x50           ; Check if the 'down arrow' was pressed
    je move_down
    ret
move_up:
    ; Decrement current selection, if not the first item
    dec byte [currentSelection]
    js  set_to_max         ; If selection is < 0, set it to max (2 in this case)
    jmp short display_menu
move_down:
    ; Increment current selection, if not the last item
    inc byte [currentSelection]
    cmp byte [currentSelection], menuItemCount
    jae set_to_zero        ; If selection is >= menuItemCount, set it to zero
    jmp short display_menu
set_to_max:
    mov byte [currentSelection], menuItemCount - 1 ; Set to the last menu item index
    jmp short display_menu
set_to_zero:
    mov byte [currentSelection], 0 ; Set to the first menu item index
    jmp short display_menu