          * = $6800
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BIT $272B
          ORA $15,X
          ASL $14,X
          .BYTE $13    ;%00010011
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          ASL $08
          ASL A
          .BYTE $1A    ;%00011010
          AND #$29
          PLP
          ROL $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $01FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $03    ;%00000011
          .BYTE $1F    ;%00011111
          .BYTE $23    ;%00100011 '#'
          AND $24
          ROL $20
          ASL $211F,X
          AND ($07,X)
          .BYTE $22    ;%00100010 '"'
          ORA $211B,X
          JSR $FF04
          .BYTE $FF    ;%11111111
          BPL L6882
          ASL $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BPL L68A2
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          ASL A
          .BYTE $1A    ;%00011010
          AND #$28
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          ASL A
          .BYTE $1A    ;%00011010
          AND #$29
          PLP
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BPL L68C2
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          BPL L68E2
          .BYTE $0F    ;%00001111
          ORA ($13),Y
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          .BYTE $13    ;%00010011
          .BYTE $12    ;%00010010
          ORA $0003
          ORA $0C
          ASL $0D0E
          BPL L6900
          .BYTE $0F    ;%00001111
          ORA $0C10
          ASL $0F1B
          ASL $0D0F
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
L6900     .BYTE $FF    ;%11111111
          BPL L6902
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          ASL $FF
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA ($FF),Y
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BPL L6922
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          ASL $FF
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA ($0A),Y
          .BYTE $1A    ;%00011010
          PLP
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          BPL L6942
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          ASL $FF
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $1B    ;%00011011
          ASL $19
          ORA $0B2A,Y
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          .BYTE $03    ;%00000011
          .BYTE $02    ;%00000010
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          ORA #$0A
          ASL $FF
          .BYTE $03    ;%00000011
          .BYTE $12    ;%00010010
          .BYTE $14    ;%00010100
          ORA $14,X
          .BYTE $07    ;%00000111
          ASL $15,X
          .BYTE $13    ;%00010011
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          .BYTE $07    ;%00000111
          ORA $1919,Y
          ROL A
          ASL $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA ($FF,X)
          ASL A
          .BYTE $1B    ;%00011011
          .BYTE $04    ;%00000100
          .BYTE $0F    ;%00001111
          ASL $2A
          ASL $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA #$FF
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $17    ;%00010111
          ORA #$14
          .BYTE $13    ;%00010011
          CLC
          .BYTE $12    ;%00010010
          .BYTE $14    ;%00010100
          ORA $0413,Y
          .BYTE $FF    ;%11111111
          PHP
          ORA $061F,X
          .BYTE $1F    ;%00011111
          ORA $1E1E,Y
          .BYTE $1C    ;%00011100
          .BYTE $03    ;%00000011
          PLP
          AND #$29
          AND #$2B
          AND #$2A
          ASL $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          PHP
          ORA $1E1F,X
          ORA $1907,Y
          ORA $062C,Y
          ASL $2B
          .BYTE $2B    ;%00101011 '+'
          .BYTE $1A    ;%00011010
          .BYTE $1A    ;%00011010
          .BYTE $1A    ;%00011010
          ROL A
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          ASL $07
          .BYTE $04    ;%00000100
          .BYTE $0F    ;%00001111
          BPL L6A1E
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
L6A1E     ORA #$FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $07    ;%00000111
          .BYTE $17    ;%00010111
          CLC
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          PHP
          AND ($25,X)
          AND $22
          .BYTE $03    ;%00000011
          AND ($25,X)
          JSR $2700
          BIT $062C
          .BYTE $04    ;%00000100
          .BYTE $0F    ;%00001111
          BPL L6A4D
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          .BYTE $1C    ;%00011100
          .BYTE $07    ;%00000111
          .BYTE $17    ;%00010111
          CLC
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
L6A4D     ASL A
          AND ($23,X)
          AND $22
          .BYTE $03    ;%00000011
          AND ($24,X)
          BIT $24
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          ASL $24
          AND $22
          ORA ($2D),Y
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          ORA ($07,X)
          .BYTE $17    ;%00010111
          CLC
L6A6B     .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          ORA #$FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $06
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $07    ;%00000111
          ROL $25
          .BYTE $22    ;%00100010 '"'
          .BYTE $0B    ;%00001011
          AND $FFFF
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          ASL A
          .BYTE $12    ;%00010010
          .BYTE $14    ;%00010100
          .BYTE $13    ;%00010011
          .BYTE $03    ;%00000011
          .BYTE $12    ;%00010010
          ORA $13,X
          ORA $1412
          ASL $14
          CLC
          ORA $19,X
          .BYTE $07    ;%00000111
          ORA #$FF
          .BYTE $FF    ;%11111111
          ORA #$17
          .BYTE $1C    ;%00011100
          BPL L6ABF
          CLC
          .BYTE $03    ;%00000011
          .BYTE $13    ;%00010011
          BPL L6AC3
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA #$04
          .BYTE $0F    ;%00001111
          BPL L6AC1
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $12    ;%00010010
          ASL $16,X
          ASL $13,X
          ASL $FFFF
L6AC1     ASL A
          .BYTE $17    ;%00010111
L6AC3     .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          CLC
          .BYTE $03    ;%00000011
          .BYTE $13    ;%00010011
          ORA $0B12,Y
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          PHP
          .BYTE $12    ;%00010010
          ORA $0719,Y
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          ORA $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $06
          ORA ($FF,X)
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
          .BYTE $07    ;%00000111
          .BYTE $17    ;%00010111
          CLC
          .BYTE $04    ;%00000100
          .BYTE $13    ;%00010011
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          ASL $0C,X
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
          ORA $0F
          CLC
          .BYTE $17    ;%00010111
          CLC
          ORA $0529,Y
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $0B    ;%00001011
          BPL L6B44
          ORA $0AFF
          JSR $0D22
          AND $26
          ROL $26
          ORA $0E0E,X
          .BYTE $03    ;%00000011
          .BYTE $23    ;%00100011 '#'
          BIT $24
          ORA $07,X
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
L6B44     .BYTE $23    ;%00100011 '#'
          .BYTE $17    ;%00010111
          CLC
          ASL $22
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          ASL $0BFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          .BYTE $1A    ;%00011010
          .BYTE $13    ;%00010011
          BPL L6B7B
          .BYTE $1C    ;%00011100
          ASL $06,X
          AND ($0C,X)
          ASL $0AFF
          .BYTE $1C    ;%00011100
          ORA $2003,X
          AND ($21,X)
          .BYTE $22    ;%00100010 '"'
          ASL $23
          .BYTE $0F    ;%00001111
          PLP
          .BYTE $27    ;%00100111 '''
L6B7B     .BYTE $27    ;%00100111 '''
          .BYTE $27    ;%00100111 '''
          ORA $FF07,Y
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          ASL $201F,X
          JSR $0F20
          ORA $21,X
          BIT $0E
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $171B,X
          CLC
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          ORA ($10),Y
          .BYTE $12    ;%00010010
          .BYTE $13    ;%00010011
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          ORA $03,X
          .BYTE $1C    ;%00011100
          ASL $1F1E,X
          .BYTE $1F    ;%00011111
          .BYTE $1F    ;%00011111
          ORA $FF07,X
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          ASL $18,X
          .BYTE $17    ;%00010111
          CLC
          .BYTE $17    ;%00010111
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          .BYTE $17    ;%00010111
          .BYTE $1A    ;%00011010
          .BYTE $1A    ;%00011010
          .BYTE $17    ;%00010111
          .BYTE $1B    ;%00011011
          .BYTE $1B    ;%00011011
          .BYTE $17    ;%00010111
          ORA $FF09,Y
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
L6BF9     .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
L6BFB     .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          JMP LA2FD
          JMP LA325
          JMP LA303
          JMP LA73F
          JMP L840B
          JMP LA57A
          JMP LA72B
          JMP LA747
          JMP LAAA6
          JMP LAA75
          JMP LAAB7
          JMP LA75D
          JMP L9449
          JMP LAC7C
          JMP L8EC4
          JMP LAEF4
          JMP LAFC8
          JMP LA90B
          JMP LAFEF
          JMP LB045
          JMP L8107
          JMP L9E4F
          JMP L7246
          JMP L9568
          LDA $56B1
          LDA ($FA),Y
          BCS L6C49
          BCS L6CA7
          LDA ($AD),Y
          LDA ($A4),Y
          BCS L6BFB
          BCS L6BF9
          ORA ($84,X)
          .BYTE $1C    ;%00011100
          LDX #$FF
          STX $6F
          INX
          STX $B41C
          STX $50
          STX $52
          TXA
L6C69     CPX #$6A
          BCS L6C6F
          STA $75,X
L6C6F     CPX #$FF
          BCS L6C76
          STA $0300,X
L6C76     INX
          BNE L6C69
          JSR $D052
          JSR L941D
          JSR L6F3B
          JSR L6CF4
          STX $66
          STX $67
          INX
          STX $2A
          INX
          STX $43
          LDA $B5CF
          STA $4A
          LDA $B5D0
          STA $49
          LDA $B5D2
          STA $70
          LDA #$FF
          STA $54
          JSR L6CE9
          JSR L8A8B
L6CA8     JSR L8D80
          LDY $54
          INY
          BNE L6CA8
          LDY $34
          STY $01
          LDY $33
          STY $00
          LDA $FF
          AND #$FB
          STA $FF
          STA $2000
          LDY $2002
          LDY #$20
          STY $2006
          LDY #$00
          STY $2006
          LDX #$04
L6CD0     LDA ($00),Y
          STA $2007
          INY
          BNE L6CD0
          INC $01
          DEX
          BNE L6CD0
          STX $8C
          INX
          STX $1C
          STX $2A
          INC $1E
          JMP $D060
L6CE9     LDX #$0D
L6CEB     LDA $B592,X
          STA $35,X
          DEX
          BPL L6CEB
          RTS
L6CF4     LDA #$00
          TAX
L6CF7     CPX #$4D
          BCS L6CFD
          STA $92,X
L6CFD     STA $B460,X
          PHA
          PLA
          INX
          BNE L6CF7
          STX $8D
          JMP $B5A3
L6D0A     LDA #$08
          STA $1E
          LDA #$2C
          STA $26
          JSR L6FB1
          LDY #$14
          STY $0300
          LDX #$00
          STX $6A
          DEX
          STX $0728
          STX $0730
          STX $0732
          STX $0738
          STX $010A
          STX $010B
          STX $86
          STX $89
          LDY #$27
          LDA $6E
          AND #$0F
          BEQ L6D41
          LSR $43
          LDY #$2F
L6D41     STY $73
          STY $8E
          STY $8F
          LDA $B5D1
          STA $030D
          LDA #$80
          STA $030E
          LDA $FF
          AND #$01
          STA $030C
          LDA #$00
          STA $0106
          LDA #$03
          STA $0107
L6D63     RTS
          LDX $27
          BNE L6D84
          JSR L6DBE
          LDA $B416
          CMP #$C2
          BNE L6D84
          LDA $B417
          SBC #$01
          BNE L6D84
          STA $B416
          STA $B417
          LDX #$02
          JSR L6DBE
L6D84     JSR L855C
          JSR L855C
          JSR L6EF1
          LDA $0108
          ORA $0109
          BEQ L6DA4
          LDA #$00
          STA $0108
          STA $0109
          LDA #$18
          LDX #$03
          JSR L95BC
L6DA4     LDA $0300
          CMP #$08
          BNE L6D63
          JSR L6F4E
          LDA $98
          CMP #$0A
          BEQ L6DBB
          LDA #$0C
          LDX #$04
          JMP L95BC
L6DBB     INC $1E
          RTS
L6DBE     INC $B416,X
          BNE L6DC6
          INC $B417,X
L6DC6     RTS
          JSR L6E00
          LDY #$0F
L6DCC     LDA $6DF0,Y
          STA $0201,X
          DEY
          LDA $6DF0,Y
          STA $0203,X
          LDA #$01
          STA $0202,X
          LDA #$73
          STA $0200,X
          JSR L84FE
          DEY
          BPL L6DCC
          LDA #$0C
          LDX #$06
          JMP L95BC
          CLI
          .BYTE $BB    ;%10111011
          RTS
          LDA ($68),Y
          LDY $B370,X
          DEY
          LDA $90,X
          .BYTE $B2    ;%10110010
          TYA
          .BYTE $B3    ;%10110011
          LDY #$BA
L6E00     JSR L6EE4
          LDA $FF
          AND #$FC
          STA $FF
          LDX #$01
          STX $1C
          DEX
          STX $FD
          STX $FC
          JMP $D060
          LDA $15
          AND #$88
          EOR #$88
          BNE L6E2D
          LDA $98
          CMP #$03
          BCS L6E2D
          LDY $010B
          INY
          BNE L6E2D
          STA $2B
          INC $1E
L6E2D     RTS
          LDY $6F
          BPL L6E64
          INC $6F
          INY
          STY $55
          STY $45
          STY $65
          STY $030C
          JSR L6E00
          JSR L6F4E
          LDA #$5A
          STA $0303
          LDX #$02
L6E4B     LDA $6E93,X
          STA $030D
          LDA $6E96,X
          STA $030E
          INC $0303
          TXA
          PHA
          JSR L81C6
          PLA
          TAX
          DEX
          BPL L6E4B
L6E64     LDA $12
          ORA $16
          ASL A
          ASL A
          ASL A
          TAY
          BCC L6E7C
          LDA $6F
          EOR #$01
          STA $6F
          LDA $0200
          EOR #$28
          STA $0200
L6E7C     TYA
          BPL L6E92
          INC $B41A
          BNE L6E87
          INC $B41B
L6E87     LSR $6F
          BCS L6E90
          LDA #$01
          STA $1E
          RTS
L6E90     INC $1E
L6E92     RTS
          .BYTE $64    ;%01100100 'd'
          STY $785C
          SEI
          .BYTE $5C    ;%01011100 '\'
L6E99     LDA #$18
          STA $1C
          JSR LB261
          JMP $C3F4
          JSR L6F3B
          LDY $0300
          LDA $26
          BNE L6EBE
          STA $74
          LDA #$FF
          STA $0300
          JSR L7CAA
          JSR L6F3F
          LDA #$03
          STA $1E
L6EBE     CMP #$1F
          BCS L6E92
          CMP $6ECB,Y
          BNE L6ECC
          INC $0300
          STY $1C
L6ECC     LDA $27
          LSR A
          BCC L6E92
          LDA #$04
          JSR L731F
          LDA #$00
          STA $55
          STA $45
          JMP L81C3
          ASL $0B14,X
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
L6EE4     JSR $D052
          LDA #$FF
          STA $00
          JSR L942A
          JMP L6F3B
L6EF1     LDX #$00
          STX $55
          JSR LA232
          JSR L7840
          JSR L6FC1
          JSR $B5BB
          JSR L7B30
          JSR L7D52
          JSR LA98A
          JSR LAB52
          JSR LA828
          JSR LAACA
          JSR L9B65
          JSR L9BCB
          JSR L9D8E
          JSR L9F21
          JSR L8438
          JSR LA9DF
          JSR L7E8D
          JSR L7EAD
          JSR LACD0
          LDX $55
L6F30     LDA #$F4
L6F32     STA $0200,X
          JSR L84FE
          BNE L6F32
          RTS
L6F3B     LDX #$00
          BEQ L6F30
L6F3F     LDA $B411
          ASL A
          ASL A
          ASL A
          LDA $010E
          ROL A
          ADC #$02
          STA $1C
          RTS
L6F4E     LDA #$01
          BNE L6F60
L6F52     LDA #$02
          BNE L6F60
L6F56     LDA #$08
          BNE L6F60
L6F5A     LDA #$10
          BNE L6F60
L6F5E     LDA #$20
L6F60     LDX #$00
          BEQ L6FA6
L6F64     LDA #$08
          BNE L6F82
L6F68     LDA #$01
          BNE L6F82
L6F6C     LDA #$02
          BNE L6F82
L6F70     LDA #$04
          BNE L6F82
L6F74     LDA #$10
          BNE L6F82
L6F78     LDA #$20
          BNE L6F82
L6F7C     LDA #$40
          BNE L6F82
L6F80     LDA #$80
L6F82     LDX #$01
          BNE L6FA6
L6F86     LDA #$01
          BNE L6FA4
L6F8A     LDA #$02
          BNE L6FA4
L6F8E     LDA #$04
          BNE L6FA4
L6F92     LDA #$08
          BNE L6FA4
L6F96     LDA #$10
          BNE L6FA4
L6F9A     LDA #$20
          BNE L6FA4
L6F9E     LDA #$40
          BNE L6FA4
L6FA2     LDA #$80
L6FA4     LDX #$02
L6FA6     ORA $0680,X
          STA $0680,X
          RTS
L6FAD     LDA #$40
          BNE L6FB3
L6FB1     LDA #$80
L6FB3     LDX #$04
          BNE L6FA6
L6FB7     LDA #$02
          BNE L6FBD
L6FBB     LDA #$40
L6FBD     LDX #$05
          BNE L6FA6
L6FC1     LDX #$00
          STX $45
          INX
          STX $4F
          JSR L6FCE
          DEC $4F
          RTS
L6FCE     LDA $0300
          BMI L6FEA
          JSR L9449
          NOP
          .BYTE $6F    ;%01101111 'o'
          ROR $70,X
          CLV
          .BYTE $73    ;%01110011 's'
          .BYTE $97    ;%10010111
          .BYTE $74    ;%01110100 't'
          LSR $2D75
          .BYTE $77    ;%01110111 'w'
          CLV
          .BYTE $73    ;%01110011 's'
          .BYTE $9F    ;%10011111
          .BYTE $77    ;%01110111 'w'
          .BYTE $7F    ;%01111111
          BNE L6F8D
          .BYTE $77    ;%01110111 'w'
L6FEA     LDA $15
          AND #$CF
          BEQ L6FF5
          JSR L7311
          LDA $15
L6FF5     AND #$07
          BNE L6FFF
          LDA $13
          AND #$08
          BEQ L700F
L6FFF     JSR L854C
          CMP #$02
          BCS L7008
          STA $47
L7008     TAX
          LDA $703B,X
          STA $0300
L700F     LDA $13
          ORA $17
          ASL A
          BPL L7019
          JSR L75A4
L7019     BIT $13
          BPL L7022
          LDA #$02
          STA $0300
L7022     LDA #$04
          JSR L7121
          LDA $0300
          CMP #$05
          BCS L704B
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L7080
          BVS L70AD
          .BYTE $73    ;%01110011 's'
          .BYTE $6B    ;%01101011 'k'
          .BYTE $74    ;%01110100 't'
          .BYTE $2B    ;%00101011 '+'
          .BYTE $73    ;%01110011 's'
          ORA ($01,X)
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
L703F     LDA #$50
          STA $030F
          LDA #$32
L7046     JSR L731F
          STA $5F
L704B     RTS
L704C     LDA #$09
          STA $4D
          LDX #$00
          LDA $0305
          CMP #$07
          BEQ L7063
          INX
          CMP #$27
          BEQ L7063
          LDA #$04
          JSR L7322
L7063     LDA $7072,X
          STA $0305
          LDX $47
L706B     LDA $7074,X
          STA $0315
          RTS
          BRK
          .BYTE $37    ;%00110111 '7'
          BMI L7046
          LDX $47
          LDA $0314
          BEQ L70D7
          LDY $030F
L7080     BIT $0308
          BMI L7090
          CPY #$18
          BCS L70B6
          LDA #$0C
          STA $0305
          BCC L70B6
L7090     CPY #$18
          BCC L70B6
          LDA $0305
          CMP #$20
          BEQ L70A0
          LDA #$0E
          STA $0305
L70A0     CPY #$20
          BCC L70B6
          LDA $15
          AND #$08
          BEQ L70AF
          LDA #$35
          STA $0305
L70AF     BIT $15
          BMI L70B6
          JSR L74FD
L70B6     LDA #$00
          CMP $0305
          BNE L70C2
          LDA #$0C
          STA $0305
L70C2     LDA $5E
          BEQ L70CA
          LDA $13
          BMI L70F4
L70CA     JSR L733C
          JSR L7452
          JSR L72E2
          LDA #$02
          BNE L7121
L70D7     LDA $0307
          BNE L70DF
          JSR L706B
L70DF     JSR L7173
          DEC $4D
          BNE L70ED
          LDA #$09
          STA $4D
          JSR L6F56
L70ED     JSR L72E2
          LDA $13
          BPL L70FF
L70F4     JSR L7377
          LDA #$12
          STA $0316
          JMP L711F
L70FF     ORA $17
          ASL A
          BPL L7107
          JSR L718B
L7107     LDA $15
          AND #$03
          BNE L7113
          JSR L7309
          JMP L711F
L7113     JSR L854C
          CMP $47
          BEQ L711F
          STA $47
          JSR L704C
L711F     LDA #$03
L7121     JSR L800B
          JSR L7150
          BCS L7132
          LDA $27
          LSR A
          AND #$03
          ORA #$A0
          STA $65
L7132     JSR L71AE
          JSR L85D4
          LDA $8D
          BEQ L7140
          LDA #$A1
          STA $65
L7140     JSR L7146
          JMP L81C6
L7146     LDA $47
          JSR L9479
          ORA $65
          STA $65
          RTS
L7150     SEC
          LDY $0300
          DEY
          BNE L7172
          LDA $B411
          AND #$08
          BEQ L7172
          LDA $0305
          CMP #$0E
          BEQ L716F
          CMP #$0C
          SEC
          BNE L7172
          BIT $0308
          BPL L7172
L716F     CMP $0306
L7172     RTS
L7173     LDA $15
          AND #$08
          LSR A
          LSR A
          LSR A
          TAX
          LDA $7072,X
          CMP $0305
          BEQ L7172
          JSR L731F
          PLA
          PLA
          JMP L711F
L718B     JSR L75A4
          LDA $15
          AND #$08
          BNE L719A
          LDA #$22
          STA $0306
          RTS
L719A     LDA $0306
          SEC
          SBC $0305
          AND #$03
          TAX
          LDA $71AA,X
          JMP L7322
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3B    ;%00111011 ';'
          AND $AD3F,X
          ASL A
          .BYTE $03    ;%00000011
          AND #$20
          BEQ L71E4
          LDA #$32
          STA $6A
          LDA #$FF
          STA $6C
          LDA $6D
          STA $71
          BEQ L71D2
          BPL L71C8
          JSR L6F9E
L71C8     LDA $030A
          AND #$08
          LSR A
          LSR A
          LSR A
          STA $6C
L71D2     LDA #$FD
          STA $0308
          LDA #$38
          STA $0314
          JSR L7238
          BNE L71E4
          JMP L721A
L71E4     LDA $6A
          BEQ L721A
          DEC $6A
          LDX $6C
          INX
          BEQ L7207
          JSR L9473
          CMP #$03
          BCS L71FE
          LDY $0315
          BNE L7207
          JSR L7302
L71FE     DEX
          BNE L7204
          JSR L8001
L7204     STA $0309
L7207     LDA $71
          BPL L721A
          LDA $27
          AND #$01
          BNE L721A
          TAY
          STY $0304
          LDY #$F7
          STY $0303
L721A     LDY $0107
          DEY
          BMI L7229
          BNE L7232
          LDA $0106
          CMP #$70
          BCS L7232
L7229     LDA $27
          AND #$0F
          BNE L7232
          JSR L6F6C
L7232     LDA #$00
          STA $030A
          RTS
L7238     LDA $0300
          CMP #$07
          BEQ L7245
          CMP #$08
          BEQ L7245
          CMP #$FF
L7245     RTS
L7246     LDA $68
          ORA $69
          BEQ L7245
          JSR L7238
          BEQ L7257
          LDY $010B
          INY
          BEQ L725A
L7257     JMP LA210
L725A     LDA $98
          CMP #$03
          BCS L7257
          LDA $B411
          AND #$20
          BEQ L7273
          LSR $68
          LSR $69
          BCC L7273
          LDA #$4F
          ADC $68
          STA $68
L7273     LDA $0106
          STA $03
          LDA $68
          SEC
          JSR L9568
          STA $0106
          LDA $0107
          STA $03
          LDA $69
          JSR L9568
          STA $0107
          LDA $0106
          AND #$F0
          ORA $0107
          BEQ L729A
          BCS L72DF
L729A     LDA #$00
          STA $0106
          STA $0107
          LDA #$07
          STA $0300
          JSR L6FA2
          JMP L703F
L72AD     LDA $0106
          STA $03
          LDA $68
          CLC
          JSR L9547
          STA $0106
          LDA $0107
          STA $03
          LDA $69
          JSR L9547
          STA $0107
          LDA $B410
          JSR L9479
          ORA #$0F
          CMP $0107
          BCS L72DF
          AND #$F9
          STA $0107
          LDA #$99
          STA $0106
L72DF     JMP LA210
L72E2     LDA $030A
          LSR A
          AND #$02
          BEQ L7308
          BCS L72F3
          LDA $0315
          BMI L7308
          BPL L72FA
L72F3     LDA $0315
          BMI L72FA
          BNE L7308
L72FA     JSR L8001
          STA $0315
L7300     LDY #$00
L7302     STY $0309
          STY $0313
L7308     RTS
L7309     LDA $0315
          BNE L7311
          JSR L6F56
L7311     JSR L7335
          STY $0300
          LDA $15
          AND #$08
          BNE L732B
          LDA #$07
L731F     STA $0305
L7322     STA $0306
          LDA #$00
          STA $0304
          RTS
L732B     LDA #$04
          STA $0300
          LDA #$27
          JSR L731F
L7335     JSR L736B
          STY $0304
          RTS
L733C     LDA $15
          AND #$03
          BEQ L735D
          JSR L854C
          TAX
          JSR L706B
          LDA $0314
          BMI L7371
          LDA $0305
          CMP #$0E
          BEQ L7371
          STX $47
          LDA $744D,X
          JMP L731F
L735D     LDA $0314
          BMI L7371
          BEQ L7371
          LDA $0305
          CMP #$0C
          BNE L7371
L736B     JSR L7300
          STY $0315
L7371     RTS
          LDY #$35
          JMP L7379
L7377     LDY #$0C
L7379     STY $0305
          DEY
          STY $0306
          LDA #$04
          STA $0304
          LDA #$00
          STA $030F
          LDA #$FC
          STA $0308
          LDX $0300
          DEX
          BNE L73A6
          LDA $B411
          AND #$08
          BEQ L73A6
          LDA #$00
          STA $0686
          JSR L6F8A
          BNE L73A9
L73A6     JSR L6F6C
L73A9     LDY #$18
          LDA $B411
          AND #$02
          BEQ L73B4
          LDY #$12
L73B4     STY $0314
          RTS
          LDA $030F
          BIT $0308
          BPL L73CB
          CMP #$20
          BCC L73CB
          BIT $15
          BMI L73CB
          JSR L74FD
L73CB     JSR L740B
          JSR L72E2
          LDA $15
          AND #$08
          BEQ L73E1
          LDA #$35
          STA $0305
          LDA #$06
          STA $0300
L73E1     JSR L7452
          LDA $5E
          BEQ L73F2
          LDA $13
          BPL L73F2
          JSR L7377
          JMP L711F
L73F2     LDA $0314
          BNE L7406
          LDA $0300
          CMP #$06
          BNE L7403
          JSR L732B
          BNE L7406
L7403     JSR L7309
L7406     LDA #$03
          JMP L7121
L740B     LDX #$01
          LDY #$00
          LDA $15
          LSR A
          BCS L741A
          DEX
          LSR A
          BCC L7448
          DEX
          INY
L741A     CPY $47
          BEQ L7448
          LDA $0300
          CMP #$06
          BNE L7433
          LDA $0305
          CMP $744F,Y
          BNE L743E
          LDA $7450,Y
          JMP L743E
L7433     LDA $0305
          CMP $744C,Y
          BNE L743E
          LDA $744D,Y
L743E     JSR L731F
          LDA #$08
          STA $0304
          STY $47
L7448     STX $0309
L744B     RTS
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          AND $35,X
          AND $A5,X
          .BYTE $13    ;%00010011
          ORA $17
          ASL A
          BPL L744B
          LDA $0305
          CMP #$35
          BNE L7463
          JMP L761C
L7463     JSR L75C6
          LDA #$20
          JMP L731F
          LDA $B411
          AND #$10
          BEQ L7491
          LDA $0314
          BNE L7491
          LDX $47
          LDA #$16
          STA $0305
          LDA #$13
          STA $0306
          LDA $7074,X
          STA $0315
          LDA #$01
          STA $0686
          JMP L6F8A
L7491     LDA #$00
          STA $0300
          RTS
          LDA $13
          AND #$08
          BNE L74A1
          BIT $13
          BPL L74D4
L74A1     LDA $15
          AND #$04
          BNE L74D4
          LDA $0301
          CLC
          ADC #$08
          STA $0301
          JSR L8B0D
          BCC L74D4
          LDX #$00
          JSR L8C13
          STX $05
          LDA #$F5
          STA $04
          JSR LAC7C
          JSR L79B5
          JSR L7309
          DEC $0306
          JSR L74FD
          LDA #$04
          JMP L74FA
L74D4     LDA $13
          JSR L854C
          CMP #$02
          BCS L74E4
          STA $47
          LDA #$16
          JSR L731F
L74E4     LDX $47
          JSR L706B
          JSR L72E2
          JSR L7506
          LDA $15
          AND #$03
          BNE L74F8
          JSR L736B
L74F8     LDA #$02
L74FA     JMP L7121
L74FD     LDY #$00
          STY $0308
          STY $0312
          RTS
L7506     LDA $B411
          LSR A
          BCC L754D
          LDA $13
          ORA $17
          ASL A
          BPL L754D
          LDA $0308
          ORA $0307
          BNE L754D
          LDX #$D0
          LDA $0300,X
          BEQ L7530
          LDX #$E0
          LDA $0300,X
          BEQ L7530
          LDX #$F0
          LDA $0300,X
          BNE L754D
L7530     LDA $030C
          STA $030C,X
          LDA $030E
          STA $030E,X
          LDA $030D
          CLC
          ADC #$04
          STA $030D,X
          LDA #$08
          STA $0300,X
          JSR L6F68
L754D     RTS
          LDA $15
          AND #$08
          BNE L7559
          LDA #$00
          STA $0300
L7559     LDA $15
          AND #$07
          BEQ L756F
          JSR L854C
          CMP #$02
          BCS L7568
          STA $47
L7568     TAX
          LDA $75A1,X
          STA $0300
L756F     LDA $13
          ORA $17
          ASL A
          BPL L7579
          JSR L75A4
L7579     BIT $13
          BPL L7582
          LDA #$06
          STA $0300
L7582     LDA #$04
          JSR L7121
          LDA $0300
          JSR L9449
          ORA #$73
          JMP L7F70
          BNE L75FF
          .BYTE $74    ;%01110100 't'
          .BYTE $7F    ;%01111111
          BNE L7617
          BNE L760C
          .BYTE $73    ;%01110011 's'
          .BYTE $7F    ;%01111111
          BNE L761D
          BNE L761F
          BNE L75A3
          ORA ($03,X)
L75A4     LDA $15
          AND #$08
          BEQ L75C6
          JMP L761C
L75AD     LDY #$D0
L75AF     LDA $0300,Y
          BEQ L75BB
          JSR LA0DB
          BNE L75AF
          INY
          RTS
L75BB     STA $030A,Y
          LDA $010E
          BEQ L75C5
          CPY #$D0
L75C5     RTS
L75C6     LDA $8D
          BNE L7610
          JSR L75AD
          BNE L7610
          JSR L7683
          JSR L76F1
          JSR L7720
          LDA #$0C
          STA $030F,Y
          LDX $47
          LDA $761A,X
          STA $0309,Y
          LDA #$00
          STA $0308,Y
          LDA #$01
          STA $030B,Y
          JSR L76AD
          LDA $0300,Y
          ASL A
          ORA $47
          AND #$03
          TAX
          LDA $7616,X
          STA $05
          LDA #$FA
          STA $04
          JSR L769E
          LDX $0300,Y
          DEX
          BNE L7610
          JSR L6F74
L7610     LDY #$09
L7612     TYA
          JMP L7322
          .BYTE $0C    ;%00001100
L7617     .BYTE $F4    ;%11110100
          PHP
          SED
          .BYTE $04    ;%00000100
          .BYTE $FC    ;%11111100
L761C     LDA $8D
          BNE L7664
          JSR L75AD
          BNE L7664
          JSR L7683
          JSR L771C
          JSR L7720
          LDA #$0C
          STA $030F,Y
          LDA #$FC
          STA $0308,Y
          LDA #$00
          STA $0309,Y
          LDA #$01
          STA $030B,Y
          JSR L76D8
          LDX $47
          LDA $767F,X
          STA $05
          LDA $0300,Y
          AND #$01
          TAX
          LDA $7681,X
          STA $04
          JSR L769E
          LDA $0300,Y
          CMP #$01
          BNE L7664
          JSR L6F74
L7664     LDX $47
          LDY $767B,X
          LDA $0314
          BEQ L7671
          LDY $767D,X
L7671     LDA $0300
          CMP #$01
          BEQ L769D
          JMP L7612
          ROL $26
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          ORA ($FF,X)
          CPX $98F0
          TAX
          INC $0300,X
          LDA #$02
          STA $0301,Y
          STA $0302,Y
          LDA #$1B
L7692     STA $0305,X
L7695     STA $0306,X
          LDA #$00
          STA $0304,X
L769D     RTS
L769E     LDX #$00
          JSR L8C13
          TYA
          TAX
          JSR LAC7C
          TXA
          TAY
          JMP L79B5
L76AD     LDA $010E
          BEQ L76F0
          CPY #$D0
          BNE L76F0
          LDX $47
          LDA $76D6,X
L76BB     JSR L76E5
          JSR L6F5E
          LDA #$0B
          STA $0300,Y
          LDA #$FF
          STA $030F,Y
          DEC $B412
          BNE L76F0
          DEC $010E
          JMP L6F3F
          STA $AD8B
          ASL $F001
          .BYTE $13    ;%00010011
          CPY #$D0
          BNE L76F0
          LDA #$8F
          BNE L76BB
L76E5     STA $0306,Y
          STA $0305,Y
          LDA #$00
          STA $0304,Y
L76F0     RTS
L76F1     LDA $47
L76F3     STA $0502,Y
          BIT $B411
          BVC L76F0
          LDA #$00
          STA $0501,Y
          STA $0304,Y
          TYA
          JSR L9472
          LDA #$00
          BCS L770D
          LDA #$0C
L770D     STA $0500,Y
          LDA #$02
          STA $0300,Y
          LDA #$7D
          JSR L76E5
          BEQ L772A
L771C     LDA #$02
          BNE L76F3
L7720     LDA $B411
          BPL L76F0
          LDA #$03
          STA $0300,Y
L772A     JMP L6F86
          LDA $50
          CMP #$05
          BCC L7796
          DEC $53
          BNE L777C
          ASL A
          BCC L773F
          LSR A
          STA $50
          BNE L7796
L773F     JSR L780D
          JSR L90BB
          JSR $B5A3
          LDA $74
          BEQ L775D
          PHA
          JSR L7CAA
          PLA
          BPL L775D
          LDA #$00
          STA $74
          BEQ L775D
L7759     LDA #$80
          STA $74
L775D     LDA $8EA2
          BEQ L776C
          JSR L6FBB
          LDA #$00
          STA $8EA2
          BEQ L7759
L776C     LDA $52
          AND #$0F
          STA $0300
          LDA #$00
          STA $52
          STA $50
          JSR L74FD
L777C     LDA $48
          BEQ L778E
          LDY $030E
          BNE L7788
          JSR L85B4
L7788     DEC $030E
          JMP L7796
L778E     INC $030E
          BNE L7796
          JSR L85B4
L7796     JSR L71AE
          JSR L7146
          JMP L81C6
          LDA #$01
          JMP L7121
          LDA $0320
          CMP #$03
          BEQ L77AF
          CMP #$08
          BNE L77F2
L77AF     LDA $032F
          BMI L77D4
          LDA $030D
          SEC
          SBC $FC
          CMP #$84
          BCC L77C1
          JSR L8884
L77C1     LDY $030D
          CPY #$EF
          BNE L77CD
          JSR L85B4
          LDY #$FF
L77CD     INY
          STY $030D
          JMP L77FF
L77D4     LDA $030D
          SEC
          SBC $FC
          CMP #$64
          BCS L77E1
          JSR L885C
L77E1     LDY $030D
          BNE L77EB
          JSR L85B4
          LDY #$F0
L77EB     DEY
          STY $030D
          JMP L77FF
L77F2     LDY #$00
          STY $0308
          CMP #$05
          BEQ L7804
          CMP #$07
          BEQ L7804
L77FF     LDA $27
          LSR A
          BCC L780C
L7804     JSR L7146
          LDA #$01
          JMP L81C3
L780C     RTS
L780D     LDX #$60
          SEC
L7810     JSR L7835
          TXA
          SBC #$20
          TAX
          BPL L7810
          JSR L8EDB
          TAY
          LDX #$18
L781F     JSR L7829
          TXA
          SEC
          SBC #$08
          TAX
          BNE L781F
L7829     TYA
          CMP $072C,X
          BNE L7834
          LDA #$FF
          STA $0728,X
L7834     RTS
L7835     LDA $0405,X
          AND #$02
          BNE L783F
          STA $B460,X
L783F     RTS
L7840     LDX #$D0
          JSR L784C
          LDX #$E0
          JSR L784C
          LDX #$F0
L784C     STX $45
          LDA $0300,X
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L78C3
          SEI
          LDA $4278
          ADC $7949,Y
          .BYTE $DB    ;%11011011
          ADC $79ED,Y
          ASL $DB7A
          ADC $79ED,Y
          ASL $6C7A
          SEI
L786C     LDA #$01
          STA $6B
          JSR L7979
          JSR L795B
          JSR L7986
L7879     LDX $45
          BCC L7890
          LDA $B411
          AND #$04
          BNE L7898
          DEC $030F,X
          BNE L7898
          LDA #$00
          STA $0300,X
          BEQ L7898
L7890     LDA $0300,X
          BEQ L789D
          JSR L7965
L7898     LDA #$01
          JSR L81C3
L789D     DEC $6B
          RTS
L78A0     INC $0500,X
L78A3     INC $0500,X
          LDA #$00
          STA $0501,X
          BEQ L78C7
          LDA #$01
          STA $6B
          JSR L7979
          JSR L795B
          LDA $0502,X
          AND #$FE
          TAY
          LDA $790C,Y
          STA $0A
          LDA $790D,Y
          STA $0B
L78C7     LDY $0500,X
          LDA ($0A),Y
          CMP #$FF
          BNE L78D6
          STA $0500,X
          JMP L78A3
L78D6     CMP $0501,X
          BEQ L78A0
          INC $0501,X
          INY
          LDA ($0A),Y
          JSR LAF46
          LDX $45
          STA $0308,X
          LDA ($0A),Y
          JSR LAFDF
          LDX $45
          STA $0309,X
          TAY
          LDA $0502,X
          LSR A
          BCC L7901
          TYA
          JSR L8001
          STA $0309,X
L7901     JSR L7986
          BCS L7909
          JSR L79A1
L7909     JMP L7879
          BPL L7987
          AND #$79
          ORA ($F3,X)
          ORA ($D3,X)
          ORA ($93,X)
          ORA ($13,X)
          ORA ($53,X)
          ORA ($73,X)
          ORA ($73,X)
          ORA ($53,X)
          ORA ($13,X)
          ORA ($93,X)
          ORA ($D3,X)
          ORA ($F3,X)
          .BYTE $FF    ;%11111111
          ORA ($B7,X)
          ORA ($B5,X)
          ORA ($B1,X)
          ORA ($B9,X)
          ORA ($BD,X)
          ORA ($BF,X)
          ORA ($BF,X)
          ORA ($BD,X)
          ORA ($B9,X)
          ORA ($B1,X)
          ORA ($B5,X)
          ORA ($B7,X)
          .BYTE $FF    ;%11111111
          LDA #$81
          STA $65
          JMP L786C
          LDA #$01
          STA $6B
          LDA $0303,X
          SEC
          SBC #$F7
          BNE L7958
          STA $0300,X
L7958     JMP L7898
L795B     LDA $030A,X
          BEQ L7978
          LDA #$00
          STA $030A,X
L7965     LDA #$1D
          LDY $0300,X
          CPY #$0B
          BNE L7970
          LDA #$91
L7970     JSR L7692
          LDA #$04
L7975     STA $0300,X
L7978     RTS
L7979     LDA $030B,X
          LSR A
          BCS L7978
L797F     LDA #$00
          BEQ L7975
L7983     JMP L8B89
L7986     JSR L7B1C
          LDY #$00
          LDA ($04),Y
          CMP #$A0
          BCS L79A1
          JSR $B5B8
          CMP #$4E
          BEQ L7983
          JSR L79CE
          BCC L79CD
          CLC
          JMP L8D13
L79A1     LDX $45
          LDA $0309,X
          STA $05
          LDA $0308,X
          STA $04
          JSR L8C13
          JSR LAC7C
          BCC L797F
L79B5     LDA $08
          STA $030D,X
          LDA $09
          STA $030E,X
          LDA $0B
          AND #$01
          BPL L79CA
L79C5     LDA $030C,X
          EOR #$01
L79CA     STA $030C,X
L79CD     RTS
L79CE     LDY $6E
          CPY #$10
          BEQ L79D8
          CMP #$70
          BCS L79DA
L79D8     CMP #$80
L79DA     RTS
          LDA #$7F
          JSR L7692
          LDA #$18
          STA $030F,X
          INC $0300,X
L79E8     LDA #$03
          JMP L81C3
          LDA $27
          LSR A
          BCC L7A0B
          DEC $030F,X
          BNE L7A0B
          LDA #$37
          LDY $0300,X
          CPY #$09
          BNE L7A02
          LDA #$82
L7A02     JSR L7692
          INC $0300,X
          JSR L6F5A
L7A0B     JMP L79E8
          INC $030F,X
          JSR L7A24
          LDX $45
          LDA $0303,X
          SEC
          SBC #$F7
          BNE L7A21
          STA $0300,X
L7A21     JMP L79E8
L7A24     JSR L7B1C
          LDA $04
          STA $0A
          LDA $05
          STA $0B
          LDX $45
          LDY $030F,X
          DEY
          BEQ L7A61
          DEY
          BNE L7A65
          LDA #$40
          JSR L7B08
          TXA
          BNE L7A48
          LDA $04
          AND #$20
          BEQ L7A64
L7A48     LDA $05
          AND #$03
          CMP #$03
          BNE L7A61
          LDA $04
          CMP #$C0
          BCC L7A61
          LDA $43
          AND #$02
          BNE L7A64
          LDA #$80
          JSR L7B08
L7A61     JSR L7AE7
L7A64     RTS
L7A65     DEY
          BNE L7A92
          LDA #$40
          JSR L7AFC
          TXA
          BNE L7A76
          LDA $04
          AND #$20
          BNE L7A64
L7A76     LDA $05
          AND #$03
          CMP #$03
          BNE L7A8F
          LDA $04
          CMP #$C0
          BCC L7A8F
          LDA $43
          AND #$02
          BNE L7A64
          LDA #$80
          JSR L7AFC
L7A8F     JMP L7AE7
L7A92     DEY
          BNE L7ABE
          LDA #$02
          JSR L7B08
          TXA
          BNE L7AA2
          LDA $04
          LSR A
          BCC L7AFB
L7AA2     LDA $04
          AND #$1F
          CMP #$1E
          BCC L7ABB
          LDA $43
          AND #$02
          BEQ L7AFB
          LDA #$1E
          JSR L7AFC
          LDA $05
          EOR #$04
          STA $05
L7ABB     JMP L7AE7
L7ABE     DEY
          BNE L7AFB
          LDA #$02
          JSR L7AFC
          TXA
          BNE L7ACE
          LDA $04
          LSR A
          BCS L7AFB
L7ACE     LDA $04
          AND #$1F
          CMP #$02
          BCS L7AE7
          LDA $43
          AND #$02
          BEQ L7AFB
          LDA #$1E
          JSR L7B08
          LDA $05
          EOR #$04
          STA $05
L7AE7     TXA
          PHA
          LDY #$00
          LDA ($04),Y
          JSR L79CE
          BCC L7AF9
          CMP #$A0
          BCS L7AF9
          JSR L8D17
L7AF9     PLA
          TAX
L7AFB     RTS
L7AFC     CLC
          ADC $0A
          STA $04
          LDA $0B
          ADC #$00
          JMP L7B15
L7B08     STA $00
          LDA $0A
          SEC
          SBC $00
          STA $04
          LDA $0B
          SBC #$00
L7B15     AND #$07
          ORA #$60
          STA $05
L7B1B     RTS
L7B1C     LDX $45
          LDA $030D,X
          STA $02
          LDA $030E,X
          STA $03
          LDA $030C,X
          STA $0B
          JMP L8CBF
L7B30     LDX #$20
          STX $45
          LDA $0300,X
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L7B8B
          .BYTE $7B    ;%01111011 '{'
          .BYTE $8B    ;%10001011
          .BYTE $7B    ;%01111011 '{'
          TSX
          .BYTE $7B    ;%01111011 '{'
          SBC $207B
          .BYTE $7C    ;%01111100 '|'
          EOR #$7C
          JSR $BA7C
          .BYTE $7B    ;%01111011 '{'
          CPY $AD7C
          .BYTE $07    ;%00000111
          .BYTE $03    ;%00000011
          BEQ L7B83
          LDA #$04
          BIT $032F
          BPL L7B5B
          ASL A
L7B5B     AND $15
          BEQ L7B83
          JSR L74FD
          STY $0304
          STY $0314
          TYA
          STA $0308,X
          INC $0300,X
          LDA #$09
          STA $0300
          LDA #$04
          JSR L731F
          LDA #$80
          STA $030E
          LDA #$70
          STA $030D
L7B83     LDA $27
          LSR A
          BCC L7B1B
          JMP L81C6
L7B8B     LDA $FD
          BNE L7BA1
          LDA $73
          ORA #$08
          STA $73
          LDA $43
          AND #$01
          STA $43
          INC $0300,X
          JMP L7B83
L7BA1     LDA #$80
          STA $030E
          LDA $030E,X
          SEC
          SBC $FD
          BMI L7BB4
          JSR L8A12
          JMP L7B83
L7BB4     JSR L8A3D
          JMP L7B83
          LDA $030F,X
          BPL L7BD1
          LDY $030D,X
          BNE L7BC9
          JSR L79C5
          LDY #$F0
L7BC9     DEY
          TYA
          STA $030D,X
          JMP L7BE3
L7BD1     INC $030D,X
          LDA $030D,X
          CMP #$F0
          BNE L7BE3
          JSR L79C5
          LDA #$00
          STA $030D,X
L7BE3     CMP #$83
          BNE L7BEA
          INC $0300,X
L7BEA     JMP L7B83
          LDA $FC
          BNE L7C0F
          LDA #$4E
          STA $0305
          LDA #$41
          STA $0306
          LDA #$5D
          STA $0305,X
          LDA #$50
          STA $0306,X
          INC $0300,X
          LDA #$40
          STA $24
          JMP L7B83
L7C0F     LDA $030F,X
          BPL L7C1A
          JSR L885C
          JMP L7B83
L7C1A     JSR L8884
          JMP L7B83
          LDA $24
          CMP #$3F
          PHA
          BCC L7C2A
          JSR L6F3F
L7C2A     PLA
          BNE L7C44
          INC $0300,X
          LDA $0300,X
          CMP #$08
          BNE L7C44
          LDA #$23
          STA $0303,X
          LDA #$04
          JSR L731F
          JMP L7B83
L7C44     LDA #$01
          JMP L81C3
          LDA $030F,X
          TAY
          CMP #$8F
          BNE L7C5E
          LDA #$07
          STA $1E
          INC $B41C
          JSR L6E00
          JMP L6E99
L7C5E     TYA
          BPL L7C69
          LDY #$00
          CMP #$84
          BNE L7C68
          INY
L7C68     TYA
L7C69     ORA #$10
          JSR LB261
          LDA $70
          EOR #$07
          STA $70
          LDY $6E
          CPY #$12
          BCC L7C7C
          LDA #$01
L7C7C     STA $1C
          JSR L7CAA
          JSR $D060
          JSR L6CE9
          JSR L6CF4
          LDX #$20
          STX $45
          LDA #$6B
          STA $0305
          LDA #$5F
          STA $0306
          LDA #$7A
          STA $0305,X
          LDA #$6E
          STA $0306,X
          INC $0300,X
          LDA #$40
          STA $24
          RTS
L7CAA     LDA $0320
          CMP #$06
          BNE L7CB6
          LDA $032F
          BMI L7CBF
L7CB6     LDA $B5C5
          LDY $74
          BMI L7CC5
          BEQ L7CC5
L7CBF     LDA #$81
          STA $74
          LDA #$20
L7CC5     ORA $0685
          STA $0685
          RTS
          LDA $FC
          BNE L7CF1
          LDA #$00
          STA $0300
          JSR L7309
          LDX $45
          LDA #$01
          STA $0300,X
          LDA $030F,X
          EOR #$80
          STA $030F,X
          BMI L7CEE
          JSR L85BD
          STA $73
L7CEE     JMP L7B83
L7CF1     JMP L7C0F
L7CF4     LDA #$00
          STA $0307
          STA $78
          TAY
          LDX #$50
          JSR LA073
L7D01     LDA $B460,X
          CMP #$04
          BNE L7D1C
          JSR LA03F
          JSR LA0AC
          JSR LA0E7
          BCS L7D1C
          JSR L7D38
          BNE L7D1C
          INC $78
          BNE L7D21
L7D1C     JSR LA0E1
          BPL L7D01
L7D21     LDA $0320
          BEQ L7D37
          LDY #$00
          LDX #$20
          JSR L7FF8
          BCS L7D37
          JSR L7D38
          BNE L7D37
          INC $0307
L7D37     RTS
L7D38     LDA $10
          AND #$02
          BNE L7D45
          LDY $11
          INY
          CPY $04
          BEQ L7D51
L7D45     LDA $030A
          AND #$38
          ORA $10
          ORA #$40
          STA $030A
L7D51     RTS
L7D52     LDA #$60
          STA $45
          LDY $0360
          BEQ L7D51
          DEY
          BNE L7D6B
          JSR L7E26
          LDY #$01
          JSR L7E26
          BCS L7D6B
          INC $0360
L7D6B     LDY $0360
          CPY #$02
          BNE L7D8B
          LDA $B414
          BPL L7D7C
          LDY #$02
          JSR L7E26
L7D7C     LDA $B415
          BPL L7D86
          LDY #$03
          JSR L7E26
L7D86     BCS L7D8B
          INC $0360
L7D8B     LDX #$60
          JSR L7D98
          LDX #$61
          JSR L7D98
          JMP L7E50
L7D98     JSR L7DBB
          JSR L7DFA
          TXA
          AND #$01
          TAY
          LDA $7DB9,Y
          STA $0363
          LDA $B3B4,X
          BEQ L7DB4
          BMI L7DB4
          LDA $27
          LSR A
          BCC L7DF9
L7DB4     JMP L81C6
          DEY
          PLA
          ADC $66
L7DBB     LDA $0304,X
          BMI L7DF9
          LDA #$01
          STA $0304,X
          LDA $030F,X
          AND #$0F
          BEQ L7DF9
          INC $0304,X
          DEC $030F,X
          LDA $030F,X
          AND #$0F
          BNE L7DF9
          LDA $0304,X
          ORA #$80
          STA $0304,X
          STA $B3B4,X
          INC $0304,X
          TXA
          PHA
          AND #$01
          PHA
          TAY
          JSR L7E26
          PLA
          TAY
          INY
          INY
          JSR L7E26
          PLA
          TAX
L7DF9     RTS
L7DFA     LDA $030F,X
          STA $036D
          TXA
          AND #$01
          TAY
          LDA $7DB7,Y
          STA $036E
          LDA $B3B4,X
          BEQ L7E20
          BMI L7E20
          LDA $0304,X
          CMP #$01
          BNE L7E20
          LDA $0306,X
          BEQ L7E20
          DEC $030F,X
L7E20     LDA #$00
          STA $0306,X
          RTS
L7E26     LDA $7E48,Y
          STA $05C8
          LDA $036C
          ASL A
          ASL A
          ORA $7E4C,Y
          STA $05C9
          LDA #$09
          STA $05C3
          LDA #$C0
          STA $45
          JSR L9E4F
          LDA #$60
          STA $45
          RTS
          BMI L7DF6
          BEQ L7EB8
          ADC ($60,X)
          RTS
          RTS
L7E50     LDA $4E
          BMI L7E8C
          LDA $50
          BNE L7E8C
          LDA $B414
          AND $B415
          BPL L7E8C
          STA $4E
          LDX #$70
          LDY #$08
L7E66     LDA #$03
          STA $0500,X
          TYA
          ASL A
          STA $0507,X
          LDA #$04
          STA $050A,X
          LDA $036C
          ASL A
          ASL A
          ORA #$62
          STA $0509,X
          TYA
          ASL A
          ADC #$08
          STA $0508,X
          JSR LA0E1
          DEY
          BNE L7E66
L7E8C     RTS
L7E8D     LDA $B412
          BEQ L7E8C
          LDA $13
          ORA $17
          AND #$20
          BEQ L7E8C
          LDA $010E
          EOR #$01
          STA $010E
          JMP L6F3F
L7EA5     SEC
          LDA #$00
L7EA8     ROL A
          DEY
          BPL L7EA8
L7EAC     RTS
L7EAD     LDA #$40
          STA $45
          LDX #$00
          JSR L7EB8
          LDX #$08
L7EB8     STX $46
          LDY $0748,X
          INY
          BEQ L7EAC
          LDA $0749,X
          STA $034D
          LDA $074A,X
          STA $034E
          LDA $074B,X
          STA $034C
          JSR L7B1C
          LDX $46
          LDY #$00
          LDA ($04),Y
          CMP #$A0
          BCC L7EAC
          LDA $0748,X
          AND #$0F
          ORA #$50
          STA $0343
          LDA $27
          LSR A
          AND #$03
          ORA #$80
          STA $65
          LDA $55
          PHA
          LDA $074F,X
          JSR L81C6
          PLA
          CMP $55
          BEQ L7F6C
          TAX
          LDY $46
          LDA $0748,Y
          LDY #$01
          CMP #$07
          BEQ L7F15
          DEY
          CMP #$06
          BEQ L7F15
          CMP #$02
          BNE L7F1B
L7F15     TYA
          STA $0206,X
          LDA #$FF
L7F1B     PHA
          LDX #$00
          LDY #$40
          JSR L7FF5
          PLA
          BCS L7F6C
          TAY
          JSR L6FAD
          LDX $46
          INY
          BEQ L7F3C
          LDA $074B,X
          STA $08
          LDA $0748,X
          STA $09
          JSR L7F92
L7F3C     LDA $0748,X
          TAY
          CPY #$08
          BCS L7F6D
          CPY #$06
          BCC L7F50
          LDA $B411
          AND #$3F
          STA $B411
L7F50     JSR L7EA5
          ORA $B411
          STA $B411
L7F59     LDA #$FF
          STA $0109
          STA $0748,X
          LDY $74
          BEQ L7F67
          LDY #$01
L7F67     STY $74
          JMP L6F3F
L7F6C     RTS
L7F6D     BEQ L7F76
          LDA #$05
          JSR L8113
          BNE L7F59
L7F76     LDA $B410
          CMP #$06
          BEQ L7F80
          INC $B410
L7F80     LDA $B410
          JSR L9479
          ORA #$09
          STA $0107
          LDA #$99
          STA $0106
          BNE L7F59
L7F92     LDA $4A
L7F94     STA $07
          LDA $49
          STA $06
          LDA $43
          LSR A
          PHP
          BEQ L7FAA
          BCC L7FB2
          LDA $FD
          BEQ L7FB2
          DEC $07
          BCS L7FB2
L7FAA     BCC L7FB2
          LDA $FC
          BEQ L7FB2
          DEC $06
L7FB2     LDA $FF
          EOR $08
          AND #$01
          PLP
          CLC
          BEQ L7FC3
          ADC $07
          STA $07
          JMP L7FC7
L7FC3     ADC $06
          STA $06
L7FC7     JSR L7FDD
L7FCA     LDY $B420
          LDA $06
          STA $B421,Y
          LDA $07
          STA $B422,Y
          INY
          INY
          STY $B420
          RTS
L7FDD     LDA $07
          JSR L9478
          ORA $06
          STA $06
          LSR $07
          LSR $07
          LSR $07
          LDA $09
          ASL A
          ASL A
          ORA $07
          STA $07
          RTS
L7FF5     JSR LA073
L7FF8     JSR LA05F
          JSR LA094
          JMP LA0E7
L8001     EOR #$FF
          CLC
          ADC #$01
          RTS
          BRK
          .BYTE $80    ;%10000000
          CPY #$40
L800B     LDX $45
          LDY $0304,X
          BEQ L8017
          DEC $0304,X
          BNE L802C
L8017     STA $0304,X
          LDY $0306,X
L801D     LDA $95C4,Y
          CMP #$FF
          BEQ L802D
          STA $0303,X
          INY
          TYA
          STA $0306,X
L802C     RTS
L802D     LDY $0305,X
          JMP L801D
          PHA
          LDA #$00
          STA $06
          PLA
          BPL L803D
          DEC $06
L803D     CLC
          RTS
L803F     LDY #$00
          STY $0F
          LDA ($00),Y
          STA $04
          TAX
          JSR L9473
          AND #$03
          STA $05
          TXA
          AND #$C0
          ORA #$20
          ORA $05
          STA $05
          LDA $65
          AND #$10
          ASL A
          ASL A
          EOR $04
          STA $04
          LDA $65
          BPL L806B
          ASL $65
          JSR L83AF
L806B     TXA
          AND #$0F
          ASL A
          TAX
          RTS
L8071     JSR L82A4
          PLP
          PLP
          LDX $45
L8078     LDA $6E
          CMP #$13
          BNE L8089
          LDA $B46E,X
          CMP #$04
          BEQ L80DF
          CMP #$02
          BEQ L80DF
L8089     LDA $040C,X
          ASL A
          BMI L80F1
          JSR LA638
          STA $00
          JSR LAD60
          AND #$20
          STA $B46E,X
          LDA #$05
          STA $B460,X
          LDA #$60
          STA $040D,X
          LDA $28
          CMP #$10
          BCC L80D7
L80AC     AND #$07
          TAY
          LDA $81B1,Y
          STA $B463,X
          CMP #$80
          BNE L80C7
          LDY $8E
          CPY $90
          BEQ L80D7
          LDA $B413
          BEQ L80D7
          INC $90
L80C6     RTS
L80C7     LDY $8F
          CPY $91
          BEQ L80D7
          INC $91
          CMP #$89
          BNE L80C6
          LSR $00
          BCS L80C6
L80D7     LDX $45
          LDA $6E
          CMP #$13
          BEQ L80E2
L80DF     JMP LA905
L80E2     LDA $28
          LDY #$00
          STY $91
          STY $90
          INY
          STY $8E
          STY $8F
          BNE L80AC
L80F1     JSR L6FAD
          LDA $6E
          AND #$0F
          STA $0108
          LSR A
          TAY
          STA $B413,Y
          LDA #$4B
          JSR L8113
          BNE L80D7
L8107     LDX $45
          LDA $B463,X
          CMP #$F7
          BNE L812C
          JMP L82A4
L8113     PHA
          CLC
          ADC $B412
          BCC L811C
          LDA #$FF
L811C     STA $B412
          PLA
          CLC
          ADC $B413
          BCC L8128
          LDA #$FF
L8128     STA $B413
          RTS
L812C     LDA $0400,X
          STA $0A
          LDA $0401,X
          STA $0B
          LDA $B467,X
          STA $06
          LDA $B463,X
          ASL A
          TAY
          LDA ($3B),Y
          BCC L8146
          LDA ($3D),Y
L8146     STA $00
          INY
          LDA ($3B),Y
          BCC L814F
          LDA ($3D),Y
L814F     STA $01
          JSR L803F
          TAY
          LDA ($3F),Y
          STA $02
          INY
          LDA ($3F),Y
          STA $03
          LDY #$00
          CPX #$02
          BNE L8181
          LDX $45
          INC $0406,X
          LDA $0406,X
          PHA
          AND #$03
          TAX
          LDA $05
          AND #$3F
          ORA $8007,X
          STA $05
          PLA
          CMP #$19
          BNE L8181
          JMP L8071
L8181     LDX $45
          INY
          LDA ($00),Y
          STA $B461,X
          JSR L81B9
          INY
          LDA ($00),Y
          STA $B462,X
          STA $09
          INY
          STY $11
          JSR L8356
          TXA
          ASL A
          STA $08
          LDX $45
          LDA $0405,X
          AND #$FD
          ORA $08
          STA $0405,X
          LDA $08
          BEQ L81CF
          JMP L8255
          .BYTE $80    ;%10000000
          STA ($89,X)
          .BYTE $80    ;%10000000
          STA ($89,X)
          STA ($89,X)
L81B9     SEC
          SBC #$10
          BCS L81C0
          LDA #$00
L81C0     STA $08
          RTS
L81C3     JSR L800B
L81C6     LDX $45
          LDA $0303,X
          CMP #$F7
          BNE L81D2
L81CF     JMP L82A4
L81D2     CMP #$07
          BNE L81DC
          LDA $65
          AND #$EF
          STA $65
L81DC     LDA $030D,X
          STA $0A
          LDA $030E,X
          STA $0B
          LDA $030C,X
          STA $06
          LDA $0303,X
          ASL A
          TAX
          LDA $965D,X
          STA $00
          LDA $965E,X
          STA $01
          JSR L803F
          LDA $9731,X
          STA $02
          LDA $9732,X
          STA $03
          LDA $4F
          BEQ L8233
          CPX #$0E
          BNE L8233
          LDX $45
          INC $5F
          LDA $5F
          PHA
          AND #$03
          TAX
          LDA $05
          AND #$3F
          ORA $8007,X
          STA $05
          PLA
          CMP #$19
          BNE L8233
          LDX $45
          LDA #$08
          STA $0300,X
          PLA
          PLA
          JMP L82A4
L8233     LDX $45
          INY
          LDA ($00),Y
          STA $0301,X
          JSR L81B9
          INY
          LDA ($00),Y
          STA $0302,X
          STA $09
          INY
          STY $11
          JSR L8356
          TXA
          LDX $45
          STA $030B,X
          TAX
          BEQ L825A
L8255     LDX $55
          JMP L8290
L825A     JMP L82A4
L825D     LDY $0F
          JSR L82E2
          ADC $10
          STA $0200,X
          DEC $0200,X
          INC $0F
          LDY $11
          LDA ($00),Y
          STA $0201,X
          LDA $65
          ASL A
          ASL A
          AND #$40
          EOR $05
          STA $0202,X
          INC $11
          LDY $0F
          JSR L831A
          ADC $0E
          STA $0203,X
          INC $0F
          INX
          INX
          INX
          INX
L8290     LDY $11
L8292     LDA ($00),Y
          CMP #$FC
          BCC L825D
          BEQ L82C8
          CMP #$FD
          BEQ L82B2
          CMP #$FE
          BEQ L82A9
          STX $55
L82A4     LDA #$00
          STA $65
          RTS
L82A9     INC $0F
          INC $0F
          INC $11
          JMP L8290
L82B2     INY
          ASL $65
          BCC L82BC
          JSR L83AF
          BNE L82C2
L82BC     LSR $65
          LDA ($00),Y
          STA $05
L82C2     INY
          STY $11
          JMP L8292
L82C8     INY
          LDA ($00),Y
          CLC
          ADC $10
          STA $10
          INC $11
          INC $11
          LDY $11
          LDA ($00),Y
          CLC
          ADC $0E
          STA $0E
          INC $11
          JMP L8290
L82E2     LDA ($02),Y
          TAY
          AND #$F0
          CMP #$80
          BEQ L82F2
          TYA
L82EC     BIT $04
          BMI L8328
          CLC
          RTS
L82F2     TYA
          AND #$0E
          LSR A
          TAY
          LDA L83C0,Y
          LDY $4F
          BNE L8306
          LDY $45
          ADC $0406,Y
          JMP L8308
L8306     ADC $5F
L8308     TAY
          LDA $83C2,Y
          PHA
          LDA $0F
          CLC
          ADC #$0C
          TAY
          PLA
          CLC
          ADC ($02),Y
          JMP L82EC
L831A     LDA ($02),Y
          TAY
          AND #$F0
          CMP #$80
          BEQ L832F
          TYA
L8324     BIT $04
          BVC L832D
L8328     EOR #$FF
          SEC
          ADC #$F8
L832D     CLC
          RTS
L832F     LDY $45
          LDA $0406,Y
          LDY $4F
          BEQ L833A
          LDA $5F
L833A     ASL A
          PHA
          LDY $0F
          LDA ($02),Y
          LSR A
          BCS L8349
          PLA
          EOR #$FF
          ADC #$01
          PHA
L8349     LDA $0F
          CLC
          ADC #$0C
          TAY
          PLA
          CLC
          ADC ($02),Y
          JMP L8324
L8356     LDX #$01
          LDA $0A
          TAY
          SEC
          SBC $FC
          STA $10
          LDA $0B
          SEC
          SBC $FD
          STA $0E
          LDA $43
          AND #$02
          BNE L8393
          CPY $FC
          LDA $06
          EOR $FF
          AND #$01
          BEQ L8389
          BCS L8391
          LDA $10
          SBC #$0F
          STA $10
          LDA $09
          CLC
          ADC $10
          CMP #$F0
          BCC L8392
          CLC
L8389     BCC L8391
          LDA $09
          CMP $10
          BCC L8392
L8391     DEX
L8392     RTS
L8393     LDA $06
          EOR $FF
          AND #$01
          BEQ L83A5
          BCS L83AD
          LDA $09
          CLC
          ADC $0E
          BCC L83AE
          CLC
L83A5     BCC L83AD
          LDA $09
          CMP $0E
          BCC L83AE
L83AD     DEX
L83AE     RTS
L83AF     LSR $65
          LDA ($00),Y
          AND #$C0
          ORA $65
          STA $05
          LDA $65
          ORA #$80
          STA $65
          RTS
L83C0     BRK
          CLC
          BMI L83C0
          SED
          .BYTE $F4    ;%11110100
          BEQ L83B6
          CPX $E8EA
          .BYTE $E7    ;%11100111
          INC $E6
          SBC $E5
          CPX $E4
L83D2     .BYTE $E3    ;%11100011
          SBC $E7
          SBC #$EB
          .BYTE $EF    ;%11101111
          .BYTE $F3    ;%11110011
          .BYTE $F7    ;%11110111
          .BYTE $FB    ;%11111011
          INC $FAFC,X
          SED
          INC $F4,X
          .BYTE $F2    ;%11110010
          BEQ L83D2
          SBC $EAEB
          SBC #$E8
          .BYTE $E7    ;%11100111
          INC $E6
          INC $E6
          INC $E8
          NOP
L83F1     CPX $FEEE
          .BYTE $FC    ;%11111100
          .BYTE $FA    ;%11111010
          SED
          .BYTE $F7    ;%11110111
          INC $F5,X
          .BYTE $F4    ;%11110100
          .BYTE $F3    ;%11110011
          .BYTE $F2    ;%11110010
          SBC ($F1),Y
          BEQ L83F1
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          BEQ L83F9
          SBC ($F2),Y
L840B     LDX $45
          LDY $B460,X
          CPY #$05
          BEQ L8432
          LDY $B464,X
          BEQ L841E
          DEC $B464,X
          BNE L8432
L841E     STA $B464,X
          LDY $B466,X
L8424     LDA ($41),Y
          CMP #$FF
          BEQ L8433
          STA $B463,X
          INY
          TYA
          STA $B466,X
L8432     RTS
L8433     LDY $B465,X
          BCS L8424
L8438     LDY #$00
          LDA $55
          PHA
          TAX
L843E     LDA $8524,Y
          STA $0200,X
          INX
          INY
          CPY #$28
          BNE L843E
          STX $55
          PLA
          TAX
          LDA $0107
          AND #$0F
          JSR L84DE
          LDA $0106
          JSR L9473
          JSR L84DE
          LDY $010B
          INY
          BNE L848B
          LDY $B413
          BEQ L8481
          LDA $B412
          JSR L8503
          LDA $02
          JSR L84DE
          LDA $01
          JSR L84DE
          LDA $00
          JSR L84DE
          BNE L84B5
L8481     LDA #$FF
          STA $020D,X
          STA $0211,X
          BNE L84B5
L848B     LDA $010B
          JSR L9473
          JSR L84DE
          LDA $010B
          AND #$0F
          JSR L84DE
          LDA $010A
          JSR L9473
          JSR L84DE
          LDA #$BD
          STA $0201,X
          LDA #$BE
          STA $0205,X
          INC $0202,X
          INC $0206,X
L84B5     LDX $55
          LDA $B410
          BEQ L84DD
          STA $03
          LDA #$40
          STA $00
          LDY #$6F
          LDA $0107
          JSR L9473
          STA $01
          BNE L84CF
          DEY
L84CF     JSR L84E6
          DEC $01
          BNE L84D7
          DEY
L84D7     DEC $03
          BNE L84CF
          STX $55
L84DD     RTS
L84DE     ORA #$80
          STA $0201,X
          JMP L84FE
L84E6     LDA #$17
          STA $0200,X
          TYA
          STA $0201,X
          LDA #$01
          STA $0202,X
          LDA $00
          STA $0203,X
          SEC
          SBC #$0A
          STA $00
L84FE     INX
          INX
          INX
          INX
          RTS
L8503     LDY #$64
          STY $0A
          JSR L8518
          STY $02
          LDY #$0A
          STY $0A
          JSR L8518
          STY $01
          STA $00
          RTS
L8518     LDY #$00
          SEC
L851B     INY
          SBC $0A
          BCS L851B
          DEY
          ADC $0A
          RTS
          AND ($80,X)
          ORA ($30,X)
          AND ($80,X)
          ORA ($38,X)
          .BYTE $2B    ;%00101011 '+'
          .BYTE $FF    ;%11111111
          ORA ($28,X)
          .BYTE $2B    ;%00101011 '+'
          .BYTE $FF    ;%11111111
          ORA ($30,X)
          .BYTE $2B    ;%00101011 '+'
          .BYTE $FF    ;%11111111
          ORA ($38,X)
          .BYTE $2B    ;%00101011 '+'
          LSR $1800,X
          .BYTE $2B    ;%00101011 '+'
          .BYTE $5F    ;%01011111 '_'
          BRK
          JSR L7621
          ORA ($18,X)
          AND ($7F,X)
          ORA ($20,X)
          AND ($3A,X)
          BRK
          PLP
L854C     STX $0E
          LDX #$00
L8550     LSR A
          BCS L8558
          INX
          CPX #$08
          BNE L8550
L8558     TXA
          LDX $0E
L855B     RTS
L855C     LDX $50
          BEQ L855B
          DEX
          BNE L8569
          JSR L8A3D
          JMP L856F
L8569     DEX
          BNE L8577
          JSR L8A12
L856F     LDX $FD
          BNE L85B3
          LDX #$05
          BNE L8597
L8577     DEX
          BNE L8580
          JSR L8884
          JMP L8586
L8580     DEX
          BNE L85B3
          JSR L885C
L8586     LDX $FC
          BNE L85B3
          STX $66
          STX $67
          INX
          LDA $030E
          BMI L85AC
          INX
          BNE L85AC
L8597     LDA #$20
          STA $53
          LDA $52
          JSR L947A
          BCS L85A8
          LDY $51
          CPY #$03
          BCC L85AC
L85A8     LDA #$47
          BNE L85AF
L85AC     JSR L85BD
L85AF     STA $73
          STX $50
L85B3     RTS
L85B4     LDA $030C
          EOR #$01
          STA $030C
          RTS
L85BD     LDA $43
          EOR #$03
          STA $43
          LDA $73
          EOR #$08
          RTS
L85C8     LDA #$01
          CMP $43
          BCS L85D3
          LDA #$D8
          CMP $030D
L85D3     RTS
L85D4     LDA $0300
          CMP #$09
          BEQ L85DF
          CMP #$07
          BCS L85D3
L85DF     JSR L85C8
          LDY #$FF
          BCS L8611
          STY $6C
          JSR LA210
          LDA #$32
          STA $6A
          LDA $27
          AND #$03
          BNE L85F8
          JSR L6F6C
L85F8     LDA $27
          LSR A
          AND #$03
          BNE L860F
          LDA $B411
          AND #$20
          BEQ L8608
          BCC L860F
L8608     LDA #$07
          STA $68
          JSR L7246
L860F     LDY #$00
L8611     INY
          STY $5E
          JSR L86E5
          LDA $030D
          SEC
          SBC $FC
          STA $4C
          LDA $00
          BPL L8642
          JSR L8001
          LDY $5E
          BEQ L862D
          LSR A
          BEQ L8685
L862D     STA $5F
L862F     JSR L87C2
          BCS L863E
          SEC
          ROR $0308
          ROR $0312
          JMP L8685
L863E     DEC $5F
          BNE L862F
L8642     BEQ L8685
          LDY $5E
          BEQ L864C
          LSR A
          LSR A
          BEQ L8685
L864C     STA $5F
L864E     JSR L880E
          BCS L8681
          LDA $0300
          CMP #$03
          BNE L8676
          LSR $0308
          BEQ L8679
          ROR $0312
          LDA #$00
          SEC
          SBC $0312
          STA $0312
          LDA #$00
          SBC $0308
          STA $0308
          JMP L8685
L8676     JSR L6F56
L8679     JSR L74FD
          STY $0314
          BEQ L8685
L8681     DEC $5F
          BNE L864E
L8685     JSR L8750
          LDA $030E
          SEC
          SBC $FD
          STA $4B
          LDA $00
          BPL L86B2
          JSR L8001
          LDY $5E
          BEQ L869E
          LSR A
          BEQ L86CF
L869E     STA $5F
L86A0     JSR L8991
          JSR L86D0
          DEC $5F
          BNE L86A0
          LDA $52
          BEQ L86CF
          LDA #$01
          BNE L86CD
L86B2     BEQ L86CF
          LDY $5E
          BEQ L86BB
          LSR A
          BEQ L86CF
L86BB     STA $5F
L86BD     JSR L89D3
          JSR L86D0
          DEC $5F
          BNE L86BD
          LDA $52
          BEQ L86CF
          LDA #$00
L86CD     STA $48
L86CF     RTS
L86D0     BCS L86CF
          LDA #$01
          STA $5F
          LDA $0314
          BNE L86CF
          LDA $0300
          CMP #$03
          BEQ L86CF
          JMP L7309
L86E5     LDA $0314
          BNE L8710
          LDA #$18
          STA $0316
          LDA $030D
          CLC
          ADC $0301
          AND #$07
          BNE L86FF
          JSR L8B18
          BCC L8710
L86FF     JSR L7CF4
          LDA $0307
          BNE L8710
          LDA $78
          BNE L8710
          LDA #$1A
          STA $0314
L8710     LDX #$05
          LDA $0312
          CLC
          ADC $0314
          STA $0312
          LDA $0308
          ADC #$00
          STA $0308
          BPL L8734
          LDA #$00
          CMP $0312
          SBC $0308
          CMP #$06
          LDX #$FA
          BNE L8736
L8734     CMP #$05
L8736     BCC L873E
          JSR L74FD
          STX $0308
L873E     LDA $0310
          CLC
          ADC $0312
          STA $0310
          LDA #$00
          ADC $0308
          STA $00
          RTS
L8750     LDA $0316
          JSR L9479
          STA $00
          STA $02
          LDA $0316
          JSR L9473
          STA $01
          STA $03
          LDA $0313
          CLC
          ADC $0315
          STA $0313
          TAX
          LDA #$00
          BIT $0315
          BPL L8778
          LDA #$FF
L8778     ADC $0309
          STA $0309
          TAY
          BPL L8791
          LDA #$00
          SEC
          SBC $0313
          TAX
          LDA #$00
          SBC $0309
          TAY
          JSR L87B4
L8791     CPX $02
          TYA
          SBC $03
          BCC L87A2
          LDA $00
          STA $0313
          LDA $01
          STA $0309
L87A2     LDA $0311
          CLC
          ADC $0313
          STA $0311
          LDA #$00
          ADC $0309
          STA $00
          RTS
L87B4     LDA #$00
          SEC
          SBC $00
          STA $00
          LDA #$00
          SBC $01
          STA $01
          RTS
L87C2     LDA $030D
          SEC
          SBC $0301
          AND #$07
          BNE L87D2
          JSR L8B0D
          BCC L880D
L87D2     LDA $0300
          CMP #$09
          BEQ L87E6
          JSR L7CF4
          LDA $030A
          AND #$42
          CMP #$42
          CLC
          BEQ L880D
L87E6     LDA $4C
          CMP #$66
          BCS L87F1
          JSR L885C
          BCC L87F3
L87F1     DEC $4C
L87F3     LDA $030D
          BNE L8806
          LDA $43
          AND #$02
          BNE L8801
          JSR L85B4
L8801     LDA #$F0
          STA $030D
L8806     DEC $030D
          INC $030F
          SEC
L880D     RTS
L880E     LDA $030D
          CLC
          ADC $0301
          AND #$07
          BNE L881E
          JSR L8B18
          BCC L885B
L881E     LDA $0300
          CMP #$09
          BEQ L8832
          JSR L7CF4
          LDA $0307
          CLC
          BNE L885B
          LDA $78
          BNE L885B
L8832     LDA $4C
          CMP #$84
          BCC L883D
          JSR L8884
          BCC L883F
L883D     INC $4C
L883F     LDA $030D
          CMP #$EF
          BNE L8854
          LDA $43
          AND #$02
          BNE L884F
          JSR L85B4
L884F     LDA #$FF
          STA $030D
L8854     INC $030D
          DEC $030F
          SEC
L885B     RTS
L885C     LDA $43
          BEQ L886C
          CMP #$01
          BNE L8882
          DEC $43
          LDA $FC
          BEQ L886C
          DEC $49
L886C     LDX $FC
          BNE L887C
          DEC $49
          JSR L8A8B
          BCS L8880
          JSR L8D0C
          LDX #$F0
L887C     DEX
          JMP L88AA
L8880     INC $49
L8882     SEC
          RTS
L8884     LDX $43
          DEX
          BEQ L8893
          BPL L88B3
          INC $43
          LDA $FC
          BEQ L8893
          INC $49
L8893     LDA $FC
          BNE L889E
          INC $49
          JSR L8A8B
          BCS L88B1
L889E     LDX $FC
          CPX #$EF
          BNE L88A9
          JSR L8D0C
          LDX #$FF
L88A9     INX
L88AA     STX $FC
          JSR L88B5
          CLC
          RTS
L88B1     DEC $49
L88B3     SEC
L88B4     RTS
L88B5     JSR L8D80
          LDX $54
          INX
          BNE L88B4
          LDA $43
          AND #$02
          BNE L88C6
          JMP L88DC
L88C6     JMP L8A6C
          .BYTE $07    ;%00000111
          BRK
          JSR $602C
          .BYTE $64    ;%01100100 'd'
L88CF     JSR L8EDB
          AND #$01
          TAY
          LDA $88CB,Y
          LDX $88CD,Y
          RTS
L88DC     LDX $43
          LDA $FC
          AND #$07
          CMP $88C9,X
          BNE L88B4
L88E7     LDX $43
          CPX $44
          BNE L88B4
          LDA $FC
          AND #$F8
          STA $00
          LDA #$00
          ASL $00
          ROL A
          ASL $00
          ROL A
L88FB     STA $01
          JSR L88CF
          ORA $01
          STA $03
          TXA
          ORA $01
          STA $01
          LDA $00
          STA $02
          LDA $43
          LSR A
          TAX
          LDA $894B,X
          STA $04
          LDY #$01
          STY $1B
          DEY
          LDX $07A0
          LDA $03
          JSR L9526
          LDA $02
          JSR L9526
          LDA $04
          JSR L9539
L892D     LDA ($00),Y
          JSR L9526
          STY $06
          LDY #$01
          BIT $04
          BPL L893C
          LDY #$20
L893C     JSR L9467
          LDY $06
          DEC $05
          BNE L892D
          STX $07A0
          JSR L9531
          JSR LA29E
          CPY #$A5
          .BYTE $54    ;%01010100 'T'
          CMP #$F2
          BEQ L8957
          LDX #$E0
L8957     STX $00
          STX $02
          JSR L88CF
          ORA #$03
          STA $03
          TXA
          ORA #$03
          STA $01
          LDA #$01
          STA $1B
          LDX $07A0
          LDA $03
          JSR L9526
          LDA $02
          JSR L9526
          LDA #$20
          STA $04
          JSR L9526
          LDY #$00
L8981     LDA ($00),Y
          JSR L9526
          INY
          DEC $04
          BNE L8981
          STX $07A0
          JSR L9531
L8991     LDA $030E
          SEC
          SBC $0302
          AND #$07
          BNE L89A1
          JSR L8BD5
          BCC L89CE
L89A1     JSR L7CF4
          LDA $030A
          AND #$41
          CMP #$41
          CLC
          BEQ L89CE
          LDA $4B
          CMP #$71
          BCS L89B9
          JSR L8A12
          BCC L89BB
L89B9     DEC $4B
L89BB     LDA $030E
          BNE L89C9
          LDA $43
          AND #$02
          BEQ L89C9
          JSR L85B4
L89C9     DEC $030E
          SEC
          RTS
L89CE     LDA #$00
          STA $52
          RTS
L89D3     LDA $030E
          CLC
          ADC $0302
          AND #$07
          BNE L89E3
          JSR L8BE0
          BCC L8A0D
L89E3     JSR L7CF4
          LDA $030A
          AND #$41
          CMP #$40
          CLC
          BEQ L8A0D
          LDA $4B
          CMP #$8F
          BCC L89FB
          JSR L8A3D
          BCC L89FD
L89FB     INC $4B
L89FD     INC $030E
          BNE L8A0B
          LDA $43
          AND #$02
          BEQ L8A0B
          JSR L85B4
L8A0B     SEC
          RTS
L8A0D     LDA #$00
          STA $52
          RTS
L8A12     LDA $43
          CMP #$02
          BEQ L8A24
          CMP #$03
          BNE L8A3B
          DEC $43
          LDA $FD
          BEQ L8A24
          DEC $4A
L8A24     LDA $FD
          BNE L8A32
          DEC $4A
          JSR L8A8B
          BCS L8A39
          JSR L8D0C
L8A32     DEC $FD
          JSR L88B5
          CLC
          RTS
L8A39     INC $4A
L8A3B     SEC
          RTS
L8A3D     LDA $43
          CMP #$03
          BEQ L8A4F
          CMP #$02
          BNE L8A68
          INC $43
          LDA $FD
          BEQ L8A4F
          INC $4A
L8A4F     LDA $FD
          BNE L8A5A
          INC $4A
          JSR L8A8B
          BCS L8A66
L8A5A     INC $FD
          BNE L8A61
          JSR L8D0C
L8A61     JSR L88B5
          CLC
          RTS
L8A66     DEC $4A
L8A68     SEC
L8A69     RTS
          .BYTE $07    ;%00000111
          BRK
L8A6C     LDX $43
          LDA $FD
          AND #$07
          CMP L8A68,X
          BNE L8A69
L8A77     LDX $43
          CPX $44
          BNE L8A69
          LDA $FD
          AND #$F8
          JSR L9474
          STA $00
          LDA #$00
          JMP L88FB
L8A8B     LDA $43
          LSR A
          BEQ L8A9E
          ROL A
          ADC #$FF
          PHA
          JSR L8FE9
          PLA
          AND $0066,Y
          SEC
          BNE L8ADA
L8A9E     LDA $49
          JSR L9479
          STA $00
          LDA #$00
          ROL A
          ROL $00
          ROL A
          STA $01
          LDA $00
          ADC $4A
          STA $00
          LDA $01
          ADC #$68
          STA $01
          LDY #$00
          LDA ($00),Y
          CMP #$FF
          BEQ L8ADA
          STA $54
L8AC3     CMP $B5C8,Y
          BEQ L8AD5
          INY
          CPY #$07
          BNE L8AC3
          LDA $74
          BEQ L8AD7
          LDA #$80
          BNE L8AD7
L8AD5     LDA #$01
L8AD7     STA $74
          CLC
L8ADA     RTS
L8ADB     LDX $45
          LDA $B461,X
          CLC
          ADC #$08
          JMP L8AEE
L8AE6     LDX $45
          LDA #$00
          SEC
          SBC $B461,X
L8AEE     STA $02
          LDA #$08
          STA $04
          JSR L8AFD
          LDA $B462,X
          JMP L8B28
L8AFD     LDA $0401,X
          STA $09
          LDA $0400,X
          STA $08
          LDA $B467,X
          STA $0B
          RTS
L8B0D     LDX $45
          LDA $0301,X
          CLC
          ADC #$08
          JMP L8B20
L8B18     LDX $45
          LDA #$00
          SEC
          SBC $0301,X
L8B20     STA $02
          JSR L8C13
          LDA $0302,X
L8B28     BNE L8B2C
          SEC
          RTS
L8B2C     STA $03
          TAY
          LDX #$00
          LDA $09
          SEC
          SBC $03
          AND #$07
          BEQ L8B3B
          INX
L8B3B     JSR L8C23
          STA $04
          JSR L8C64
          LDX #$00
          LDY #$08
          LDA $00
L8B49     BNE L8B87
          STX $06
          STY $07
          LDX $04
L8B51     JSR L8CBF
          LDY #$00
          LDA ($04),Y
          CMP #$4E
          BEQ L8B89
          JSR $B5B8
          JSR L79CE
          BCC L8B88
          CMP #$A0
          BCS L8B6B
          JMP L8D13
L8B6B     LDY $4F
          BEQ L8B7E
          DEY
          STY $52
          CMP #$A0
          BEQ L8B7C
          CMP #$A1
          BNE L8B7E
          INC $52
L8B7C     INC $52
L8B7E     DEX
          BEQ L8B87
          JSR L8CE3
          JMP L8B51
L8B87     SEC
L8B88     RTS
L8B89     LDX $6B
          BEQ L8BD0
          LDX #$06
L8B8F     LDA $05
          EOR $57,X
          AND #$04
          BNE L8BC1
          LDA $04
          EOR $56,X
          AND #$1F
          BNE L8BC1
          TXA
          JSR L947A
          ORA #$80
          TAY
          LDA $0300,Y
          BEQ L8BC1
          LDA $0307,Y
          LSR A
          BCS L8BBA
          LDX $45
          LDA $0300,X
          EOR #$0B
          BNE L8BD2
L8BBA     LDA #$04
          STA $030A,Y
          BNE L8BD0
L8BC1     DEX
          DEX
          BPL L8B8F
          LDA $04
          JSR L9474
          AND #$01
          TAX
          INC $0366,X
L8BD0     CLC
          RTS
L8BD2     JMP L6F78
L8BD5     LDX $45
          LDA $0302,X
          CLC
          ADC #$08
          JMP L8BE8
L8BE0     LDX $45
          LDA #$00
          SEC
          SBC $0302,X
L8BE8     STA $03
          JSR L8C13
          LDY $0301,X
L8BF0     BNE L8BF4
          SEC
          RTS
L8BF4     STY $02
          LDX #$00
          LDA $08
          SEC
          SBC $02
          AND #$07
          BEQ L8C02
          INX
L8C02     JSR L8C23
          STA $04
          JSR L8C64
          LDX #$08
          LDY #$00
          LDA $01
          JMP L8B49
L8C13     LDA $030C,X
          STA $0B
          LDA $030D,X
          STA $08
          LDA $030E,X
          STA $09
          RTS
L8C23     EOR #$FF
          CLC
          ADC #$01
          AND #$07
          STA $04
          TYA
          ASL A
          SEC
          SBC $04
          BCS L8C35
          ADC #$08
L8C35     TAY
          LSR A
          LSR A
          LSR A
          STA $04
          TYA
          AND #$07
          BEQ L8C41
          INX
L8C41     TXA
          CLC
          ADC $04
          RTS
L8C46     LDX $45
          LDA $B462,X
          CLC
          ADC #$08
          JMP L8C59
L8C51     LDX $45
          LDA #$00
          SEC
          SBC $B462,X
L8C59     STA $03
          JSR L8AFD
          LDY $B461,X
          JMP L8BF0
L8C64     LDA $02
          BPL L8C77
          JSR L8CB4
          BCS L8C71
          CPX #$F0
          BCC L8C92
L8C71     TXA
          ADC #$0F
          JMP L8C89
L8C77     JSR L8CB4
          LDA $08
          SEC
          SBC $02
          TAX
          AND #$07
          STA $00
          BCS L8C92
          TXA
          SBC #$0F
L8C89     TAX
          LDA $43
          AND #$02
          BNE L8C92
          INC $0B
L8C92     STX $02
          LDX #$00
          LDA $03
          BMI L8C9B
          DEX
L8C9B     LDA $09
          SEC
          SBC $03
          STA $03
          AND #$07
          STA $01
          TXA
          ADC #$00
          BEQ L8CB3
          LDA $43
          AND #$02
          BEQ L8CB3
          INC $0B
L8CB3     RTS
L8CB4     LDA $08
          SEC
          SBC $02
          TAX
          AND #$07
          STA $00
          RTS
L8CBF     LDA #$18
          STA $05
          LDA $02
          AND #$F8
          ASL A
          ROL $05
          ASL A
          ROL $05
          STA $04
          LDA $03
          LSR A
          LSR A
          LSR A
          ORA $04
          STA $04
          LDA $0B
          ASL A
          ASL A
          AND #$04
          ORA $05
          STA $05
          RTS
L8CE3     LDA $02
          CLC
          ADC $06
          STA $02
          CMP #$F0
          BCC L8CFA
          ADC #$0F
          STA $02
          LDA $43
          AND #$02
          BNE L8CFA
          INC $0B
L8CFA     LDA $03
          CLC
          ADC $07
          STA $03
          BCC L8D0B
          LDA $43
          AND #$02
          BEQ L8D0B
          INC $0B
L8D0B     RTS
L8D0C     LDA $FF
          EOR #$03
          STA $FF
          RTS
L8D13     LDY $6B
          BEQ L8D59
L8D17     TAY
          JSR $B5B5
          CPY #$98
          BCS L8D58
          LDX #$C0
L8D21     LDA $0500,X
          BEQ L8D30
          JSR LA0E1
          BNE L8D21
          LDA $0500,X
          BNE L8D58
L8D30     INC $0500,X
          LDA $04
          AND #$DE
          STA $0508,X
          LDA $05
          STA $0509,X
          LDA $6E
          CMP #$11
          BNE L8D4D
          CPY #$76
          BNE L8D4D
          LDA #$04
          BNE L8D54
L8D4D     TYA
          CLC
          ADC #$10
          AND #$3C
          LSR A
L8D54     LSR A
          STA $050A,X
L8D58     CLC
L8D59     RTS
L8D5A     JSR L8EDB
          ASL A
          ASL A
          ORA #$60
          STA $34
          LDA #$00
          STA $33
          RTS
L8D68     LDA $54
          AND #$0F
          INC $54
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L8DC1
          .BYTE $89    ;%10001001
          .BYTE $7F    ;%01111111
          BNE L8DC5
          .BYTE $89    ;%10001001
          .BYTE $7B    ;%01111011 '{'
          STA $FFA9
          STA $54
L8D7F     RTS
L8D80     LDA $54
          CMP #$FF
          BEQ L8D7F
          CMP #$FE
          BEQ L8DB2
          CMP #$F0
          BCS L8D68
          JSR L8FF1
          JSR L90EE
          LDA $54
          ASL A
          TAY
          LDA ($35),Y
          STA $2D
          INY
          LDA ($35),Y
          STA $2E
          LDY #$00
          LDA ($2D),Y
          STA $62
          LDA #$01
          JSR L8E15
          JSR L8D5A
          JSR L934E
L8DB2     JMP L8DFF
L8DB5     STA $0E
          LDA $33
          STA $31
          LDA $34
          STA $32
          LDA $0E
L8DC1     JSR L9473
          TAX
L8DC5     BEQ L8DD5
L8DC7     LDA $31
          CLC
          ADC #$40
          STA $31
          BCC L8DD2
          INC $32
L8DD2     DEX
          BNE L8DC7
L8DD5     LDA $0E
          AND #$0F
          ASL A
          ADC $31
          STA $31
          BCC L8DE2
          INC $32
L8DE2     INY
          LDA ($2D),Y
          TAX
          INY
          LDA ($2D),Y
          STA $61
          TXA
          ASL A
          TAY
          LDA ($37),Y
          STA $2F
          INY
          LDA ($37),Y
          STA $30
          JSR L92E2
          LDA #$03
          JSR L8E15
L8DFF     LDY #$00
          LDA ($2D),Y
          CMP #$FF
          BEQ L8E49
          CMP #$FE
          BEQ L8E11
          CMP #$FD
          BNE L8DB5
          BEQ L8E1F
L8E11     STA $54
          LDA #$01
L8E15     CLC
          ADC $2D
          STA $2D
          BCC L8E1E
          INC $2E
L8E1E     RTS
L8E1F     LDA $2D
          STA $00
          LDA $2E
          STA $01
          LDA #$01
L8E29     JSR L925F
          LDY #$00
          LDA ($00),Y
          CMP #$FF
          BEQ L8E49
          AND #$0F
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L8E97
          STX $8EE2
          .BYTE $7F    ;%01111111
          BNE L8E9C
          .BYTE $8F    ;%10001111
          .BYTE $7F    ;%01111111
          BNE L8DCB
          .BYTE $8F    ;%10001111
          LDA $A28F
          BEQ L8DD2
          .BYTE $54    ;%01010100 'T'
          LDA $43
          STA $44
          AND #$02
          BNE L8E58
          JMP L88E7
L8E58     JMP L8A77
          JSR L8E61
          JMP L8E29
L8E61     LDA ($00),Y
          AND #$F0
          TAX
          JSR L8ED0
          BNE L8E7A
          INY
          LDA ($00),Y
          JSR L8E7D
          LDY #$02
          LDA ($00),Y
          JSR L8EA3
          PHA
L8E79     PLA
L8E7A     LDA #$03
          RTS
L8E7D     PHA
          AND #$C0
          STA $040F,X
          ASL A
          BPL L8E9B
          LDA $6E
          AND #$06
          LSR A
          TAY
          LDA $B413,Y
          BEQ L8E96
          PLA
          PLA
          JMP L8E79
L8E96     LDA #$01
          STA $8EA2
L8E9B     PLA
L8E9C     AND #$3F
          STA $B46E,X
          RTS
          BRK
L8EA3     TAY
          AND #$F0
          ORA #$08
          STA $0400,X
          TYA
          JSR L9479
          ORA #$0C
          STA $0401,X
          LDA #$01
          STA $B460,X
          LDA #$00
          STA $0404,X
          JSR L8EDB
          STA $B467,X
L8EC4     LDY $B46E,X
          ASL $0405,X
          JSR LAA68
          JMP LA747
L8ED0     LDA $B460,X
          BEQ L8EDA
          LDA $0405,X
          AND #$02
L8EDA     RTS
L8EDB     LDA $FF
          EOR $43
          AND #$01
          RTS
          JSR L8EE8
L8EE5     JMP L8E29
L8EE8     INY
          LDA ($00),Y
          PHA
          JSR L9479
          PHP
          LDA $4A
          CLC
          ADC $49
          PLP
          ROL A
          AND #$03
L8EF9     TAY
          LDX $8F56,Y
          PLA
          AND #$03
          STA $0307,X
          TYA
          PHA
          LDA $0307,X
          CMP #$01
          BEQ L8F26
          CMP #$03
          BEQ L8F26
          LDA #$0A
          STA $09
          LDY $4A
          TXA
          JSR L9479
          BCC L8F1D
          DEY
L8F1D     TYA
          JSR L9197
          JSR L91A0
          BCS L8F2B
L8F26     LDA #$01
          STA $0300,X
L8F2B     PLA
          AND #$01
          TAY
          JSR L8EDB
          STA $030C,X
          LDA $8F52,Y
          STA $030E,X
          LDA #$68
          STA $030D,X
          LDA $8F54,Y
          TAY
          JSR L8EDB
          EOR #$01
          TAX
          TYA
          ORA $66,X
          STA $66,X
          LDA #$02
          RTS
          BEQ L8F64
          .BYTE $02    ;%00000010
          ORA ($80,X)
          BCS L8EF9
          BCC L8F7B
          .BYTE $5F    ;%01011111 '_'
          .BYTE $8F    ;%10001111
          BNE L8EE5
L8F5F     LDA $0320
          BNE L8F82
L8F64     INY
          LDA ($00),Y
          STA $032F
          LDY #$83
          STY $032D
          LDA #$80
          STA $032E
          JSR L8EDB
          STA $032C
          LDA #$23
          STA $0323
          INC $0320
L8F82     LDA #$02
          RTS
          JSR L8EDB
          STA $036C
          LDA #$40
          LDX $B415
          BPL L8F94
          LDA #$30
L8F94     STA $0370
          LDA #$60
          LDX $B414
          BPL L8FA0
          LDA #$50
L8FA0     STA $036F
          STY $4E
          LDA #$01
          STA $0360
L8FAA     JMP L8E29
          LDX #$20
L8FAF     TXA
          SEC
          SBC #$08
          BMI L8FE5
          TAX
          LDY $0728,X
          INY
          BNE L8FAF
          LDY #$00
          LDA ($00),Y
          AND #$F0
          STA $0729,X
          INY
          LDA ($00),Y
          STA $0728,X
          INY
          LDA ($00),Y
          TAY
          AND #$F0
          ORA #$08
          STA $072A,X
          TYA
          JSR L9479
          ORA #$00
          STA $072B,X
          JSR L8EDB
          STA $072C,X
L8FE5     LDA #$03
          BNE L8FAA
L8FE9     LDA $FF
          EOR #$01
          AND #$01
          TAY
          RTS
L8FF1     LDX $43
          DEX
          LDY #$00
          JSR L90A7
          INY
          JSR L90A7
          LDX #$50
          JSR L8EDB
          TAY
L9003     TYA
          EOR $B467,X
          LSR A
          BCS L9014
          LDA $0405,X
          AND #$02
          BNE L9014
          STA $B460,X
L9014     JSR LA0E1
          BPL L9003
          LDX #$18
L901B     TYA
          EOR $B3,X
          LSR A
          BCS L9025
          LDA #$00
          STA $B0,X
L9025     TXA
          SEC
          SBC #$08
          TAX
          BPL L901B
          JSR L90BB
          JSR L90B1
          JSR L8EDB
          ASL A
          ASL A
          TAY
          LDX #$C0
L903A     TYA
          EOR $0509,X
          AND #$04
          BNE L9045
          STA $0500,X
L9045     JSR LA0E1
          CMP #$F0
          BNE L903A
          TYA
          LSR A
          LSR A
          TAY
          LDX #$D0
          JSR L90D0
          LDX #$E0
          JSR L90D0
          LDX #$F0
          JSR L90D0
          TYA
          SEC
          SBC $032C
          BNE L9069
          STA $0320
L9069     LDX #$1E
L906B     LDA $0704,X
          BNE L9075
          LDA #$FF
          STA $0700,X
L9075     TXA
          SEC
          SBC #$06
          TAX
          BPL L906B
          CPY $036C
          BNE L9086
          LDA #$00
          STA $0360
L9086     LDX #$18
L9088     TYA
          CMP $072C,X
          BNE L9093
          LDA #$FF
          STA $0728,X
L9093     TXA
          SEC
          SBC #$08
          TAX
          BPL L9088
          LDX #$00
          JSR L90E2
          LDX #$08
          JSR L90E2
          JMP $B5A6
L90A7     TXA
          EOR #$03
          AND $0066,Y
L90AD     STA $0066,Y
          RTS
L90B1     JSR L8EDB
          EOR #$01
          TAY
          LDA #$00
          BEQ L90AD
L90BB     LDX #$B0
L90BD     LDA $0300,X
          BEQ L90CA
          LDA $030B,X
          BNE L90CA
          STA $0300,X
L90CA     JSR LA0E1
          BMI L90BD
          RTS
L90D0     LDA $0300,X
          CMP #$05
          BCC L90E1
          TYA
          EOR $030C,X
          LSR A
          BCS L90E1
          STA $0300,X
L90E1     RTS
L90E2     TYA
          CMP $074B,X
          BNE L90ED
          LDA #$FF
          STA $0748,X
L90ED     RTS
L90EE     LDA $B590
          STA $00
          LDA $B591
L90F6     STA $01
          LDY #$00
          LDA ($00),Y
          CMP $49
          BEQ L9114
          BCS L90ED
          INY
          LDA ($00),Y
          TAX
          INY
          AND ($00),Y
          CMP #$FF
          BEQ L90ED
          LDA ($00),Y
          STX $00
          JMP L90F6
L9114     LDA #$03
          JSR L925F
L9119     LDY #$00
          LDA ($00),Y
          CMP $4A
          BEQ L912A
          BCS L90ED
          INY
          JSR L9256
          JMP L9119
L912A     LDA #$02
L912C     JSR L925F
          LDY #$00
          LDA ($00),Y
          AND #$0F
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L9189
          STA ($54),Y
          STA ($B9),Y
          STA ($F7),Y
          STA ($FC),Y
          STA ($04),Y
          .BYTE $92    ;%10010010
          JSR $4492
          .BYTE $92    ;%10010010
          LSR A
          .BYTE $92    ;%10010010
          BVC L90E0
          JSR L8E61
L9151     JMP L912C
          INY
          LDX #$00
          LDA #$FF
          CMP $0748
          BEQ L9165
          LDX #$08
          CMP $0750
          BNE L918F
L9165     LDA ($00),Y
          JSR L9193
          JSR L91A0
          BCS L918F
          LDY #$02
          LDA $09
          STA $0748,X
          LDA ($00),Y
          TAY
          AND #$F0
          ORA #$08
          STA $0749,X
          TYA
          JSR L9479
          ORA #$08
          STA $074A,X
L9189     JSR L8EDB
          STA $074B,X
L918F     LDA #$03
          BNE L9151
L9193     STA $09
          LDA $4A
L9197     STA $07
          LDA $49
          STA $06
          JMP L7FDD
L91A0     LDY $B420
          BEQ L91B7
L91A5     LDA $07
          CMP $B420,Y
          BNE L91B3
          LDA $06
          CMP $B41F,Y
          BEQ L91B8
L91B3     DEY
          DEY
          BNE L91A5
L91B7     CLC
L91B8     RTS
          LDX #$18
          LDA $28
          ADC $27
          STA $85
L91C1     JSR L91DC
          TXA
          SEC
          SBC #$08
          TAX
          BPL L91C1
          LDA $B5DC
          STA $B555
          STA $B556
          LDA #$01
          STA $B550
L91D9     JMP L912C
L91DC     LDA $B0,X
          BNE L91F6
          TXA
          ADC $85
          AND #$7F
          STA $B1,X
          ADC $29
          STA $B2,X
          JSR L8EDB
          STA $B3,X
          LDA #$01
          STA $B0,X
          ROL $85
L91F6     RTS
          JSR L8F5F
          BNE L91D9
          JSR $B5A9
          LDA #$02
L9201     JMP L912C
          JSR $B5AC
          LDA #$38
          STA $07
          LDA #$00
          STA $06
          JSR L91A0
          BCC L921C
          LDA #$08
          STA $98
          LDA #$00
          STA $99
L921C     LDA #$01
          BNE L9201
          JSR $B5AF
          TXA
          LSR A
          ADC #$3C
          STA $07
          LDA #$00
          STA $06
          JSR L91A0
          BCC L9241
          LDA #$81
          STA $0758,X
          LDA #$01
          STA $075D,X
          LDA #$07
          STA $075B,X
L9241     JMP L921C
          JSR $B5B2
          JMP L921C
          JSR L8EE8
          JMP L912C
          LDA $43
          STA $8C
          BNE L921C
L9256     LDA ($00),Y
          CMP #$FF
          BNE L925F
          PLA
          PLA
          RTS
L925F     CLC
          ADC $00
          STA $00
          BCC L9268
          INC $01
L9268     RTS
L9269     AND #$0F
          BNE L926F
          LDA #$10
L926F     STA $0E
          LDA ($2F),Y
          JSR L9473
          ASL A
          ADC $31
          STA $00
          LDA #$00
          ADC $32
          STA $01
L9281     LDA $01
          CMP #$63
          BEQ L928E
          CMP #$67
          BCC L9295
          BEQ L928E
          RTS
L928E     LDA $00
          CMP #$A0
          BCC L9295
          RTS
L9295     INC $10
          LDY $10
          LDA ($2F),Y
          ASL A
          ASL A
          STA $11
          LDX #$03
L92A1     LDY $11
          LDA ($39),Y
          INC $11
          LDY $92F0,X
          STA ($00),Y
          DEX
          BPL L92A1
          JSR L92F4
          LDY #$02
          JSR L9467
          LDA $00
          AND #$1F
          BNE L92C8
          LDA $10
          CLC
          ADC $0E
          SEC
          SBC #$01
          JMP L92CE
L92C8     DEC $0E
          BNE L9281
          LDA $10
L92CE     SEC
          ADC $2F
          STA $2F
          BCC L92D7
          INC $30
L92D7     LDA #$40
          CLC
          ADC $31
          STA $31
          BCC L92E2
          INC $32
L92E2     LDY #$00
          STY $10
          LDA ($2F),Y
          CMP #$FF
          BEQ L92EF
          JMP L9269
L92EF     RTS
          AND ($20,X)
          ORA ($00,X)
L92F4     LDA $61
          CMP $62
          BEQ L9349
          LDA $00
          STA $02
          LDA $01
          LSR A
          ROR $02
          LSR A
          ROR $02
          LDA $02
          AND #$07
          STA $03
          LDA $02
          LSR A
          LSR A
          AND #$38
          ORA $03
          ORA #$C0
          STA $02
          LDA #$63
          STA $03
          LDX #$00
          BIT $00
          BVC L9324
          LDX #$02
L9324     LDA $00
          AND #$02
          BEQ L932B
          INX
L932B     LDA $01
          AND #$04
          ORA $03
          STA $03
          LDA $934A,X
          LDY #$00
          AND ($02),Y
          STA ($02),Y
          LDA $61
L933E     DEX
          BMI L9345
          ASL A
          ASL A
          BCC L933E
L9345     ORA ($02),Y
          STA ($02),Y
L9349     RTS
          .BYTE $FC    ;%11111100
          .BYTE $F3    ;%11110011
          .BYTE $CF    ;%11001111
          .BYTE $3F    ;%00111111 '?'
L934E     LDA $34
          TAY
          TAX
          INY
          INY
          INY
          LDA #$FF
          JSR $EAD2
          LDX $01
          JSR L84FE
          STX $01
          LDX $62
          LDA $936E,X
          LDY #$C0
L9368     STA ($00),Y
          INY
          BNE L9368
          RTS
          BRK
          EOR $AA,X
          .BYTE $FF    ;%11111111
L9372     LDX #$28
          LDY #$02
          JSR $E9B1
          LDA $28
          RTS
L937C     JSR L9433
          JSR L93C8
          INC $27
          LDA #$00
          STA $1A
L9388     TAY
          LDA $1A
          BNE L9390
          JMP L9388
L9390     JSR L9372
          JMP L937C
          CLI
          PHP
          PHA
          TXA
          PHA
          TYA
          PHA
          LDA #$00
          STA $2003
          LDA #$02
          STA $4014
          LDA $1A
          BNE L93BA
          JSR L9402
          JSR L947E
          JSR $D06E
          JSR L94C5
          JSR $D000
L93BA     JSR $DFF3
          LDY #$01
          STY $1A
          PLA
          TAY
          PLA
          TAX
          PLA
          PLP
          RTI
L93C8     LDA $12
          AND #$10
          BEQ L93E9
          LDA $1E
          CMP #$03
          BEQ L93DC
          CMP #$05
          BNE L93E9
          LDA #$03
          BNE L93DE
L93DC     LDA #$05
L93DE     STA $1E
          LDA $2B
          EOR #$01
          STA $2B
          JSR L6F52
L93E9     LDA $1E
          JSR L9449
          .BYTE $82    ;%10000010
          CPY #$58
          JMP (L6D0A)
          .BYTE $64    ;%01100100 'd'
          ADC $6DC7
          ORA $6E,X
          ROL $996E
          ROR $6EA3
          LDX $95
L9402     LDY $1C
          BNE L9407
          RTS
L9407     DEY
          TYA
          ASL A
          TAY
          LDX $B560,Y
          LDA $B561,Y
          TAY
          LDA #$00
          STA $1C
L9416     STX $00
          STY $01
          JMP L94BC
L941D     LDA #$24
          LDX #$FC
          LDY #$00
          JSR $EA84
          LDX #$FC
          BNE L942C
L942A     LDX $00
L942C     LDA #$20
          LDY #$00
          JMP $EA84
L9433     LDX #$01
          DEC $23
          BPL L943F
          LDA #$09
          STA $23
          LDX #$02
L943F     LDA $24,X
          BEQ L9445
          DEC $24,X
L9445     DEX
          BPL L943F
          RTS
L9449     ASL A
          STY $64
          STX $63
          TAY
          INY
          PLA
          STA $0C
          PLA
          STA $0D
          LDA ($0C),Y
          TAX
          INY
          LDA ($0C),Y
          STA $0D
          STX $0C
          LDX $63
          LDY $64
          JMP ($000C)
L9467     TYA
          CLC
          ADC $00
          STA $00
          BCC L9471
          INC $01
L9471     RTS
L9472     LSR A
L9473     LSR A
L9474     LSR A
          LSR A
          LSR A
          RTS
L9478     ASL A
L9479     ASL A
L947A     ASL A
          ASL A
          ASL A
          RTS
L947E     LDA $1B
          BEQ L9493
          LDX #$A1
          LDY #$07
          JSR L9416
          LDA #$00
          STA $07A0
          STA $07A1
          STA $1B
L9493     RTS
L9494     STA $2006
          INY
          LDA ($00),Y
          STA $2006
          INY
          LDA ($00),Y
          ASL A
          JSR L94D3
          ASL A
          LDA ($00),Y
          AND #$3F
          TAX
          BCC L94AD
          INY
L94AD     BCS L94B0
          INY
L94B0     LDA ($00),Y
          STA $2007
          DEX
          BNE L94AD
          INY
          JSR L9467
L94BC     LDX $2002
          LDY #$00
          LDA ($00),Y
          BNE L9494
L94C5     LDA $2002
          LDA $FD
          STA $2005
          LDA $FC
          STA $2005
          RTS
L94D3     PHA
          LDA $FF
          ORA #$04
          BCS L94DC
          AND #$FB
L94DC     STA $2000
          STA $FF
          PLA
          RTS
L94E3     LDY #$01
          STY $1B
          DEY
          LDA ($02),Y
          AND #$0F
          STA $05
          LDA ($02),Y
          JSR L9473
          STA $04
          LDX $07A0
L94F8     LDA $01
          JSR L9526
          LDA $00
          JSR L9526
          LDA $05
          STA $06
          JSR L9526
L9509     INY
          LDA ($02),Y
          JSR L9526
          DEC $06
          BNE L9509
          STX $07A0
          STY $06
          LDY #$20
          JSR L9467
          LDY $06
          DEC $04
          BNE L94F8
          JSR L9531
L9526     STA $07A1,X
L9529     INX
          CPX #$4F
          BCC L9538
          LDX $07A0
L9531     LDA #$00
          STA $07A1,X
          PLA
          PLA
L9538     RTS
L9539     STA $04
          AND #$BF
          STA $07A1,X
          AND #$3F
          STA $05
          JMP L9529
L9547     JSR L958A
          ADC $01
          CMP #$0A
          BCC L9552
          ADC #$05
L9552     CLC
          ADC $02
          STA $02
          LDA $03
          AND #$F0
          ADC $02
          BCC L9563
L955F     ADC #$5F
          SEC
          RTS
L9563     CMP #$A0
          BCS L955F
          RTS
L9568     JSR L958A
          SBC $01
          STA $01
          BCS L957B
          ADC #$0A
          STA $01
          LDA $02
          ADC #$0F
          STA $02
L957B     LDA $03
          AND #$F0
          SEC
          SBC $02
          BCS L9587
          ADC #$A0
          CLC
L9587     ORA $01
          RTS
L958A     PHA
          AND #$0F
          STA $01
          PLA
          AND #$F0
          STA $02
          LDA $03
          AND #$0F
          RTS
          JSR L95A1
L959C     LDA $1A
          BEQ L959C
          RTS
L95A1     LDA #$00
          STA $1A
          RTS
          LDA $26
          BNE L95BB
          LDA $20
          CMP #$04
          BEQ L95B9
          CMP #$06
          BEQ L95B9
          JSR L7CAA
          LDA $20
L95B9     STA $1E
L95BB     RTS
L95BC     STA $26
          STX $20
          LDA #$09
          BNE L95B9
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $FF
          .BYTE $07    ;%00000111
          .BYTE $FF    ;%11111111
          .BYTE $17    ;%00010111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $22    ;%00100010 '"'
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          BPL L95D1
          .BYTE $17    ;%00010111
          CLC
          ORA $FF1A,Y
          .BYTE $03    ;%00000011
          .BYTE $17    ;%00010111
          .BYTE $FF    ;%11111111
          ASL $1C1D,X
          .BYTE $1B    ;%00011011
          .BYTE $FF    ;%11111111
          PLP
          .BYTE $FF    ;%11111111
          ROL A
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $12    ;%00010010
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          ORA $FF0E
          BMI L9617
          .BYTE $FF    ;%11111111
          AND ($31),Y
          .BYTE $33    ;%00110011 '3'
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $33    ;%00110011 '3'
          .BYTE $33    ;%00110011 '3'
          AND ($FF),Y
          AND $FF,X
          AND $FF38,Y
          RTI
          EOR ($42,X)
          .BYTE $FF    ;%11111111
          LSR $FF
          .BYTE $47    ;%01000111 'G'
          .BYTE $FF    ;%11111111
          PHA
          .BYTE $FF    ;%11111111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
L9611     .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
L9617     .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $4B    ;%01001011 'K'
          .BYTE $FF    ;%11111111
          LSR $FF4F
          .BYTE $3C    ;%00111100 '<'
          LSR A
          EOR #$4A
          EOR $4D4A
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          ROL $FF
          AND $FF
          .BYTE $27    ;%00100111 '''
          .BYTE $FF    ;%11111111
          .BYTE $67    ;%01100111 'g'
          .BYTE $67    ;%01100111 'g'
          .BYTE $67    ;%01100111 'g'
          PLA
          PLA
          ADC #$F7
          .BYTE $FF    ;%11111111
          ORA $1D98,X
          TYA
          ORA $1D98,X
          TYA
          .BYTE $2F    ;%00101111 '/'
          TYA
          .BYTE $42    ;%01000010 'B'
          TYA
          .BYTE $54    ;%01010100 'T'
          TYA
          .BYTE $54    ;%01010100 'T'
          TYA
          ROR A
          TYA
          ROR $7E98,X
          TYA
          ROR $7E98,X
          TYA
          BCC L9611
          .BYTE $A3    ;%10100011
          TYA
          LDA $98,X
          LDA $98,X
          DEC $98
          DEC $98
          .BYTE $D7    ;%11010111
          TYA
          .BYTE $D7    ;%11010111
          TYA
          .BYTE $D7    ;%11010111
          TYA
          .BYTE $D7    ;%11010111
          TYA
          .BYTE $D7    ;%11010111
          TYA
          SBC ($98,X)
          .BYTE $EB    ;%11101011
          TYA
          SBC $98,X
          .BYTE $FF    ;%11111111
          TYA
          ASL A
          STA $9915,Y
          JSR $2B99
          STA $992B,Y
L969F     .BYTE $2B    ;%00101011 '+'
          STA $992B,Y
          RTI
          STA $994A,Y
L96A7     LSR A
          STA $9950,Y
          LSR $99,X
          .BYTE $5C    ;%01011100 '\'
          STA $9961,Y
          ADC ($99,X)
          ROR $99
          .BYTE $7A    ;%01111010 'z'
          STA $997A,Y
          .BYTE $7A    ;%01111010 'z'
          STA $997A,Y
          .BYTE $7A    ;%01111010 'z'
          STA $998E,Y
          TXS
          STA $999A,Y
          LDX $99
          LDX $99
          .BYTE $B3    ;%10110011
          STA $99B3,Y
          .BYTE $B3    ;%10110011
          STA $99C6,Y
          CMP $D999,Y
          STA $99D9,Y
          .BYTE $E7    ;%11100111
          STA $99E7,Y
          .BYTE $E7    ;%11100111
          STA $99E7,Y
          .BYTE $FB    ;%11111011
          STA $9A10,Y
          BIT $9A
          BIT $9A
          BIT $9A
          BIT $9A
          SEC
          TXS
          EOR $619A
          TXS
          .BYTE $6F    ;%01101111 'o'
          TXS
          .BYTE $73    ;%01110011 's'
          TXS
          SEI
          TXS
          SEI
          TXS
          STX $939A
          TXS
          TYA
          TXS
          LDY #$9A
          TAY
          TXS
          BCS L969F
          CLV
          TXS
          CPY #$9A
          INY
          TXS
          BNE L96A7
          CLD
          TXS
          CPX #$9A
          INC $F39A
          TXS
          SED
          TXS
          BRK
          .BYTE $9B    ;%10011011
          .BYTE $0C    ;%00001100
          .BYTE $9B    ;%10011011
          ASL $9B,X
          ASL $9B,X
          ASL $9B,X
          ASL $9B,X
          ASL $9B,X
          ASL $9B,X
          ASL $9B,X
          ROL A
          .BYTE $9B    ;%10011011
          .BYTE $3B    ;%00111011 ';'
          .BYTE $9B    ;%10011011
          EOR $9B
          EOR $9B,X
          .BYTE $53    ;%01010011 'S'
          .BYTE $97    ;%10010111
          ADC ($97),Y
          ADC $8997,X
          .BYTE $97    ;%10010111
          STA $A397,Y
          .BYTE $97    ;%10010111
          .BYTE $4F    ;%01001111 'O'
          .BYTE $97    ;%10010111
          .BYTE $AF    ;%10101111
          .BYTE $97    ;%10010111
          .BYTE $C7    ;%11000111
          .BYTE $97    ;%10010111
          .BYTE $DF    ;%11011111
          .BYTE $97    ;%10010111
          .BYTE $E3    ;%11100011
          .BYTE $97    ;%10010111
          .BYTE $EB    ;%11101011
          .BYTE $97    ;%10010111
          .BYTE $F7    ;%11110111
          .BYTE $97    ;%10010111
          .BYTE $9B    ;%10011011
          .BYTE $97    ;%10010111
L974D     .BYTE $03    ;%00000011
          TYA
          INX
          .BYTE $FC    ;%11111100
          NOP
L9752     .BYTE $FC    ;%11111100
          BEQ L974D
          BEQ L9757
L9757     SED
          BEQ L9752
          SED
          SED
          BRK
          BRK
          SED
          BRK
          BRK
          BRK
          PHP
          PHP
          SED
          PHP
          BRK
          PHP
          PHP
          SED
          .BYTE $F4    ;%11110100
          SED
          INC $EC,X
          .BYTE $F4    ;%11110100
          INC $F3F4
          SED
          .BYTE $F3    ;%11110011
          BRK
          .BYTE $FB    ;%11111011
          SED
          .BYTE $FB    ;%11111011
          BRK
          .BYTE $03    ;%00000011
          SED
          .BYTE $03    ;%00000011
          BRK
          SED
          INC $F8,X
          INC $06F8,X
          BRK
          INC $00,X
          INC $0600,X
          .BYTE $FC    ;%11111100
          BEQ L9788
          SED
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $FC    ;%11111100
L9790     PHP
          .BYTE $FC    ;%11111100
          BPL L9790
          CLC
          .BYTE $FC    ;%11111100
          JSR $28FC
          .BYTE $FC    ;%11111100
          .BYTE $FC    ;%11111100
          SED
          SED
          SED
          BRK
          BRK
          SED
          BRK
          BRK
          INX
          BRK
          BEQ L97A7
L97A7     SED
          BRK
          BRK
          BRK
          PHP
          BRK
          BPL L97AF
L97AF     .BYTE $80    ;%10000000
          .BYTE $80    ;%10000000
          STA ($81,X)
          .BYTE $82    ;%10000010
          .BYTE $82    ;%10000010
          .BYTE $83    ;%10000011
          .BYTE $83    ;%10000011
          STY $84
          STA $85
          .BYTE $F4    ;%11110100
          SED
          .BYTE $F4    ;%11110100
          BRK
L97BF     .BYTE $FC    ;%11111100
          SED
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $04    ;%00000100
          SED
          .BYTE $04    ;%00000100
          BRK
          BEQ L97C9
L97C9     BEQ L97D3
          SED
          PHP
          BEQ L97BF
          BEQ L97C9
          SED
          BEQ L97D4
L97D4     BEQ L97DE
          BEQ L97E0
          SED
          BRK
          PHP
          PHP
          BRK
          PHP
L97DE     PHP
          SED
L97E0     .BYTE $FC    ;%11111100
          BRK
L97E2     .BYTE $FC    ;%11111100
          .BYTE $FC    ;%11111100
          SED
          .BYTE $FC    ;%11111100
L97E6     BRK
          .BYTE $FC    ;%11111100
          BPL L97E6
          CLC
          .BYTE $FC    ;%11111100
          BEQ L97E2
          SED
          .BYTE $F4    ;%11110100
          BRK
          .BYTE $FC    ;%11111100
          PHP
          .BYTE $04    ;%00000100
          SED
          .BYTE $04    ;%00000100
L97F6     BRK
          .BYTE $FC    ;%11111100
          INX
          CPX $ECF0
          PHP
          .BYTE $FC    ;%11111100
          BPL L980C
          BEQ L980E
          PHP
L9803     BRK
          SED
          BRK
          BRK
          PHP
          SED
          PHP
          BRK
          INX
L980C     BEQ L97F6
L980E     SED
          INX
          BRK
          BEQ L9803
          BEQ L980D
          BEQ L9817
L9817     SED
          BEQ L9812
          SED
          SED
          BRK
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          BRK
          ORA ($FD,X)
          JSR $41FE
          RTI
          SBC $2060,X
          AND ($FE,X)
          INC $FF31,X
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          SBC $FE20,X
          .BYTE $43    ;%01000011 'C'
          .BYTE $42    ;%01000010 'B'
          SBC $2260,X
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          ORA $06
          SBC $FE20,X
          EOR $44
          SBC $2560,X
          ROL $27
          AND $36,X
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          ORA #$FD
          RTS
          ORA #$FD
          JSR $19FE
          .BYTE $1A    ;%00011010
          SBC $2920,X
          ROL A
          INC $FD39,X
          RTS
          AND $40FF,Y
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          SBC $0E20,X
          ORA $1EFE
          ORA $2D2E,X
          INC $60FD,X
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3C    ;%00111100 '<'
          INC $FF17,X
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          BRK
          ORA ($FD,X)
          JSR $4A4B
          EOR #$FD
          RTS
          JSR $FE21
          INC $FF31,X
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          BRK
          ORA ($FD,X)
          JSR $4A4B
          EOR #$FD
          RTS
          .BYTE $22    ;%00100010 '"'
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          BRK
          ORA ($FD,X)
          JSR $4A4B
          EOR #$FD
          RTS
          AND $26
          .BYTE $27    ;%00100111 '''
          AND $36,X
          .BYTE $FF    ;%11111111
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          BRK
          ORA ($FD,X)
          JSR $41FE
          RTI
          SBC $2260,X
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          BRK
          ORA ($FD,X)
          JSR $4A4B
          EOR #$FD
          RTS
          .BYTE $22    ;%00100010 '"'
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          EOR ($0F,X)
          .BYTE $04    ;%00000100
          .BYTE $52    ;%01010010 'R'
          .BYTE $53    ;%01010011 'S'
          .BYTE $62    ;%01100010 'b'
          .BYTE $63    ;%01100011 'c'
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $FF    ;%11111111
          .BYTE $42    ;%01000010 'B'
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $64    ;%01100100 'd'
          ADC $66
          .BYTE $FF    ;%11111111
          STA ($0F,X)
          .BYTE $04    ;%00000100
          .BYTE $52    ;%01010010 'R'
          .BYTE $53    ;%01010011 'S'
          .BYTE $62    ;%01100010 'b'
          .BYTE $63    ;%01100011 'c'
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $FF    ;%11111111
          .BYTE $82    ;%10000010
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $64    ;%01100100 'd'
          ADC $66
          .BYTE $FF    ;%11111111
          ORA ($08,X)
          .BYTE $04    ;%00000100
          .BYTE $FC    ;%11111100
          .BYTE $03    ;%00000011
          BRK
          BVC L9958
          RTS
          ADC ($FF,X)
          STA ($08,X)
          .BYTE $04    ;%00000100
          .BYTE $FC    ;%11111100
          SBC $5000,X
          EOR ($60),Y
          ADC ($FF,X)
          CMP ($08,X)
          .BYTE $04    ;%00000100
          .BYTE $FC    ;%11111100
          SBC $5000,X
          EOR ($60),Y
          ADC ($FF,X)
          EOR ($08,X)
          .BYTE $04    ;%00000100
          .BYTE $FC    ;%11111100
          .BYTE $03    ;%00000011
          BRK
          BVC L9979
          RTS
          ADC ($FF,X)
          RTI
          .BYTE $0F    ;%00001111
          .BYTE $04    ;%00000100
          SBC $0E20,X
          ORA $1EFE
          ORA $2D2E,X
          INC $60FD,X
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3C    ;%00111100 '<'
          INC $17FE,X
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          BPL L996C
          SEC
          SEC
          SBC $2860,X
          .BYTE $FF    ;%11111111
          LSR A
          .BYTE $04    ;%00000100
          PHP
          LSR $FF5F,X
          ASL A
          .BYTE $04    ;%00000100
          PHP
          LSR $FF5F,X
          ORA #$08
L9958     .BYTE $04    ;%00000100
          .BYTE $14    ;%00010100
          BIT $FF
          .BYTE $04    ;%00000100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          BMI L9960
          .BYTE $04    ;%00000100
          BRK
          BRK
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          ADC #$FE
          SBC $7A20,X
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          ROL $FE2D
          SBC $3B60,X
          .BYTE $3C    ;%00111100 '<'
L9979     .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          INC $FD69,X
          JSR L797A
          INC $7778,X
          ROL $FE2D
          SBC $3B60,X
          .BYTE $3C    ;%00111100 '<'
          .BYTE $FF    ;%11111111
          AND $18,X
          PHP
          .BYTE $0F    ;%00001111
          .BYTE $1F    ;%00011111
          .BYTE $2F    ;%00101111 '/'
          SBC $2FA3,X
          .BYTE $1F    ;%00011111
          .BYTE $0F    ;%00001111
          .BYTE $FF    ;%11111111
          AND $18,X
          .BYTE $04    ;%00000100
          ROR A
          .BYTE $6B    ;%01101011 'k'
          JMP (LA3FD)
          JMP (L6A6B)
          .BYTE $FF    ;%11111111
          .BYTE $07    ;%00000111
          BRK
          BRK
          .BYTE $FC    ;%11111100
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $7B    ;%01111011 '{'
          .BYTE $7C    ;%01111100 '|'
          .BYTE $8B    ;%10001011
          STY $8D7D
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          ADC #$FD
          JSR L7AFE
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2260,X
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          INC $FD69,X
          JSR L797A
          INC $7778,X
          SBC $2260,X
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          ORA $0C0C
          .BYTE $74    ;%01110100 't'
          SBC $7460,X
          SBC $74A0,X
          SBC $74E0,X
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          ADC #$FE
          SBC $7A20,X
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2060,X
          AND ($FE,X)
          INC $FF31,X
          LSR $0F
          .BYTE $04    ;%00000100
          ADC #$FE
          SBC $7A20,X
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2260,X
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          ADC #$FE
          SBC $7A20,X
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2560,X
          ROL $27
          AND $36,X
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          INC $FD69,X
          JSR L797A
          INC $7778,X
          SBC $2060,X
          AND ($FE,X)
          INC $FF31,X
          LSR $0F
          .BYTE $04    ;%00000100
          INC $FD69,X
          JSR L797A
          INC $7778,X
          SBC $2260,X
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          LSR $0F
          .BYTE $04    ;%00000100
          INC $FD69,X
          JSR L797A
          INC $7778,X
          SBC $2560,X
          ROL $27
          AND $36,X
          .BYTE $FF    ;%11111111
          ORA $0C0C
          ADC $FD,X
          RTS
          ADC $FD,X
          LDY #$75
          SBC $75E0,X
          .BYTE $FF    ;%11111111
          BRK
          BRK
          BRK
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          JMP $08FF
          BPL L9A8B
          AND $4E3E,X
          SBC $3E60,X
          AND $FD4E,X
          CPX #$4E
          ROL $FD3D,X
          LDY #$4E
L9A8B     AND $FF3E,X
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          BVS L9A92
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ADC ($FF),Y
          ORA $0303
          STX $97,Y
          LDX $A7
          .BYTE $FF    ;%11111111
          ORA $0303
          .BYTE $9B    ;%10011011
          .BYTE $9C    ;%10011100
          .BYTE $AB    ;%10101011
          LDY $0DFF
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          TYA
          TXS
          TAY
L9AAE     LDA #$FF
          ORA $0303
          BCC L9A46
          LDY #$A1
          .BYTE $FF    ;%11111111
          ORA $0303
          STA $AD9E,X
          LDX $0DFF
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $92    ;%10010010
          .BYTE $93    ;%10010011
          LDX #$A3
          .BYTE $FF    ;%11111111
          ORA $0303
          TYA
          STA $A9A8,Y
          .BYTE $FF    ;%11111111
          ORA $0303
          TYA
          TAX
          TAY
          LDA #$FF
          ORA $0303
          STY $95,X
          LDY $A5
          .BYTE $FF    ;%11111111
          ORA $0303
          .BYTE $9F    ;%10011111
          SBC $9F40,X
          SBC $AF00,X
          SBC LAF40,X
          .BYTE $FF    ;%11111111
          .BYTE $34    ;%00110100 '4'
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $F2    ;%11110010
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          BRK
          BRK
          .BYTE $BF    ;%10111111
          .BYTE $FF    ;%11111111
          .BYTE $13    ;%00010011
          BRK
          BRK
          BCS L9AAE
          .BYTE $B2    ;%10110010
          .BYTE $B3    ;%10110011
          .BYTE $FF    ;%11111111
          .BYTE $13    ;%00010011
          BRK
          BRK
          LDY $B5,X
          LDX $B7,Y
          CLV
          LDX $B9,Y
          .BYTE $B3    ;%10110011
          .BYTE $FF    ;%11111111
          .BYTE $13    ;%00010011
          BRK
          BRK
          .BYTE $B3    ;%10110011
          TSX
          TSX
          INC $8080,X
          .BYTE $FF    ;%11111111
          ASL $0800,X
          .BYTE $FA    ;%11111010
          .BYTE $FB    ;%11111011
          .BYTE $FA    ;%11111010
          .BYTE $FB    ;%11111011
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $04    ;%00000100
          CMP $C6
          .BYTE $C7    ;%11000111
          CMP $D6,X
          .BYTE $D7    ;%11010111
          SBC $E6
          .BYTE $E7    ;%11100111
          .BYTE $FF    ;%11111111
          ASL $0800,X
          .BYTE $FA    ;%11111010
          .BYTE $FB    ;%11111011
          .BYTE $FA    ;%11111010
          .BYTE $FB    ;%11111011
          INC $C9C8,X
          .BYTE $EB    ;%11101011
          CLD
          CMP $E8EA,Y
          SBC #$FF
          ASL A
          .BYTE $04    ;%00000100
          PHP
          SBC $5700,X
          SBC $5740,X
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $04    ;%00000100
          .BYTE $0C    ;%00001100
          SBC $5700,X
          CLC
          SBC $1840,X
          .BYTE $57    ;%01010111 'W'
          SBC $18C0,X
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
L9B56     .BYTE $04    ;%00000100
          BPL L9B56
          BRK
          .BYTE $57    ;%01010111 'W'
          CLC
          SBC $1840,X
          .BYTE $57    ;%01010111 'W'
          SBC $18C0,X
          CLC
          .BYTE $FF    ;%11111111
L9B65     LDA $50
          BNE L9BBE
          LDY $52
          BEQ L9BBE
          STA $90
          STA $91
          LDA $28
          AND #$0F
          STA $8E
          ASL A
          ORA #$40
          STA $8F
          LDA $FF
          EOR #$01
          AND #$01
          TAY
          LSR A
          STA $0066,Y
          LDA $43
          AND #$02
          BNE L9B9D
          LDX #$04
          LDA $FC
          BEQ L9BBF
          LDA $FF
          EOR $030C
          LSR A
          BCC L9BA5
          BCS L9BA4
L9B9D     LDX #$02
          LDA $030E
          BPL L9BA5
L9BA4     DEX
L9BA5     TXA
          STA $51
          JSR L9BC6
          LDA #$12
          STA $53
          LDA $52
          JSR L9479
          ORA $0300
          STA $52
          LDA #$05
          STA $0300
L9BBE     RTS
L9BBF     JSR L9BA5
          JSR L8586
          TXA
L9BC6     ORA #$80
          STA $50
          RTS
L9BCB     LDX #$B0
L9BCD     JSR L9BD9
          LDA $45
          SEC
L9BD3     SBC #$10
          TAX
          BMI L9BCD
          RTS
L9BD9     STX $45
          LDA $0300,X
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L9BD3
          .BYTE $9B    ;%10011011
          .BYTE $27    ;%00100111 '''
          .BYTE $9C    ;%10011100
          .BYTE $53    ;%01010011 'S'
          .BYTE $9C    ;%10011100
          DEC $9C,X
          CLC
          STA $9D42,X
          INC $0300,X
          LDA #$30
          JSR L7692
          JSR L9D4D
          LDY $0307,X
          LDA $9C23,Y
          STA $030F,X
L9C03     LDA $0307,X
          CMP #$03
          BNE L9C0C
          LDA #$01
L9C0C     ORA #$A0
          STA $65
          LDA #$00
          STA $030A,X
          TXA
          AND #$10
          EOR #$10
          ORA $65
          STA $65
          LDA #$06
          JMP L81C3
          ORA $01
          ASL A
          ORA ($BD,X)
          ASL A
          .BYTE $03    ;%00000011
          AND #$04
          BEQ L9C03
          DEC $030F,X
          BNE L9C03
          LDA #$03
          CMP $0307,X
          BNE L9C40
          LDY $010B
          INY
          BNE L9C03
L9C40     STA $0300,X
          LDA #$50
          STA $030F,X
          LDA #$2C
          STA $0305,X
          SEC
          SBC #$03
          JMP L9CD0
          LDA $50
          BEQ L9C6F
          LDA $030C
          EOR $030C,X
          LSR A
          BCS L9C6F
          LDA $030E
          EOR $030E,X
          BMI L9C6F
          LDA #$04
          STA $0300,X
          BNE L9CC5
L9C6F     LDA $0306,X
          CMP $0305,X
          BCC L9CC5
          LDA $030F,X
          CMP #$50
          BNE L9CA9
          JSR L9D49
          LDA $0307,X
          CMP #$01
          BEQ L9CA9
          CMP #$03
          BEQ L9CA9
          LDA #$0A
          STA $09
          LDA $030C,X
          STA $08
          LDY $4A
          TXA
          JSR L9479
          BCC L9C9E
          DEY
L9C9E     TYA
          JSR L7F94
          LDA #$00
          STA $0300,X
          BEQ L9CC5
L9CA9     LDA $27
          LSR A
          BCS L9CC5
          DEC $030F,X
          BNE L9CC5
L9CB3     LDA #$01
          STA $030F,X
          JSR L9D4D
          LDA #$02
          STA $0300,X
          JSR L9CC8
L9CC3     LDX $45
L9CC5     JMP L9C03
L9CC8     LDA #$30
          STA $0305,X
          SEC
          SBC #$02
L9CD0     JSR L7695
          JMP L6F9A
          LDA $50
          CMP #$05
          BCS L9D15
          JSR L9D4D
          JSR L9CC8
          LDX $45
          LDA $8C
          BEQ L9CF9
          TXA
          JSR L9473
          EOR $8C
          LSR A
          BCC L9CF9
          LDA $70
          EOR #$07
          STA $70
          STA $1C
L9CF9     INC $0300,X
          LDA #$00
          STA $8C
          LDA $0307,X
          CMP #$03
          BNE L9D15
          TXA
          JSR L9479
          BCS L9D12
          JSR L6FBB
          BNE L9D15
L9D12     JSR L6FB7
L9D15     JMP L9CC3
          LDA $50
          CMP #$05
          BNE L9D3F
          TXA
          EOR #$10
          TAX
          LDA #$06
          STA $0300,X
          LDA #$2C
          STA $0305,X
          SEC
          SBC #$03
          JSR L7695
          JSR L6F9A
          JSR L6F3F
          LDX $45
          LDA #$02
          STA $0300,X
L9D3F     JMP L9C03
          LDA $50
          BNE L9D3F
          JMP L9CB3
L9D49     LDA #$FF
          BNE L9D4F
L9D4D     LDA #$4E
L9D4F     PHA
          LDA #$50
          STA $02
          TXA
          JSR L9473
          AND #$01
          TAY
          LDA $9D8C,Y
          STA $03
          LDA $030C,X
          STA $0B
          JSR L8CBF
          LDY #$00
          PLA
L9D6B     STA ($04),Y
          TAX
          TYA
          CLC
          ADC #$20
          TAY
          TXA
          CPY #$C0
          BNE L9D6B
          LDX $45
          TXA
          JSR L9474
          AND #$06
          TAY
          LDA $04
          STA $0056,Y
          LDA $05
          STA $0057,Y
L9D8B     RTS
          INX
          BPL L9D31
          CPY #$20
          TXS
          STA $45A6,X
          JSR LA0E1
          BNE L9D90
          STX $45
          LDA $0500,X
          BEQ L9D8B
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE L9D57
          STA $9DC7,X
          CPY $C79D
          STA $9DF6,X
          INC $0500,X
          LDA #$00
          JSR L9DE0
          LDA #$50
          STA $0507,X
          LDA $0508,X
          STA $00
          LDA $0509,X
          STA $01
          LDA #$02
          JMP L9EC7
          LDA $27
          AND #$03
          BNE L9DEB
          DEC $0507,X
          BNE L9DEB
          INC $0500,X
          LDY $050A,X
          LDA $9DEC,Y
L9DE0     STA $0506,X
          STA $0505,X
          LDA #$00
          STA $0504,X
L9DEB     RTS
          CLC
          .BYTE $1C    ;%00011100
          JSR $0400
          PHP
          .BYTE $0C    ;%00001100
          BPL L9E19
          .BYTE $14    ;%00010100
          LDA #$00
          STA $0500,X
          LDA $0508,X
          CLC
          ADC #$21
          STA $00
          LDA $0509,X
          STA $01
          JSR L9EAF
          LDA $02
          STA $07
          LDA $03
          STA $09
          LDA $01
          LSR A
          LSR A
          AND #$01
L9E19     STA $0B
          LDY #$00
          JSR LA073
          LDA #$04
          CLC
          ADC $0301
          STA $04
          LDA #$04
          CLC
          ADC $0302
          STA $05
          JSR LA0E7
          BCS L9E4E
          JSR LA1FE
          LDA #$50
          STA $68
          JMP L7246
L9E3F     LDA $0503,X
          ASL A
          TAY
          LDA $B7A7,Y
          STA $02
          LDA $B7A8,Y
          STA $03
L9E4E     RTS
L9E4F     LDA $07A0
          CMP #$1F
          BCS L9E4E
          LDX $45
          LDA $0508,X
          STA $00
          LDA $0509,X
          STA $01
          JSR L9E3F
          LDY #$00
          STY $11
          LDA ($02),Y
          TAX
          JSR L9473
          STA $04
          TXA
          AND #$0F
          STA $05
          INY
          STY $10
L9E79     LDX $05
L9E7B     LDY $10
          LDA ($02),Y
          INC $10
          LDY $11
          STA ($00),Y
          INC $11
          DEX
          BNE L9E7B
          LDA $11
          CLC
          ADC #$20
          SEC
          SBC $05
          STA $11
          DEC $04
          BNE L9E79
          LDA $01
          AND #$04
          BEQ L9EA4
          LDA $01
          ORA #$0C
          STA $01
L9EA4     LDA $01
          AND #$2F
          STA $01
          JSR L94E3
          CLC
          RTS
L9EAF     LDA $00
          TAY
          AND #$E0
          STA $02
          LDA $01
          LSR A
          ROR $02
          LSR A
          ROR $02
          TYA
          AND #$1F
          JSR L947A
          STA $03
          RTS
L9EC7     LDX $45
          LDY $0504,X
          BEQ L9ED3
          DEC $0504,X
          BNE L9EF2
L9ED3     STA $0504,X
          LDY $0506,X
          LDA $9EF9,Y
          CMP #$FE
          BEQ L9EF3
          STA $0503,X
          INY
          TYA
          STA $0506,X
          JSR L9E4F
          BCC L9EF2
          LDX $45
          DEC $0506,X
L9EF2     RTS
L9EF3     INC $0500,X
          PLA
          PLA
          RTS
          ASL $07
          BRK
          INC $0607,X
          ORA ($FE,X)
          .BYTE $07    ;%00000111
          ASL $02
          INC $0607,X
          .BYTE $03    ;%00000011
          INC $0607,X
          .BYTE $04    ;%00000100
          INC $0607,X
          ORA $FE
          .BYTE $07    ;%00000111
          ASL $09
          INC $0607,X
          ASL A
          INC $0607,X
          .BYTE $0B    ;%00001011
          INC $0607,X
          PHP
          INC $FFA9,X
          STA $6D
          STA $010F
          LDX #$18
L9F2A     LDA $B0,X
          BEQ L9F68
          CMP #$03
          BEQ L9F68
          JSR LA087
          JSR L7238
          BEQ L9F46
          LDA $6A
          BNE L9F46
          LDY #$00
          JSR LA036
          JSR LA1A1
L9F46     LDY #$D0
L9F48     LDA $0300,Y
          BEQ L9F63
          CMP #$04
          BCC L9F5D
          CMP #$07
          BEQ L9F5D
          CMP #$0A
          BEQ L9F5D
          CMP #$0B
          BNE L9F63
L9F5D     JSR LA036
          JSR LA217
L9F63     JSR LA0DB
          BNE L9F48
L9F68     TXA
          SEC
          SBC #$08
          TAX
          BPL L9F2A
          LDX #$B0
L9F71     LDA $0300,X
          CMP #$02
          BNE L9F85
          LDY #$00
          JSR L7238
          BEQ L9F8A
          JSR L7FF5
          JSR LA164
L9F85     JSR LA0E1
          BMI L9F71
L9F8A     LDX #$50
L9F8C     LDA $B460,X
          BEQ L9F93
          CMP #$03
L9F93     BEQ L9FD2
          JSR LA03F
          LDA $B460,X
          CMP #$05
          BEQ L9FC1
          LDY #$D0
L9FA1     LDA $0300,Y
          BEQ L9FBC
          CMP #$04
          BCC L9FB6
          CMP #$07
          BEQ L9FB6
          CMP #$0A
          BEQ L9FB6
          CMP #$0B
          BNE L9FBC
L9FB6     JSR LA02D
          JSR LA1B7
L9FBC     JSR LA0DB
          BNE L9FA1
L9FC1     LDY #$00
          LDA $6A
          BNE L9FD2
          JSR L7238
          BEQ L9FD2
          JSR LA02D
          JSR LA16F
L9FD2     JSR LA0E1
          BMI L9FDA
          JMP L9F8C
L9FDA     LDX #$00
          JSR LA05F
          LDY #$60
L9FE1     LDA $B460,Y
          BEQ L9FFF
          CMP #$05
          BEQ L9FFF
          LDA $6A
          BNE L9FFF
          JSR L7238
          BEQ L9FFF
          JSR LA0A0
          JSR LA04F
          JSR LA0E7
          JSR LA1DA
L9FFF     JSR LA0DB
          CMP #$C0
          BNE L9FE1
          LDY #$00
          JSR L7238
          BEQ LA02A
          JSR LA073
          LDX #$F0
LA012     LDA $0300,X
          CMP #$07
          BEQ LA01D
          CMP #$0A
          BNE LA023
LA01D     JSR L7FF8
          JSR LA1FE
LA023     JSR LA0E1
          CMP #$C0
          BNE LA012
LA02A     JMP L7246
LA02D     JSR LA0AC
          JSR LA073
          JMP LA0E7
LA036     JSR LA073
          JSR LA0BF
          JMP LA0E7
LA03F     LDA $0400,X
          STA $07
          LDA $0401,X
          STA $09
          LDA $B467,X
          JMP LA06C
LA04F     LDA $0400,Y
          STA $06
          LDA $0401,Y
          STA $08
          LDA $B467,Y
          JMP LA080
LA05F     LDA $030D,X
          STA $07
          LDA $030E,X
          STA $09
          LDA $030C,X
LA06C     EOR $FF
          AND #$01
          STA $0B
          RTS
LA073     LDA $030D,Y
          STA $06
          LDA $030E,Y
          STA $08
          LDA $030C,Y
LA080     EOR $FF
          AND #$01
          STA $0A
          RTS
LA087     LDA $B1,X
          STA $07
          LDA $B2,X
          STA $09
          LDA $B3,X
          JMP LA06C
LA094     LDA $0301,X
          JSR LA0CD
          LDA $0302,X
          JMP LA0C6
LA0A0     LDA $0301,X
          JSR LA0D4
          LDA $0302,X
          JMP LA0B8
LA0AC     LDA $B461,X
          JSR LA0CD
          LDA $B462,X
          JMP LA0C6
LA0B8     CLC
          ADC $B462,Y
          STA $05
          RTS
LA0BF     LDA #$04
          JSR LA0CD
          LDA #$08
LA0C6     CLC
          ADC $0302,Y
          STA $05
          RTS
LA0CD     CLC
          ADC $0301,Y
          STA $04
          RTS
LA0D4     CLC
          ADC $B461,Y
          STA $04
          RTS
LA0DB     TYA
          CLC
          ADC #$10
          TAY
          RTS
LA0E1     TXA
          SEC
          SBC #$10
          TAX
          RTS
LA0E7     LDA #$02
          STA $10
          AND $43
          STA $03
          LDA $07
          SEC
          SBC $06
          STA $00
          LDA $03
          BNE LA111
          LDA $0B
          EOR $0A
          BEQ LA111
          JSR LA14F
          LDA $00
          SEC
          SBC #$10
          STA $00
          BCS LA10E
          DEC $01
LA10E     JMP LA118
LA111     LDA #$00
          SBC #$00
          JSR LA153
LA118     SEC
          LDA $01
          BNE LA14E
          LDA $00
          STA $11
          CMP $04
          BCS LA14E
          ASL $10
          LDA $09
          SEC
          SBC $08
          STA $00
          LDA $03
          BEQ LA13E
          LDA $0B
          EOR $0A
          BEQ LA13E
          JSR LA14F
          JMP LA143
LA13E     SBC #$00
          JSR LA153
LA143     SEC
          LDA $01
          BNE LA14E
          LDA $00
          STA $0F
          CMP $05
LA14E     RTS
LA14F     LDA $0B
          SBC $0A
LA153     STA $01
          BPL LA15C
          JSR L87B4
          INC $10
LA15C     RTS
LA15D     ORA $030A,X
          STA $030A,X
          RTS
LA164     BCS LA16E
LA166     LDA $10
LA168     ORA $030A,Y
          STA $030A,Y
LA16E     RTS
LA16F     BCS LA16E
          JSR LA1D5
          JSR L7150
          LDY #$00
          BCC LA19A
          LDA $B460,X
          CMP #$04
          BCS LA16E
          LDA $B46E,X
LA185     STA $010F
          TAY
          BMI LA192
          LDA $B683,Y
          AND #$10
          BNE LA16E
LA192     LDY #$00
          JSR LA225
          JMP LA1F3
LA19A     LDA #$81
          STA $040E,X
          BNE LA1C2
LA1A1     BCS LA1B6
          JSR L7150
          LDY #$00
          LDA #$C0
          BCS LA185
LA1AC     LDA $B6,X
          AND #$F8
          ORA $10
          EOR #$03
          STA $B6,X
LA1B6     RTS
LA1B7     BCS LA1CB
          LDA $0300,Y
          STA $040E,X
          JSR LA166
LA1C2     JSR LA21F
LA1C5     ORA $0404,X
          STA $0404,X
LA1CB     RTS
LA1CC     LDA $10
          ORA $0404,Y
          STA $0404,Y
          RTS
LA1D5     JSR LA22D
          BNE LA1C5
LA1DA     BCS LA1FD
          JSR LA1CC
          TYA
          PHA
          JSR L7150
          PLA
          TAY
          BCC LA1FD
          LDA #$80
          STA $010F
          JSR LA21F
          JSR LA15D
LA1F3     LDA $B5C6
          STA $68
          LDA $B5C7
          STA $69
LA1FD     RTS
LA1FE     BCS LA216
          LDA #$E0
          STA $010F
          JSR LA225
          LDA $0F
LA20A     BEQ LA20E
          LDA #$01
LA20E     STA $6D
LA210     LDA #$00
          STA $68
          STA $69
LA216     RTS
LA217     BCS LA216
          JSR LA166
          JMP LA1AC
LA21F     JSR LA22D
          JMP L947A
LA225     LDA $10
          ASL A
          ASL A
          ASL A
          JMP LA168
LA22D     LDA $10
          EOR #$03
          RTS
LA232     LDX #$50
LA234     JSR LA23E
          LDX $45
          JSR LA0E1
          BNE LA234
LA23E     STX $45
          LDY $B460,X
          BEQ LA24C
          CPY #$03
          BCS LA24C
          JSR LA26C
LA24C     JSR LA297
          LDA $B460,X
          STA $7C
          CMP #$07
          BCS LA269
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE LA209
          LDX #$D3
          LDX #$FA
          LDX #$2B
          .BYTE $A3    ;%10100011
          BVS LA20A
          .BYTE $DB    ;%11011011
          .BYTE $A3    ;%10100011
LA269     JMP LA905
LA26C     LDA $0405,X
          AND #$02
          BNE LA294
          LDA $0400,X
          STA $0A
          LDA $0401,X
          STA $0B
          LDA $B467,X
          STA $06
          LDA $B461,X
          STA $08
          LDA $B462,X
          STA $09
          JSR L8356
          TXA
          BNE LA294
          PLA
          PLA
LA294     LDX $45
          RTS
LA297     LDA $0405,X
          ASL A
          ROL A
          TAY
          TXA
LA29E     JSR L9473
          EOR $27
          LSR A
          TYA
          ROR A
          ROR A
          STA $0405,X
          RTS
          LDA $0405,X
          ASL A
          BMI LA2D0
          LDA #$00
          STA $B46D,X
          STA $0406,X
          STA $040A,X
          JSR LA5A6
          JSR LA648
          JSR LA56F
          JSR LA563
          LDA $0409,X
          BEQ LA2D0
          JSR LA6A7
LA2D0     JMP LA2F7
          LDA $0405,X
          ASL A
          BMI LA2F7
          LDA $0405,X
          AND #$20
          BEQ LA2EE
          LDY $B46E,X
          LDA $B6B3,Y
          STA $0409,X
          DEC $B460,X
          BNE LA2F7
LA2EE     JSR LA5A6
          JSR LA648
          JSR LA40B
LA2F7     JSR LA423
          JMP $B5DD
LA2FD     JSR L840B
          JSR LAD08
LA303     LDX $45
          LDA $040F,X
          BPL LA312
          LDA $65
          BMI LA312
          LDA #$A3
LA310     STA $65
LA312     LDA $B460,X
          BEQ LA31A
          JSR L8107
LA31A     LDX $45
          LDA #$00
          STA $0404,X
          STA $040E,X
          RTS
LA325     JSR L840B
          JMP LA303
          JSR LA423
          LDA $B460,X
          CMP #$03
          BEQ LA2FD
          BIT $65
          BMI LA33D
          LDA #$A1
          STA $65
LA33D     LDA $27
          AND #$07
          BNE LA35E
          DEC $040D,X
          BNE LA35E
          LDA $B460,X
          CMP #$03
          BEQ LA35E
          LDA $040C,X
          STA $B460,X
          LDY $B46E,X
          LDA $B693,Y
          STA $040D,X
LA35E     LDA $040D,X
          CMP #$0B
          BCS LA36D
          LDA $27
          AND #$02
          BEQ LA36D
          ASL $65
LA36D     JMP LA303
          LDA $0404,X
          AND #$24
          BEQ LA3C1
          JSR LA905
          LDY $B463,X
          CPY #$80
          BEQ LA3A4
          TYA
          PHA
          LDA $B46E,X
          PHA
          LDY #$00
          LDX #$03
          PLA
          BNE LA399
          DEX
          PLA
          CMP #$81
          BNE LA398
          LDX #$00
          LDY #$50
LA398     PHA
LA399     PLA
          STY $68
          STX $69
          JSR L72AD
          JMP L6F7C
LA3A4     LDA #$02
          LDY $B46E,X
          BEQ LA3AD
          LDA #$1E
LA3AD     CLC
          ADC $B412
          BCS LA3B8
          CMP $B413
          BCC LA3BB
LA3B8     LDA $B413
LA3BB     STA $B412
          JMP L6F80
LA3C1     LDA $27
          AND #$03
          BNE LA3CF
          DEC $040D,X
          BNE LA3CF
          JSR LA905
LA3CF     LDA $27
          AND #$02
          LSR A
          ORA #$A0
          STA $65
          JMP LA303
          DEC $040F,X
          BNE LA3FD
          LDA $040C,X
          TAY
          AND #$C0
          STA $040F,X
          TYA
          AND #$3F
          STA $B460,X
          PHA
          JSR LAD60
          AND #$20
          BEQ LA3FC
          PLA
          JSR LA402
          PHA
LA3FC     PLA
LA3FD     LDA #$A0
          JMP LA310
LA402     STA $040C,X
LA405     LDA #$04
          STA $B460,X
          RTS
LA40B     LDA $43
          LDX $45
          CMP #$02
          BCC LA458
          LDA $0400,X
          CMP #$EC
          BCC LA458
          JMP LA905
LA41D     JSR L6F92
          JMP LA560
LA423     LDA $040F,X
          STA $0A
          LDA $0404,X
          AND #$20
          BEQ LA458
          LDA $040E,X
          CMP #$03
          BNE LA466
          BIT $0A
          BVS LA466
          LDA $B460,X
          CMP #$04
          BEQ LA466
          JSR LA402
          LDA #$40
          STA $040D,X
          JSR LAD60
          AND #$20
          BEQ LA458
          LDA #$05
          STA $040B,X
          JMP $B5A0
LA458     RTS
LA459     JSR LAD60
          AND #$20
          BNE LA41D
          JSR L6F78
          JMP LA31A
LA466     LDA $040B,X
          CMP #$FF
          BEQ LA459
          BIT $0A
          BVC LA476
          JSR L6F96
          BNE LA497
LA476     JSR LA638
          AND #$0C
          BEQ LA48A
          CMP #$04
          BEQ LA48F
          CMP #$08
          BEQ LA494
          JSR L6F92
          BNE LA497
LA48A     JSR L6F70
          BNE LA497
LA48F     JSR L6F70
          BNE LA497
LA494     JSR L6F8E
LA497     LDX $45
          JSR LAD60
          AND #$20
          BEQ LA4A7
          LDA $040E,X
          CMP #$0B
          BNE LA459
LA4A7     LDA $B460,X
          CMP #$04
          BNE LA4B1
          LDA $040C,X
LA4B1     ORA $0A
          STA $040C,X
          ASL A
          BMI LA4CB
          JSR LAD60
          AND #$20
          BNE LA4CB
          LDY $040E,X
          CPY #$0B
          BEQ LA4FE
          CPY #$81
          BEQ LA4FE
LA4CB     LDA #$06
          STA $B460,X
          LDA #$0A
          BIT $0A
          BVC LA4D8
          LDA #$03
LA4D8     STA $040F,X
          CPY #$02
          BEQ LA4F4
          BIT $0A
          BVC LA4F9
          LDY $040E,X
          CPY #$0B
          BNE LA4F9
          DEC $040B,X
          BEQ LA4FE
          DEC $040B,X
          BEQ LA4FE
LA4F4     DEC $040B,X
          BEQ LA4FE
LA4F9     DEC $040B,X
          BNE LA560
LA4FE     LDA #$03
          STA $B460,X
          BIT $0A
          BVS LA515
          LDA $040E,X
          CMP #$02
          BCS LA515
          LDA #$00
          JSR L8078
          LDX $45
LA515     JSR LA731
          LDA $B603,Y
          JSR LA57A
          STA $0406,X
          LDX #$C0
LA523     LDA $B460,X
          BEQ LA533
          TXA
          CLC
          ADC #$08
          TAX
          CMP #$E0
          BNE LA523
          BEQ LA560
LA533     LDA $B5D5
          JSR LA57A
          LDA #$0A
          STA $0406,X
          INC $B460,X
          LDA #$00
          BIT $0A
          BVC LA549
          LDA #$03
LA549     STA $0407,X
          LDY $45
          LDA $0400,Y
          STA $0400,X
          LDA $0401,Y
          STA $0401,X
          LDA $B467,Y
          STA $B467,X
LA560     LDX $45
          RTS
LA563     JSR LAD60
          ASL A
          ASL A
          ASL A
          AND #$C0
          STA $B46F,X
          RTS
LA56F     JSR LA731
          LDA $B633,Y
          CMP $B465,X
          BEQ LA585
LA57A     STA $B465,X
LA57D     STA $B466,X
LA580     LDA #$00
          STA $B464,X
LA585     RTS
LA586     JSR LA731
          LDA $B653,Y
          CMP $B465,X
          BEQ LA5A5
          JSR LA57A
          LDY $B46E,X
          LDA $B673,Y
          AND #$7F
          BEQ LA5A5
          TAY
LA59F     DEC $B466,X
          DEY
          BNE LA59F
LA5A5     RTS
LA5A6     LDA #$00
          STA $7D
          JSR LA638
          TAY
          LDA $B460,X
          CMP #$02
          BNE LA5BA
          TYA
          AND #$02
          BEQ LA5A5
LA5BA     TYA
          DEC $040D,X
          BNE LA5A5
          PHA
          LDY $B46E,X
          LDA $B693,Y
          STA $040D,X
          PLA
          BPL LA5FC
          LDA #$FE
          JSR LA6A0
          LDA $43
          CMP #$02
          BCC LA5E2
          JSR LA63F
          BCC LA5E2
          TYA
          EOR $FF
          BCS LA5ED
LA5E2     LDA $0401,X
          CMP $030E
          BNE LA5EC
          INC $7D
LA5EC     ROL A
LA5ED     AND #$01
          JSR LA631
          LSR A
          ROR A
          EOR $0403,X
          BPL LA5FC
          JSR LAE8A
LA5FC     LDA #$FB
          JSR LA6A0
          LDA $43
          CMP #$02
          BCS LA611
          JSR LA63F
          BCC LA611
          TYA
          EOR $FF
          BCS LA61E
LA611     LDA $0400,X
          CMP $030D
          BNE LA61D
          INC $7D
          INC $7D
LA61D     ROL A
LA61E     AND #$01
          ASL A
          ASL A
          JSR LA631
          LSR A
          LSR A
          LSR A
          ROR A
          EOR $0402,X
          BPL LA637
          JMP LAEBF
LA631     ORA $0405,X
          STA $0405,X
LA637     RTS
LA638     LDY $B46E,X
          LDA $B683,Y
          RTS
LA63F     LDA $B467,X
          TAY
          EOR $030C
          LSR A
          RTS
LA648     LDA #$E7
          STA $06
          LDA #$18
          JSR LA631
          LDY $B46E,X
          LDA $B6A3,Y
          BEQ LA6A6
          TAY
          LDA $0405,X
          AND #$02
          BEQ LA69E
          TYA
          LDY #$F7
          ASL A
          BCS LA669
          LDY #$EF
LA669     LSR A
          STA $02
          STY $06
          LDA $030D
          STA $00
          LDY $0400,X
          LDA $0405,X
          BMI LA683
          LDY $030E
          STY $00
          LDY $0401,X
LA683     LDA $030C
          LSR A
          ROR $00
          LDA $B467,X
          LSR A
          TYA
          ROR A
          SEC
          SBC $00
          BPL LA697
          JSR L8001
LA697     LSR A
          LSR A
          LSR A
          CMP $02
          BCC LA6A6
LA69E     LDA $06
LA6A0     AND $0405,X
          STA $0405,X
LA6A6     RTS
LA6A7     DEC $0409,X
          BNE LA6B6
          LDA $0405,X
          AND #$08
          BNE LA6B7
          INC $0409,X
LA6B6     RTS
LA6B7     LDA $B46E,X
          CMP #$07
          BNE LA6C3
          JSR L6F64
          LDX $45
LA6C3     INC $B460,X
          JSR LA586
          LDY $B46E,X
          LDA $B6C3,Y
          CLC
          ADC #$C9
          STA $00
          LDA #$00
          ADC #$B7
          STA $01
          LDA $27
          EOR $28
          LDY #$00
          AND ($00),Y
          TAY
          INY
          LDA ($00),Y
          STA $0408,X
          JSR LAD60
          BPL LA726
          LDA #$00
          STA $0406,X
          STA $0407,X
          LDY $0408,X
          LDA $B723,Y
          STA $B46A,X
          LDA $B737,Y
          STA $B46B,X
          LDA $B74B,Y
          STA $0402,X
          LDA $B75F,Y
          STA $0403,X
          LDA $0405,X
          BMI LA71F
          LSR A
          BCC LA726
          JSR LAE81
          JMP LA726
LA71F     AND #$04
          BEQ LA726
          JSR LAEB6
LA726     LDA #$DF
          JMP LA6A0
LA72B     LDA $0405,X
          JMP LA738
LA731     LDA $0405,X
          BPL LA738
          LSR A
          LSR A
LA738     LSR A
          LDA $B46E,X
          ROL A
          TAY
          RTS
LA73F     TXA
          LSR A
          LSR A
          LSR A
          ADC $27
          LSR A
          RTS
LA747     LDY $B46E,X
          LDA $B693,Y
          STA $040D,X
          LDA $B623,Y
          LDY $040F,X
          BPL LA759
          ASL A
LA759     STA $040B,X
LA75C     RTS
LA75D     LDA $0405,X
          AND #$10
          BEQ LA75C
          LDA $82
          AND $B460,X
          BEQ LA75C
          LDA $82
          BPL LA774
          LDY $B46D,X
          BNE LA75C
LA774     JSR LA7D5
          BCS LA7E4
          STA $0404,Y
          JSR LA819
          LDA $0405,X
          LSR A
          LDA $80
          PHA
          ROL A
          TAX
          LDA $B783,X
          PHA
          TYA
          TAX
          PLA
          JSR LA57A
          LDX $45
          LDA #$01
          STA $B460,Y
          AND $0405,X
          TAX
          LDA $A817,X
          STA $0403,Y
          LDA #$00
          STA $0402,Y
          LDX $45
          JSR LA7E5
          LDA $0405,X
          LSR A
          PLA
          TAX
          LDA $B79B,X
          STA $04
          TXA
          ROL A
          TAX
          LDA $B793,X
          STA $05
          JSR LA80A
          LDX $45
          BIT $82
          BVC LA7E4
          LDA $0405,X
          AND #$01
          TAY
          LDA $007E,Y
          JMP LA57D
LA7D5     LDY #$60
          CLC
LA7D8     LDA $B460,Y
          BEQ LA7E4
          JSR LA0DB
          CMP #$C0
          BNE LA7D8
LA7E4     RTS
LA7E5     LDA $80
          CMP #$02
          BCC LA809
          LDX $45
          LDA $0405,X
          LSR A
          LDA $83
          ROL A
          AND #$07
          STA $040A,Y
          LDA #$02
          STA $B460,Y
          LDA #$00
          STA $0409,Y
          STA $B464,Y
          STA $0408,Y
LA809     RTS
LA80A     LDX $45
          JSR L8AFD
          TYA
          TAX
          JSR LAC7C
          JMP LA936
          .BYTE $02    ;%00000010
          INC $02A9,X
          STA $B461,Y
          STA $B462,Y
          ORA $0405,Y
          STA $0405,Y
          RTS
LA828     LDX #$B0
LA82A     JSR LA836
          LDX $45
          JSR LA0E1
          CMP #$60
          BNE LA82A
LA836     STX $45
          LDA $0405,X
          AND #$02
          BNE LA842
          JSR LA905
LA842     LDA $B460,X
          BEQ LA856
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE LA8A4
          TAY
          ROR $7FA8,X
          BNE LA8AB
          LDA #$7E
          LDA #$60
          JSR LA948
          JSR LA90B
          LDX $45
          BCS LA869
          LDA $B460,X
          BEQ LA856
          JSR LA94D
LA869     LDA #$01
LA86B     JSR L840B
          JMP L8107
LA871     INC $0408,X
LA874     INC $0408,X
          LDA #$00
          STA $0409,X
          BEQ LA891
          JSR LA948
          LDA $040A,X
          AND #$FE
          TAY
          LDA $B79F,Y
          STA $0A
          LDA $B7A0,Y
          STA $0B
LA891     LDY $0408,X
          LDA ($0A),Y
          CMP #$FF
          BNE LA8A0
          STA $0408,X
          JMP LA874
LA8A0     CMP $0409,X
          BEQ LA871
          INC $0409,X
          INY
          LDA ($0A),Y
LA8AB     JSR LAF46
          LDX $45
          STA $0402,X
          LDA ($0A),Y
          JSR LAFDF
          LDX $45
          STA $0403,X
          TAY
          LDA $040A,X
          LSR A
          PHP
          BCC LA8CC
          TYA
          JSR L8001
          STA $0403,X
LA8CC     PLP
          BNE LA8DF
          LDA $0402,X
          BEQ LA8DF
          BMI LA8DF
          LDY $040A,X
          LDA $B5D8,Y
          STA $B465,X
LA8DF     JSR LA90B
          LDX $45
          BCS LA902
          LDA $B460,X
          BEQ LA957
          LDY #$00
          LDA $040A,X
          LSR A
          BEQ LA8F4
          INY
LA8F4     LDA $B5DA,Y
          JSR LA57A
          JSR LA405
          LDA #$0A
          STA $0409,X
LA902     JMP LA869
LA905     LDA #$00
          STA $B460,X
          RTS
LA90B     LDA $6E
          CMP #$11
          BNE LA917
          LDA $B460,X
          LSR A
          BCC LA924
LA917     JSR LA96A
          LDY #$00
          LDA ($04),Y
          CMP #$A0
          BCC LA947
          LDX $45
LA924     LDA $0403,X
          STA $05
          LDA $0402,X
          STA $04
LA92E     JSR L8AFD
          JSR LAC7C
          BCC LA905
LA936     LDA $08
          STA $0400,X
          LDA $09
          STA $0401,X
          LDA $0B
          AND #$01
          STA $B467,X
LA947     RTS
LA948     LDA $0404,X
          BEQ LA957
LA94D     LDA #$00
          STA $0404,X
          LDA #$05
          STA $B460,X
LA957     RTS
          LDA $B463,X
          CMP #$F7
          BEQ LA964
          DEC $0409,X
          BNE LA967
LA964     JSR LA905
LA967     JMP LA869
LA96A     LDX $45
          LDA $0400,X
          STA $02
          LDA $0401,X
          STA $03
          LDA $B467,X
          STA $0B
          JMP L8CBF
          JSR LA905
          LDA $B5D4
          JSR LA57A
          JMP LA869
LA98A     LDX #$C0
LA98C     STX $45
          LDA $B460,X
          BEQ LA996
          JSR LA9A1
LA996     LDA $45
          CLC
          ADC #$08
          TAX
          CMP #$E0
          BNE LA98C
LA9A0     RTS
LA9A1     DEC $0406,X
          BNE LA9B5
          LDA #$0C
          STA $0406,X
          DEC $0407,X
          BMI LA9B2
          BNE LA9B5
LA9B2     JSR LA905
LA9B5     LDA $0406,X
          CMP #$09
          BNE LA9CE
          LDA $0407,X
          ASL A
          TAY
          LDA $A9D7,Y
          STA $04
          LDA $A9D8,Y
          STA $05
          JSR LA92E
LA9CE     LDA #$80
          STA $65
          LDA #$03
          JMP LA86B
          BRK
          BRK
          .BYTE $0C    ;%00001100
          .BYTE $1C    ;%00011100
          BPL LA9CD
          BEQ LA9E7
LA9DF     LDY #$18
LA9E1     JSR LA9EC
          LDA $45
          SEC
LA9E7     SBC #$08
          TAY
          BNE LA9E1
LA9EC     STY $45
          LDX $0728,Y
          INX
          BEQ LA9A0
          LDX $0729,Y
          LDA $B460,X
          BEQ LAA03
          LDA $0405,X
          AND #$02
          BNE LAA74
LAA03     STA $0404,X
          LDA #$FF
          CMP $B46E,X
          BNE LAA5D
          DEC $0409,X
          BNE LAA74
          LDA $0728,Y
          JSR L8E7D
          LDY $45
          LDA $072A,Y
          STA $0400,X
          LDA $072B,Y
          STA $0401,X
          LDA $072C,Y
          STA $B467,X
          LDA #$18
          STA $B462,X
          LDA #$0C
          STA $B461,X
          LDY #$00
          JSR LA073
          JSR LA03F
          JSR LA0AC
          JSR LA0E7
          BCC LAA74
          LDA #$01
          STA $0409,X
          STA $B460,X
          AND $43
          ASL A
          STA $0405,X
          LDY $B46E,X
          JSR LAA68
          JMP LA747
LAA5D     STA $B46E,X
          LDA #$01
          STA $0409,X
          JMP LA905
LAA68     JSR LAD60
          ROR $0405,X
          LDA $B6B3,Y
          STA $0409,X
LAA74     RTS
LAA75     LDX $45
          JSR LA731
          LDA $B46D,X
          INC $B46F,X
          DEC $B46F,X
          BNE LAA87
          PHA
          PLA
LAA87     BPL LAA8C
          JSR L8001
LAA8C     CMP #$08
          BCC LAAAC
          CMP #$10
          BCS LAA74
          TYA
          AND #$01
          TAY
          LDA $0080,Y
          CMP $B465,X
          BEQ LAA74
          STA $B466,X
          DEC $B466,X
LAAA6     STA $B465,X
          JMP LA580
LAAAC     LDA $B633,Y
          CMP $B465,X
          BEQ LAA74
          JMP LA57A
LAAB7     LDX $45
          JSR LA731
          LDA $B653,Y
          CMP $B465,X
          BEQ LAA74
          STA $B465,X
          JMP LA57D
LAACA     LDA #$40
          STA $45
          LDX #$0C
LAAD0     JSR LAAD9
          DEX
          DEX
          DEX
          DEX
          BNE LAAD0
LAAD9     LDA $A0,X
          BEQ LAB44
          DEC $A0,X
          TXA
          LSR A
          TAY
          LDA $AB4A,Y
          STA $04
          LDA $AB4B,Y
          STA $05
          LDA $A1,X
          STA $08
          LDA $A2,X
          STA $09
          LDA $A3,X
          STA $0B
          JSR LAC7C
          BCC LAB45
          LDA $08
          STA $A1,X
          STA $034D
          LDA $09
          STA $A2,X
          STA $034E
          LDA $0B
          AND #$01
          STA $A3,X
          STA $034C
          LDA $A3,X
          STA $034C
          LDA #$5A
          STA $0343
          TXA
LAB1F     PHA
          JSR L81C6
          LDA $6A
          BNE LAB42
          LDY #$00
          LDX #$40
          JSR L7FF5
          BCS LAB42
          JSR L7150
          LDY #$00
          BCC LAB42
          CLC
          JSR LA1FE
          LDA #$50
          STA $68
          JSR L7246
LAB42     PLA
          TAX
LAB44     RTS
LAB45     LDA #$00
          STA $A0,X
          RTS
          BRK
          .BYTE $FB    ;%11111011
          .BYTE $FB    ;%11111011
          INC $02FB,X
          BRK
          ORA $AD
          BVC LAB0A
          BEQ LAB81
          LDX #$F0
          STX $45
          LDA $B555
          CMP $B5DC
          BNE LAB82
          LDA #$03
          JSR L840B
          LDA $28
          STA $85
          LDA #$18
LAB6E     PHA
          TAX
          JSR LAB85
          PLA
          TAX
          LDA $B6,X
          AND #$F8
          STA $B6,X
          TXA
          SEC
          SBC #$08
          BPL LAB6E
LAB81     RTS
LAB82     JMP LA905
LAB85     LDA $B0,X
          JSR L9449
          .BYTE $7F    ;%01111111
          BNE LAB1F
          .BYTE $AB    ;%10101011
          .BYTE $9E    ;%10011110
          .BYTE $AB    ;%10101011
          .BYTE $A7    ;%10100111
          .BYTE $AB    ;%10101011
          JSR LAC71
          JSR LABF5
          JSR LAC12
          JMP L8107
          JSR LAC71
          JSR LABAE
          JMP L8107
          LDA #$00
          STA $B0,X
          JMP L6F70
LABAE     JSR LAC4C
          LDA $B4,X
          CMP #$02
          BCS LABC2
          LDY $08
          CPY $030D
          BCC LABC2
          ORA #$02
          STA $B4,X
LABC2     LDY #$01
          LDA $B4,X
          LSR A
          BCC LABCB
          LDY #$FF
LABCB     STY $05
          LDY #$04
          LSR A
          LDA $B5,X
          BCC LABD6
          LDY #$FD
LABD6     STY $04
          INC $B5,X
          JSR LAC7C
          BCS LABE5
          LDA $B4,X
          ORA #$02
          STA $B4,X
LABE5     BCC LABEA
          JSR LAC59
LABEA     LDA $B5,X
          CMP #$50
          BCC LABF4
          LDA #$01
          STA $B0,X
LABF4     RTS
LABF5     LDA #$00
          STA $B5,X
          TAY
          LDA $030E
          SEC
          SBC $B2,X
          BPL LAC06
          INY
          JSR L8001
LAC06     CMP #$10
          BCS LAC11
          TYA
          STA $B4,X
          LDA #$02
          STA $B0,X
LAC11     RTS
LAC12     TXA
          LSR A
          LSR A
          LSR A
          ADC $85
          STA $85
          LSR $85
          AND #$03
          TAY
          LDA $AC47,Y
          STA $04
          LDA $AC48,Y
          STA $05
          JSR LAC4C
          LDA $08
          SEC
          SBC $FC
          TAY
          LDA #$02
          CPY #$20
          BCC LAC3F
          JSR L8001
          CPY #$80
          BCC LAC41
LAC3F     STA $04
LAC41     JSR LAC7C
          JMP LAC59
          .BYTE $02    ;%00000010
          INC $FF01,X
          .BYTE $02    ;%00000010
LAC4C     LDA $B3,X
          STA $0B
          LDA $B1,X
          STA $08
          LDA $B2,X
          STA $09
          RTS
LAC59     LDA $08
          STA $B1,X
          STA $04F0
          LDA $09
          STA $B2,X
          STA $04F1
          LDA $0B
          AND #$01
          STA $B3,X
          STA $B557
          RTS
LAC71     LDA $B6,X
          AND #$04
          BEQ LAC7B
          LDA #$03
          STA $B0,X
LAC7B     RTS
LAC7C     LDA $43
          AND #$02
          STA $02
          LDA $04
          CLC
          BMI LAC9E
          BEQ LACAC
          ADC $08
          BCS LAC91
          CMP #$F0
          BCC LAC99
LAC91     ADC #$0F
          LDY $02
          BNE LACCE
          INC $0B
LAC99     STA $08
          JMP LACAC
LAC9E     ADC $08
          BCS LACAA
          SBC #$0F
          LDY $02
          BNE LACCE
          INC $0B
LACAA     STA $08
LACAC     LDA $05
          CLC
          BMI LACC0
          BEQ LACCC
          ADC $09
          BCC LACBD
          LDY $02
          BEQ LACCE
          INC $0B
LACBD     JMP LACCA
LACC0     ADC $09
          BCS LACCA
          LDY $02
          BEQ LACCE
          INC $0B
LACCA     STA $09
LACCC     SEC
          RTS
LACCE     CLC
LACCF     RTS
LACD0     LDA $010B
          CMP #$99
          BNE LACE6
          CLC
          SBC $010A
          BNE LACE6
          STA $06
          LDA #$38
          STA $07
          JSR L7FCA
LACE6     LDX #$20
LACE8     JSR LACF2
          TXA
          SEC
          SBC #$08
          TAX
          BNE LACE8
LACF2     LDA $0758,X
          SEC
          SBC #$02
          BNE LACCF
          STA $06
          INC $0758,X
          TXA
          LSR A
          ADC #$3C
          STA $07
          JMP L7FCA
LAD08     LDX $45
          LDA $0405,X
          ASL A
          BMI LAD5F
          LDA $B460,X
          CMP #$02
          BNE LAD5F
          JSR LAEF4
          LDA $00
          BPL LAD2D
          JSR L8001
          STA $60
LAD23     JSR LB0A5
          JSR LAD68
          DEC $60
          BNE LAD23
LAD2D     BEQ LAD3B
          STA $60
LAD31     JSR LB0FB
          JSR LADAB
          DEC $60
          BNE LAD31
LAD3B     JSR LAFC8
          LDA $00
          BPL LAD51
          JSR L8001
          STA $60
LAD47     JSR LB157
          JSR LAE1E
          DEC $60
          BNE LAD47
LAD51     BEQ LAD5F
          STA $60
LAD55     JSR LB1AE
          JSR LADE4
          DEC $60
          BNE LAD55
LAD5F     RTS
LAD60     LDY $B46E,X
          LDA $B773,Y
          ASL A
          RTS
LAD68     LDX $45
          BCS LADAA
          LDA $0405,X
          BPL LAD77
LAD71     JSR LAEAC
          JMP LADA6
LAD77     JSR LAD60
          BPL LAD9A
          LDA $B46F,X
          BEQ LAD71
          BPL LAD88
          JSR LAE61
          BEQ LAD92
LAD88     SEC
          ROR $0402,X
          ROR $0406,X
          JMP LADA6
LAD92     STA $0402,X
          STA $0406,X
          BEQ LADA6
LAD9A     LDA $B773,Y
          LSR A
          LSR A
          BCC LADA6
          LDA #$04
          JSR LB21B
LADA6     LDA #$01
          STA $60
LADAA     RTS
LADAB     LDX $45
          BCS LADE3
          LDA $0405,X
          BPL LADBA
LADB4     JSR LAEAC
          JMP LADDF
LADBA     JSR LAD60
          BPL LADD3
          LDA $B46F,X
          BEQ LADB4
          BPL LADD0
          CLC
          ROR $0402,X
          ROR $0406,X
          JMP LADDF
LADD0     JSR LAE61
LADD3     LDA $B773,Y
          LSR A
          LSR A
          BCC LADDF
          LDA #$04
          JSR LB21B
LADDF     LDA #$01
          STA $60
LADE3     RTS
LADE4     LDX $45
          BCS LAE1D
          JSR LAD60
          BPL LAE0E
          LDA $0405,X
          BMI LADF8
LADF2     JSR LAE77
          JMP LAE19
LADF8     LDA $B46F,X
          BEQ LADF2
          BPL LAE09
          CLC
          ROR $0403,X
          ROR $0407,X
          JMP LAE19
LAE09     JSR LAE70
          BEQ LAE19
LAE0E     LDA $B773,Y
          LSR A
          BCC LAE19
          LDA #$01
          JSR LB21B
LAE19     LDA #$01
          STA $60
LAE1D     RTS
LAE1E     LDX $45
          BCS LAE60
          JSR LAD60
          BPL LAE50
          LDA $0405,X
          BMI LAE32
LAE2C     JSR LAE77
          JMP LAE5C
LAE32     LDA $B46F,X
          BEQ LAE2C
          BPL LAE3E
          JSR LAE70
          BEQ LAE48
LAE3E     SEC
          ROR $0403,X
          ROR $0407,X
          JMP LAE5C
LAE48     STA $0403,X
          STA $0407,X
          BEQ LAE5C
LAE50     JSR LAD60
          LSR A
          LSR A
          BCC LAE5C
          LDA #$01
          JSR LB21B
LAE5C     LDA #$01
          STA $60
LAE60     RTS
LAE61     JSR LAE68
          STA $B46A,X
          RTS
LAE68     LDA #$20
          JSR LA631
          LDA #$00
          RTS
LAE70     JSR LAE68
          STA $B46B,X
          RTS
LAE77     JSR LAEA6
          BNE LAEA5
          LDA #$01
          JSR LB21B
LAE81     LDA $B46B,X
          JSR L8001
          STA $B46B,X
LAE8A     JSR LAEA6
          BNE LAEA5
          JSR LAD60
          SEC
          BPL LAE9D
          LDA #$00
          SBC $0407,X
          STA $0407,X
LAE9D     LDA #$00
          SBC $0403,X
          STA $0403,X
LAEA5     RTS
LAEA6     JSR LA638
          AND #$20
          RTS
LAEAC     JSR LAEA6
          BNE LAEA5
          LDA #$04
          JSR LB21B
LAEB6     LDA $B46A,X
          JSR L8001
          STA $B46A,X
LAEBF     JSR LAEA6
          BNE LAEDA
          JSR LAD60
          SEC
          BPL LAED2
          LDA #$00
          SBC $0406,X
          STA $0406,X
LAED2     LDA #$00
          SBC $0402,X
          STA $0402,X
LAEDA     RTS
LAEDB     LDA $0405,X
          BPL LAEE2
          LSR A
          LSR A
LAEE2     LSR A
          LDA $0408,X
          ROL A
          ASL A
          TAY
          LDA $B6D3,Y
          STA $7C
          LDA $B6D4,Y
          STA $7D
          RTS
LAEF4     JSR LAD60
          BPL LAEFC
          JMP LAFEF
LAEFC     LDA $0405,X
          AND #$20
          EOR #$20
          BEQ LAF52
          JSR LAEDB
LAF08     LDY $0406,X
LAF0B     LDA ($7C),Y
          CMP #$F0
          BCC LAF2F
          CMP #$FA
          BEQ LAF2C
          CMP #$FB
          BEQ LAF60
          CMP #$FC
          BEQ LAF63
          CMP #$FD
          BEQ LAF55
          CMP #$FE
          BEQ LAF8E
          LDA #$00
          STA $0406,X
          BEQ LAF08
LAF2C     JMP LAFC2
LAF2F     SEC
          SBC $0409,X
          BNE LAF40
          STA $0409,X
          INY
          INY
          TYA
          STA $0406,X
          BNE LAF0B
LAF40     INC $0409,X
          INY
          LDA ($7C),Y
LAF46     ASL A
          PHP
          JSR L9472
          PLP
          BCC LAF52
          EOR #$FF
          ADC #$00
LAF52     STA $00
          RTS
LAF55     INC $0406,X
          INY
          LDA #$00
          STA $B46D,X
          BEQ LAF0B
LAF60     PLA
          PLA
          RTS
LAF63     LDA $B46F,X
          BPL LAF6E
          JSR L8ADB
          JMP LAF73
LAF6E     BEQ LAF82
          JSR L8AE6
LAF73     LDX $45
          BCS LAF82
          LDY $0406,X
          INY
          LDA #$00
          STA $B46F,X
          BEQ LAF87
LAF82     LDY $0406,X
          DEY
          DEY
LAF87     TYA
          STA $0406,X
          JMP LAF0B
LAF8E     DEY
          DEY
          TYA
          STA $0406,X
          LDA $B46F,X
          BPL LAF9F
          JSR L8ADB
          JMP LAFA4
LAF9F     BEQ LAFAB
          JSR L8AE6
LAFA4     LDX $45
          BCC LAFAB
          JMP LAF08
LAFAB     LDY $B46E,X
          LDA $B683,Y
          AND #$20
          BEQ LAFC2
          LDA $0405,X
          EOR #$05
          ORA $B683,Y
          AND #$1F
          STA $0405,X
LAFC2     JSR LAE61
          JMP LAF52
LAFC8     JSR LAD60
          BPL LAFD0
          JMP LB045
LAFD0     LDA $0405,X
          AND #$20
          EOR #$20
          BEQ LAFEC
          LDY $0406,X
          INY
          LDA ($7C),Y
LAFDF     TAX
          AND #$08
          PHP
          TXA
          AND #$07
          PLP
          BEQ LAFEC
          JSR L8001
LAFEC     STA $00
          RTS
LAFEF     LDY #$0E
          LDA $B46A,X
          BMI LB00E
          CLC
          ADC $0406,X
          STA $0406,X
          LDA $0402,X
          ADC #$00
          STA $0402,X
          BPL LB026
LB007     JSR L8001
          LDY #$F2
          BNE LB026
LB00E     JSR L8001
          SEC
          STA $00
          LDA $0406,X
          SBC $00
          STA $0406,X
          LDA $0402,X
          SBC #$00
          STA $0402,X
          BMI LB007
LB026     CMP #$0E
          BCC LB033
          LDA #$00
          STA $0406,X
          TYA
          STA $0402,X
LB033     LDA $B468,X
          CLC
          ADC $0406,X
          STA $B468,X
          LDA #$00
          ADC $0402,X
          STA $00
          RTS
LB045     LDA #$00
          STA $00
          STA $02
          LDA #$0E
          STA $01
          STA $03
          LDA $0407,X
          CLC
          ADC $B46B,X
          STA $0407,X
          STA $04
          LDA #$00
          LDY $B46B,X
          BPL LB066
          LDA #$FF
LB066     ADC $0403,X
          STA $0403,X
          TAY
          BPL LB080
          LDA #$00
          SEC
          SBC $0407,X
          STA $04
          LDA #$00
          SBC $0403,X
          TAY
          JSR L87B4
LB080     LDA $04
          CMP $02
          TYA
          SBC $03
          BCC LB093
          LDA $00
          STA $0407,X
          LDA $01
          STA $0403,X
LB093     LDA $B469,X
          CLC
          ADC $0407,X
          STA $B469,X
          LDA #$00
          ADC $0403,X
          STA $00
          RTS
LB0A5     LDX $45
          LDA $0400,X
          SEC
          SBC $B461,X
          AND #$07
          SEC
          BNE LB0B6
          JSR L8ADB
LB0B6     LDY #$00
          STY $00
          LDX $45
          BCC LB0FA
          INC $00
          LDY $0400,X
          BNE LB0D9
          LDY #$F0
          LDA $43
          CMP #$02
          BCS LB0D9
          LDA $FC
          BEQ LB0FA
          JSR LB213
          BEQ LB0FA
          JSR LB20A
LB0D9     DEY
          TYA
          STA $0400,X
          CMP $B461,X
          BNE LB0F1
          LDA $FC
          BEQ LB0EC
          JSR LB213
          BNE LB0F1
LB0EC     INC $0400,X
          CLC
          RTS
LB0F1     LDA $0405,X
          BMI LB0F9
          INC $B46D,X
LB0F9     SEC
LB0FA     RTS
LB0FB     LDX $45
          LDA $0400,X
          CLC
          ADC $B461,X
          AND #$07
          SEC
          BNE LB10C
          JSR L8AE6
LB10C     LDY #$00
          STY $00
          LDX $45
          BCC LB156
          INC $00
          LDY $0400,X
          CPY #$EF
          BNE LB131
          LDY #$FF
          LDA $43
          CMP #$02
          BCS LB131
          LDA $FC
          BEQ LB156
          JSR LB213
          BNE LB156
          JSR LB20A
LB131     INY
          TYA
          STA $0400,X
          CLC
          ADC $B461,X
          CMP #$EF
          BNE LB14D
          LDA $FC
          BEQ LB147
          JSR LB213
          BEQ LB14D
LB147     DEC $0400,X
          CLC
          BCC LB156
LB14D     LDA $0405,X
          BMI LB155
          DEC $B46D,X
LB155     SEC
LB156     RTS
LB157     LDX $45
          LDA $0401,X
          SEC
          SBC $B462,X
          AND #$07
          SEC
          BNE LB168
          JSR L8C46
LB168     LDY #$00
          STY $00
          LDX $45
          BCC LB1AD
          INC $00
          LDY $0401,X
          BNE LB18A
          LDA $43
          CMP #$02
          BCC LB18A
          LDA $FD
          BEQ LB184
          JSR LB213
LB184     CLC
          BEQ LB1AD
          JSR LB20A
LB18A     DEC $0401,X
          LDA $0401,X
          CMP $B462,X
          BNE LB1A4
          LDA $FD
          BEQ LB19E
          JSR LB213
          BNE LB1A4
LB19E     INC $0401,X
          CLC
          BCC LB1AD
LB1A4     LDA $0405,X
          BPL LB1AC
          INC $B46D,X
LB1AC     SEC
LB1AD     RTS
LB1AE     LDX $45
          LDA $0401,X
          CLC
          ADC $B462,X
          AND #$07
          SEC
          BNE LB1BF
          JSR L8C51
LB1BF     LDY #$00
          STY $00
          LDX $45
          BCC LB209
          INC $00
          INC $0401,X
          BNE LB1E6
          LDA $43
          CMP #$02
          BCC LB1E6
          LDA $FD
          BEQ LB1DD
          JSR LB213
          BEQ LB1E3
LB1DD     DEC $0401,X
          CLC
          BCC LB209
LB1E3     JSR LB20A
LB1E6     LDA $0401,X
          CLC
          ADC $B462,X
          CMP #$FF
          BNE LB200
          LDA $FD
          BEQ LB1FA
          JSR LB213
          BEQ LB200
LB1FA     DEC $0401,X
          CLC
          BCC LB209
LB200     LDA $0405,X
          BPL LB208
          DEC $B46D,X
LB208     SEC
LB209     RTS
LB20A     LDA $B467,X
          EOR #$01
          STA $B467,X
          RTS
LB213     LDA $B467,X
          EOR $FF
          AND #$01
          RTS
LB21B     EOR $0405,X
          STA $0405,X
          RTS
LB222     LDX #$FD
          LDY #$B3
          LDA #$1B
          JMP LB235
          PHA
          LDA #$20
          STA $B3C2
          LDA #$00
          BEQ LB23D
LB235     PHA
          LDA #$20
          STA $B3C2
          LDA #$01
LB23D     STA $B3C4
          PLA
          STA $B24E
          STX $B254
          STY $B255
LB24A     JSR LB2C3
          LDA #$1F
          JSR $E239
          LDX $ECB3,Y
          .BYTE $B3    ;%10110011
          BEQ LB25E
          JSR LB2CC
          JMP LB24A
LB25E     JMP LB378
LB261     PHA
          JSR LB32D
          LDX #$E4
          LDY #$B3
          JSR LB28A
          PLA
          JSR $C46B
          PHA
          JSR LB222
          PLA
          LDY $1E
          CPY #$07
          BNE LB27C
          RTS
LB27C     STA $6E
          AND #$0F
          ASL A
          TAY
          LDA $B2AC,Y
          TAX
          LDA $B2AD,Y
          TAY
LB28A     LDA #$20
          STA $B3C2
          LDA #$01
LB291     STA $B3C4
          STX $B2A2
          STY $B2A3
LB29A     JSR LB2C3
          JSR $E1F8
          LDX $00B3,Y
          BRK
          BEQ LB2BF
          JSR LB2CC
          JMP LB29A
          INY
          .BYTE $B3    ;%10110011
          CMP $D6B3
          .BYTE $B3    ;%10110011
          .BYTE $D2    ;%11010010
          .BYTE $B3    ;%10110011
          CMP $A9B3,X
          JSR $C28D
          .BYTE $B3    ;%10110011
          LDA #$00
          BEQ LB291
LB2BF     JSR LB378
          RTS
LB2C3     JSR LB36E
          JSR L6F4E
          JMP $DFF3
LB2CC     PHA
          JSR LB378
          PLA
          PHA
          LSR A
          LSR A
          LSR A
          SEC
          ROR A
          STA $B356
          PLA
          PHA
          AND #$0F
          ORA #$80
          STA $B357
          PLA
          LDY $1E
          CPY #$03
          BNE LB2ED
          JMP LB385
LB2ED     LDA #$00
          STA $FC
          LDA $FF
          AND #$FC
          STA $FF
          JSR L6EE4
          LDX #$4F
          LDY #$B3
          JSR L9416
          JSR LB346
          JSR $D068
LB307     JSR LB310
          JSR L6F3B
          JMP LB32D
LB310     LDA $4032
          LSR A
          BCC LB310
LB316     LDA #$20
          PHA
LB319     JSR $D058
          PLA
          BEQ LB322
          TAY
          DEY
          TYA
LB322     PHA
          LDA $4032
          LSR A
          BCS LB319
          PLA
          BNE LB316
LB32C     RTS
LB32D     LDA $1E
          CMP #$03
          BEQ LB32C
          JSR L6EE4
          LDX #$59
          LDY #$B3
          JSR L9416
          JSR $D058
          JSR LB346
          JMP $D068
LB346     LDA $FF
          AND #$EF
          ORA #$08
          STA $FF
          RTS
          AND ($F3,X)
          ASL $B3
          TSX
          TSX
          .BYTE $FF    ;%11111111
          AND ($21,X)
          BRK
          AND ($CC,X)
          .BYTE $07    ;%00000111
          .BYTE $0B    ;%00001011
LB35D     .BYTE $0C    ;%00001100
          .BYTE $1B    ;%00011011
          .BYTE $1C    ;%00011100
          .BYTE $2B    ;%00101011 '+'
          BIT $233F
          BNE LB3C6
          BRK
          BRK
          JSR $D058
          JMP $E161
LB36E     LDA $FF
          AND #$7B
LB372     STA $2000
          STA $FF
          RTS
LB378     LDA $2002
          AND #$80
          BNE LB378
          LDA $FF
          ORA #$80
          BNE LB372
LB385     PHA
          PHA
          JSR L6F3B
          LDA #$5E
          STA $03F3
          LDA #$80
          STA $03FD
          LDA #$C0
          STA $03FE
          LDA $030C
          STA $03FC
          LDA #$F0
          STA $45
          LDA #$00
          STA $55
          JSR L81C6
          PLA
          LSR A
          LSR A
          LSR A
          SEC
          ROR A
          STA $020D
          PLA
          AND #$0F
          ORA #$80
          STA $0211
          JMP LB307
          ORA ($4D,X)
          EOR $54
          JSR $0002
          BRK
LB3C6     BRK
          BRK
          BPL LB34B
          BCC LB35D
          .BYTE $FF    ;%11111111
          ORA ($90),Y
          STY $91
          .BYTE $FF    ;%11111111
          .BYTE $13    ;%00010011
          .BYTE $92    ;%10010010
          STA $FF
          .BYTE $12    ;%00010010
          .BYTE $1F    ;%00011111
          BCC LB36C
          STX $91
          .BYTE $FF    ;%11111111
          .BYTE $14    ;%00010100
          .BYTE $1F    ;%00011111
          .BYTE $92    ;%10010010
          BCC LB369
          STA ($FF),Y
          .BYTE $EF    ;%11101111
          .BYTE $FF    ;%11111111
          ASL $FFFF
          .BYTE $FF    ;%11111111
          INC $0EFF
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          LDY #$C5
          ADC $00,X
          BRK
          LDY #$C5
          BRK
          .BYTE $EF    ;%11101111
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          BRK
          CPY #$F0
          .BYTE $03    ;%00000011
          BRK
          BRK
          CPY #$00
          LDX #$A3
          .END

;auto-generated symbols and labels
 L6882      $6882
 L6900      $6900
 L6902      $6902
 L6922      $6922
 L6942      $6942
 L7008      $7008
 L7019      $7019
 L7022      $7022
 L7046      $7046
 L7063      $7063
 L7080      $7080
 L7090      $7090
 L7107      $7107
 L7113      $7113
 L7121      $7121
 L7132      $7132
 L7140      $7140
 L7146      $7146
 L7150      $7150
 L7172      $7172
 L7173      $7173
 L7204      $7204
 L7207      $7207
 L7229      $7229
 L7232      $7232
 L7238      $7238
 L7245      $7245
 L7246      $7246
 L7257      $7257
 L7273      $7273
 L7300      $7300
 L7302      $7302
 L7308      $7308
 L7309      $7309
 L7311      $7311
 L7322      $7322
 L7335      $7335
 L7371      $7371
 L7377      $7377
 L7379      $7379
 L7403      $7403
 L7406      $7406
 L7433      $7433
 L7448      $7448
 L7452      $7452
 L7463      $7463
 L7491      $7491
 L7506      $7506
 L7530      $7530
 L7559      $7559
 L7568      $7568
 L7579      $7579
 L7582      $7582
 L7610      $7610
 L7612      $7612
 L7617      $7617
 L7621      $7621
 L7664      $7664
 L7671      $7671
 L7683      $7683
 L7692      $7692
 L7695      $7695
 L7720      $7720
 L7759      $7759
 L7788      $7788
 L7796      $7796
 L7804      $7804
 L7810      $7810
 L7829      $7829
 L7834      $7834
 L7835      $7835
 L7840      $7840
 L7879      $7879
 L7890      $7890
 L7898      $7898
 L7901      $7901
 L7909      $7909
 L7958      $7958
 L7965      $7965
 L7970      $7970
 L7975      $7975
 L7978      $7978
 L7979      $7979
 L7983      $7983
 L7986      $7986
 L7987      $7987
 L8001      $8001
 L8017      $8017
 L8071      $8071
 L8078      $8078
 L8089      $8089
 L8107      $8107
 L8113      $8113
 L8128      $8128
 L8146      $8146
 L8181      $8181
 L8233      $8233
 L8255      $8255
 L8290      $8290
 L8292      $8292
 L8306      $8306
 L8308      $8308
 L8324      $8324
 L8328      $8328
 L8349      $8349
 L8356      $8356
 L8389      $8389
 L8391      $8391
 L8392      $8392
 L8393      $8393
 L8424      $8424
 L8432      $8432
 L8433      $8433
 L8438      $8438
 L8481      $8481
 L8503      $8503
 L8518      $8518
 L8550      $8550
 L8558      $8558
 L8569      $8569
 L8577      $8577
 L8580      $8580
 L8586      $8586
 L8597      $8597
 L8608      $8608
 L8611      $8611
 L8642      $8642
 L8676      $8676
 L8679      $8679
 L8681      $8681
 L8685      $8685
 L8710      $8710
 L8734      $8734
 L8736      $8736
 L8750      $8750
 L8778      $8778
 L8791      $8791
 L8801      $8801
 L8806      $8806
 L8832      $8832
 L8854      $8854
 L8880      $8880
 L8882      $8882
 L8884      $8884
 L8893      $8893
 L8957      $8957
 L8981      $8981
 L8991      $8991
 L9003      $9003
 L9014      $9014
 L9025      $9025
 L9045      $9045
 L9069      $9069
 L9075      $9075
 L9086      $9086
 L9088      $9088
 L9093      $9093
 L9114      $9114
 L9119      $9119
 L9151      $9151
 L9165      $9165
 L9189      $9189
 L9193      $9193
 L9197      $9197
 L9201      $9201
 L9241      $9241
 L9256      $9256
 L9268      $9268
 L9269      $9269
 L9281      $9281
 L9295      $9295
 L9324      $9324
 L9345      $9345
 L9349      $9349
 L9368      $9368
 L9372      $9372
 L9388      $9388
 L9390      $9390
 L9402      $9402
 L9407      $9407
 L9416      $9416
 L9433      $9433
 L9445      $9445
 L9449      $9449
 L9467      $9467
 L9471      $9471
 L9472      $9472
 L9473      $9473
 L9474      $9474
 L9478      $9478
 L9479      $9479
 L9493      $9493
 L9494      $9494
 L9509      $9509
 L9526      $9526
 L9529      $9529
 L9531      $9531
 L9538      $9538
 L9539      $9539
 L9547      $9547
 L9552      $9552
 L9563      $9563
 L9568      $9568
 L9587      $9587
 L9611      $9611
 L9617      $9617
 L9752      $9752
 L9757      $9757
 L9788      $9788
 L9790      $9790
 L9803      $9803
 L9812      $9812
 L9817      $9817
 L9958      $9958
 L9960      $9960
 L9979      $9979
 L68A2      $68A2
 L68C2      $68C2
 L68E2      $68E2
 L6A1E      $6A1E
 L6A4D      $6A4D
 L6ABF      $6ABF
 L6AC3      $6AC3
 L6AC1      $6AC1
 L6B44      $6B44
 L6B7B      $6B7B
 LA2FD      $A2FD
 LA325      $A325
 LA303      $A303
 LA73F      $A73F
 L840B      $840B
 LA57A      $A57A
 LA72B      $A72B
 LA747      $A747
 LAAA6      $AAA6
 LAA75      $AA75
 LAAB7      $AAB7
 LA75D      $A75D
 LAC7C      $AC7C
 L8EC4      $8EC4
 LAEF4      $AEF4
 LAFC8      $AFC8
 LA90B      $A90B
 LAFEF      $AFEF
 LB045      $B045
 L9E4F      $9E4F
 L6C49      $6C49
 L6CA7      $6CA7
 L6BFB      $6BFB
 L6BF9      $6BF9
 L6C6F      $6C6F
 L6C76      $6C76
 L6C69      $6C69
 L941D      $941D
 L6F3B      $6F3B
 L6CF4      $6CF4
 L6CE9      $6CE9
 L8A8B      $8A8B
 L8D80      $8D80
 L6CA8      $6CA8
 L6CD0      $6CD0
 L6CEB      $6CEB
 L6CFD      $6CFD
 L6CF7      $6CF7
 L6FB1      $6FB1
 L6D41      $6D41
 L6D84      $6D84
 L6DBE      $6DBE
 L855C      $855C
 L6EF1      $6EF1
 L6DA4      $6DA4
 L95BC      $95BC
 L6D63      $6D63
 L6F4E      $6F4E
 L6DBB      $6DBB
 L6DC6      $6DC6
 L6E00      $6E00
 L84FE      $84FE
 L6DCC      $6DCC
 L6EE4      $6EE4
 L6E2D      $6E2D
 L6E64      $6E64
 L81C6      $81C6
 L6E4B      $6E4B
 L6E7C      $6E7C
 L6E92      $6E92
 L6E87      $6E87
 L6E90      $6E90
 LB261      $B261
 L6EBE      $6EBE
 L7CAA      $7CAA
 L6F3F      $6F3F
 L6ECC      $6ECC
 L731F      $731F
 L81C3      $81C3
 L942A      $942A
 LA232      $A232
 L6FC1      $6FC1
 L7B30      $7B30
 L7D52      $7D52
 LA98A      $A98A
 LAB52      $AB52
 LA828      $A828
 LAACA      $AACA
 L9B65      $9B65
 L9BCB      $9BCB
 L9D8E      $9D8E
 L9F21      $9F21
 LA9DF      $A9DF
 L7E8D      $7E8D
 L7EAD      $7EAD
 LACD0      $ACD0
 L6F32      $6F32
 L6F30      $6F30
 L6F60      $6F60
 L6FA6      $6FA6
 L6F82      $6F82
 L6FA4      $6FA4
 L6FB3      $6FB3
 L6FBD      $6FBD
 L6FCE      $6FCE
 L6FEA      $6FEA
 L6F8D      $6F8D
 L6FF5      $6FF5
 L6FFF      $6FFF
 L700F      $700F
 L854C      $854C
 L75A4      $75A4
 L704B      $704B
 L70AD      $70AD
 L70D7      $70D7
 L70B6      $70B6
 L70A0      $70A0
 L70AF      $70AF
 L74FD      $74FD
 L70C2      $70C2
 L70CA      $70CA
 L70F4      $70F4
 L733C      $733C
 L72E2      $72E2
 L70DF      $70DF
 L706B      $706B
 L70ED      $70ED
 L6F56      $6F56
 L70FF      $70FF
 L711F      $711F
 L718B      $718B
 L704C      $704C
 L800B      $800B
 L71AE      $71AE
 L85D4      $85D4
 L716F      $716F
 L719A      $719A
 L71E4      $71E4
 L71D2      $71D2
 L71C8      $71C8
 L6F9E      $6F9E
 L721A      $721A
 L71FE      $71FE
 L6F6C      $6F6C
 L725A      $725A
 LA210      $A210
 L729A      $729A
 L72DF      $72DF
 L6FA2      $6FA2
 L703F      $703F
 L72F3      $72F3
 L72FA      $72FA
 L732B      $732B
 L736B      $736B
 L735D      $735D
 L73A6      $73A6
 L6F8A      $6F8A
 L73A9      $73A9
 L73B4      $73B4
 L73CB      $73CB
 L740B      $740B
 L73E1      $73E1
 L73F2      $73F2
 L741A      $741A
 L743E      $743E
 L744B      $744B
 L761C      $761C
 L75C6      $75C6
 L74A1      $74A1
 L74D4      $74D4
 L8B0D      $8B0D
 L8C13      $8C13
 L79B5      $79B5
 L74FA      $74FA
 L74E4      $74E4
 L74F8      $74F8
 L754D      $754D
 L6F68      $6F68
 L756F      $756F
 L7F70      $7F70
 L75FF      $75FF
 L760C      $760C
 L761D      $761D
 L761F      $761F
 L75A3      $75A3
 L75BB      $75BB
 LA0DB      $A0DB
 L75AF      $75AF
 L75C5      $75C5
 L75AD      $75AD
 L76F1      $76F1
 L76AD      $76AD
 L769E      $769E
 L6F74      $6F74
 L771C      $771C
 L76D8      $76D8
 L769D      $769D
 L76F0      $76F0
 L76E5      $76E5
 L6F5E      $6F5E
 L76BB      $76BB
 L770D      $770D
 L772A      $772A
 L76F3      $76F3
 L6F86      $6F86
 L777C      $777C
 L773F      $773F
 L780D      $780D
 L90BB      $90BB
 L775D      $775D
 L776C      $776C
 L6FBB      $6FBB
 L778E      $778E
 L85B4      $85B4
 L77AF      $77AF
 L77F2      $77F2
 L77D4      $77D4
 L77C1      $77C1
 L77CD      $77CD
 L77FF      $77FF
 L77E1      $77E1
 L885C      $885C
 L77EB      $77EB
 L780C      $780C
 L8EDB      $8EDB
 L781F      $781F
 L783F      $783F
 L784C      $784C
 L78C3      $78C3
 L795B      $795B
 L789D      $789D
 L78C7      $78C7
 L78D6      $78D6
 L78A3      $78A3
 L78A0      $78A0
 LAF46      $AF46
 LAFDF      $AFDF
 L79A1      $79A1
 L786C      $786C
 L8B89      $8B89
 L7B1C      $7B1C
 L79CE      $79CE
 L79CD      $79CD
 L8D13      $8D13
 L797F      $797F
 L79CA      $79CA
 L79D8      $79D8
 L79DA      $79DA
 L7A0B      $7A0B
 L7A02      $7A02
 L6F5A      $6F5A
 L79E8      $79E8
 L7A24      $7A24
 L7A21      $7A21
 L7A61      $7A61
 L7A65      $7A65
 L7B08      $7B08
 L7A48      $7A48
 L7A64      $7A64
 L7AE7      $7AE7
 L7A92      $7A92
 L7AFC      $7AFC
 L7A76      $7A76
 L7A8F      $7A8F
 L7ABE      $7ABE
 L7AA2      $7AA2
 L7AFB      $7AFB
 L7ABB      $7ABB
 L7ACE      $7ACE
 L7AF9      $7AF9
 L8D17      $8D17
 L7B15      $7B15
 L8CBF      $8CBF
 L7B8B      $7B8B
 L7B83      $7B83
 L7B5B      $7B5B
 L7B1B      $7B1B
 L7BA1      $7BA1
 L7BB4      $7BB4
 L8A12      $8A12
 L8A3D      $8A3D
 L7BD1      $7BD1
 L7BC9      $7BC9
 L79C5      $79C5
 L7BE3      $7BE3
 L7BEA      $7BEA
 L7C0F      $7C0F
 L7C1A      $7C1A
 L7C2A      $7C2A
 L7C44      $7C44
 L7C5E      $7C5E
 L6E99      $6E99
 L7C69      $7C69
 L7C68      $7C68
 L7C7C      $7C7C
 L7CB6      $7CB6
 L7CBF      $7CBF
 L7CC5      $7CC5
 L7CF1      $7CF1
 L7CEE      $7CEE
 L85BD      $85BD
 LA073      $A073
 L7D1C      $7D1C
 LA03F      $A03F
 LA0AC      $A0AC
 LA0E7      $A0E7
 L7D38      $7D38
 L7D21      $7D21
 LA0E1      $A0E1
 L7D01      $7D01
 L7D37      $7D37
 L7FF8      $7FF8
 L7D45      $7D45
 L7D51      $7D51
 L7D6B      $7D6B
 L7E26      $7E26
 L7D8B      $7D8B
 L7D7C      $7D7C
 L7D86      $7D86
 L7D98      $7D98
 L7E50      $7E50
 L7DBB      $7DBB
 L7DFA      $7DFA
 L7DB4      $7DB4
 L7DF9      $7DF9
 L7E20      $7E20
 L7DF6      $7DF6
 L7EB8      $7EB8
 L7E8C      $7E8C
 L7E66      $7E66
 L7EA8      $7EA8
 L7EAC      $7EAC
 L7F6C      $7F6C
 L7F15      $7F15
 L7F1B      $7F1B
 L7FF5      $7FF5
 L6FAD      $6FAD
 L7F3C      $7F3C
 L7F92      $7F92
 L7F6D      $7F6D
 L7F50      $7F50
 L7EA5      $7EA5
 L7F67      $7F67
 L7F76      $7F76
 L7F59      $7F59
 L7F80      $7F80
 L7FAA      $7FAA
 L7FB2      $7FB2
 L7FC3      $7FC3
 L7FC7      $7FC7
 L7FDD      $7FDD
 LA05F      $A05F
 LA094      $A094
 L802C      $802C
 L802D      $802D
 L801D      $801D
 L803D      $803D
 L806B      $806B
 L83AF      $83AF
 L82A4      $82A4
 L80DF      $80DF
 L80F1      $80F1
 LA638      $A638
 LAD60      $AD60
 L80D7      $80D7
 L80C7      $80C7
 L80C6      $80C6
 L80E2      $80E2
 LA905      $A905
 L80AC      $80AC
 L812C      $812C
 L811C      $811C
 L814F      $814F
 L803F      $803F
 L81B9      $81B9
 L81CF      $81CF
 L81C0      $81C0
 L81D2      $81D2
 L81DC      $81DC
 L825A      $825A
 L82E2      $82E2
 L831A      $831A
 L825D      $825D
 L82C8      $82C8
 L82B2      $82B2
 L82A9      $82A9
 L82BC      $82BC
 L82C2      $82C2
 L82F2      $82F2
 L82EC      $82EC
 L832F      $832F
 L832D      $832D
 L833A      $833A
 L83A5      $83A5
 L83AD      $83AD
 L83AE      $83AE
 L83C0      $83C0
 L83B6      $83B6
 L83D2      $83D2
 L83F1      $83F1
 L83F9      $83F9
 L841E      $841E
 L843E      $843E
 L84DE      $84DE
 L848B      $848B
 L84B5      $84B5
 L84DD      $84DD
 L84CF      $84CF
 L84E6      $84E6
 L84D7      $84D7
 L851B      $851B
 L855B      $855B
 L856F      $856F
 L85B3      $85B3
 L85AC      $85AC
 L947A      $947A
 L85A8      $85A8
 L85AF      $85AF
 L85D3      $85D3
 L85DF      $85DF
 L85C8      $85C8
 L85F8      $85F8
 L860F      $860F
 L86E5      $86E5
 L862D      $862D
 L87C2      $87C2
 L863E      $863E
 L862F      $862F
 L864C      $864C
 L880E      $880E
 L864E      $864E
 L86B2      $86B2
 L869E      $869E
 L86CF      $86CF
 L86D0      $86D0
 L86A0      $86A0
 L86CD      $86CD
 L86BB      $86BB
 L89D3      $89D3
 L86BD      $86BD
 L86FF      $86FF
 L8B18      $8B18
 L7CF4      $7CF4
 L873E      $873E
 L87B4      $87B4
 L87A2      $87A2
 L87D2      $87D2
 L880D      $880D
 L87E6      $87E6
 L87F1      $87F1
 L87F3      $87F3
 L881E      $881E
 L885B      $885B
 L883D      $883D
 L883F      $883F
 L884F      $884F
 L886C      $886C
 L887C      $887C
 L8D0C      $8D0C
 L88AA      $88AA
 L88B3      $88B3
 L889E      $889E
 L88B1      $88B1
 L88A9      $88A9
 L88B5      $88B5
 L88B4      $88B4
 L88C6      $88C6
 L88DC      $88DC
 L8A6C      $8A6C
 L88CF      $88CF
 L893C      $893C
 L892D      $892D
 LA29E      $A29E
 L89A1      $89A1
 L8BD5      $8BD5
 L89CE      $89CE
 L89B9      $89B9
 L89BB      $89BB
 L89C9      $89C9
 L89E3      $89E3
 L8BE0      $8BE0
 L8A0D      $8A0D
 L89FB      $89FB
 L89FD      $89FD
 L8A0B      $8A0B
 L8A24      $8A24
 L8A3B      $8A3B
 L8A32      $8A32
 L8A39      $8A39
 L8A4F      $8A4F
 L8A68      $8A68
 L8A5A      $8A5A
 L8A66      $8A66
 L8A61      $8A61
 L8A69      $8A69
 L88FB      $88FB
 L8A9E      $8A9E
 L8FE9      $8FE9
 L8ADA      $8ADA
 L8AD5      $8AD5
 L8AC3      $8AC3
 L8AD7      $8AD7
 L8AEE      $8AEE
 L8AFD      $8AFD
 L8B28      $8B28
 L8B20      $8B20
 L8B2C      $8B2C
 L8B3B      $8B3B
 L8C23      $8C23
 L8C64      $8C64
 L8B87      $8B87
 L8B88      $8B88
 L8B6B      $8B6B
 L8B7E      $8B7E
 L8B7C      $8B7C
 L8CE3      $8CE3
 L8B51      $8B51
 L8BD0      $8BD0
 L8BC1      $8BC1
 L8BBA      $8BBA
 L8BD2      $8BD2
 L8B8F      $8B8F
 L6F78      $6F78
 L8BE8      $8BE8
 L8BF4      $8BF4
 L8C02      $8C02
 L8B49      $8B49
 L8C35      $8C35
 L8C41      $8C41
 L8C59      $8C59
 L8BF0      $8BF0
 L8C77      $8C77
 L8CB4      $8CB4
 L8C71      $8C71
 L8C92      $8C92
 L8C89      $8C89
 L8C9B      $8C9B
 L8CB3      $8CB3
 L8CFA      $8CFA
 L8D0B      $8D0B
 L8D59      $8D59
 L8D58      $8D58
 L8D30      $8D30
 L8D21      $8D21
 L8D4D      $8D4D
 L8D54      $8D54
 L8DC1      $8DC1
 L8DC5      $8DC5
 L8D7F      $8D7F
 L8DB2      $8DB2
 L8D68      $8D68
 L8FF1      $8FF1
 L90EE      $90EE
 L8E15      $8E15
 L8D5A      $8D5A
 L934E      $934E
 L8DFF      $8DFF
 L8DD5      $8DD5
 L8DD2      $8DD2
 L8DC7      $8DC7
 L8DE2      $8DE2
 L92E2      $92E2
 L8E49      $8E49
 L8E11      $8E11
 L8DB5      $8DB5
 L8E1F      $8E1F
 L8E1E      $8E1E
 L925F      $925F
 L8E97      $8E97
 L8E9C      $8E9C
 L8DCB      $8DCB
 L8E58      $8E58
 L88E7      $88E7
 L8A77      $8A77
 L8E61      $8E61
 L8E29      $8E29
 L8ED0      $8ED0
 L8E7A      $8E7A
 L8E7D      $8E7D
 L8EA3      $8EA3
 L8E9B      $8E9B
 L8E96      $8E96
 L8E79      $8E79
 LAA68      $AA68
 L8EDA      $8EDA
 L8EE8      $8EE8
 L8F26      $8F26
 L8F1D      $8F1D
 L91A0      $91A0
 L8F2B      $8F2B
 L8F64      $8F64
 L8EF9      $8EF9
 L8F7B      $8F7B
 L8EE5      $8EE5
 L8F82      $8F82
 L8F94      $8F94
 L8FA0      $8FA0
 L8FE5      $8FE5
 L8FAF      $8FAF
 L8FAA      $8FAA
 L90A7      $90A7
 L901B      $901B
 L90B1      $90B1
 L903A      $903A
 L90D0      $90D0
 L906B      $906B
 L90E2      $90E2
 L90AD      $90AD
 L90CA      $90CA
 L90BD      $90BD
 L90E1      $90E1
 L90ED      $90ED
 L90F6      $90F6
 L912A      $912A
 L90E0      $90E0
 L912C      $912C
 L918F      $918F
 L91B7      $91B7
 L91B3      $91B3
 L91B8      $91B8
 L91A5      $91A5
 L91DC      $91DC
 L91C1      $91C1
 L91F6      $91F6
 L8F5F      $8F5F
 L91D9      $91D9
 L921C      $921C
 L926F      $926F
 L928E      $928E
 L92A1      $92A1
 L92F4      $92F4
 L92C8      $92C8
 L92CE      $92CE
 L92D7      $92D7
 L92EF      $92EF
 L932B      $932B
 L933E      $933E
 L93C8      $93C8
 L937C      $937C
 L93BA      $93BA
 L947E      $947E
 L94C5      $94C5
 L93E9      $93E9
 L93DC      $93DC
 L93DE      $93DE
 L6F52      $6F52
 L6D0A      $6D0A
 L94BC      $94BC
 L942C      $942C
 L943F      $943F
 L94D3      $94D3
 L94AD      $94AD
 L94B0      $94B0
 L94DC      $94DC
 L94F8      $94F8
 L958A      $958A
 L955F      $955F
 L957B      $957B
 L95A1      $95A1
 L959C      $959C
 L95BB      $95BB
 L95B9      $95B9
 L95D1      $95D1
 L969F      $969F
 L96A7      $96A7
 L974D      $974D
 L97A7      $97A7
 L97AF      $97AF
 L97C9      $97C9
 L97D3      $97D3
 L97BF      $97BF
 L97D4      $97D4
 L97DE      $97DE
 L97E0      $97E0
 L97E6      $97E6
 L97E2      $97E2
 L980C      $980C
 L980E      $980E
 L97F6      $97F6
 L980D      $980D
 L996C      $996C
 L797A      $797A
 LA3FD      $A3FD
 L6A6B      $6A6B
 L7AFE      $7AFE
 L9A8B      $9A8B
 L9A92      $9A92
 L9A46      $9A46
 L9AAE      $9AAE
 L9B56      $9B56
 L9BBE      $9BBE
 L9B9D      $9B9D
 L9BBF      $9BBF
 L9BA5      $9BA5
 L9BA4      $9BA4
 L9BC6      $9BC6
 L9BD9      $9BD9
 L9BCD      $9BCD
 L9BD3      $9BD3
 L9D4D      $9D4D
 L9C0C      $9C0C
 L9C03      $9C03
 L9C40      $9C40
 L9CD0      $9CD0
 L9C6F      $9C6F
 L9CC5      $9CC5
 L9CA9      $9CA9
 L9D49      $9D49
 L9C9E      $9C9E
 L7F94      $7F94
 L9CC8      $9CC8
 L6F9A      $6F9A
 L9D15      $9D15
 L9CF9      $9CF9
 L9D12      $9D12
 L6FB7      $6FB7
 L9CC3      $9CC3
 L9D3F      $9D3F
 L9CB3      $9CB3
 L9D4F      $9D4F
 L9D6B      $9D6B
 L9D31      $9D31
 L9D90      $9D90
 L9D8B      $9D8B
 L9D57      $9D57
 L9DE0      $9DE0
 L9EC7      $9EC7
 L9DEB      $9DEB
 L9E19      $9E19
 L9EAF      $9EAF
 L9E4E      $9E4E
 LA1FE      $A1FE
 L9E3F      $9E3F
 L9E7B      $9E7B
 L9E79      $9E79
 L9EA4      $9EA4
 L94E3      $94E3
 L9ED3      $9ED3
 L9EF2      $9EF2
 L9EF3      $9EF3
 L9F68      $9F68
 LA087      $A087
 L9F46      $9F46
 LA036      $A036
 LA1A1      $A1A1
 L9F63      $9F63
 L9F5D      $9F5D
 LA217      $A217
 L9F48      $9F48
 L9F2A      $9F2A
 L9F85      $9F85
 L9F8A      $9F8A
 LA164      $A164
 L9F71      $9F71
 L9F93      $9F93
 L9FD2      $9FD2
 L9FC1      $9FC1
 L9FBC      $9FBC
 L9FB6      $9FB6
 LA02D      $A02D
 LA1B7      $A1B7
 L9FA1      $9FA1
 LA16F      $A16F
 L9FDA      $9FDA
 L9F8C      $9F8C
 L9FFF      $9FFF
 LA0A0      $A0A0
 LA04F      $A04F
 LA1DA      $A1DA
 L9FE1      $9FE1
 LA02A      $A02A
 LA01D      $A01D
 LA023      $A023
 LA012      $A012
 LA0BF      $A0BF
 LA06C      $A06C
 LA080      $A080
 LA0CD      $A0CD
 LA0C6      $A0C6
 LA0D4      $A0D4
 LA0B8      $A0B8
 LA111      $A111
 LA14F      $A14F
 LA10E      $A10E
 LA118      $A118
 LA153      $A153
 LA14E      $A14E
 LA13E      $A13E
 LA143      $A143
 LA15C      $A15C
 LA16E      $A16E
 LA1D5      $A1D5
 LA19A      $A19A
 LA192      $A192
 LA225      $A225
 LA1F3      $A1F3
 LA1C2      $A1C2
 LA1B6      $A1B6
 LA185      $A185
 LA1CB      $A1CB
 LA166      $A166
 LA21F      $A21F
 LA22D      $A22D
 LA1C5      $A1C5
 LA1FD      $A1FD
 LA1CC      $A1CC
 LA15D      $A15D
 LA216      $A216
 LA20E      $A20E
 LA1AC      $A1AC
 LA168      $A168
 LA23E      $A23E
 LA234      $A234
 LA24C      $A24C
 LA26C      $A26C
 LA297      $A297
 LA269      $A269
 LA209      $A209
 LA20A      $A20A
 LA294      $A294
 LA2D0      $A2D0
 LA5A6      $A5A6
 LA648      $A648
 LA56F      $A56F
 LA563      $A563
 LA6A7      $A6A7
 LA2F7      $A2F7
 LA2EE      $A2EE
 LA40B      $A40B
 LA423      $A423
 LAD08      $AD08
 LA312      $A312
 LA31A      $A31A
 LA33D      $A33D
 LA35E      $A35E
 LA36D      $A36D
 LA3C1      $A3C1
 LA3A4      $A3A4
 LA399      $A399
 LA398      $A398
 L72AD      $72AD
 L6F7C      $6F7C
 LA3AD      $A3AD
 LA3B8      $A3B8
 LA3BB      $A3BB
 L6F80      $6F80
 LA3CF      $A3CF
 LA3FC      $A3FC
 LA402      $A402
 LA310      $A310
 LA458      $A458
 L6F92      $6F92
 LA560      $A560
 LA466      $A466
 LA41D      $A41D
 LA459      $A459
 LA476      $A476
 L6F96      $6F96
 LA497      $A497
 LA48A      $A48A
 LA48F      $A48F
 LA494      $A494
 L6F70      $6F70
 L6F8E      $6F8E
 LA4A7      $A4A7
 LA4B1      $A4B1
 LA4CB      $A4CB
 LA4FE      $A4FE
 LA4D8      $A4D8
 LA4F4      $A4F4
 LA4F9      $A4F9
 LA515      $A515
 LA731      $A731
 LA533      $A533
 LA523      $A523
 LA549      $A549
 LA585      $A585
 LA5A5      $A5A5
 LA59F      $A59F
 LA5BA      $A5BA
 LA5FC      $A5FC
 LA6A0      $A6A0
 LA5E2      $A5E2
 LA63F      $A63F
 LA5ED      $A5ED
 LA5EC      $A5EC
 LA631      $A631
 LAE8A      $AE8A
 LA611      $A611
 LA61E      $A61E
 LA61D      $A61D
 LA637      $A637
 LAEBF      $AEBF
 LA6A6      $A6A6
 LA69E      $A69E
 LA669      $A669
 LA683      $A683
 LA697      $A697
 LA6B6      $A6B6
 LA6B7      $A6B7
 LA6C3      $A6C3
 L6F64      $6F64
 LA586      $A586
 LA726      $A726
 LA71F      $A71F
 LAE81      $AE81
 LAEB6      $AEB6
 LA738      $A738
 LA759      $A759
 LA75C      $A75C
 LA774      $A774
 LA7D5      $A7D5
 LA7E4      $A7E4
 LA819      $A819
 LA7E5      $A7E5
 LA80A      $A80A
 LA57D      $A57D
 LA7D8      $A7D8
 LA809      $A809
 LA936      $A936
 LA836      $A836
 LA82A      $A82A
 LA842      $A842
 LA856      $A856
 LA8A4      $A8A4
 LA8AB      $A8AB
 LA948      $A948
 LA869      $A869
 LA94D      $A94D
 LA891      $A891
 LA8A0      $A8A0
 LA874      $A874
 LA871      $A871
 LA8CC      $A8CC
 LA8DF      $A8DF
 LA902      $A902
 LA957      $A957
 LA8F4      $A8F4
 LA405      $A405
 LA917      $A917
 LA924      $A924
 LA96A      $A96A
 LA947      $A947
 LA964      $A964
 LA967      $A967
 LA996      $A996
 LA9A1      $A9A1
 LA98C      $A98C
 LA9B5      $A9B5
 LA9B2      $A9B2
 LA9CE      $A9CE
 LA92E      $A92E
 LA86B      $A86B
 LA9CD      $A9CD
 LA9E7      $A9E7
 LA9EC      $A9EC
 LA9E1      $A9E1
 LA9A0      $A9A0
 LAA03      $AA03
 LAA74      $AA74
 LAA5D      $AA5D
 LAA87      $AA87
 LAA8C      $AA8C
 LAAAC      $AAAC
 LA580      $A580
 LAAD9      $AAD9
 LAAD0      $AAD0
 LAB44      $AB44
 LAB45      $AB45
 LAB42      $AB42
 LAB0A      $AB0A
 LAB81      $AB81
 LAB82      $AB82
 LAB85      $AB85
 LAB6E      $AB6E
 LAB1F      $AB1F
 LAC71      $AC71
 LABF5      $ABF5
 LAC12      $AC12
 LABAE      $ABAE
 LAC4C      $AC4C
 LABC2      $ABC2
 LABCB      $ABCB
 LABD6      $ABD6
 LABE5      $ABE5
 LABEA      $ABEA
 LAC59      $AC59
 LABF4      $ABF4
 LAC06      $AC06
 LAC11      $AC11
 LAC3F      $AC3F
 LAC41      $AC41
 LAC7B      $AC7B
 LAC9E      $AC9E
 LACAC      $ACAC
 LAC91      $AC91
 LAC99      $AC99
 LACCE      $ACCE
 LACAA      $ACAA
 LACC0      $ACC0
 LACCC      $ACCC
 LACBD      $ACBD
 LACCA      $ACCA
 LACE6      $ACE6
 L7FCA      $7FCA
 LACF2      $ACF2
 LACE8      $ACE8
 LACCF      $ACCF
 LAD5F      $AD5F
 LAD2D      $AD2D
 LB0A5      $B0A5
 LAD68      $AD68
 LAD23      $AD23
 LAD3B      $AD3B
 LB0FB      $B0FB
 LADAB      $ADAB
 LAD31      $AD31
 LAD51      $AD51
 LB157      $B157
 LAE1E      $AE1E
 LAD47      $AD47
 LB1AE      $B1AE
 LADE4      $ADE4
 LAD55      $AD55
 LADAA      $ADAA
 LAD77      $AD77
 LAEAC      $AEAC
 LADA6      $ADA6
 LAD9A      $AD9A
 LAD71      $AD71
 LAD88      $AD88
 LAE61      $AE61
 LAD92      $AD92
 LB21B      $B21B
 LADE3      $ADE3
 LADBA      $ADBA
 LADDF      $ADDF
 LADD3      $ADD3
 LADB4      $ADB4
 LADD0      $ADD0
 LAE1D      $AE1D
 LAE0E      $AE0E
 LADF8      $ADF8
 LAE77      $AE77
 LAE19      $AE19
 LADF2      $ADF2
 LAE09      $AE09
 LAE70      $AE70
 LAE60      $AE60
 LAE50      $AE50
 LAE32      $AE32
 LAE5C      $AE5C
 LAE2C      $AE2C
 LAE3E      $AE3E
 LAE48      $AE48
 LAE68      $AE68
 LAEA6      $AEA6
 LAEA5      $AEA5
 LAE9D      $AE9D
 LAEDA      $AEDA
 LAED2      $AED2
 LAEE2      $AEE2
 LAEFC      $AEFC
 LAF52      $AF52
 LAEDB      $AEDB
 LAF2F      $AF2F
 LAF2C      $AF2C
 LAF60      $AF60
 LAF63      $AF63
 LAF55      $AF55
 LAF8E      $AF8E
 LAF08      $AF08
 LAFC2      $AFC2
 LAF40      $AF40
 LAF0B      $AF0B
 LAF6E      $AF6E
 L8ADB      $8ADB
 LAF73      $AF73
 LAF82      $AF82
 L8AE6      $8AE6
 LAF87      $AF87
 LAF9F      $AF9F
 LAFA4      $AFA4
 LAFAB      $AFAB
 LAFD0      $AFD0
 LAFEC      $AFEC
 LB00E      $B00E
 LB026      $B026
 LB007      $B007
 LB033      $B033
 LB066      $B066
 LB080      $B080
 LB093      $B093
 LB0B6      $B0B6
 LB0FA      $B0FA
 LB0D9      $B0D9
 LB213      $B213
 LB20A      $B20A
 LB0F1      $B0F1
 LB0EC      $B0EC
 LB0F9      $B0F9
 LB10C      $B10C
 LB156      $B156
 LB131      $B131
 LB14D      $B14D
 LB147      $B147
 LB155      $B155
 LB168      $B168
 L8C46      $8C46
 LB1AD      $B1AD
 LB18A      $B18A
 LB184      $B184
 LB1A4      $B1A4
 LB19E      $B19E
 LB1AC      $B1AC
 LB1BF      $B1BF
 L8C51      $8C51
 LB209      $B209
 LB1E6      $B1E6
 LB1DD      $B1DD
 LB1E3      $B1E3
 LB200      $B200
 LB1FA      $B1FA
 LB208      $B208
 LB235      $B235
 LB23D      $B23D
 LB2C3      $B2C3
 LB25E      $B25E
 LB2CC      $B2CC
 LB24A      $B24A
 LB378      $B378
 LB32D      $B32D
 LB28A      $B28A
 LB222      $B222
 LB27C      $B27C
 LB2BF      $B2BF
 LB29A      $B29A
 LB291      $B291
 LB36E      $B36E
 LB2ED      $B2ED
 LB385      $B385
 LB346      $B346
 LB310      $B310
 LB322      $B322
 LB319      $B319
 LB316      $B316
 LB32C      $B32C
 LB3C6      $B3C6
 LB372      $B372
 LB307      $B307
 LB34B      $B34B
 LB35D      $B35D
 LB36C      $B36C
 LB369      $B369

