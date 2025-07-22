
L6000     CLD
          LDX #$00
          STX $2000
          STX $2001
L6009     LDA $2002
          BPL L6009
          DEX
          TXS
          LDX $2F
          LDY #$07
          STY $01
          LDA #$00
          STA $00
          TAY
L601B     STA ($00),Y
          DEY
          BNE L601B
          DEC $01
          BPL L601B
          TXA
          BNE L6029
          LDX #$5F
L6029     STX $0618
          LDA #$4F
          STA $4025
          STA $FA
          JSR L65DC
          JSR L6630
          LDY #$00
          LDA $C3F2
          STA $00
          LDA $C3F3
          STA $01
          LDA #$60
          STA ($00),Y
          LDY #$00
          STY $2005
          STY $2005
          STY $3C
          INY
          STY $3A
          LDA #$90
          STA $2000
          STA $FF
          LDA #$06
          STA $FE
          LDA #$C0
          STA $0100
          LDA #$80
          STA $0101
          LDA #$35
          STA $0102
          LDA #$53
          STA $0103
L6075     JSR L66EA
          JSR L6144
          JSR L6080
          BEQ L6075
L6080     LDA #$01
          STA $32
L6084     JSR L6777
          JSR L6777
          LDA $30
          BEQ L6084
          INC $2F
          DEC $32
          LDA #$00
          STA $30
          RTS
L6097     LDA #$00
          STA $1A
L609B     LDA $1A
          BEQ L609B
L609F     RTS
          LDA $40
          AND #$10
          BEQ L609F
          JMP ($C3F0)
L60A9     JSR L6097
          LDA $FE
          AND #$E1
L60B0     STA $2001
          STA $FE
          RTS
L60B6     JSR L6097
          JSR L676A
          LDA $FE
          ORA #$1E
          BNE L60B0
L60C2     LDA $2002
          AND #$80
          BNE L60C2
          LDA $FF
          ORA #$80
          BNE L60D3
          LDA $FF
          AND #$7F
L60D3     STA $2000
          STA $FF
          RTS
          CLI
          PHA
          TXA
          PHA
          TYA
          PHA
          LDA #$00
          STA $2003
          LDA #$02
          STA $4014
          LDA $32
          BEQ L612D
          JSR L62CD
          LDA $AE
          BEQ L6104
          CMP #$05
          BCS L6104
          ASL A
          TAY
          LDX $69D5,Y
          LDA $69D6,Y
          TAY
          JSR L671E
L6104     LDA $AF
          BEQ L6118
          CMP #$05
          BCS L6118
          ASL A
          TAY
          LDX $6A88,Y
          LDA $6A89,Y
          TAY
          JSR L671E
L6118     JSR L663B
          JSR L66CB
          JSR L676A
          LDA $FE
          STA $2001
          JSR L6672
          LDY #$01
          STY $30
L612D     LDA $FE
          STA $2001
          LDA $FF
          STA $2000
          JSR $DFF3
          LDA #$01
          STA $1A
          PLA
          TAY
          PLA
          TAX
          PLA
          RTI
L6144     JSR L6532
          LDA $AD
          BNE L615D
          LDA $2F
          AND #$0F
          BNE L615D
          INC $34
          LDA $34
          CMP #$09
          BNE L615D
          LDA #$01
          STA $34
L615D     LDA $3C
          JSR L6700
          .BYTE $72    ;%01110010 'r'
          ADC ($AC,X)
          ADC ($C4,X)
          ADC ($22,X)
          .BYTE $62    ;%01100010 'b'
          .BYTE $5C    ;%01011100 '\'
          .BYTE $62    ;%01100010 'b'
          .BYTE $8B    ;%10001011
          .BYTE $62    ;%01100010 'b'
          LDY #$60
          .BYTE $9F    ;%10011111
          RTS
          JSR L60A9
          JSR L65E7
          JSR L6630
          LDX #$6F
          LDY #$68
          JSR L671E
          LDA #$20
          STA $0684
          LDA #$60
          STA $2D
          LDA #$36
          STA $A6
          LDA #$00
          STA $AA
          STA $A7
          STA $A9
          STA $AD
          STA $AE
          STA $AF
          STA $B0
          LDA #$01
          STA $34
          LDA #$08
          STA $A8
          INC $3C
          JMP L60B6
          JSR L6322
          LDA $2D
          BNE L61B6
          INC $3C
          RTS
L61B6     CMP #$50
          BNE L61BD
          INC $AE
          RTS
L61BD     CMP #$01
          BNE L61C3
          INC $AF
L61C3     RTS
          LDA $2F
          AND #$3F
          BNE L61F8
          INC $A9
          LDA $A9
          CMP #$08
          BNE L61E1
          LDA $B41D
          CMP #$03
          BNE L61DA
          RTS
L61DA     ASL A
          STA $AA
          LDA #$36
          STA $A6
L61E1     CMP #$10
          BNE L61F8
          STA $2D
          LDY #$00
          LDA $B41D
          CMP #$04
          BCC L61F1
          INY
L61F1     STY $A7
          INC $3C
          JMP L6630
L61F8     DEC $A8
          BNE L620F
          LDY $A9
          LDA $6212,Y
          STA $A8
          INC $A7
          LDA $A7
          CMP #$03
          BNE L620F
          LDA #$00
          STA $A7
L620F     JMP L6322
          PHP
          .BYTE $07    ;%00000111
          ASL $05
          .BYTE $04    ;%00000100
          .BYTE $03    ;%00000011
          .BYTE $02    ;%00000010
          ORA ($01,X)
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          LDA $2D
          BNE L6231
          LDA #$10
          STA $2D
          LDA #$08
          STA $34
          INC $3C
          RTS
L6231     LDA $B41D
          CMP #$04
          BCS L623B
          JMP L6322
L623B     SBC #$04
          ASL A
          ASL A
          STA $AB
          LDA $2F
          AND #$08
          BNE L624D
          LDY #$10
          STY $AC
          BNE L6255
L624D     INC $AB
          INC $AB
          LDY #$10
          STY $AC
L6255     LDA #$2D
          STA $A6
          JMP L6307
          LDA $2D
          BNE L627E
          LDA $AD
          BNE L626A
          LDA #$08
          STA $34
          INC $AD
L626A     LDA $2F
          AND #$07
          BNE L627E
          INC $34
          LDA $34
          CMP #$0B
          BNE L627E
          LDA #$10
          STA $2D
          INC $3C
L627E     LDA $B41D
          CMP #$04
          BCS L6288
          JMP L6322
L6288     JMP L6307
          LDA $2D
          BEQ L629F
          CMP #$02
          BNE L62CC
          JSR L60A9
          JSR L65E7
          JSR L6630
          JMP L60B6
L629F     LDA $B0
          BNE L62A5
          INC $B0
L62A5     CMP #$06
          BNE L62B2
          LDA $FC
          CMP #$88
          BCC L62B2
          INC $3C
          RTS
L62B2     LDA $2F
          AND #$03
          BNE L62CC
          INC $FC
          LDA $FC
          CMP #$F0
          BNE L62CC
          INC $B0
          LDA #$00
          STA $FC
          LDA $FF
          EOR #$02
          STA $FF
L62CC     RTS
L62CD     LDY $B0
          BEQ L6306
          CPY #$07
          BCS L6306
          LDX #$00
          LDA $FC
          BPL L62DF
          INX
          SEC
          SBC #$80
L62DF     CMP #$04
          BCS L6306
          STA $01
          DEY
          TXA
          BNE L62F4
          DEY
          BMI L6306
          TYA
          ASL A
          ASL A
          ASL A
          ADC #$04
          BNE L62F8
L62F4     TYA
          ASL A
          ASL A
          ASL A
L62F8     ADC $01
          ASL A
          TAY
          LDX $6AB6,Y
          LDA $6AB7,Y
          TAY
          JMP L671E
L6306     RTS
L6307     LDX $AB
          LDA $639A,X
          STA $00
          LDA $639B,X
          STA $01
          LDX #$20
          LDY #$00
L6317     LDA ($00),Y
          STA $0200,X
          INX
          INY
          CPY $AC
          BNE L6317
L6322     LDX #$30
          LDY $AA
          LDA $63E2,Y
          STA $00
          LDA $63E3,Y
L632E     STA $01
          LDY #$00
L6332     LDA ($00),Y
          STA $0200,X
          INX
          INY
          LDA ($00),Y
          BPL L6348
          AND #$7F
          STA $0200,X
          LDA $A7
          EOR #$40
          BNE L634D
L6348     STA $0200,X
          LDA $A7
L634D     INX
          STA $0200,X
          INY
          INX
          LDA ($00),Y
          STA $0200,X
          INY
          INX
          CPY $A6
          BNE L6332
          LDA $3C
          CMP #$02
          BCC L6381
          LDA $A9
          CMP #$08
          BCC L6381
          LDA $B41D
          CMP #$03
          BNE L6381
          LDY #$00
          LDX #$00
L6375     LDA $6382,Y
          STA $0200,X
          INY
          INX
          CPY #$18
          BNE L6375
L6381     RTS
          .BYTE $93    ;%10010011
          ROL $01,X
L6385     BVS L631A
          .BYTE $37    ;%00110111 '7'
          ORA ($78,X)
          .BYTE $93    ;%10010011
          SEC
          ORA ($80,X)
          .BYTE $9B    ;%10011011
          LSR $01
          BVS L632E
          .BYTE $47    ;%01000111 'G'
          ORA ($78,X)
          .BYTE $9B    ;%10011011
          PHA
          ORA ($80,X)
          LDX #$63
          .BYTE $B2    ;%10110010
          .BYTE $63    ;%01100011 'c'
          .BYTE $C2    ;%11000010
          .BYTE $63    ;%01100011 'c'
          .BYTE $D2    ;%11010010
          .BYTE $63    ;%01100011 'c'
          .BYTE $9B    ;%10011011
          .BYTE $1F    ;%00011111
L63A4     ORA ($80,X)
          .BYTE $A3    ;%10100011
          .BYTE $2F    ;%00101111 '/'
          ORA ($80,X)
          .BYTE $AB    ;%10101011
          .BYTE $3F    ;%00111111 '?'
          ORA ($80,X)
          .BYTE $F4    ;%11110100
          .BYTE $3F    ;%00111111 '?'
          ORA ($80,X)
          .BYTE $9B    ;%10011011
          ROL A
          ORA ($80,X)
          .BYTE $9B    ;%10011011
          .BYTE $2B    ;%00101011 '+'
          ORA ($88,X)
          .BYTE $A3    ;%10100011
L63BB     .BYTE $3A    ;%00111010 ':'
          ORA ($80,X)
          .BYTE $AB    ;%10101011
          .BYTE $3F    ;%00111111 '?'
          ORA ($80,X)
          .BYTE $9B    ;%10011011
          .BYTE $0C    ;%00001100
          ORA ($80,X)
          .BYTE $A3    ;%10100011
          .BYTE $1C    ;%00011100
          ORA ($80,X)
          .BYTE $AB    ;%10101011
          .BYTE $3F    ;%00111111 '?'
L63CC     ORA ($80,X)
          .BYTE $F4    ;%11110100
          .BYTE $3F    ;%00111111 '?'
          ORA ($80,X)
          .BYTE $9B    ;%10011011
          LSR A
          ORA ($80,X)
          .BYTE $9B    ;%10011011
          .BYTE $4B    ;%01001011 'K'
          ORA ($88,X)
          .BYTE $A3    ;%10100011
          .BYTE $5A    ;%01011010 'Z'
          ORA ($80,X)
          .BYTE $AB    ;%10101011
          .BYTE $3F    ;%00111111 '?'
          ORA ($80,X)
          INC $2463
          .BYTE $64    ;%01100100 'd'
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $64    ;%01100100 'd'
          BCC L644E
          DEC $64
          .BYTE $FC    ;%11111100
          .BYTE $64    ;%01100100 'd'
          .BYTE $93    ;%10010011
          BRK
          BVS L6385
          ORA ($78,X)
          .BYTE $93    ;%10010011
          .BYTE $80    ;%10000000
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          BPL L646A
          .BYTE $9B    ;%10011011
          ORA ($78),Y
          .BYTE $9B    ;%10011011
          BCC L6380
          .BYTE $A3    ;%10100011
          JSR $A370
          AND ($78,X)
          .BYTE $A3    ;%10100011
          .BYTE $22    ;%00100010 '"'
          .BYTE $80    ;%10000000
          .BYTE $AB    ;%10101011
          BMI L647C
          .BYTE $AB    ;%10101011
          AND ($78),Y
          .BYTE $AB    ;%10101011
L6410     .BYTE $32    ;%00110010 '2'
          .BYTE $80    ;%10000000
          .BYTE $B3    ;%10110011
          RTI
          BVS L63C9
          EOR ($78,X)
          .BYTE $B3    ;%10110011
          CPY #$80
          .BYTE $BB    ;%10111011
          BVC L648E
          .BYTE $BB    ;%10111011
          EOR ($78),Y
          .BYTE $BB    ;%10111011
          BNE L63A4
          .BYTE $93    ;%10010011
          .BYTE $02    ;%00000010
          BVS L63BB
          .BYTE $03    ;%00000011
          SEI
          .BYTE $93    ;%10010011
          .BYTE $04    ;%00000100
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          .BYTE $12    ;%00010010
          BVS L63CC
          .BYTE $13    ;%00010011
          SEI
          .BYTE $9B    ;%10011011
          .BYTE $14    ;%00010100
L6435     .BYTE $80    ;%10000000
          .BYTE $A3    ;%10100011
          ORA $70
          .BYTE $A3    ;%10100011
          ASL $78
          .BYTE $A3    ;%10100011
          .BYTE $07    ;%00000111
          .BYTE $80    ;%10000000
          .BYTE $AB    ;%10101011
          ORA $70,X
          .BYTE $AB    ;%10101011
          ASL $78,X
          .BYTE $AB    ;%10101011
L6446     .BYTE $17    ;%00010111
          .BYTE $80    ;%10000000
          .BYTE $B3    ;%10110011
          PHP
          BVS L63FF
          ORA #$78
L644E     .BYTE $B3    ;%10110011
          DEY
          .BYTE $80    ;%10000000
          .BYTE $BB    ;%10111011
          CLC
          BVS L6410
          ORA $BB78,Y
          TYA
          .BYTE $80    ;%10000000
          .BYTE $93    ;%10010011
          BRK
          BVS L63F1
          ORA ($78,X)
          .BYTE $93    ;%10010011
          .BYTE $34    ;%00110100 '4'
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          BPL L64D6
          .BYTE $9B    ;%10011011
          ORA ($78),Y
          .BYTE $9B    ;%10011011
L646A     .BYTE $44    ;%01000100 'D'
L646B     .BYTE $80    ;%10000000
          .BYTE $A3    ;%10100011
          JSR $A370
          AND ($78,X)
          .BYTE $A3    ;%10100011
          .BYTE $33    ;%00110011 '3'
          .BYTE $80    ;%10000000
          .BYTE $AB    ;%10101011
          BMI L64E8
          .BYTE $AB    ;%10101011
          AND ($78),Y
          .BYTE $AB    ;%10101011
L647C     .BYTE $43    ;%01000011 'C'
          .BYTE $80    ;%10000000
          .BYTE $B3    ;%10110011
          RTI
          BVS L6435
          EOR ($78,X)
          .BYTE $B3    ;%10110011
          CPY #$80
          .BYTE $BB    ;%10111011
          BVC L64FA
          .BYTE $BB    ;%10111011
          EOR ($78),Y
          .BYTE $BB    ;%10111011
L648E     BNE L6410
          .BYTE $93    ;%10010011
          BRK
          BVS L6427
          ORA ($78,X)
          .BYTE $93    ;%10010011
          .BYTE $34    ;%00110100 '4'
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          .BYTE $53    ;%01010011 'S'
          BVS L6438
          .BYTE $54    ;%01010100 'T'
          SEI
          .BYTE $9B    ;%10011011
          EOR $80,X
          .BYTE $A3    ;%10100011
          JSR $A370
          AND ($78,X)
          .BYTE $A3    ;%10100011
          .BYTE $22    ;%00100010 '"'
          .BYTE $80    ;%10000000
          .BYTE $AB    ;%10101011
          BMI L651E
          .BYTE $AB    ;%10101011
          AND ($78),Y
          .BYTE $AB    ;%10101011
L64B2     .BYTE $32    ;%00110010 '2'
          .BYTE $80    ;%10000000
          .BYTE $B3    ;%10110011
          RTI
          BVS L646B
          EOR ($78,X)
          .BYTE $B3    ;%10110011
          CPY #$80
          .BYTE $BB    ;%10111011
          BVC L6530
          .BYTE $BB    ;%10111011
          EOR ($78),Y
          .BYTE $BB    ;%10111011
          BNE L6446
          .BYTE $93    ;%10010011
          ORA $9370
          ASL $9378
          .BYTE $0F    ;%00001111
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          ORA $9B70,X
          ASL $A378,X
L64D6     AND $A370
          ROL $AB78
          AND $AB70,X
          ROL $B378,X
          EOR $B370
          LSR $B378
L64E8     .BYTE $4F    ;%01001111 'O'
          .BYTE $80    ;%10000000
          .BYTE $BB    ;%10111011
          EOR $BB70,X
          LSR $BB78,X
          .BYTE $5F    ;%01011111 '_'
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          AND #$80
          .BYTE $A3    ;%10100011
          AND $AB80,Y
L64FA     JMP $9380
          ORA $9370
          ASL $9378
          .BYTE $0F    ;%00001111
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          ASL A
          BVS L64A4
          .BYTE $0B    ;%00001011
          SEI
          .BYTE $A3    ;%10100011
          .BYTE $1A    ;%00011010
          BVS L64B2
          .BYTE $1B    ;%00011011
          SEI
          .BYTE $AB    ;%10101011
          AND $AB70,X
          ROL $B378,X
          EOR $B370
          LSR $B378
L651E     .BYTE $4F    ;%01001111 'O'
          .BYTE $80    ;%10000000
          .BYTE $BB    ;%10111011
          EOR $BB70,X
          LSR $BB78,X
L6527     .BYTE $5F    ;%01011111 '_'
          .BYTE $80    ;%10000000
          .BYTE $9B    ;%10011011
          BIT $A380
          .BYTE $3C    ;%00111100 '<'
          .BYTE $80    ;%10000000
          .BYTE $AB    ;%10101011
L6530     JMP $A080
          BRK
L6534     LDA $6540,Y
          STA $0270,Y
          INY
          CPY #$9C
          BNE L6534
          RTS
          PHP
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          BPL L65AD
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          RTS
          BRK
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          RTS
          .BYTE $7F    ;%01111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          ROR A
          .BYTE $7F    ;%01111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          .BYTE $D4    ;%11010100
          .BYTE $33    ;%00110011 '3'
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          .BYTE $B2    ;%10110010
          .BYTE $93    ;%10010011
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          .BYTE $47    ;%01000111 'G'
          .BYTE $B3    ;%10110011
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          STA $0B,X
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          .BYTE $E2    ;%11100010
          .BYTE $1C    ;%00011100
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          .BYTE $34    ;%00110100 '4'
          STY $23
          .BYTE $22    ;%00100010 '"'
          CLC
          .BYTE $B2    ;%10110010
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          INC $2340
          .BYTE $22    ;%00100010 '"'
          .BYTE $22    ;%00100010 '"'
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          PLA
          .BYTE $1A    ;%00011010
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          BCC L6527
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          .BYTE $22    ;%00100010 '"'
          STA ($24,X)
          .BYTE $22    ;%00100010 '"'
          DEY
          ROR A
          BIT $23
          BNE L6531
          BIT $22
          LDY #$10
          BIT $23
          BVS L65A6
          AND $22
          .BYTE $42    ;%01000010 'B'
          LSR A
          AND $23
          ADC $2530,X
          .BYTE $22    ;%00100010 '"'
          BVC L65F7
          AND $23
          EOR #$50
          AND $22
          LDA $2591,Y
L65A6     .BYTE $23    ;%00100011 '#'
          BCS L65C2
          AND $22
          CPY #$53
L65AD     AND $23
          TSX
          LDY $25
          .BYTE $22    ;%00100010 '"'
          DEC $98,X
          AND $23
          .BYTE $1A    ;%00011010
          PLA
          AND $22
          .BYTE $0C    ;%00001100
          .BYTE $97    ;%10010111
          AND $23
          NOP
          .BYTE $33    ;%00110011 '3'
          AND $22
          .BYTE $92    ;%10010010
          .BYTE $43    ;%01000011 'C'
          AND $23
          ADC $AC
          AND $22
          LSR A
          ROL A
          AND $23
          ADC ($7C),Y
          ROL $22
          .BYTE $B2    ;%10110010
          .BYTE $73    ;%01110011 's'
          ROL $23
          .BYTE $E7    ;%11100111
          .BYTE $0C    ;%00001100
          ROL $22
          TAX
L65DC     JSR L65E7
          LDA #$28
          LDX #$FF
          LDY #$00
          BEQ L65ED
L65E7     LDA #$20
          LDX #$FF
          LDY #$00
L65ED     STX $02
          STY $03
          STA $01
          LDA $2002
          LDA $FF
          AND #$FB
          STA $2000
          STA $FF
          LDA $01
          STA $2006
          LDA #$00
          STA $2006
          LDX #$04
          LDY #$00
          LDA $02
L660F     STA $2007
          DEY
          BNE L660F
          DEX
          BNE L660F
          LDA $01
          CLC
          ADC #$03
          STA $2006
          LDA #$C0
          STA $2006
          LDY #$40
          LDA $03
L6629     STA $2007
          DEY
          BNE L6629
          RTS
L6630     LDY #$00
          LDA #$F4
L6634     STA $0200,Y
          DEY
          BNE L6634
L663A     RTS
L663B     LDA $34
          BEQ L663A
          ASL A
          TAY
          LDA $665B,Y
          LDX $665A,Y
          TAY
          JSR L671E
          LDA #$3F
          STA $2006
          LDA #$00
          STA $2006
          STA $2006
          STA $2006
          RTS
          .BYTE $C3    ;%11000011
          .BYTE $67    ;%01100111 'g'
          .BYTE $E7    ;%11100111
          .BYTE $67    ;%01100111 'g'
          .BYTE $F2    ;%11110010
          .BYTE $67    ;%01100111 'g'
          SBC $0867,X
          PLA
          .BYTE $13    ;%00010011
          PLA
          ASL $2968,X
          PLA
          .BYTE $34    ;%00110100 '4'
          PLA
          EOR $6668
          PLA
L6672     LDX #$01
          STX $4016
          DEX
          TXA
          STA $4016
          JSR L6680
          INX
L6680     LDY #$08
L6682     PHA
          LDA $4016,X
          STA $00
          LSR A
          ORA $00
          LSR A
          PLA
          ROL A
          DEY
          BNE L6682
          LDY $40,X
          STY $00
          CMP $48,X
          BNE L66A6
          INC $4A,X
          LDY $4A,X
          CPY #$03
          BCC L66AC
          STA $4C,X
          JMP L66A8
L66A6     STA $48,X
L66A8     LDA #$00
          STA $4A,X
L66AC     LDA $4C,X
          STA $40,X
          EOR $00
          AND $40,X
          STA $42,X
          STA $44,X
          LDY #$40
          LDA $40,X
          CMP $00
          BNE L66C8
          DEC $46,X
          BNE L66CA
          STA $44,X
          LDY #$08
L66C8     STY $46,X
L66CA     RTS
L66CB     LDA $31
          BEQ L66E0
          LDX #$61
          LDY #$06
          JSR L671E
          LDA #$00
          STA $0660
          STA $0661
          STA $31
L66E0     LDA $FF
          AND #$FB
          STA $FF
          STA $2000
          RTS
L66EA     LDX #$03
          DEC $28
          BPL L66F6
          LDA #$0A
          STA $28
          LDX #$05
L66F6     LDA $29,X
          BEQ L66FC
          DEC $29,X
L66FC     DEX
          BPL L66F6
          RTS
L6700     STX $E0
          STY $E1
          ASL A
          TAY
          INY
          PLA
          STA $14
          PLA
          STA $15
          LDA ($14),Y
          TAX
          INY
          LDA ($14),Y
          STA $15
          STX $14
          LDX $E0
          LDY $E1
          JMP ($0014)
L671E     STX $00
          STY $01
          JMP L6761
L6725     STA $2006
          INY
          LDA ($00),Y
          STA $2006
          INY
          LDA ($00),Y
          ASL A
          PHA
          LDA $FF
          ORA #$04
          BCS L673B
          AND #$FB
L673B     STA $2000
          STA $FF
          PLA
          ASL A
          BCC L6747
          ORA #$02
          INY
L6747     LSR A
          LSR A
          TAX
L674A     BCS L674D
          INY
L674D     LDA ($00),Y
          STA $2007
          DEX
          BNE L674A
          SEC
          TYA
          ADC $00
          STA $00
          LDA #$00
          ADC $01
          STA $01
L6761     LDX $2002
          LDY #$00
          LDA ($00),Y
          BNE L6725
L676A     PHA
          LDA #$00
          STA $2005
          LDA $FC
          STA $2005
          PLA
          RTS
L6777     LDA $0618
          CLC
          ADC #$0F
          ADC $0619
          ADC $061A
          ADC $061B
          STA $0618
          LDA $0619
          ADC #$11
          STA $0619
          EOR $0618
          CLC
          BPL L6798
          SEC
L6798     ROR $061A
          ROR $061B
          LDA $0618
          RTS
          STX $0660
          LDA #$00
          STA $0661,X
          LDA #$01
          STA $31
          RTS
          STA $0661,X
          INX
          TXA
          CMP #$55
          BCC L67C2
          LDX $0660
L67BB     LDA #$00
          STA $0661,X
          BEQ L67BB
L67C2     RTS
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $210F
          ORA ($02),Y
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          PLP
          CLC
          PHP
          .BYTE $0F    ;%00001111
          ASL $19,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          ROL $15,X
          .BYTE $17    ;%00010111
          .BYTE $0F    ;%00001111
          .BYTE $12    ;%00010010
          AND ($20,X)
          .BYTE $0F    ;%00001111
          AND $12,X
          ASL $00,X
          .BYTE $3F    ;%00111111 '?'
          ORA $1007,Y
          JSR $0F30
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          BRK
          .BYTE $3F    ;%00111111 '?'
          ORA $1207,Y
          .BYTE $22    ;%00100010 '"'
          .BYTE $32    ;%00110010 '2'
          .BYTE $0F    ;%00001111
          .BYTE $0B    ;%00001011
          .BYTE $1B    ;%00011011
          .BYTE $2B    ;%00101011 '+'
          BRK
          .BYTE $3F    ;%00111111 '?'
          ORA $1407,Y
          BIT $34
          .BYTE $0F    ;%00001111
          ORA #$19
          AND #$00
          .BYTE $3F    ;%00111111 '?'
          ORA $1607,Y
          ROL $36
          .BYTE $0F    ;%00001111
          .BYTE $07    ;%00000111
          .BYTE $17    ;%00010111
          .BYTE $27    ;%00100111 '''
          BRK
          .BYTE $3F    ;%00111111 '?'
          ORA $1807,Y
          PLP
          SEC
          .BYTE $0F    ;%00001111
          ORA $15
          AND $00
          .BYTE $3F    ;%00111111 '?'
          ORA $1A07,Y
          ROL A
          .BYTE $3A    ;%00111010 ':'
          .BYTE $0F    ;%00001111
          .BYTE $03    ;%00000011
          .BYTE $13    ;%00010011
          .BYTE $13    ;%00010011
          BRK
          .BYTE $3F    ;%00111111 '?'
          ORA $1C07,Y
          BIT $0F3C
          ORA ($11,X)
          AND ($00,X)
          .BYTE $3F    ;%00111111 '?'
          ORA $1803
          PHP
          .BYTE $07    ;%00000111
          .BYTE $3F    ;%00111111 '?'
          ORA ($0F),Y
          ROL $05
          .BYTE $07    ;%00000111
          .BYTE $0F    ;%00001111
          ROL $05
          .BYTE $07    ;%00000111
          .BYTE $0F    ;%00001111
          ORA ($01,X)
          ORA $0F
          .BYTE $13    ;%00010011
          .BYTE $1C    ;%00011100
          .BYTE $0C    ;%00001100
          BRK
          .BYTE $3F    ;%00111111 '?'
          ORA $0803
          .BYTE $07    ;%00000111
          .BYTE $0F    ;%00001111
          .BYTE $3F    ;%00111111 '?'
          ORA ($0F),Y
          ASL $08
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          ASL $08
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          BRK
          BPL L6870
          .BYTE $0F    ;%00001111
          ORA ($0C,X)
          .BYTE $0F    ;%00001111
          BRK
          .BYTE $3F    ;%00111111 '?'
          ORA $0F43
          .BYTE $3F    ;%00111111 '?'
          ORA ($4F),Y
          .BYTE $0F    ;%00001111
          BRK
          .BYTE $23    ;%00100011 '#'
L6870     BRK
          JSR $3130
          BMI L68A7
          BMI L68A9
          BMI L68AB
          BMI L68AD
          BMI L68AF
          BMI L68B1
          BMI L68B3
          BMI L68B5
          BMI L68B7
          BMI L68B9
          BMI L68BB
          BMI L68BD
          BMI L68BF
          BMI L68C1
          BMI L68C3
          .BYTE $23    ;%00100011 '#'
          JSR $3220
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68A7     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68A9     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68AB     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68AD     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68AF     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68B1     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68B3     .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
L68B5     .BYTE $23    ;%00100011 '#'
          RTI
L68B7     JSR $3534
          .BYTE $34    ;%00110100 '4'
L68BB     AND $34,X
L68BD     AND $34,X
L68BF     AND $34,X
L68C1     AND $34,X
L68C3     AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $34,X
          AND $23,X
          RTS
          JSR $3736
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          ROL $37,X
          .BYTE $23    ;%00100011 '#'
          .BYTE $80    ;%10000000
          JSR $3938
          SEC
          AND $3938,Y
          SEC
          AND $3938,Y
          SEC
          AND $3938,Y
          SEC
          AND $3938,Y
          SEC
          AND $3938,Y
          SEC
          AND $3938,Y
          SEC
          AND $3938,Y
          SEC
          AND $A023,Y
          JSR $3B3A
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $23    ;%00100011 '#'
          BEQ L6994
          .BYTE $FF    ;%11111111
          PLP
          ROL $1C05
          ORA $0F0A,X
          .BYTE $0F    ;%00001111
          PLP
          TAY
          .BYTE $13    ;%00010011
          .BYTE $1C    ;%00011100
          .BYTE $0C    ;%00001100
          ASL $0A17
          .BYTE $1B    ;%00011011
          .BYTE $12    ;%00010010
          CLC
          .BYTE $FF    ;%11111111
          JSR $121B
          ORA $0E1D,X
          .BYTE $17    ;%00010111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          PLP
          INC $1405
          ASL A
          .BYTE $17    ;%00010111
          CLC
          ORA ($29),Y
          ROR $15
          .BYTE $0C    ;%00001100
          ORA ($0A),Y
          .BYTE $1B    ;%00011011
          ASL A
          .BYTE $0C    ;%00001100
          ORA $1B0E,X
          .BYTE $FF    ;%11111111
          ORA $1C0E
          .BYTE $12    ;%00010010
          BPL L6995
          ASL $FF0D
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          AND #$AC
          PHP
          .BYTE $14    ;%00010100
          .BYTE $12    ;%00010010
          .BYTE $22    ;%00100010 '"'
          CLC
          ORA $140A,X
          ASL $2B2A
          .BYTE $0C    ;%00001100
          .BYTE $17    ;%00010111
          ASL $FF20
L6995     ASL $0A,X
          ORA $1E1C,X
          CLC
          .BYTE $14    ;%00010100
          ASL A
          ROL A
          JMP ($1C09)
          ORA ($12),Y
          .BYTE $14    ;%00010100
          ASL A
          ASL $18,X
          ORA $2A18,X
          CPX $1608
          ASL $121C,X
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          .BYTE $2B    ;%00101011 '+'
          .BYTE $2B    ;%00101011 '+'
          ASL A
          ORA ($12),Y
          ORA $1DFF,Y
          ASL A
          .BYTE $17    ;%00010111
          ASL A
          .BYTE $14    ;%00010100
          ASL A
          .BYTE $2B    ;%00101011 '+'
          .BYTE $A7    ;%10100111
          .BYTE $12    ;%00010010
          ASL $0A,X
          .BYTE $12    ;%00010010
          .BYTE $17    ;%00010111
          .BYTE $FF    ;%11111111
          ORA $181B,Y
          BPL L69E9
          ASL A
          ASL $16,X
          ASL $FF0D
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          BRK
          .BYTE $DF    ;%11011111
          ADC #$08
          ROR A
          BMI L6A47
          ADC ($6A,X)
          JSR $086D
          BPL L69FF
          ASL $1D0A
          .BYTE $FF    ;%11111111
          .BYTE $3F    ;%00111111 '?'
L69E9     .BYTE $3F    ;%00111111 '?'
          JSR $1AC3
          .BYTE $22    ;%00100010 '"'
          CLC
          ASL $0FFF,X
          ASL $0F15,X
          .BYTE $12    ;%00010010
          ORA $0E,X
          ORA $22FF
          CLC
          ASL $FF1B,X
L69FF     ASL $12,X
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $12    ;%00010010
          CLC
          .BYTE $17    ;%00010111
          .BYTE $07    ;%00000111
          BRK
          AND ($03,X)
          .BYTE $17    ;%00010111
          .BYTE $12    ;%00010010
          ORA $20FF,X
          .BYTE $12    ;%00010010
          ORA $15,X
          .BYTE $FF    ;%11111111
          .BYTE $1B    ;%00011011
          ASL $121F
          .BYTE $1F    ;%00011111
          ASL $19FF
          ASL $0C0A
          ASL $12FF
          .BYTE $17    ;%00010111
          AND ($42,X)
          ASL A
          ORA $0E11,X
          .BYTE $FF    ;%11111111
          .BYTE $1C    ;%00011100
          ORA $0C0A,Y
          ASL $0007
          AND ($83,X)
          CLC
          .BYTE $0B    ;%00001011
          ASL $001D,X
          .BYTE $12    ;%00010010
          ORA $16FF,X
          ASL A
          .BYTE $22    ;%00100010 '"'
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          ASL $12FF
          .BYTE $17    ;%00010111
          .BYTE $1F    ;%00011111
          ASL A
          ORA $0D0E
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          AND ($C2,X)
          .BYTE $12    ;%00010010
          ORA $0E11,X
          .BYTE $FF    ;%11111111
          CLC
          ORA $0E11,X
          .BYTE $1B    ;%00011011
          .BYTE $FF    ;%11111111
          ASL $0E,X
          ORA $181B,X
          .BYTE $12    ;%00010010
          ORA $0007
          .BYTE $22    ;%00100010 '"'
          .BYTE $03    ;%00000011
          CLC
          ORA $0A1B,Y
          .BYTE $22    ;%00100010 '"'
          .BYTE $FF    ;%11111111
          .BYTE $0F    ;%00001111
          CLC
          .BYTE $1B    ;%00011011
          .BYTE $FF    ;%11111111
          ASL A
          .BYTE $FF    ;%11111111
          ORA $1E1B,X
          ASL $19FF
          ASL $0C0A
          ASL $12FF
          .BYTE $17    ;%00010111
          .BYTE $22    ;%00100010 '"'
          .BYTE $42    ;%01000010 'B'
          ASL A
          ORA $0E11,X
          .BYTE $FF    ;%11111111
          .BYTE $1C    ;%00011100
          ORA $0C0A,Y
          ASL $003F
          .BYTE $92    ;%10010010
          ROR A
          .BYTE $9B    ;%10011011
          ROR A
          LDY $6A
          LDA $206A
          ADC $FF48
          JSR $5AC3
          .BYTE $FF    ;%11111111
          BRK
          AND ($03,X)
          .BYTE $57    ;%01010111 'W'
          .BYTE $FF    ;%11111111
          AND ($42,X)
          LSR A
          .BYTE $FF    ;%11111111
          BRK
          AND ($83,X)
          CLI
          .BYTE $FF    ;%11111111
          AND ($C2,X)
          .BYTE $52    ;%01010010 'R'
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $22    ;%00100010 '"'
          .BYTE $03    ;%00000011
          CLI
          .BYTE $FF    ;%11111111
          .BYTE $22    ;%00100010 '"'
          .BYTE $42    ;%01000010 'B'
          LSR A
          .BYTE $FF    ;%11111111
          BRK
          ASL $206B
          .BYTE $6B    ;%01101011 'k'
          .BYTE $3F    ;%00111111 '?'
          .BYTE $6B    ;%01101011 'k'
          RTI
          .BYTE $6B    ;%01101011 'k'
          .BYTE $52    ;%01010010 'R'
          .BYTE $6B    ;%01101011 'k'
          LSR $746B,X
          .BYTE $6B    ;%01101011 'k'
          .BYTE $87    ;%10000111
          .BYTE $6B    ;%01101011 'k'
          TXS
          .BYTE $6B    ;%01101011 'k'
          LDA #$6B
          CPY $6B
          .BYTE $CF    ;%11001111
          .BYTE $6B    ;%01101011 'k'
          SBC $FD6B
          .BYTE $6B    ;%01101011 'k'
          ASL $6C,X
          .BYTE $37    ;%00110111 '7'
          JMP (L6C3C)
          .BYTE $4B    ;%01001011 'K'
          JMP (L6C67)
          BCC L6B4A
          STA $6C,X
          CLV
          JMP (L6CC1)
          .BYTE $D2    ;%11010010
          JMP (L6CE2)
          .BYTE $F2    ;%11110010
          JMP (L6CF7)
          .BYTE $FC    ;%11111100
          JMP (L6D01)
          ASL $6D
          .BYTE $0B    ;%00001011
          ADC $6D10
          .BYTE $14    ;%00010100
          ADC $6D15
          AND $3F6D
          ADC $6D44
          EOR #$6D
          .BYTE $44    ;%01000100 'D'
          ADC $6D49
          EOR $626D,X
          ADC $6D5D
          .BYTE $62    ;%01100010 'b'
          ADC $2C20
          ASL A
          ORA ($0A),Y
          .BYTE $12    ;%00010010
          .BYTE $FF    ;%11111111
          .BYTE $22    ;%00100010 '"'
          ASL $0A14,X
          ASL $12,X
          .BYTE $23    ;%00100011 '#'
          CPY #$60
          BRK
          BRK
          JSR $0D6A
          .BYTE $23    ;%00100011 '#'
          ASL A
          .BYTE $1B    ;%00011011
          ASL $1CFF,X
          CLC
          .BYTE $0B    ;%00001011
          ASL A
          .BYTE $13    ;%00010011
          .BYTE $12    ;%00010010
          ASL $0A,X
          JSR $0BAB
          BPL L6B4E
          .BYTE $23    ;%00100011 '#'
          .BYTE $FF    ;%11111111
          .BYTE $1C    ;%00011100
          ASL $1017
          CLC
          .BYTE $14    ;%00010100
          ASL $0000,X
          AND ($6A,X)
          ASL A
          .BYTE $17    ;%00010111
          .BYTE $07    ;%00000111
          .BYTE $1C    ;%00011100
          ORA ($12),Y
          CLC
          ORA $170A,X
          .BYTE $12    ;%00010010
          .BYTE $23    ;%00100011 '#'
L6B4E     CPX #$60
          BRK
          BRK
          AND ($EB,X)
          PHP
          ASL $07,X
          ORA ($18),Y
          ASL $0A0D,X
          .BYTE $12    ;%00010010
          BRK
          .BYTE $22    ;%00100010 '"'
          .BYTE $A7    ;%10100111
          .BYTE $12    ;%00010010
          .BYTE $1C    ;%00011100
          ORA $0C0E,Y
          .BYTE $12    ;%00010010
          ASL A
          ORA $FF,X
          ORA $0A11,X
          .BYTE $17    ;%00010111
          .BYTE $14    ;%00010100
          .BYTE $1C    ;%00011100
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $0018,X
          .BYTE $22    ;%00100010 '"'
          CPX $1408
          ASL $FF17
          .BYTE $23    ;%00100011 '#'
          ASL $121B,X
          .BYTE $23    ;%00100011 '#'
          ROL $1C04
          ASL $1216,X
          BRK
          .BYTE $23    ;%00100011 '#'
          JMP ($1207)
          .BYTE $17    ;%00010111
          ASL $0A1C,X
          JSR $230A
          LDA $1405
          ASL A
          .BYTE $0C    ;%00001100
          ORA ($18),Y
          BRK
          PLP
          PLP
          LSR $28FF
          JMP ($1107)
          .BYTE $22    ;%00100010 '"'
          ASL A
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          ASL A
          .BYTE $17    ;%00010111
          BRK
          PLP
          TAY
          .BYTE $13    ;%00010011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BPL L6BCB
          .BYTE $22    ;%00100010 '"'
          ASL A
          .BYTE $14    ;%00010100
          ASL $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          PLP
          INX
          .BYTE $4F    ;%01001111 'O'
          .BYTE $FF    ;%11111111
          BRK
          AND #$2C
          .BYTE $07    ;%00000111
          ORA ($0A),Y
          .BYTE $1B    ;%00011011
          ASL A
L6BCB     ORA $FF0A
          BRK
          AND #$66
          ASL $FF,X
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA $170E,Y
          ORA $170E,Y
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          AND #$A8
          .BYTE $4F    ;%01001111 'O'
          .BYTE $FF    ;%11111111
          BRK
          AND #$EA
          .BYTE $0C    ;%00001100
          ORA $1118,X
          .BYTE $1B    ;%00011011
          .BYTE $22    ;%00100010 '"'
          ASL $FFFF,X
          ASL $0A,X
          .BYTE $14    ;%00010100
          CLC
          BRK
          ROL A
          ROL $11
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          ASL $1417
          ASL $FF12
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ROL A
          .BYTE $67    ;%01100111 'g'
          EOR ($FF),Y
          BRK
          ROL A
          .BYTE $EB    ;%11101011
          .BYTE $0B    ;%00001011
          ASL A
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          .BYTE $12    ;%00010010
          .BYTE $1C    ;%00011100
          ORA $0D0E,X
          .BYTE $FF    ;%11111111
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          .BYTE $2B    ;%00101011 '+'
          PLP
          .BYTE $0F    ;%00001111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $0A,X
          .BYTE $14    ;%00010100
          CLC
          ORA $FF18,X
          .BYTE $14    ;%00010100
          ASL A
          .BYTE $17    ;%00010111
          CLC
          ORA ($00),Y
          .BYTE $2B    ;%00101011 '+'
          LDX $53
          .BYTE $FF    ;%11111111
          BRK
L6C3C     JSR $0B2B
          ORA $1B12
          ASL $1D0C
          ASL $FF0D
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          BRK
          JSR $1467
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $22    ;%00100010 '"'
          ASL A
          ASL $0A,X
          ASL $18,X
          ORA $FF18,X
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          JSR $4EAA
          .BYTE $FF    ;%11111111
          BRK
L6C67     AND ($27,X)
          ORA ($0C),Y
          ORA ($12),Y
          ASL $FF0F
          ORA $1B12
          ASL $1D0C
          ASL $FF0D
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          AND ($68,X)
          ORA ($FF),Y
          .BYTE $FF    ;%11111111
          .BYTE $1C    ;%00011100
          ASL A
          ORA $1B18,X
          ASL $18FF,X
          .BYTE $14    ;%00010100
          ASL A
          ORA $FF0A
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          AND ($E6,X)
          CLI
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $22    ;%00100010 '"'
          .BYTE $2B    ;%00101011 '+'
          BPL L6CB2
          .BYTE $1B    ;%00011011
          CLC
          ORA $0C1E
          ASL $FF0D
          .BYTE $0B    ;%00001011
          .BYTE $22    ;%00100010 '"'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $22    ;%00100010 '"'
          ROR A
          .BYTE $0C    ;%00001100
          BPL L6CCB
          .BYTE $17    ;%00010111
          ORA $120E,Y
          .BYTE $FF    ;%11111111
L6CB2     .BYTE $22    ;%00100010 '"'
          CLC
          .BYTE $14    ;%00010100
          CLC
          .BYTE $12    ;%00010010
          BRK
          .BYTE $22    ;%00100010 '"'
          LDX $53
          .BYTE $FF    ;%11111111
          .BYTE $22    ;%00100010 '"'
          INX
          .BYTE $4F    ;%01001111 'O'
          .BYTE $FF    ;%11111111
          BRK
L6CC1     .BYTE $23    ;%00100011 '#'
          AND #$4D
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $4B    ;%01001011 'K'
          ORA #$0C
          CLC
          ORA $1B22,Y
          .BYTE $12    ;%00010010
          BPL L6CE1
          ORA $2300,X
          .BYTE $6B    ;%01101011 'k'
          LSR A
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          STX $0104
          ORA #$08
          ASL $23
          TAY
          .BYTE $4F    ;%01001111 'O'
          .BYTE $FF    ;%11111111
L6CE1     BRK
L6CE2     PLP
          .BYTE $0C    ;%00001100
          PHP
          .BYTE $17    ;%00010111
          .BYTE $12    ;%00010010
          .BYTE $17    ;%00010111
          ORA $170E,X
          ORA $2818
          ROR $51
          .BYTE $FF    ;%11111111
          BRK
          PLP
          TAX
          JMP $00FF
L6CF7     AND #$26
          .BYTE $5B    ;%01011011 '['
          .BYTE $FF    ;%11111111
          BRK
          AND #$67
          .BYTE $52    ;%01010010 'R'
          .BYTE $FF    ;%11111111
          BRK
L6D01     AND #$E6
          .BYTE $54    ;%01010100 'T'
          .BYTE $FF    ;%11111111
          BRK
          ROL A
          PLP
          EOR $FF,X
          BRK
          ROL A
          INC $50
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $2B    ;%00101011 '+'
          AND #$4E
          .BYTE $FF    ;%11111111
          BRK
          JSR $1426
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BIT $25
          ROL $27
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BIT $2E2D
          .BYTE $2F    ;%00101111 '/'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          JSR $0A4B
          PLP
          AND #$2A
          .BYTE $2B    ;%00101011 '+'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $20
          ROR A
          JMP $00FF
          AND ($26,X)
          .BYTE $53    ;%01010011 'S'
          .BYTE $FF    ;%11111111
          BRK
          AND ($6A,X)
          JMP $00FF
          AND ($88,X)
          ORA ($19),Y
          ASL $111C,X
          .BYTE $FF    ;%11111111
          .BYTE $1C    ;%00011100
          ORA $1B0A,X
          ORA $0BFF,X
          ASL $1D1D,X
          CLC
          .BYTE $17    ;%00010111
          .BYTE $22    ;%00100010 '"'
          ROL $4B
          .BYTE $FF    ;%11111111
          BRK
          BRK
          RTS
          LDX $27
          BNE $6D84
          JSR $6DBE
          LDA $B416
          CMP #$C2
          BNE $6D84
          LDA $B417
          SBC #$01
          BNE $6D84
          STA $B416
          STA $B417
          LDX #$00

