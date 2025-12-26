.memorymap
    defaultslot 0
    slot 0 $0000 $FFDC "DummySlot"
    slot 1 $0000 $0800 "RAMConsoleSlot"
    slot 2 $6000 $8000 "RAMDiskSysSlot"
    slot 3 $E000 $2000 "ROMFDSBIOSSlot"
.endme

.rombankmap
    bankstotal FDSFile_BankQty
    banksize $8000
    banks FDSFile_BankQty
.endro
