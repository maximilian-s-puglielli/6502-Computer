PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

    .org $8000
reset:
    lda #$FF
    sta $6002

    lda #$E0
    sta $6003

loop:
    lda #$55
    sta $6000

    lda #$C0
    sta $6001

    lda #$AA
    sta $6000

    lda #$60
    sta $6001

    jmp loop

    .org $FFFC
    .word reset
    .word $0000
