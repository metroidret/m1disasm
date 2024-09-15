; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
;
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER by YOSHi
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Hosted on wiki.metroidconstruction.com, with possible additions by wiki contributors.

;Kraid Structure Pointers

StrctPtrTbl:
    .word LAA6B, LAA7E, LAA97, LAAB0, LAAB7, LAABE, LAAC2, LAAD2
    .word LAAE2, LAAE7, LAAEC, LAAEF, LAAF2, LAAFD, LAB03, LAB08
    .word LAB11, LAB26, LAB29, LAB3C, LAB51, LAB55, LAB68, LAB75
    .word LAB88, LAB9B, LABB0, LABBA, LABBD, LABC4, LABE0, LABE9
    .word LABFE, LAC01, LAC0A, LAC0F, LAC14, LAC1E, LAC27