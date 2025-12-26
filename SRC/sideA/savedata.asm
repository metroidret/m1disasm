; side A file $0E - savedata (prgram $C5A0-$C614)
; Save data file

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 FDSFileID_Side00_0F
    .ascstr "SAVEDATA"
FDSFileMacroPart2 $C5A0, FDSFileType_PRGRAM



; the game writes to this file to save game data
SaveData:
@enable: ;($C5A0)
    ; bit 7: slot was once accessed to start a game? %1=no, %0=yes
    ; bit 0: slot is named? %1=yes, %0=no
    @@0:
        .byte $80
    @@1:
        .byte $80
    @@2:
        .byte $80
@name: ;($C5A3)
    ; first 8 bytes is save slot name, last 8 bytes is save slot name's dakuten accents
    @@0:
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    @@1:
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
    @@2:
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
@gameOverCount: ;($C5D3)
    @@0:
        .byte $00, $00
    @@1:
        .byte $00, $00
    @@2:
        .byte $00, $00
@energyTank: ;($C5D9)
    ; only for save menu, real etank count is in samus stat
    @@0:
        .byte $00
    @@1:
        .byte $00
    @@2:
        .byte $00
@day: ;($C5DC)
    ; day count is SamusAge+2
    @@0:
        .byte $00, $00
    @@1:
        .byte $00, $00
    @@2:
        .byte $00, $00
@samusStat: ;($C5E2)
    .dstruct @@0 instanceof SamusStat values
    .endst
    .dstruct @@1 instanceof SamusStat values
    .endst
    .dstruct @@2 instanceof SamusStat values
    .endst
@moneyBags: ;($C612)
    @@0:
        .byte $00
    @@1:
        .byte $00
    @@2:
        .byte $00
@end:



FDSFileMacroPart3

