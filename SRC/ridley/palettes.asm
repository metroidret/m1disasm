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

;Ridley Palette Data

Palette00:
LA0EB:  .byte $3F                       ;Upper byte of PPU palette adress.
LA0EC:  .byte $00                       ;Lower byte of PPU palette adress.
LA0ED:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA0EE:  .byte $0F, $20, $10, $00, $0F, $21, $14, $13, $0F, $28, $1B, $02, $0F, $15, $16, $04
;The following values are written to the sprite palette:
LA0FE:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $14, $13, $29, $0F, $13, $15, $27

LA10E:  .byte $00                       ;End Palette00 info.

Palette01:
LA10F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA110:  .byte $12                       ;Lower byte of PPU palette adress.
LA111:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA112:  .byte $19, $27

LA114:  .byte $00                       ;End Palette01 info.

Palette03:
LA115:  .byte $3F                       ;Upper byte of PPU palette adress.
LA116:  .byte $12                       ;Lower byte of PPU palette adress.
LA117:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA118:  .byte $2C, $27

LA11A:  .byte $00                       ;End Palette03 info.

Palette02:
LA11B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA11C:  .byte $12                       ;Lower byte of PPU palette adress.
LA11D:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA11E:  .byte $19, $35

LA120:  .byte $00                       ;End Palette02 info.

Palette04:
LA121:  .byte $3F                       ;Upper byte of PPU palette adress.
LA122:  .byte $12                       ;Lower byte of PPU palette adress.
LA123:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA124:  .byte $2C, $24

LA126:  .byte $00                       ;End Palette04 info.

Palette05:
LA127:  .byte $3F                       ;Upper byte of PPU palette adress.
LA128:  .byte $00                       ;Lower byte of PPU palette adress.
LA129:  .byte $10                       ;Palette data length.
;The following values are written to the background palette:
LA12A:  .byte $0F, $20, $16, $04, $0F, $21, $14, $13, $0F, $27, $16, $02, $0F, $15, $16, $04

LA13A:  .byte $00                       ;End Palette05 info.

Palette06:
LA13B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA13C:  .byte $11                       ;Lower byte of PPU palette adress.
LA13D:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA13E:  .byte $04, $09, $07

LA141:  .byte $00                       ;End Palette06 info.

Palette07:
LA142:  .byte $3F                       ;Upper byte of PPU palette adress.
LA143:  .byte $11                       ;Lower byte of PPU palette adress.
LA144:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA145:  .byte $05, $09, $17

LA148:  .byte $00                       ;End Palette07 info.

Palette08:
LA149:  .byte $3F                       ;Upper byte of PPU palette adress.
LA14A:  .byte $11                       ;Lower byte of PPU palette adress.
LA14B:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA14C:  .byte $06, $0A, $26

LA14F:  .byte $00                       ;End Palette08 info.

Palette09:
LA150:  .byte $3F                       ;Upper byte of PPU palette adress.
LA151:  .byte $11                       ;Lower byte of PPU palette adress.
LA152:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA153:  .byte $16, $19, $27

LA156:  .byte $00                       ;End Palette09 info.

Palette0A:
LA157:  .byte $3F                       ;Upper byte of PPU palette adress.
LA158:  .byte $00                       ;Lower byte of PPU palette adress.
LA159:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA15A:  .byte $0F, $30, $30, $21

LA15E:  .byte $00                       ;End Palette0A info.

Palette0B:
LA15F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA160:  .byte $10                       ;Lower byte of PPU palette adress.
LA161:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA162:  .byte $0F, $15, $34, $17

LA166:  .byte $00                       ;End Palette0B info.

Palette0C:
LA167:  .byte $3F                       ;Upper byte of PPU palette adress.
LA168:  .byte $10                       ;Lower byte of PPU palette adress.
LA169:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA16A:  .byte $0F, $15, $34, $19

LA16E:  .byte $00                       ;End Palette0C info.

Palette0D:
LA16F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA170:  .byte $10                       ;Lower byte of PPU palette adress.
LA171:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA172:  .byte $0F, $15, $34, $28

LA176:  .byte $00                       ;End Palette0D info.

Palette0E:
LA177:  .byte $3F                       ;Upper byte of PPU palette adress.
LA178:  .byte $10                       ;Lower byte of PPU palette adress.
LA179:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA17A:  .byte $0F, $15, $34, $29

LA17E:  .byte $00                       ;End Palette0E info.