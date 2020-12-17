PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

E  = $80    ; 1000 0000
RW = $40    ; 0100 0000
RS = $20    ; 0010 0000

    .org $8000
start:
setio:
    lda #$FF    ; Set all pins on port B to output
    sta DDRB
    lda #$E0    ; Set top 3 pins on port A to output
    sta DDRA

setdisplay:
    lda #$38    ; Set 8-bit mode, 2-line display, 5x8 font
    sta PORTB
    lda #0
    sta PORTA
    lda #E      ; Send instruction
    sta PORTA
    lda #0
    sta PORTA

    lda #$0F    ; Display on, cursor on, blink on
    sta PORTB
    lda #0
    sta PORTA
    lda #E      ; Send instruction
    sta PORTA
    lda #0
    sta PORTA

    lda #$06    ; Increment cursor, don't shift display
    sta PORTB
    lda #0
    sta PORTA
    lda #E      ; Send instruction
    sta PORTA
    lda #0
    sta PORTA

main:
    lda #'H'        ; Write an H
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'e'        ; Write an E
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'l'        ; Write an l
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'l'        ; Write an l
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'o'        ; Write an o
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #','        ; Write a \,
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #' '        ; Write a SPC
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'W'        ; Write a W
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'o'        ; Write an o
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'r'        ; Write an r
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'l'        ; Write an l
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'d'        ; Write an d
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    lda #'!'        ; Write an !
    sta PORTB
    lda #RS
    sta PORTA
    lda #(RS | E)   ; Send character
    sta PORTA
    lda #RS
    sta PORTA

    jmp main

    .org $FFFC
    .word start     ; Set the reset vector
    .word $0000
