PORTB = $6000
PORTA = $6001
DDRB  = $6002
DDRA  = $6003

    .org $8000
reset:
    lda #%11111111
    sta DDRB

    lda #%11100000
    sta DDRA

main:
    lda #'a'
    sta PORTB

    lda #$C0
    sta PORTA

    lda #'z'
    sta PORTB

    lda #$60
    sta PORTA

    jmp main

    .org $FFFC
    .word reset
    .word $0000
