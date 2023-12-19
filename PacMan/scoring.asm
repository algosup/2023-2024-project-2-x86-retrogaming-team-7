section .data
current_score dw 0
point_pellet dw 10
point_super_pellet dw 30
point_ghost_ dw 200
point_cherry dw 100
point_strawberry dw 300
point_orange dw 500
point_apple dw 700
point_melon dw 1000
point_ship dw 2000
point_bell dw 3000
point_key dw 5000
scoreCurrentSprite dw 0
scoreFiveRecord dw 0
scoreFourRecord dw 0
scoreThreeRecord dw 0
scoreTwoRecord dw 0
scoreOneRecord dw 0
pelletsNumbers db 188

yScorePos dw 0
xScorePos dw 0
%define SPRITEW 8
%define SPRITEH 8
section .text
display_score:
    ; Affiche "S"
    mov word [scoreCurrentSprite], alphabetS
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 264
    mov word [yScorePos], 21
    call scoringDraw
    ; Affiche "C"
    mov word [scoreCurrentSprite], alphabetC
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 272  ; 10 + 8
    call scoringDraw
    ; Affiche "O"
    mov word [scoreCurrentSprite], alphabetO
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 280  ; 18 + 8
    call scoringDraw
    ; Affiche "R"
    mov word [scoreCurrentSprite], alphabetR
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 288  ; 26 + 8
    call scoringDraw
    ; Affiche "E"
    mov word [scoreCurrentSprite], alphabetE
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 296  ; 34 + 8
    call scoringDraw
    call points 
    ret
points:
    mov word [scoreCurrentSprite], number0
    call five
    call four
    call three
    call two
    call one
    ret
    
five:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 264
    call scoringDraw
    ret
four:
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 272
    call scoringDraw
    ret
three:
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 280
    call scoringDraw
    ret
two:
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 288
    call scoringDraw
    ret
one:
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 296
    call scoringDraw
    ret
scoringDraw:
    mov ax, [xScorePos]
    mov ax, [yScorePos]
    ; Reset the graphic segment
    mov ax, 0A000h
    mov es, ax
    ; Cacul the addresse to the screen where the sprite will be draw
    mov ax, [yScorePos]
    imul ax, 320       ;  Multiply yPos par the width of screen to get the offset
    add ax, [xScorePos]     ; Add xPos to the offset
    mov di, ax         ; DI = address for the draw 
    ; Get the addresses's sprite to draw
    mov cx, SPRITEH     ; Define the sprite's height
    .draw_line:
        push cx     ; Save CX else modify by rep
        mov cx, SPRITEW     ; Define the width for the current row
        rep movsb  ; Print the sprite's row
        pop cx  ; Restore CX for the next sprite's row
        ; Adjust DI for the next rows and take in account the width offset
        add di, 320 - SPRITEW
        loop .draw_line  ; Repeat the draw for each sprite's rows
        ret

pelletsPoints:
    call scoreFour
    ret
superPelletUpdate:
    call scoreFourSP
    ret

scoreFour:
    cmp word [scoreFourRecord], 9
    je .scoreThree
    add word [scoreFourRecord], 1
    cmp word [scoreFourRecord], 0
    je .printNumberZero
    cmp word [scoreFourRecord], 1
    je .printNumberOne
    cmp word [scoreFourRecord], 2
    je .printNumberTwo
    cmp word [scoreFourRecord], 3
    je .printNumberThree
    cmp word [scoreFourRecord], 4
    je .printNumberFour
    cmp word [scoreFourRecord], 5
    je .printNumberFive
    cmp word [scoreFourRecord], 6
    je .printNumberSix
    cmp word [scoreFourRecord], 7
    je .printNumberSeven
    cmp word [scoreFourRecord], 8
    je .printNumberEight
    cmp word [scoreFourRecord], 9
    je .printNumberNine

    .printNumberZero:
    mov word [scoreCurrentSprite], number0
    jmp .end
    .printNumberOne:
    mov word [scoreCurrentSprite], number1
    jmp .end    
    .printNumberTwo:
    mov word [scoreCurrentSprite], number2
    jmp .end
    .printNumberThree:
    mov word [scoreCurrentSprite], number3
    jmp .end
    .printNumberFour:
    mov word [scoreCurrentSprite], number4
    jmp .end
    .printNumberFive:
    mov word [scoreCurrentSprite], number5
    jmp .end
    .printNumberSix:
    mov word [scoreCurrentSprite], number6
    jmp .end
    .printNumberSeven:
    mov word [scoreCurrentSprite], number7
    jmp .end
    .printNumberEight:
    mov word [scoreCurrentSprite], number8
    jmp .end
    .printNumberNine:
    mov word [scoreCurrentSprite], number9
    jmp .end
    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 288
    call scoringDraw
    ret

    .scoreThree:
    mov word [scoreFourRecord], 0
    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 288
    call scoringDraw
    call scoreThree
    ret

scoreThree:
    cmp word [scoreThreeRecord], 9
    je .scoreTwo
    add word [scoreThreeRecord], 1
    cmp word [scoreThreeRecord], 1
    je .printNumberOne
    cmp word [scoreThreeRecord], 2
    je .printNumberTwo
    cmp word [scoreThreeRecord], 3
    je .printNumberThree
    cmp word [scoreThreeRecord], 4
    je .printNumberFour
    cmp word [scoreThreeRecord], 5
    je .printNumberFive
    cmp word [scoreThreeRecord], 6
    je .printNumberSix
    cmp word [scoreThreeRecord], 7
    je .printNumberSeven
    cmp word [scoreThreeRecord], 8
    je .printNumberEight
    cmp word [scoreThreeRecord], 9
    je .printNumberNine

    .printNumberOne:
    mov word [scoreCurrentSprite], number1
    jmp .end    
    .printNumberTwo:
    mov word [scoreCurrentSprite], number2
    jmp .end
    .printNumberThree:
    mov word [scoreCurrentSprite], number3
    jmp .end
    .printNumberFour:
    mov word [scoreCurrentSprite], number4
    jmp .end
    .printNumberFive:
    mov word [scoreCurrentSprite], number5
    jmp .end
    .printNumberSix:
    mov word [scoreCurrentSprite], number6
    jmp .end
    .printNumberSeven:
    mov word [scoreCurrentSprite], number7
    jmp .end
    .printNumberEight:
    mov word [scoreCurrentSprite], number8
    jmp .end
    .printNumberNine:
    mov word [scoreCurrentSprite], number9
    jmp .end
    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 280
    call scoringDraw
    ret

    .scoreTwo:
    mov word [scoreThreeRecord], 0
    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 280
    call scoringDraw
    call scoreTwo
    ret

scoreTwo:
    cmp word [scoreTwoRecord], 9
    je .scoreOne
    add word [scoreTwoRecord], 1
    cmp word [scoreTwoRecord], 1
    je .printNumberOne
    cmp word [scoreTwoRecord], 2
    je .printNumberTwo
    cmp word [scoreTwoRecord], 3
    je .printNumberThree
    cmp word [scoreTwoRecord], 4
    je .printNumberFour
    cmp word [scoreTwoRecord], 5
    je .printNumberFive
    cmp word [scoreTwoRecord], 6
    je .printNumberSix
    cmp word [scoreTwoRecord], 7
    je .printNumberSeven
    cmp word [scoreTwoRecord], 8
    je .printNumberEight
    cmp word [scoreTwoRecord], 9
    je .printNumberNine

    .printNumberOne:
    mov word [scoreCurrentSprite], number1
    jmp .end    
    .printNumberTwo:
    mov word [scoreCurrentSprite], number2
    jmp .end
    .printNumberThree:
    mov word [scoreCurrentSprite], number3
    jmp .end
    .printNumberFour:
    mov word [scoreCurrentSprite], number4
    jmp .end
    .printNumberFive:
    mov word [scoreCurrentSprite], number5
    jmp .end
    .printNumberSix:
    mov word [scoreCurrentSprite], number6
    jmp .end
    .printNumberSeven:
    mov word [scoreCurrentSprite], number7
    jmp .end
    .printNumberEight:
    mov word [scoreCurrentSprite], number8
    jmp .end
    .printNumberNine:
    mov word [scoreCurrentSprite], number9
    jmp .end
    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 272
    call scoringDraw
    ret

    .scoreOne:
    mov word [scoreTwoRecord], 0
    mov word [scoreCurrentSprite], number0
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 272
    call scoringDraw
    call scoreOne
    ret

scoreOne:
    add word [scoreOneRecord], 1
    cmp word [scoreOneRecord], 1
    je .printNumberOne
    cmp word [scoreOneRecord], 2
    je .printNumberTwo
    cmp word [scoreOneRecord], 3
    je .printNumberThree
    cmp word [scoreOneRecord], 4
    je .printNumberFour
    cmp word [scoreOneRecord], 5
    je .printNumberFive
    cmp word [scoreOneRecord], 6
    je .printNumberSix
    cmp word [scoreOneRecord], 7
    je .printNumberSeven
    cmp word [scoreOneRecord], 8
    je .printNumberEight
    cmp word [scoreOneRecord], 9
    je .printNumberNine

    .printNumberOne:
    mov word [scoreCurrentSprite], number1
    jmp .end    
    .printNumberTwo:
    mov word [scoreCurrentSprite], number2
    jmp .end
    .printNumberThree:
    mov word [scoreCurrentSprite], number3
    jmp .end
    .printNumberFour:
    mov word [scoreCurrentSprite], number4
    jmp .end
    .printNumberFive:
    mov word [scoreCurrentSprite], number5
    jmp .end
    .printNumberSix:
    mov word [scoreCurrentSprite], number6
    jmp .end
    .printNumberSeven:
    mov word [scoreCurrentSprite], number7
    jmp .end
    .printNumberEight:
    mov word [scoreCurrentSprite], number8
    jmp .end
    .printNumberNine:
    mov word [scoreCurrentSprite], number9
    jmp .end
    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 264
    call scoringDraw
    ret

scoreFourSP:
    add word [scoreFourRecord], 3
    cmp word [scoreFourRecord], 3
    je .printNumberThreeSP
    cmp word [scoreFourRecord], 4
    je .printNumberFourSP
    cmp word [scoreFourRecord], 5
    je .printNumberFiveSP
    cmp word [scoreFourRecord], 6
    je .printNumberSixSP
    cmp word [scoreFourRecord], 7
    je .printNumberSevenSP
    cmp word [scoreFourRecord], 8
    je .printNumberEightSP
    cmp word [scoreFourRecord], 9
    je .printNumberNineSP
    cmp word [scoreFourRecord], 10
    je .printNumberZeroSP
    cmp word [scoreFourRecord], 11
    je .printNumberOneSP
    cmp word [scoreFourRecord], 12
    je .printNumberTwoSP

    .printNumberThreeSP:
    mov word [scoreCurrentSprite], number3
    jmp .end

    .printNumberFourSP:
    mov word [scoreCurrentSprite], number4
    jmp .end

    .printNumberFiveSP:
    mov word [scoreCurrentSprite], number5
    jmp .end

    .printNumberSixSP:
    mov word [scoreCurrentSprite], number6
    jmp .end

    .printNumberSevenSP:
    mov word [scoreCurrentSprite], number7
    jmp .end

    .printNumberEightSP:
    mov word [scoreCurrentSprite], number8
    jmp .end

    .printNumberNineSP:
    mov word [scoreCurrentSprite], number9
    jmp .end

    .printNumberZeroSP:
    mov word [scoreFourRecord], 0
    mov word [scoreCurrentSprite], number0
    jmp .nextLevel

    .printNumberOneSP:
    mov word [scoreFourRecord], 1
    mov word [scoreCurrentSprite], number1
    jmp .nextLevel

    .printNumberTwoSP:
    mov word [scoreFourRecord], 2
    mov word [scoreCurrentSprite], number2
    jmp .nextLevel

    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 288
    call scoringDraw
    ret

    .nextLevel:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 288
    call scoringDraw
    call scoreThreeSP
    ret

scoreThreeSP:
    add word [scoreThreeRecord], 3
    cmp word [scoreThreeRecord], 3
    je .printNumberThreeSP
    cmp word [scoreThreeRecord], 4
    je .printNumberFourSP
    cmp word [scoreThreeRecord], 5
    je .printNumberFiveSP
    cmp word [scoreThreeRecord], 6
    je .printNumberSixSP
    cmp word [scoreThreeRecord], 7
    je .printNumberSevenSP
    cmp word [scoreThreeRecord], 8
    je .printNumberEightSP
    cmp word [scoreThreeRecord], 9
    je .printNumberNineSP
    cmp word [scoreThreeRecord], 10
    je .printNumberZeroSP
    cmp word [scoreThreeRecord], 11
    je .printNumberOneSP
    cmp word [scoreThreeRecord], 12
    je .printNumberTwoSP

    .printNumberFourSP:
    mov word [scoreCurrentSprite], number4
    jmp .end

    .printNumberFiveSP:
    mov word [scoreCurrentSprite], number5
    jmp .end

    .printNumberSixSP:
    mov word [scoreCurrentSprite], number6
    jmp .end

    .printNumberSevenSP:
    mov word [scoreCurrentSprite], number7
    jmp .end

    .printNumberEightSP:
    mov word [scoreCurrentSprite], number8
    jmp .end

    .printNumberNineSP:
    mov word [scoreCurrentSprite], number9
    jmp .end

    .printNumberZeroSP:
    mov word [scoreThreeRecord], 0
    mov word [scoreCurrentSprite], number0
    jmp .nextLevelSP

    .printNumberOneSP:
    mov word [scoreThreeRecord], 1
    mov word [scoreCurrentSprite], number1
    jmp .nextLevelSP

    .printNumberTwoSP:
    mov word [scoreThreeRecord], 2
    mov word [scoreCurrentSprite], number2
    jmp .nextLevelSP

    .printNumberThreeSP:
    mov word [scoreThreeRecord], 3
    mov word [scoreCurrentSprite], number3
    jmp .nextLevelSP

    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 280
    call scoringDraw
    ret

    .nextLevelSP:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 280
    call scoringDraw
    ; call scoreTwoSP
    ret