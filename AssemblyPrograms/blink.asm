;;; AUTHOR:  Maximilian S Puglielli (MSP)
;;; CREATED: 2020.12.23

;;; DEFINED CONSTANTS
PORTB = $6000
; PORTA = $6001
DDRB  = $6002
; DDRA  = $6003

;;; PROGRAM START
    .org $8000
main:
    lda #%11111111
    sta DDRB

loop:
    lda #$55
    sta PORTB
    lda #$AA
    sta PORTB
    jmp loop

    .org $FFFC
    .word main
    .word $0000
