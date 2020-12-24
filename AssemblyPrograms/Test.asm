;;; AUTHOR:  Maximilian S Puglielli (MSP)
;;; CREATED: 2020.12.23

;;; DEFINED CONSTANTS
PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

E  = %10000000
RW = %01000000
RS = %00100000

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; PROGRAM START
    .org $8000
main:
    lda #%11111111  ; Set all pins on port B to output
    sta DDRB

    lda #%11100000  ; Set top 3 pins on port A to output
    sta DDRA

    lda #%00111000  ; Set 8-bit mode, 2-line display, 5x8 font
    sta PORTB
    lda #0          ; Clear E/RW/RS bits
    sta PORTA
    lda #E          ; Set E bit => send instruction to LCD
    sta PORTA
    lda #0          ; Clear E/RW/RS bits
    sta PORTA

    lda #%00001110  ; Display on; cursor on; blink off
    sta PORTB
    lda #0          ; Clear E/RW/RS bits
    sta PORTA
    lda #E          ; Set E bit => send instruction to LCD
    sta PORTA
    lda #0          ; Clear E/RW/RS bits
    sta PORTA

    lda #%00000110  ; Increment and shift cursor, don't shift display
    sta PORTB
    lda #0          ; Clear E/RW/RS bits
    sta PORTA
    lda #E          ; Set E bit => send instruction to LCD
    sta PORTA
    lda #0          ; Clear E/RW/RS bits
    sta PORTA

    lda #'H'        ; Write an H to LCD
    sta PORTB
    lda #RS         ; Set RS, Clear RW/E bits
    sta PORTA
    lda #(RS | E)   ; Set E bit => send instruction to LCD
    sta PORTA
    lda #RS         ; Clear E bit
    sta PORTA

    lda #'e'        ; Write an e to LCD
    sta PORTB
    lda #RS         ; Set RS, Clear RW/E bits
    sta PORTA
    lda #(RS | E)   ; Set E bit => send instruction to LCD
    sta PORTA
    lda #RS         ; Clear E bit
    sta PORTA

    lda #'l'        ; Write an l to LCD
    sta PORTB
    lda #RS         ; Set RS, Clear RW/E bits
    sta PORTA
    lda #(RS | E)   ; Set E bit => send instruction to LCD
    sta PORTA
    lda #RS         ; Clear E bit
    sta PORTA

    lda #'l'        ; Write another l to LCD
    sta PORTB
    lda #RS         ; Set RS, Clear RW/E bits
    sta PORTA
    lda #(RS | E)   ; Set E bit => send instruction to LCD
    sta PORTA
    lda #RS         ; Clear E bit
    sta PORTA

    lda #'o'        ; Write an o to LCD
    sta PORTB
    lda #RS         ; Set RS, Clear RW/E bits
    sta PORTA
    lda #(RS | E)   ; Set E bit => send instruction to LCD
    sta PORTA
    lda #RS         ; Clear E bit
    sta PORTA

loop:
    lda #$55
    sta PORTB
    lda #$AA
    sta PORTB
    jmp loop

    .org $FFFA
    .word main  ; INTERRUPT VECTOR #1
    .word main  ; CPU RESET VECTOR
    .word main  ; INTERRUPT VECTOR #2
