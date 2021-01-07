;;; AUTHOR:  Maximilian S Puglielli (MSP)
;;; CREATED: 2020.12.23

;;; DEFINED CONSTANTS
PORTB = $6000
DDRB  = $6002

;;; PROGRAM START
    .org $8000
main:
    lda #%11111111
    sta DDRB

blink:
    lda #$55
    sta PORTB
    lda #$AA
    sta PORTB
    jmp blink

    .org $FFFA
    .word $0000
    .word main
    .word $0000
