    .org $8000
    lda #$FF
    sta $6002

    lda #$E0
    sta $6001

loop:
    lda #$55
    sta $6000

    lda #$AA
    sta $6000

    jmp loop

    .org $FFFC
    .word $8000
    .word $0000
