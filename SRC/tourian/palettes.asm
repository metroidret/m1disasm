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

;Tourian Palette Data

Palette00:
LA718:  .byte $3F                       ;Upper byte of PPU palette adress.
LA719:  .byte $00                       ;Lower byte of PPU palette adress.
LA71A:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA71B:  .byte $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $16, $20, $00, $0F, $20, $10, $00
;The following values are written to the sprite palette:
LA72B:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $16, $30, $0F, $16, $2A, $37

LA73B:  .byte $00                       ;End Palette00 info.

Palette01:
LA73C:  .byte $3F                       ;Upper byte of PPU palette adress.
LA73D:  .byte $12                       ;Lower byte of PPU palette adress.
LA73E:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA73F:  .byte $19, $27

LA741:  .byte $00                       ;End Palette01 info.

Palette03:
LA742:  .byte $3F                       ;Upper byte of PPU palette adress.
LA743:  .byte $12                       ;Lower byte of PPU palette adress.
LA744:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA745:  .byte $2C, $27

LA747:  .byte $00                       ;End Palette03 info.

Palette02:
LA748:  .byte $3F                       ;Upper byte of PPU palette adress.
LA749:  .byte $12                       ;Lower byte of PPU palette adress.
LA74A:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA74B:  .byte $19, $35

LA74D:  .byte $00                       ;End Palette02 info.

Palette04:
LA74E:  .byte $3F                       ;Upper byte of PPU palette adress.
LA74F:  .byte $12                       ;Lower byte of PPU palette adress.
LA750:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA751:  .byte $2C, $24

LA753:  .byte $00                       ;End Palette04 info.

Palette05:
LA754:  .byte $3F                       ;Upper byte of PPU palette adress.
LA755:  .byte $0A                       ;Lower byte of PPU palette adress.
LA756:  .byte $01                       ;Palette data length.
;The following values are written to the background palette:
LA757:  .byte $27

LA758:  .byte $00                       ;End Palette05 info.

Palette06:
LA759:  .byte $3F                       ;Upper byte of PPU palette adress.
LA75A:  .byte $0A                       ;Lower byte of PPU palette adress.
LA75B:  .byte $01                       ;Palette data length.
;The following values are written to the background palette:
LA75C:  .byte $20

LA75D:  .byte $00                       ;End Palette06 info.

Palette07:
LA75E:  .byte $3F                       ;Upper byte of PPU palette adress.
LA75F:  .byte $00                       ;Lower byte of PPU palette adress.
LA760:  .byte $11                       ;Palette data length.
;The following values are written to the background palette:
LA761:  .byte $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $20, $16, $00, $0F, $20, $10, $00
LA771:  .byte $0F

LA772:  .byte $00                       ;End Palette07 info.

Palette08:
LA773:  .byte $3F                       ;Upper byte of PPU palette adress.
LA774:  .byte $00                       ;Lower byte of PPU palette adress.
LA775:  .byte $11                       ;Palette data length.
;The following values are written to the background palette:
LA776:  .byte $20, $02, $16, $00, $20, $02, $11, $00, $20, $02, $16, $00, $20, $02, $10, $00
LA786:  .byte $20

LA787:  .byte $00                       ;End Palette08 info.

Palette09:
LA788:  .byte $3F                       ;Upper byte of PPU palette adress.
LA789:  .byte $00                       ;Lower byte of PPU palette adress.
LA78A:  .byte $60                       ;Lower byte of PPU palette adress.
LA78B:  .byte $20                       ;Repeat bit set. Fill sprite and background palette with #$20.

LA78C:  .byte $00                       ;End Palette09 info.

Palette0A:
LA78D:  .byte $3F                       ;Upper byte of PPU palette adress.
LA78E:  .byte $11                       ;Lower byte of PPU palette adress.
LA78F:  .byte $03
;The following values are written to the sprite palette:
LA790:  .byte $04, $09, $07

LA793:  .byte $00                       ;End Palette0A info.

Palette0B:
LA794:  .byte $3F                       ;Upper byte of PPU palette adress.
LA795:  .byte $11                       ;Lower byte of PPU palette adress.
LA796:  .byte $03                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA797:  .byte $05, $09, $17

LA79A:  .byte $00                       ;End Palette0B info.

Palette0C:
LA79B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA79C:  .byte $11                       ;Lower byte of PPU palette adress.
LA79D:  .byte $03                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA79E:  .byte $06, $0A, $26

LA7A1:  .byte $00                       ;End Palette0C info.

Palette0D:
LA7A2:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7A3:  .byte $11                       ;Lower byte of PPU palette adress.
LA7A4:  .byte $03                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7A5:  .byte $16, $19, $27

LA7A8:  .byte $00                       ;End Palette0D info.

Palette0E:
LA7A9:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7AA:  .byte $00                       ;Lower byte of PPU palette adress.
LA7AB:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the background palette:
LA7AC:  .byte $0F, $30, $30, $21

LA7B0:  .byte $00                       ;End Palette0E info.

Palette0F:
LA7B1:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7B2:  .byte $10                       ;Lower byte of PPU palette adress.
LA7B3:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7B4:  .byte $0F, $15, $34, $17

LA7B8:  .byte $00                       ;End Palette0F info.

Palette10:
LA7B9:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7BA:  .byte $10                       ;Lower byte of PPU palette adress.
LA7BB:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7BC:  .byte $0F, $15, $34, $19

LA7C0:  .byte $00                       ;End Palette10 info.

Palette11:
LA7C1:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7C2:  .byte $10                       ;Lower byte of PPU palette adress.
LA7C3:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7C4:  .byte $0F, $15, $34, $28

LA7C8:  .byte $00                       ;End Palette11 info.

Palette12:
LA7C9:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7CA:  .byte $10                       ;Lower byte of PPU palette adress.
LA7CB:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA7CC:  .byte $0F, $15, $34, $29

LA7D0:  .byte $00                       ;End Palette12 info.