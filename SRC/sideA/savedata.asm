; side A file $0E - savedata (prgram $C5A0-$C614)
; Save data file

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side00_0F
    .ascstr "SAVEDATA"
FDSFileMacroPart2 $C5A0, FDSFileType_PRGRAM



; the game writes to this file to save game data
;@C5A0:
    .byte $80
    .byte $80
    .byte $80
;@C5A3:
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
;@C5D3:
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
;@C5D9:
    .byte $00
    .byte $00
    .byte $00
;@C5DC:
    .byte $00, $00
    .byte $00, $00
    .byte $00, $00
;@C5E2:
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
;@C612:
    .byte $00
    .byte $00
    .byte $00



FDSFileMacroPart3

