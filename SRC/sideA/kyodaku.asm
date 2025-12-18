; side A file $00 - kyodaku- (  vram $2800-$28DF)
; Copyright screen necessary for any FDS game to boot properly

.include "hardware.asm"
.include "constants.asm"
.include "macros.asm"

FDSFileMacroPart1 $00
    .ascstr "KYODAKU-"
FDSFileMacroPart2 $2800, $02

.stringmap charmap_kyodaku, "           NINTENDO r           "
.stringmap charmap_kyodaku, "       FAMILY COMPUTER TM       "
.stringmap charmap_kyodaku, "                                "
.stringmap charmap_kyodaku, "  THIS PRODUCT IS MANUFACTURED  "
.stringmap charmap_kyodaku, "  AND SOLD BY NINTENDO CO;LTD.  "
.stringmap charmap_kyodaku, "  OR BY OTHER COMPANY UNDER     "
.stringmap charmap_kyodaku, "  LICENSE OF NINTENDO CO;LTD..  "

FDSFileMacroPart3

