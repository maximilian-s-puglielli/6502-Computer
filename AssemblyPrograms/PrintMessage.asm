;;; AUTHOR:  Maximilian S Puglielli (MSP)
;;; CREATED: 2020.12.23

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CONSTANT DEFINED SYMBOLS

PORTB = $6000   ; Used for setting I/O pins on Port B of the IO board
                ; (65C22 -> Versatile Interface Adapter)
PORTA = $6001   ; Used for setting I/O pins on Port A of the IO board
                ; (65C22 -> Versatile Interface Adapter)
DDRB  = $6002   ; Used for configuring I/O pins on Port B of the IO board
                ; (65C22 -> Versatile Interface Adapter)
DDRA  = $6003   ; Used for configuring I/O pins on Port A of the IO board
                ; (65C22 -> Versatile Interface Adapter)

;;; NOTE: that DDR stands for Data Direction Register.  It's used to configure
;;; whether certain pins are used for INPUT or OUTPUT for either Port A or B.

;;; NOTE: that ALL the pins on Port B and the MOST SIGNIFICANT TOP 3 pins on
;;; Port A will be configured for OUTPUT.  These pins are used to control the
;;; LCD.  In the future, the LEAST SIGNIFICANT BOTTOM 5 pins on Port A - the
;;; leftover pins - may be configured for INPUT and then hooked up to some
;;; buttons for user input.

E  = %10000000  ; ENABLE FLAG
RW = %01000000  ; READ/WRITE FLAG
RS = %00100000  ; REGISTER SELECT FLAG

;;; NOTE: As stated above, the MOST SIGNIFICANT TOP 3 pins on Port A will be
;;; configured for OUTPUT.  Their purpose is to control the ENABLE, READ/WRITE,
;;; and REGISTER SELECT pins on the LCD.

    .org $8000  ; PROGRAM TEXT BEGINNING

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PROGRAM ENTRY POINT

main:
;;; INITIALIZE THE STACK POINTER TO $FF
    ldx #$FF    ; load $FF into the X register
    txs         ; X Register -> Stack Pointer

;;; CONFIGURE I/O PINS ON PORTS A & B
    lda #%11111111
    sta DDRB    ; configure ALL pins on Port B for OUTPUT
    lda #%11111111
    sta DDRA    ; configure ALL pins on Port A for OUTPUT
    ;;; NOTE: We're configuring the MOST SIGNIFICANT BOTTOM 5 pins on Port A for
    ;;; OUTPUT to protect against some unexpected input into the
    ;;; micro-architecture; we're not actually using those bottom 5 pins.

;;; CONFIGURE THE LCD
    lda #%00111000      ; set: 8-bit mode, 2-line display, 5x8 font
    jsr instruct_lcd
    lda #%00001110      ; set: display on, cursor on, blink off
    jsr instruct_lcd
    lda #%00000110      ; set: inc and shift cursor, don't shift display
    jsr instruct_lcd
    jsr clear_display   ; clear the LCD's display

;;; PRINT THE MESSAGE ONCE
    ldx #$00
print_loop:
    lda message,x
    beq exit
    jsr print_char
    inx
    jmp print_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PROGRAM EXIT

exit:
    jmp exit    ; end of program infinite loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GLOBAL SUBROUTINES

instruct_lcd:
;;; PARAM  -> A Register: the instruction to send to the LCD
;;; RETURN -> void
;;; NOTE: The A Register is not maintained through this subroutine.

;;; WAIT FOR THE LCD TO NOT BE BUSY
    pha             ; A Register -> Stack
    jsr await_lcd   ; await the LCD
    pla             ; Stack -> A Register

;;; SEND THE INSTRUCTION
    sta PORTB   ; send instruction to LCD's data bus
    lda #$00    ; deactivate REGISTER SELECT to send an instruction
    sta PORTA
    lda #E      ; activate ENABLE pin to send instruction to LCD
    sta PORTA

;;; CLEAN UP AND RETURN
    lda #$00    ; deactivate ENABLE pin
    sta PORTA
    rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_char:
;;; PARAM  -> A Register: the character to send to the LCD
;;; RETURN -> void
;;; NOTE: The A Register is not maintained through this subroutine.

;;; WAIT FOR THE LCD TO NOT BE BUSY
    pha             ; A Register -> Stack
    jsr await_lcd   ; await the LCD
    pla             ; Stack -> A Register

;;; SEND THE INSTRUCTION
    sta PORTB       ; send character to LCD's data bus
    lda #RS         ; active REGISTER SELECT to send a character
    sta PORTA
    lda #(RS | E)   ; activate ENABLE pin to send character to LCD
    sta PORTA

;;; CLEAN UP AND RETURN
    lda #$00        ; deactivate ENABLE pin
    sta PORTA
    rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

await_lcd:
;;; PARAM  -> void
;;; RETURN -> void
;;; NOTE: This subroutine overwrites the A Register.

;;; CONFIGURE PORT B FOR INPUT
    lda #%00000000  ; configure ALL pins on Port B for INPUT
    sta DDRB

lcd_busy:
;;; READ THE BUSY FLAG AND ADDRESS COUNTER
    lda #RW         ; set the READ/WRITE pin to WRITE
    sta PORTA
    lda #(RW | E)   ; set the READ/WRITE pin to WRITE and activate the ENABLE pin
    sta PORTA
    lda PORTB       ; read the Busy Flag and Address Counter -> BF AC AC AC  AC AC AC AC

;;; CHECK IF BUSY FLAG IS ACTIVATED
    and #%10000000  ; mask off everything except the Busy Flag
    bne lcd_busy    ; branch to lcd_busy if the Zero Flag is not set
                    ; => the Busy Flag is not zero => the LCD is busy

;;; STOP READING AND CLEAN UP
    lda #$00        ; deactivate the ENABLE pin
    sta PORTA

;;; CONFIGURE PORT B FOR OUTPUT
    lda #%11111111  ; configure ALL pins on Port B for OUTPUT
    sta DDRB
    rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

clear_display:
;;; PARAM  -> void
;;; RETURN -> void
;;; NOTE: This subroutine overwrites the A Register.

;;; SEND A CLEAR DISPLAY INSTRUCTION
    lda #%00000001      ; instruction for -> clear display
    jsr instruct_lcd    ; send instruction
    rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; READ-ONLY DATA MEMORY

message: .asciiz "  Commadore 32                          Merry Christmas!"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; HARDWARE VECTORS

    .org $FFFA  ; PROGRAM TEXT ENDING

    .word main  ; NON-MASKABLE INTERRUPT VECTOR     <- Hardware
    .word main  ; CPU RESET VECTOR                  <- Hardware
    .word main  ; BREAK / INTERRUPT REQUEST VECTOR  <- Software / Hardware

    ;;; NOTE: We have both the interrupt vectors set to main because we aren't
    ;;; using interrupts.  If we set them to $0000, the program would crash if
    ;;; either interrupts were activated.  This way, the program restarts if
    ;;; either interrupt is triggered.
