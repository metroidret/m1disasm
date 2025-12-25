; disk info block

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

.section "Side{FDSFile_Side}-DiskInfo" bank FDSFile_Bank slot "DummySlot"
    .byte $01
    .ascstr "*NINTENDO-HVC*"
    .byte $01
    .ascstr "MET"
    .ascstr " "
    .byte $02
    .byte FDSFile_Side
    .byte $00
    .byte $00
    .byte $00
    .byte FDSFileID_Side00_Boot
    .byte $FF, $FF, $FF, $FF, $FF
    .byte $61, $09, $09
    .byte $49
    .byte $61
    .byte $00
    .byte $00, $02
    .byte $00, $1A, $00, $10, $00
    .byte $61, $09, $09
    .byte $FF
    .byte $FF
    .byte $FF, $FF
    .byte $FF
    .byte $00
    .byte FDSFile_Side
    .byte $00
    .byte $00
    
    .byte $02
    .byte FDSFile_SideFileQty
.ends

