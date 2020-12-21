PORTB = $6000
DDRB  = $6002

    .org $8000
reset:
    lda #$FF
    sta DDRB

main:
    lda #$55
    sta PORTB

    lda #$AA
    sta PORTB

    jmp main

    .org $FFFC
    .word reset
    .word $0000
