DataD785_SongEnd: ;($CC00)
    .word SongEndFDS ; written to $EE
; written to $0610-$061C
     ; (BUG: pointers misaligned with data)
    .word LDB2C+6.b
    .word FDSWaveform_DC6E+6.b
    .byte $17
    .byte $20
    .byte $80
    .byte $80
    
    .byte $00 ; these four change a lot in $0618-$061B
    .byte $02 ; maybe RNG?
    .byte $00
    .byte $87
    
    .byte $42



.include "songs/end.asm"



    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
    .byte $FF
