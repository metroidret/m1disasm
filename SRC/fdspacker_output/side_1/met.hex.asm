          * = $D000
          LDX #$00
          STX $01
          JSR LD00B
          LDX $2B
          INC $01
LD00B     LDY #$01
          STY $4016
          DEY
          STY $4016
          LDY #$08
LD016     PHA
          LDA $4016,X
          STA $00
          LSR A
          ORA $00
          LSR A
          PLA
          ROL A
          DEY
          BNE LD016
          LDX $01
          LDY $14,X
          STY $00
          STA $14,X
          EOR $00
          BEQ LD039
          LDA $00
          AND #$BF
          STA $00
          EOR $14,X
LD039     AND $14,X
          STA $12,X
          STA $16,X
          LDY #$20
          LDA $14,X
          CMP $00
          BNE LD04F
          DEC $18,X
          BNE LD051
          STA $16,X
          LDY #$10
LD04F     STY $18,X
LD051     RTS
          LDA $FE
          AND #$E7
LD056     STA $FE
          JSR $95A1
LD05B     LDA $1A
          BEQ LD05B
          RTS
          LDA $FF
          AND #$F7
          ORA #$10
          STA $FF
          LDA $FE
          ORA #$18
          BNE LD056
          LDA $FF
          STA $2000
          LDA $FE
          STA $2001
          LDA $73
          STA $FB
          STA $4025
          RTS
          BRK
          BPL LD084
          CLC
LD084     BRK
          ORA ($38,X)
          ORA ($02,X)
          RTI
          BRK
          ORA #$58
          CLC
          .BYTE $7F    ;%01111111
          .BYTE $0F    ;%00001111
          LDY #$0D
          .BYTE $7F    ;%01111111
          .BYTE $0F    ;%00001111
LD094     PHP
          .BYTE $1B    ;%00011011
          .BYTE $7F    ;%01111111
          .BYTE $0B    ;%00001011
          CLC
          .BYTE $89    ;%10001001
          .BYTE $7F    ;%01111111
          .BYTE $67    ;%01100111 'g'
          CLC
          .BYTE $8B    ;%10001011
          .BYTE $7F    ;%01111111
LD09F     SBC $0228,X
          .BYTE $7F    ;%01111111
          TAY
          SED
          INC $83,X
          CLI
          SEI
          STX $8C,Y
          RTI
          LDA $9A1D,Y
          JSR $168F
          STA $42E0
          TXS
          .BYTE $7F    ;%01111111
          CLD
          PLP
          TXS
          .BYTE $7F    ;%01111111
          CPX #$28
          CPX #$D0
          .BYTE $27    ;%00100111 '''
          CMP ($01),Y
          BEQ LD094
          CLD
          .BYTE $D2    ;%11010010
          ORA ($00,X)
          CMP ($35),Y
          CMP ($02),Y
          BPL LD09F
          CLD
          .BYTE $D2    ;%11010010
          .BYTE $02    ;%00000010
          TAY
          CLD
          CLD
          .BYTE $D2    ;%11010010
          .BYTE $04    ;%00000100
          CLV
          CLD
          CMP $00D8,X
          CLV
          CLD
          .BYTE $CF    ;%11001111
          CLD
          BRK
          PLA
          .BYTE $D3    ;%11010011
          .BYTE $82    ;%10000010
          .BYTE $D3    ;%11010011
          .BYTE $B7    ;%10110111
          .BYTE $D3    ;%11010011
          TAX
          .BYTE $D3    ;%11010011
          LDX $A4D3,Y
          .BYTE $D3    ;%11010011
          .BYTE $9E    ;%10011110
          .BYTE $D3    ;%11010011
          CPY $D3
          .BYTE $4B    ;%01001011 'K'
          .BYTE $D3    ;%11010011
          ROR $88D3
          .BYTE $D3    ;%11010011
          DEY
          .BYTE $D3    ;%11010011
          DEY
          .BYTE $D3    ;%11010011
          DEY
          .BYTE $D3    ;%11010011
          DEY
          .BYTE $D3    ;%11010011
          DEX
          .BYTE $D3    ;%11010011
          .BYTE $C3    ;%11000011
          .BYTE $D4    ;%11010100
          .BYTE $E2    ;%11100010
          .BYTE $D3    ;%11010011
          LDY #$D4
          LDA $ADDE
          DEC $D511,X
          .BYTE $44    ;%01000100 'D'
          .BYTE $D4    ;%11010100
          .BYTE $3C    ;%00111100 '<'
          CMP $D9,X
          .BYTE $D4    ;%11010100
          INC $AED4
          .BYTE $D4    ;%11010100
          DEC $DE
          LDX $DE,Y
          .BYTE $1A    ;%00011010
          CMP $52,X
          .BYTE $D4    ;%11010100
          INC $ADD4
          STA ($06,X)
          LDX #$BD
          BNE LD13A
          LDA $0689
          LDX #$C2
          BNE LD13A
LD12E     LDA $0682
          LDX #$C7
          BNE LD13A
          LDA $068A
          LDX #$CC
LD13A     JSR LD2A7
          JMP ($00E2)
LD140     LDA $0684
          LDX #$D1
          JSR LD2A7
          JSR LDD8E
          JSR LDD9F
          JMP ($00E2)
LD151     LDA #$00
          BEQ LD157
LD155     LDA #$0C
LD157     STA $E0
          LDA #$40
          STA $E1
          STY $E2
          LDA #$D0
          STA $E3
          LDY #$00
LD165     LDA ($E2),Y
          STA ($E0),Y
          INY
          TYA
          CMP #$04
          BNE LD165
          RTS
LD170     INC $0602
          JSR LD229
          STA $0603
          RTS
LD17A     LDA $0680
          AND #$FD
          STA $0680
          LDA $0602
          BEQ LD170
          LDA #$00
          STA $0602
LD18C     LDA #$C0
          STA $4017
          LDA $0680
          LSR A
          BCS LD1C3
          LSR A
          BCS LD17A
          LDA $0602
          BNE LD1C8
          JSR LD304
          JSR LD140
          JSR LD12E
          JSR LD120
          JSR LD8C8
          JSR LD7B8
LD1B1     LDA #$00
          STA $0680
          STA $0681
          STA $0682
          STA $0684
          STA $0685
          RTS
LD1C3     JSR LD1F2
          BEQ LD1B1
LD1C8     LDA $0603
          CMP #$12
          BEQ LD1DD
          AND #$03
          CMP #$03
          BNE LD1DA
          LDY #$99
          JSR LD151
LD1DA     INC $0603
LD1DD     RTS
LD1DE     LDA $062C
          BEQ LD1F2
          LDA $068D
          STA $065D
          RTS
LD1EA     LDA $068D
          CMP $064D
          BEQ LD1F8
LD1F2     JSR LD20B
          JSR LD229
LD1F8     JSR LD1FC
          RTS
LD1FC     LDA #$00
          STA $062D
          STA $0602
          STA $065D
          STA $062C
          RTS
LD20B     LDA #$00
          STA $0653
          STA $0656
          STA $0615
          STA $0607
          STA $0688
          STA $0689
          STA $068A
          STA $068C
          STA $068D
          RTS
LD229     JSR LD240
          LDA #$10
          STA $4000
          STA $4004
          STA $400C
          LDA #$00
          STA $4008
          STA $4011
          RTS
LD240     LDA #$80
          STA $4080
          RTS
LD246     LDX $065C
          STA $0660,X
          TXA
          BEQ LD261
          CMP #$01
          BEQ LD258
          CMP #$02
          BEQ LD25E
          RTS
LD258     JSR LD151
          JMP LD264
LD25E     JMP LD264
LD261     JSR LD155
LD264     JSR LD27D
          TXA
          STA $0652,X
          LDA #$00
          STA $0665,X
          STA $0670,X
          STA $0674,X
          STA $0678,X
          STA $0607
          RTS
LD27D     LDX $065C
          LDA $0688,X
          AND #$00
          ORA $064D
          STA $0688,X
          RTS
LD28C     LDA #$00
          STA $064D
          BEQ LD27D
LD293     LDX $065C
          INC $0665,X
          LDA $0665,X
          CMP $0660,X
          BNE LD2A6
          LDA #$00
          STA $0665,X
LD2A6     RTS
LD2A7     STA $064D
          STX $E4
          LDY #$D0
          STY $E5
          LDY #$00
LD2B2     LDA ($E4),Y
          STA $00E0,Y
          INY
          TYA
          CMP #$04
          BNE LD2B2
          LDA ($E4),Y
          STA $065C
          LDY #$00
          LDA $064D
          PHA
LD2C8     ASL $064D
          BCS LD2D9
          INY
          INY
          TYA
          CMP #$10
          BNE LD2C8
LD2D4     PLA
          STA $064D
          RTS
LD2D9     LDA ($E0),Y
          STA $E2
          INY
          LDA ($E0),Y
          STA $E3
          JMP LD2D4
LD2E5     INC $0670
          LDA $0670
          STA $400E
          RTS
LD2EF     LDA #$16
          LDY #$8D
          JSR LD32D
          LDA #$0A
          STA $0670
          RTS
LD2FC     JSR LD293
          BNE LD2E5
          JMP LD335
LD304     LDA #$00
          STA $065C
          LDA $0680
          STA $064D
          ASL A
          ASL A
          ASL A
          BCS LD2EF
          ASL A
          BCS LD329
          ASL A
          BCS LD33E
          LDA $0688
          AND #$20
          BNE LD2FC
          LDA $0688
          AND #$DC
          BNE LD330
          RTS
LD329     LDA #$30
          LDY #$91
LD32D     JMP LD246
LD330     JSR LD293
          BNE LD33D
LD335     JSR LD28C
          LDA #$10
          STA $400C
LD33D     RTS
LD33E     LDA #$03
          LDY #$95
          BNE LD32D
          LDA $7E8D,X
          LSR $3E46,X
          BRK
          JSR LD293
          BNE LD367
          LDY $0671
          LDA $D344,Y
          BNE LD35B
          JMP LD38D
LD35B     STA $4002
          LDA $D0A0
          STA $4003
          INC $0671
LD367     RTS
          LDA #$05
          LDY #$9D
          BNE LD3BB
          JSR LD293
          BNE LD367
          INC $0671
          LDA $0671
          CMP #$03
          BEQ LD38D
          LDY #$99
          JMP LD151
          LDA #$06
          LDY #$99
          BNE LD3BB
          JSR LD293
          BNE LD367
LD38D     LDA #$10
          STA $4000
          LDA #$00
          STA $0653
          JSR LD28C
          INC $0607
          RTS
          LDA #$0C
          LDY #$A9
          BNE LD3BB
          LDA #$08
          LDY #$AD
          BNE LD3BB
          LDA $0689
          AND #$CC
          BNE LD367
          LDA #$06
          LDY #$A5
          BNE LD3BB
          LDA #$0B
          LDY #$A1
LD3BB     JMP LD246
          LDA #$16
          LDY #$B1
          BNE LD3BB
          LDA #$04
          LDY #$B5
          BNE LD3BB
          JSR LD293
          BNE LD3E1
          INC $0671
          LDA $0671
          CMP #$02
          BNE LD3DC
          JMP LD38D
LD3DC     LDY #$B9
          JSR LD151
LD3E1     RTS
          LDA $0615
          BNE LD3E1
          LDA $28
          AND #$03
          ORA #$03
          LDX #$F4
          LDY #$D3
          JMP LDD0E
          BIT $AEDB
          .BYTE $DB    ;%11011011
          BRK
          LDY #$00
          .BYTE $07    ;%00000111
          BRK
          LDY #$A0
          TAY
          .BYTE $02    ;%00000010
          BIT $6EDB
          .BYTE $DB    ;%11011011
          LDY #$A0
          BRK
          BPL LD40A
LD40A     LDY #$0A
          CPX #$01
          BIT $2EDB
          .BYTE $DC    ;%11011100
          .BYTE $82    ;%10000010
          .BYTE $47    ;%01000111 'G'
          BRK
          ASL $00
          .BYTE $87    ;%10000111
          .BYTE $87    ;%10000111
          .BYTE $02    ;%00000010
          BRK
LD41B     LDA #$26
          LDX #$0E
          LDY #$D4
          JSR LDD0E
          LDA #$09
          STA $0676
          LDA $D415
          STA $0672
          LDA #$08
LD431     STA $067E
          LDA #$00
          STA $067F
          RTS
LD43A     LDA #$0E
          LDX #$01
          LDY #$D4
          JSR LDD0E
          RTS
          LDA $0615
          BNE LD451
          LDA $0686
          BEQ LD41B
          LSR A
          BCS LD43A
LD451     RTS
          LDA $0686
          BEQ LD472
          LSR A
          BCC LD451
          JSR LD293
          BNE LD462
LD45F     JMP LD4F3
LD462     INC $0672
          LDA $0672
          STA $4086
LD46B     JSR LD559
          JSR LD54C
          RTS
LD472     JSR LD293
          BEQ LD45F
          LDA $0667
          CMP #$19
          BNE LD483
          LDA #$F7
          STA $0676
LD483     LDA $0672
          CLC
          ADC $0676
          STA $0672
          STA $4086
          JMP LD46B
          BIT $2EDB
          .BYTE $DC    ;%11011100
          .BYTE $82    ;%10000010
          LSR A
          BRK
          BVS LD49C
LD49C     .BYTE $80    ;%10000000
          RTS
          BPL LD4A0
LD4A0     LDA #$30
          LDX #$93
          LDY #$D4
          JSR LDD0E
          LDA #$28
          JMP LD431
          JSR LD293
          BNE LD46B
          JMP LD4F3
          EOR $6EDB
          .BYTE $DB    ;%11011011
          .BYTE $82    ;%10000010
          BVC LD4BD
LD4BD     JSR $A004
          LDY #$98
          .BYTE $07    ;%00000111
          JSR LD1F2
          LDA #$50
          LDX #$B6
          LDY #$D4
          JSR LDD0E
          LDA #$E0
          STA $0672
          LDA #$1E
          JMP LD431
          JSR LD293
          BEQ LD4F3
          JSR LD56D
          JSR LD54C
          DEC $0672
          LDA $0672
          STA $4086
          RTS
          JSR LD293
          BNE LD503
LD4F3     LDA #$80
          STA $4080
          JSR LD28C
          LDA #$00
          STA $0656
          STA $0606
LD503     RTS
          BIT $AEDB
          .BYTE $DB    ;%11011011
          .BYTE $9B    ;%10011011
          .BYTE $07    ;%00000111
          BRK
          ADC ($00),Y
          BRK
          LDY #$F8
          .BYTE $02    ;%00000010
          LDA #$10
          LDX #$04
          LDY #$D5
          JMP LDD0E
          JSR LD293
          BNE LD522
          JMP LD4F3
LD522     LDA $0672
          CLC
          ADC #$12
          STA $0672
          STA $4082
LD52E     RTS
          BIT $EEDB
          .BYTE $DB    ;%11011011
          BRK
          LDY #$00
          .BYTE $27    ;%00100111 '''
          BRK
          BRK
          .BYTE $8B    ;%10001011
          .BYTE $FF    ;%11111111
          .BYTE $07    ;%00000111
          LDA $068A
          AND #$1C
          BNE LD52E
          LDA #$0E
          LDX #$2F
          LDY #$D5
          JMP LDD0E
LD54C     LDA $067C
          STA $4082
          LDA $067D
          STA $4083
          RTS
LD559     CLC
          LDA $067C
          ADC $067E
          STA $067C
          LDA $067D
          ADC $067F
          STA $067D
          RTS
LD56D     SEC
          LDA $067C
          SBC $067E
          STA $067C
          LDA $067D
          SBC $067F
          STA $067D
          RTS
LD581     LDA #$7F
          STA $0648
          STA $0649
          STX $0628
          STY $0629
          RTS
LD590     LDA $0640
          CMP #$01
          BNE LD59A
          STA $066A
LD59A     LDA $0641
          CMP #$01
          BNE LD5A4
          STA $066B
LD5A4     RTS
LD5A5     LDA $0607
          BEQ LD5C1
          LDA #$00
          STA $0607
          LDA $0648
          STA $4001
          LDA $0600
          STA $4002
          LDA $0601
          STA $4003
LD5C1     RTS
LD5C2     LDX #$00
          JSR LD5CC
          INX
          JSR LD5CC
          RTS
LD5CC     LDA $062E,X
          BEQ LD616
          STA $EB
          JSR LD5A5
          LDA $066C,X
          CMP #$10
          BEQ LD624
          LDY #$00
LD5DF     DEC $EB
          BEQ LD5E7
          INY
          INY
          BNE LD5DF
LD5E7     LDA $D958,Y
          STA $EC
          LDA $D959,Y
          STA $ED
          LDY $066A,X
          LDA ($EC),Y
          STA $EA
          CMP #$FF
          BEQ LD61B
          CMP #$F0
          BEQ LD620
          LDA $0628,X
          AND #$F0
          ORA $EA
          TAY
LD608     INC $066A,X
LD60B     LDA $0653,X
          BNE LD616
          TXA
          BEQ LD617
          STY $4004
LD616     RTS
LD617     STY $4000
          RTS
LD61B     LDY $0628,X
          BNE LD60B
LD620     LDY #$10
          BNE LD60B
LD624     LDY #$10
          BNE LD608
LD628     JSR LD1DE
          RTS
LD62C     JSR LD5C2
          RTS
LD630     JSR LD590
          LDA #$00
          TAX
          STA $064B
          BEQ LD64D
LD63B     TXA
          LSR A
          TAX
LD63E     INX
          TXA
          CMP #$04
          BEQ LD62C
          LDA $064B
          CLC
          ADC #$04
          STA $064B
LD64D     TXA
          ASL A
          TAX
          LDA $0630,X
          STA $E6
          LDA $0631,X
          STA $E7
          LDA $0631,X
          BEQ LD63B
          TXA
          LSR A
          TAX
          DEC $0640,X
          BNE LD63E
LD667     LDY $0638,X
          INC $0638,X
          LDA ($E6),Y
          BEQ LD628
          TAY
          CMP #$FF
          BEQ LD67F
          AND #$C0
          CMP #$C0
          BEQ LD68F
          JMP LD6A7
LD67F     LDA $0624,X
          BEQ LD69E
          DEC $0624,X
          LDA $063C,X
          STA $0638,X
          BNE LD69E
LD68F     TYA
          AND #$3F
          STA $0624,X
          DEC $0624,X
          LDA $0638,X
          STA $063C,X
LD69E     JMP LD667
LD6A1     JMP LD769
LD6A4     JMP LD742
LD6A7     TYA
          AND #$B0
          CMP #$B0
          BNE LD6CB
          TYA
          AND #$0F
          CLC
          ADC $062B
          TAY
          LDA $DE29,Y
          STA $0620,X
          TAY
          TXA
          CMP #$02
          BEQ LD6A4
LD6C2     LDY $0638,X
          INC $0638,X
          LDA ($E6),Y
          TAY
LD6CB     TXA
          CMP #$03
          BEQ LD6A1
          PHA
          LDX $064B
          LDA $DDAA,Y
          BEQ LD6E4
          STA $0600,X
          LDA $DDA9,Y
          ORA #$08
          STA $0601,X
LD6E4     TAY
          PLA
          TAX
          TYA
          BNE LD6F9
          LDA #$00
          STA $EA
          TXA
          CMP #$02
          BEQ LD6FE
          LDA #$10
          STA $EA
          BNE LD6FE
LD6F9     LDA $0628,X
          STA $EA
LD6FE     TXA
          DEC $0653,X
          CMP $0653,X
          BEQ LD73C
          INC $0653,X
          LDY $064B
          TXA
          CMP #$02
          BEQ LD717
          LDA $062E,X
          BNE LD71C
LD717     LDA $EA
          STA $4000,Y
LD71C     LDA $EA
          STA $066C,X
          LDA $0600,Y
          STA $4002,Y
          LDA $0601,Y
          STA $4003,Y
          LDA $0648,X
          STA $4001,Y
LD733     LDA $0620,X
          STA $0640,X
          JMP LD63E
LD73C     INC $0653,X
          JMP LD733
LD742     LDA $062D
          AND #$0F
          BNE LD763
          LDA $062D
          AND #$F0
          BNE LD754
          TYA
          JMP LD758
LD754     LDA #$FF
          BNE LD763
LD758     CLC
          ADC #$FF
          ASL A
          ASL A
          CMP #$3C
          BCC LD763
          LDA #$3C
LD763     STA $062A
          JMP LD6C2
LD769     LDA $0688
          AND #$FC
          BNE LD782
          LDA $D080,Y
          STA $400C
          LDA $D081,Y
          STA $400E
          LDA $D082,Y
          STA $400F
LD782     JMP LD733
LD785     STX $E0
          STY $E1
          LDY #$00
          LDA ($E0),Y
          STA $EE
          INY
          LDA ($E0),Y
          STA $EF
          LDX #$0D
          INY
LD797     LDA ($E0),Y
          STA $060E,Y
          INY
          DEX
          BNE LD797
          LDY #$00
          STY $060C
          STY $0606
          INY
          STY $060A
          RTS
LD7AD     LDA #$00
          STA $0615
          LDA #$80
          STA $4080
LD7B7     RTS
LD7B8     LDA $0615
          BEQ LD7B7
          DEC $060A
          BNE LD7B7
LD7C2     LDY $060C
          INC $060C
          LDA ($EE),Y
          BEQ LD7AD
          TAY
          CMP #$FF
          BEQ LD7DA
          AND #$C0
          CMP #$C0
          BEQ LD7EA
          JMP LD7FC
LD7DA     LDA $060D
          BEQ LD7F9
          DEC $060D
          LDA $060E
          STA $060C
          BNE LD7F9
LD7EA     TYA
          AND #$3F
          STA $060D
          DEC $060D
          LDA $060C
          STA $060E
LD7F9     JMP LD7C2
LD7FC     TYA
          AND #$B0
          CMP #$B0
          BNE LD81A
          TYA
          AND #$0F
          CLC
          ADC $0614
          TAY
          LDA $DE29,Y
          STA $060B
          LDY $060C
          INC $060C
          LDA ($EE),Y
          TAY
LD81A     LDA #$00
          STA $EA
          LDA $DCAF,Y
          BEQ LD82F
          STA $061D
          LDA $DCAE,Y
          STA $061E
          JMP LD833
LD82F     LDA #$FF
          STA $EA
LD833     LDA $0656
          BNE LD891
          LDA $0606
          BNE LD857
          INC $0606
          LDX $0610
          LDY $0611
          JSR LDAF4
          LDX $0612
          LDY $0613
          JSR LDB11
          LDA #$01
          STA $4089
LD857     LDA $0616
          STA $4084
          LDA $0617
          STA $4084
          LDA $0618
          STA $4085
          LDA $0619
          STA $4086
          LDA $061A
          STA $4087
          LDA $061B
          STA $4080
          LDA $EA
          BNE LD898
          LDA $061C
LD882     STA $4080
          LDA $061D
          STA $4082
          LDA $061E
          STA $4083
LD891     LDA $060B
          STA $060A
          RTS
LD898     LDA #$80
          BNE LD882
          EOR ($8F,X)
          .BYTE $34    ;%00110100 '4'
          .BYTE $27    ;%00100111 '''
          .BYTE $1A    ;%00011010
          ORA $8200
          PLA
          ADC $4E,X
          .BYTE $5B    ;%01011011 '['
          .BYTE $03    ;%00000011
          CMP $D8F1,Y
          BPL LD887
          .BYTE $AF    ;%10101111
          DEC $D2D8,X
          CLD
          .BYTE $D2    ;%11010010
          CMP ($DF),Y
          CLV
          .BYTE $DF    ;%11011111
          BRK
          CMP $D8EE,Y
          INC $EED8
          CLD
          SBC $FAD8,X
          CLD
          INC $FDD8
          CLD
LD8C8     LDA $065D
          LDX #$DB
          BNE LD8D4
          LDA $0685
          LDX #$D6
LD8D4     JSR LD2A7
          JSR LDD8E
          JMP ($00E2)
          LDA $068D
          BEQ LD8ED
          JMP LD630
LD8E5     LDA $068D
          ORA #$F0
          STA $068D
LD8ED     RTS
          JMP LD934
          JSR LD92E
          LDX #$3A
          LDY #$D9
          BNE LD90A
          JMP LD92A
          JMP LD926
          JMP LD919
          JSR LD926
          LDX #$49
          LDY #$D9
LD90A     JSR LD8E5
          JMP LD785
          JSR LD92E
          LDX #$00
          LDY #$CC
          BNE LD90A
LD919     LDA #$B3
LD91B     TAX
          TAY
LD91D     JSR LD581
          JSR LDE4B
          JMP LD630
LD926     LDA #$34
          BNE LD91B
LD92A     LDA #$F4
          BNE LD91B
LD92E     LDX #$F5
          LDY #$F6
          BNE LD91D
LD934     LDX #$92
          LDY #$96
          BNE LD91D
          .BYTE $93    ;%10010011
          .BYTE $DA    ;%11011010
          BIT $6EDB
          .BYTE $DC    ;%11011100
          BRK
          .BYTE $F3    ;%11110011
          .BYTE $80    ;%10000000
          .BYTE $80    ;%10000000
          BRK
          .BYTE $13    ;%00010011
          BRK
          STX $44
          LDY $2CDA,X
          .BYTE $DB    ;%11011011
          ROR $0BDC
          .BYTE $F4    ;%11110100
          .BYTE $80    ;%10000000
          .BYTE $80    ;%10000000
          BRK
          .BYTE $12    ;%00010010
          BRK
          STY $48
          RTS
          CMP $D96B,Y
          ADC $D9,X
          .BYTE $80    ;%10000000
          CMP $0201,Y
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          .BYTE $04    ;%00000100
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          .BYTE $07    ;%00000111
          ASL $05
          .BYTE $FF    ;%11111111
          BRK
          ORA $0709
          ASL $05
          ORA $05
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          ASL $07
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          ASL $06
          ASL $06
          ORA $05
          ORA $04
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          ORA ($01,X)
          ORA ($01,X)
          ORA ($F0,X)
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          SBC $00,X
          BRK
          LDY $DF
          LDX $DF
          ADC $00DF,Y
          BRK
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          INC $C4DE
          DEC $DF1A,X
          .BYTE $72    ;%01110010 'r'
          .BYTE $DF    ;%11011111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          BEQ LD9CB
          .BYTE $04    ;%00000100
          LDY #$DE
          DEC $DE
          .BYTE $F7    ;%11110111
          DEC $DF2B,X
          BRK
          .BYTE $FF    ;%11111111
          BEQ LD9D4
LD9D4     BRK
          ORA $1FDF,X
          .BYTE $DF    ;%11011111
          DEY
          .BYTE $DF    ;%11011111
          BRK
          BRK
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          BRK
          BRK
          .BYTE $52    ;%01010010 'R'
          .BYTE $DA    ;%11011010
          .BYTE $54    ;%01010100 'T'
          .BYTE $DA    ;%11011010
          EOR $DA
          BRK
          BRK
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          BEQ LD9EF
          ORA ($00,X)
          .BYTE $DF    ;%11011111
          .BYTE $0F    ;%00001111
          .BYTE $DF    ;%11011111
          DEC $00DE,X
          BRK
          .BYTE $17    ;%00010111
          BRK
          BRK
          .BYTE $03    ;%00000011
          ORA ($CE,X)
          CMP $CEC5
          INC $64CC,X
          .BYTE $CF    ;%11001111
          .BYTE $17    ;%00010111
          BRK
          BEQ LDA0C
          .BYTE $04    ;%00000100
          LDA $BBDE,Y
LDA0C     DEC $DF2F,X
          DEC $0BDF
          BRK
          BEQ LDA16
          ORA ($A2,X)
          .BYTE $DA    ;%11011010
          .BYTE $AB    ;%10101011
          .BYTE $DA    ;%11011010
          LDY $DA,X
          BRK
          BRK
          BRK
          BRK
          BEQ LDA24
          .BYTE $02    ;%00000010
          .BYTE $6F    ;%01101111 'o'
LDA24     .BYTE $DA    ;%11011010
          .BYTE $7F    ;%01111111
          .BYTE $DA    ;%11011010
          STX $00DA
          BRK
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          LDY #$DE
          .BYTE $F7    ;%11110111
          DEC $DF61,X
          .BYTE $CB    ;%11001011
          .BYTE $DF    ;%11011111
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          BRK
          BRK
          DEC $DA,X
          CPY $DA
          .BYTE $DF    ;%11011111
          .BYTE $DA    ;%11011010
          BRK
          BRK
          INY
          BCS LDA80
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3C    ;%00111100 '<'
          ROL $3E40,X
          .BYTE $3C    ;%00111100 '<'
          .BYTE $3A    ;%00111010 ':'
          LDX $02,Y
          .BYTE $FF    ;%11111111
          CLV
          .BYTE $02    ;%00000010
          .BYTE $B3    ;%10110011
          .BYTE $02    ;%00000010
          .BYTE $B2    ;%10110010
          .BYTE $74    ;%01110100 't'
          .BYTE $02    ;%00000010
          ROR A
          .BYTE $02    ;%00000010
          .BYTE $72    ;%01110010 'r'
          .BYTE $02    ;%00000010
          .BYTE $62    ;%01100010 'b'
          LDY $02,X
          .BYTE $B2    ;%10110010
          RTS
          .BYTE $02    ;%00000010
          JMP ($7602)
          .BYTE $B3    ;%10110011
          .BYTE $02    ;%00000010
          .BYTE $B2    ;%10110010
          ROR $7C02,X
          .BYTE $B3    ;%10110011
          .BYTE $02    ;%00000010
          BRK
          .BYTE $B3    ;%10110011
          .BYTE $52    ;%01010010 'R'
          .BYTE $42    ;%01000010 'B'
          .BYTE $B2    ;%10110010
          PHA
          ROL $3E38,X
          .BYTE $B2    ;%10110010
          .BYTE $44    ;%01000100 'D'
          JMP $4CB3
          LDY $38,X
          BRK
          .BYTE $B3    ;%10110011
LDA80     PHA
          .BYTE $3A    ;%00111010 ':'
          .BYTE $B2    ;%10110010
          ROL $3038,X
          SEC
          .BYTE $B2    ;%10110010
          ROL $B344,X
          .BYTE $42    ;%01000010 'B'
          LDY $3C,X
          LDY $2C,X
          ROL A
          ASL $B21C,X
          .BYTE $22    ;%00100010 '"'
          BIT $3430
          SEC
          BMI LDAC1
          BMI LDAD7
          .BYTE $34    ;%00110100 '4'
          BIT $B426
          ROL A
          .BYTE $B3    ;%10110011
          ROL $3A42,X
          SEC
          LDY $34,X
          .BYTE $34    ;%00110100 '4'
          BRK
          .BYTE $B3    ;%10110011
          BMI LDADE
          BIT $2026
          LDY $24,X
          BIT $B3
          ROL $34,X
          BMI LDAE3
          LDY $1C,X
          .BYTE $1C    ;%00011100
          .BYTE $B3    ;%10110011
          .BYTE $34    ;%00110100 '4'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $34    ;%00110100 '4'
          BMI LDA76
          ROL A
          ROL A
          LDY $12,X
          .BYTE $B3    ;%10110011
          BPL LDAE1
          ASL $0A,X
          LDY $14,X
          .BYTE $12    ;%00010010
          .BYTE $B3    ;%10110011
          BPL LDAD7
          ASL $B404
          .BYTE $0C    ;%00001100
          BRK
          CPX #$B0
          .BYTE $54    ;%01010100 'T'
          LSR $4248
          PHA
          LSR $E0FF
          .BYTE $B3    ;%10110011
LDAE1     .BYTE $02    ;%00000010
          BCS LDB20
          RTI
          .BYTE $44    ;%01000100 'D'
          LSR A
          LSR $5854
          .BYTE $5C    ;%01011100 '\'
          .BYTE $62    ;%01100010 'b'
          ROR $6C
          BVS LDB64
          .BYTE $7A    ;%01111010 'z'
          .BYTE $B3    ;%10110011
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
LDAF4     LDA #$80
          STA $4087
          STX $E2
          STY $E3
          LDY #$00
LDAFF     LDA ($E2),Y
          CMP #$FF
          BEQ LDB0B
          STA $4088
          INY
          BNE LDAFF
LDB0B     LDA #$00
          STA $4087
          RTS
LDB11     LDA #$81
          STA $4089
          STX $E2
          STY $E3
          LDY #$FF
LDB1C     INY
          LDA ($E2),Y
          STA $4040,Y
          CPY #$3F
          BNE LDB1C
          LDA #$00
          STA $4089
          RTS
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          ORA ($01,X)
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          .BYTE $FF    ;%11111111
          ORA ($07,X)
          .BYTE $07    ;%00000111
          ORA ($01,X)
          .BYTE $07    ;%00000111
          .BYTE $07    ;%00000111
          ASL $06
          ASL $07
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          ORA $05
          ORA $05
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
          .BYTE $03    ;%00000011
LDB64     ORA $05
          ORA $03
          .BYTE $03    ;%00000011
          ORA $05
          .BYTE $03    ;%00000011
          ORA ($FF,X)
          BRK
          .BYTE $02    ;%00000010
          .BYTE $04    ;%00000100
          ASL $08
          ASL A
          .BYTE $0C    ;%00001100
          ASL $1210
          .BYTE $14    ;%00010100
          ASL $18,X
          .BYTE $1A    ;%00011010
          .BYTE $1C    ;%00011100
          ASL $211F,X
          .BYTE $23    ;%00100011 '#'
          AND $27
          AND #$2B
          AND $312F
          .BYTE $33    ;%00110011 '3'
          AND $37,X
          AND $3D3B,Y
          .BYTE $3F    ;%00111111 '?'
          AND $393B,X
          .BYTE $37    ;%00110111 '7'
          AND $33,X
          AND ($2F),Y
          AND $292B
          ROL $24
          .BYTE $22    ;%00100010 '"'
          JSR $1C1E
          .BYTE $1A    ;%00011010
          CLC
          ASL $14,X
          .BYTE $12    ;%00010010
          BPL LDBB5
          .BYTE $0C    ;%00001100
          ASL A
          PHP
          ASL $04
          .BYTE $02    ;%00000010
          BRK
          BRK
          PHP
          ASL $1713
          .BYTE $1B    ;%00011011
          JSR $2724
          AND #$2B
          .BYTE $27    ;%00100111 '''
          .BYTE $22    ;%00100010 '"'
          ASL $181B,X
          ORA $2C24,X
          BMI LDBF4
          BMI LDBF2
          .BYTE $2B    ;%00101011 '+'
          AND #$28
          .BYTE $27    ;%00100111 '''
          ROL $25
          BIT $23
          .BYTE $22    ;%00100010 '"'
          AND ($20,X)
          ORA $0B11,Y
          .BYTE $12    ;%00010010
          ORA $2312,Y
          JSR $342F
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          ROL $3E3F,X
          .BYTE $3A    ;%00111010 ':'
          .BYTE $34    ;%00110100 '4'
          BMI LDC10
          .BYTE $27    ;%00100111 '''
          .BYTE $23    ;%00100011 '#'
          ASL $161B,X
          .BYTE $13    ;%00010011
          .BYTE $0F    ;%00001111
          .BYTE $0B    ;%00001011
          PHP
          .BYTE $04    ;%00000100
          BRK
          BRK
          .BYTE $03    ;%00000011
          PHP
          .BYTE $0B    ;%00001011
LDBF2     .BYTE $0F    ;%00001111
          .BYTE $13    ;%00010011
LDBF4     .BYTE $17    ;%00010111
          .BYTE $1B    ;%00011011
          ASL $2723,X
          .BYTE $2B    ;%00101011 '+'
          .BYTE $2F    ;%00101111 '/'
          .BYTE $33    ;%00110011 '3'
          .BYTE $37    ;%00110111 '7'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $37    ;%00110111 '7'
          .BYTE $33    ;%00110011 '3'
          .BYTE $2F    ;%00101111 '/'
          .BYTE $2B    ;%00101011 '+'
          .BYTE $27    ;%00100111 '''
          .BYTE $23    ;%00100011 '#'
          JSR $182B
          .BYTE $14    ;%00010100
          BPL LDC18
          PHP
          .BYTE $04    ;%00000100
          BRK
          .BYTE $04    ;%00000100
LDC10     PHP
          .BYTE $0C    ;%00001100
          BPL LDC28
          CLC
          .BYTE $1C    ;%00011100
          JSR $2824
          .BYTE $2B    ;%00101011 '+'
          .BYTE $2F    ;%00101111 '/'
          .BYTE $33    ;%00110011 '3'
          .BYTE $37    ;%00110111 '7'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
LDC28     BRK
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3F    ;%00111111 '?'
          .BYTE $3F    ;%00111111 '?'
          BRK
          BRK
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3B    ;%00111011 ';'
          BRK
          .BYTE $33    ;%00110011 '3'
          .BYTE $33    ;%00110011 '3'
          BRK
          BRK
          BRK
          AND $002D
          BRK
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          BRK
          BRK
          .BYTE $1C    ;%00011100
          .BYTE $1C    ;%00011100
          BRK
          BRK
          .BYTE $14    ;%00010100
          .BYTE $14    ;%00010100
          BRK
          BRK
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          BRK
          BRK
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          BRK
          BRK
          ROL $3C3D,X
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3A    ;%00111010 ':'
          SEC
          .BYTE $37    ;%00110111 '7'
          ROL $36,X
          AND $34,X
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          AND ($30),Y
          .BYTE $2F    ;%00101111 '/'
          ROL $2C2D
          .BYTE $2B    ;%00101011 '+'
          ROL A
          AND #$28
          .BYTE $27    ;%00100111 '''
          ROL $25
          BIT $23
          .BYTE $22    ;%00100010 '"'
          AND ($20,X)
          .BYTE $1F    ;%00011111
          ASL $1C1D,X
          .BYTE $1B    ;%00011011
          .BYTE $1A    ;%00011010
          ORA $1718,Y
          ASL $15,X
          .BYTE $14    ;%00010100
          .BYTE $13    ;%00010011
          .BYTE $12    ;%00010010
          ORA ($10),Y
          .BYTE $0F    ;%00001111
          ASL $0C0D
          .BYTE $0B    ;%00001011
          ASL A
          ORA #$08
          .BYTE $07    ;%00000111
          ASL $05
          .BYTE $04    ;%00000100
          .BYTE $03    ;%00000011
          .BYTE $02    ;%00000010
          ORA ($00,X)
          .BYTE $07    ;%00000111
          BEQ LDCB1
LDCB1     BRK
          BRK
          LDX #$00
          LDY $C100
          BRK
          CPY $D800
          BRK
          SBC $00
          .BYTE $F3    ;%11110011
          ORA ($01,X)
          ORA ($11,X)
          ORA ($21,X)
          ORA ($32,X)
          ORA ($44,X)
          ORA ($58,X)
          ORA ($6C,X)
          ORA ($82,X)
          ORA ($99,X)
          ORA ($B1,X)
          ORA ($CB,X)
          ORA ($E6,X)
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          .BYTE $02    ;%00000010
          .BYTE $22    ;%00100010 '"'
          .BYTE $02    ;%00000010
          .BYTE $42    ;%01000010 'B'
          .BYTE $02    ;%00000010
          ADC $02
          .BYTE $89    ;%10001001
          .BYTE $02    ;%00000010
          BCS LDCE7
          CMP $0403,Y
          .BYTE $03    ;%00000011
          .BYTE $32    ;%00110010 '2'
          .BYTE $03    ;%00000011
          .BYTE $63    ;%01100011 'c'
          .BYTE $03    ;%00000011
          STX $03,Y
          CMP $0704
          .BYTE $04    ;%00000100
          .BYTE $44    ;%01000100 'D'
          .BYTE $04    ;%00000100
          STA $04
          DEX
          ORA $13
          ORA $60
          ORA $B2
          ASL $08
          ASL $64
          ASL $C6
          .BYTE $07    ;%00000111
          AND $9A07
          PHP
          ASL $8808
          ORA #$0A
LDD0E     STA $EA
          STX $E0
          STY $E1
          LDA $068A
          AND #$FC
          BNE LDD61
          LDY #$00
          JSR LDD62
          TAY
          JSR LDAF4
          LDY #$02
          JSR LDD62
          TAY
          JSR LDB11
          LDY #$04
          JSR LDD62
          STA $EB
          INY
          LDA ($E0),Y
          LDY $EB
          JSR LDD70
          LDY #$07
          JSR LDD62
          JSR LDD69
          INY
          JSR LDD62
          JSR LDD7A
          INY
          JSR LDD62
          JSR LDD81
          LDA $EA
          JSR LD246
          LDA #$00
          STA $0654
          LDA #$05
          STA $0656
LDD61     RTS
LDD62     LDA ($E0),Y
          TAX
          INY
          LDA ($E0),Y
          RTS
LDD69     STX $4086
          STA $4087
          RTS
LDD70     STX $4084
          STY $4084
          STA $4085
          RTS
LDD7A     STX $4080
          STA $4080
          RTS
LDD81     STX $4082
          STX $067C
          STA $4083
          STA $067D
          RTS
LDD8E     LDA #$FF
          STA $065E
          LDA $064D
          BEQ LDD9E
LDD98     INC $065E
          ASL A
          BCC LDD98
LDD9E     RTS
LDD9F     LDA $065E
          CLC
          ADC #$08
          STA $065E
          RTS
          .BYTE $07    ;%00000111
          BEQ LDDAC
LDDAC     BRK
          ASL $4E
          ORA $F3
          ORA $4D
          ORA $01
          .BYTE $04    ;%00000100
          LDA $7504,Y
          .BYTE $04    ;%00000100
          AND $03,X
          SED
          .BYTE $03    ;%00000011
          .BYTE $BF    ;%10111111
          .BYTE $03    ;%00000011
          .BYTE $89    ;%10001001
          .BYTE $03    ;%00000011
          .BYTE $57    ;%01010111 'W'
          .BYTE $03    ;%00000011
          .BYTE $27    ;%00100111 '''
          .BYTE $02    ;%00000010
          SBC $CF02,Y
          .BYTE $02    ;%00000010
          LDX $02
          .BYTE $80    ;%10000000
          .BYTE $02    ;%00000010
          .BYTE $5C    ;%01011100 '\'
          .BYTE $02    ;%00000010
          .BYTE $3A    ;%00111010 ':'
          .BYTE $02    ;%00000010
          .BYTE $1A    ;%00011010
          ORA ($FC,X)
          ORA ($DF,X)
          ORA ($C4,X)
          ORA ($AB,X)
          ORA ($93,X)
          ORA ($7C,X)
          ORA ($67,X)
          ORA ($52,X)
          ORA ($3F,X)
          ORA ($2D,X)
          ORA ($1C,X)
          ORA ($0C,X)
          BRK
          SBC $EE00,X
          BRK
          SBC ($00,X)
          .BYTE $D4    ;%11010100
          BRK
          INY
          BRK
          LDA $B200,X
          BRK
          TAY
          BRK
          .BYTE $9F    ;%10011111
          BRK
          STX $00,Y
          STA $8500
          BRK
          ROR $7600,X
          BRK
          BVS LDE0A
LDE0A     ADC #$00
          .BYTE $63    ;%01100011 'c'
          BRK
          LSR $5800,X
          BRK
          .BYTE $53    ;%01010011 'S'
          BRK
          .BYTE $4F    ;%01001111 'O'
          BRK
          LSR A
          BRK
          LSR $00
          .BYTE $42    ;%01000010 'B'
          BRK
          ROL $3A00,X
          BRK
          .BYTE $37    ;%00110111 '7'
          BRK
          .BYTE $34    ;%00110100 '4'
          BRK
          AND ($00),Y
          ROL $2700
          .BYTE $04    ;%00000100
          PHP
          BPL LDE4D
          RTI
          CLC
          BMI LDE3D
          .BYTE $0B    ;%00001011
          ORA $02
          ASL $0C
          CLC
          BMI LDE99
          BIT $48
          .BYTE $12    ;%00010010
          BPL LDE46
          .BYTE $03    ;%00000011
          BPL LDE48
          ASL $381C
          BVS LDE70
LDE46     .BYTE $54    ;%01010100 'T'
          ORA $12,X
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
LDE4B     JSR LD1EA
          LDA $064D
          STA $068D
          LDA $065E
          TAY
          LDA $D89C,Y
          TAY
          LDX #$00
LDE5E     LDA $D9A9,Y
          STA $062B,X
          INY
          INX
          TXA
          CMP #$0D
          BNE LDE5E
          LDA #$01
          STA $0640
LDE70     STA $0641
          STA $0642
          STA $0643
          LDA #$00
          STA $0638
          STA $0639
          STA $063A
          STA $063B
          RTS
          STA ($2C,X)
          .BYTE $22    ;%00100010 '"'
          .BYTE $1C    ;%00011100
          BIT $1C22
          STA $2C
          .BYTE $04    ;%00000100
          STA ($2E,X)
          BIT $1E
          ROL $1E24
LDE99     STA $2E
          .BYTE $04    ;%00000100
          STA ($32,X)
          PLP
          .BYTE $22    ;%00100010 '"'
          .BYTE $72    ;%01110010 'r'
          .BYTE $DF    ;%11011111
          BIT $AEDB
          .BYTE $DB    ;%11011011
          .BYTE $17    ;%00010111
          RTI
          .BYTE $80    ;%10000000
          .BYTE $80    ;%10000000
          BRK
LDEAB     .BYTE $02    ;%00000010
          BRK
          .BYTE $83    ;%10000011
          LSR $20
          .BYTE $34    ;%00110100 '4'
          CMP $A0A2,Y
          LDY #$DE
          JMP LD90A
          .BYTE $B7    ;%10110111
          .BYTE $02    ;%00000010
LDEBB     .BYTE $C2    ;%11000010
          LDY $64,X
          .BYTE $74    ;%01110100 't'
          ROR A
          .BYTE $02    ;%00000010
          .BYTE $64    ;%01100100 'd'
          SEI
          .BYTE $74    ;%01110100 't'
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B2    ;%10110010
          .BYTE $72    ;%01110010 'r'
          .BYTE $5A    ;%01011010 'Z'
          ROR $6C56
          .BYTE $54    ;%01010100 'T'
          PLA
          BVC LDF3F
          LSR $6C,X
          .BYTE $54    ;%01010100 'T'
          PLA
          BVC LDF3B
          JMP $C4FF
          .BYTE $72    ;%01110010 'r'
          .BYTE $5A    ;%01011010 'Z'
          ROR $6C5A
          .BYTE $5A    ;%01011010 'Z'
          PLA
          .BYTE $5A    ;%01011010 'Z'
          ROR $6C56
          LSR $68,X
LDEE7     LSR $64,X
          LSR $FF,X
          .BYTE $B2    ;%10110010
          .BYTE $5A    ;%01011010 'Z'
          LDA ($42),Y
          .BYTE $B2    ;%10110010
          LSR $B1,X
          .BYTE $42    ;%01000010 'B'
          .BYTE $B2    ;%10110010
          .BYTE $54    ;%01010100 'T'
          LDA ($42),Y
          .BYTE $B2    ;%10110010
          BVC LDEAB
          .BYTE $42    ;%01000010 'B'
          .BYTE $B2    ;%10110010
          .BYTE $5A    ;%01011010 'Z'
          LDA ($42),Y
          .BYTE $B2    ;%10110010
          LSR $B1,X
          .BYTE $42    ;%01000010 'B'
          .BYTE $B2    ;%10110010
          .BYTE $52    ;%01010010 'R'
          LDA ($42),Y
          .BYTE $B2    ;%10110010
          BVC LDEBB
          .BYTE $42    ;%01000010 'B'
          .BYTE $B2    ;%10110010
          .BYTE $5A    ;%01011010 'Z'
          LDA ($44),Y
          .BYTE $B2    ;%10110010
          LSR $B1,X
          .BYTE $44    ;%01000100 'D'
          .BYTE $B2    ;%10110010
          .BYTE $52    ;%01010010 'R'
          LDA ($44),Y
          .BYTE $B2    ;%10110010
          LSR $B1,X
          .BYTE $44    ;%01000100 'D'
          CPY $5A
          BVC LDF65
          .BYTE $FF    ;%11111111
          .BYTE $C3    ;%11000011
          CLI
          BVC LDF6A
          .BYTE $FF    ;%11111111
          CLI
          BVC LDED8
          LSR $02
LDF2A     CPX #$B4
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          BRK
          BNE LDEE7
          ROL A
          LDA ($2A),Y
          LDA ($02),Y
          .BYTE $FF    ;%11111111
          LDY $4C,X
          RTS
          LSR $545C,X
          RTS
          .BYTE $5C    ;%01011100 '\'
LDF3F     LSR $C2,X
          .BYTE $34    ;%00110100 '4'
          PHA
          LSR $44
          .BYTE $3C    ;%00111100 '<'
          PHA
          .BYTE $44    ;%01000100 'D'
          ROL $C2FF,X
          .BYTE $B2    ;%10110010
          .BYTE $34    ;%00110100 '4'
          LDA ($42),Y
          LDA $4C,X
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B2    ;%10110010
          BIT $3AB1
          LDA $48,X
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          .BYTE $B2    ;%10110010
          ASL $2CB1,X
          LDA $36,X
          .BYTE $FF    ;%11111111
          CPY $B2
          JSR $2EB1
          LDA $38,X
          .BYTE $FF    ;%11111111
LDF6A     CPX #$B6
          ROL A
          LDA ($2A),Y
          LDA ($02),Y
          .BYTE $FF    ;%11111111
          BNE LDF2A
          ASL $B2
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          INY
          LDY $02,X
          .BYTE $FF    ;%11111111
          .BYTE $B2    ;%10110010
          BIT $26
          ROL A
          ROL $3834
          .BYTE $3C    ;%00111100 '<'
LDF84     ROL $42B6,X
          LDA ($3E),Y
          .BYTE $3C    ;%00111100 '<'
          LDX $3E,Y
          LDA ($3C),Y
          SEC
          LDX $34,Y
          .BYTE $B2    ;%10110010
          .BYTE $42    ;%01000010 'B'
          LDY $4C,X
          .BYTE $B3    ;%10110011
          .BYTE $44    ;%01000100 'D'
          .BYTE $42    ;%01000010 'B'
          ROL $B63C,X
          SEC
          .BYTE $B2    ;%10110010
          .BYTE $3C    ;%00111100 '<'
          LDX $42,Y
          .BYTE $B2    ;%10110010
          JMP $38B6
          .BYTE $B2    ;%10110010
          .BYTE $3C    ;%00111100 '<'
          LDY $34,X
          .BYTE $B3    ;%10110011
          ROL A
          ROL $3834
          LDX $34,Y
          .BYTE $B2    ;%10110010
          BIT $26B4
          LDA $38,X
          .BYTE $3C    ;%00111100 '<'
          .BYTE $42    ;%01000010 'B'
          JMP $3A34
          PHA
          .BYTE $42    ;%01000010 'B'
          ROL $3E,X
          JMP $4244
          SEC
          ROL $4038
          SEC
          ROL $E038
          LDX $06,Y
          .BYTE $B2    ;%10110010
          .BYTE $02    ;%00000010
          .BYTE $FF    ;%11111111
          BNE LDF84
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          CPY $04B2
          .BYTE $04    ;%00000100
          LDA $07,X
          BCS LDFDE
          .BYTE $04    ;%00000100
          LDX $04,Y
          LDA ($04),Y
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          DEX
          LDA ($04),Y
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $07    ;%00000111
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          CPX #$B4
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          .BYTE $17    ;%00010111
          CLC
          ORA $1A19,Y
          JMP LD18C
          .END

;auto-generated symbols and labels
 LD00B      $D00B
 LD016      $D016
 LD039      $D039
 LD04F      $D04F
 LD051      $D051
 LD05B      $D05B
 LD056      $D056
 LD084      $D084
 LD094      $D094
 LD09F      $D09F
 LD13A      $D13A
 LD2A7      $D2A7
 LDD8E      $DD8E
 LDD9F      $DD9F
 LD157      $D157
 LD165      $D165
 LD229      $D229
 LD170      $D170
 LD1C3      $D1C3
 LD17A      $D17A
 LD1C8      $D1C8
 LD304      $D304
 LD140      $D140
 LD12E      $D12E
 LD120      $D120
 LD8C8      $D8C8
 LD7B8      $D7B8
 LD1F2      $D1F2
 LD1B1      $D1B1
 LD1DD      $D1DD
 LD1DA      $D1DA
 LD151      $D151
 LD1F8      $D1F8
 LD20B      $D20B
 LD1FC      $D1FC
 LD240      $D240
 LD261      $D261
 LD258      $D258
 LD25E      $D25E
 LD264      $D264
 LD155      $D155
 LD27D      $D27D
 LD2A6      $D2A6
 LD2B2      $D2B2
 LD2D9      $D2D9
 LD2C8      $D2C8
 LD2D4      $D2D4
 LD32D      $D32D
 LD293      $D293
 LD2E5      $D2E5
 LD335      $D335
 LD2EF      $D2EF
 LD329      $D329
 LD33E      $D33E
 LD2FC      $D2FC
 LD330      $D330
 LD246      $D246
 LD33D      $D33D
 LD28C      $D28C
 LD367      $D367
 LD35B      $D35B
 LD38D      $D38D
 LD3BB      $D3BB
 LD3E1      $D3E1
 LD3DC      $D3DC
 LDD0E      $DD0E
 LD40A      $D40A
 LD451      $D451
 LD41B      $D41B
 LD43A      $D43A
 LD472      $D472
 LD462      $D462
 LD4F3      $D4F3
 LD559      $D559
 LD54C      $D54C
 LD45F      $D45F
 LD483      $D483
 LD46B      $D46B
 LD49C      $D49C
 LD4A0      $D4A0
 LD431      $D431
 LD4BD      $D4BD
 LD56D      $D56D
 LD503      $D503
 LD522      $D522
 LD52E      $D52E
 LD59A      $D59A
 LD5A4      $D5A4
 LD5C1      $D5C1
 LD5CC      $D5CC
 LD616      $D616
 LD5A5      $D5A5
 LD624      $D624
 LD5E7      $D5E7
 LD5DF      $D5DF
 LD61B      $D61B
 LD620      $D620
 LD617      $D617
 LD60B      $D60B
 LD608      $D608
 LD1DE      $D1DE
 LD5C2      $D5C2
 LD590      $D590
 LD64D      $D64D
 LD62C      $D62C
 LD63B      $D63B
 LD63E      $D63E
 LD628      $D628
 LD67F      $D67F
 LD68F      $D68F
 LD6A7      $D6A7
 LD69E      $D69E
 LD667      $D667
 LD769      $D769
 LD742      $D742
 LD6CB      $D6CB
 LD6A4      $D6A4
 LD6A1      $D6A1
 LD6E4      $D6E4
 LD6F9      $D6F9
 LD6FE      $D6FE
 LD73C      $D73C
 LD717      $D717
 LD71C      $D71C
 LD733      $D733
 LD763      $D763
 LD754      $D754
 LD758      $D758
 LD6C2      $D6C2
 LD782      $D782
 LD797      $D797
 LD7B7      $D7B7
 LD7AD      $D7AD
 LD7DA      $D7DA
 LD7EA      $D7EA
 LD7FC      $D7FC
 LD7F9      $D7F9
 LD7C2      $D7C2
 LD81A      $D81A
 LD82F      $D82F
 LD833      $D833
 LD891      $D891
 LD857      $D857
 LDAF4      $DAF4
 LDB11      $DB11
 LD898      $D898
 LD882      $D882
 LD887      $D887
 LD8D4      $D8D4
 LD8ED      $D8ED
 LD630      $D630
 LD934      $D934
 LD92E      $D92E
 LD90A      $D90A
 LD92A      $D92A
 LD926      $D926
 LD919      $D919
 LD8E5      $D8E5
 LD785      $D785
 LD581      $D581
 LDE4B      $DE4B
 LD91B      $D91B
 LD91D      $D91D
 LD9CB      $D9CB
 LD9D4      $D9D4
 LD9EF      $D9EF
 LDA0C      $DA0C
 LDA16      $DA16
 LDA24      $DA24
 LDA80      $DA80
 LDAC1      $DAC1
 LDAD7      $DAD7
 LDADE      $DADE
 LDAE3      $DAE3
 LDA76      $DA76
 LDAE1      $DAE1
 LDB20      $DB20
 LDB64      $DB64
 LDB0B      $DB0B
 LDAFF      $DAFF
 LDB1C      $DB1C
 LDBB5      $DBB5
 LDBF4      $DBF4
 LDBF2      $DBF2
 LDC10      $DC10
 LDC18      $DC18
 LDC28      $DC28
 LDCB1      $DCB1
 LDCE7      $DCE7
 LDD61      $DD61
 LDD62      $DD62
 LDD70      $DD70
 LDD69      $DD69
 LDD7A      $DD7A
 LDD81      $DD81
 LDD9E      $DD9E
 LDD98      $DD98
 LDDAC      $DDAC
 LDE0A      $DE0A
 LDE4D      $DE4D
 LDE3D      $DE3D
 LDE99      $DE99
 LDE46      $DE46
 LDE48      $DE48
 LDE70      $DE70
 LD1EA      $D1EA
 LDE5E      $DE5E
 LDF3F      $DF3F
 LDF3B      $DF3B
 LDEAB      $DEAB
 LDEBB      $DEBB
 LDF65      $DF65
 LDF6A      $DF6A
 LDED8      $DED8
 LDEE7      $DEE7
 LDF2A      $DF2A
 LDF84      $DF84
 LDFDE      $DFDE
 LD18C      $D18C

