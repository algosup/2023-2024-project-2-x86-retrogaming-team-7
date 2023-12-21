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
pelletsNumbers db 50
superPelletsNumbers db 0

yScorePos dw 0
xScorePos dw 0

xLivesPos dw 0
yLivesPos dw 0
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
    ; Affiche "L"
    mov word [scoreCurrentSprite], alphabetL
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 264
    mov word [yScorePos], 53
    call scoringDraw
    ; Affiche "I"
    mov word [scoreCurrentSprite], alphabetI
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 272
    call scoringDraw
    ; Affiche "V"
    mov word [scoreCurrentSprite], alphabetV
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 280
    call scoringDraw
    ; Affiche "E"
    mov word [scoreCurrentSprite], alphabetE
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 288
    call scoringDraw
    ; Affiche "S"
    mov word [scoreCurrentSprite], alphabetS
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 296
    call scoringDraw
    call points
display_lives:
    mov word [lives_sprite], pacman_left_1
    mov si, [lives_sprite]
    mov word [xLivesPos], 264
    mov word [yLivesPos], 65
    call drawSprite
    mov word [lives_sprite], pacman_left_1
    mov si, [lives_sprite]
    mov word [xLivesPos], 272
    mov word [yLivesPos], 65
    call drawSprite
    mov word [lives_sprite], pacman_left_1
    mov si, [lives_sprite]
    mov word [xLivesPos], 280
    mov word [yLivesPos], 65
    call drawSprite
    mov word [lives_sprite], pacman_left_1
    mov si, [lives_sprite]
    mov word [xLivesPos], 288
    mov word [yLivesPos], 65
    call drawSprite
    ret

drawSprite:
    mov ax, 0A000h
    mov es, ax
    mov ax, [yLivesPos]
    imul ax, 320
    add ax, [xLivesPos]
    mov di, ax
    mov cx, SPRITEH
    .draw_line:
        push cx
        mov cx, SPRITEW
        rep movsb
        pop cx
        add di, 320 - SPRITEW
        loop .draw_line
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

checkPelletNumber:
    cmp byte [pelletsNumbers], 0
    je .firstCheckResetMapPellet
    jne .end
    .firstCheckResetMapPellet:
    cmp byte [superPelletsNumbers], 0
    je resetMapPellet
    ret
    .end:
    ret

checkSuperPelletNumber:
    cmp byte [superPelletsNumbers], 0
    je .firstCheckResetMapSuperPellet
    jne .end
    .firstCheckResetMapSuperPellet:
    cmp byte [pelletsNumbers], 0
    je resetMapPellet
    ret
    .end:
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
    add word [scoreThreeRecord], 1
    cmp word [scoreThreeRecord], 1
    je .printNumberOneESP
    cmp word [scoreThreeRecord], 2
    je .printNumberTwoESP
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

    .printNumberOneESP:
    mov word [scoreCurrentSprite], number1
    jmp .end

    .printNumberTwoESP:
    mov word [scoreCurrentSprite], number2
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
    call scoreTwoSP
    ret

scoreTwoSP:
    add word [scoreTwoRecord], 1
    cmp word [scoreTwoRecord], 0
    je .printNumberZeroSP
    cmp word [scoreTwoRecord], 1
    je .printNumberOneESP
    cmp word [scoreTwoRecord], 2
    je .printNumberTwoESP
    cmp word [scoreTwoRecord], 3
    je .printNumberThreeSP
    cmp word [scoreTwoRecord], 4
    je .printNumberFourSP
    cmp word [scoreTwoRecord], 5
    je .printNumberFiveSP
    cmp word [scoreTwoRecord], 6
    je .printNumberSixSP
    cmp word [scoreTwoRecord], 7
    je .printNumberSevenSP
    cmp word [scoreTwoRecord], 8
    je .printNumberEightSP
    cmp word [scoreTwoRecord], 9
    je .printNumberNineSP
    cmp word [scoreTwoRecord], 10
    je .printNumberZeroSP
    cmp word [scoreTwoRecord], 11
    je .printNumberOneSP
    cmp word [scoreTwoRecord], 12
    je .printNumberTwoSP

    .printNumberOneESP:
    mov word [scoreCurrentSprite], number1
    jmp .end

    .printNumberTwoESP:
    mov word [scoreCurrentSprite], number2
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
    mov word [scoreTwoRecord], 0
    mov word [scoreCurrentSprite], number0
    jmp .nextLevelSP

    .printNumberOneSP:
    mov word [scoreTwoRecord], 1
    mov word [scoreCurrentSprite], number1
    jmp .nextLevelSP

    .printNumberTwoSP:
    mov word [scoreTwoRecord], 2
    mov word [scoreCurrentSprite], number2
    jmp .nextLevelSP

    .printNumberThreeSP:
    mov word [scoreTwoRecord], 3
    mov word [scoreCurrentSprite], number3
    jmp .nextLevelSP

    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 272
    call scoringDraw
    ret

    .nextLevelSP:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 272
    call scoringDraw
    call scoreOneSP
    ret

scoreOneSP:
    add word [scoreOneRecord], 1
    cmp word [scoreOneRecord], 1
    je .printNumberOneESP
    cmp word [scoreOneRecord], 2
    je .printNumberTwoESP
    cmp word [scoreOneRecord], 3
    je .printNumberThreeSP
    cmp word [scoreOneRecord], 4
    je .printNumberFourSP
    cmp word [scoreOneRecord], 5
    je .printNumberFiveSP
    cmp word [scoreOneRecord], 6
    je .printNumberSixSP
    cmp word [scoreOneRecord], 7
    je .printNumberSevenSP
    cmp word [scoreOneRecord], 8
    je .printNumberEightSP
    cmp word [scoreOneRecord], 9
    je .printNumberNineSP
    cmp word [scoreOneRecord], 10
    je .printNumberZeroSP
    cmp word [scoreOneRecord], 11
    je .printNumberOneSP
    cmp word [scoreOneRecord], 12
    je .printNumberTwoSP

    .printNumberOneESP:
    mov word [scoreCurrentSprite], number1
    jmp .end

    .printNumberTwoESP:
    mov word [scoreCurrentSprite], number2
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
    mov word [scoreOneRecord], 0
    mov word [scoreCurrentSprite], number0
    jmp .end

    .printNumberOneSP:
    mov word [scoreOneRecord], 1
    mov word [scoreCurrentSprite], number1
    jmp .end

    .printNumberTwoSP:
    mov word [scoreOneRecord], 2
    mov word [scoreCurrentSprite], number2
    jmp .end

    .printNumberThreeSP:
    mov word [scoreOneRecord], 3
    mov word [scoreCurrentSprite], number3
    jmp .end

    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 33
    mov word [xScorePos], 264
    call scoringDraw
    ret

;========================
; END GAME GG
;========================
drawNumbersGG:
    cmp word [scoreFiveRecord], 0
    je .numberFiveDrawZero
    cmp word [scoreFiveRecord], 1
    je .numberFiveDrawOne
    cmp word [scoreFiveRecord], 2
    je .numberFiveDrawTwo
    cmp word [scoreFiveRecord], 3
    je .numberFiveDrawThree
    cmp word [scoreFiveRecord], 4
    je .numberFiveDrawFour
    cmp word [scoreFiveRecord], 5
    je .numberFiveDrawFive
    cmp word [scoreFiveRecord], 6
    je .numberFiveDrawSix
    cmp word [scoreFiveRecord], 7
    je .numberFiveDrawSeven
    cmp word [scoreFiveRecord], 8
    je .numberFiveDrawEight
    cmp word [scoreFiveRecord], 9
    je .numberFiveDrawNine

    .numberFiveDrawZero:
    mov word [scoreCurrentSprite], number0
    jmp .beforeNumberFour
    .numberFiveDrawOne:
    mov word [scoreCurrentSprite], number1
    jmp .beforeNumberFour
    .numberFiveDrawTwo:
    mov word [scoreCurrentSprite], number2
    jmp .beforeNumberFour
    .numberFiveDrawThree:
    mov word [scoreCurrentSprite], number3
    jmp .beforeNumberFour
    .numberFiveDrawFour:
    mov word [scoreCurrentSprite], number4
    jmp .beforeNumberFour
    .numberFiveDrawFive:
    mov word [scoreCurrentSprite], number5
    jmp .beforeNumberFour
    .numberFiveDrawSix:
    mov word [scoreCurrentSprite], number6
    jmp .beforeNumberFour
    .numberFiveDrawSeven:
    mov word [scoreCurrentSprite], number7
    jmp .beforeNumberFour
    .numberFiveDrawEight:
    mov word [scoreCurrentSprite], number8
    jmp .beforeNumberFour
    .numberFiveDrawNine:
    mov word [scoreCurrentSprite], number9
    jmp .beforeNumberFour

    .beforeNumberFour:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 100
    mov word [xScorePos], 172
    call scoringDraw

    cmp word [scoreFourRecord], 0
    je .numberFourDrawZero
    cmp word [scoreFourRecord], 1
    je .numberFourDrawOne
    cmp word [scoreFourRecord], 2
    je .numberFourDrawTwo
    cmp word [scoreFourRecord], 3
    je .numberFourDrawThree
    cmp word [scoreFourRecord], 4
    je .numberFourDrawFour
    cmp word [scoreFourRecord], 5
    je .numberFourDrawFive
    cmp word [scoreFourRecord], 6
    je .numberFourDrawSix
    cmp word [scoreFourRecord], 7
    je .numberFourDrawSeven
    cmp word [scoreFourRecord], 8
    je .numberFourDrawEight
    cmp word [scoreFourRecord], 9
    je .numberFourDrawNine

    .numberFourDrawZero:
    mov word [scoreCurrentSprite], number0
    jmp .beforeNumberThree
    .numberFourDrawOne:
    mov word [scoreCurrentSprite], number1
    jmp .beforeNumberThree
    .numberFourDrawTwo:
    mov word [scoreCurrentSprite], number2
    jmp .beforeNumberThree
    .numberFourDrawThree:
    mov word [scoreCurrentSprite], number3
    jmp .beforeNumberThree
    .numberFourDrawFour:
    mov word [scoreCurrentSprite], number4
    jmp .beforeNumberThree
    .numberFourDrawFive:
    mov word [scoreCurrentSprite], number5
    jmp .beforeNumberThree
    .numberFourDrawSix:
    mov word [scoreCurrentSprite], number6
    jmp .beforeNumberThree
    .numberFourDrawSeven:
    mov word [scoreCurrentSprite], number7
    jmp .beforeNumberThree
    .numberFourDrawEight:
    mov word [scoreCurrentSprite], number8
    jmp .beforeNumberThree
    .numberFourDrawNine:
    mov word [scoreCurrentSprite], number9
    jmp .beforeNumberThree

    .beforeNumberThree:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 100
    mov word [xScorePos], 164
    call scoringDraw

    cmp word [scoreThreeRecord], 0
    je .numberThreeDrawZero
    cmp word [scoreThreeRecord], 1
    je .numberThreeDrawOne
    cmp word [scoreThreeRecord], 2
    je .numberThreeDrawTwo
    cmp word [scoreThreeRecord], 3
    je .numberThreeDrawThree
    cmp word [scoreThreeRecord], 4
    je .numberThreeDrawFour
    cmp word [scoreThreeRecord], 5
    je .numberThreeDrawFive
    cmp word [scoreThreeRecord], 6
    je .numberThreeDrawSix
    cmp word [scoreThreeRecord], 7
    je .numberThreeDrawSeven
    cmp word [scoreThreeRecord], 8
    je .numberThreeDrawEight
    cmp word [scoreThreeRecord], 9
    je .numberThreeDrawNine

    .numberThreeDrawZero:
    mov word [scoreCurrentSprite], number0
    jmp .beforeNumberTwo
    .numberThreeDrawOne:
    mov word [scoreCurrentSprite], number1
    jmp .beforeNumberTwo
    .numberThreeDrawTwo:
    mov word [scoreCurrentSprite], number2
    jmp .beforeNumberTwo
    .numberThreeDrawThree:
    mov word [scoreCurrentSprite], number3
    jmp .beforeNumberTwo
    .numberThreeDrawFour:
    mov word [scoreCurrentSprite], number4
    jmp .beforeNumberTwo
    .numberThreeDrawFive:
    mov word [scoreCurrentSprite], number5
    jmp .beforeNumberTwo
    .numberThreeDrawSix:
    mov word [scoreCurrentSprite], number6
    jmp .beforeNumberTwo
    .numberThreeDrawSeven:
    mov word [scoreCurrentSprite], number7
    jmp .beforeNumberTwo
    .numberThreeDrawEight:
    mov word [scoreCurrentSprite], number8
    jmp .beforeNumberTwo
    .numberThreeDrawNine:
    mov word [scoreCurrentSprite], number9
    jmp .beforeNumberTwo

    .beforeNumberTwo:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 100
    mov word [xScorePos], 156
    call scoringDraw

    cmp word [scoreTwoRecord], 0
    je .numberTwoDrawZero
    cmp word [scoreTwoRecord], 1
    je .numberTwoDrawOne
    cmp word [scoreTwoRecord], 2
    je .numberTwoDrawTwo
    cmp word [scoreTwoRecord], 3
    je .numberTwoDrawThree
    cmp word [scoreTwoRecord], 4
    je .numberTwoDrawFour
    cmp word [scoreTwoRecord], 5
    je .numberTwoDrawFive
    cmp word [scoreTwoRecord], 6
    je .numberTwoDrawSix
    cmp word [scoreTwoRecord], 7
    je .numberTwoDrawSeven
    cmp word [scoreTwoRecord], 8
    je .numberTwoDrawEight
    cmp word [scoreTwoRecord], 9
    je .numberTwoDrawNine

    .numberTwoDrawZero:
    mov word [scoreCurrentSprite], number0
    jmp .beforeNumberOne
    .numberTwoDrawOne:
    mov word [scoreCurrentSprite], number1
    jmp .beforeNumberOne
    .numberTwoDrawTwo:
    mov word [scoreCurrentSprite], number2
    jmp .beforeNumberOne
    .numberTwoDrawThree:
    mov word [scoreCurrentSprite], number3
    jmp .beforeNumberOne
    .numberTwoDrawFour:
    mov word [scoreCurrentSprite], number4
    jmp .beforeNumberOne
    .numberTwoDrawFive:
    mov word [scoreCurrentSprite], number5
    jmp .beforeNumberOne
    .numberTwoDrawSix:
    mov word [scoreCurrentSprite], number6
    jmp .beforeNumberOne
    .numberTwoDrawSeven:
    mov word [scoreCurrentSprite], number7
    jmp .beforeNumberOne
    .numberTwoDrawEight:
    mov word [scoreCurrentSprite], number8
    jmp .beforeNumberOne
    .numberTwoDrawNine:
    mov word [scoreCurrentSprite], number9
    jmp .beforeNumberOne

    .beforeNumberOne:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 100
    mov word [xScorePos], 148
    call scoringDraw
    
    cmp word [scoreOneRecord], 0
    je .numberOneDrawZero
    cmp word [scoreOneRecord], 1
    je .numberOneDrawOne
    cmp word [scoreOneRecord], 2
    je .numberOneDrawTwo
    cmp word [scoreOneRecord], 3
    je .numberOneDrawThree
    cmp word [scoreOneRecord], 4
    je .numberOneDrawFour
    cmp word [scoreOneRecord], 5
    je .numberOneDrawFive
    cmp word [scoreOneRecord], 6
    je .numberOneDrawSix
    cmp word [scoreOneRecord], 7
    je .numberOneDrawSeven
    cmp word [scoreOneRecord], 8
    je .numberOneDrawEight
    cmp word [scoreOneRecord], 9
    je .numberOneDrawNine

    .numberOneDrawZero:
    mov word [scoreCurrentSprite], number0
    jmp .end
    .numberOneDrawOne:
    mov word [scoreCurrentSprite], number1
    jmp .end
    .numberOneDrawTwo:
    mov word [scoreCurrentSprite], number2
    jmp .end
    .numberOneDrawThree:
    mov word [scoreCurrentSprite], number3
    jmp .end
    .numberOneDrawFour:
    mov word [scoreCurrentSprite], number4
    jmp .end
    .numberOneDrawFive:
    mov word [scoreCurrentSprite], number5
    jmp .end
    .numberOneDrawSix:
    mov word [scoreCurrentSprite], number6
    jmp .end
    .numberOneDrawSeven:
    mov word [scoreCurrentSprite], number7
    jmp .end
    .numberOneDrawEight:
    mov word [scoreCurrentSprite], number8
    jmp .end
    .numberOneDrawNine:
    mov word [scoreCurrentSprite], number9
    jmp .end

    .end:
    mov si, [scoreCurrentSprite]
    mov word [yScorePos], 100
    mov word [xScorePos], 140
    call scoringDraw
    ret

displayEndScore:
    mov word [scoreCurrentSprite], alphabetE
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 132
    mov word [yScorePos], 78
    call scoringDraw

    mov word [scoreCurrentSprite], alphabetN
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 140
    call scoringDraw
    
    mov word [scoreCurrentSprite], alphabetD
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 148
    call scoringDraw
    ; Affiche "G"
    mov word [scoreCurrentSprite], alphabetG
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 158
    call scoringDraw

    mov word [scoreCurrentSprite], alphabetA
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 166
    call scoringDraw

    mov word [scoreCurrentSprite], alphabetM
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 174
    call scoringDraw

    mov word [scoreCurrentSprite], alphabetE
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 182
    call scoringDraw
    ; Affiche "S"
    mov word [scoreCurrentSprite], alphabetS
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 140
    mov word [yScorePos], 92
    call scoringDraw
    ; Affiche "C"
    mov word [scoreCurrentSprite], alphabetC
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 148  ; 10 + 8
    call scoringDraw
    ; Affiche "O"
    mov word [scoreCurrentSprite], alphabetO
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 156  ; 18 + 8
    call scoringDraw
    ; Affiche "R"
    mov word [scoreCurrentSprite], alphabetR
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 164  ; 26 + 8
    call scoringDraw
    ; Affiche "E"
    mov word [scoreCurrentSprite], alphabetE
    mov si, [scoreCurrentSprite]
    mov word [xScorePos], 172  ; 34 + 8
    call scoringDraw
    ret
resetMapPellet:
    mov byte [pelletsNumbers], 10
    mov word [actualKeystroke], 0
    mov word [waitingKeystroke], 0
    call clearScreen
    call displayEndScore
    call drawNumbersGG
    ret