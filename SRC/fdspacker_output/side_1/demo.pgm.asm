          * = $6800
L6800     TXA
          PHA
          LDX #$0B
L6804     ASL $28
          ROL $29
          ROL A
          ROL A
          EOR $28
          ROL A
          EOR $28
          LSR A
          LSR A
          EOR #$FF
          AND #$01
          ORA $28
          STA $28
          DEX
          BNE L6804
          PLA
          TAX
          LDA $28
          RTS
          CLD
L6822     LDA $2002
          BPL L6822
          LDX #$00
          STX $2000
          STX $2001
          DEX
          TXS
          LDY #$07
          STY $01
          LDY #$00
          STY $00
          TYA
L683A     STA ($00),Y
          INY
          BNE L683A
          DEC $01
          BMI L684F
          LDX $01
          CPX #$01
          BNE L683A
          INY
          INY
          INY
          INY
          BNE L683A
L684F     JSR L69DF
          JSR L6A1C
          LDY #$00
          STY $2005
          STY $2005
          INY
          STY $1D
          LDA #$90
          STA $2000
          STA $FF
          LDA #$02
          STA $FE
          LDA #$47
          STA $4025
          STA $FB
          BNE L68A7
L6874     JSR L6AE4
          JSR L695F
          INC $27
          LDA #$00
          STA $1A
          LDX #$08
          LDA $27
          AND #$01
          BEQ L688A
          LDX #$10
L688A     LDA $0183
          STA $0184
          LDA $0182
          STA $0183
          LDA $0181
          STA $0182
          LDA $0180
          STA $0181
          LDA #$00
          STA $0180
L68A7     TAY
L68A8     LDA $1A
          BNE L68B7
          INY
          CPY #$09
          BNE L68A8
          INC $0180
          JMP L68A7
L68B7     JSR L6800
          JMP L6874
          CLI
          PHP
          PHA
          TXA
          PHA
          TYA
          PHA
          LDA $1A
          BEQ L68CB
          STA $02FC
L68CB     LDA $1F
          CMP #$15
          BCS L68E5
          LDA $5D
          STA $0200
          LDA $5E
          STA $0201
          LDA $5F
          STA $0202
          LDA $60
          STA $0203
L68E5     LDA #$00
          STA $2003
          LDA #$02
          STA $4014
          LDA $1A
          BNE L694E
          JSR L6A45
          JSR L6B5D
          JSR L6CF1
          JSR L6A71
          LDA $2002
          LDA $FF
          AND #$01
          ASL A
          ASL A
          CLC
          ADC #$20
          STA $2006
          LDA #$00
          STA $2006
          LDA $3F
          STA $FD
          JSR L6B1C
          LDA $43
          BEQ L694E
L691E     LDA $2002
          AND #$40
          BNE L691E
          LDA $1F
          CMP #$09
          BCC L693A
          JSR L6A31
          LDA #$04
          STA $040E
          JSR L868D
          LDA $5C
          BNE L693A
L693A     JSR $DFF3
L693D     LDA $2002
          AND #$40
          BEQ L693D
          LDA $40
          STA $FD
          JSR L6B1C
          JMP L6951
L694E     JSR $DFF3
L6951     LDA $4017
          LDY #$01
          STY $1A
          PLA
          TAY
          PLA
          TAX
          PLA
          PLP
          RTI
L695F     LDA $1D
          BEQ L6966
          JMP L696D
L6966     LDA $1E
          JSR L6AFA
          BRK
          ADC $5BA4
          BEQ L6988
          DEY
          STY $5B
          STY $59
          STY $43
          STY $3F
          STY $40
          LDA $FF
          AND #$FC
          STA $FF
          LDA #$1B
          STA $1F
          BNE L6999
L6988     JSR L8707
          JSR L86BE
          LDA $1F
          CMP #$0A
          BCS L6999
          JSR L6A31
          LDA $1F
L6999     JSR L6AFA
          ORA ($6D,X)
          ADC #$6D
          STY $DF6D
          ADC $6DF5
          LDY $006D,X
          ROR $6E16
          AND $6E,X
          STY $6E
          .BYTE $DC    ;%11011100
          ADC #$DC
          ADC #$E3
          ROR $6F26
          LSR $6F
          ROR $6F
          DEC $69,X
          CMP ($6F),Y
          .BYTE $1C    ;%00011100
          BVS L69E5
          BVS L69E7
          BVS L6960
          DEY
          .BYTE $3C    ;%00111100 '<'
          .BYTE $89    ;%10001001
          DEC $F289
          .BYTE $89    ;%10001001
          LDA $8B
          CMP $8B
          .BYTE $47    ;%01000111 'G'
          DEY
          ORA ($6D,X)
          LDA #$00
          STA $53
          STA $51
          INC $1F
          RTS
L69DF     JSR L69E6
          LDA #$02
          BNE L69E8
L69E6     LDA #$01
L69E8     STA $01
          LDA #$FF
          STA $00
          LDX $2002
          LDA $FF
          AND #$FB
          STA $FF
          STA $2000
          LDX $01
          DEX
          LDA $6A18,X
          STA $2006
          LDA #$00
          STA $2006
          LDX #$04
          LDY #$00
          LDA $00
L6A0E     STA $2007
          DEY
          BNE L6A0E
          DEX
          BNE L6A0E
          RTS
          JSR $2824
          BIT $02A0
          STY $01
          LDY #$00
          STY $00
          LDY #$04
          LDA #$F0
L6A28     STA ($00),Y
          INY
          BNE L6A28
          JMP L84D0
          RTS
L6A31     LDY #$02
          STY $01
          LDY #$00
          STY $00
          LDY #$5F
          LDA #$F4
L6A3D     STA ($00),Y
          DEY
          BPL L6A3D
          JMP L84D0
L6A45     LDA $52
          BNE L6A56
          LDY $1C
          BNE L6A5B
          LDA $1F
          CMP #$15
          BCS L6A5A
          JMP L85DB
L6A56     LDA #$00
          STA $52
L6A5A     RTS
L6A5B     DEY
          TYA
          ASL A
          TAY
          LDX $77EC,Y
          LDA $77ED,Y
          TAY
          LDA #$00
          STA $1C
L6A6A     STX $00
          STY $01
          JMP L6B9F
L6A71     LDA $59
          BEQ L6A78
          JMP L6ACA
L6A78     LDX #$00
          STX $01
          JSR L6A83
          LDX $2B
          INC $01
L6A83     LDY #$01
          STY $4016
          DEY
          STY $4016
          LDY #$08
L6A8E     PHA
          LDA $4016,X
          STA $00
          LSR A
          ORA $00
          LSR A
          PLA
          ROL A
          DEY
          BNE L6A8E
          LDX $01
          LDY $14,X
          STY $00
          STA $14,X
          EOR $00
          BEQ L6AB1
          LDA $00
          AND #$BF
          STA $00
          EOR $14,X
L6AB1     AND $14,X
          STA $12,X
          STA $16,X
          LDY #$20
          LDA $14,X
          CMP $00
          BNE L6AC7
          DEC $18,X
          BNE L6AC9
          STA $16,X
          LDY #$10
L6AC7     STY $18,X
L6AC9     RTS
L6ACA     LDY #$01
          STY $4016
          DEY
          STY $4016
          LDY #$04
L6AD5     LDA $4016
          DEY
          BNE L6AD5
          AND #$03
          BEQ L6AC9
          INY
          STY $5B
          BNE L6AC9
L6AE4     LDX #$01
          DEC $23
          BPL L6AF0
          LDA #$09
          STA $23
          LDX #$02
L6AF0     LDA $24,X
          BEQ L6AF6
          DEC $24,X
L6AF6     DEX
          BPL L6AF0
          RTS
L6AFA     ASL A
          STY $0415
          STX $0414
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
          LDX $0414
          LDY $0415
          JMP ($000C)
L6B1C     LDA $2002
          LDA $FD
          STA $2005
          LDA $FC
          STA $2005
          RTS
L6B2A     TYA
          CLC
          ADC $00
          STA $00
          BCC L6B34
          INC $01
L6B34     RTS
L6B35     TYA
          CLC
          ADC $02
          STA $02
          BCC L6B3F
          INC $03
L6B3F     RTS
          TYA
          CLC
          ADC $04
          STA $04
          BCC L6B3F
          INC $05
          RTS
L6B4B     EOR #$FF
          CLC
          ADC #$01
          RTS
          LSR A
L6B52     LSR A
L6B53     LSR A
          LSR A
          LSR A
          RTS
          ASL A
L6B58     ASL A
L6B59     ASL A
          ASL A
          ASL A
          RTS
L6B5D     LDA $1B
          BEQ L6B76
          LDA #$A1
          STA $00
          LDA #$07
          STA $01
          JSR L6B9F
          LDA #$00
          STA $07A0
          STA $07A1
          STA $1B
L6B76     RTS
L6B77     STA $2006
          INY
          LDA ($00),Y
          STA $2006
          INY
          LDA ($00),Y
          ASL A
          JSR L6BAB
          ASL A
          LDA ($00),Y
          AND #$3F
          TAX
          BCC L6B90
          INY
L6B90     BCS L6B93
          INY
L6B93     LDA ($00),Y
          STA $2007
          DEX
          BNE L6B90
          INY
          JSR L6B2A
L6B9F     LDX $2002
          LDY #$00
          LDA ($00),Y
          BNE L6B77
          JMP L6B1C
L6BAB     PHA
          LDA $FF
          ORA #$04
          BCS L6BB4
          AND #$FB
L6BB4     STA $2000
          STA $FF
          PLA
          RTS
L6BBB     LDY #$01
          STY $1B
          DEY
          LDA ($02),Y
          AND #$0F
          STA $05
          LDA ($02),Y
          JSR L6B52
          STA $04
          LDX $07A0
L6BD0     LDA $01
          JSR L6BFE
          LDA $00
          JSR L6BFE
          LDA $05
          STA $06
          JSR L6BFE
L6BE1     INY
          LDA ($02),Y
          JSR L6BFE
          DEC $06
          BNE L6BE1
          STX $07A0
          STY $06
          LDY #$20
          JSR L6B2A
          LDY $06
          DEC $04
          BNE L6BD0
          JSR L6C09
L6BFE     STA $07A1,X
L6C01     INX
          CPX #$4F
          BCC L6C10
          LDX $07A0
L6C09     LDA #$00
          STA $07A1,X
          PLA
          PLA
L6C10     RTS
          STX $00
          STY $01
          LDX #$80
          STX $02
          LDX #$07
          STX $03
L6C1D     LDY #$01
          STY $1B
          DEY
          BEQ L6C5B
L6C24     STA $04
          LDA $01
          JSR L6BFE
          LDA $00
          JSR L6BFE
          LDA $04
          JSR L6C65
          BIT $04
          BVC L6C3A
          INY
L6C3A     BIT $04
          BVS L6C3F
          INY
L6C3F     LDA ($02),Y
          JSR L6BFE
          STY $06
          LDY #$01
          BIT $04
          BPL L6C4E
          LDY #$20
L6C4E     JSR L6B2A
          LDY $06
          DEC $05
          BNE L6C3A
          STX $07A0
          INY
L6C5B     LDX $07A0
          LDA ($02),Y
          BNE L6C24
          JSR L6C09
L6C65     STA $04
          AND #$BF
          STA $07A1,X
          AND #$3F
          STA $05
          JMP L6C01
          JSR L6CB6
          ADC $01
          CMP #$0A
          BCC L6C7E
          ADC #$05
L6C7E     CLC
          ADC $02
          STA $02
          LDA $03
          AND #$F0
          ADC $02
          BCC L6C8F
L6C8B     ADC #$5F
          SEC
          RTS
L6C8F     CMP #$A0
          BCS L6C8B
          RTS
          JSR L6CB6
          SBC $01
          STA $01
          BCS L6CA7
          ADC #$0A
          STA $01
          LDA $02
          ADC #$0F
          STA $02
L6CA7     LDA $03
          AND #$F0
          SEC
          SBC $02
          BCS L6CB3
          ADC #$A0
          CLC
L6CB3     ORA $01
          RTS
L6CB6     PHA
          AND #$0F
          STA $01
          PLA
          AND #$F0
          STA $02
          LDA $03
          AND #$0F
          RTS
          JSR L6CCD
L6CC8     LDA $1A
          BEQ L6CC8
          RTS
L6CCD     LDA #$00
          STA $1A
          RTS
L6CD2     LDA $FE
          AND #$E7
L6CD6     STA $FE
          JSR L6CCD
L6CDB     LDA $1A
          BEQ L6CDB
          RTS
L6CE0     LDA $FF
          AND #$F7
          ORA #$10
          STA $FF
          STA $2000
          LDA $FE
          ORA #$1E
          BNE L6CD6
L6CF1     LDA $FF
          STA $2000
          LDA $FE
          STA $2001
          LDA $FB
          STA $4025
          RTS
          LDY #$02
          STY $57
          STY $54
          DEY
          STY $56
          STY $59
          DEY
          STY $58
          STY $55
          STY $5C
          LDA #$D0
          STA $5D
          LDA #$02
          STA $63
          LDA #$19
          STA $5E
          LDA #$20
          STA $5F
          LDA #$B8
          STA $60
          STY $3F
          STY $40
          STY $49
          STY $4A
          STY $4B
          STY $4C
          STY $00
          LDX #$60
L6D37     STX $01
          TXA
          AND #$03
          ASL A
          TAY
          STY $02
          LDA $6D61,Y
          LDY #$00
L6D45     STA ($00),Y
          INY
          BEQ L6D57
          CPY #$40
          BNE L6D45
          LDY $02
          LDA $6D62,Y
          LDY #$40
          BPL L6D45
L6D57     INX
          CPX #$68
          BNE L6D37
          INC $1F
          JMP L84EE
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          CPY #$C4
          LDA #$10
          STA $F0
          STA $0684
          JSR L6CD2
          JSR L69DF
          LDX #$34
          LDY #$7B
          JSR L6A6A
          LDA #$01
          STA $1C
          STA $4D
          INC $1F
          LDA #$00
          STA $62
          JMP L6CE0
          LDA $62
          CMP #$0D
          BCS L6DB2
          ASL A
          TAY
          LDA $7DAF,Y
          STA $02
          LDA $7DB0,Y
          STA $03
          LDY #$00
          LDA ($02),Y
          STA $01
          INY
          LDA ($02),Y
          STA $00
          INY
          JSR L6B35
          INC $62
          JMP L6C1D
L6DB2     LDA #$08
          STA $26
          LSR A
          STA $49
          INC $1F
          RTS
          LDA $27
          AND #$03
          BNE L6DDE
          LDA $49
          AND #$03
          STA $49
          JSR L85A0
          LDA $26
          BNE L6DDE
          LDA $49
          CMP #$04
          BNE L6DDE
          INC $1F
          JSR L8183
          LDA #$18
          STA $26
L6DDE     RTS
          LDA $26
          BNE L6DF4
          LDA $27
          AND #$0F
          BNE L6DF4
          JSR L85A0
          BNE L6DF4
          LDA #$20
          STA $26
          INC $1F
L6DF4     RTS
          LDA $26
          BNE L6DF4
          LDA #$08
          STA $26
          INC $1F
          RTS
          LDA $26
          BNE L6E15
          LDA $048A
          AND $049A
          CMP #$01
          BNE L6E12
          INC $1F
          BNE L6E15
L6E12     JSR L81A7
L6E15     RTS
          LDA $27
          AND #$07
          BNE L6E34
          LDA $4C
          CMP #$04
          BNE L6E31
          JSR L826F
          LDA #$08
          STA $26
          STA $44
          LDA #$00
          STA $47
          INC $1F
L6E31     JSR L8673
L6E34     RTS
          LDA $48
          BEQ L6E3C
          JSR L85BB
L6E3C     LDA $26
          BNE L6E83
          LDA $048A
          AND $049A
          AND $04AA
          AND $04BA
          BEQ L6E7D
          LDA #$01
          CMP $47
          BEQ L6E5E
          INC $47
          STA $4F
          STA $48
          LDA #$00
          STA $4E
L6E5E     AND $04CA
          AND $04DA
          AND $04EA
          AND $04FA
          BEQ L6E7D
          LDA #$01
          STA $4F
          STA $48
          JSR L84EE
          LDA #$00
          STA $4E
          INC $1F
          BNE L6E80
L6E7D     JSR L82D6
L6E80     JSR L834E
L6E83     RTS
          LDA $48
          BEQ L6E8E
          JSR L834E
          JMP L85BB
L6E8E     INC $1F
          LDA #$60
          STA $030D
          LDA #$7C
          STA $030E
          LDA $0305
          STA $0306
          RTS
          LDA #$01
          STA $43
          LDA #$04
          STA $040E
          STA $13
          STA $15
          STA $17
          LDA #$03
          STA $0300
          STA $0400
          INC $1F
          RTS
          LDA $0300
          CMP #$04
          BNE L6EE2
          LDA #$00
          STA $0300
          LDA #$0B
          STA $0305
          LDA #$0C
          STA $0306
          LDA #$07
          STA $0303
          LDA #$08
          STA $26
          LDA #$00
          STA $51
          STA $53
          INC $1F
L6EE2     RTS
          LDA $53
          BNE L6EF1
          LDA $27
          AND #$0F
          CMP #$01
          BNE L6F25
          STA $53
L6EF1     LDA $51
          CMP #$10
          BEQ L6F17
          INC $51
          ASL A
          TAY
          LDA $7F44,Y
          STA $02
          LDA $7F45,Y
          STA $03
          LDY #$00
          LDA ($02),Y
          STA $01
          INY
          LDA ($02),Y
          STA $00
          INY
          JSR L6B35
          JMP L6BBB
L6F17     INC $1F
          LDA #$08
          STA $26
          LDA #$06
          STA $4C
          LDA #$00
          STA $51
L6F25     RTS
          LDA $26
          BNE L6F45
          LDA $27
          AND #$07
          BNE L6F45
          LDA $4C
          CMP #$0B
          BNE L6F42
          LDA #$00
          STA $4C
          LDA #$30
          STA $26
          INC $1F
          BNE L6F45
L6F42     JSR L8673
L6F45     RTS
          LDA $26
          BNE L6F65
          LDA $27
          AND #$07
          BNE L6F65
          LDA $4C
          CMP #$05
          BNE L6F62
          LDA #$06
          STA $4C
          LDA #$00
          STA $53
          INC $1F
          BNE L6F65
L6F62     JSR L8673
L6F65     RTS
          LDA $53
          BNE L6F74
          LDA $27
          AND #$0F
          CMP #$01
          BNE L6FB7
          STA $53
L6F74     LDA $51
          CMP #$0C
          BEQ L6F9E
          INC $51
          ASL A
          TAY
          LDA $7F44,Y
          STA $04
          LDA $7F45,Y
          STA $05
          LDY #$00
          LDA ($04),Y
          STA $01
          INY
          LDA ($04),Y
          STA $00
          LDA #$14
          STA $02
          LDA #$81
          STA $03
          JMP L6BBB
L6F9E     LDA #$23
          STA $01
          LDA #$D0
          STA $00
          LDA #$81
          STA $03
          LDA #$2D
          STA $02
          JSR L6C1D
          INC $1F
          LDA #$10
          STA $26
L6FB7     RTS
          LDA $26
          BNE L6FD0
          LDA $3F
          BNE L6FD0
          LDA $40
          AND #$0F
          BNE L6FD0
          LDA #$01
          STA $5A
          LDA #$10
          STA $26
          INC $1F
L6FD0     RTS
          LDA $26
          BNE L7018
          STA $5A
          STA $43
          STA $0408
          LDY #$1F
L6FDE     STA $0300,Y
          DEY
          BPL L6FDE
          LDA $FF
          AND #$FC
          STA $FF
          INY
          STY $3F
          STY $40
          STY $49
          STY $4A
          STY $4B
          STY $4C
          STY $55
          STY $13
          STY $15
          STY $17
          STY $62
          INY
          STY $56
          INY
          STY $54
          STY $57
          STY $1F
          LDA $63
          BNE L7019
          LDA #$10
          STA $0684
          LDA #$02
          STA $63
L7018     RTS
L7019     DEC $63
          RTS
          JSR L6CD2
          INC $1F
          RTS
          RTS
          LDA #$01
          STA $0680
          RTS
          LSR $0416
          LDA ($00),Y
          AND #$C0
          ORA $0416
          STA $05
          LDA $0416
          ORA #$80
          STA $0416
          RTS
          LDY #$00
          LDX $040E
L7043     LDA $70B5,Y
          STA $0200,X
          INX
          BEQ L7051
          INY
          CPY #$1C
          BNE L7043
L7051     TXA
          PHA
          LDX $040E
          JSR L70B0
          BEQ L707E
          LDA $0107
          TAY
          JSR L6B52
          JSR L70A9
          JSR L70B0
          BEQ L707E
          TYA
          AND #$0F
          JSR L70A9
          JSR L70B0
          BEQ L707E
          LDA $0106
          JSR L6B52
          JSR L70A9
L707E     LDY $0422
          BEQ L7095
          LDA $040E
          CLC
          ADC #$10
          BEQ L7095
          TAX
          LDA $0421
          CLC
          ADC #$8B
          STA $0201,X
L7095     LDA $040E
          CLC
          ADC #$18
          BCS L70A4
          TAX
          LDA $041E
          JSR L70A9
L70A4     PLA
          STA $040E
          RTS
L70A9     CLC
          ADC #$80
          STA $0201,X
          RTS
L70B0     INX
          INX
          INX
          INX
          RTS
          BPL L7041
          BRK
          CLC
          BPL L70BA
          BRK
          JSR $FF10
          BRK
          PLP
          BPL L70C2
          BRK
          BMI L70DE
          .BYTE $FF    ;%11111111
          BRK
          CLC
          CLC
          STX $2800
          CLC
          .BYTE $FF    ;%11111111
          BRK
          BMI L7058
          ASL $1084
          LDX #$00
          LDY #$08
L70D9     LSR A
          BCS L70E0
          INX
          DEY
L70DE     BNE L70D9
L70E0     TXA
          LDY $10
          LDX $0E
L70E5     RTS
          LDX $0409
          BEQ L70E5
          DEX
          BNE L70F1
          JMP L70F4
L70F1     DEX
          BNE L70FC
L70F4     LDX $3F
          BNE L7138
          LDX #$05
          BNE L7118
L70FC     DEX
          BNE L7102
          JMP L7105
L7102     DEX
          BNE L7138
L7105     LDX $FC
          BNE L7138
          STX $0417
          STX $0418
          INX
          LDA $030E
          BMI L7130
          INX
          BNE L7130
L7118     LDA #$20
          STA $040D
          LDA $040C
          JSR L6B59
          BCS L712C
          LDY $040A
          CPY #$03
          BCC L7130
L712C     LDA #$47
          BNE L7133
L7130     JSR L7142
L7133     STA $FB
          STX $0409
L7138     RTS
          LDA $030C
          EOR #$01
          STA $030C
          RTS
L7142     LDA $0400
          EOR #$03
          STA $0400
          LDA $FB
          EOR #$08
          RTS
          BRK
          ORA ($02,X)
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $FF
          .BYTE $13    ;%00010011
          ASL $FF
          .BYTE $07    ;%00000111
          .BYTE $FF    ;%11111111
          .BYTE $17    ;%00010111
          PHP
          .BYTE $FF    ;%11111111
          AND ($FF,X)
          .BYTE $22    ;%00100010 '"'
          .BYTE $FF    ;%11111111
          ORA ($0F,X)
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          BPL L7168
          .BYTE $13    ;%00010011
          .BYTE $14    ;%00010100
          ORA $16,X
          .BYTE $FF    ;%11111111
          .BYTE $17    ;%00010111
          CLC
          ORA $FF1A,Y
          JSR $FF1F
          BRK
          .BYTE $13    ;%00010011
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          .BYTE $17    ;%00010111
          .BYTE $FF    ;%11111111
          .BYTE $1B    ;%00011011
          .BYTE $1C    ;%00011100
          ORA $FF1E,X
          ASL $1C1D,X
          .BYTE $1B    ;%00011011
          .BYTE $FF    ;%11111111
          PLP
          AND #$FF
          ROL A
          .BYTE $FF    ;%11111111
          .BYTE $1F    ;%00011111
          JSR $11FF
          .BYTE $FF    ;%11111111
          .BYTE $12    ;%00010010
          .BYTE $FF    ;%11111111
          ORA #$0A
          .BYTE $0B    ;%00001011
          .BYTE $FF    ;%11111111
          .BYTE $0C    ;%00001100
          ORA $FF0E
          BIT $2CFF
          BIT $2C2C
          BIT $2C2C
          BIT $2D2D
          AND $2D2D
          ROL $2E2E
          .BYTE $2F    ;%00101111 '/'
          .BYTE $2F    ;%00101111 '/'
          .BYTE $FF    ;%11111111
          .BYTE $2F    ;%00101111 '/'
          .BYTE $2F    ;%00101111 '/'
          ROL $2E2E
          AND $2D2D
          AND $2C2D
          BIT $2C2C
          BIT $2C2C
          BIT $30FF
          .BYTE $2B    ;%00101011 '+'
          .BYTE $FF    ;%11111111
          AND ($FF),Y
          AND ($31),Y
          AND ($31),Y
          AND ($31),Y
          AND ($31),Y
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $33    ;%00110011 '3'
          .BYTE $33    ;%00110011 '3'
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          .BYTE $34    ;%00110100 '4'
          .BYTE $34    ;%00110100 '4'
          .BYTE $33    ;%00110011 '3'
          .BYTE $33    ;%00110011 '3'
          .BYTE $33    ;%00110011 '3'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          .BYTE $32    ;%00110010 '2'
          AND ($31),Y
          AND ($31),Y
          AND ($31),Y
          AND ($31),Y
          .BYTE $FF    ;%11111111
          AND $FF,X
          .BYTE $37    ;%00110111 '7'
          ROL $FF,X
          AND $FF38,Y
          .BYTE $3A    ;%00111010 ':'
          .BYTE $3B    ;%00111011 ';'
          .BYTE $FF    ;%11111111
          .BYTE $3C    ;%00111100 '<'
          .BYTE $F7    ;%11110111
          EOR #$F7
          .BYTE $FF    ;%11111111
          AND $3F3E,X
          .BYTE $FF    ;%11111111
          RTI
          EOR ($42,X)
          .BYTE $FF    ;%11111111
          .BYTE $43    ;%01000011 'C'
          .BYTE $FF    ;%11111111
          .BYTE $44    ;%01000100 'D'
          .BYTE $FF    ;%11111111
          EOR $FF
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
          .BYTE $07    ;%00000111
          .BYTE $F7    ;%11110111
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          .BYTE $F7    ;%11110111
          .BYTE $F7    ;%11110111
          .BYTE $23    ;%00100011 '#'
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
          .BYTE $C3    ;%11000011
          .BYTE $73    ;%01110011 's'
          CMP ($73),Y
          CPX #$73
          INC $0073
          .BYTE $74    ;%01110100 't'
          .BYTE $13    ;%00010011
          .BYTE $74    ;%01110100 't'
          AND $74
          AND $74,X
          EOR $6174
          .BYTE $74    ;%01110100 't'
          .BYTE $6F    ;%01101111 'o'
          .BYTE $74    ;%01110100 't'
          ROR $8C74,X
          .BYTE $74    ;%01110100 't'
          .BYTE $9E    ;%10011110
          .BYTE $74    ;%01110100 't'
          LDA ($74),Y
          .BYTE $C3    ;%11000011
          .BYTE $74    ;%01110100 't'
          BNE L72E3
          SBC ($74,X)
          INC $FF74
          .BYTE $74    ;%01110100 't'
          ORA #$75
          .BYTE $13    ;%00010011
          ADC $1D,X
          ADC $27,X
          ADC $31,X
          ADC $3B,X
          ADC $45,X
          ADC $4F,X
          ADC $5A,X
          ADC $65,X
          ADC $70,X
          ADC $7B,X
          ADC $8F,X
          ADC $A3,X
          ADC $B4,X
          ADC $C9,X
          ADC $D2,X
          ADC $DC,X
          ADC $E6,X
          ADC $F0,X
          ADC $FA,X
          ADC $FF,X
          ADC $04,X
          ROR $09,X
          ROR $1D,X
          ROR $29,X
          ROR $35,X
          ROR $41,X
          ROR $4D,X
          ROR $61,X
          ROR $6D,X
          ROR $79,X
          ROR $85,X
          ROR $91,X
          ROR $9E,X
          ROR $AD,X
          ROR $BC,X
          ROR $CF,X
          ROR $E2,X
          ROR $E7,X
          ROR $EC,X
          ROR $FB,X
          ROR $0B,X
          .BYTE $77    ;%01110111 'w'
          .BYTE $1C    ;%00011100
          .BYTE $77    ;%01110111 'w'
          BIT $4077
          .BYTE $77    ;%01110111 'w'
          EOR $77,X
          ADC #$77
          ADC $8A77,Y
          .BYTE $77    ;%01110111 'w'
          TXS
          .BYTE $77    ;%01110111 'w'
          LDX $C377
          .BYTE $77    ;%01110111 'w'
          .BYTE $D7    ;%11010111
          .BYTE $77    ;%01110111 'w'
          INC $77
L72E3     .BYTE $F7    ;%11110111
          .BYTE $72    ;%01110010 'r'
          ORA $73,X
          AND ($73,X)
          AND $3573
          .BYTE $73    ;%01110011 's'
          .BYTE $3F    ;%00111111 '?'
          .BYTE $73    ;%01110011 's'
          .BYTE $F3    ;%11110011
          .BYTE $72    ;%01110010 'r'
          .BYTE $4B    ;%01001011 'K'
          .BYTE $73    ;%01110011 's'
          SBC #$FC
          .BYTE $EB    ;%11101011
          .BYTE $FC    ;%11111100
          SBC ($F8),Y
          SBC ($00),Y
          SBC $F9F0,Y
          SED
          SBC $0100,Y
          SED
          ORA ($00,X)
          ORA ($08,X)
          ORA #$F8
          ORA #$00
          ORA #$08
          SBC $F9F4,Y
          INC $ED,X
          .BYTE $F4    ;%11110100
          .BYTE $EF    ;%11101111
          .BYTE $F4    ;%11110100
          .BYTE $F4    ;%11110100
          SED
          .BYTE $F4    ;%11110100
          BRK
          .BYTE $FC    ;%11111100
          SED
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $04    ;%00000100
          SED
          .BYTE $04    ;%00000100
          BRK
          SBC $F9F6,Y
          INC $06F9,X
          ORA ($F6,X)
          ORA ($FE,X)
          ORA ($06,X)
          .BYTE $FC    ;%11111100
          BEQ L732C
          SED
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $FC    ;%11111100
          PHP
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
          BEQ L7343
L7343     SED
          BRK
          BRK
          BRK
          PHP
          BRK
          BPL L734B
L734B     .BYTE $80    ;%10000000
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
          .BYTE $FC    ;%11111100
          SED
          .BYTE $FC    ;%11111100
          BRK
          .BYTE $04    ;%00000100
          SED
          .BYTE $04    ;%00000100
          BRK
          .BYTE $FC    ;%11111100
          SED
          .BYTE $F4    ;%11110100
          BEQ L7356
          CPX $E8EA
          .BYTE $E7    ;%11100111
          INC $E6
          SBC $E5
          CPX $E4
          .BYTE $E3    ;%11100011
          SBC $E7
          SBC #$EB
          .BYTE $EF    ;%11101111
          .BYTE $F3    ;%11110011
          .BYTE $F7    ;%11110111
L737A     .BYTE $FB    ;%11111011
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          INC $FAFC,X
          SED
          INC $F4,X
          .BYTE $F2    ;%11110010
          BEQ L737A
          SBC $EAEB
          SBC #$E8
          .BYTE $E7    ;%11100111
          INC $E6
          INC $E6
          INC $E8
          NOP
          CPX $00EE
          BRK
          BRK
          BRK
          BRK
          BRK
L73A1     BRK
          BRK
          INC $FAFC,X
          SED
          .BYTE $F7    ;%11110111
          INC $F5,X
          .BYTE $F4    ;%11110100
          .BYTE $F3    ;%11110011
          .BYTE $F2    ;%11110010
          SBC ($F1),Y
          BEQ L73A1
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          .BYTE $EF    ;%11101111
          BEQ L73A9
          SBC ($F2),Y
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BPL L73CC
          BRK
          ORA ($FE,X)
          BPL L73DC
          JSR $FE21
          INC $FF31,X
          BRK
          BPL L73DA
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          INC $1312,X
          .BYTE $22    ;%00100010 '"'
L73DA     .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          BRK
          BPL L73E9
          ORA $06
          INC $1615,X
          AND $26
          .BYTE $27    ;%00100111 '''
          AND $36,X
          .BYTE $FF    ;%11111111
          RTI
          BPL L73F7
          BRK
          ORA ($FD,X)
          JSR $41FE
L73F7     RTI
          SBC $2060,X
          AND ($FE,X)
          INC $FF31,X
          RTI
          BPL L7409
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          SBC $FE20,X
          .BYTE $43    ;%01000011 'C'
L7409     .BYTE $42    ;%01000010 'B'
          SBC $2260,X
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          RTI
          BPL L741C
          ORA $06
          SBC $FE20,X
          EOR $44
          SBC $2560,X
          ROL $27
          AND $36,X
          .BYTE $FF    ;%11111111
          BRK
          BPL L742E
          .BYTE $0B    ;%00001011
          .BYTE $0C    ;%00001100
          INC $1C1B,X
          .BYTE $2B    ;%00101011 '+'
L742E     BIT $3BFE
          .BYTE $3C    ;%00111100 '<'
          INC $FF17,X
          BRK
          BPL L743E
          ORA #$FD
          RTS
          ORA #$FD
          JSR $19FE
          SBC $1960,X
          SBC $2920,X
          ROL A
          INC $FD39,X
          RTS
          AND $40FF,Y
          BPL L7456
          SBC $0E20,X
          ORA $1EFE
L7456     ORA $2D2E,X
          INC $60FD,X
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3C    ;%00111100 '<'
          INC $FF17,X
          BRK
          BPL L746A
          BRK
          ORA ($46,X)
          .BYTE $47    ;%01000111 'G'
          PHA
          JSR $FE21
          INC $FF31,X
          BRK
          BPL L7478
          BRK
          ORA ($46,X)
          .BYTE $47    ;%01000111 'G'
          PHA
          .BYTE $22    ;%00100010 '"'
L7478     .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          BRK
          BPL L7487
          BRK
          ORA ($46,X)
          .BYTE $47    ;%01000111 'G'
          PHA
          AND $26
          .BYTE $27    ;%00100111 '''
          AND $36,X
          .BYTE $FF    ;%11111111
          RTI
          BPL L7495
          BRK
          ORA ($FD,X)
          JSR $4A4B
L7495     EOR #$FD
          RTS
          JSR $FE21
          INC $FF31,X
          RTI
          BPL L74A7
          BRK
          ORA ($FD,X)
          JSR $4A4B
L74A7     EOR #$FD
          RTS
          .BYTE $22    ;%00100010 '"'
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          RTI
          BPL L74BA
          BRK
          ORA ($FD,X)
          JSR $4A4B
L74BA     EOR #$FD
          RTS
          AND $26
          .BYTE $27    ;%00100111 '''
          AND $36,X
          .BYTE $FF    ;%11111111
          BRK
          BPL L74CC
          BRK
          ORA ($FE,X)
          BPL L74DC
          .BYTE $22    ;%00100010 '"'
L74CC     .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          RTI
          BPL L74D9
          BRK
          ORA ($FD,X)
          JSR $41FE
L74D9     RTI
          SBC $2260,X
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          BRK
          BPL L74EA
          BRK
          ORA ($46,X)
          .BYTE $47    ;%01000111 'G'
          PHA
          .BYTE $22    ;%00100010 '"'
L74EA     .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          RTI
          BPL L74F7
          BRK
          ORA ($FD,X)
          JSR $4A4B
L74F7     EOR #$FD
          RTS
          .BYTE $22    ;%00100010 '"'
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          ORA ($10,X)
          ASL $52
          .BYTE $53    ;%01010011 'S'
          .BYTE $62    ;%01100010 'b'
          .BYTE $63    ;%01100011 'c'
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $FF    ;%11111111
          .BYTE $02    ;%00000010
          BPL L7512
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $64    ;%01100100 'd'
          ADC $66
L7512     .BYTE $FF    ;%11111111
          CMP ($10,X)
          ASL $52
          .BYTE $53    ;%01010011 'S'
          .BYTE $62    ;%01100010 'b'
          .BYTE $63    ;%01100011 'c'
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $FF    ;%11111111
          .BYTE $C2    ;%11000010
          BPL L7526
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $64    ;%01100100 'd'
          ADC $66
L7526     .BYTE $FF    ;%11111111
          EOR ($10,X)
          ASL $52
          .BYTE $53    ;%01010011 'S'
          .BYTE $62    ;%01100010 'b'
          .BYTE $63    ;%01100011 'c'
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $FF    ;%11111111
          .BYTE $42    ;%01000010 'B'
          BPL L753A
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $64    ;%01100100 'd'
          ADC $66
L753A     .BYTE $FF    ;%11111111
          STA ($10,X)
          ASL $52
          .BYTE $53    ;%01010011 'S'
          .BYTE $62    ;%01100010 'b'
          .BYTE $63    ;%01100011 'c'
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $FF    ;%11111111
          .BYTE $82    ;%10000010
          BPL L754E
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $64    ;%01100100 'd'
          ADC $66
L754E     .BYTE $FF    ;%11111111
          ORA ($08,X)
          ASL $FC
          .BYTE $02    ;%00000010
          BRK
          BVC L75A8
          RTS
          ADC ($FF,X)
          STA ($08,X)
          ASL $FC
          INC $5000,X
          EOR ($60),Y
          ADC ($FF,X)
          CMP ($08,X)
          ASL $FC
          INC $5000,X
          EOR ($60),Y
          ADC ($FF,X)
          EOR ($08,X)
          ASL $FC
          .BYTE $02    ;%00000010
          BRK
          BVC L75C9
          RTS
          ADC ($FF,X)
          ASL $10
          ASL $69
          INC $5958,X
          INC $5B5A,X
          SBC $2E60,X
          AND $FDFE
          JSR $3C3B
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $FE
          ADC #$58
          EOR $5AFE,Y
          .BYTE $5B    ;%01011011 '['
          SBC $2E60,X
          AND $FDFE
          JSR $3C3B
          .BYTE $FF    ;%11111111
          BRK
          BPL L75AC
          .BYTE $0B    ;%00001011
          .BYTE $0C    ;%00001100
L75A8     INC $1C1B,X
          .BYTE $2B    ;%00101011 '+'
L75AC     BIT $3BFE
          .BYTE $3C    ;%00111100 '<'
          INC $17FE,X
          .BYTE $FF    ;%11111111
          RTI
          BPL L75BD
          SBC $0E20,X
          ORA $1EFE
L75BD     ORA $2D2E,X
          INC $60FD,X
          .BYTE $3B    ;%00111011 ';'
          .BYTE $3C    ;%00111100 '<'
          INC $17FE,X
          .BYTE $FF    ;%11111111
L75C9     .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          PHP
          INC $FD28,X
          RTS
          PLP
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          BPL L75FE
          SEC
          SEC
          SBC $2860,X
          .BYTE $FF    ;%11111111
          ORA ($10,X)
          PHP
          JMP $5C4D
          EOR $6D6C,X
          .BYTE $FF    ;%11111111
          ORA ($10,X)
          PHP
          JMP $5C4D
          EOR $5B5A,X
          .BYTE $FF    ;%11111111
          ORA ($10,X)
          PHP
          JMP $5C4D
          EOR $6B6A,X
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          BMI L75FE
          .BYTE $04    ;%00000100
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          .BYTE $37    ;%00110111 '7'
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          BRK
          BRK
          .BYTE $04    ;%00000100
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $69
          INC $20FD,X
          .BYTE $7A    ;%01111010 'z'
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          ROL $FE2D
          SBC $3B60,X
          .BYTE $3C    ;%00111100 '<'
          .BYTE $FF    ;%11111111
          ADC $18,X
          PHP
          .BYTE $0F    ;%00001111
          .BYTE $1F    ;%00011111
          .BYTE $2F    ;%00101111 '/'
          SBC $2FE3,X
          .BYTE $1F    ;%00011111
          .BYTE $0F    ;%00001111
          .BYTE $FF    ;%11111111
          ADC $18,X
          PHP
          EOR $6D5D
          SBC $6DE3,X
          EOR $FF4D,X
          ADC $18,X
          .BYTE $04    ;%00000100
          ROR A
          .BYTE $6B    ;%01101011 'k'
          JMP ($E3FD)
          JMP (L6A6B)
          .BYTE $FF    ;%11111111
          ADC $00,X
          BRK
          .BYTE $3F    ;%00111111 '?'
          INC $FD4F,X
          .BYTE $E3    ;%11100011
          .BYTE $4F    ;%01001111 'O'
          INC $FF3F,X
          LSR $10
          ASL $FE
          ADC #$FD
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
          PHP
          EOR $6D5D
          SBC $6DA3,X
          EOR $FF4D,X
          AND $18,X
          .BYTE $04    ;%00000100
          ROR A
          .BYTE $6B    ;%01101011 'k'
          JMP ($A3FD)
          JMP (L6A6B)
          .BYTE $FF    ;%11111111
          AND $00,X
          BRK
          .BYTE $3F    ;%00111111 '?'
          INC $FD4F,X
          .BYTE $A3    ;%10100011
          .BYTE $4F    ;%01001111 'O'
          INC $FF3F,X
          .BYTE $07    ;%00000111
          BRK
          BRK
          .BYTE $FC    ;%11111100
          .BYTE $FC    ;%11111100
          BRK
          ORA #$09
          ORA $2919,Y
          ROL A
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $69
          INC $5958,X
          INC $5B5A,X
          .BYTE $22    ;%00100010 '"'
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $FE
          ADC #$58
          EOR $5AFE,Y
          .BYTE $5B    ;%01011011 '['
          .BYTE $22    ;%00100010 '"'
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $69
          SBC $FE20,X
          .BYTE $7A    ;%01111010 'z'
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2260,X
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $FE
          ADC #$FD
          JSR L797A
          INC $7778,X
          SBC $2260,X
          .BYTE $07    ;%00000111
          PHP
          .BYTE $32    ;%00110010 '2'
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          BVS L76E6
          .BYTE $14    ;%00010100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          ADC ($FF),Y
          .BYTE $04    ;%00000100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          INC $FD74,X
          RTS
          .BYTE $74    ;%01110100 't'
          SBC $74A0,X
          SBC $74E0,X
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $69
          INC $5958,X
          INC $5B5A,X
          JSR $FE21
          INC $FF31,X
          ASL $10
          ASL $69
          INC $5958,X
          INC $5B5A,X
          .BYTE $22    ;%00100010 '"'
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $69
          INC $5958,X
          INC $5B5A,X
          AND $26
          .BYTE $27    ;%00100111 '''
          AND $36,X
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $69
          INC $20FD,X
          .BYTE $7A    ;%01111010 'z'
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2060,X
          AND ($FE,X)
          INC $FF31,X
          LSR $10
          ASL $69
          INC $20FD,X
          .BYTE $7A    ;%01111010 'z'
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2260,X
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $69
          INC $20FD,X
          .BYTE $7A    ;%01111010 'z'
          ADC $78FE,Y
          .BYTE $77    ;%01110111 'w'
          SBC $2560,X
          ROL $27
          AND $36,X
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $FE
          ADC #$58
          EOR $5AFE,Y
          .BYTE $5B    ;%01011011 '['
          JSR $FE21
          INC $FF31,X
          ASL $10
          ASL $FE
          ADC #$58
          EOR $5AFE,Y
          .BYTE $5B    ;%01011011 '['
          .BYTE $22    ;%00100010 '"'
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          ASL $10
          ASL $FE
          ADC #$58
          EOR $5AFE,Y
          .BYTE $5B    ;%01011011 '['
          AND $26
          .BYTE $27    ;%00100111 '''
          AND $36,X
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $FE
          ADC #$FD
          JSR L797A
          INC $7778,X
          SBC $2060,X
          AND ($FE,X)
          INC $FF31,X
          LSR $10
          ASL $FE
          ADC #$FD
          JSR L797A
          INC $7778,X
          SBC $2260,X
          .BYTE $23    ;%00100011 '#'
          INC $3332,X
          .BYTE $34    ;%00110100 '4'
          .BYTE $FF    ;%11111111
          LSR $10
          ASL $FE
          ADC #$FD
          JSR L797A
          INC $7778,X
          SBC $2560,X
          ROL $27
          AND $36,X
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          INC $FD75,X
          RTS
          ADC $FD,X
          LDY #$75
          SBC $75E0,X
          .BYTE $FF    ;%11111111
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          .BYTE $04    ;%00000100
          TXA
          .BYTE $FF    ;%11111111
          BRK
          BPL L7866
          .BYTE $34    ;%00110100 '4'
          SEI
          CLI
          SEI
          .BYTE $7C    ;%01111100 '|'
          SEI
          LDY #$78
          CPY $78
          INX
          SEI
          .BYTE $0C    ;%00001100
          ADC $7930,Y
          .BYTE $54    ;%01010100 'T'
          ADC $7978,Y
          .BYTE $9C    ;%10011100
          ADC $79C0,Y
          CPX $79
          PHP
          .BYTE $7A    ;%01111010 'z'
          BIT $507A
          .BYTE $7A    ;%01111010 'z'
          .BYTE $74    ;%01110100 't'
          .BYTE $7A    ;%01111010 'z'
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          AND $14,X
          .BYTE $04    ;%00000100
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
L7866     AND #$0F
          AND $0929,Y
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          ROL $15,X
          ASL $0F
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $27    ;%00100111 '''
          AND ($12,X)
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          AND ($20),Y
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          ORA ($0F,X)
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          ORA ($01,X)
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $02    ;%00000010
          .BYTE $02    ;%00000010
          ORA ($0F,X)
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $02    ;%00000010
          ORA ($01,X)
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $12    ;%00010010
          .BYTE $12    ;%00010010
          .BYTE $02    ;%00000010
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
L797A     JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          ORA ($02),Y
          .BYTE $02    ;%00000010
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          AND ($11),Y
          ORA ($0F,X)
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          .BYTE $12    ;%00010010
          BMI L79EC
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          AND ($11),Y
          ORA ($0F,X)
          ASL $2A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $12    ;%00010010
          BMI L79FC
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          BIT $2C
          .BYTE $0F    ;%00001111
          ORA $21,X
          SEC
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
L79EC     AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $12    ;%00010010
          .BYTE $02    ;%00000010
          ORA ($0F,X)
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
L79FC     .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          .BYTE $02    ;%00000010
          ORA ($0F,X)
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $280F
          CLC
          PHP
          .BYTE $0F    ;%00001111
          AND #$1B
          .BYTE $1A    ;%00011010
          .BYTE $0F    ;%00001111
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0F
          ORA ($0F,X)
          .BYTE $0F    ;%00001111
          .BYTE $0F    ;%00001111
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          .BYTE $0F    ;%00001111
          .BYTE $37    ;%00110111 '7'
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          .BYTE $0F    ;%00001111
          .BYTE $17    ;%00010111
          AND ($37),Y
          .BYTE $0F    ;%00001111
          .BYTE $32    ;%00110010 '2'
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $2830
          CLC
          PHP
          BMI L7A82
          .BYTE $1B    ;%00011011
          .BYTE $1A    ;%00011010
          BMI L7A84
          PLP
          AND #$30
          BMI L7A92
          BMI L7A94
          ASL $1A,X
          .BYTE $27    ;%00100111 '''
          BMI L7AA0
          .BYTE $3A    ;%00111010 ':'
          .BYTE $1B    ;%00011011
          BMI L7A84
          AND ($37),Y
          BMI L7AA3
          .BYTE $22    ;%00100010 '"'
          .BYTE $12    ;%00010010
          BRK
          .BYTE $3F    ;%00111111 '?'
          BRK
          .BYTE $04    ;%00000100
          .BYTE $0F    ;%00001111
          BMI L7AAA
          AND ($00,X)
          BRK
          JSR $4000
          BRK
          RTS
L7A82     .BYTE $FF    ;%11111111
          JSR $2040
          RTS
          RTI
          RTS
          .BYTE $FF    ;%11111111
          LDA $030D,X
          STA $07
          LDA $030E,X
L7A92     STA $09
L7A94     LDA $030C,X
          STA $0B
          RTS
          LDA $030D,Y
          STA $06
          LDA $030E,Y
          STA $08
          LDA $030C,Y
          STA $0A
          RTS
L7AAA     LDA $0301,X
          CLC
          ADC $0301,Y
          STA $04
          LDA $0302,X
          CLC
          ADC $0302,Y
          STA $05
          RTS
          LDA #$02
          STA $01
          LDA $07
          SEC
          SBC $06
          STA $02
          LDA $03
          BNE L7AE3
          LDA $0B
          EOR $0A
          BEQ L7AE3
          LDA $0B
          SBC $0A
          LSR A
          LDA $0A
          EOR $FF
          AND #$01
          ORA $01
          STA $01
          BNE L7AEC
L7AE3     LDA #$00
          SBC #$00
          BPL L7AEB
          INC $01
L7AEB     LSR A
L7AEC     LDA $02
          BCC L7AF5
          BEQ L7B33
          JSR L6B4B
L7AF5     STA $11
          CMP $04
          BCS L7B33
          ASL $01
          LDA $09
          SEC
          SBC $08
          STA $02
          LDA $03
          BEQ L7B1F
          LDA $0B
          EOR $0A
          BEQ L7B1F
          LDA $0B
          SBC $0A
          LSR A
          LDA $0A
          EOR $FF
          AND #$01
          ORA $01
          STA $01
          BNE L7B26
L7B1F     SBC #$00
          BPL L7B25
          INC $01
L7B25     LSR A
L7B26     LDA $02
          BCC L7B2F
          BEQ L7B33
          JSR L6B4B
L7B2F     STA $0F
          CMP $05
L7B33     RTS
          .BYTE $1F    ;%00011111
          BEQ L7B87
          BRK
          .BYTE $23    ;%00100011 '#'
          CPY #$20
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
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
          .BYTE $23    ;%00100011 '#'
          CPX #$20
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          .BYTE $27    ;%00100111 '''
          CPY #$20
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
L7B87     BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          .BYTE $27    ;%00100111 '''
          CPX #$20
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          .BYTE $22    ;%00100010 '"'
          CPX #$20
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CPY $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CMP $FFFF
          DEC $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CPY $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CMP $FFFF
          DEC $23FF
          BRK
          JSR $C1C0
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          .BYTE $23    ;%00100011 '#'
          JSR $C220
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $23    ;%00100011 '#'
          RTI
          JSR $C5C4
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          .BYTE $23    ;%00100011 '#'
          RTS
          JSR $C7C6
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          .BYTE $23    ;%00100011 '#'
          .BYTE $80    ;%10000000
          JSR $C9C8
          INY
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$23
          LDY #$20
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          ROL $E0
          JSR $FFFF
          CPY $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CMP $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          DEC $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CPY $FFFF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $27    ;%00100111 '''
          BRK
          JSR $C1C0
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          CPY #$C1
          .BYTE $27    ;%00100111 '''
          JSR $C220
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $C3    ;%11000011
          .BYTE $27    ;%00100111 '''
          RTI
          JSR $C5C4
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          CPY $C5
          .BYTE $27    ;%00100111 '''
          RTS
          JSR $C7C6
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          DEC $C7
          .BYTE $27    ;%00100111 '''
          .BYTE $80    ;%10000000
          JSR $C9C8
          INY
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$C8
          CMP #$27
          LDY #$20
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          DEX
          .BYTE $CB    ;%11001011
          BRK
          CMP #$7D
          SBC $117D
          ROR $7E35,X
          EOR $757E,Y
          ROR $7E91,X
          LDA $C97E
          ROR $7EE5,X
          ORA ($7F,X)
          ORA $327F,X
          .BYTE $7F    ;%01111111
          .BYTE $23    ;%00100011 '#'
          CPY #$20
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
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
          BRK
          .BYTE $23    ;%00100011 '#'
          CPX #$20
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          .BYTE $27    ;%00100111 '''
          CPY #$20
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          .BYTE $27    ;%00100111 '''
          CPX #$20
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          AND ($24,X)
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          .BYTE $FF    ;%11111111
          ASL A
          .BYTE $0B    ;%00001011
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $0F    ;%00001111
          BVS L7EDF
          .BYTE $72    ;%01110010 'r'
          .BYTE $73    ;%01110011 's'
          .BYTE $74    ;%01110100 't'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          AND ($44,X)
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $12    ;%00010010
          .BYTE $13    ;%00010011
          .BYTE $14    ;%00010100
          ORA $16,X
          .BYTE $17    ;%00010111
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $1A    ;%00011010
          .BYTE $1B    ;%00011011
          .BYTE $1C    ;%00011100
          ORA $1F1E,X
          .BYTE $80    ;%10000000
          STA ($82,X)
          .BYTE $83    ;%10000011
          STY $85
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          AND ($64,X)
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $23    ;%00100011 '#'
          BIT $25
          ROL $27
          PLP
          AND #$2A
          .BYTE $2B    ;%00101011 '+'
          BIT $2E2D
          .BYTE $2F    ;%00101111 '/'
          BCC L7E37
          .BYTE $92    ;%10010010
          .BYTE $93    ;%10010011
          STY $95,X
          STX $FF,Y
          BRK
          AND ($84,X)
          CLC
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $32    ;%00110010 '2'
          .BYTE $33    ;%00110011 '3'
          .BYTE $34    ;%00110100 '4'
          AND $36,X
          .BYTE $37    ;%00110111 '7'
          SEC
          AND $3B3A,Y
          .BYTE $3C    ;%00111100 '<'
          AND $3F3E,X
          SEI
          ADC $7B7A,Y
          .BYTE $7C    ;%01111100 '|'
          ADC $FF7E,X
          BRK
          AND ($A4,X)
          CLC
          .BYTE $FF    ;%11111111
          EOR ($42,X)
          .BYTE $43    ;%01000011 'C'
          .BYTE $44    ;%01000100 'D'
          EOR $46
          .BYTE $47    ;%01000111 'G'
          PHA
          EOR #$4A
          .BYTE $4B    ;%01001011 'K'
          JMP $4E4D
          .BYTE $4F    ;%01001111 'O'
          DEY
          .BYTE $89    ;%10001001
          TXA
L7EDF     .BYTE $8B    ;%10001011
          STY $8E8D
          .BYTE $8F    ;%10001111
          BRK
          AND ($C4,X)
          CLC
          BVC L7F3B
          .BYTE $52    ;%01010010 'R'
          .BYTE $53    ;%01010011 'S'
          .BYTE $54    ;%01010100 'T'
          EOR $56,X
          .BYTE $57    ;%01010111 'W'
          CLI
          EOR $5B5A,Y
          .BYTE $5C    ;%01011100 '\'
          EOR $5F5E,X
          TYA
          STA $9B9A,Y
          .BYTE $9C    ;%10011100
          STA $9F9E,X
          BRK
          AND ($E4,X)
          CLC
          RTS
          ADC ($62,X)
          .BYTE $63    ;%01100011 'c'
          .BYTE $FF    ;%11111111
          ADC $66
          .BYTE $67    ;%01100111 'g'
          .BYTE $FF    ;%11111111
          ADC #$6A
          .BYTE $6B    ;%01101011 'k'
          JMP (L6E6D)
          .BYTE $6F    ;%01101111 'o'
          TAY
          LDA #$AA
          .BYTE $AB    ;%10101011
          LDY $FFAD
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $22    ;%00100010 '"'
          PLP
          ORA ($B4),Y
          TSX
          LDX $B5,Y
          .BYTE $FF    ;%11111111
          LDX $A3,Y
          .BYTE $B7    ;%10110111
          CLV
          .BYTE $A3    ;%10100011
          .BYTE $FF    ;%11111111
          LDA $A3BA,Y
          .BYTE $A3    ;%10100011
          LDX $A1
          BRK
          .BYTE $22    ;%00100010 '"'
          ADC #$0E
          LDY #$B0
          LDA ($B2),Y
          .BYTE $B3    ;%10110011
          .BYTE $FF    ;%11111111
L7F3B     LDA ($A2,X)
          LDA ($A3,X)
          LDY $A1
          LDA $A6
          BRK
          .BYTE $64    ;%01100100 'd'
          .BYTE $7F    ;%01111111
          .BYTE $7F    ;%01111111
          .BYTE $7F    ;%01111111
          TXS
          .BYTE $7F    ;%01111111
          LDA $7F,X
          BNE L7FCD
          .BYTE $EB    ;%11101011
          .BYTE $7F    ;%01111111
          ASL $80
          AND ($80,X)
          .BYTE $3C    ;%00111100 '<'
          .BYTE $80    ;%10000000
          .BYTE $57    ;%01010111 'W'
          .BYTE $80    ;%10000000
          .BYTE $72    ;%01110010 'r'
          .BYTE $80    ;%10000000
          STA $A880
          .BYTE $80    ;%10000000
          .BYTE $C3    ;%11000011
          .BYTE $80    ;%10000000
          DEC $F980,X
          .BYTE $80    ;%10000000
          JSR $46A4
          .BYTE $D4    ;%11010100
          ADC $D4,X
          .BYTE $BF    ;%10111111
          CMP ($FF),Y
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
          .BYTE $BB    ;%10111011
          .BYTE $64    ;%01100100 'd'
          CMP $76,X
          BNE L7F7D
          ROR $20,X
          TAX
          LSR $D8
          AND ($D0),Y
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
          .BYTE $BB    ;%10111011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          LDA $D902,X
          .BYTE $FF    ;%11111111
          .BYTE $CF    ;%11001111
          .BYTE $FF    ;%11111111
          JSR $46B0
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
          .BYTE $BB    ;%10111011
          .BYTE $FF    ;%11111111
          ASL $4087
          BNE L7F3B
          .BYTE $FF    ;%11111111
          JSR $46B6
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
          PLA
          .BYTE $FF    ;%11111111
          .BYTE $77    ;%01110111 'w'
L7FCD     .BYTE $D2    ;%11010010
          CLD
          .BYTE $FF    ;%11111111
          AND ($24,X)
          LSR $FF
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
          .BYTE $D4    ;%11010100
          .BYTE $D3    ;%11010011
          BNE L8059
          BNE L7FF3
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          AND ($2A,X)
          LSR $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
L7FF3     .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $BB    ;%10111011
          BNE L8073
          BNE L7FFD
          ORA $FFD7
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          AND ($30,X)
          LSR $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $BB    ;%10111011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          LDA $317F,X
          BNE L808F
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          AND ($36,X)
          LSR $FF
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
          PLA
          .BYTE $FF    ;%11111111
          .BYTE $97    ;%10010111
          .BYTE $D3    ;%11010011
          BNE L8035
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          AND ($A4,X)
          LSR $FF
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ROR $19,X
          LDX $FFFF,Y
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
          AND ($AA,X)
L8059     LSR $FF
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
          .BYTE $BB    ;%10111011
          .BYTE $FF    ;%11111111
          .BYTE $BB    ;%10111011
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $D4    ;%11010100
          ADC $D3,X
          .BYTE $FF    ;%11111111
          AND ($75),Y
          AND ($B0,X)
          LSR $FF
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
          LDY $FFFF,X
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ORA #$D1
          .BYTE $FF    ;%11111111
          DEC $D0,X
          .BYTE $D7    ;%11010111
          AND ($B6,X)
L808F     LSR $FF
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
          STX $FF
          .BYTE $A7    ;%10100111
          LDX $AFB0
          .BYTE $22    ;%00100010 '"'
          BIT $46
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
          .BYTE $22    ;%00100010 '"'
          ROL A
          LSR $FF
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
          .BYTE $22    ;%00100010 '"'
          BMI L8127
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
          .BYTE $22    ;%00100010 '"'
          ROL $46,X
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
          LSR $FF
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
L8127     .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          JSR $0000
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          EOR ($81),Y
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          ORA ($00,X)
          BRK
          BRK
          BRK
          BRK
          .BYTE $02    ;%00000010
          BRK
          BRK
          .BYTE $03    ;%00000011
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          ORA ($00,X)
          BRK
          BRK
          BRK
          BRK
          .BYTE $02    ;%00000010
          BRK
          BRK
          .BYTE $03    ;%00000011
          ADC $7A81,Y
          STA ($7D,X)
          STA ($80,X)
          STA ($00,X)
          CLC
          CPY $1800
          CMP $1800
          DEC $A200
          ASL A
L8185     LDA $819C,X
          STA $0480,X
          STA $0490,X
          DEX
          BPL L8185
          LDA #$6B
          STA $0490
          LDA #$DC
          STA $0493
          RTS
          EOR #$E1
          ORA ($3D,X)
          BRK
          BRK
          BRK
          BRK
          JSR $0000
L81A7     LDX #$00
          JSR L81AE
          LDX #$10
L81AE     JSR L81B1
L81B1     LDA $0485,X
          BNE L81B9
          JSR L81F2
L81B9     LDA $048A,X
          BNE L81F1
          DEC $0485,X
          LDA $0486,X
          CLC
          ADC $0480,X
          STA $0480,X
          LDA $0487,X
          CLC
          ADC $0483,X
          STA $0483,X
          DEC $0488,X
          BNE L81EE
          LDA $0481,X
          EOR #$03
          STA $0481,X
          LDA #$20
          STA $0488,X
          ASL A
          EOR $0482,X
          STA $0482,X
L81EE     JMP L8253
L81F1     RTS
L81F2     TXA
          JSR L6B53
          TAY
          LDA $83F3,Y
          STA $00
          LDA $83F4,Y
          STA $01
          LDY $0484,X
          LDA ($00),Y
          BPL L820D
          LDA #$01
          STA $0489,X
L820D     BNE L8214
          LDA #$01
          STA $048A,X
L8214     STA $0485,X
          INY
          LDA ($00),Y
          DEC $0489,X
          BMI L8228
          LDA #$00
          STA $0486,X
          LDA ($00),Y
          BMI L823F
L8228     PHA
          PHA
          LDA #$00
          STA $0489,X
          PLA
          JSR L6B52
          JSR L8249
          STA $0486,X
          PLA
          AND #$0F
          JSR L8249
L823F     STA $0487,X
          INC $0484,X
          INC $0484,X
          RTS
L8249     CMP #$08
          BCC L8252
          AND #$07
          JSR L6B4B
L8252     RTS
L8253     LDA $0480,X
          SEC
          SBC #$01
          STA $0210,X
          LDA $0481,X
          STA $0211,X
          LDA $0482,X
          STA $0212,X
          LDA $0483,X
          STA $0213,X
          RTS
L826F     LDA #$20
          STA $45
          LDX #$3F
L8275     LDA $8296,X
          CMP $FF
          BEQ L8282
          STA $0480,X
          STA $04C0,X
L8282     DEX
          BPL L8275
          LDA #$B8
          STA $04E0
          STA $04F0
          LDA #$16
          STA $04ED
          STA $04FD
          RTS
          JSR L80E0
          BRK
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $74    ;%01110100 't'
          CLI
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $FF    ;%11111111
          ORA $010E,X
          ORA ($20,X)
          CPX #$C0
          SED
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $7C    ;%01111100 '|'
          CLI
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $FF    ;%11111111
          .BYTE $1F    ;%00011111
          ASL $0180
          INY
          CPX #$00
          BRK
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $74    ;%01110100 't'
          RTS
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $FF    ;%11111111
          ORA $011A,X
          .BYTE $80    ;%10000000
          INY
          CPX #$40
          SED
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $7C    ;%01111100 '|'
          RTS
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          .BYTE $FF    ;%11111111
          .BYTE $1F    ;%00011111
          .BYTE $1A    ;%00011010
          .BYTE $80    ;%10000000
          .BYTE $80    ;%10000000
L82D6     LDA $44
          BEQ L830E
          DEC $44
          BNE L830E
          ASL $048C
          ASL $048D
          ASL $049C
          ASL $049D
          ASL $04AC
          ASL $04AD
          ASL $04BC
          ASL $04BD
          ASL $04CC
          ASL $04CD
          ASL $04DC
          ASL $04DD
          ASL $04EC
          ASL $04ED
          ASL $04FC
          ASL $04FD
L830E     LDX #$00
          JSR L833B
          LDX #$10
          JSR L833B
          LDX #$20
          JSR L833B
          LDX #$30
          LDA $45
          BEQ L8327
          DEC $45
          BNE L833B
L8327     JSR L833B
          LDX #$40
          JSR L833B
          LDX #$50
          JSR L833B
          LDX #$60
          JSR L833B
          LDX #$70
L833B     LDA $048A,X
          BNE L834D
          JSR L8387
          BCS L834A
          LDA #$01
          STA $048A,X
L834A     JMP L8253
L834D     RTS
L834E     LDA $4F
          BEQ L8381
          LDY $4E
          CPY #$04
          BCC L835E
          BNE L8381
          LDA #$00
          STA $4F
L835E     LDA $8382,Y
          STA $00
          LDY #$00
L8365     LDX $848F,Y
          INY
L8369     LDA $848F,Y
          STA $0200,X
          INX
          INY
          TXA
          AND #$03
          BNE L8369
          CPY $00
          BNE L8365
          LDA $27
          LSR A
          BCC L8381
          INC $4E
L8381     RTS
          ORA $19
          EOR ($19,X)
          ORA $BD
          STY $2004
          .BYTE $DA    ;%11011010
          .BYTE $83    ;%10000011
          LDY $048E,X
          BPL L8397
          EOR #$FF
          CLC
          ADC #$01
L8397     CLC
          ADC $0483,X
          STA $0483,X
          SEC
          SBC $0486,X
          PHP
          PLA
          EOR $048E,X
          LSR A
          BCC L83CD
          LDA $048D,X
          JSR L83DA
          LDY $048F,X
          BPL L83BA
          EOR #$FF
          CLC
          ADC #$01
L83BA     CLC
          ADC $0480,X
          STA $0480,X
          SEC
          SBC $0487,X
          PHP
          PLA
          EOR $048F,X
          LSR A
          BCS L83D9
L83CD     LDA $0487,X
          STA $0480,X
          LDA $0486,X
          STA $0483,X
L83D9     RTS
L83DA     STA $04
          LDA #$08
          STA $00
L83E0     LSR $04
          BCC L83EC
          LDA $27
          AND $00
          BNE L83EC
          INC $04
L83EC     LSR $00
          BNE L83E0
          LDA $04
          RTS
          .BYTE $F7    ;%11110111
          .BYTE $83    ;%10000011
          AND $0184
          BRK
          ORA ($11,X)
          ORA ($10,X)
          ASL $11
          .BYTE $07    ;%00000111
          STA ($10),Y
          ORA ($03,X)
          BPL L8407
          ORA $1001,Y
          ORA ($19,X)
          ORA ($10,X)
          ORA ($19,X)
          ORA #$11
          .BYTE $04    ;%00000100
          ORA ($02,X)
          STA ($01),Y
          BCC L8419
          STA ($06),Y
          BCC L841D
          STA ($06),Y
          BCC L8435
          ORA ($06,X)
          BPL L8425
          ORA ($0E),Y
          ORA ($08,X)
          STA ($27),Y
          ORA ($00,X)
          BRK
          ORA ($00,X)
          PHP
          ORA #$01
          STA $0901,Y
L8435     ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($09,X)
          ORA ($99,X)
          ORA ($19,X)
          ORA ($11,X)
          ORA ($10,X)
          ORA ($11,X)
          ORA ($10,X)
          ORA ($11,X)
          ORA ($10,X)
          ORA ($11,X)
          ORA ($10,X)
          ORA ($11,X)
          ORA ($10,X)
          ORA ($11,X)
          ORA ($10,X)
          ORA ($11,X)
          ORA ($10,X)
          .BYTE $02    ;%00000010
          ORA ($01),Y
          BPL L847B
          ORA ($10),Y
          ORA #$FF
          .BYTE $EF    ;%11101111
          ORA ($09),Y
          .BYTE $FF    ;%11111111
          .BYTE $F3    ;%11110011
          .BYTE $1F    ;%00011111
          ORA #$FF
          CPX $090F
          .BYTE $FF    ;%11111111
          SBC $0916
          BRK
          BRK
          BPL L84EB
          SBC $00
          ADC $5214,Y
          .BYTE $E3    ;%11100011
          BRK
          ADC $5A18,Y
          .BYTE $E7    ;%11100111
          RTI
          ADC ($1C),Y
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $E7    ;%11100111
          BRK
          STA ($20,X)
          .BYTE $62    ;%01100010 'b'
          .BYTE $E3    ;%11100011
          .BYTE $80    ;%10000000
          ADC $5214,Y
          CPX $00
          ADC $5A18,Y
          INC $00
          ADC ($1C),Y
          .BYTE $5A    ;%01011010 'Z'
          INC $00
          STA ($20,X)
          .BYTE $62    ;%01100010 'b'
          CPX $00
          ADC $4A24,Y
          .BYTE $E3    ;%11100011
          BRK
          ADC $5A28,Y
          .BYTE $E7    ;%11100111
          RTI
          ADC #$2C
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $E7    ;%11100111
          BRK
          .BYTE $89    ;%10001001
          BMI L8537
          .BYTE $E3    ;%11100011
          .BYTE $80    ;%10000000
          ADC $50A5,Y
          BEQ L84ED
          LDA $27
          LSR A
          BCS L84ED
          LDX #$9F
L84DB     DEC $8500,X
          DEC $0260,X
          DEX
          DEX
          DEX
          DEX
          CPX #$FF
          BNE L84DB
          LDA #$00
L84EB     STA $50
L84ED     RTS
L84EE     LDY #$9F
L84F0     LDA $8500,Y
          STA $0260,Y
          DEY
          CPY #$FF
          BNE L84F0
          LDA #$00
          STA $50
          RTS
          .BYTE $73    ;%01110011 's'
          CPY $F222
          PHA
          CMP $EE63
          ROL A
          DEC $DCA2
          ROL $CF,X
          .BYTE $E2    ;%11100010
          DEC $11
          CPY $B723
          .BYTE $53    ;%01010011 'S'
          CMP $A063
          .BYTE $BB    ;%10111011
          DEC $9AA2
          .BYTE $0F    ;%00001111
          .BYTE $CF    ;%11001111
          .BYTE $E2    ;%11100010
          .BYTE $8B    ;%10001011
          STA $CC
          .BYTE $E2    ;%11100010
          BVS L84C2
          CMP $6BA3
          LDY #$CE
          .BYTE $63    ;%01100011 'c'
          CLI
          .BYTE $63    ;%01100011 'c'
          .BYTE $CF    ;%11001111
          .BYTE $23    ;%00100011 '#'
          .BYTE $4F    ;%01001111 'O'
          ASL A
          CPY $3922
          .BYTE $1F    ;%00011111
          CMP $2A23
          .BYTE $7F    ;%01111111
          DEC $1FA3
          LSR $CF,X
          LDX #$03
          EOR $E3CC
          .BYTE $AF    ;%10101111
          ROL $63CD,X
          .BYTE $2B    ;%00101011 '+'
          ADC ($CE,X)
          .BYTE $E2    ;%11100010
          .BYTE $4F    ;%01001111 'O'
          AND #$CF
          .BYTE $62    ;%01100010 'b'
          .BYTE $6F    ;%01101111 'o'
          TXA
          CPY $8223
          TYA
          CMP $07A3
          LDX $E2CE
          DEX
          LDX $CF,Y
          .BYTE $63    ;%01100011 'c'
          .BYTE $E3    ;%11100011
          .BYTE $0F    ;%00001111
          CPY $1862
          .BYTE $1F    ;%00011111
          CMP $3822
          .BYTE $22    ;%00100010 '"'
          DEC $5FA3
          .BYTE $53    ;%01010011 'S'
          .BYTE $CF    ;%11001111
          .BYTE $E2    ;%11100010
          SEI
          PHA
          CPY $94E3
          .BYTE $37    ;%00110111 '7'
          CMP $B3A3
          .BYTE $6F    ;%01101111 'o'
          DEC $DCA3
          SEI
          .BYTE $CF    ;%11001111
          .BYTE $22    ;%00100010 '"'
          INC $CC83,X
          .BYTE $62    ;%01100010 'b'
          .BYTE $0B    ;%00001011
          .BYTE $9F    ;%10011111
          CMP $2623
          LDY #$CE
          .BYTE $62    ;%01100010 'b'
          AND $CFBD,Y
          LDX #$1C
          .BYTE $07    ;%00000111
          CPY $A4E3
          .BYTE $87    ;%10000111
          CMP $5D63
          .BYTE $5A    ;%01011010 'Z'
          DEC $4F62
          SEC
          .BYTE $CF    ;%11001111
          .BYTE $23    ;%00100011 '#'
          STA $A4
          EOR #$B9
          LDX $C985
          .BYTE $FF    ;%11111111
          BEQ L85AD
          STA $1C
          INC $49
L85AD     RTS
          .BYTE $02    ;%00000010
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          ORA #$0A
          .BYTE $0B    ;%00001011
          .BYTE $0C    ;%00001100
          .BYTE $0C    ;%00001100
          .BYTE $FF    ;%11111111
L85BB     LDY $4A
          LDA $85D1,Y
          CMP #$FF
          BNE L85CC
          LDA #$00
          STA $4A
          STA $48
          BEQ L85D0
L85CC     STA $1C
          INC $4A
L85D0     RTS
          ORA ($01),Y
          ORA ($01),Y
          ORA ($11),Y
          ORA ($11,X)
          ORA ($FF,X)
L85DB     LDA $27
          AND #$0F
          BNE L85E6
          LDA $07A0
          BEQ L85E7
L85E6     RTS
L85E7     LDA #$19
          STA $00
          LDA #$3F
          STA $01
          LDA $4B
          AND #$07
          ASL A
          TAY
          LDA $8613,Y
          STA $02
          LDA $8614,Y
          STA $03
          INC $4B
          JSR L6C1D
          LDA #$1D
          STA $00
          LDA #$3F
          STA $01
          INY
          JSR L6B35
          JMP L6C1D
          .BYTE $23    ;%00100011 '#'
          STX $2D
          STX $37
          STX $41
          STX $4B
          STX $55
          STX $5F
          STX $69
          STX $03
          .BYTE $0F    ;%00001111
          .BYTE $02    ;%00000010
          .BYTE $13    ;%00010011
          BRK
          .BYTE $03    ;%00000011
          BRK
          .BYTE $34    ;%00110100 '4'
          .BYTE $0F    ;%00001111
          BRK
          .BYTE $03    ;%00000011
          ASL $01
          .BYTE $23    ;%00100011 '#'
          BRK
          .BYTE $03    ;%00000011
          .BYTE $0F    ;%00001111
          .BYTE $34    ;%00110100 '4'
          ORA #$00
          .BYTE $03    ;%00000011
          ASL $0F,X
          .BYTE $23    ;%00100011 '#'
          BRK
          .BYTE $03    ;%00000011
          .BYTE $0F    ;%00001111
          BIT $1A
          BRK
          .BYTE $03    ;%00000011
          .BYTE $17    ;%00010111
          .BYTE $0F    ;%00001111
          .BYTE $13    ;%00010011
          BRK
          .BYTE $03    ;%00000011
          BRK
          .BYTE $04    ;%00000100
          PLP
          BRK
          .BYTE $03    ;%00000011
          .BYTE $17    ;%00010111
          ORA ($14,X)
          BRK
          .BYTE $03    ;%00000011
          BPL L8662
          PLP
          BRK
          .BYTE $03    ;%00000011
          ASL $02,X
          .BYTE $0F    ;%00001111
          BRK
          .BYTE $03    ;%00000011
          BMI L866C
          .BYTE $1A    ;%00011010
          BRK
          .BYTE $03    ;%00000011
          ASL $12
L8662     .BYTE $0F    ;%00001111
          BRK
          .BYTE $03    ;%00000011
          BMI L866B
          ORA #$00
          .BYTE $03    ;%00000011
          .BYTE $0F    ;%00001111
L866B     .BYTE $12    ;%00010010
L866C     .BYTE $14    ;%00010100
          BRK
          .BYTE $03    ;%00000011
          BPL L8695
          .BYTE $0F    ;%00001111
          BRK
L8673     LDY $4C
          LDA $8681,Y
          CMP #$FF
          BEQ L8680
          STA $1C
          INC $4C
L8680     RTS
          ORA $0F0E
          BPL L8687
          .BYTE $FF    ;%11111111
L8687     ORA ($10,X)
          .BYTE $0F    ;%00001111
          ASL $FF0D
L868D     LDA $5C
          BEQ L86BD
          LDX #$01
          LDA $13
L8695     ASL A
          BCS L869E
          ASL A
          BCC L86BD
          INX
          INX
          INX
L869E     LDY #$03
          LDA $15
          LSR A
          BCS L86B5
          LSR A
          BCS L86B0
          LDY #$00
          LSR A
          BCS L86B5
          LSR A
          BCC L86BD
L86B0     TXA
          JSR L6B4B
          TAX
L86B5     TXA
          CLC
          ADC $005D,Y
          STA $005D,Y
L86BD     RTS
L86BE     LDA $59
          BEQ L8706
          LDA $55
          DEC $56
          BNE L86DA
          PHA
          LDY $57
          LDA $873B,Y
          STA $55
          LDX $873C,Y
          STX $56
          INC $57
          INC $57
          PLA
L86DA     LDX #$01
          LDY $15
          STY $00
          STA $15
          EOR $00
          BEQ L86EE
          LDA $00
          AND #$BF
          STA $00
          EOR $15
L86EE     AND $15
          STA $13
          STA $17
          LDY #$20
          LDA $15
          CMP $00
          BNE L8704
          DEC $18,X
          BNE L8706
          STA $17
          LDY #$10
L8704     STY $18,X
L8706     RTS
L8707     LDA $58
          BEQ L873A
          LDX $57
          LDA $15
          CMP $873B,X
          BEQ L8722
          LDY $873C,X
          BNE L872A
          DEX
          DEX
          DEC $57
          DEC $57
          JMP L872A
L8722     INC $873C,X
          BNE L873A
          DEC $873E,X
L872A     STA $873D,X
          INC $873E,X
          INC $57
          INC $57
          BNE L873A
          LDA #$00
          STA $58
L873A     RTS
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BCC L8750
          .BYTE $0B    ;%00001011
          BRK
          BRK
          BRK
          BRK
          BRK
          LDA ($01),Y
L8750     ROL $81,X
          ORA $2B01,X
          STA ($1E,X)
          ORA ($2A,X)
          STA ($1B,X)
          ORA ($28,X)
          STA ($1B,X)
          ORA ($3A,X)
          EOR ($06,X)
          ORA ($05,X)
          EOR ($06,X)
          ORA ($05,X)
          EOR ($05,X)
          ORA ($06,X)
          EOR ($06,X)
          ORA ($07,X)
          EOR ($03,X)
          ORA ($06,X)
          EOR ($06,X)
          ORA ($06,X)
          EOR ($04,X)
          ORA ($06,X)
          EOR ($05,X)
          ORA ($06,X)
          EOR ($05,X)
          ORA ($06,X)
          EOR ($06,X)
          ORA ($1E,X)
          STA ($17,X)
          ORA ($25,X)
          STA ($1D,X)
          ORA ($25,X)
          STA ($20,X)
          ORA ($22,X)
          STA ($25,X)
          ORA ($1E,X)
          STA ($20,X)
          ORA ($21,X)
          STA ($20,X)
          ORA ($20,X)
          STA ($1E,X)
          ORA ($22,X)
          STA ($29,X)
          ORA ($32,X)
          EOR ($08,X)
          ORA ($05,X)
          EOR ($06,X)
          ORA ($05,X)
          EOR ($07,X)
          ORA ($04,X)
          EOR ($06,X)
          ORA ($05,X)
          EOR ($06,X)
          ORA ($2E,X)
          EOR ($07,X)
          ORA ($06,X)
          EOR ($05,X)
          ORA ($06,X)
          EOR ($06,X)
          ORA ($05,X)
          EOR ($07,X)
          ORA ($27,X)
          STA ($21,X)
          ORA ($23,X)
          STA ($19,X)
          ORA ($00,X)
          ORA ($00,X)
          ORA ($20,X)
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
          BRK
L883B     JSR L6CD2
          JSR L69DF
          JSR L6A1C
          JMP $CF1D
          LDA #$FF
          STA $0102
          STA $0103
          JSR L883B
          LDA $39
          BNE L8899
          LDA $2002
          LDA #$10
          STA $2006
          LDA #$00
          STA $2006
          STA $2F
          TAY
          TAX
          LDA #$15
          STA $2D
          LDA #$C6
          STA $2E
L886F     LDA ($2D),Y
          STA $2007
          INC $2D
          LDA $2D
          BNE L887C
          INC $2E
L887C     INX
          BNE L886F
          INC $2F
          LDA $2F
          CMP #$08
          BNE L886F
L8887     LDA ($2D),Y
          STA $2007
          INC $2D
          LDA $2D
          BNE L8894
          INC $2E
L8894     INX
          CPX #$20
          BNE L8887
L8899     LDA #$00
          STA $39
          LDX #$31
          LDY #$8F
          JSR L8E39
          INC $36
          JSR L8CF2
          DEC $36
          LDA $2002
          LDY #$00
L88B0     LDA $C5A0,Y
          AND #$01
          BEQ L8915
          TYA
          ASL A
          TAX
          JSR L8E70
          JSR L8E90
          LDA $8D43,X
          STA $2006
          LDA $8D44,X
          CLC
          ADC #$0F
          STA $2006
          LDA $C5DC,X
          STA $2007
          LDA $C5DD,X
          JSR L892D
          LDA $8D43,X
          STA $2006
          LDA $8D44,X
          CLC
          ADC #$24
          STA $2006
          LDA $C5D3,X
          JSR L892D
          LDA $C5D4,X
          JSR L892D
          LDA $C5D9,Y
          BEQ L8915
          PHA
          LDA $8D43,X
          STA $2006
          LDA $8D44,X
          CLC
          ADC #$08
          STA $2006
          PLA
          TAX
L890D     LDA #$74
          STA $2007
          DEX
          BNE L890D
L8915     INY
          CPY #$03
          BNE L88B0
          JSR L8C77
          STY $38
          LDA #$0D
          STA $1C
          LDA #$16
          STA $1F
L8927     JSR $CF27
          JMP L6CE0
L892D     PHA
          LSR A
          LSR A
          LSR A
          LSR A
          STA $2007
          PLA
          AND #$0F
          STA $2007
          RTS
          LDA $12
          AND #$30
          CMP #$10
          BNE L8956
          LDY $38
          CPY #$03
          BCC L8992
          BEQ L8950
          LDY #$19
          BNE L8952
L8950     LDY #$17
L8952     STY $1F
          BCS L896C
L8956     CMP #$20
          BNE L896C
          LDY $38
          INY
          CPY #$05
          BNE L8963
          LDY #$00
L8963     CPY #$03
          BCS L896A
          JSR L8C79
L896A     STY $38
L896C     LDY $38
          LDA $898D,Y
          STA $0200
          LDA #$E8
          STA $0201
          LDA #$03
          STA $0202
          LDA #$18
          STA $0203
          LDX #$38
          LDY #$28
          JSR L8C95
          JMP L8DB1
          RTI
          RTS
          .BYTE $80    ;%10000000
          LDY #$B8
L8992     LDA $38
          ASL A
          ASL A
          ASL A
          ASL A
          TAX
          LDY $C5EE,X
          BEQ L89A6
          DEC $C5EE,X
          LDA #$81
          STA $C5F0,X
L89A6     LDY #$00
L89A8     LDA $C5E2,X
          STA $B410,Y
          INX
          INY
          CPY #$10
          BNE L89A8
          LDA $38
          STA $B41F
          TAX
          LDA $C5A0,X
          ORA $B41E
          STA $B41E
          AND #$01
          STA $C5A0,X
          JSR $CE35
          JMP $CE66
          JSR L883B
          LDX #$42
          LDY #$90
          JSR L8E39
          JSR L8D5E
          JSR L8CF2
          LDA #$00
          STA $34
          STA $35
          LDA #$80
          STA $33
          JSR L8C86
          STY $37
          INC $1F
          JMP L8927
          JSR L6A1C
          LDX #$30
          LDY #$58
          JSR L8C95
          JSR L8DB1
          LDY $37
          LDA $12
          AND #$30
          CMP #$10
          BNE L8A39
          CPY #$03
          BNE L8A39
          LDA #$1B
          STA $1F
          INC $39
          LDX #$00
          LDY #$00
L8A17     LDA #$00
          STA $2D
L8A1B     LDA $C5A3,Y
          CMP #$FF
          BEQ L8A2A
          LDA $C5A0,X
          ORA #$01
          STA $C5A0,X
L8A2A     INY
          INC $2D
          LDA $2D
          CMP #$10
          BNE L8A1B
          INX
          CPX #$03
          BNE L8A17
          RTS
L8A39     CMP #$20
          BNE L8A51
          LDA #$80
          STA $33
          INY
          CPY #$04
          BNE L8A48
          LDY #$00
L8A48     CPY #$03
          BEQ L8A4F
          JSR L8C88
L8A4F     STY $37
L8A51     CPY #$03
          BNE L8A58
          JMP L8AE8
L8A58     LDA $12
          BPL L8AD5
          LDX $07A0
          TYA
          ASL A
          TAY
          LDA $8B81,Y
          JSR L8E5C
          LDA $33
          LSR A
          LSR A
          LSR A
          ADC $8B82,Y
          JSR L8E5C
          LDA $34
          ASL A
          TAY
          LDA $8FCF,Y
          STA $2D
          LDA $8FD0,Y
          STA $2E
          LDY $35
          LDA ($2D),Y
          PHA
          PHA
          CMP #$5B
          BEQ L8A98
          CMP #$5C
          BEQ L8A98
          LDA #$82
          JSR L8E5C
          LDA #$FF
          BNE L8A9A
L8A98     LDA #$01
L8A9A     JSR L8E5C
          PLA
          JSR L8E5C
          JSR L8E40
          LDA $37
          STA $2D
          LDA $33
          ASL A
          LDX #$00
L8AAD     ASL A
          ROL $2D
          INX
          CPX #$04
          BNE L8AAD
          LDX $2D
          PLA
          CMP #$5B
          BEQ L8AC5
          CMP #$5C
          BEQ L8AC5
          STA $C5A3,X
          LDA #$FF
L8AC5     STA $C5AB,X
          LDA $33
          CLC
          ADC #$08
          CMP #$C0
          BNE L8AD3
          LDA #$80
L8AD3     STA $33
L8AD5     LDA $12
          AND #$40
          BEQ L8AE8
          LDA $33
          SEC
          SBC #$08
          CMP #$78
          BNE L8AE6
          LDA #$B8
L8AE6     STA $33
L8AE8     LDY $37
          LDA $8B87,Y
          STA $0200
          LDA #$E8
          STA $0201
          LDA #$03
          STA $0202
          LDA #$40
          STA $0203
          CPY #$03
          BEQ L8B80
          LDA $27
          AND #$08
          BEQ L8B1E
          LDA $8B87,Y
          STA $0204
          LDA #$EC
          STA $0205
          LDA #$20
          STA $0206
          LDA $33
L8B1B     STA $0207
L8B1E     LDX $34
          LDY $35
          LDA $16
          AND #$0F
          BEQ L8B64
          LSR A
          BCC L8B3D
          INY
          CPY #$15
          BNE L8B3B
          INX
          CPX #$05
          BNE L8B37
          LDX #$00
L8B37     STX $34
          LDY #$00
L8B3B     STY $35
L8B3D     LSR A
          BCC L8B4E
          DEY
          BPL L8B4C
          DEX
          BPL L8B48
          LDX #$04
L8B48     STX $34
          LDY #$14
L8B4C     STY $35
L8B4E     LSR A
          BCC L8B5A
          INX
          CPX #$05
          BNE L8B58
          LDX #$00
L8B58     STX $34
L8B5A     LSR A
          BCC L8B64
          DEX
          BPL L8B62
          LDX #$04
L8B62     STX $34
L8B64     LDA $27
          AND #$08
          BEQ L8B80
          LDA $8B8B,X
          STA $0208
          LDA #$EC
          STA $0209
          LDA #$20
          STA $020A
          LDA $8B90,Y
L8B7D     STA $020B
L8B80     RTS
          JSR $21C0
          RTI
          AND ($C0,X)
          .BYTE $37    ;%00110111 '7'
          .BYTE $57    ;%01010111 'W'
          .BYTE $77    ;%01110111 'w'
          .BYTE $8F    ;%10001111
          .BYTE $A7    ;%10100111
          .BYTE $AF    ;%10101111
          .BYTE $B7    ;%10110111
          .BYTE $BF    ;%10111111
          .BYTE $C7    ;%11000111
          JSR $3028
          SEC
          RTI
          BVC L8BEF
          RTS
          PLA
          BVS L8B1B
          DEY
          BCC L8B36
          LDY #$B0
          CLV
          CPY #$C8
          BNE L8B7D
          JSR L883B
          LDX #$42
          LDY #$90
          JSR L8E39
          JSR L8D5E
          LDX #$8E
          LDY #$90
          JSR L8E39
          JSR L8CF2
          LDA #$00
          STA $37
          INC $1F
          JMP L8927
          JSR L6A1C
          LDX #$30
          LDY #$58
          JSR L8C95
          JSR L8DB1
          LDA $12
          AND #$10
          BEQ L8C41
          LDY $37
          CPY #$03
          BNE L8BE3
          LDY #$17
          STY $1F
          RTS
L8BE3     LDA #$80
          STA $C5A0,Y
          TYA
          PHA
          PHA
          ASL A
          TAY
          LDX $07A0
          LDA $8D49,Y
          JSR L8E5C
          LDA $8D4A,Y
          JSR L8C6A
          LDA $8D49,Y
          JSR L8E5C
          LDA $8D4A,Y
          SEC
          SBC #$20
          JSR L8C6A
          JSR L8E40
          PLA
          ASL A
          ASL A
          ASL A
          ASL A
          TAY
          LDX #$00
L8C16     LDA #$FF
          STA $C5A3,Y
          LDA #$00
          STA $C5E2,Y
          INY
          INX
          CPX #$10
          BNE L8C16
          PLA
          TAY
          LDA #$00
          STA $C5D9,Y
          STA $C612,Y
          TYA
          ASL A
          TAY
          LDA #$00
          STA $C5D3,Y
          STA $C5D4,Y
          STA $C5DC,Y
          STA $C5DD,Y
L8C41     LDA $12
          AND #$20
          BEQ L8C52
          LDX $37
          INX
          CPX #$04
          BNE L8C50
          LDX #$00
L8C50     STX $37
L8C52     LDY $37
          LDA $8B87,Y
          STA $0200
          LDA #$E8
          STA $0201
          LDA #$03
          STA $0202
          LDA #$40
          STA $0203
          RTS
L8C6A     JSR L8E5C
          LDA #$48
          JSR L8E5C
          LDA #$FF
          JMP L8E5C
L8C77     LDY #$00
L8C79     LDA $C5A0,Y
          AND #$01
          BNE L8C85
          INY
          CPY #$03
          BNE L8C79
L8C85     RTS
L8C86     LDY #$00
L8C88     LDA $C5A0,Y
          AND #$01
          BEQ L8C94
          INY
          CPY #$03
          BNE L8C88
L8C94     RTS
L8C95     STX $2D
          STY $2E
          LDX #$80
          STX $2F
L8C9D     LDY #$00
L8C9F     LDA $8CD7,Y
          CLC
          ADC $2D
          STA $0200,X
          INX
          INY
          LDA $8CD7,Y
          STA $0200,X
          INY
          INX
          LDA #$00
          STA $0200,X
          INX
          LDA $8CD7,Y
          CLC
          ADC $2E
          STA $0200,X
          INY
          INX
          CPY #$1B
          BNE L8C9F
          LDA $2D
          CLC
          ADC #$20
          STA $2D
          INC $2F
          LDA $2F
          CMP #$83
          BNE L8C9D
          RTS
          BRK
L8CD8     CMP #$00
          BRK
          DEX
L8CDC     PHP
          BRK
          .BYTE $CB    ;%11001011
          BPL L8CE9
          CMP $0800,Y
          .BYTE $DA    ;%11011010
          PHP
          PHP
          .BYTE $DB    ;%11011011
          BPL L8CFA
          SBC #$00
          BPL L8CD8
          PHP
          BPL L8CDC
          BPL L8CA0
          .BYTE $02    ;%00000010
          JSR $00A9
          TAY
          STA $2D
L8CFA     ASL A
          PHA
          TAX
          LDA $36
          BEQ L8D0D
          LDA $8D43,X
          STA $2E
          LDA $8D44,X
          STA $2F
          BNE L8D17
L8D0D     LDA $8D49,X
          STA $2E
          LDA $8D4A,X
          STA $2F
L8D17     LDA $2E
          STA $2006
          LDA $2F
          STA $2006
          JSR L8D4F
          PLA
          TAX
          LDA $2F
          SEC
          SBC #$20
          PHA
          LDA $2E
          SBC #$00
          STA $2006
          PLA
          STA $2006
          JSR L8D4F
          INC $2D
          LDA $2D
          CMP #$03
          BNE L8CFA
          RTS
          AND ($0A,X)
          AND ($8A,X)
          .BYTE $22    ;%00100010 '"'
          ASL A
          JSR $21F0
          BVS L8D6F
          BEQ L8CF2
          BRK
L8D51     LDA $C5A3,Y
          STA $2007
          INY
          INX
          CPX #$08
          BNE L8D51
          RTS
L8D5E     LDA $2002
          LDY #$00
          TYA
          STA $2D
          STA $2E
L8D68     ASL A
          TAX
          LDA $8DA7,X
          STA $2006
          LDA $8DA8,X
          STA $2006
L8D76     LDX #$00
L8D78     LDA $8FD9,Y
          STA $2007
          INY
          INX
          CPX #$05
          BNE L8D78
          INC $2D
          LDA $2D
          CMP #$04
          BEQ L8D93
          LDA #$FF
          STA $2007
          BNE L8D76
L8D93     LDA $8FD9,Y
          STA $2007
          INY
          LDA #$00
          STA $2D
          INC $2E
          LDA $2E
          CMP #$05
          BNE L8D68
          RTS
          .BYTE $22    ;%00100010 '"'
          LDY $22
          CPY $22
          CPX $23
          .BYTE $04    ;%00000100
          .BYTE $23    ;%00100011 '#'
          BIT $A5
          .BYTE $1F    ;%00011111
          CMP #$16
          BNE L8DBD
          LDY #$40
          STY $30
          BNE L8DC3
L8DBD     LDY #$70
          LDA #$00
          STA $30
L8DC3     STY $2F
          LDY #$00
          STY $2E
          LDX #$00
L8DCB     LDA $C5A0,Y
          AND #$01
          BEQ L8E13
          LDA $C612,Y
          STA $31
          LDY #$00
          STY $2D
L8DDB     LDY $2E
          LDA $8E33,Y
          LDY $30
          BEQ L8DE7
          CLC
          ADC #$08
L8DE7     LDY $2D
          CLC
          ADC $8E36,Y
          STA $0220,X
          INX
          LDA $31
          ASL A
          ASL A
          ADC $2D
          TAY
          LDA $8E1C,Y
          STA $0220,X
          INX
          LDA #$02
          STA $0220,X
          INX
          LDA $2F
          STA $0220,X
          INX
          INC $2D
          LDY $2D
          CPY #$03
          BNE L8DDB
L8E13     INC $2E
          LDY $2E
          CPY #$03
          BNE L8DCB
          RTS
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CPY #$D0
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          CMP ($D1,X)
          .BYTE $FF    ;%11111111
          .BYTE $C3    ;%11000011
          .BYTE $C2    ;%11000010
          .BYTE $D2    ;%11010010
          .BYTE $FF    ;%11111111
          CMP $C4
          .BYTE $D4    ;%11010100
          .BYTE $FF    ;%11111111
          .BYTE $C7    ;%11000111
          DEC $D6
          BMI L8E85
          BVS L8E37
L8E37     PHP
          BPL L8DC0
          BRK
          STY $01
          JMP L6B9F
L8E40     STX $07A0
          LDA #$00
          STA $07A1,X
          LDA #$01
          STA $1B
          RTS
          STA $32
          AND #$F0
          LSR A
          LSR A
          LSR A
          LSR A
          JSR L8E5C
          LDA $32
          AND #$0F
L8E5C     STA $07A1,X
          INX
          TXA
          CMP #$55
          BCC L8E6F
          LDX $07A0
L8E68     LDA #$00
          STA $07A1,X
          BEQ L8E68
L8E6F     RTS
L8E70     TYA
          PHA
          JSR L6B58
          TAY
          LDA $C5EB,Y
          STA $0B
          LDA $C5EA,Y
          STA $0A
          JSR L8EBB
          LDA $06
L8E85     STA $C5DD,X
          LDA $07
          STA $C5DC,X
          PLA
          TAY
          RTS
L8E90     TYA
          PHA
          JSR L6B58
          TAY
          LDA $C5ED,Y
          STA $0B
          LDA $C5EC,Y
          STA $0A
          JSR L8EBB
          LDA $06
          STA $C5D4,X
          LDA $07
          STA $C5D3,X
          LDA $C5E2,Y
          PHA
          TXA
          LSR A
          TAY
          PLA
          STA $C5D9,Y
          PLA
          TAY
          RTS
L8EBB     LDA #$FF
          STA $01
          STA $02
          STA $03
          SEC
L8EC4     LDA $0A
          SBC #$E8
          STA $0A
          LDA $0B
          SBC #$03
          STA $0B
          INC $03
          BCS L8EC4
          LDA $0A
          ADC #$E8
          STA $0A
          LDA $0B
          ADC #$03
          STA $0B
          LDA $0A
L8EE2     SEC
L8EE3     SBC #$64
          INC $02
          BCS L8EE3
          DEC $0B
          BPL L8EE2
          ADC #$64
          SEC
L8EF0     SBC #$0A
          INC $01
          BCS L8EF0
          ADC #$0A
          STA $06
          LDA $01
          JSR L6B58
          ORA $06
          STA $06
          LDA $03
          JSR L6B58
          ORA $02
          STA $07
          RTS
          .BYTE $3F    ;%00111111 '?'
          BRK
          JSR $2002
          .BYTE $1B    ;%00011011
          .BYTE $3A    ;%00111010 ':'
          .BYTE $02    ;%00000010
          JSR $0121
          .BYTE $02    ;%00000010
          BIT $2730
          .BYTE $02    ;%00000010
          ROL $31
          .BYTE $17    ;%00010111
          .BYTE $02    ;%00000010
          ASL $19,X
          .BYTE $27    ;%00100111 '''
          .BYTE $02    ;%00000010
          ASL $20,X
          .BYTE $27    ;%00100111 '''
          .BYTE $02    ;%00000010
          ASL $20,X
          ORA ($02),Y
          ORA ($20,X)
          AND ($00,X)
          JSR $0175
          .BYTE $5B    ;%01011011 '['
          JSR $1785
          .BYTE $6B    ;%01101011 'k'
          .BYTE $FF    ;%11111111
          .BYTE $3B    ;%00111011 ';'
          .BYTE $FF    ;%11111111
          .BYTE $57    ;%01010111 'W'
          .BYTE $FF    ;%11111111
          AND $FF,X
          EOR ($FF,X)
          AND $40FF,Y
          .BYTE $FF    ;%11111111
          AND $FF,X
          AND $38FF,X
          .BYTE $FF    ;%11111111
          .BYTE $2F    ;%00101111 '/'
          .BYTE $FF    ;%11111111
          .BYTE $6B    ;%01101011 'k'
          JSR $1CC2
          BVS L8FC6
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          .BYTE $17    ;%00010111
          ASL A
          ASL $0E,X
          .BYTE $72    ;%01110010 'r'
          .BYTE $72    ;%01110010 'r'
          ASL $0E17
          .BYTE $1B    ;%00011011
          BPL L8F8A
          .BYTE $72    ;%01110010 'r'
          ORA $220A
          .BYTE $72    ;%01110010 'r'
          ADC ($20),Y
          .BYTE $E2    ;%11100010
          .BYTE $D2    ;%11010010
          .BYTE $73    ;%01110011 's'
          JSR $D2FD
          .BYTE $73    ;%01110011 's'
          AND ($12,X)
          .BYTE $89    ;%10001001
          .BYTE $6B    ;%01101011 'k'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $6B    ;%01101011 'k'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $6B    ;%01101011 'k'
          AND ($18,X)
          .BYTE $89    ;%10001001
          .BYTE $6B    ;%01101011 'k'
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $6B    ;%01101011 'k'
L8F8A     .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $6B    ;%01101011 'k'
          .BYTE $22    ;%00100010 '"'
          STA $08
          .BYTE $42    ;%01000010 'B'
          JMP $FF31
          EOR ($30,X)
          CLI
          AND $22,X
          SBC $09
          .BYTE $14    ;%00010100
          .BYTE $12    ;%00010010
          ORA $15,X
          .BYTE $FF    ;%11111111
          ASL $18,X
          ORA $230E
          .BYTE $22    ;%00100010 '"'
          ORA ($80,X)
          .BYTE $23    ;%00100011 '#'
          .BYTE $23    ;%00100011 '#'
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $72    ;%01110010 'r'
          .BYTE $23    ;%00100011 '#'
          AND $8101,X
          .BYTE $23    ;%00100011 '#'
          CPY #$54
          BRK
          .BYTE $23    ;%00100011 '#'
          .BYTE $D4    ;%11010100
          .BYTE $12    ;%00010010
          .BYTE $04    ;%00000100
          ORA $00
          BRK
          BRK
          BRK
          BRK
          BRK
          .BYTE $04    ;%00000100
          ORA $00
          BRK
          BRK
          BRK
L8FC6     BRK
          BRK
          .BYTE $04    ;%00000100
          ORA $23
          INC $5A
          BRK
          BRK
          CMP $EE8F,Y
          .BYTE $8F    ;%10001111
          .BYTE $03    ;%00000011
          BCC L8FEE
          BCC L9005
          BCC L9008
          .BYTE $2F    ;%00101111 '/'
          BMI L900E
          .BYTE $32    ;%00110010 '2'
          .BYTE $47    ;%01000111 'G'
          PHA
          EOR #$4A
          .BYTE $4B    ;%01001011 'K'
          AND $26
          .BYTE $27    ;%00100111 '''
          PLP
          AND #$0A
          .BYTE $0B    ;%00001011
          .BYTE $0C    ;%00001100
          ORA $0F0E
L8FEE     .BYTE $33    ;%00110011 '3'
          .BYTE $34    ;%00110100 '4'
          AND $36,X
          .BYTE $37    ;%00110111 '7'
          JMP $4E4D
          .BYTE $4F    ;%01001111 'O'
          BVC L9023
          .BYTE $2B    ;%00101011 '+'
          BIT $2DFF
          BPL L9010
          .BYTE $12    ;%00010010
          .BYTE $13    ;%00010011
          .BYTE $14    ;%00010100
          ORA $38,X
          AND $3B3A,Y
          .BYTE $3C    ;%00111100 '<'
L9008     EOR ($FF),Y
          .BYTE $52    ;%01010010 'R'
          .BYTE $FF    ;%11111111
          .BYTE $53    ;%01010011 'S'
          .BYTE $5B    ;%01011011 '['
L900E     .BYTE $5C    ;%01011100 '\'
          .BYTE $63    ;%01100011 'c'
L9010     .BYTE $62    ;%01100010 'b'
          PLA
          ASL $17,X
          CLC
          ORA $1B1A,Y
          AND $3F3E,X
          RTI
          EOR ($54,X)
          EOR $56,X
          .BYTE $57    ;%01010111 'W'
          CLI
          BRK
L9023     ORA ($02,X)
          .BYTE $03    ;%00000011
          .BYTE $04    ;%00000100
          .BYTE $1C    ;%00011100
          ORA $1F1E,X
          JSR $4221
          .BYTE $43    ;%01000011 'C'
          .BYTE $44    ;%01000100 'D'
          EOR $46
          EOR $FFFF,Y
          BIT $5A
          ORA $06
          .BYTE $07    ;%00000111
          PHP
          ORA #$22
          .BYTE $23    ;%00100011 '#'
          ADC ($67,X)
          ADC #$66
          .BYTE $23    ;%00100011 '#'
          CPY #$60
          BRK
          .BYTE $23    ;%00100011 '#'
          CPX #$60
          BRK
          JSR $4780
          .BYTE $72    ;%01110010 'r'
          JSR $0D89
          .BYTE $42    ;%01000010 'B'
          .BYTE $FF    ;%11111111
          JMP $31FF
          .BYTE $FF    ;%11111111
          EOR ($FF,X)
          BMI L905A
          CLI
          .BYTE $FF    ;%11111111
          AND $20,X
          STA $7247,Y
          .BYTE $22    ;%00100010 '"'
          .BYTE $4B    ;%01001011 'K'
          PHP
          EOR ($30,X)
          CLI
          AND $FF,X
          .BYTE $32    ;%00110010 '2'
          EOR $2256,Y
          .BYTE $82    ;%10000010
          ORA ($70,X)
          .BYTE $22    ;%00100010 '"'
          .BYTE $83    ;%10000011
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $72    ;%01110010 'r'
          .BYTE $22    ;%00100010 '"'
          STA $7101,X
          .BYTE $22    ;%00100010 '"'
          LDX #$C5
          .BYTE $73    ;%01110011 's'
          .BYTE $22    ;%00100010 '"'
          LDA $73C5,X
          .BYTE $23    ;%00100011 '#'
          .BYTE $42    ;%01000010 'B'
          ORA ($80,X)
          .BYTE $23    ;%00100011 '#'
          .BYTE $43    ;%01000011 'C'
          .BYTE $5A    ;%01011010 'Z'
          .BYTE $72    ;%01110010 'r'
          .BYTE $23    ;%00100011 '#'
          EOR $8101,X
          BRK
          JSR $1287
          .BYTE $14    ;%00010100
          .BYTE $FF    ;%11111111
          .BYTE $12    ;%00010010
          .BYTE $FF    ;%11111111
          ORA $FF,X
          ORA $FF,X
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          .BYTE $FF    ;%11111111
          ASL $FF,X
          CLC
          .BYTE $FF    ;%11111111
          ORA $0EFF
          .BYTE $22    ;%00100010 '"'
          .BYTE $4B    ;%01001011 'K'
          .BYTE $04    ;%00000100
          .BYTE $14    ;%00010100
          .BYTE $12    ;%00010010
          ORA $15,X
          BRK
          ROR $00
L90AD     STA $0066,Y
          RTS
          JSR L8EDB
          EOR #$01
          TAY
          LDA #$00
          BEQ L90AD
          LDX #$B0
L90BD     LDA $0300,X
          BEQ L90CA
          LDA $030B,X
          BNE L90CA
          STA $0300,X
L90CA     JSR $A0E1
          BMI L90BD
          RTS
          LDA $0300,X
          CMP #$05
          BCC L90E1
          TYA
          EOR $030C,X
          LSR A
          BCS L90E1
          STA $0300,X
L90E1     RTS
          TYA
          CMP $074B,X
          BNE L90ED
          LDA #$FF
          STA $0748,X
L90ED     RTS
          LDA $B590
          STA $00
          LDA $B591
          STA $01
          LDY #$00
          LDA ($00),Y
          CMP $49
          BEQ $9114
          .END

;auto-generated symbols and labels
 L6800      $6800
 L6804      $6804
 L6822      $6822
 L6874      $6874
 L6951      $6951
 L6960      $6960
 L6966      $6966
 L6988      $6988
 L6999      $6999
 L7018      $7018
 L7019      $7019
 L7041      $7041
 L7043      $7043
 L7051      $7051
 L7058      $7058
 L7095      $7095
 L7102      $7102
 L7105      $7105
 L7118      $7118
 L7130      $7130
 L7133      $7133
 L7138      $7138
 L7142      $7142
 L7168      $7168
 L7343      $7343
 L7356      $7356
 L7409      $7409
 L7456      $7456
 L7478      $7478
 L7487      $7487
 L7495      $7495
 L7512      $7512
 L7526      $7526
 L7866      $7866
 L8035      $8035
 L8059      $8059
 L8073      $8073
 L8127      $8127
 L8183      $8183
 L8185      $8185
 L8214      $8214
 L8228      $8228
 L8249      $8249
 L8252      $8252
 L8253      $8253
 L8275      $8275
 L8282      $8282
 L8327      $8327
 L8365      $8365
 L8369      $8369
 L8381      $8381
 L8387      $8387
 L8397      $8397
 L8407      $8407
 L8419      $8419
 L8425      $8425
 L8435      $8435
 L8537      $8537
 L8662      $8662
 L8673      $8673
 L8680      $8680
 L8687      $8687
 L8695      $8695
 L8704      $8704
 L8706      $8706
 L8707      $8707
 L8722      $8722
 L8750      $8750
 L8887      $8887
 L8894      $8894
 L8899      $8899
 L8915      $8915
 L8927      $8927
 L8950      $8950
 L8952      $8952
 L8956      $8956
 L8963      $8963
 L8992      $8992
 L9005      $9005
 L9008      $9008
 L9010      $9010
 L9023      $9023
 L683A      $683A
 L684F      $684F
 L69DF      $69DF
 L6A1C      $6A1C
 L68A7      $68A7
 L6AE4      $6AE4
 L695F      $695F
 L688A      $688A
 L68B7      $68B7
 L68A8      $68A8
 L68CB      $68CB
 L68E5      $68E5
 L694E      $694E
 L6A45      $6A45
 L6B5D      $6B5D
 L6CF1      $6CF1
 L6A71      $6A71
 L6B1C      $6B1C
 L691E      $691E
 L693A      $693A
 L6A31      $6A31
 L868D      $868D
 L693D      $693D
 L696D      $696D
 L6AFA      $6AFA
 L86BE      $86BE
 L69E5      $69E5
 L69E7      $69E7
 L69E6      $69E6
 L69E8      $69E8
 L6A0E      $6A0E
 L6A28      $6A28
 L84D0      $84D0
 L6A3D      $6A3D
 L6A56      $6A56
 L6A5B      $6A5B
 L6A5A      $6A5A
 L85DB      $85DB
 L6B9F      $6B9F
 L6A78      $6A78
 L6ACA      $6ACA
 L6A83      $6A83
 L6A8E      $6A8E
 L6AB1      $6AB1
 L6AC7      $6AC7
 L6AC9      $6AC9
 L6AD5      $6AD5
 L6AF0      $6AF0
 L6AF6      $6AF6
 L6B34      $6B34
 L6B3F      $6B3F
 L6B76      $6B76
 L6BAB      $6BAB
 L6B90      $6B90
 L6B93      $6B93
 L6B2A      $6B2A
 L6B77      $6B77
 L6BB4      $6BB4
 L6B52      $6B52
 L6BFE      $6BFE
 L6BE1      $6BE1
 L6BD0      $6BD0
 L6C09      $6C09
 L6C10      $6C10
 L6C5B      $6C5B
 L6C65      $6C65
 L6C3A      $6C3A
 L6C3F      $6C3F
 L6C4E      $6C4E
 L6C24      $6C24
 L6C01      $6C01
 L6CB6      $6CB6
 L6C7E      $6C7E
 L6C8F      $6C8F
 L6C8B      $6C8B
 L6CA7      $6CA7
 L6CB3      $6CB3
 L6CCD      $6CCD
 L6CC8      $6CC8
 L6CDB      $6CDB
 L6CD6      $6CD6
 L6D57      $6D57
 L6D45      $6D45
 L6D37      $6D37
 L84EE      $84EE
 L6CD2      $6CD2
 L6A6A      $6A6A
 L6CE0      $6CE0
 L6DB2      $6DB2
 L6B35      $6B35
 L6C1D      $6C1D
 L6DDE      $6DDE
 L85A0      $85A0
 L6DF4      $6DF4
 L6E15      $6E15
 L6E12      $6E12
 L81A7      $81A7
 L6E34      $6E34
 L6E31      $6E31
 L826F      $826F
 L6E3C      $6E3C
 L85BB      $85BB
 L6E83      $6E83
 L6E7D      $6E7D
 L6E5E      $6E5E
 L6E80      $6E80
 L82D6      $82D6
 L834E      $834E
 L6E8E      $6E8E
 L6EE2      $6EE2
 L6EF1      $6EF1
 L6F25      $6F25
 L6F17      $6F17
 L6BBB      $6BBB
 L6F45      $6F45
 L6F42      $6F42
 L6F65      $6F65
 L6F62      $6F62
 L6F74      $6F74
 L6FB7      $6FB7
 L6F9E      $6F9E
 L6FD0      $6FD0
 L6FDE      $6FDE
 L70B0      $70B0
 L707E      $707E
 L70A9      $70A9
 L70A4      $70A4
 L70BA      $70BA
 L70C2      $70C2
 L70DE      $70DE
 L70E0      $70E0
 L70D9      $70D9
 L70E5      $70E5
 L70F1      $70F1
 L70F4      $70F4
 L70FC      $70FC
 L6B59      $6B59
 L712C      $712C
 L72E3      $72E3
 L732C      $732C
 L734B      $734B
 L737A      $737A
 L73A1      $73A1
 L73A9      $73A9
 L73CC      $73CC
 L73DC      $73DC
 L73DA      $73DA
 L73E9      $73E9
 L73F7      $73F7
 L741C      $741C
 L742E      $742E
 L743E      $743E
 L746A      $746A
 L74A7      $74A7
 L74BA      $74BA
 L74CC      $74CC
 L74DC      $74DC
 L74D9      $74D9
 L74EA      $74EA
 L74F7      $74F7
 L753A      $753A
 L754E      $754E
 L75A8      $75A8
 L75C9      $75C9
 L75AC      $75AC
 L75BD      $75BD
 L75FE      $75FE
 L6A6B      $6A6B
 L797A      $797A
 L76E6      $76E6
 L79EC      $79EC
 L79FC      $79FC
 L7A82      $7A82
 L7A84      $7A84
 L7A92      $7A92
 L7A94      $7A94
 L7AA0      $7AA0
 L7AA3      $7AA3
 L7AAA      $7AAA
 L7AE3      $7AE3
 L7AEC      $7AEC
 L7AEB      $7AEB
 L7AF5      $7AF5
 L7B33      $7B33
 L6B4B      $6B4B
 L7B1F      $7B1F
 L7B26      $7B26
 L7B25      $7B25
 L7B2F      $7B2F
 L7B87      $7B87
 L7EDF      $7EDF
 L7E37      $7E37
 L7F3B      $7F3B
 L6E6D      $6E6D
 L7FCD      $7FCD
 L7F7D      $7F7D
 L7FF3      $7FF3
 L7FFD      $7FFD
 L808F      $808F
 L81AE      $81AE
 L81B1      $81B1
 L81B9      $81B9
 L81F2      $81F2
 L81F1      $81F1
 L81EE      $81EE
 L6B53      $6B53
 L820D      $820D
 L823F      $823F
 L80E0      $80E0
 L830E      $830E
 L833B      $833B
 L834D      $834D
 L834A      $834A
 L835E      $835E
 L83CD      $83CD
 L83DA      $83DA
 L83BA      $83BA
 L83D9      $83D9
 L83EC      $83EC
 L83E0      $83E0
 L841D      $841D
 L847B      $847B
 L84EB      $84EB
 L84ED      $84ED
 L84DB      $84DB
 L84F0      $84F0
 L84C2      $84C2
 L85AD      $85AD
 L85CC      $85CC
 L85D0      $85D0
 L85E6      $85E6
 L85E7      $85E7
 L866C      $866C
 L866B      $866B
 L86BD      $86BD
 L869E      $869E
 L86B5      $86B5
 L86B0      $86B0
 L86DA      $86DA
 L86EE      $86EE
 L873A      $873A
 L872A      $872A
 L883B      $883B
 L887C      $887C
 L886F      $886F
 L8E39      $8E39
 L8CF2      $8CF2
 L8E70      $8E70
 L8E90      $8E90
 L892D      $892D
 L890D      $890D
 L88B0      $88B0
 L8C77      $8C77
 L896C      $896C
 L896A      $896A
 L8C79      $8C79
 L8C95      $8C95
 L8DB1      $8DB1
 L89A6      $89A6
 L89A8      $89A8
 L8D5E      $8D5E
 L8C86      $8C86
 L8A39      $8A39
 L8A2A      $8A2A
 L8A1B      $8A1B
 L8A17      $8A17
 L8A51      $8A51
 L8A48      $8A48
 L8A4F      $8A4F
 L8C88      $8C88
 L8A58      $8A58
 L8AE8      $8AE8
 L8AD5      $8AD5
 L8E5C      $8E5C
 L8A98      $8A98
 L8A9A      $8A9A
 L8E40      $8E40
 L8AAD      $8AAD
 L8AC5      $8AC5
 L8AD3      $8AD3
 L8AE6      $8AE6
 L8B80      $8B80
 L8B1E      $8B1E
 L8B64      $8B64
 L8B3D      $8B3D
 L8B3B      $8B3B
 L8B37      $8B37
 L8B4E      $8B4E
 L8B4C      $8B4C
 L8B48      $8B48
 L8B5A      $8B5A
 L8B58      $8B58
 L8B62      $8B62
 L8BEF      $8BEF
 L8B1B      $8B1B
 L8B36      $8B36
 L8B7D      $8B7D
 L8C41      $8C41
 L8BE3      $8BE3
 L8C6A      $8C6A
 L8C16      $8C16
 L8C52      $8C52
 L8C50      $8C50
 L8C85      $8C85
 L8C94      $8C94
 L8C9F      $8C9F
 L8C9D      $8C9D
 L8CE9      $8CE9
 L8CFA      $8CFA
 L8CD8      $8CD8
 L8CDC      $8CDC
 L8CA0      $8CA0
 L8D0D      $8D0D
 L8D17      $8D17
 L8D4F      $8D4F
 L8D6F      $8D6F
 L8D51      $8D51
 L8D78      $8D78
 L8D93      $8D93
 L8D76      $8D76
 L8D68      $8D68
 L8DBD      $8DBD
 L8DC3      $8DC3
 L8E13      $8E13
 L8DE7      $8DE7
 L8DDB      $8DDB
 L8DCB      $8DCB
 L8E85      $8E85
 L8E37      $8E37
 L8DC0      $8DC0
 L8E6F      $8E6F
 L8E68      $8E68
 L6B58      $6B58
 L8EBB      $8EBB
 L8EC4      $8EC4
 L8EE3      $8EE3
 L8EE2      $8EE2
 L8EF0      $8EF0
 L8FC6      $8FC6
 L8F8A      $8F8A
 L8FEE      $8FEE
 L900E      $900E
 L905A      $905A
 L8EDB      $8EDB
 L90AD      $90AD
 L90CA      $90CA
 L90BD      $90BD
 L90E1      $90E1
 L90ED      $90ED

