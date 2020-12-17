PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

    .org $8000
reset:
    lda #$FF
    sta DDRB

    lda #$E0
    sta DDRA

main:
    lda #$55
    sta PORTB

    lda #$C0
    sta PORTA

    lda #$AA
    sta PORTB

    lda #$60
    sta PORTA

    jmp main

    .org $FFFC
    .word reset
    .word $0000
