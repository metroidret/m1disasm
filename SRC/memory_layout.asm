.ifndef BUILDTARGET
    .fail "no build target specified"
.endif


.memorymap
    defaultslot 0
    slot 0 $0000 $0010 "HeaderSlot"
    slot 1 $0000 $0800 "RAMConsoleSlot"
    slot 2 $6000 $2000 "RAMCartSlot"
    slot 3 $8000 $4000 "ROMSwitchSlot"
    slot 4 $C000 $4000 "ROMFixedSlot"
.endme

.rombankmap
    bankstotal $8
    banksize $4000
    banks $8
.endro
