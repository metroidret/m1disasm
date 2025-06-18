.MEMORYMAP
    DEFAULTSLOT 0
    SLOT 0 $0000 $0010 "HeaderSlot"
    SLOT 1 $0000 $0800 "RAMConsoleSlot"
    SLOT 2 $6000 $2000 "RAMCartSlot"
    SLOT 3 $8000 $4000 "ROMSwitchSlot"
    SLOT 4 $C000 $4000 "ROMFixedSlot"
.ENDME

.ROMBANKMAP
    BANKSTOTAL $8
    BANKSIZE $4000
    BANKS $8
.ENDRO


.include "hardware.asm"

.include "constants.asm"
.include "macros.asm"

.include "header.asm"
.include "prg0_title.asm"
.include "prg1_brinstar.asm"
.include "prg2_norfair.asm"
.include "prg3_tourian.asm"
.include "prg4_kraid.asm"
.include "prg5_ridley.asm"
.include "prg6_graphics.asm"
.include "prg7_engine.asm"
