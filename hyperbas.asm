; da65 V2.15 - Git 8b68576
; Created:    2016-07-08 13:47:09
; Input file: hyperbas.rom
; Page:       1


        .setcpu "6502"

RES             := $0000
RESB            := $0002
L005E           := $005E
L0061           := $0061
L00BE           := $00BE
L0100           := $0100
L0145           := $0145
FLGTEL          := $020D
VNMI            := $02F4
VAPLIC          := $02FD
V2DRA           := $0321
L040C           := $040C
L0531           := $0531
L07BA           := $07BA
L07C0           := $07C0
L07EA           := $07EA
L07ED           := $07ED
L07F9           := $07F9
L0810           := $0810
L1000           := $1000
L1228           := $1228
L208A           := $208A
L244F           := $244F
L2710           := $2710
L4142           := $4142
L4145           := $4145
L414F           := $414F
L424F           := $424F
L434F           := $434F
L4546           := $4546
L4553           := $4553
L4645           := $4645
L474F           := $474F
L4843           := $4843
L4944           := $4944
L494C           := $494C
L4C20           := $4C20
L4E45           := $4E45
L5349           := $5349
L534F           := $534F
L5445           := $5445
L5542           := $5542
L554F           := $554F
L801C           := $801C
L8045           := $8045
L8053           := $8053
L8145           := $8145
L8380           := $8380
L8381           := $8381
L9C1D           := $9C1D
        jmp     START_HYPERBASIC

        nop
        nop
; $C005
ROUTINE3:
        ldx     #$00
        stx     $8C
        stx     $07FF
        stx     L07ED
        stx     L07EA
        ldx     #$80
        stx     $8D
        dex
        stx     $02A2
        lda     #$0D
        sta     $029F
        lda     #$60
        sta     $07EF
        sta     $07EC
        lda     #$00
        ldy     #$08
        sta     $07F3
        sty     $07F4
        ldy     #$98
        sta     $07FB
        sty     $07FC
        jsr     ROUTINE2
        lda     V2DRA
        and     #$07
        sta     VNMI
        sta     VAPLIC
        lda     #$68
        ldy     #$C0
        sta     VNMI+1
        sty     $02F6
        lda     #$8A
        ldy     #$FE
        sta     VAPLIC+1
        sty     $02FF
        lda     FLGTEL
        and     #$04
        beq     LC068
        jsr     LC4DE
        jsr     LF50B
LC068:  ldx     #$00
        ldy     #$00
        .byte   $2C
LC06D:  ldx     #$06
        lda     #$01
        sta     $9B
        lda     #$10
        sta     $07EB
        lda     #$6E
        brk
        .byte   $2D
        asl     $027E
        cmp     #$03
        beq     LC068
        sty     $8E
        sta     $8F
        lda     $8C
        ora     #$02
        sta     $8C
        jsr     LC4DE
        txa
        pha
        .byte   $24
LC093:  inx
        lda     $0590,x
        cmp     #$20
        beq     LC093
        txa
        clc
        adc     #$90
        sta     $0C
        lda     #$00
        adc     #$05
        sta     $0D
        ldy     #$00
LC0A9:  lda     ($0C),y
        beq     LC0B0
        iny
        bne     LC0A9
LC0B0:  bit     FLGTEL
        bmi     LC0CF
        jsr     LC49B
        lda     $0220
        pha
        lda     $0224
        pha
        ldx     #$02
        jsr     ROUTINE1
        pla
        tay
        pla
        tax
        jsr     LC3AB
        jsr     LC4A6
LC0CF:  pla
        bne     LC112
        lda     #$03
        sta     $02A8
        sta     $02A6
        ldy     #$00
        lda     ($0C),y
        beq     LC14B
        sec
        lda     $0C
        sbc     #$90
        tax
        jsr     LC49B
        jsr     LC4E7
        jsr     LC4A6
        bcs     LC14E
        tya
        tax
        jsr     LDA03
        ldx     #$00
        brk
        and     RES,x
        .byte   $33
        jsr     LC10F
LC0FF:  sec
        lda     $0220
        sbc     $0228
        cmp     #$02
        bcc     LC10C
        brk
        .byte   $25
LC10C:  jmp     LC068

LC10F:  jmp     (L005E)

LC112:  ldx     $8F
        cpx     #$0A
        beq     LC155
        cpx     #$0B
        beq     LC175
        ldy     #$00
        lda     ($0C),y
        beq     LC133
        sec
        lda     $0C
        sbc     #$90
        tax
        jsr     LC49B
        jsr     LC4E7
        jsr     LC4A6
        bcs     LC14E
LC133:  tya
        brk
        .byte   $2E
LC136:  clc
        adc     $07FD
        sta     $07FD
        tax
        tya
        adc     $07FE
        sta     $07FE
        jsr     LC3C2
        jsr     LC3DC
LC14B:  jmp     LC068

LC14E:  lda     #$0B
        brk
        bpl     LC19F
        .byte   $6F
        .byte   $C0
LC155:  brk
        .byte   $2F
        bcc     LC14B
        clc
        ldy     #$00
        lda     (RESB),y
        adc     RESB
        sta     RESB
        bcc     LC166
        inc     RESB+1
LC166:  lda     (RESB),y
        beq     LC172
        jsr     LC224
        ldy     #$80
        jmp     LC06D

LC172:  jmp     LC068

LC175:  brk
        .byte   $2F
        bcc     LC1B7
        ldy     #$01
        lda     ($5C),y
        cmp     RES
        bne     LC188
        iny
        lda     ($5C),y
        cmp     RES+1
        beq     LC1B7
LC188:  lda     $5C
        ldy     $5D
        sta     RESB
        sty     RESB+1
LC190:  ldy     #$00
        lda     (RESB),y
        tay
        tax
        iny
        lda     (RESB),y
        cmp     RES
        bne     LC1AB
        iny
        .byte   $B1
LC19F:  .byte   $02
        cmp     RES+1
        bne     LC1AB
        lda     #$0B
        brk
        bpl     LC1F5
        ror     a
        .byte   $C1
LC1AB:  txa
        clc
        adc     RESB
        sta     RESB
        bcc     LC190
        inc     RESB+1
        bcs     LC190
LC1B7:  lda     #$0B
        brk
        bpl     LC208
        pla
        .byte   $C0
LC1BE:  lda     L0061
        ldy     $62
        ldx     $C9
        cpx     #$00
        beq     LC1CC
        lda     $9E
        ldy     $9F
LC1CC:  jsr     LD0ED
        lda     $C0
        ldy     $C1
        sta     RESB
        sty     RESB+1
        lda     #$FE
        ldy     #$FF
        ldx     $C9
        cpx     #$00
        beq     LC1E5
        lda     L0061
        ldy     $62
LC1E5:  sec
        adc     #$00
        bcc     LC1EB
        iny
LC1EB:  jsr     LD0ED
        lda     #$02
        sta     $98
        rts

LC1F3:  .byte   $20
        .byte   $BE
LC1F5:  .byte   $C1
LC1F6:  jsr     LC224
        jsr     LF1C9
        ldy     #$00
        lda     (RESB),y
        beq     LC223
        lda     #$0A
        jsr     L07EA
        clc
LC208:  ldy     #$00
        lda     (RESB),y
        adc     RESB
        sta     RESB
        tax
        lda     RESB+1
        adc     #$00
        sta     RESB+1
        cmp     $C1
        bcc     LC1F6
        bne     LC223
        cpx     $C0
        bcc     LC1F6
        beq     LC1F6
LC223:  rts

LC224:  lda     #$0D
        jsr     LC362
        lda     #$7F
        jsr     LC362
        ldy     #$00
        lda     (RESB),y
        beq     LC223
        pha
        iny
        lda     (RESB),y
        pha
        iny
        lda     (RESB),y
        tay
        pla
        jsr     LD559
LC241:  lda     L0100,x
        beq     LC24C
        jsr     L07EA
        inx
        bne     LC241
LC24C:  ldy     #$04
        tax
        lda     (RESB),y
        cmp     #$08
        bcc     LC267
        cmp     #$12
        bcs     LC265
        cmp     #$0D
        bcc     LC265
        lda     $98
        cmp     #$02
        beq     LC265
        dec     $98
LC265:  ldx     $98
LC267:  jsr     LC360
        dex
        bpl     LC267
        pla
        sec
        sbc     #$04
        tax
        stx     $10
        ldy     #$04
LC276:  sty     $11
        lda     (RESB),y
        bmi     LC28E
        cmp     #$20
        bcc     LC28E
        jsr     LC358
LC283:  jsr     LC362
LC286:  ldy     $11
        iny
        dec     $10
        bne     LC276
        rts

LC28E:  sta     $96
        cmp     #$08
        bcc     LC29A
        cmp     #$0D
        bcs     LC29A
        inc     $98
LC29A:  cmp     #$B0
        bcc     LC2AA
        cmp     #$C0
        bcc     LC31C
        iny
        lda     (RESB),y
        sty     $11
        dec     $10
        .byte   $2C
LC2AA:  lda     #$00
        sta     $97
        lda     $96
        cmp     #$1D
        bcc     LC2BB
        cmp     #$20
        bcs     LC2BB
        jsr     LC360
LC2BB:  jsr     LCA8A
        jmp     LC2C7

LC2C1:  jmp     LC286

LC2C4:  jmp     LC283

LC2C7:  cmp     #$10
        bne     LC2D0
        lda     #$22
        jsr     LC362
LC2D0:  ldy     #$06
        lda     ($92),y
        sta     $13
        cmp     #$07
        beq     LC2E9
        iny
LC2DB:  lda     ($92),y
        sty     $12
        jsr     LC362
        ldy     $12
        iny
        .byte   $C4
LC2E6:  .byte   $13
        bne     LC2DB
LC2E9:  lda     $94
        cmp     #$01
        beq     LC2FF
        cmp     #$03
        bne     LC314
        lda     $96
        cmp     #$1D
        bcc     LC314
        cmp     #$20
        bcs     LC314
        bcc     LC310
LC2FF:  ldy     #$06
        lda     ($92),y
        tay
        lda     ($92),y
        cmp     #$80
        beq     LC2C1
        ldy     #$04
        lda     ($92),y
        beq     LC2C4
LC310:  lda     #$20
        bne     LC2C4
LC314:  cmp     #$10
        bne     LC2C1
        lda     #$22
        bne     LC2C4
LC31C:  cmp     #$B2
        bcc     LC32B
        cmp     #$B6
        bcs     LC32B
        pha
        jsr     LC360
        pla
        clc
        .byte   $24
LC32B:  sec
        php
        sec
        sbc     #$B0
        tax
        ldy     #$FF
LC333:  dex
        bmi     LC33E
LC336:  iny
        lda     LEB98,y
        bpl     LC336
        bmi     LC333
LC33E:  iny
        lda     LEB98,y
        php
        and     #$7F
        sty     $12
        .byte   $20
LC348:  .byte   $62
        .byte   $C3
        ldy     $12
        plp
        bpl     LC33E
        plp
        bcs     LC355
        jsr     LC360
LC355:  jmp     LC286

LC358:  sec
        sbc     #$20
        tay
        lda     LE468,y
        rts

LC360:  lda     #$20
LC362:  pha
        lda     $9B
        lsr     a
        bcc     LC36C
        pla
        brk
        .byte   $32
        rts

LC36C:  pla
        cmp     #$7F
        beq     LC377
        .byte   $2C
LC372:  lda     #$20
        jmp     L07EA

LC377:  lda     $9B
        cmp     #$40
        beq     LC383
        lda     $9B
        bne     LC372
        brk
        .byte   $33
LC383:  rts

; $C384
ROUTINE2:
        lda     #$00
        ldy     #$08
        sta     $5C
        sty     $5D
        lda     #$07
        sta     L005E
        sty     $5F
        lda     #$01
        sta     $07FD
        sty     $07FE
        lda     #$00
        ldy     #$07
LC39E:  sta     ($5C),y
        dey
LC3A2           := * + 1
        bpl     LC39E
        lda     #$D0
        sta     $0805
        jmp     LFDA5

LC3AB:  lda     #$1F
        brk
        bpl     LC348
        clc
        adc     #$40
        brk
        bpl     LC3E2
        ora     $5002
        ora     ($E8,x)
        txa
        clc
        adc     #$40
        brk
        bpl     LC422
LC3C2:  stx     $0C
        sta     $0D
        ldy     #$00
        clc
        lda     ($0C),y
        adc     $0F
        sta     ($0C),y
        tax
        iny
        lda     ($0C),y
        beq     LC3DB
        adc     $10
        sta     ($0C),y
        bne     LC3C2
LC3DB:  rts

LC3DC:  jsr     LCAE8
        lda     $5C
        .byte   $A4
LC3E2:  eor     $0C85,x
        sty     $0D
LC3E7:  ldy     #$00
        lda     ($0C),y
        beq     LC42C
        sec
        sbc     #$04
        sta     $0E
        ldy     #$03
LC3F4:  iny
        dec     $0E
        bmi     LC41D
        lda     ($0C),y
        cmp     #$C0
        bcc     LC3F4
        sta     $96
        iny
        dec     $0E
        cmp     #$D0
        bcc     LC3F4
        lda     ($0C),y
        sta     $97
        jsr     LCA8A
        tya
        pha
        ldy     #$03
        lda     ($92),y
        ora     #$80
        sta     ($92),y
        pla
        tay
        bpl     LC3F4
LC41D:  ldy     #$00
        clc
        lda     ($0C),y
LC422:  adc     $0C
        sta     $0C
        bcc     LC3E7
        inc     $0D
        bcs     LC3E7
LC42C:  ldx     $07FD
        lda     $07FE
LC432:  stx     $92
        sta     $93
LC436:  ldy     #$01
        lda     ($92),y
        beq     LC48D
        ldy     #$03
        lda     ($92),y
        bpl     LC450
        and     #$7F
        sta     ($92),y
        ldy     #$00
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        bne     LC432
LC450:  sec
        ldy     #$00
        lda     $92
        sta     $08
        sbc     ($92),y
        sta     $0F
        iny
        lda     $93
        sta     $09
        sbc     ($92),y
        sta     $10
        lda     ($92),y
        sta     $05
        dey
        lda     ($92),y
        sta     $04
        lda     L005E
        ldy     $5F
        sta     $06
        sty     $07
        brk
        clc
        lda     $92
        pha
        tax
        lda     $93
        pha
        jsr     LC3C2
        jsr     LCAE8
        pla
        sta     $93
        pla
        sta     $92
        jmp     LC436

LC48D:  clc
        lda     $92
        adc     #$06
        sta     L005E
        lda     $93
        adc     #$00
        sta     $5F
        rts

LC49B:  pha
        lda     RES
        sta     $AE
        lda     RES+1
        sta     $AF
        pla
        rts

LC4A6:  pha
        lda     $AE
        sta     RES
        lda     $AF
        sta     RES+1
        pla
        rts

LC4B1:  jsr     LC1BE
        sec
        lda     RESB
        sta     $08
        sbc     $C0
        sta     $0F
        lda     RESB+1
        sta     $09
        sbc     $C1
        sta     $10
        lda     $C0
        ldy     $C1
        sta     $04
        sty     $05
        lda     L005E
        ldy     $5F
        sta     $06
        sty     $07
        brk
        clc
        lda     $0F
        ldy     $10
        jmp     LC136

LC4DE:  lda     #$00
        sta     $8B
        sta     $C2
        sta     $67
        rts

LC4E7:  stx     $C4
        lsr     $B0
        ldy     #$05
        sty     $C2
        ldy     #$01
        sty     $C5
        lda     $0590,x
        bne     LC4FA
        clc
        rts

LC4FA:  ldx     $C4
        lda     $0590,x
        cmp     #$3F
        bne     LC50E
        txa
        sbc     #$04
        sta     $C4
        lda     #$E9
        ldy     #$E8
        bne     LC560
LC50E:  ldx     #$01
        jsr     LCA05
        bcc     LC55C
        ldx     $C4
LC517:  lda     $0590,x
        beq     LC54B
        cmp     #$3A
        beq     LC54B
        cmp     #$3D
        beq     LC527
        inx
        bne     LC517
LC527:  lda     #$AA
        jsr     LCA7A
        jsr     LC909
        ldx     #$07
        jsr     LC676
        bcs     LC5B1
        ldx     #$08
        jsr     LC676
        bcs     LC5B1
        ldx     #$02
        lda     $94
        cmp     #$08
        beq     LC54A
        cmp     #$0C
        beq     LC54A
        dex
LC54A:  .byte   $2C
LC54B:  ldx     #$0C
        jsr     LC676
        bcs     LC5B1
        jsr     LC688
        cmp     #$3A
        beq     LC576
        jmp     LC5DA

LC55C:  lda     $92
        ldy     $93
LC560:  jsr     LCE02
        lda     $92
        ldy     $93
        sta     $0C
        sty     $0D
        ldy     #$06
        lda     ($0C),y
        sta     $C6
        tay
        lda     ($0C),y
        cmp     #$80
LC576:  beq     LC5B5
        dec     $C6
LC57A:  inc     $C6
        ldy     $C6
        lda     ($0C),y
        tax
        and     #$E0
        cmp     #$C0
        beq     LC593
        asl     a
        bpl     LC59A
        txa
        and     #$3F
        jsr     LCA69
        jmp     LC5A2

LC593:  jsr     LC65E
        bcs     LC5B1
        bcc     LC5B5
LC59A:  jsr     LC676
        bcc     LC5A2
        jmp     LC633

LC5A2:  ldy     $C6
        lda     ($0C),y
        bmi     LC5B5
        and     #$20
        bne     LC57A
        ldx     #$09
        jsr     LC676
LC5B1:  bcs     LC5F4
        bcc     LC57A
LC5B5:  jsr     LC688
        cmp     #$3A
        bne     LC5C7
        jsr     LC686
        lda     #$20
        jsr     LCA69
        jmp     LC4FA

LC5C7:  ldy     #$04
        lda     ($0C),y
        cmp     #$AB
        bne     LC5DA
        jsr     LC90C
        sec
        ror     $B0
        jsr     LCCCC
        bcs     LC5FD
LC5DA:  jsr     LC688
        tax
        beq     LC603
        cmp     #$27
        beq     LC600
        ldx     #$00
        jsr     LC676
        bcc     LC5FD
        bit     $B0
        bpl     LC633
        ldx     #$13
        jsr     LC676
LC5F4:  bcs     LC633
        lsr     $B0
        jsr     LCCCC
        bcc     LC5DA
LC5FD:  jsr     LC909
LC600:  jmp     LC4FA

LC603:  jsr     LCAEE
        lda     #$00
        ldy     #$06
        sta     $0C
        sty     $0D
        lda     $0601
        ldx     $0602
        cpx     #$CC
        bne     LC61C
        cmp     #$C0
        beq     LC627
LC61C:  jsr     LDF9A
        bne     LC62A
        sec
        lda     $C2
        sbc     #$05
        .byte   $2C
LC627:  lda     #$00
        .byte   $2C
LC62A:  lda     $C2
        sta     $0600
        ldy     $C5
        clc
        rts

LC633:  bit     FLGTEL
        bmi     LC654
        lda     $0220
        pha
        lda     $0224
        pha
        ldx     #$00
        jsr     LD581
        ldy     $CA
        ldx     LC6CA,y
        jsr     LD581
        pla
        tay
        pla
        tax
        jsr     LC3AB
LC654:  clc
        lda     $C4
        adc     $8E
        tax
        sec
        ldy     #$80
        rts

LC65E:  inc     $C6
        iny
        clc
        lda     ($0C),y
        adc     $0C
        tax
        dey
        lda     ($0C),y
        and     #$1F
        adc     $0D
        pha
        txa
        pha
        jmp     LC688

LC674:  ldx     #$01
LC676:  txa
        and     #$1F
        sta     $CA
        asl     a
        tax
        lda     LC69D,x
        pha
        lda     LC69C,x
        pha
        .byte   $2C
LC686:  inc     $C4
LC688:  ldx     $C4
        lda     $0590,x
        cmp     #$20
        bne     LC695
        inc     $C4
        bcs     LC688
LC695:  cmp     #$00
        beq     LC69B
        cmp     #$3A
LC69B:  rts

LC69C:  .byte   $E5
LC69D:  dec     $EA
        dec     $0D
        .byte   $C7
        lsr     $3BC9,x
        .byte   $C7
        lsr     $C7
        .byte   $6B
        .byte   $C7
        tay
        .byte   $C7
        .byte   $BF
        .byte   $C7
        dec     $C7
        cmp     LD4C7
        .byte   $C7
        inc     $C7
        cpx     $14C7
        cmp     #$38
        cmp     #$8D
        cmp     #$A3
        cmp     #$AD
        cmp     #$B7
        cmp     #$C6
        cmp     #$BA
        .byte   $C7
        .byte   $02
        .byte   $C7
LC6CA:  ora     (RESB+1,x)
        .byte   $04
        brk
        .byte   $07
        .byte   $0C
        ora     $0F0E
        asl     a
        php
        ora     #$06
        ora     RES
        brk
        .byte   $02
        bpl     LC6F4
        .byte   $12
        ora     ($15),y
        brk
        brk
        .byte   $0B
        .byte   $02
        asl     $14,x
        cmp     #$3A
        jmp     LC7DD

LC6EB:  jsr     LCBC6
        bcs     LC76A
LC6F0:  ldx     #$03
        .byte   $20
        .byte   $05
LC6F4:  dex
        bcs     LC6FD
        jsr     LCE06
        jmp     LC6EB

LC6FD:  bit     $BA
        bmi     LC76A
        clc
        rts

        bne     LC70A
        lda     #$46
        jmp     LCA69

LC70A:  lda     #$02
        sta     $CA
LC70E:  jsr     LCBC6
        bcs     LC76A
LC713:  ldx     #$03
        jsr     LCA05
        bcs     LC730
        ldy     #$04
        lda     ($92),y
        cmp     #$15
        beq     LC72A
        cmp     #$17
        bcc     LC736
        cmp     #$20
        bcs     LC736
LC72A:  jsr     LCE06
        jmp     LC70E

LC730:  bit     $BA
        bpl     LC76A
        clc
        rts

LC736:  lda     #$1A
        sta     $CA
        sec
        rts

        jsr     LCBC6
        bcs     LC76A
        bit     $BA
        bpl     LC6F0
        bmi     LC713
        jsr     LC7F9
        bcs     LC76A
        ldx     $0106
        cpx     #$07
        beq     LC76A
        cmp     #$24
        bne     LC76A
LC757:  jsr     LCD8A
        inc     $0106
        cmp     #$28
        bne     LC767
        jsr     LC865
        jmp     LC78A

LC767:  jmp     LC85F

LC76A:  sec
        rts

        jsr     LC7F9
        bcs     LC76A
        ldx     $0106
        cpx     #$07
        beq     LC76A
LC778:  jsr     LC688
        cmp     #$28
        bne     LC785
        jsr     LC868
        jmp     LC78A

LC785:  jmp     LC862

        clc
        rts

LC78A:  ldx     #$0A
        jsr     LC676
        lda     $94
        pha
        jsr     LC674
        pla
        bcs     LC76A
        sta     $94
        ldx     #$0B
        jsr     LC676
        bcs     LC76A
        jsr     LC909
        lda     #$3D
        jmp     LCA69

        jsr     LC7F9
        bcs     LC76A
        ldx     $0106
        cpx     #$07
        beq     LC76A
        cmp     #$24
        beq     LC757
        bne     LC778
        cmp     #$27
        jmp     LC7DD

        ldx     #$2C
        cmp     #$3D
        jmp     LC7D9

        ldx     #$21
        cmp     #$2C
        jmp     LC7D9

        ldx     #$2D
        cmp     #$28
        jmp     LC7D9

        ldx     #$2E
        cmp     #$29
LC7D9:  bne     LC76A
        txa
        .byte   $2C
LC7DD:  bne     LC76A
        jsr     LCA69
        jsr     LC686
        clc
        rts

        jsr     LC7F7
        bcc     LC859
        rts

        jsr     LC7F7
        bcc     LC859
        jmp     LCCCC

LC7F5:  sec
        rts

LC7F7:  sec
        .byte   $24
LC7F9:  clc
        ror     RES
        sty     $94
        ldx     #$07
        stx     $C8
        jsr     LC9D3
        bcc     LC7F5
LC807:  ldx     #$03
        jsr     LCA05
        bcc     LC7F5
        jsr     LC688
        jsr     LCB45
        cmp     #$41
        bcc     LC7F5
        cmp     #$5B
        bcs     LC7F5
LC81C:  jsr     LCD8A
        jsr     LCB45
        pha
        jsr     LC9D3
        bcc     LC851
        ldx     #$03
        jsr     LCA05
        bcs     LC837
        cpx     #$16
        bne     LC851
        bit     RES
        bpl     LC851
LC837:  pla
        cmp     #$2D
        beq     LC81C
        cmp     #$2E
        beq     LC81C
        cmp     #$30
        bcc     LC852
        cmp     #$3A
        bcc     LC81C
        cmp     #$41
        bcc     LC852
        cmp     #$5B
        bcc     LC81C
        .byte   $24
LC851:  pla
LC852:  ldx     $C8
        stx     $0106
        clc
        rts

LC859:  lda     #$06
        .byte   $2C
LC85C:  lda     #$07
        .byte   $2C
LC85F:  lda     #$08
        .byte   $2C
LC862:  lda     #$09
        .byte   $2C
LC865:  lda     #$0C
        .byte   $2C
LC868:  lda     #$0D
LC86A:  sta     $94
        ldx     #$07
        ldy     #$01
        lda     $0106
        jsr     LC9EA
        bcc     LC8B0
        ldy     #$02
        lda     $94
        cmp     #$0C
        bcc     LC884
        cmp     #$0E
        bcc     LC898
LC884:  cmp     #$07
        beq     LC898
        iny
        cmp     #$08
        beq     LC898
        ldy     #$04
        cmp     #$06
        beq     LC898
        iny
        cmp     #$09
        bne     LC8A0
LC898:  lda     #$00
        jsr     LCD8C
        dey
        bne     LC898
LC8A0:  lda     $94
        ldy     #$00
        jsr     LCD96
        ldx     $0104
        lda     $0105
        jmp     LC8B8

LC8B0:  ldy     #$04
        lda     ($92),y
        tax
        iny
        lda     ($92),y
LC8B8:  pha
        txa
        jsr     LCA7A
        pla
        jsr     LCA7A
        ldy     #$02
        lda     ($92),y
        cmp     #$0B
        beq     LC913
        cmp     #$0C
        beq     LC906
        cmp     #$0D
        beq     LC906
        ldx     $C5
        ldy     $05FD,x
        cmp     #$07
        bne     LC8E4
        cpy     #$B5
        beq     LC909
        cpy     #$B4
        beq     LC909
        bne     LC90C
LC8E4:  cmp     #$06
        bne     LC906
LC8E8:  cpx     #$03
        beq     LC903
        tya
        beq     LC913
        cpy     #$B5
        beq     LC909
        cpy     #$B4
        beq     LC909
        cpy     #$A1
        beq     LC90C
        cpy     #$A2
        beq     LC90C
        cpy     #$AC
        beq     LC90C
LC903:  lda     #$08
        .byte   $2C
LC906:  lda     #$05
        .byte   $2C
LC909:  lda     #$03
        .byte   $2C
LC90C:  lda     #$02
        clc
        adc     $C2
        sta     $C2
LC913:  clc
        rts

        ldx     #$07
        stx     $C8
LC919:  ldx     $C4
        lda     $0590,x
        beq     LC92B
        ldx     $C8
        sta     L0100,x
        inc     $C8
        inc     $C4
        bne     LC919
LC92B:  lda     $C8
        sta     $0106
        cmp     #$07
        beq     LC913
        lda     #$0B
        jmp     LC86A

        jsr     LC688
        cmp     #$40
        bne     LC985
        lda     #$44
        jsr     LC97D
        jsr     LC674
        bcs     LC986
        jsr     LC688
        cmp     #$2C
        bne     LC987
        lda     #$42
        jsr     LC97D
        jsr     LC674
        bcs     LC986
        lda     #$43
        bne     LC96F
        cmp     #$5D
        bne     LC989
        lda     #$3F
        jsr     LC97D
        jsr     LC674
        bcs     LC986
        lda     #$40
LC96F:  jsr     LCA69
        jsr     LC688
        beq     LC985
        cmp     #$3B
        bne     LC987
        lda     #$23
LC97D:  jsr     LCA69
        jsr     LC686
        lda     #$00
LC985:  clc
LC986:  rts

LC987:  sec
        rts

LC989:  lda     #$26
        jmp     LCA69

        jsr     LCB50
        bcc     LC9D1
        inc     $C2
        cmp     #$B0
        beq     LC99D
        cmp     #$B1
LC99B:  bne     LC9D1
LC99D:  stx     $C4
        jsr     LCA7A
        clc
        rts

        jsr     LCB50
        bcc     LC9D1
        cmp     #$B2
        jmp     LC99B

        jsr     LCB50
        bcc     LC9D1
        cmp     #$B3
        jmp     LC99B

        jsr     LCB50
        bcc     LC9D1
        pha
        jsr     LC909
        pla
        cmp     #$B4
        jmp     LC99B

        jsr     LCB50
        bcc     LC9D1
        cmp     #$B5
        jmp     LC99B

LC9D1:  sec
        rts

LC9D3:  jsr     LCB50
        bcc     LC9D1
        cmp     #$B5
        beq     LC9E8
        cmp     #$B4
        beq     LC9E8
        cmp     #$B2
        beq     LC9E8
        cmp     #$B3
        bne     LC9D1
LC9E8:  clc
        rts

LC9EA:  pha
        stx     $BC
        sty     $BD
        jsr     LCA15
        pla
        bcs     LCA02
LC9F5:  ldy     #$06
        cmp     ($92),y
        beq     LCA03
        pha
        jsr     LCA35
        pla
        bcc     LC9F5
LCA02:  rts

LCA03:  clc
        rts

LCA05:  clc
        lda     #$90
        adc     $C4
        sta     $BC
        lda     #$05
        adc     #$00
        sta     $BD
        txa
        sta     $94
LCA15:  sec
        lda     $BC
        sbc     #$07
        sta     $BC
        bcs     LCA20
        dec     $BD
LCA20:  ldx     #$B9
        lda     #$DF
LCA24:  stx     $92
        sta     $93
        ldy     #$01
        lda     ($92),y
        beq     LCA67
        iny
        lda     ($92),y
        cmp     $94
        beq     LCA40
LCA35:  ldy     #$00
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        jmp     LCA24

LCA40:  ldy     #$06
        lda     ($92),y
        sec
        sbc     #$07
        sta     $95
LCA49:  iny
        lda     ($BC),y
        ldx     $94
        cpx     #$10
        bcs     LCA55
        jsr     LCB45
LCA55:  cmp     ($92),y
        bne     LCA35
        dec     $95
        bne     LCA49
        ldy     #$04
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        clc
        rts

LCA67:  sec
        rts

LCA69:  pha
        sec
        sbc     #$20
        tay
        lda     LE491,y
        sbc     LE490,y
        clc
        adc     $C2
        sta     $C2
        pla
LCA7A:  ldx     $C5
        sta     $0600,x
        pha
        lda     #$FF
        sta     $0601,x
        pla
        inc     $C5
        clc
        rts

LCA8A:  tya
        pha
        ldy     $96
        cpy     #$D0
        bcc     LCAAD
        tya
        sbc     #$D0
        sta     RES
        lda     $97
        ldx     #$05
LCA9B:  lsr     RES
        ror     a
        dex
        bne     LCA9B
        and     #$FE
        tay
        lda     ($CB),y
        tax
        iny
        lda     ($CB),y
        jmp     LCAB9

LCAAD:  ldx     #$B9
        lda     #$DF
        cpy     #$A0
        bcc     LCAB9
        ldx     #$9F
        lda     #$E8
LCAB9:  stx     $92
        sta     $93
        ldy     #$04
        lda     ($92),y
        cmp     $96
        bne     LCADD
        iny
        lda     ($92),y
        cmp     $97
        bne     LCADD
        ldy     #$03
        lda     ($92),y
        sta     $95
        tax
        dey
        lda     ($92),y
        sta     $94
        pla
        tay
        lda     $94
        rts

LCADD:  ldy     #$00
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        jmp     LCAB9

LCAE8:  lda     $8C
        and     #$BF
        sta     $8C
LCAEE:  lda     $07FB
        ldy     $07FC
        dey
        sta     $CB
        sty     $CC
        lda     #$D0
        ldy     #$00
        sta     $96
        sty     $97
        sty     RES
        ldx     $07FD
        lda     $07FE
LCB09:  stx     $92
        sta     $93
        ldy     #$01
        lda     ($92),y
        beq     LCB4F
LCB13:  ldy     #$05
        lda     ($92),y
        cmp     $97
        dey
        lda     ($92),y
        sbc     $96
        bcs     LCB2B
        ldy     #$00
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        jmp     LCB09

LCB2B:  ldy     RES
        lda     $92
        sta     ($CB),y
        iny
        lda     $93
        sta     ($CB),y
        iny
        sty     RES
        lda     #$3F
        adc     $97
        sta     $97
        bcc     LCB13
        inc     $96
        bcs     LCB13
LCB45:  cmp     #$61
        bcc     LCB4F
        cmp     #$7B
        bcs     LCB4F
        sbc     #$1F
LCB4F:  rts

LCB50:  ldy     #$00
        sty     $C7
        .byte   $24
LCB55:  iny
        ldx     $C4
        .byte   $2C
LCB59:  inx
        iny
        lda     $0590,x
        jsr     LCB45
        sec
        sbc     LEB98,y
        beq     LCB59
        cmp     #$80
        beq     LCB78
        inc     $C7
        .byte   $24
LCB6E:  iny
        lda     LEB98,y
        beq     LCB7E
        bpl     LCB6E
        bmi     LCB55
LCB78:  inx
        lda     $C7
        adc     #$AF
        sec
LCB7E:  rts

LCB7F:  ldx     $C4
        inx
        ldy     $C8
LCB84:  lda     $0590,x
        beq     LCB95
        cmp     #$22
        beq     LCB94
        sta     L0100,y
        iny
        inx
        bne     LCB84
LCB94:  inx
LCB95:  stx     $C4
        sty     $C8
        sty     $0106
        jsr     LC688
        lda     #$10
        jsr     LC86A
        lda     #$10
        jmp     LCD7D

LCBA9:  jsr     LCD8A
        beq     LCBBD
        sta     $0E
        jsr     LCD8A
        cmp     #$27
        bne     LCBC0
        jsr     LCD8A
        jmp     LCD67

LCBBD:  lda     #$1B
        .byte   $2C
LCBC0:  lda     #$15
        sta     $CA
LCBC4:  sec
        rts

LCBC6:  ldx     #$07
        stx     $C8
        ldx     #$00
        stx     $0E
        stx     $0F
        jsr     LC688
        cmp     #$28
        bne     LCBFD
        lda     $CA
        pha
        ldx     #$0A
        jsr     LC676
        pla
        pha
        tax
        jsr     LC676
        pla
        bcs     LCBC4
        pha
        ldx     #$0B
        jsr     LC676
        pla
        bcs     LCBC4
        sta     $CA
        rts

LCBF4:  jmp     LCCDC

LCBF7:  jmp     LCCAA

LCBFA:  jmp     LCB7F

LCBFD:  cmp     #$22
        beq     LCBFA
        cmp     #$27
        beq     LCBA9
        cmp     #$25
        beq     LCBF4
        cmp     #$23
        beq     LCBF4
        cmp     #$2E
        beq     LCBF4
        cmp     #$2D
        beq     LCBF4
        cmp     #$2B
        beq     LCBF4
        cmp     #$30
        bcc     LCC21
        cmp     #$3A
        bcc     LCBF4
LCC21:  ldx     #$02
        jsr     LCA05
        bcs     LCBF7
        jsr     LCE06
        ldy     #$03
        lda     ($92),y
        sta     $95
        cmp     #$02
        bcc     LCC97
        lda     $CA
        pha
        ldx     #$0A
        jsr     LC676
        bcs     LCC65
        lda     $95
        ldx     #$01
        cmp     #$04
        bcc     LCC48
        inx
LCC48:  pha
        jsr     LC676
        bcs     LCCC8
        pla
        pha
        cmp     #$06
        bcc     LCC8A
        lda     #$3B
        jsr     LCA69
        jsr     LC688
        cmp     #$2C
        beq     LCC68
LCC60:  lda     #$09
        sta     $CA
        pla
LCC65:  pla
        sec
        rts

LCC68:  jsr     LC686
        jsr     LC674
        bcs     LCCC8
        pla
        pha
        cmp     #$07
        bcc     LCC8A
        lda     #$3C
        jsr     LCA69
        jsr     LC688
        cmp     #$2C
        bne     LCC60
        jsr     LC686
        jsr     LC674
        bcs     LCCC8
LCC8A:  ldx     #$0B
        jsr     LC676
        bcs     LCCC8
        pla
        tax
        pla
        sta     $CA
        txa
LCC97:  ldx     #$11
        tay
        beq     LCCA6
        cmp     #$02
        beq     LCCA6
        cmp     #$05
        beq     LCCA6
        ldx     #$10
LCCA6:  txa
        jmp     LCD7D

LCCAA:  lda     $CA
        pha
        ldx     #$07
        jsr     LC676
        pla
        sta     $CA
        bcs     LCCCA
        lda     #$10
        ldx     $94
        cpx     #$08
        beq     LCCC5
        cpx     #$0C
        beq     LCCC5
        lda     #$11
LCCC5:  jmp     LCD7D

LCCC8:  pla
        pla
LCCCA:  sec
        rts

LCCCC:  lda     #$07
        sta     $C8
        jsr     LC688
        cmp     #$30
        bcc     LCCCA
        cmp     #$3A
        bcs     LCCCA
        .byte   $24
LCCDC:  sec
        php
        clc
        lda     $C4
        adc     #$90
        pha
        lda     #$00
        adc     #$05
        tay
        pla
        plp
        php
        bcs     LCCF7
        brk
        rol     $86
        .byte   $02
        sta     L0061
        sty     $62
        .byte   $2C
LCCF7:  brk
        adc     #$18
        lda     RESB
        adc     $C4
        sta     $C4
        txa
        bmi     LCD60
        ldy     #$00
LCD05:  lda     (RES),y
        cmp     #$20
        beq     LCD0E
        jsr     LCD8C
LCD0E:  iny
        cpy     RESB
        bne     LCD05
        lda     $C8
        sta     $0106
        plp
        bcs     LCD2A
        lda     L0061
        jsr     LCD8C
        lda     $62
        jsr     LCD8C
        jsr     LC85C
        clc
        rts

LCD2A:  brk
        stx     $F0
        asl     a
        lda     $65
        bmi     LCD38
        lda     $69
        ora     $6A
        beq     LCD55
LCD38:  lda     $65
        ora     #$7F
        and     L0061
        sta     L0061
        ldy     #$FB
LCD42:  lda     str_char,y
        jsr     LCD8C
        iny
        bne     LCD42
        lda     #$12
        jsr     LC86A
        lda     #$12
        jmp     LCD7D

LCD55:  lda     $6B
        sta     $0F
        lda     $6C
        sta     $0E
        jmp     LCD67

LCD60:  pla
        lda     #$18
        sta     $CA
        sec
        rts

LCD67:  ldx     $C8
        stx     $0106
        lda     $0E
        jsr     LCD8C
        lda     $0F
        jsr     LCD8C
        lda     #$11
        jsr     LC86A
        lda     #$11
LCD7D:  cmp     #$10
        beq     LCD85
        lsr     $BA
        clc
        rts

LCD85:  sec
        ror     $BA
        clc
        rts

LCD8A:  inc     $C4
LCD8C:  ldx     $C8
        sta     L0100,x
        inc     $C8
        jmp     LC688

LCD96:  sta     $0102
        sty     $0103
        sec
        lda     L005E
        sta     $06
        sbc     #$06
        sta     $10
        sta     $04
        lda     $5F
        sta     $07
        sbc     #$00
        sta     $11
        sta     $05
        ldy     #$04
        lda     ($10),y
        sta     $0104
        iny
        lda     ($10),y
        sta     $0105
        clc
        lda     $10
        adc     $C8
        sta     L0100
        sta     $08
        lda     $11
        adc     #$00
        sta     $0101
        sta     $09
        brk
        clc
        clc
        ldy     $C8
        iny
        lda     #$00
        sta     ($10),y
        iny
        iny
        iny
        iny
        lda     ($10),y
        adc     #$01
        sta     ($10),y
        dey
        lda     ($10),y
        adc     #$00
        sta     ($10),y
        clc
        lda     $C8
        adc     L005E
        sta     L005E
        bcc     LCDF7
        inc     $5F
LCDF7:  ldy     $C8
LCDF9:  lda     L0100,y
        sta     ($10),y
        dey
        bpl     LCDF9
LCE01:  rts

LCE02:  sta     $92
        sty     $93
LCE06:  ldy     #$04
        lda     ($92),y
        pha
        jsr     LCA7A
        cmp     #$C0
        bcc     LCE18
        iny
        lda     ($92),y
        jsr     LCA7A
LCE18:  ldy     #$06
        lda     ($92),y
        tay
        sec
        sbc     #$07
        clc
        adc     $C4
        sta     $C4
        jsr     LCE3B
        and     #$7F
        clc
        adc     $C2
        sta     $C2
        pla
        cmp     #$0E
        bcc     LCE01
        cmp     #$11
        bcs     LCE01
        jmp     LC90C

LCE3B:  ldy     #$06
        lda     ($92),y
        tay
        dey
LCE41:  iny
        lda     ($92),y
        bpl     LCE41
        iny
        and     #$E0
        cmp     #$C0
        bne     LCE4E
        iny
LCE4E:  lda     ($92),y
        rts

LCE51:  lda     $07B5
        ldy     $07B6
        sta     $07F7
        sty     $07F8
        rts

LCE5E:  jsr     LCE51
LCE61:  lda     #$00
        sta     $0E
        sta     $BF
        lda     $07F5
        ldy     $07F6
        sta     RES
        sty     RES+1
LCE71:  ldx     $07FD
        lda     $07FE
LCE77:  stx     $0C
        sta     $0D
        ldy     #$02
        lda     ($0C),y
        tax
        ldy     #$06
        lda     ($0C),y
        cpx     #$08
        beq     LCE8E
        cpx     #$0C
        bne     LCEBD
        adc     #$01
LCE8E:  clc
        adc     $0C
        sta     $12
        lda     $0D
        adc     #$00
        sta     $13
        cpx     #$08
        beq     LCEBA
LCE9D:  jsr     LCED9
        ldy     #$00
        clc
        lda     #$03
        adc     $12
        sta     $12
        bcc     LCEAD
        inc     $13
LCEAD:  cmp     ($0C),y
        bne     LCE9D
        lda     $13
        iny
        cmp     ($0C),y
        bne     LCE9D
        beq     LCEBD
LCEBA:  jsr     LCED9
LCEBD:  ldy     #$00
        lda     ($0C),y
        tax
        iny
        lda     ($0C),y
        bne     LCE77
        lda     $BF
        bne     LCE61
        ldx     $0E
        beq     LCF23
        ldy     RES+1
        lda     RES
        jsr     LCF62
        jmp     LCE71

LCED9:  ldy     #$00
        lda     ($12),y
        beq     LCF23
        sta     $0F
        iny
        lda     $BF
        beq     LCEFD
        lda     ($12),y
        cmp     RES
        bne     LCF23
        iny
        lda     ($12),y
        cmp     RES+1
        bne     LCF23
        lda     $BF
        sta     ($12),y
        dey
        lda     L00BE
        sta     ($12),y
        rts

LCEFD:  lda     ($12),y
        tax
        cmp     RES
        iny
        lda     ($12),y
        tay
        sbc     RES+1
        bcc     LCF23
        cpx     $07F7
        tya
        sbc     $07F8
        bcs     LCF23
        lda     $0F
        sta     $0E
        stx     RES
        sty     RES+1
        lda     $12
        ldy     $13
        sta     $10
        sty     $11
LCF23:  rts

LCF24:  pha
        eor     #$FF
        sec
        adc     $07F7
        tax
        lda     $07F8
        bcs     LCF33
        adc     #$FF
LCF33:  cpx     $07F5
        pha
        sbc     $07F6
        pla
        bcs     LCF43
        jsr     LCE5E
        pla
        bne     LCF24
LCF43:  stx     L00BE
        sta     $BF
        stx     $07F7
        sta     $07F8
        tay
        ror     $BA
        pla
        rts

LCF52:  jsr     LCF24
        sta     $60
        stx     L0061
        sty     $62
        rts

LCF5C:  lda     L0061
        ldy     $62
        ldx     $60
LCF62:  pha
        tya
        pha
        txa
        jsr     LCF52
        sta     RES
        pla
        tay
        pla
        tax
        lda     RES
        stx     RES
        sty     RES+1
        tay
        beq     LCF80
LCF78:  dey
        lda     (RES),y
        sta     (L00BE),y
        tya
        bne     LCF78
LCF80:  rts

LCF81:  ldy     #$03
        lda     ($0C),y
        tax
        ldy     #$06
        lda     ($0C),y
        tay
        txa
        beq     LCF98
        lda     #$0B
        sta     ($0C),y
        iny
        lda     #$00
        sta     ($0C),y
        dey
LCF98:  tya
        pha
        lda     ($0C),y
        tax
        iny
        lda     ($0C),y
        pha
        ldy     #$02
        lda     ($0C),y
        tay
        pla
        jsr     LD002
        clc
        pla
        adc     RES
        bcc     LCFB1
        inx
LCFB1:  clc
        adc     $0C
        sta     $08
        txa
        adc     $0D
        sta     $09
        sec
        ldy     #$00
        lda     $08
        sbc     ($0C),y
        sta     $0F
        iny
        lda     $09
        sbc     ($0C),y
        sta     $10
        ora     $0F
        beq     LD001
        lda     L005E
        ldy     $5F
        sta     $06
        sty     $07
        clc
        adc     $0F
        sta     L005E
        tya
        adc     $10
        sta     $5F
        ldy     #$00
        lda     ($0C),y
        sta     $04
        iny
        lda     ($0C),y
        sta     $05
        brk
        clc
        lda     $0C
        pha
        tax
        lda     $0D
        pha
        jsr     LC3C2
        pla
        sta     $0D
        pla
        sta     $0C
        jmp     LFDEA

LD001:  rts

LD002:  stx     RESB
        sta     RES+1
        sta     RESB+1
        txa
        asl     a
        rol     RES+1
        cpy     #$0C
        beq     LD013
        asl     a
        rol     RES+1
LD013:  clc
        adc     RESB
        pha
        lda     RES+1
        adc     RESB+1
        tax
        pla
        adc     #$02
        sta     RES
        pha
        bcc     LD025
        inx
LD025:  stx     RES+1
        pla
        rts

LD029:  ldx     #$18
        jmp     LD17E

LD02E:  jsr     LD1F7
        ldy     #$06
        lda     ($92),y
        tay
        lda     L0061
        cmp     ($92),y
        lda     $62
        iny
        sbc     ($92),y
        bcs     LD029
        ldy     #$02
        lda     ($92),y
        tay
        ldx     L0061
        lda     $62
        jsr     LD002
        clc
        ldy     #$06
        adc     ($92),y
        bcc     LD056
        inx
        clc
LD056:  adc     $92
        pha
        txa
        adc     $93
        tax
        pla
        rts

        pla
        sta     RES
        clc
        adc     #$03
        sta     RESB
        pla
        sta     RES+1
        adc     #$00
        sta     RESB+1
        ldx     $07A0
        ldy     #$01
        lda     (RES),y
        sta     $07A2,x
        iny
        lda     (RES),y
        sta     $07A3,x
        inx
        inx
        stx     $07A0
        jmp     (RESB)

        clc
        bit     $38
        ldx     $07A0
        lda     $07A1,x
        sta     $93
        lda     $07A0,x
        sta     $92
        dex
        dex
        stx     $07A0
        bcc     LD0B1
        jsr     LD02E
        sta     $C4
        stx     $C5
        lda     $92
        ldy     $93
        sta     $BC
        sty     $BD
        lda     #$FF
        sta     $C3
        rts

LD0B1:  jsr     LD02E
        sta     RES
        stx     RES+1
        ldy     #$02
        lda     ($92),y
        cmp     #$0C
        beq     LD0D4
        jsr     LD0DC
        lda     L0061
        sta     $65
        ora     #$80
        sta     L0061
        lda     #$00
        sta     $66
        lda     #$40
        sta     $BA
        rts

LD0D4:  jsr     LD0DF
        lda     #$80
        sta     $BA
        rts

LD0DC:  ldx     #$05
        .byte   $2C
LD0DF:  ldx     #$03
        ldy     #$00
LD0E3:  lda     (RES),y
        sta     $60,y
        iny
        dex
        bne     LD0E3
        rts

LD0ED:  sta     RES
        sty     RES+1
        lda     L07F9
        ldy     $07FA
        sta     L00BE
        sty     $BF
        lda     $5C
        ldy     $5D
        sty     $C1
LD101:  sta     $C0
        ldy     #$00
        lda     ($C0),y
        beq     LD136
        ldy     #$02
        lda     RES+1
        cmp     ($C0),y
        bcc     LD137
        bne     LD11C
        dey
        lda     RES
        cmp     ($C0),y
        bcc     LD137
        beq     LD137
LD11C:  clc
        ldy     #$03
        lda     ($C0),y
        adc     L00BE
        sta     L00BE
        bcc     LD12A
        inc     $BF
        clc
LD12A:  ldy     #$00
        lda     $C0
        adc     ($C0),y
        bcc     LD101
        inc     $C1
        bcs     LD101
LD136:  clc
LD137:  rts

LD138:  lda     $052F
        cmp     $052D
        lda     $0530
        sbc     $052E
        bcs     LD14E
        jmp     LF0FF

LD149:  bit     FLGTEL
        bvs     LD176
LD14E:  rts

LD14F:  bit     FLGTEL
        bpl     LD170
        rts

LD155:  bit     FLGTEL
        bmi     LD173
        rts

LD15B:  lda     FLGTEL
        lsr     a
        bcs     LD179
        rts

LD162:  ldy     $8B
        beq     LD14E
        dey
        beq     LD17C
        ldx     #$16
        dey
        beq     LD17E
        dex
        .byte   $2C
LD170:  ldx     #$00
        .byte   $2C
LD173:  ldx     #$01
        .byte   $2C
LD176:  ldx     #$02
        .byte   $2C
LD179:  ldx     #$0B
        .byte   $2C
LD17C:  ldx     #$14
LD17E:  stx     $07B7
        ldy     #$00
        sty     $8B
        iny
        lda     ($99),y
        sta     $07B8
        iny
        lda     ($99),y
        sta     $07B9
        cmp     #$FF
        beq     LD19B
        lda     $8C
        and     #$04
        bne     LD1CC
LD19B:  brk
        and     $20
        .byte   $7B
        cmp     $AC,x
        lda     LC807,y
        beq     LD1BD
        ldx     #$04
        jsr     ROUTINE1
        lda     #$00
        sta     $14
        lda     $07B8
        ldy     $07B9
        ldx     #$03
        brk
        and     #$A9
        and     #$00
        .byte   $10
LD1BD:  brk
        and     $AC
        .byte   $B7
        .byte   $07
        cpy     #$13
        beq     LD1CC
        ldx     #$FF
        txs
        jmp     LC068

LD1CC:  ldx     $07BE
        inx
        inx
        txs
        sec
        lda     $07BC
        sbc     #$02
        sta     L07C0
        lda     $07BD
        sbc     #$00
        sta     $07C1
        cpy     #$13
        beq     LD1EA
        jmp     (L07BA)

LD1EA:  lda     $C2
        pha
        lda     $0700
        pha
        jmp     LC068

LD1F4:  ldx     #$08
        .byte   $2C
LD1F7:  ldx     #$00
        lda     $BA
        beq     LD223
        lda     $60,x
        beq     LD227
        bpl     LD224
        cmp     #$91
        bcs     LD224
        lda     $65,x
        bmi     LD224
        lda     #$91
        sbc     $60,x
        tay
        beq     LD219
LD212:  lsr     L0061,x
        ror     $62,x
        dey
        bne     LD212
LD219:  sty     $BA
        lda     L0061,x
        ldy     $62,x
        sta     $62,x
        sty     L0061,x
LD223:  rts

LD224:  jmp     LF0FF

LD227:  sta     L0061,x
        sta     $62,x
        sta     $BA
        rts

LD22E:  jsr     LD1F7
        ldx     $62
        bne     LD224
        lda     L0061
        rts

LD238:  ldx     #$08
        .byte   $2C
LD23B:  ldx     #$00
        ldy     $BA
        bne     LD267
        sty     $66
        sty     $63,x
        sty     $64,x
        sty     $65,x
        ldy     #$40
        lda     L0061,x
        ora     $62,x
        beq     LD263
        lda     #$90
        sta     $60,x
        lda     $62,x
        bmi     LD219
LD259:  dec     $60,x
        asl     L0061,x
        rol     $62,x
        bpl     LD259
        bmi     LD219
LD263:  sta     $60,x
        sty     $BA
LD267:  rts

        clc
        pla
        sta     RES
        adc     #$02
        tay
        pla
        sta     RES+1
        adc     #$00
        pha
        tya
        pha
        ldy     #$02
        lda     (RES),y
        sta     $BD
        sta     $C5
        dey
        lda     (RES),y
        sta     $BC
        ldy     #$06
        adc     ($BC),y
        sta     $C4
        bcc     LD267
        inc     $C5
LD28E:  rts

LD28F:  ldy     #$03
        sty     RES
        lda     $BA
        sta     ($BC),y
        dey
        lda     ($BC),y
        cmp     #$08
        beq     LD2D7
        cmp     #$0C
        beq     LD2D7
        cmp     #$0D
        bne     LD2A9
        jsr     LD23B
LD2A9:  lda     $BA
        bmi     LD2D2
        beq     LD2C1
        jsr     LD2EB
        lda     #$05
        sta     RES
        lda     $65
        ora     #$7F
        and     L0061
        sta     L0061
LD2BE:  ldx     #$00
        .byte   $2C
LD2C1:  ldx     #$01
        ldy     #$00
LD2C5:  lda     $60,x
        sta     ($C4),y
        iny
        inx
        cpx     RES
        bne     LD2C5
        jmp     LD51E

LD2D2:  ldx     #$11
        jmp     LD17E

LD2D7:  lda     $BA
        bpl     LD2D2
        jsr     LD2BE
        lda     $07F8
        sbc     $07F6
        cmp     #$02
        bcs     LD28E
        jmp     LCE5E

LD2EB:  lda     $60
        beq     LD30D
        asl     $66
        bcc     LD30D
        inc     $64
        bne     LD30D
        inc     $63
        bne     LD30D
        inc     $62
        bne     LD30D
        inc     L0061
        bne     LD30D
        inc     $60
        ror     L0061
        ror     $62
        ror     $63
        ror     $64
LD30D:  rts

LD30E:  lda     #$80
        .byte   $2C
LD311:  lda     #$40
        .byte   $2C
LD314:  lda     #$00
        sta     RES+1
        pla
        tax
        pla
        tay
        pla
        sta     $8E
        pla
        sta     $8F
        pla
        sta     RES
        pla
        sta     $6D
        pla
        sta     $68
        pla
        sta     $69
        pla
        sta     $6A
        pla
        sta     $6B
        pla
        sta     $6C
        lda     $8F
        pha
        lda     $8E
        pha
        tya
        pha
        txa
        pha
        lda     RES+1
        beq     LD35E
        bmi     LD35D
        jsr     LD23B
        lda     RES
        sta     $BA
        jsr     LD238
        lda     #$00
        sta     $66
        lda     $65
        eor     $6D
        sta     $6E
        lda     $60
LD35D:  rts

LD35E:  jsr     LD1F7
        lda     RES
        sta     $BA
        jmp     LD1F4

        jsr     LD40A
        pla
        pla
        clc
        txa
        adc     #$02
        tax
        tya
        adc     #$00
        pha
        txa
        pha
        ldy     #$00
        sty     $66
        iny
        lda     (RESB),y
        sta     $92
        iny
        lda     (RESB),y
        sta     $93
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        pha
        ldy     #$06
        lda     ($92),y
        tay
        pla
        cpx     #$10
        beq     LD39B
        cpx     #$06
        bne     LD3AC
LD39B:  tya
        sbc     #$07
        sta     $60
        lda     $92
        adc     #$06
        sta     L0061
        lda     $93
        adc     #$00
        bcc     LD3DE
LD3AC:  cpx     #$11
        beq     LD3BC
        cpx     #$07
        beq     LD3BC
        cpx     #$09
        bne     LD3CE
        cmp     #$00
        bne     LD3E9
LD3BC:  lda     ($92),y
        sta     L0061
        iny
        ora     ($92),y
        sta     $60
        lda     ($92),y
        sta     $62
        lda     #$00
        sta     $BA
        rts

LD3CE:  cpx     #$08
        bne     LD3E5
        lda     ($92),y
        sta     $60
        iny
        lda     ($92),y
        sta     L0061
        iny
        lda     ($92),y
LD3DE:  sta     $62
        lda     #$80
        sta     $BA
        rts

LD3E5:  cpx     #$12
        bne     LD409
LD3E9:  lda     ($92),y
        sta     $60
        iny
        lda     ($92),y
        sta     $65
        ora     #$80
        sta     L0061
        iny
        lda     ($92),y
        sta     $62
        iny
        lda     ($92),y
        sta     $63
        iny
        lda     ($92),y
        sta     $64
        lda     #$40
        sta     $BA
LD409:  rts

LD40A:  pla
        clc
        adc     #$01
        sta     RES
        pla
        adc     #$00
        sta     RES+1
        pla
        tax
        pla
        tay
        inc     $C3
        beq     LD43B
        bit     $BA
        bmi     LD426
        bvc     LD426
        jsr     LD2EB
LD426:  lda     $64
        pha
        lda     $63
        pha
        lda     $62
        pha
        lda     L0061
        pha
        lda     $60
        pha
        lda     $65
        pha
        lda     $BA
        pha
LD43B:  tya
        pha
        txa
        pha
        stx     RESB
        sty     RESB+1
        jmp     (RES)

LD446:  ldx     #$0C
        .byte   $2C
LD449:  ldx     #$06
        .byte   $2C
LD44C:  ldx     #$00
        .byte   $2C
LD44F:  ldx     #$C3
LD451:  jsr     LD486
        beq     LD4CB
        jmp     LD17C

LD459:  cpx     #$C3
        beq     LD484
        lda     $9C,x
        beq     LD4C7
        lda     $9D,x
        beq     LD4A5
        lda     $9E,x
        bpl     LD49D
        and     #$7F
        sta     $9E,x
        jsr     LD486
        clc
        eor     #$FF
        adc     #$01
        pha
        tya
        eor     #$FF
        adc     #$00
        tay
        pla
        rts

LD47E:  ldx     #$06
        .byte   $2C
LD481:  ldx     #$00
        .byte   $2C
LD484:  ldx     #$C3
LD486:  cpx     #$C3
        bne     LD48F
        lda     $BA
        jmp     LD491

LD48F:  lda     $9C,x
LD491:  beq     LD4C7
        cpx     #$C3
        bne     LD49D
        lda     $65
        bmi     LD4CC
        bpl     LD4A5
LD49D:  lda     $9E,x
        bmi     LD4CC
        ora     #$80
        sta     $9E,x
LD4A5:  lda     $9D,x
        beq     LD4CF
        bpl     LD4CC
        cmp     #$91
        bcs     LD4CC
        lda     #$91
        sbc     $9D,x
        tay
LD4B4:  dey
        bmi     LD4BE
        lsr     $9E,x
        ror     $9F,x
        jmp     LD4B4

LD4BE:  lda     $9F,x
        ldy     $9E,x
        sta     $9E,x
        sty     $9F,x
        rts

LD4C7:  lda     $9E,x
        ldy     $9F,x
LD4CB:  rts

LD4CC:  jmp     LF0FF

LD4CF:  lda     #$00
        tay
        sta     $9E,x
        sty     $9F,x
        rts

LD4D7:  ldx     $C9
        lda     $BA
        sta     $9C,x
        cmp     #$40
        bne     LD4E8
        lda     $65
        ora     #$7F
        and     L0061
        .byte   $2C
LD4E8:  lda     L0061
        sta     $9E,x
        lda     $60
        sta     $9D,x
        lda     $62
        sta     $9F,x
        lda     $63
        sta     $A0,x
        lda     $64
        sta     $A1,x
        ldy     #$FF
        sty     $C3
        txa
        clc
        adc     #$06
        sta     $C9
        rts

        tsx
        clc
        pla
        sta     $99
        sta     $07BC
        adc     #$02
        pha
        ldy     $0102,x
        sty     $9A
        bcc     LD528
        inc     $0102,x
        bcs     LD528
LD51E:  tsx
        lda     $0101,x
        ldy     $0102,x
        sta     $07BC
LD528:  sty     $07BD
        stx     $07BE
        ldx     $027E
        bne     LD573
        stx     $C9
        stx     $07A0
        lda     #$05
        sta     $02A8
        dex
        stx     $C3
        bit     $8C
        bmi     LD545
        rts

LD545:  ldy     #$01
        lda     ($99),y
        pha
        iny
        lda     ($99),y
        tay
        pla
        jsr     LD559
        brk
        .byte   $17
        lda     #$20
        brk
        .byte   $13
        rts

LD559:  ldx     #$00
        stx     $11
        ldx     #$01
        stx     $12
        ldx     #$20
        stx     $14
        ldx     #$03
        brk
        plp
        ldx     #$00
        stx     $0105
        lda     #$00
        ldy     #$01
        rts

LD573:  asl     $027E
        ldx     #$13
        jmp     LD17E

LD57B:  lda     #$96
        ldy     #$D6
        bne     LD591
LD581:  lda     #$70
        ldy     #$D7
        bne     LD591
; $D587
ROUTINE1:
        lda     #$30
        ldy     #$D8
        bne     LD591
LD58D:  lda     #$D6
        ldy     #$D7
LD591:  sta     RESB
        sty     RESB+1
        ldy     #$00
LD597:  dex
        bmi     LD5A6
LD59A:  inc     RESB
        bne     LD5A0
        inc     RESB+1
LD5A0:  lda     (RESB),y
        bpl     LD59A
        bmi     LD597
LD5A6:  iny
        lda     (RESB),y
        php
        and     #$7F
        cmp     #$20
        bcs     LD5D1
        tax
        cmp     #$1C
        bcs     LD5CE
        lda     RESB+1
        pha
        lda     RESB
        pha
LD5BB:  tya
        pha
        lda     #$DF
        ldy     #$D5
        jsr     LD591
        pla
        tay
        pla
        sta     RESB
        pla
        sta     RESB+1
        bne     LD5D3
LD5CE:  lda     LD5BB,x
LD5D1:  brk
LD5D3           := * + 1
        bpl     LD5FC
        bpl     LD5A6
        rts

        asl     a
        ora     $181F
LD5DB:  lda     #$20
        brk
        bpl     LD640
        .byte   $3F
        .byte   $20
; X
str_junk:
        .byte   "mode"
        .byte   $A0
        .byte   "fichier"
        .byte   $A0
        .byte   "disquette"

        .byte   $A0
        .byte   "mau"
LD5FC:  .byte   "vais"
        .byte   $A0
        .byte   "typ"
        .byte   $E5
        .byte   "STRATSE"
        .byte   $C4
        .byte   " de"
        .byte   $A0
        .byte   " non"
        .byte   $A0
        .byte   " incorrec"

        .byte   $F4
        .byte   " trop"
        .byte   $A0
        .byte   "parametr"
        .byte   $E5
        .byte   "NEX"
        .byte   $D4
        .byte   "gran"
        .byte   $E4
        .byte   "GOSU"
        .byte   $C2
        .byte   " sa"
LD640:  .byte   "ns"
        .byte   $A0
        .byte   "expression"

        .byte   $A0
        .byte   "variable"
        .byte   $A0
        .byte   " ou"
        .byte   $A0
        .byte   "lign"
        .byte   $E5
        .byte   "labe"
        .byte   $EC
        .byte   "nombr"
        .byte   $E5
        .byte   "alph"
        .byte   $E1
        .byte   "numeriqu"
        .byte   $E5
        .byte   "chain"
        .byte   $E5
        .byte   "COUN"
        .byte   $D4,$22
        .byte   " "
        .byte   $BF
        .byte   "absen"
        .byte   $F4
        .byte   "Liste des"

        .byte   $A0,$00
        .byte   "TEX"
        .byte   $D4,$00
        .byte   "HIRE"
        .byte   $D3,$00
        .byte   "minite"
        .byte   $EC,$B3,$01,$9A
        .byte   "erreur d'E/"

        .byte   $D3,$01
        .byte   "existan"
        .byte   $F4,$02
        .byte   "sature"
        .byte   $E5,$02
        .byte   "protege"
        .byte   $E5,$03,$04,$06,$81,$02,$07,$85
        .byte   "pas"
        .byte   $06,$85
        .byte   "nom"
        .byte   $06,$01
        .byte   "incorrec"
        .byte   $F4
        .byte   "lecteur "
        .byte   $9A,$01
        .byte   "ouver"
        .byte   $F4,$01
        .byte   "ferm"
        .byte   $E5
        .byte   "fin"
        .byte   $06,$81,$03,$04
        .byte   " d'"
        .byte   $8F
        .byte   "valeur"
        .byte   $08,$E5
        .byte   "execution arrete"

        .byte   $E5,$14,$09,$8C
        .byte   "division par "

        .byte   $B0
        .byte   "LOG"
        .byte   $11
        .byte   "LN"
        .byte   $11
        .byte   "SQR"
        .byte   $11
        .byte   "^ : "
        .byte   $0A
        .byte   " <= "
        .byte   $B0,$03,$8B
        .byte   "index"
        .byte   $06
        .byte   "tableau"
        .byte   $09,$8C
        .byte   "RETURN"
        .byte   $0E,$8D,$17,$09
        .byte   "longu"
        .byte   $E5,$09,$06,$8D,$1E
        .byte   "@AAttention:"

        .byte   $A0
        .byte   "plus"
        .byte   $06,$8A
        .byte   "SET"
        .byte   $11
        .byte   "OF"
        .byte   $C6,$0F,$96,$0F,$15,$96
        .byte   "No"
        .byte   $06,$12,$11,$93,$93,$8F,$22
        .byte   "("
        .byte   $99,$22
        .byte   ")"
        .byte   $99,$22
        .byte   ","
        .byte   $99,$14,$09,$8C,$10,$15,$96,$10
        .byte   $96,$90,$22
        .byte   "="
        .byte   $99,$22
        .byte   "TO"
        .byte   $99,$22
        .byte   "THEN"
        .byte   $99,$22
        .byte   "ELSE"
        .byte   $99,$BF
        .byte   "caracter"
        .byte   $E5
        .byte   "2eme "
        .byte   $22
        .byte   "'"
        .byte   $99,$BF,$22
        .byte   "STEP"
        .byte   $99,$BF
        .byte   " "
        .byte   $12
        .byte   "/"
        .byte   $13,$A0
        .byte   "UN"
        .byte   $18,$0E,$98,$0B,$0E
        .byte   "FO"
        .byte   $D2,$80
        .byte   "UNTIL"
        .byte   $0E
        .byte   "REPEA"
        .byte   $DE
        .byte   " "
        .byte   $1A,$1D,$9C
        .byte   " "
        .byte   $13,$A0
        .byte   " defini plusieurs fois"


        .byte   $1D,$9C,$BF
        .byte   "PASSE I"
        .byte   $E1
        .byte   "-I"
        .byte   $E2
        .byte   "-I"
        .byte   $E3
        .byte   "-II"
        .byte   $1D,$9C
        .byte   "WEND"
        .byte   $0E
        .byte   "WHIL"
        .byte   $C5,$1D,$1C
        .byte   "essayez WORD,FUNCTION,ERRLIST !"



        .byte   $1D,$9C,$1D
; X
str_freebytes:
        .byte   "44 Ko libres"

        ora     $9C1C,x
        asl     $4140,x
        .byte   $9F
        jsr     L9C1D
        jsr     L1228
        .byte   $A0
; X
str_copyright:
        .byte   "HYPER BASIC V2.0b"


        .byte   $0D,$0A
        .byte   "(c) 1986 ORIC International"



        .byte   $0D,$0A,$00
LD8A0:  ldx     #$0A
        jsr     LDF6B
        lda     $07FD
        ldx     $07FE
LD8AB:  sta     $92
        stx     $93
        ldy     #$01
        lda     ($92),y
        beq     LD8D7
        iny
        lda     ($92),y
        cmp     #$06
        beq     LD8C4
        cmp     #$0C
        bcc     LD8C9
        cmp     #$0E
        bcs     LD8C9
LD8C4:  iny
        lda     #$03
        sta     ($92),y
LD8C9:  ldy     #$01
        lda     ($92),y
        tax
        dey
        lda     ($92),y
        jmp     LD8AB

LD8D4:  jmp     LD998

LD8D7:  ldx     #$0B
        jsr     LDF6B
        lda     $5C
        ldx     $5D
        stx     $0D
LD8E2:  sta     $0C
        ldy     #$00
        lda     ($0C),y
        beq     LD8D4
        ldy     #$04
        lda     ($0C),y
        beq     LD91C
        cmp     #$C0
        bne     LD95D
        iny
        lda     ($0C),y
        cmp     #$CC
        bne     LD95D
        ldy     #$09
        jsr     LD96C
        ldy     #$06
        lda     ($92),y
        tay
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        inx
        bne     LD911
        clc
        adc     #$01
LD911:  pha
        txa
        pha
        ldy     #$06
        jsr     LD96C
        jmp     LD94B

LD91C:  iny
        jsr     LD96C
        lda     $95
        cmp     #$03
        beq     LD942
        ldx     #$07
        jsr     LD58D
        ldy     #$06
        lda     ($92),y
        sta     RESB
        iny
        cpy     RESB
        beq     LD93D
        lda     ($92),y
        brk
        bpl     LD987
        and     ($D9),y
LD93D:  ldx     #$08
        jsr     LD58D
LD942:  ldy     #$02
        lda     ($0C),y
        pha
        dey
        lda     ($0C),y
        pha
LD94B:  ldy     #$03
        lda     #$00
        sta     ($92),y
        ldy     #$06
        lda     ($92),y
LD955:  tay
        pla
        sta     ($92),y
        iny
        pla
        sta     ($92),y
LD95D:  clc
        ldy     #$00
        lda     ($0C),y
        adc     $0C
        bcc     LD968
        inc     $0D
LD968:  jmp     LD8E2

LD96B:  rts

LD96C:  lda     ($0C),y
        sta     $96
        iny
        lda     ($0C),y
        sta     $97
        jmp     LCA8A

LD978:  ldx     #$01
        jsr     LD58D
        sec
        ldy     #$06
        lda     ($0C),y
        sbc     #$07
        tax
LD985:  iny
        .byte   $B1
LD987:  .byte   $0C
        brk
        bpl     LD955
        bne     LD985
        ldx     #$06
        bit     $04A2
        sec
        ror     $B5
        jmp     LD58D

LD998:  ldx     #$0C
        jsr     LDF6B
        ldx     $07FD
        lda     $07FE
LD9A3:  stx     $0C
        sta     $0D
        ldy     #$01
        lda     ($0C),y
        beq     LD96B
        iny
        lda     ($0C),y
        cmp     #$07
        beq     LD9D0
        cmp     #$06
        beq     LD9C9
        cmp     #$0C
        bcc     LD9F8
        cmp     #$0E
        bcs     LD9F8
        jsr     LCF81
        jsr     LCAEE
        jmp     LD9F8

LD9C9:  iny
        lda     ($0C),y
        cmp     #$03
        beq     LD9F8
LD9D0:  ldy     #$06
        lda     ($0C),y
        tay
        lda     ($0C),y
        pha
        iny
        lda     ($0C),y
        tay
        pla
        jsr     LD0ED
        bcs     LD9E8
        jsr     LD978
        jmp     LD9F8

LD9E8:  ldy     #$06
        lda     ($0C),y
        tay
        iny
        iny
        lda     L00BE
        sta     ($0C),y
        iny
        lda     $BF
        sta     ($0C),y
LD9F8:  ldy     #$00
        lda     ($0C),y
        tax
        iny
        lda     ($0C),y
        jmp     LD9A3

LDA03:  inx
        inx
        inx
        stx     $C3
        lsr     $B5
        ldy     #$00
        sty     L07F9
        sty     $07FA
        dey
        tya
        jsr     LD0ED
        clc
        lda     $07FB
        sbc     L00BE
        sta     L07F9
        sta     $07B5
        tax
        lda     $07FC
        sbc     $BF
        sbc     #$01
        sta     $07FA
        sta     $07B6
        jsr     LD8A0
        lda     #$00
        sta     $0700
        lda     #$FD
        ldy     #$05
LDA3D:  sta     $C0
        sty     $C1
        lda     L005E
        ldy     $5F
        sta     L00BE
        sty     $BF
        lda     #$FF
        sta     $99
        sta     $9A
        jsr     LDC07
        jsr     LDAB8
        lda     L00BE
        ldy     $BF
        sta     $07F5
        sty     $07F6
        bit     $8C
        bvs     LDAAE
        ldx     #$0D
        jsr     LDF6B
        jsr     LFDA5
        lda     L07F9
        ldy     $07FA
        sta     L00BE
        sty     $BF
        lda     #$00
        ldy     #$08
        sty     $C1
LDA7B:  sta     $C0
        ldy     #$00
        lda     ($C0),y
        beq     LDAAE
        sta     $C3
        iny
        lda     ($C0),y
        sta     $99
        iny
        lda     ($C0),y
        sta     $9A
        bit     $8D
        bmi     LDAA0
        lda     #$0D
        brk
        bpl     LDA3D
        sta     $9AA4,y
        jsr     LD559
        brk
        .byte   $14
LDAA0:  jsr     LDC07
        clc
        lda     $C3
        adc     $C0
        bcc     LDA7B
        inc     $C1
        bcs     LDA7B
LDAAE:  bit     $B5
        bmi     LDABD
        lda     $8C
        ora     #$40
        sta     $8C
LDAB8:  lda     #$60
        jmp     LDF5C

LDABD:  lda     L07F9
        ldy     $07FA
        sta     RES
        sty     RES+1
        ldy     #$00
        lda     #$60
        sta     (RES),y
LDACD:  rts

LDACE:  ldx     $C4
        cpx     $C3
        bcs     LDACD
        pha
        lda     #$20
        jmp     LDCD4

LDADA:  pla
        beq     LDACE
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        ldy     #$04
        lda     ($92),y
        cmp     #$08
        bcc     LDADA
        cmp     #$0D
        bcs     LDB25
        pha
        cmp     #$0B
        bne     LDB01
        lda     $B7
        jsr     LDF7B
        lda     $B6
        jsr     LDF7B
LDB01:  lda     $BF
        jsr     LDF7B
        lda     L00BE
        jsr     LDF7B
        pla
        cmp     #$08
        bne     LDB1F
        ldy     #$05
        lda     ($C0),y
        jsr     LDF7B
        iny
        lda     ($C0),y
        jsr     LDF7B
        lda     #$08
LDB1F:  jsr     LDF7B
        jmp     LDADA

LDB25:  cmp     #$12
        bcs     LDADA
        cmp     #$0E
        bne     LDB4E
        lda     #$09
        jsr     LDF90
        bcs     LDB46
LDB34:  jsr     LDF85
        jsr     LDF5C
        jsr     LDF85
        jsr     LDF5C
        jmp     LDADA

LDB43:  ldx     #$02
        .byte   $2C
LDB46:  ldx     #$05
        jsr     LDF72
        jmp     LDADA

LDB4E:  cmp     #$0F
        bne     LDB8E
        lda     #$0A
        jsr     LDF90
        bcs     LDB43
        jsr     LDF85
        pha
        jsr     LDF5C
        jsr     LDF85
        jsr     LDF5C
        tax
        sec
        pla
        sbc     #$02
        bcs     LDB6E
        dex
LDB6E:  sta     RES
        dec     $BF
        ldy     #$F4
        sta     (L00BE),y
        iny
        txa
        sta     (L00BE),y
        clc
        lda     RES
        adc     #$01
        ldy     #$F9
        sta     (L00BE),y
        txa
        adc     #$00
        iny
        sta     (L00BE),y
        inc     $BF
        jmp     LDADA

LDB8E:  cmp     #$10
        bne     LDBBF
        lda     #$0B
        jsr     LDF90
        bcs     LDBFC
        jsr     LDF85
        sta     RES
        jsr     LDF85
        sta     RES+1
        jsr     LDF85
        jsr     LDF5C
        jsr     LDF85
        jsr     LDF5C
        dec     RES+1
        ldy     #$FE
        lda     L00BE
        sta     (RES),y
        iny
        lda     $BF
        sta     (RES),y
        jmp     LDADA

LDBBF:  lda     #$08
        jsr     LDF90
        bcs     LDBF9
        jsr     LDF85
        sta     $97
        jsr     LDF85
        sta     $96
        ldy     $C4
        cpy     #$07
        bne     LDBE4
        dey
        lda     ($C0),y
        cmp     $97
        bne     LDBF9
        dey
        lda     ($C0),y
        cmp     $96
        bne     LDBF9
LDBE4:  jsr     LCA8A
        lda     $92
        jsr     LDF5C
        lda     $93
        jsr     LDF5C
        lda     #$4C
        jsr     LDF5C
        jmp     LDB34

LDBF9:  ldx     #$03
        .byte   $2C
LDBFC:  ldx     #$0E
        jsr     LDF72
        jmp     LDADA

LDC04:  jmp     LDADA

LDC07:  ldy     #$03
        sty     $C4
        clc
        lda     L00BE
        sta     $B6
        adc     ($C0),y
        sta     $B1
        lda     $BF
        sta     $B7
        adc     #$00
        sta     $B2
        lsr     $B0
        ldy     #$04
        lda     ($C0),y
        cmp     #$C0
        bne     LDC2E
        iny
        lda     ($C0),y
        cmp     #$CC
        bne     LDC2E
        rts

LDC2E:  lda     #$00
        pha
        ldy     #$04
        lda     ($C0),y
        jsr     LDF9A
        beq     LDC48
        ldx     #$07
        ldy     #$D5
        jsr     LDF52
        ldx     $99
        ldy     $9A
        jsr     LDF57
LDC48:  inc     $C4
        lda     $C4
        cmp     $C3
        bcs     LDC04
        ldy     $C4
        lda     ($C0),y
        cmp     #$20
        beq     LDC04
        tax
        bmi     LDC60
        bcs     LDC63
        jmp     LDDB6

LDC60:  jmp     LDCF0

LDC63:  cmp     #$50
        bcs     LDC60
        cmp     #$2D
        bne     LDC6F
        pha
LDC6C:  jmp     LDC48

LDC6F:  cmp     #$2E
        bne     LDC97
LDC73:  pla
        cmp     #$2D
        beq     LDC84
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        jmp     LDC73

LDC84:  pla
        pha
        cmp     #$02
        bne     LDC6C
        pla
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        jmp     LDC48

LDC97:  cmp     #$3D
        bne     LDCBA
        ldy     $C4
        iny
        lda     ($C0),y
        ldx     #$88
        ldy     #$D0
        cmp     #$2C
        beq     LDCB2
        cmp     #$2F
        beq     LDCB2
        dec     $C4
        ldx     #$86
        ldy     #$D0
LDCB2:  jsr     LDF52
        inc     $C4
        jmp     LDC48

LDCBA:  sta     $8F
LDCBC:  pla
        cmp     #$01
        beq     LDCD1
        cmp     #$2D
        beq     LDCD1
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        jmp     LDCBC

LDCD1:  pha
        lda     $8F
LDCD4:  sec
        sbc     #$20
        tax
        ldy     LE490,x
LDCDB:  tya
        cmp     LE491,x
        beq     LDCEA
        lda     LE411,y
        jsr     LDF5C
        iny
        bne     LDCDB
LDCEA:  jmp     LDC48

LDCED:  jmp     LDDB6

LDCF0:  cmp     #$C0
        bcs     LDCED
        cmp     #$B0
        bcc     LDCED
        beq     LDD01
        cmp     #$B1
        bne     LDD09
        lda     #$18
        .byte   $2C
LDD01:  lda     #$38
        jsr     LDF5C
        jmp     LDC48

LDD09:  cmp     #$B5
        bne     LDD28
LDD0D:  pla
        beq     LDD1C
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        jmp     LDD0D

LDD1C:  pha
        lda     L00BE
        ldy     $BF
        sta     $B3
        sty     $B4
        jmp     LDD51

LDD28:  cmp     #$B4
        bne     LDD96
LDD2C:  pla
        beq     LDD3B
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        jmp     LDD2C

LDD3B:  pha
        ldy     #$00
        clc
        lda     L00BE
        adc     #$03
        sta     ($B3),y
        iny
        lda     $BF
        adc     #$00
        sta     ($B3),y
        lda     #$4C
        jsr     LDF5C
LDD51:  lda     $B1
        jsr     LDF5C
        lda     $B2
        jsr     LDF5C
        ldy     $C4
        iny
        lda     ($C0),y
        cmp     #$D0
        bcc     LDD8C
        sta     $96
        iny
        lda     ($C0),y
        sta     $97
        jsr     LCA8A
        cmp     #$06
        beq     LDD79
        cmp     #$07
        beq     LDD84
LDD76:  jmp     LDC48

LDD79:  lda     #$EA
        jsr     LDF5C
        jsr     LDF5C
        jsr     LDF5C
LDD84:  lda     #$4C
        jsr     LDF5C
        jmp     LDDF6

LDD8C:  ldx     #$1E
        ldy     #$D5
        jsr     LDF52
        jmp     LDC48

LDD96:  cmp     #$B3
        bne     LDD76
LDD9A:  pla
        cmp     #$01
        beq     LDDAB
        pla
        sta     $92
        pla
        sta     $93
        jsr     LDF23
        jmp     LDD9A

LDDAB:  pha
        ldx     #$48
        ldy     #$E0
        jsr     LDF52
        jmp     LDC48

LDDB6:  sta     $96
        cmp     #$C0
        bcc     LDDC2
        iny
        inc     $C4
        lda     ($C0),y
        .byte   $2C
LDDC2:  lda     #$00
        sta     $97
        jsr     LCA8A
        cmp     #$01
        bne     LDE20
        tax
        lda     $96
        beq     LDE19
        cmp     #$A1
        beq     LDDE4
        cmp     #$A2
        beq     LDDE4
        cmp     #$AC
        beq     LDDE4
        jmp     LDF18

        jmp     LDF17

LDDE4:  jsr     LDF23
        ldy     $C4
        iny
        lda     ($C0),y
        sta     $96
        iny
        lda     ($C0),y
        sta     $97
        jsr     LCA8A
LDDF6:  ldy     #$03
        lda     ($92),y
        beq     LDE07
        lda     $92
        ldy     $93
        sta     $0C
        sty     $0D
        jsr     LD978
LDE07:  ldy     #$06
        lda     ($92),y
        tay
        iny
        iny
        lda     ($92),y
        jsr     LDF5C
        iny
        lda     ($92),y
        jsr     LDF5C
LDE19:  inc     $C4
        inc     $C4
        jmp     LDC48

LDE20:  cmp     #$06
        bne     LDE61
        cpx     #$03
        bne     LDE35
        jsr     LDF42
        ldx     #$42
        ldy     #$F5
        jsr     LDF52
        jmp     LDC48

LDE35:  ldx     #$CB
        ldy     #$E8
        jsr     LDF52
        lda     #$20
        jsr     LDF5C
        ldy     #$06
        lda     ($92),y
        tay
        iny
        iny
        lda     ($92),y
        jsr     LDF5C
        iny
        lda     ($92),y
        jsr     LDF5C
        lda     #$EA
        jsr     LDF5C
        jsr     LDF5C
LDE5B:  jmp     LDC48

LDE5E:  jmp     LDF06

LDE61:  cmp     #$0C
        beq     LDE9A
        cmp     #$0D
        beq     LDE9A
        cmp     #$10
        bcs     LDE9A
        cmp     #$07
        beq     LDE9A
        cmp     #$09
        beq     LDE79
        cmp     #$08
        bne     LDE5E
LDE79:  ldy     $C4
        dey
        dey
        lda     ($C0),y
        cmp     #$0D
        beq     LDE5B
        ldy     $C4
        iny
        lda     ($C0),y
        cmp     #$2F
        beq     LDE90
        cmp     #$2C
        bne     LDE9A
LDE90:  ldx     #$68
        ldy     #$D2
        jsr     LDF46
        jmp     LDC48

LDE9A:  clc
LDE9B:  ror     $91
LDE9D:  pla
        pha
        cmp     #$50
        bcc     LDED8
        tsx
        lda     $0104,x
        cmp     $0101,x
        bcc     LDED8
        lda     $92
        sta     RES
        lda     $93
        sta     RES+1
        pla
        sta     $0104,x
        lda     $0105,x
        sta     $92
        pla
        sta     $0105,x
        lda     $0106,x
        sta     $93
        pla
        sta     $0106,x
        jsr     LDF23
        lda     RES
        sta     $92
        lda     RES+1
        sta     $93
        jmp     LDE9D

LDED8:  bit     $91
        bmi     LDEF8
        ldy     #$02
        lda     ($92),y
        cmp     #$02
        bne     LDEEA
        jsr     LDF23
        jmp     LDC48

LDEEA:  cmp     #$0C
        beq     LDEFC
        cmp     #$0D
        beq     LDEFC
        jsr     LDF42
        jmp     LDC48

LDEF8:  ldx     #$02
        bne     LDF18
LDEFC:  ldx     #$5F
        ldy     #$D0
        jsr     LDF46
        jmp     LDC48

LDF06:  cmp     #$02
        bne     LDF10
        cpx     #$02
        bcs     LDE9B
        bcc     LDE9A
LDF10:  cmp     #$03
        beq     LDF18
        jmp     LDC48

LDF17:  tax
LDF18:  lda     $93
        pha
        lda     $92
        pha
        txa
        pha
        jmp     LDC48

LDF23:  jsr     LCE3B
        tax
        bpl     LDF36
        sec
        tya
        adc     $92
        tax
        lda     $93
        adc     #$00
        tay
        jmp     LDF52

LDF36:  dex
        bmi     LDF6A
        iny
        lda     ($92),y
        jsr     LDF5C
        jmp     LDF36

LDF42:  ldx     #$68
        ldy     #$D3
LDF46:  jsr     LDF52
        lda     $92
        jsr     LDF5C
        lda     $93
        bne     LDF5C
LDF52:  lda     #$20
        jsr     LDF5C
LDF57:  txa
        jsr     LDF5C
        tya
LDF5C:  stx     $8E
        ldx     #$00
        sta     (L00BE,x)
        inc     L00BE
        bne     LDF68
        inc     $BF
LDF68:  ldx     $8E
LDF6A:  rts

LDF6B:  bit     $8D
        bmi     LDF6A
        jmp     LD58D

LDF72:  jsr     LD5DB
        jsr     LD58D
        brk
        and     $60
LDF7B:  inc     $0700
        ldx     $0700
        sta     $0701,x
        rts

LDF85:  ldx     $0700
        lda     $0701,x
        dec     $0700
        clc
        rts

LDF90:  ldx     $0700
        cmp     $0701,x
        beq     LDF85
        sec
        rts

LDF9A:  cmp     #$00
        beq     LDFB8
        cmp     #$09
        beq     LDFB8
        cmp     #$0F
        beq     LDFB8
        cmp     #$10
        beq     LDFB8
        cmp     #$05
        beq     LDFB8
        cmp     #$A0
        beq     LDFB8
        cmp     #$A1
        beq     LDFB8
        cmp     #$A3
LDFB8:  rts

        .byte   $C3
        .byte   $DF
        ora     (RES,x)
        brk
        brk
        php
        eor     a:$8C,x
        .byte   $DF
        .byte   $DF
        ora     (RES,x)
        ora     (RES,x)
        ora     $4552
        .byte   $54
        eor     $52,x
        lsr     $0380
        jmp     LDFD5

LDFD5:  dec     $C2
        bmi     LDFDA
        rts

LDFDA:  ldx     #$19
        jmp     LD17E

        .byte   $EF
        .byte   $DF
        ora     (RES,x)
        .byte   $03
        brk
        asl     a
        eor     $4E
        .byte   $44
        .byte   $80
        .byte   $03
LDFEB:  jmp     LC068

        rts

        .byte   $FF
        .byte   $DF
        ora     (RES,x)
        .byte   $04
        brk
        .byte   $0B
        .byte   $53
        .byte   $54
        .byte   $4F
        bvc     LDF7B
        .byte   $03
LDFFC:  jsr     LD573
        ora     #$E0
        ora     (RES,x)
        ora     RES
        php
        .byte   $27
        stx     $6D00
        cpx     #$01
        ora     ($08,x)
        brk
        asl     a
        lsr     $4F
        .byte   $52
        rol     $28
        and     ($70,x)
        and     ($21),y
        cpy     #$25
        .byte   $83
        jsr     LDF85
        jsr     LE05C
        jsr     LDF7B
        lda     $BC
        jsr     LDF7B
        lda     $BD
        jmp     LDF7B

        beq     LE040
        ldx     #$12
        jsr     LC676
        bcs     LE045
        jsr     LC674
        bcs     LE045
        jmp     LC909

LE040:  lda     #$3A
        jsr     LCA69
LE045:  rts

LE046:  sec
        bit     $18
        ror     a
        jsr     LE05C
        ldx     #$FF
        stx     $C3
        inx
        stx     $62
        stx     $BA
        inx
        stx     L0061
        jmp     LDF7B

LE05C:  pha
        jsr     LD23B
        ldy     #$FA
LE062:  lda     LFF66,y
        jsr     LDF7B
        iny
        bne     LE062
        pla
        rts

        .byte   $7C
        cpx     #$01
        brk
        ora     #$00
        ora     $4552
        bvc     LE0BD
        eor     ($54,x)
        .byte   $80
        brk
        lda     $01E0,x
        brk
        asl     a
        brk
        .byte   $0C
        .byte   $43
        .byte   $4F
        eor     $4E,x
        .byte   $54
        sta     ($05,x)
        jsr     LE08F
        bpl     LE0B6
LE08F:  ldx     #$C3
        jsr     LD486
        ora     $62
        bne     LE09A
        inc     L0061
LE09A:  clc
        pla
        sta     RES
        adc     #$02
        tay
        pla
        sta     RES+1
        adc     #$00
        pha
        tya
        pha
        ldy     #$01
        lda     L0061
        eor     #$FF
        adc     #$01
        sta     (RES),y
        iny
        lda     $62
LE0B6:  eor     #$FF
        adc     #$00
        sta     (RES),y
        rts

LE0BD:  .byte   $D7
        cpx     #$01
        brk
        .byte   $0B
        brk
        .byte   $0C
        .byte   $57
        pha
        eor     #$4C
        eor     $84
        .byte   $07
        lda     $60
        bne     LE0D2
        jmp     L2710

LE0D2:  ldx     #$17
        jmp     LD17E

        bit     $E2
        ora     (RES+1,x)
        ora     $0B00
        lsr     $5845
        .byte   $54
        cmp     ($42,x)
        .byte   $83
        pla
        sta     RESB
        pla
        sta     RESB+1
        ldx     $0700
        ldy     #$02
        lda     $0701,x
        sta     $BD
        cmp     (RESB),y
        bne     LE0D2
        dey
        lda     $0700,x
        sta     $BC
        cmp     (RESB),y
        bne     LE0D2
        ldy     #$03
        lda     ($BC),y
        pha
        lda     #$40
        sta     ($BC),y
        ldy     #$06
        clc
        lda     ($BC),y
        adc     $BC
        sta     $BC
        bcc     LE119
        inc     $BD
LE119:  pla
        bne     LE135
        sta     $BA
        ldy     #$00
        lda     ($BC),y
        sta     L0061
        iny
        lda     ($BC),y
        sta     $62
        jsr     LD23B
        ldx     $BC
        ldy     $BD
        brk
        .byte   $83
        ldx     $0700
LE135:  lda     $06FF,x
        bpl     LE18B
        ldy     #$01
        lda     ($BC),y
        bmi     LE18B
        dey
        sec
        lda     ($BC),y
        sbc     #$81
        bcc     LE18B
        iny
        cmp     #$08
        bcc     LE155
        iny
        sbc     #$10
        bcs     LE18B
        adc     #$08
        clc
LE155:  tax
        lda     LE183,x
LE159:  adc     ($BC),y
        sta     ($BC),y
        bcc     LE164
        lda     #$00
        dey
        bpl     LE159
LE164:  ldy     #$01
        lda     ($BC),y
        bpl     LE19D
        and     #$7F
        sta     ($BC),y
        dey
        lda     ($BC),y
        sec
        adc     #$00
        sta     ($BC),y
        ldx     #$04
LE178:  iny
        lda     ($BC),y
        ror     a
        sta     ($BC),y
        dex
        bne     LE178
        beq     LE19D
LE183:  .byte   $80
        rti

        jsr     L0810
        .byte   $04
        .byte   $02
        .byte   $01
LE18B:  ldy     #$05
LE18D:  lda     $06FE,x
        sta     $60,y
        dex
        dey
        bpl     LE18D
        lda     $BC
        ldy     $BD
        brk
        .byte   $85
LE19D:  ldx     $0700
        ldy     #$00
        lda     ($BC),y
        beq     LE1DF
        pha
        iny
        lda     ($BC),y
        eor     $06F8,x
        bmi     LE1E5
        pla
        cmp     $06F3,x
        bne     LE1D6
        lda     ($BC),y
        ora     #$80
        cmp     $06F4,x
        bne     LE1D6
        iny
        lda     ($BC),y
        cmp     $06F5,x
        bne     LE1D6
        iny
        lda     ($BC),y
        cmp     $06F6,x
        bne     LE1D6
        iny
        lda     ($BC),y
        cmp     $06F7,x
        beq     LE1F1
LE1D6:  lda     $06F8,x
        bcc     LE1E9
        eor     #$FF
        bcs     LE1E9
LE1DF:  lda     $06F3,x
        beq     LE1F3
        .byte   $24
LE1E5:  pla
        lda     $06F8,x
LE1E9:  asl     a
        lda     #$FF
        bcs     LE1F3
        lda     #$01
        .byte   $2C
LE1F1:  lda     #$00
LE1F3:  ldy     $06FE,x
        bpl     LE1FD
        eor     #$FF
        clc
        adc     #$01
LE1FD:  tax
        bpl     LE20C
        sec
        lda     $0700
        sbc     #$0F
        sta     $0700
        lda     #$06
        .byte   $2C
LE20C:  lda     #$03
        clc
        adc     RESB
        sta     RESB
        bcc     LE217
        inc     RESB+1
LE217:  jmp     (RESB)

        beq     LE221
        ldx     #$06
        jmp     LC676

LE221:  jmp     LC906

        .byte   $37
        .byte   $E2
        ora     (RES,x)
        asl     $0C00
        eor     $4E,x
        .byte   $54
        eor     #$4C
        sty     $05
        lda     $60
        bne     LE239
        jmp     LE252

LE239:  ora     (RES,x)
        .byte   $0F
        brk
        asl     $4E55
        .byte   $43
        .byte   $4F
        eor     $4E,x
        .byte   $54
        .byte   $80
        .byte   $0B
        inc     L2710
        bne     LE251
        inc     $2711
        beq     LE254
LE251:  .byte   $4C
LE252:  rts

        .byte   $E2
LE254:  ora     (RES,x)
        bpl     LE258
LE258:  .byte   $0B
        .byte   $57
        eor     $4E
        .byte   $44
        .byte   $80
        ora     ($4C,x)
        sei
        .byte   $E2
        .byte   $03
        .byte   $64
        .byte   $12
        brk
        php
        lsr     L8380,x
        lda     #$6E
LE26C:  sta     $07EE
        jsr     LD311
        jsr     L07ED
        jmp     LD162

        stx     $E2
        .byte   $03
        .byte   $5F
        .byte   $13
        brk
        php
        rol     a
        .byte   $80
        .byte   $83
        lda     #$6C
        bne     LE26C
        sty     $E2,x
        .byte   $03
        .byte   $5F
        .byte   $14
        brk
        php
        .byte   $2F
        .byte   $80
        .byte   $83
        lda     #$6D
        bne     LE26C
        dec     $E2
        .byte   $03
        .byte   $5A
        ora     RES,x
        php
        .byte   $2B
        .byte   $80
        .byte   $83
        bit     $BA
        bpl     LE2BD
        jsr     LD30E
        clc
        lda     $60
        adc     $68
        bcs     LE2C1
        pha
        jsr     LCF5C
        lda     $69
        ldy     $6A
        ldx     $68
        jsr     LCF62
        pla
        sta     $60
        rts

LE2BD:  lda     #$6A
        bne     LE26C
LE2C1:  ldx     #$1A
        jmp     LD17E

        .byte   $D4
        .byte   $E2
        .byte   $03
        .byte   $5A
        asl     RES,x
        php
        and     L8380
        lda     #$6B
        bne     LE26C
        .byte   $E2
        .byte   $E2
        .byte   $03
        cli
        .byte   $17
        brk
        php
        and     L8380,x
        lda     #$02
        bne     LE329
        sbc     ($E2),y
        .byte   $03
        cli
        clc
        brk
        ora     #$3E
        and     L8380,x
        lda     #$03
        bne     LE329
        brk
        .byte   $E3
        .byte   $03
        cli
        ora     $0900,y
        .byte   $3C
        and     L8380,x
        lda     #$06
        bne     LE329
        .byte   $0F
        .byte   $E3
        .byte   $03
        cli
        .byte   $1A
        brk
        ora     #$3C
        rol     L8380,x
        lda     #$05
        bne     LE329
        ora     $03E3,x
        cli
        .byte   $1B
        brk
        php
        rol     L8380,x
        lda     #$01
        bne     LE329
        lda     $03E3,y
        cli
        .byte   $1C
        brk
        php
        .byte   $3C
        .byte   $80
        .byte   $83
        lda     #$04
LE329:  sta     $90
        bit     $BA
        bmi     LE376
        jsr     LD311
        jsr     LE339
        tax
        jmp     LE394

LE339:  lda     $68
        tax
        beq     LE368
        lda     $6D
        eor     $65
        bmi     LE36C
        cpx     $60
        bne     LE360
        lda     $69
        cmp     L0061
        bne     LE360
        lda     $6A
        cmp     $62
        bne     LE360
        lda     $6B
        cmp     $63
        bne     LE360
        lda     $6C
        cmp     $64
        beq     LE375
LE360:  lda     $65
        bcc     LE36E
        eor     #$FF
        bcs     LE36E
LE368:  lda     $60
        beq     LE375
LE36C:  lda     $65
LE36E:  rol     a
        lda     #$FF
        bcs     LE375
        lda     #$01
LE375:  rts

LE376:  jsr     LD30E
        lda     $68
        tax
        sec
        sbc     $60
        beq     LE389
        lda     #$01
        bcc     LE389
        ldx     $60
        lda     #$FF
LE389:  sta     $65
        ldy     #$FF
        inx
LE38E:  iny
        dex
        bne     LE399
        ldx     $65
LE394:  bmi     LE3A5
        clc
        bcc     LE3A5
LE399:  lda     ($69),y
        cmp     (L0061),y
        beq     LE38E
        ldx     #$FF
        bcs     LE3A5
        ldx     #$01
LE3A5:  inx
        txa
        rol     a
        and     $90
        beq     LE3AE
        lda     #$01
LE3AE:  sta     L0061
        sta     $60
        lda     #$00
        sta     $62
        sta     $BA
        rts

        .byte   $D4
        .byte   $E3
        .byte   $03
        eor     $1D,x
        brk
        asl     a
        cli
        .byte   $4F
        .byte   $52
        .byte   $80
        .byte   $83
        jsr     LD314
        lda     L0061
        eor     $69
        tay
        lda     $62
        eor     $6A
        jmp     LE3EE

        .byte   $F7
        .byte   $E3
        .byte   $03
        .byte   $52
        asl     $0A00,x
        eor     ($4E,x)
        .byte   $44
        .byte   $80
        .byte   $83
        jsr     LD314
        lda     L0061
        and     $69
        sta     L0061
        tay
        lda     $62
        and     $6A
LE3EE:  sta     $62
        sty     L0061
        ora     L0061
        sta     $60
        rts

        .byte   $2B
        sbc     RESB+1
        bvc     LE41B
        brk
        ora     #$4F
        .byte   $52
        .byte   $80
        .byte   $83
        jsr     LD314
        lda     L0061
        ora     $69
        tay
        lda     $62
        ora     $6A
        jmp     LE3EE

LE411:  jsr     LD51E
        jsr     LD4D7
        jsr     LE95A
        .byte   $20
LE41B:  .byte   $5F
        sbc     #$20
        ora     $20E5
        sbc     $20E4
        cmp     #$E4
        jsr     LE4CF
        jsr     LE4D5
        jsr     LE4EC
        jsr     LC1F3
        jsr     LD28F
        jsr     LF641
        jsr     LF5E6
        jsr     LF5FE
        jsr     LF60A
        jsr     LF619
        jsr     LF997
        jsr     LE046
        jsr     LEAF4
        jsr     LEB0A
        jsr     LE4B9
        jsr     LE4F7
        jsr     LE517
        jsr     LE51C
        jsr     LD4D7
        lda     #$00
        sta     $60
        lda     #$11
        sta     $07EB
LE468:  .byte   $3A
        bit     $3B2C
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        and     $2928,x
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        eor     ($45,x)
        .byte   $54
        brk
        bit     a:$2C
        brk
        eor     $2C00,x
        bit     $4000
        brk
        brk
        brk
LE490:  brk
LE491:  .byte   $03
        asl     $09
        ora     #$0C
        .byte   $0F
        .byte   $12
        ora     $18,x
        .byte   $1B
        asl     $2121,x
        and     ($21,x)
        and     ($24,x)
        .byte   $27
        rol     a
        and     $3330
        rol     $36,x
        rol     $36,x
        and     $3F3C,y
        .byte   $3F
        .byte   $42
        .byte   $42
        eor     $45
        pha
        .byte   $4B
        .byte   $4B
        lsr     $5752
LE4B9:  ldx     #$00
        stx     $BA
        stx     $9C
        stx     L0061
        stx     $62
        dex
        stx     $9E
        stx     $9F
        rts

        lda     #$90
        ldy     #$80
        bne     LE4D9
LE4CF:  lda     #$8F
        ldy     #$40
        bne     LE4D9
LE4D5:  lda     #$8E
        ldy     #$C0
LE4D9:  sty     $9B
        pha
        lda     #$12
        sta     $07EB
        ldx     #$03
LE4E3:  lsr     $02B6,x
        dex
        bpl     LE4E3
        pla
        brk
        .byte   $02
LE4EC:  rts

        lda     #$10
        sta     $07EB
        lda     #$00
        sta     $9B
        rts

LE4F7:  jsr     LD1F7
        lda     L0061
        cmp     #$04
        bcs     LE50A
        adc     #$10
        sta     $07EB
        lda     #$FF
        sta     $C3
        rts

LE50A:  jmp     LF0FF

        lda     #$0D
        jsr     L07EA
        lda     #$0A
        jmp     L07EA

LE517:  lda     #$1F
        jsr     L07EA
LE51C:  lda     #$FF
        sta     $C3
        jsr     LD1F7
        lda     L0061
        clc
        adc     #$40
        jmp     L07EA

        .byte   $3B
        sbc     RESB
        .byte   $02
        .byte   $80
LE530:  brk
        asl     a
        .byte   $43
        .byte   $4F
        .byte   $53
        .byte   $80
        .byte   $83
        lda     #$71
        bne     LE599
        .byte   $4B
        sbc     RESB
        .byte   $02
        sta     (RES,x)
        asl     a
        .byte   $53
        eor     #$4E
        .byte   $80
        .byte   $83
        lda     #$70
        bne     LE599
        lsr     $02E5,x
        .byte   $02
        .byte   $82
        brk
        asl     a
        eor     ($42,x)
        .byte   $53
        .byte   $80
        .byte   $83
        lda     $BA
        beq     LE55D
        lsr     $65
LE55D:  rts

        ror     $02E5
        .byte   $02
        .byte   $83
        brk
        asl     a
        eor     ($54,x)
        lsr     L8380
        lda     #$73
        bne     LE599
        .byte   $8B
        sbc     RESB
        .byte   $02
        sty     RES
        .byte   $0B
        .byte   $44
        eor     $45
        .byte   $4B
        .byte   $80
        .byte   $83
        jsr     LD1F7
        ldy     #$00
        lda     (L0061),y
        tax
        iny
        lda     (L0061),y
        sta     $62
        stx     L0061
        rts

        lda     $E5
        .byte   $02
        .byte   $02
        sta     RES
        asl     a
        .byte   $44
        eor     $47
        .byte   $80
        .byte   $83
        lda     #$7A
LE599:  sta     $07EE
        jsr     LD23B
        jsr     L07ED
        jmp     LD162

        lda     $E5,x
        .byte   $02
        .byte   $02
        stx     RES
        asl     a
        eor     $58
        bvc     LE530
        .byte   $83
        lda     #$74
        bne     LE599
        cpy     $E5
        .byte   $02
        .byte   $02
        .byte   $87
        brk
        ora     #$4C
        lsr     L8380
        lda     #$75
        bne     LE599
        .byte   $D4
        sbc     RESB
        .byte   $02
        dey
        brk
        asl     a
        jmp     L474F

        .byte   $80
        .byte   $83
        lda     #$76
        bne     LE599
        sbc     $02E5
        .byte   $02
        .byte   $89
        brk
        .byte   $0B
        bvc     LE622
        eor     $4B
        .byte   $80
        .byte   $83
        jsr     LD1F7
        ldy     #$00
        lda     (L0061),y
        sta     L0061
        sty     $62
        rts

        sbc     $02E5,x
        .byte   $02
        txa
        brk
        asl     a
        .byte   $52
        eor     ($44,x)
        .byte   $80
        .byte   $83
        lda     #$79
        bne     LE599
        ora     $02E6
        .byte   $02
        .byte   $8B
        brk
        asl     a
        .byte   $52
        lsr     $8044
        .byte   $83
        lda     #$77
        bne     LE599
        asl     $02E6,x
        .byte   $02
        sty     $0A00
        .byte   $53
        eor     ($52),y
        .byte   $80
        .byte   $83
        lda     #$78
        jmp     LE599

        .byte   $2F
        inc     RESB
        .byte   $02
LE622:  sta     $0A00
        .byte   $54
        eor     ($4E,x)
        .byte   $80
        .byte   $83
        lda     #$72
        jmp     LE599

        .byte   $7B
        inc     RESB
        .byte   $04
        stx     $0B00
        jmp     L424F

        bit     $80
        .byte   $83
        clc
        ldy     #$01
        bcc     LE646
LE641:  clc
        .byte   $24
LE643:  sec
        ldy     #$00
LE646:  ror     $8F
        sty     $8E
        jsr     LCF5C
        ldy     $8E
        beq     LE65B
        lda     $60
        beq     LE67A
        dey
        lda     (L0061),y
        jmp     LE674

LE65B:  cpy     $60
        bcs     LE67A
        lda     (L0061),y
        bit     $8F
        bmi     LE671
        cmp     #$41
        bcc     LE674
        cmp     #$5B
        bcs     LE674
        adc     #$20
        bcc     LE674
LE671:  jsr     LCB45
LE674:  sta     (L0061),y
        iny
        jmp     LE65B

LE67A:  rts

        txa
        inc     RESB
        .byte   $04
        .byte   $8F
        brk
        asl     a
        jmp     L244F

        .byte   $80
        .byte   $03
        jsr     LE641
        sta     $02E6,y
        .byte   $04
        bcc     LE690
LE690:  asl     a
        eor     $50,x
        bit     $80
        .byte   $03
        jsr     LE643
        .byte   $DA
        inc     RESB
        .byte   $03
        sta     (RES),y
        .byte   $0B
        .byte   $42
        eor     #$4E
        bit     $80
        .byte   $83
        jsr     LD1F7
        sec
        ror     RES
        ldy     #$10
        lda     #$25
        sta     L0100
        ldx     #$01
LE6B5:  asl     L0061
        rol     $62
        bcs     LE6C0
        bit     RES
        bmi     LE6CA
        .byte   $2C
LE6C0:  sta     RES
        lda     #$00
        adc     #$30
        sta     L0100,x
        inx
LE6CA:  dey
        bne     LE6B5
LE6CD:  cpx     #$01
        bne     LE6D7
        inx
        lda     #$30
        sta     $0101
LE6D7:  jmp     LE779

        inc     $E6,x
        .byte   $02
        .byte   $03
        .byte   $92
        brk
        .byte   $0B
        .byte   $43
        pha
        .byte   $52
        bit     $80
        .byte   $83
        jsr     LD22E
        pha
        lda     #$01
        jsr     LCF52
        ldy     #$00
        pla
        sta     (L0061),y
        rts

        rti

        .byte   $E7
        .byte   $02
        .byte   $03
        .byte   $93
        brk
        .byte   $0B
        pha
        eor     $58
        bit     $80
        .byte   $83
        jsr     LD1F7
        sec
        ror     RES
        lda     #$23
        sta     L0100
        ldx     #$01
        lda     $62
        jsr     LE71D
        lda     L0061
        jsr     LE71D
        jmp     LE6CD

LE71D:  pha
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        jsr     LE728
        pla
        and     #$0F
LE728:  ora     #$30
        cmp     #$3A
        bcc     LE730
        adc     #$06
LE730:  cmp     #$30
        bne     LE739
        bit     RES
        bmi     LE73F
        .byte   $2C
LE739:  sta     RES
        sta     L0100,x
        inx
LE73F:  rts

        .byte   $5F
        .byte   $E7
        .byte   $02
        .byte   $03
        sty     RES,x
        .byte   $0B
        .byte   $53
        bvc     LE78D
        bit     $80
        .byte   $83
        jsr     LD22E
LE750:  jsr     LCF52
        tay
        beq     LE75E
LE756:  lda     #$20
        dey
        sta     (L0061),y
        tya
        bne     LE756
LE75E:  rts

        .byte   $80
        .byte   $E7
        .byte   $02
        .byte   $03
        sta     RES,x
        .byte   $0B
        .byte   $53
        .byte   $54
        .byte   $52
        bit     $80
        .byte   $83
        jsr     LD23B
        brk
        pla
        ldx     #$FF
LE773:  inx
        lda     L0100,x
        bne     LE773
LE779:  lda     #$00
        ldy     #$01
        jmp     LCF62

        .byte   $9F
        .byte   $E7
        .byte   $02
        ora     $96
        brk
        asl     a
        .byte   $41
LE788:  .byte   $53
        .byte   $43
        .byte   $80
        .byte   $83
        .byte   $A5
LE78D:  rts

        beq     LE794
        ldy     #$00
        lda     (L0061),y
LE794:  sta     L0061
        lda     #$00
        sta     $62
        lda     #$00
        sta     $BA
        rts

        bcs     LE788
        .byte   $02
        ora     $97
        brk
        asl     a
        jmp     L4E45

        .byte   $80
        .byte   $83
        lda     $60
        jmp     LE794

        .byte   $DB
        .byte   $E7
        .byte   $02
        ora     $98
        brk
        asl     a
        lsr     $41,x
        jmp     L8380

LE7BC:  ldy     $60
        lda     (L0061),y
        pha
        sty     $0C
        lda     #$00
        sta     (L0061),y
        lda     L0061
        ldy     $62
        sta     $0D
        sty     $0E
        brk
        adc     #$68
        ldy     $0C
        sta     ($0D),y
        lda     #$40
        sta     $BA
        rts

        .byte   $07
        inx
        .byte   $02
        brk
        sta     $0B00,y
        .byte   $54
        .byte   $52
        eor     $45,x
        .byte   $80
        .byte   $83
        lda     #$01
        .byte   $2C
LE7EB:  lda     #$00
        ldy     #$00
LE7EF:  sta     $8E
        sty     $8F
        jsr     LD40A
        lda     $8F
        sta     $62
        lda     $8E
LE7FC:  sta     L0061
        ora     $62
        sta     $60
        lda     #$00
        sta     $BA
        rts

        clc
        inx
        .byte   $02
        brk
        txs
        brk
        .byte   $0C
        lsr     $41
        jmp     L4553

        .byte   $80
        .byte   $03
        jsr     LE7EB
        and     $02E8
        brk
        .byte   $9B
        brk
        ora     #$50
        eor     #$80
        .byte   $83
        jsr     LD40A
        brk
        .byte   $7C
        lda     #$40
        sta     $BA
        rts

        eor     ($E8),y
        .byte   $02
        .byte   $02
        .byte   $9C
        brk
        asl     a
        .byte   $53
        .byte   $47
        lsr     L8380
        jsr     LD23B
        lda     $60
        beq     LE850
        ldx     #$81
        stx     $60
        dex
        stx     L0061
        ldx     #$03
        lda     #$00
LE84B:  sta     L0061,x
        dex
        bne     LE84B
LE850:  rts

        .byte   $64
        inx
        .byte   $02
        .byte   $02
        sta     $0A00,x
        eor     #$4E
        .byte   $54
        .byte   $80
        .byte   $83
        lda     $BA
        beq     LE863
        brk
        .byte   $7B
LE863:  rts

        sta     $02E8
        ora     ($9E,x)
        brk
        .byte   $0B
        .byte   $4B
        eor     $59
        bit     $80
        .byte   $83
        jsr     LD40A
        brk
        php
        bcs     LE884
        pha
        lda     #$01
        jsr     LCF52
        ldy     #$00
        pla
        sta     (L0061),y
        rts

LE884:  lda     #$00
        sta     $60
        lda     #$80
        sta     $BA
        rts

        .byte   $9F
        inx
        .byte   $02
        .byte   $02
        .byte   $9F
        brk
        .byte   $0B
        .byte   $52
        eor     ($4E,x)
        .byte   $44
        .byte   $80
        .byte   $83
        lda     #$7D
        jmp     LE599

        .byte   $AB
        inx
        ora     (RES,x)
        ldy     #$00
        asl     a
        .byte   $52
        eor     $4D
        stx     $B900
        inx
        ora     (RES,x)
        lda     (RES,x)
        .byte   $0B
        .byte   $47
        .byte   $4F
        .byte   $54
        .byte   $4F
        sta     $4C01
        cld
        inx
        ora     (RES,x)
        ldx     #$00
        .byte   $0C
        .byte   $47
        .byte   $4F
        .byte   $53
        eor     $42,x
        sta     $2004
        .byte   $CB
        inx
        jsr     LC2E6
        tsx
        cpx     #$28
        bcc     LE8D3
        rts

LE8D3:  ldx     #$1B
        jmp     LD17E

        sbc     #$E8
        ora     (RES,x)
        .byte   $A3
        brk
        asl     a
        .byte   $43
        jmp     L8053

        .byte   $83
        lda     #$0C
        brk
        bpl     LE949
        ldy     $01E9
        brk
        ldy     RES
        .byte   $0C
        bvc     LE944
        eor     #$4E
        .byte   $54
        .byte   $23
        cpy     #$12
        brk
LE8F9:  jsr     LCA69
LE8FC:  jsr     LC688
        bne     LE908
LE901:  lda     #$25
        jsr     LCA69
LE906:  clc
LE907:  rts

LE908:  cmp     #$3B
        bne     LE918
        lda     #$23
        jsr     LE942
LE911:  jsr     LE94A
        bne     LE8FC
        beq     LE906
LE918:  cmp     #$2C
        bne     LE925
        lda     #$22
        jsr     LE942
        bne     LE8FC
        beq     LE906
LE925:  ldx     #$0F
        jsr     LC676
        bcs     LE907
        beq     LE911
        jsr     LE94A
        beq     LE901
        ldx     #$04
        jsr     LC676
        bcs     LE907
        lda     #$24
        jsr     LCA69
        jmp     LE8FC

LE942:  .byte   $20
        .byte   $69
LE944:  dex
        jsr     LC686
        .byte   $F0
LE949:  .byte   $0C
LE94A:  jsr     LC688
        beq     LE956
        jsr     LCB50
        bcc     LE957
        cmp     #$B4
LE956:  rts

LE957:  lda     #$01
        rts

LE95A:  lda     #$01
        jmp     L07EA

        lda     #$FF
        sta     $C3
        lda     $BA
        bpl     LE978
        ldx     $60
LE969:  ldy     #$00
LE96B:  txa
        beq     LE977
        lda     (L0061),y
        jsr     L07EA
        iny
        dex
        bne     LE96B
LE977:  rts

LE978:  bne     LE9A0
        lda     #$20
        jsr     L07EA
        lda     #$00
        sta     $14
        lda     #$00
        ldy     #$01
        sta     $11
        sty     $12
        lda     L0061
        ldy     $62
        ldx     #$03
        brk
        plp
        tya
        tax
        inx
LE996:  lda     #$00
        ldy     #$01
        sta     L0061
        sty     $62
        bne     LE969
LE9A0:  brk
        pla
        ldx     #$FF
LE9A4:  inx
        lda     L0100,x
        bne     LE9A4
        beq     LE996
        cmp     ($E9,x)
        ora     (RES,x)
        lda     RES
        ora     $504C
        .byte   $52
        eor     #$4E
        .byte   $54
        cpy     #$0F
        brk
        lda     #$29
        jmp     LE8F9

        dec     $E9,x
        ora     (RES,x)
        ldx     RES
        ora     $5053
        .byte   $52
        eor     #$4E
        .byte   $54
        cpy     #$0F
        brk
        lda     #$27
        jmp     LE8F9

        .byte   $EB
        sbc     #$01
        brk
        .byte   $A7
        brk
        ora     $504D
        .byte   $52
        eor     #$4E
        .byte   $54
        cpy     #$0F
        brk
        lda     #$28
        jmp     LE8F9

        ora     ($EA),y
        ora     (RES,x)
        tay
        brk
        asl     a
        .byte   $47
        eor     $54
        .byte   $23
        and     $EF
        .byte   $83
        lda     #$01
        jsr     LCF52
        lda     $07EB
        sec
        sbc     #$04
        sta     $07EB
        .byte   $20
        nop
LEA09:  .byte   $07
        ldy     #$00
        sta     (L0061),y
        jmp     LD28F

        .byte   $7A
        nop
        ora     (RES,x)
        lda     #$00
        .byte   $0C
        eor     #$4E
        bvc     LEA71
        .byte   $54
        .byte   $27
        .byte   $EF
        .byte   $83
        ldx     #$00
LEA22:  brk
        .byte   $0C
        cmp     #$03
        beq     LEA42
        cmp     #$0D
        beq     LEA56
        cmp     #$7F
        bne     LEA45
        txa
        beq     LEA22
        lda     #$08
        brk
        bpl     LEA58
        .byte   $DB
        cmp     $A9,x
        php
        brk
        bpl     LEA09
        jmp     LEA22

LEA42:  jmp     LDFFC

LEA45:  cmp     #$20
        bcc     LEA51
        cpx     #$6E
        beq     LEA22
        sta     $0590,x
        inx
LEA51:  brk
        bpl     LEAA0
        .byte   $22
        nop
LEA56:  brk
        .byte   $25
LEA58:  lda     #$90
        ldy     #$05
        stx     $60
        sta     L0061
        sty     $62
        ldy     #$02
        lda     ($BC),y
        cmp     #$09
        beq     LEA74
        cmp     #$0D
        beq     LEA74
        jsr     LCF5C
LEA71:  jmp     LD28F

LEA74:  jsr     LE7BC
        jmp     LD28F

        .byte   $87
        nop
        ora     (RES,x)
        tax
        brk
        php
        brk
        .byte   $80
        .byte   $03
        jsr     LD28F
        tya
        nop
        ora     (RES,x)
        .byte   $AB
        brk
        ora     #$49
        lsr     $24
        ldy     $05,x
        lda     $60
        bne     LEA9A
        jmp     LEACB

LEA9A:  ora     (RES,x)
        ldy     $0E00
        .byte   $45
LEAA0:  .byte   $52
        .byte   $52
        .byte   $47
        .byte   $4F
        .byte   $54
        .byte   $4F
        sta     $1883
        pla
        sta     RES
        adc     #$02
        tax
        pla
        sta     RES+1
        adc     #$00
        pha
        txa
        pha
        ldy     #$01
        lda     (RES),y
        sta     L07BA
        iny
        lda     (RES),y
        sta     $07BB
        lda     $8C
        ora     #$04
        sta     $8C
        rts

LEACB:  .byte   $1F
        .byte   $EB
        .byte   $02
        .byte   $07
        lda     $0B00
        eor     $4449
        bit     $80
        .byte   $83
        jsr     LEB45
        ldx     #$00
        clc
        lda     $60
        adc     #$02
        sbc     $63
        bcc     LEB3A
        cmp     $64
        bcc     LEAEC
        lda     $64
LEAEC:  tax
        dec     $63
        lda     $63
        jmp     LEB3A

LEAF4:  pla
        tax
        pla
        tay
        lda     #$FF
        sta     $C3
        lda     $60
        pha
        lda     L0061
        pha
        lda     $62
        pha
        tya
        pha
        txa
        pha
        rts

LEB0A:  pla
        sta     RES
        pla
        sta     RES+1
        jsr     LD22E
        pha
        lda     #$FF
        sta     $C3
        lda     RES+1
        pha
        lda     RES
        pha
        rts

        .byte   $7B
        .byte   $EB
        .byte   $02
        asl     $AE
        brk
        .byte   $0C
        jmp     L4645

        .byte   $54
        bit     $80
        .byte   $83
        jsr     LEB47
        ldx     $63
        cpx     $60
        bcc     LEB38
LEB36:  ldx     $60
LEB38:  lda     #$00
LEB3A:  clc
        adc     L0061
        ldy     $62
        bcc     LEB42
        iny
LEB42:  jmp     LCF62

LEB45:  sec
        .byte   $24
LEB47:  clc
        pla
        sta     RESB
        pla
        sta     RESB+1
        pla
        sta     RES+1
        pla
        sta     RES
        bcc     LEB59
        pla
        sta     $63
LEB59:  php
        jsr     LD22E
        plp
        bcc     LEB63
        sta     $64
        .byte   $2C
LEB63:  sta     $63
        pla
        sta     $62
        pla
        sta     L0061
        pla
        sta     $60
        lda     RES
        pha
        lda     RES+1
        pha
        lda     RESB+1
        pha
        lda     RESB
        pha
        rts

        cpy     #$EB
        .byte   $02
        asl     $AF
        brk
        ora     $4952
        .byte   $47
        pha
        .byte   $54
        bit     $80
        .byte   $83
        jsr     LEB47
        sec
        lda     $60
        sbc     $63
        bcc     LEB36
        ldx     $63
        bcs     LEB3A
LEB98:  .byte   $53
        eor     $D4
        .byte   $4F
        lsr     $C6
        .byte   $54
        .byte   $CF
        .byte   $53
        .byte   $54
        eor     $D0
        eor     $4C
        .byte   $53
        cmp     $54
        pha
        eor     $CE
        lsr     LD44F
        eor     $53,x
        eor     #$4E
        .byte   $C7
        eor     ($FF,x)
        .byte   $54
        eor     ($C2,x)
        eor     ($FF,x)
        eor     ($55,x)
        .byte   $54
        .byte   $CF
        brk
        .byte   $D4
        .byte   $EB
        ora     (RES,x)
        cpy     #$00
        .byte   $0C
        pha
        eor     #$52
        eor     $53
        .byte   $80
        .byte   $83
        jsr     LD149
        brk
        .byte   $1A
        rts

        .byte   $E3
        .byte   $EB
        ora     (RES,x)
        cpy     #$01
        .byte   $0B
        .byte   $54
        eor     $58
        .byte   $54
        .byte   $80
        .byte   $02
        brk
        ora     LEC27,y
        ora     (RES,x)
        cpy     #$02
        .byte   $0B
        jmp     L5349

        .byte   $54
        cpy     #$0D
        brk
        lda     #$26
LEBF3:  pha
        jsr     LEC04
        pla
        bcs     LEC03
        jsr     LCA69
        lda     #$2B
        jsr     LCA69
LEC02:  clc
LEC03:  rts

LEC04:  lda     #$3E
        jsr     LCA69
        jsr     LC688
        beq     LEC02
        jsr     LEC1F
        bcs     LEC03
        jsr     LC688
        beq     LEC02
        ldx     #$09
        jsr     LC676
        bcs     LEC03
LEC1F:  jsr     LC909
        ldx     #$0D
        jmp     LC676

LEC27:  .byte   $53
        cpx     a:RES+1
        cpy     #$03
        .byte   $0C
        .byte   $54
        .byte   $52
        eor     ($43,x)
        eor     $90
        .byte   $83
        php
        asl     $8C
        plp
        ror     $8C
        bpl     LEC4E
        lda     #$8B
        brk
        .byte   $07
        lda     #$62
        ldy     #$02
        ldx     #$03
        brk
        rol     $A9,x
        .byte   $8B
        brk
        .byte   $03
        rts

LEC4E:  .byte   $A9
LEC4F:  .byte   $8B
        brk
        .byte   $07
        rts

        tax
        cpx     a:RES+1
LEC57:  cpy     #$04
        .byte   $0B
        .byte   $57
        .byte   $4F
        .byte   $52
        .byte   $44
        .byte   $80
        .byte   $83
        lda     #$01
LEC62:  sta     $94
        ldx     #$B9
        lda     #$DF
LEC68:  stx     $92
        sta     $93
        ldy     #$02
        lda     ($92),y
        cmp     $94
        bne     LEC96
        cmp     #$01
        bne     LEC7D
        iny
        lda     ($92),y
        bne     LEC96
LEC7D:  sec
        ldy     #$06
        lda     ($92),y
LEC82:  sbc     #$07
        tax
        beq     LEC96
LEC87:  iny
        lda     ($92),y
        brk
        bpl     LEC57
        bne     LEC87
        lda     #$01
        brk
        bpl     LECB4
        cmp     #$F1
LEC96:  clc
        ldy     #$00
        lda     ($92),y
        tax
        iny
        lda     ($92),y
        bne     LEC68
        lda     #$0D
        brk
        bpl     LEC4F
        asl     a
        brk
        bpl     LED0A
        ldy     $01EC,x
        brk
        cpy     #$05
        asl     a
        lsr     $5745
LECB4:  .byte   $80
        .byte   $83
        jsr     ROUTINE2
        jmp     LC068

        .byte   $E7
        cpx     a:RES+1
        cpy     #$07
        asl     a
        .byte   $52
        eor     $4E,x
        cpy     #$19
        .byte   $83
        jsr     LFDA5
        lda     L0061
        ldy     $62
        jsr     LD0ED
        jmp     (L00BE)

        lda     #$3E
        jsr     LCA69
        jsr     LC688
        beq     LECE5
        ldx     #$0D
        jmp     LC676

LECE5:  clc
        rts

        inc     $EC,x
        ora     (RES,x)
        cpy     #$08
        .byte   $0B
        .byte   $4F
        eor     $50,x
        .byte   $53
        .byte   $80
        .byte   $02
        brk
        .byte   $42
        php
        sbc     a:RES+1
        cpy     #$09
        .byte   $0B
        pha
        eor     $4C
        bvc     LEC82
        .byte   $83
LED03:  ldx     #$00
        jmp     ROUTINE1

        .byte   $32
        .byte   $ED
LED0A:  ora     (RES,x)
        cpy     #$0A
        .byte   $0B
        bvc     LED60
        .byte   $4B
        eor     RES+1
        sty     $83
        jsr     LD481
        lda     $BA
        bmi     LED25
        jsr     LD44F
        .byte   $A0
LED21:  brk
        sta     ($9E),y
LED24:  rts

LED25:  ldy     $60
LED27:  tya
        beq     LED24
        dey
        lda     (L0061),y
        sta     ($9E),y
        jmp     LED27

        bvc     LED21
        ora     (RES,x)
        cpy     #$0B
        .byte   $0B
        .byte   $44
        .byte   $4F
        .byte   $4B
        eor     RES+1
        sta     ($83,x)
        jsr     LD481
        jsr     LD484
        ldx     #$00
        sta     ($9E,x)
        tya
        ldy     #$01
        sta     ($9E),y
        rts

        .byte   $63
        sbc     a:RES+1
        cpy     #$0C
        .byte   $0B
        .byte   $43
        eor     ($4C,x)
        jmp     L8381

        jsr     LD484
LED60:  jmp     (L0061)

        .byte   $72
        sbc     a:RES+1
        cpy     #$0F
        .byte   $0B
        bvc     LEDB5
        lsr     $8047
        .byte   $02
        brk
        sta     LED82,x
        ora     (RES,x)
        cpy     #$10
        .byte   $0C
        .byte   $53
        pha
        .byte   $4F
        .byte   $4F
        .byte   $54
        .byte   $80
        .byte   $02
        brk
        .byte   $47
LED82:  sty     $ED,x
        ora     (RES,x)
        cpy     #$11
        asl     $5845
        bvc     LEDD9
        .byte   $4F
        .byte   $44
        eor     $80
        .byte   $02
        brk
        .byte   $9C
        ldx     #$ED
        ora     (RES,x)
        cpy     #$12
        asl     a
        .byte   $5A
        eor     ($50,x)
        .byte   $80
        .byte   $02
        brk
        lsr     $B1
        sbc     a:RES+1
        cpy     #$13
        asl     a
        lsr     $494D
        .byte   $80
        .byte   $03
        jsr     LEDC2
        cmp     $ED,x
        ora     (RES,x)
LEDB5:  cpy     #$14
        .byte   $0C
        .byte   $52
        eor     $53
        eor     $54
        .byte   $80
        .byte   $83
        lsr     $02FA
LEDC2:  lda     #$00
LEDC4:  ldy     #$C0
        sta     $0415
        sty     $0416
        lda     #$07
        sta     $0417
        sei
        jmp     L040C

        beq     LEDC4
        ora     (RES,x)
LEDD9:  cpy     #$15
        .byte   $0C
        .byte   $57
        eor     #$44
        .byte   $54
        pha
        sta     ($83,x)
        jsr     LD44F
        clc
        adc     $0228
        adc     #$FF
        sta     $022C
        rts

        php
        inc     a:RES+1
        cpy     #$16
        ora     $574C
        eor     #$44
        .byte   $54
        pha
        sta     ($83,x)
        jsr     LD44F
        sta     $0288
        brk
        eor     #$60
        .byte   $19
LEE09:  inc     a:RES+1
        cpy     #$17
        .byte   $0B
        .byte   $47
        .byte   $52
        eor     ($42,x)
        .byte   $80
        .byte   $83
        ldy     #$B4
        bne     LEE2B
        .byte   $3C
        inc     a:RES+1
        cpy     #$18
        asl     $4552
        jmp     L4145

        .byte   $53
        eor     $80
        .byte   $83
        ldy     #$98
LEE2B:  .byte   $A9
LEE2C:  brk
LEE2D:  sta     $07FB
        sty     $07FC
        lda     $8C
        and     #$BF
        sta     $8C
        jmp     LFDA5

        bvc     LEE2C
        ora     (RES,x)
        cpy     #$19
        .byte   $0C
        jmp     L494C

        .byte   $53
        .byte   $54
        cpy     #$0E
        brk
        lda     #$29
        jmp     LEBF3

        .byte   $64
        inc     a:RES+1
        cpy     #$1A
        .byte   $0C
        eor     L494C
        .byte   $53
        .byte   $54
        cpy     #$0E
        brk
        .byte   $A9
LEE60:  plp
        jmp     LEBF3

        sei
        inc     a:RES+1
        cpy     #$1B
        .byte   $0C
        .byte   $53
        jmp     L5349

        .byte   $54
        cpy     #$0E
        brk
        lda     #$27
        jmp     LEBF3

        .byte   $92
        inc     a:RES+1
        cpy     #$1C
        .byte   $0C
        jmp     L4546

        eor     $44
        bcc     LEE09
        php
        lsr     $028A
        pla
        .byte   $49
LEE8C:  ora     ($4A,x)
        rol     $028A
        rts

        ldx     #$EE
        ora     (RES,x)
        cpy     #$1D
        .byte   $0B
        eor     ($49,x)
        .byte   $44
        eor     $80
        .byte   $03
        jsr     LED03
        .byte   $BF
        inc     a:RES+1
        cpy     #$1E
        .byte   $0F
        lsr     $55
        lsr     $5443
        eor     #$4F
        lsr     L8380
        lda     #$02
        jsr     LEC62
        brk
        and     $A9
        .byte   $03
        jmp     LEC62

        inc     $EE
        ora     (RES,x)
        cpy     #$1F
        .byte   $0B
        eor     $564F
        eor     RES+1
        ora     ($81,x)
        .byte   $83
        jsr     LD484
        sta     $08
        sty     $09
        jsr     LD481
        sta     $04
        sty     $05
        jsr     LD47E
        sta     $06
        sty     $07
        brk
        clc
        rts

        .byte   $FA
        inc     a:RES+1
        cpy     #$20
        .byte   $0C
        pha
        eor     #$4D
        eor     $4D
        sta     ($83,x)
        jsr     LD484
        jmp     LEE2D

        .byte   $13
        .byte   $EF
        ora     (RES,x)
        cpy     #$21
        ora     $5543
        .byte   $52
        .byte   $53
        .byte   $4F
        .byte   $52
        bcc     LEE8C
        ldx     #$00
        bcc     LEF10
        brk
        and     $60,x
LEF10:  brk
        .byte   $34
        rts

        rol     $EF
        ora     (RES,x)
        cpy     #$22
        .byte   $0B
        jmp     L554F

        .byte   $54
        sta     ($83,x)
        jsr     LD44F
        brk
        pha
        rts

        eor     ($EF,x)
        ora     (RES,x)
        cpy     #$23
        .byte   $0B
        .byte   $57
        eor     ($49,x)
        .byte   $54
        sta     ($83,x)
        jsr     LD484
        sta     $44
        sty     $45
LEF3A:  lda     $44
        ora     $45
        bne     LEF3A
        rts

        cli
        .byte   $EF
        ora     (RES,x)
        cpy     #$24
        asl     $4150
        .byte   $54
        .byte   $54
        eor     $52
        lsr     L8381
        jsr     LD44F
        sta     $02AA
        rts

        sei
        .byte   $EF
        .byte   $02
        ora     ($C0,x)
        .byte   $27
        .byte   $0B
        .byte   $44
        .byte   $52
        lsr     $24,x
        .byte   $80
        .byte   $83
        jsr     LD40A
        lda     #$01
        jsr     LCF52
        lda     $020C
        clc
        adc     #$41
        ldy     #$00
        sta     (L0061),y
        rts

        sta     ($EF),y
        .byte   $02
        ora     ($C0,x)
        and     #$0B
        eor     $58
        .byte   $54
        bit     $80
        .byte   $83
        jsr     LD40A
        lda     #$5D
        ldy     #$05
        ldx     #$03
        jmp     LCF62

        lda     ($EF),y
        ora     (RES,x)
        cpy     #$2A
        asl     a
        eor     $58
        .byte   $54
        .byte   $82
        .byte   $83
        lda     $60
        cmp     #$03
        bne     LEFAE
        ldy     #$02
LEFA5:  lda     (L0061),y
        .byte   $99
LEFA8:  eor     $8805,x
        bpl     LEFA5
        rts

LEFAE:  jmp     LF0FF

        dec     $EF
        ora     (RES,x)
        cpy     #$2B
        .byte   $0C
        .byte   $54
        .byte   $43
        .byte   $4F
        bvc     LF016
        .byte   $80
        .byte   $83
        lda     #$00
        sta     $28
        brk
        lsr     a
        rts

        .byte   $DA
        .byte   $EF
        ora     (RES,x)
        cpy     #$2C
        .byte   $0C
        pha
        .byte   $43
        .byte   $4F
        bvc     LF02B
        .byte   $80
        .byte   $83
        jsr     LD14F
        brk
        jmp     LEE60

        .byte   $EF
        ora     (RES,x)
        cpy     #$34
        ora     $5A41
        eor     $52
        .byte   $54
        eor     L8380,y
        lda     #$01
        brk
        .byte   $52
        rts

        .byte   $02
        beq     LEFF2
        brk
LEFF2:  cpy     #$35
        ora     $5751
        eor     $52
        .byte   $54
        eor     L8380,y
        lda     #$00
        brk
        .byte   $52
        rts

        asl     $F0,x
        ora     (RES,x)
        cpy     #$36
        ora     $5246
        eor     $4E
        .byte   $43
        pha
        .byte   $80
        .byte   $83
        lda     #$02
        brk
        .byte   $52
        rts

LF016:  rol     $01F0
        brk
        cpy     #$37
        ora     $4341
        .byte   $43
        eor     $4E
        .byte   $54
        bcc     LEFA8
        lda     #$04
        bcs     LF02B
        lda     #$05
LF02B:  brk
        .byte   $52
        rts

        .byte   $44
        beq     LF032
        brk
LF032:  cpy     #$38
        ora     $4544
        jmp     L5445

        eor     $C0
        .byte   $12
        .byte   $03
        jsr     LC4B1
        jmp     LEC04

        stx     $F0
        ora     (RES,x)
        cpy     #$3D
        .byte   $0C
        .byte   $41
LF04C:  .byte   $53
        .byte   $43
        eor     #$49
        .byte   $80
        .byte   $83
        jsr     LD5DB
        jsr     LD5DB
        ldx     #$00
LF05A:  jsr     LD5DB
        txa
        brk
        rol     a
        tya
        brk
        .byte   $10
LF063:  inx
        cpx     #$10
        bne     LF05A
        brk
        and     RES
        and     $A2
        .byte   $20
LF06E:  txa
        jsr     LF333
        ldy     #$10
LF074:  jsr     LD5DB
        txa
        brk
        bpl     LF063
        dey
        bne     LF074
        brk
        and     $8A
        bpl     LF06E
        brk
        and     $60
        .byte   $9E
        beq     LF08A
        brk
LF08A:  cpy     #$3E
        .byte   $0B
        .byte   $54
        eor     ($4C,x)
        .byte   $4B
        bcc     LF016
        php
        lda     $8D
        asl     a
        plp
        ror     a
        eor     #$80
        sta     $8D
        rts

        lda     ($F0),y
        ora     (RES,x)
        cpy     #$48
        .byte   $0F
        .byte   $43
        jmp     L434F

        .byte   $4B
        .byte   $4F
        lsr     $46
        .byte   $80
        .byte   $02
        brk
        and     LF0C8,x
        ora     (RES,x)
        cpy     #$49
        .byte   $0F
        .byte   $43
        jmp     L434F

        .byte   $4B
        .byte   $53
        eor     $54
        sta     ($83,x)
        jsr     LD484
        brk
        .byte   $3E
        rts

LF0C8:  bit     $F1
        ora     (RES,x)
        cpy     #$4A
        ora     $5353
        bvc     LF118
        eor     $44
        sta     ($83,x)
        jsr     LD484
        ldy     #$20
LF0DC:  lda     $62
        cmp     LF105,y
        bne     LF0FB
        lda     L0061
        cmp     LF104,y
        bne     LF0FB
        tya
        lsr     a
        sta     RES
        lda     $031F
        and     #$F0
        ora     RES
        sta     $031F
        sta     $59
LF0FA:  rts

LF0FB:  dey
        dey
        bpl     LF0DC
LF0FF:  ldx     #$12
        jmp     LD17E

LF104:  .byte   $10
LF105:  brk
        .byte   $32
        brk
        .byte   $4B
        brk
        adc     $8600
        brk
        stx     RES,y
        bit     $5801
        .byte   $02
        bcs     LF11A
        php
        .byte   $07
LF118:  rts

        .byte   $09
LF11A:  bpl     LF12A
        cpy     #$12
        jsr     L801C
        and     RES
        .byte   $4B
        sty     $F1,x
        ora     (RES,x)
        cpy     #$4B
LF12A:  .byte   $0C
        .byte   $53
        eor     $444F
        eor     $82
        .byte   $83
        ldy     $60
LF134:  dey
        bmi     LF0FA
        ldx     #$0D
LF139:  lda     LF16A,x
        cmp     (L0061),y
        beq     LF145
        dex
        bpl     LF139
        bmi     LF0FF
LF145:  cpx     #$08
        bcs     LF158
        lda     $59
        and     LF178,x
        ora     LF186,x
        sta     $59
        sta     $031F
        bcc     LF134
LF158:  lda     $031E
        and     LF178,x
        ora     LF186,x
        sta     $031E
        and     #$E0
        sta     $5A
        bcs     LF134
LF16A:  bmi     LF19D
        and     $36,x
        .byte   $37
        sec
        .byte   $43
        .byte   $42
        bvc     LF1C2
        .byte   $4F
        eor     $4D
        .byte   $53
LF178:  .byte   $7F
        .byte   $7F
        .byte   $9F
        .byte   $9F
        .byte   $9F
        .byte   $9F
        .byte   $EF
        .byte   $EF
        .byte   $DF
        .byte   $DF
        .byte   $3F
        .byte   $3F
        .byte   $3F
        .byte   $3F
LF186:  brk
        .byte   $80
        rts

        rti

        jsr     L1000
        brk
        jsr     RES
        rti

        .byte   $80
        cpy     #$E0
        sbc     (RES+1),y
        brk
        cpy     #$4C
        asl     $5245
LF19D:  .byte   $52
        jmp     L5349

        .byte   $54
        .byte   $80
        .byte   $83
        ldx     #$00
LF1A6:  txa
        pha
        ldx     #$30
        stx     $14
        ldy     #$00
        ldx     #$00
        brk
        and     #$20
        .byte   $DB
        cmp     $68,x
        tax
        stx     $0C
        jsr     LD57B
        jsr     LF1C7
        ldx     $0C
        inx
LF1C2:  cpx     #$1C
        bne     LF1A6
LF1C6:  rts

LF1C7:  brk
        .byte   $25
LF1C9:  brk
        php
        bcs     LF1C6
        cmp     #$03
        beq     LF1DB
        brk
        .byte   $0C
        cmp     #$1B
        beq     LF1DB
        cmp     #$03
        bne     LF1C6
LF1DB:  pla
        pla
        brk
        and     $60
        asl     $01F2
        brk
        cpy     #$4D
        .byte   $0B
        .byte   $54
        eor     #$4D
        eor     RES+1
        sta     ($83,x)
        jsr     LD44F
        cmp     #$3C
        bcs     LF20B
        ldx     #$00
        stx     $0210
        stx     $0211
        sta     $0212
        jsr     LD44C
        cmp     #$64
        bcs     LF20B
        sta     $0213
        rts

LF20B:  jmp     LF0FF

        .byte   $5C
        .byte   $F2
        .byte   $02
        ora     ($C0,x)
        lsr     $540C
        eor     #$4D
        eor     $24
        .byte   $80
        .byte   $83
        jsr     LD40A
        lda     #$0A
        jsr     LCF52
        ldx     #$00
LF226:  lda     $0210,x
        pha
        inx
        cpx     #$04
        bne     LF226
        ldy     #$00
        pla
        jsr     LF243
        pla
        jsr     LF243
        pla
        jsr     LF243
        pla
        ora     #$30
        jmp     LF258

LF243:  ldx     #$2F
        sec
LF246:  sbc     #$0A
        inx
        bcs     LF246
        pha
        txa
        jsr     LF258
        pla
        adc     #$3A
        jsr     LF258
        lda     #$3A
LF258:  sta     (L0061),y
        iny
        rts

        ror     $01F2,x
        brk
        cpy     #$4F
        .byte   $0B
        jmp     L5542

        lsr     RES+1
        sta     ($83,x)
        lda     #$24
LF26C:  pha
        jsr     LD481
        sta     RES
        sty     RES+1
        jsr     LD484
        pla
        tax
        lda     L0061
        brk
        cli
        rts

        sta     ($F2),y
        ora     (RES,x)
        cpy     #$50
        .byte   $0C
        .byte   $53
        .byte   $52
        .byte   $42
        eor     $46,x
        ora     ($81,x)
        .byte   $83
        lda     #$0C
        bne     LF26C
        ldy     $F2
        ora     (RES,x)
        cpy     #$51
        .byte   $0C
        .byte   $53
        eor     $42
        eor     $46,x
        ora     ($81,x)
        .byte   $83
        lda     #$18
        bne     LF26C
        sbc     ($F2,x)
        ora     (RES,x)
        cpy     #$52
        .byte   $0B
        bvc     LF2F9
        .byte   $4F
        .byte   $54
        ora     (RES+1,x)
        .byte   $82
        .byte   $83
        jsr     LD155
        jsr     LD449
        cmp     #$1C
        bcs     LF2DE
        brk
        jsr     L4C20
        .byte   $D4
        cmp     #$28
        bcs     LF2DE
        ldy     #$00
        brk
        .byte   $22
        lda     #$80
        ldy     #$BB
        brk
        .byte   $22
LF2D0:  ldy     $60
LF2D2:  tya
        beq     LF2DD
        dey
        lda     (L0061),y
        sta     (RES),y
        jmp     LF2D2

LF2DD:  rts

LF2DE:  jmp     LF0FF

        .byte   $F2
        .byte   $F2
        ora     (RES,x)
        cpy     #$53
        asl     a
        bvc     LF339
        bvc     LF26C
        ora     $20
        cmp     $DF,x
        pla
        pla
        .byte   $09
LF2F3:  .byte   $F3
        ora     (RES,x)
        cpy     #$54
        .byte   $0D
LF2F9:  .byte   $53
        .byte   $53
        eor     ($56,x)
        eor     $41
        cpy     #$CA
        .byte   $83
        jsr     LD138
        sec
        brk
        .byte   $5F
        rts

        .byte   $3B
        .byte   $F3
        ora     (RES,x)
        cpy     #$55
        ora     $4C53
        .byte   $4F
        eor     ($44,x)
        eor     ($81,x)
        .byte   $83
        jsr     LD484
        sta     $052D
        sty     $052E
        sec
        brk
        .byte   $5E
LF324:  lda     RES
        pha
        lda     RES+1
        jsr     LF333
        pla
        jsr     LF333
        brk
        and     $60
LF333:  brk
        rol     a
        brk
        bpl     LF2D0
        brk
LF339:  bpl     LF39B
        .byte   $4F
        .byte   $F3
        ora     (RES,x)
        cpy     #$56
        .byte   $0C
        .byte   $53
        jmp     L414F

        .byte   $44
        .byte   $80
        .byte   $83
        clc
        brk
        lsr     $154C,x
        sbc     $66,x
        .byte   $F3
        ora     (RES,x)
        cpy     #$57
        .byte   $0C
        .byte   $53
        .byte   $53
        eor     ($56,x)
        eor     $22
        cpy     #$9B
        .byte   $83
        jsr     LD138
        clc
        brk
        .byte   $5F
        rts

        ror     $F3,x
        ora     (RES,x)
        cpy     #$58
        .byte   $0C
        .byte   $53
        .byte   $44
        eor     $4D,x
        bvc     LF2F3
        .byte   $02
        brk
        .byte   $5C
        dey
        .byte   $F3
        ora     (RES,x)
        cpy     #$5A
        asl     $4F43
        lsr     $4F53
        jmp     L8045

        .byte   $02
        brk
        eor     LF3A6,x
        ora     (RES,x)
        cpy     #$5B
        ora     $4C4D
        .byte   $4F
        eor     ($44,x)
        eor     ($81,x)
        .byte   $83
        jsr     LD484
        .byte   $8D
LF39B:  and     $8C05
        rol     $3805
        brk
        rts

        jmp     LF324

LF3A6:  cpy     #$F3
        ora     (RES,x)
        cpy     #$5C
        ora     $534D
        eor     ($56,x)
        eor     $41
        cpy     #$16
        .byte   $83
        jsr     LD138
        sec
        brk
        adc     ($60,x)
        jmp     LF59A

        .byte   $D4
        .byte   $F3
        ora     (RES,x)
        cpy     #$5D
        .byte   $0C
        eor     $4F4C
        eor     ($44,x)
        .byte   $80
        .byte   $83
        clc
        brk
        rts

        jmp     LF515

        inc     $01F3
        brk
        cpy     #$5E
        .byte   $0C
        eor     $4153
        lsr     $45,x
        .byte   $22
        cpy     #$16
        .byte   $83
        jsr     LD138
        clc
        brk
        adc     ($60,x)
        jmp     LF595

        php
        .byte   $F4
        ora     (RES,x)
        cpy     #$5F
        .byte   $0B
        .byte   $52
        eor     #$4E
        .byte   $47
        .byte   $80
        .byte   $83
LF3FB:  brk
        .byte   $62
        bcc     LF407
        brk
        php
        bcs     LF3FB
        cmp     #$03
        bne     LF3FB
LF407:  rts

        .byte   $1A
        .byte   $F4
        ora     (RES,x)
        cpy     #$60
        asl     $4F43
        lsr     $454E
        .byte   $43
        .byte   $54
        .byte   $80
        .byte   $02
        brk
        .byte   $64
        .byte   $2B
        .byte   $F4
        ora     (RES,x)
        cpy     #$61
        ora     $4357
        cli
        lsr     $49
        lsr     $0280
        brk
        .byte   $63
        .byte   $3F
        .byte   $F4
        ora     (RES,x)
        cpy     #$62
        bpl     LF488
        lsr     $4F43
        lsr     $454E
        .byte   $43
        .byte   $54
        .byte   $80
        .byte   $02
        brk
        adc     $52
        .byte   $F4
        ora     (RES,x)
        cpy     #$63
        .byte   $0B
        .byte   $53
        .byte   $4F
        eor     $54,x
        sta     ($83,x)
        jsr     LD44F
        brk
        .byte   $67
        rts

        adc     $F4
        ora     (RES,x)
        cpy     #$64
        .byte   $0B
        eor     L554F
        .byte   $54
        sta     ($83,x)
        jsr     LD44F
        brk
        ror     $60
        sty     $F4
        .byte   $02
        .byte   $02
        cpy     #$65
        asl     a
        bvc     LF4BD
        .byte   $53
        .byte   $80
        .byte   $83
        jsr     LD1F7
        and     #$07
        tax
        ldy     $0220,x
        cmp     #$04
        bcc     LF481
        ldy     $0286
LF481:  sty     L0061
        rts

        sty     $F4,x
        ora     (RES,x)
LF488:  cpy     #$68
        asl     a
        .byte   $44
        eor     #$52
        stx     $83,y
LF490:  lda     #$56
        bne     LF4D9
        .byte   $A7
        .byte   $F4
        ora     (RES,x)
        cpy     #$6A
        ora     $4544
        jmp     L4142

        .byte   $4B
        stx     $83,y
        lda     #$4A
        bne     LF4D9
        .byte   $B7
        .byte   $F4
        ora     (RES,x)
        cpy     #$70
        asl     a
        .byte   $44
        eor     $4C
        stx     $83,y
        lda     #$4D
        bne     LF4D9
        iny
        .byte   $F4
        ora     (RES,x)
        cpy     #$71
LF4BD:  .byte   $0B
        bvc     LF512
        .byte   $4F
        .byte   $54
        stx     $83,y
        lda     #$50
        bne     LF4D9
        sbc     ($F4,x)
        ora     (RES,x)
        cpy     #$72
        ora     $4E55
        bvc     LF525
        .byte   $4F
        .byte   $54
        stx     $83,y
        lda     #$53
LF4D9:  pha
        jsr     LF995
        pla
        jmp     LF964

        .byte   $FB
        .byte   $F4
        ora     (RES,x)
        cpy     #$33
        .byte   $0B
        eor     #$4E
        eor     #$54
        .byte   $80
        .byte   $83
        lda     #$00
        sta     $052F
        sta     $0530
        lda     #$5C
        jmp     LF964

        lsr     a
        sbc     RES+1,x
        brk
        cpy     #$74
        .byte   $0B
        jmp     L414F

        .byte   $44
        .byte   $82
        .byte   $83
        jsr     LF997
LF50B:  lda     #$68
        jsr     LF964
        lda     #$62
LF512:  jsr     LF964
LF515:  lda     $052C
        lsr     a
        lda     $052C
        bpl     LF53D
        lda     $052F
        ldy     $0530
        .byte   $85
LF525:  lsr     $5F84,x
        php
        jsr     LCAE8
        plp
        bcc     LF53A
        ldx     #$00
        jsr     LDA03
        jsr     LFDA5
        jmp     (L07F9)

LF53A:  jmp     LC0FF

LF53D:  bcc     LF549
        jmp     (L0531)

        jsr     LF995
        cmp     #$02
        bne     LF50B
LF549:  rts

        eor     $01F5,x
        brk
        cpy     #$75
        .byte   $0C
        .byte   $53
        eor     ($56,x)
LF554:  eor     $4D
        .byte   $22
        cpy     #$4A
        .byte   $03
        jsr     LF62E
        bvs     LF554
        ora     (RES,x)
        cpy     #$76
        .byte   $0C
; $E564
str_saveo:
        .byte   "SAVEO"
        .byte   $22
        cpy     #$37
        .byte   $03
        jsr     LF62B
        .byte   $83
        sbc     RES+1,x
        brk
        cpy     #$77
        .byte   $0C
        .byte   $53
        eor     ($56,x)
        eor     $55
        .byte   $22
        cpy     #$24
        .byte   $03
        jsr     LF631
        .byte   $63
        inc     RES+1,x
        brk
        cpy     #$78
        .byte   $0B
        .byte   $53
        eor     ($56,x)
        eor     $22
        cpy     #$11
        .byte   $03
        jsr     LF634
LF595:  lda     #$36
        jsr     LCA69
LF59A:  lda     #$31
        jsr     LCA69
LF59F:  jsr     LC688
        beq     LF5B8
        ldx     #$09
        jsr     LC676
        jsr     LCB50
        bcc     LF5BA
        stx     $C4
        jsr     LCA7A
        lda     #$32
        jsr     LCA69
LF5B8:  clc
        rts

LF5BA:  jsr     LC688
        jsr     LCB45
        ldx     #$33
        cmp     #$41
        beq     LF5D0
        inx
        cmp     #$45
        beq     LF5D0
        inx
        cmp     #$54
        bne     LF5E4
LF5D0:  txa
        pha
        clc
        adc     #$04
        jsr     LCA69
        inc     $C4
        jsr     LC674
        pla
        jsr     LCA69
        jmp     LF59F

LF5E4:  sec
        rts

LF5E6:  lda     #$01
        ora     $052C
        sta     $052C
        asl     a
        bpl     LF5FD
        lda     $052D
        ldy     $052E
        sta     L0531
        sty     $0532
LF5FD:  rts

LF5FE:  jsr     LD484
        sta     $052D
        sty     $052E
        jmp     LF613

LF60A:  jsr     LD484
        sta     $052F
        sty     $0530
LF613:  lda     #$40
        sta     $052C
        rts

LF619:  jsr     LD484
        sta     L0531
        sty     $0532
        lda     #$01
        ora     $052C
        sta     $052C
        rts

LF62B:  lda     #$00
        .byte   $2C
LF62E:  lda     #$40
        .byte   $2C
LF631:  lda     #$C0
        .byte   $2C
LF634:  lda     #$80
        sta     $0528
        jsr     LD138
        lda     #$6B
        jmp     LF964

LF641:  lda     L005E
        ldy     $5F
        sta     $052F
        sty     $0530
        lda     #$F0
        ldy     #$07
        sta     $052D
        sty     $052E
        lda     #$00
        sta     L0531
        .byte   $8D
LF65B:  .byte   $32
        ora     $A9
        .byte   $80
        sta     $052C
        rts

        bcc     LF65B
        ora     (RES,x)
        cpy     #$79
        ora     L4142
        .byte   $43
        .byte   $4B
        eor     $50,x
        .byte   $80
        .byte   $83
        jsr     LD155
        lda     $020C
        sta     $0517
        ldx     $0209
        beq     LF682
        lda     #$01
LF682:  sta     $0518
        lda     #$59
        jsr     LF964
        jsr     ROUTINE2
        jmp     LDFEB

        lda     ($F6),y
        ora     (RES,x)
        cpy     #$7B
        .byte   $0B
        jmp     L4944

        .byte   $52
        stx     $83,y
        lda     #$88
        brk
        .byte   $04
        lda     #$8E
        brk
        brk
        jsr     LF490
        lda     #$8E
        brk
        .byte   $04
        lda     #$88
        brk
        brk
        rts

        cpy     $F6
        ora     (RES,x)
        cpy     #$7C
        .byte   $0C
        .byte   $44
        lsr     $4D41
        eor     $82
        .byte   $83
        lda     #$3B
        jmp     LF964

        .byte   $D7
        inc     RES+1,x
        brk
        cpy     #$7D
        .byte   $0C
        .byte   $43
        .byte   $4F
        bvc     LF728
        .byte   $4F
        cpy     #$45
        .byte   $83
        lda     #$00
        beq     LF6FA
        nop
        inc     RES+1,x
        brk
        cpy     #$7E
        .byte   $0C
        .byte   $43
        .byte   $4F
        bvc     LF73B
        eor     $32C0
        .byte   $83
        lda     #$40
        bne     LF6FA
        ora     $01F7
        brk
        cpy     #$7F
        .byte   $0B
        .byte   $43
        .byte   $4F
        bvc     LF74E
        cpy     #$1F
        .byte   $83
        lda     #$80
LF6FA:  sta     $0528
        lda     #$00
        sta     $0529
        jsr     LF722
        lda     #$38
        jmp     LF964

        jmp     LF738

        .byte   $4F
        .byte   $F7
        ora     (RES,x)
        cpy     #$80
        asl     a
        .byte   $52
        eor     $4E
        cpy     #$2A
        .byte   $83
        jsr     LF722
        lda     #$47
        jmp     LF964

LF722:  ldx     $9D
        lda     $9E
        ldy     $9F
LF728:  brk
        bit     $A2
        .byte   $0C
LF72C:  lda     $0517,x
        sta     L0100,x
        dex
        bpl     LF72C
        jmp     LF995

LF738:  jsr     LF749
LF73B:  bcs     LF74E
        ldx     #$11
        jsr     LC676
        bcs     LF74E
        lda     #$45
        jsr     LCA69
LF749:  ldx     #$02
        jmp     LC676

LF74E:  rts

        adc     $F7
        ora     (RES,x)
        cpy     #$83
        .byte   $0C
        eor     $53
        eor     ($56,x)
        eor     $82
        .byte   $83
        jsr     LF997
        lda     #$35
        jmp     LF964

        .byte   $92
        .byte   $F7
        ora     (RES,x)
        cpy     #$84
        .byte   $0B
        .byte   $4F
        bvc     LF7B4
        lsr     $0101
        .byte   $82
        .byte   $83
        jsr     LD44C
        ldx     #$10
        cmp     #$01
        bcc     LF781
        bne     LF7A8
        ldx     #$08
LF781:  stx     $052C
        jsr     LF997
        jsr     LD449
        sta     $0548
        lda     #$1A
        jmp     LF964

        ora     #$F8
        ora     (RES,x)
        cpy     #$85
        .byte   $0C
        .byte   $43
        jmp     L534F

        eor     $81
        .byte   $83
        jsr     LF8E1
        lda     #$1D
        jmp     LF964

LF7A8:  jmp     LF0FF

        ldx     #$09
        lda     $65
        bpl     LF7B2
        dex
LF7B2:  stx     $94
LF7B4:  ldx     $06
        ldy     $07
        clc
        and     #$7F
        adc     #$07
        jsr     LC9EA
        bcc     LF7C7
        lda     #$00
        sta     $60
LF7C6:  rts

LF7C7:  ldy     #$06
        lda     $92
        ldx     $93
        sta     $BC
        stx     $BD
        adc     ($92),y
        bcc     LF7D6
        inx
LF7D6:  sta     $C4
        stx     $C5
        bit     $51
        bpl     LF806
        ldy     #$04
LF7E0:  lda     ($C4),y
        sta     $60,y
        dey
        bpl     LF7E0
        bit     $65
        bmi     LF7C6
        ldy     #$03
        lda     ($BC),y
        bne     LF7C6
        sta     $BA
        lda     $60
        ldx     L0061
        sta     L0061
        stx     $62
        jsr     LD23B
        lda     L0061
        and     #$7F
        sta     L0061
        rts

LF806:  jmp     LF8C9

        .byte   $1A
        sed
        ora     (RES,x)
        cpy     #$86
        asl     a
        bvc     LF867
        .byte   $54
        ora     ($81,x)
        .byte   $83
        lda     #$23
        bne     LF82A
        .byte   $4B
        sed
        ora     (RES,x)
        cpy     #$87
        .byte   $0B
        .byte   $54
        eor     ($4B,x)
        eor     RES+1
        sta     ($83,x)
        lda     #$20
LF82A:  ldx     VNMI
        stx     $054C
        ldx     #$AB
        ldy     #$F7
        stx     $054D
        sty     $054E
LF83A:  pha
        jsr     LF8E7
        jsr     LD484
        sta     $052D
        sty     $052E
        pla
        jmp     LF964

        eor     $01F8,x
        brk
        cpy     #$88
        .byte   $0B
        lsr     a
        eor     $4D,x
        bvc     LF858
LF857:  .byte   $81
LF858:  .byte   $83
        lda     #$2C
        bne     LF83A
        bvs     LF857
        ora     (RES,x)
        cpy     #$89
        ora     $5041
        .byte   $50
LF867:  eor     $4E
        .byte   $44
        sta     ($83,x)
        lda     #$26
        bne     LF881
        .byte   $89
        sed
        ora     (RES,x)
        cpy     #$8A
        ora     $4552
        .byte   $57
        eor     #$4E
        .byte   $44
        sta     ($83,x)
        lda     #$29
LF881:  pha
        jsr     LF8E1
        pla
        jmp     LF964

        lda     ($F8),y
        ora     (RES,x)
        cpy     #$8B
        .byte   $0B
        .byte   $53
        bvc     LF8E8
        .byte   $54
        ora     ($84,x)
        .byte   $83
        jsr     LF8E7
        lda     $BA
        bmi     LF8AA
        jsr     LD23B
        lda     $65
        ora     #$7F
        and     L0061
        sta     L0061
        lsr     a
LF8AA:  sta     $65
        lda     #$14
        jmp     LF964

        inc     $01F8
        brk
        cpy     #$8C
        .byte   $0C
        .byte   $53
        .byte   $54
        eor     ($4B,x)
        eor     RES+1
        .byte   $27
        .byte   $EF
        .byte   $83
        jsr     LF8E7
        lda     #$17
        jsr     LF964
LF8C9:  lda     $65
        bmi     LF8DB
        lda     L0061
        sta     $65
        ora     #$80
        sta     L0061
        lda     #$40
        sta     $BA
        bne     LF8DE
LF8DB:  jsr     LCF5C
LF8DE:  jmp     LD28F

LF8E1:  jsr     LD44F
        jmp     LF8EA

LF8E7:  .byte   $20
LF8E8:  .byte   $4C
        .byte   $D4
LF8EA:  sta     $0548
        rts

        ora     $02F9
        .byte   $02
        cpy     #$8F
        asl     a
        lsr     $53
        .byte   $54
        .byte   $80
        .byte   $83
        jsr     LD22E
        sta     $0548
        lda     #$11
        jsr     LF964
        lda     L0061
        jmp     LE7FC

LF90A:  jmp     LF0FF

        lsr     $01F9
        brk
        cpy     #$90
        .byte   $0B
        lsr     $49
        jmp     L8145

        .byte   $83
        jsr     LF8E1
        tax
        beq     LF90A
        cmp     #$11
        bcs     LF90A
        sta     $0549
        lda     #$FF
        sta     $0544
        sta     $0545
        lda     #$2F
        jsr     LF964
        sec
        lda     L07F9
        sbc     $04
        sta     $07B5
        sta     $0542
        lda     $07FA
        sbc     $05
        sta     $07B6
        sta     $0543
        jmp     LFDA5

        rol     $FA,x
        ora     (RES,x)
        cpy     #$91
        .byte   $0C
        eor     $5245
        .byte   $47
        eor     $82
        .byte   $83
        lda     #$0E
        jsr     LF4D9
        jmp     LC068

LF964:  sta     $0415
        php
        txa
        pha
        jsr     LD15B
        lda     #$FF
        sta     $0416
        lda     #$00
        sta     $0417
        sta     $0512
        pla
        tsx
        dex
        dex
        dex
        dex
        stx     $0513
        tax
        jsr     L040C
        plp
        lda     $0512
        beq     LF994
        clc
        adc     #$03
        tax
        jmp     LD17E

LF994:  rts

LF995:  clc
        .byte   $24
LF997:  sec
        php
        jsr     LD15B
        ldx     $60
        lda     L0061
        ldy     $62
        brk
        bit     $8A
        bmi     LF9C3
        plp
        ldx     $0517
        bcc     LF9B1
        cmp     #$02
        beq     LF9C3
LF9B1:  cmp     #$02
        bne     LF9B8
        ldx     $020C
LF9B8:  stx     $0500
        ldy     $0208,x
        bne     LF994
        ldx     #$0D
        .byte   $2C
LF9C3:  ldx     #$0C
        jmp     LD17E

LF9C8:  sty     $07EB
        pha
        jsr     LD14F
        jsr     LD44F
        cmp     #$04
        bcs     LFA25
        lsr     a
        ror     a
        ror     a
        sta     $57
        sec
        pla
        sec
        bcs     LF9E4
LF9E0:  clc
        sty     $07EB
LF9E4:  sta     $13
        ror     $12
        lda     #$00
        sta     $90
        sta     $02AB
        dec     $13
        beq     LFA13
        ldx     #$00
        jsr     LFA28
        dec     $13
        beq     LFA13
        ldx     #$06
        jsr     LFA28
        dec     $13
        beq     LFA13
        ldx     #$0C
        jsr     LFA28
        dec     $13
        beq     LFA13
        ldx     #$12
        jsr     LFA28
LFA13:  bit     $12
        bmi     LFA1C
        ldx     #$C3
        jsr     LFA28
LFA1C:  jsr     L07EA
        lda     $02AB
        bne     LFA25
        rts

LFA25:  jmp     LF0FF

LFA28:  jsr     LD459
        ldx     $90
        sta     $4D,x
        sty     $4E,x
        inc     $90
        inc     $90
        rts

        .byte   $4B
        .byte   $FA
        ora     (RES,x)
        cpy     #$A0
        ora     $5543
        .byte   $52
        .byte   $53
        eor     $54
        ora     (RES+1,x)
        sta     ($83,x)
        ldy     #$90
        bne     LFA71
        rts

        .byte   $FA
        ora     (RES,x)
        cpy     #$A1
        ora     $5543
        .byte   $52
        eor     $564F
        ora     (RES+1,x)
        sta     ($83,x)
        ldy     #$91
        bne     LFA71
        ror     $FA,x
        ora     (RES,x)
        cpy     #$A2
        .byte   $0B
        .byte   $44
        .byte   $52
        eor     ($57,x)
        ora     (RES+1,x)
        sta     ($83,x)
        ldy     #$8E
LFA71:  lda     #$03
LFA73:  jmp     LF9C8

        stx     $01FA
        brk
        cpy     #$A3
        .byte   $0C
        eor     ($44,x)
        .byte   $52
        eor     ($57,x)
        ora     (RES+1,x)
        ora     (RES+1,x)
        sta     ($83,x)
        ldy     #$8D
LFA8A:  lda     #$05
        bne     LFA73
        ldy     $FA
        ora     (RES,x)
        cpy     #$A4
        ora     $4943
        .byte   $52
        .byte   $43
        jmp     L0145

        sta     ($83,x)
        lda     #$02
        ldy     #$8F
        bne     LFA73
        ldx     $FA,y
        ora     (RES,x)
        cpy     #$A5
        asl     a
        .byte   $42
        .byte   $4F
        cli
        ora     (RES+1,x)
        sta     ($83,x)
        ldy     #$94
        bne     LFA71
        .byte   $CB
        .byte   $FA
        ora     (RES,x)
        cpy     #$A6
        .byte   $0B
        eor     ($42,x)
        .byte   $4F
        cli
        ora     (RES+1,x)
        ora     (RES+1,x)
        sta     ($83,x)
        ldy     #$95
        bne     LFA8A
        .byte   $DC
        .byte   $FA
        ora     (RES,x)
        cpy     #$A7
        .byte   $0C
        bvc     LFB15
        bvc     LFB1B
        .byte   $52
        sta     (RESB+1,x)
        jsr     LFAEA
        asl     $FB
        ora     (RES,x)
        cpy     #$A8
        asl     a
        eor     #$4E
        .byte   $4B
        sta     ($83,x)
        sec
        .byte   $24
LFAEA:  clc
        php
        jsr     LD44F
        plp
        php
        bcs     LFAF5
        ora     #$10
LFAF5:  pha
        lda     FLGTEL
        and     #$80
        tax
        pla
        plp
        bcc     LFB03
        brk
        .byte   $93
        rts

LFB03:  brk
        .byte   $92
        rts

        asl     $01FB,x
        brk
        cpy     #$A9
        ora     $4152
        .byte   $44
        eor     #$41
        lsr     L8380
LFB15:  lda     FLGTEL
        and     #$DF
        .byte   $8D
LFB1B:  ora     $6002
        and     $FB,x
        ora     (RES,x)
        cpy     #$AA
        .byte   $0C
        .byte   $44
        eor     $47
        .byte   $52
        eor     $80
        .byte   $83
        lda     FLGTEL
        ora     #$20
        sta     FLGTEL
        rts

        adc     #$FB
        ora     (RES,x)
        cpy     #$AC
        .byte   $0B
        .byte   $43
        jmp     L4843

        ora     ($81,x)
        .byte   $83
        jsr     LFB5E
        jsr     LD44C
        cmp     #$04
        bcs     LFB57
        adc     #$04
        sta     $0101
        jsr     LD44F
        cmp     #$18
LFB57:  bcs     LFBD2
        ora     #$80
        jmp     L0100

LFB5E:  lda     #$00
        sta     L0100
        lda     #$60
        .byte   $8D
LFB66:  .byte   $02
        ora     ($60,x)
        bcc     LFB66
        ora     (RES,x)
        cpy     #$AD
        .byte   $0B
        .byte   $4F
        bvc     LFBB6
        pha
        ora     ($81,x)
        .byte   $83
        jsr     LFB5E
        jsr     LD44C
        cmp     #$04
        bcs     LFBD2
        sta     $0101
        jsr     LD44F
        cmp     #$18
        bcs     LFBD2
        ora     #$80
        jmp     L0100

        .byte   $F2
        .byte   $FB
        ora     (RES,x)
        cpy     #$AE
        ora     $5243
        .byte   $4F
        .byte   $53
        .byte   $53
        cli
        ora     (RES+1,x)
        ora     ($81,x)
        .byte   $83
        ldx     #$00
        jsr     LFBD5
        brk
        ora     ($A2,x)
        asl     $20
        .byte   $DF
        .byte   $FB
        brk
        ora     ($A2,x)
        .byte   $0C
        jsr     LFBD5
        brk
LFBB6:  .byte   $02
        ldx     #$C3
        jsr     LFBDF
        brk
        .byte   $02
LFBBE:  asl     $027E
        php
        jsr     LFBEB
        brk
        asl     a
        bcs     LFBCB
        brk
        .byte   $12
LFBCB:  plp
        bcc     LFBBE
        ldx     #$07
        bne     LFC1B
LFBD2:  jmp     LF0FF

LFBD5:  jsr     LD451
        cmp     #$08
LFBDA:  bcs     LFBD2
        ora     #$80
        rts

LFBDF:  jsr     LD451
        cmp     #$08
        bcc     LFBD2
        cmp     #$18
        jmp     LFBDA

LFBEB:  brk
        ora     #$B0
        .byte   $02
        brk
        ora     ($60),y
        .byte   $22
        .byte   $FC
        ora     (RES,x)
        cpy     #$AF
        .byte   $0C
        .byte   $43
        .byte   $52
        .byte   $4F
        .byte   $53
        .byte   $53
        ora     ($81,x)
        .byte   $83
        ldx     #$00
        jsr     LFBD5
        brk
        ora     ($A2,x)
        .byte   $C3
        jsr     LFBDF
        brk
        .byte   $01
LFC0F:  asl     $027E
        php
        jsr     LFBEB
        plp
        bcc     LFC0F
        ldx     #$03
LFC1B:  lsr     $02B2,x
        dex
        bpl     LFC1B
        rts

        .byte   $47
        .byte   $FC
        ora     (RES,x)
        cpy     #$B0
        ora     $4152
        lsr     $4F44
        eor     L8380
        lda     $0304
        sta     $02F0
        lda     $0309
        sta     $02F1
        lda     $0324
        sta     $02F2
        lsr     $02F3
        rts

        sty     $01FC
        brk
        cpy     #$B1
        .byte   $0D
; X
str_window:
        .byte   "WINDOW"
        ora     (RES+1,x)
        ora     (RES+1,x)
        sta     ($83,x)
        jsr     LD449
        sta     L0100
        jsr     LD446
        sta     $0101
        ldx     #$12
        jsr     LD451
        sta     $0102
        jsr     LD44F
        sta     $0103
        lda     #$80
        ldy     #$BB
        sta     $0104
        sty     $0105
        jsr     LD44C
        tax
        lda     #$00
        ldy     #$01
        brk
        rol     $60,x
LFC89:  jmp     LF0FF

        ldy     #$FC
        ora     (RES,x)
        cpy     #$B2
        .byte   $0B
; X
str_play:
        .byte   "PLAY"
        ora     (RES+1,x)
        ora     ($81,x)
        .byte   $83
        ldy     #$43
        bne     LFCC9
        ldx     $FC,y
        ora     (RES,x)
        cpy     #$B3
        .byte   $0C
; X
str_sound:
        .byte   "SOUND"
        ora     (RES+1,x)
        sta     ($83,x)
        lda     #$03
        ldy     #$44
        bne     LFCCB
        cmp     ($FC),y
        ora     (RES,x)
        cpy     #$B4
        .byte   $0C
; X
str_music:
        .byte   "MUSIC"
        ora     (RES+1,x)
        ora     ($81,x)
        .byte   $83
        ldy     #$45
LFCC9:  lda     #$04
LFCCB:  jmp     LF9E0

LFCCE:  jmp     LF0FF

        .byte   $FA
        .byte   $FC
        ora     (RES,x)
        cpy     #$B6
        .byte   $0C
; X
str_lores:
        .byte   "LORES"
        sta     ($83,x)
        jsr     LD155
        jsr     LD44F
        cmp     #$02
        bcs     LFCCE
        adc     #$08
        ldx     #$80
        ldy     #$BB
        stx     RES
        sty     RES+1
        ldy     #$E0
        ldx     #$BF
        brk
        .byte   $1C
        rts

        .byte   $14
        sbc     a:RES+1,x
        cpy     #$B7
        asl     a
; X
str_lpr:.byte   "LPR"
        bcc     LFC89
        bcs     LFD11
        lda     FLGTEL
        and     #$FD
        sta     FLGTEL
        rts

LFD11:  brk
        asl     $2160,x
        sbc     a:RES+1,x
        cpy     #$B8
        asl     a
; X
str_sei:.byte   "SEI"
        .byte   $80
        ora     ($78,x)
        rol     $01FD
        brk
        cpy     #$B9
        asl     a
; X
str_cli:.byte   "CLI"
        .byte   $80
        ora     ($58,x)
        .byte   $43
        sbc     a:RESB,x
        cpy     #$C0
        .byte   $0C
; X
str_errnb:
        .byte   "ERRNB"
        .byte   $80
        .byte   $83
        lda     $07B7
        ldy     #$00
        beq     LFD57
        .byte   $5A
        sbc     a:RESB,x
        cpy     #$C1
        .byte   $0C
; X
str_errnl:
        .byte   "ERRNL"
        .byte   $80
        .byte   $83
        lda     $07B8
        ldy     $07B9
LFD57:  jmp     LE7EF

        .byte   $6F
        sbc     a:RES+1,x
        cpy     #$C2
        .byte   $0C
; X
str_error:
        .byte   "ERROR"
        sta     ($83,x)
        jsr     LD44F
        tax
        jmp     LD17E

        sta     ($FD,x)
        ora     (RES,x)
        cpy     #$C3
        .byte   $0D
; X
str_resume:
        .byte   "RESUME"
        .byte   $80
        .byte   $03
        jmp     (L07C0)

        .byte   $97
        sbc     a:RES+1,x
        cpy     #$C4
        .byte   $0D
; X
str_erroff:
        .byte   "ERROFF"
        .byte   $80
        .byte   $83
        lda     $8C
        and     #$FB
        sta     $8C
        rts

        ora     #$FE
        ora     (RES,x)
        cpy     #$C5
        .byte   $0C
; X
str_clear:
        .byte   "CLEAR"
        .byte   $80
        .byte   $83
LFDA5:  jsr     LCE51
        ldx     #$FD
        lda     #$07
        ldy     #$01
LFDAE:  stx     $0C
        sta     $0D
        lda     ($0C),y
        beq     LFE08
        iny
        lda     ($0C),y
        tax
        ldy     #$06
        lda     ($0C),y
        tay
        cpx     #$08
        beq     LFDD5
        cpx     #$09
        beq     LFDD5
        cpx     #$0C
        beq     LFDCF
        cpx     #$0D
        bne     LFDDF
LFDCF:  jsr     LFDEA
        jmp     LFDDF

LFDD5:  lda     #$00
        sta     ($0C),y
        iny
        sta     ($0C),y
        iny
        sta     ($0C),y
LFDDF:  ldy     #$00
        lda     ($0C),y
        tax
        iny
        lda     ($0C),y
        jmp     LFDAE

LFDEA:  ldy     #$06
        lda     ($0C),y
        sec
        adc     #$01
        adc     $0C
        sta     RES
        lda     #$00
        adc     $0D
        sta     RES+1
        ldy     #$01
        lda     ($0C),y
        tax
        dey
        lda     ($0C),y
        tay
        lda     #$00
        brk
        .byte   $1C
LFE08:  rts

        ora     $01FE,y
        brk
        cpy     #$C6
        .byte   $0C
; X
str_vcopy:
        .byte   "VCOPY"
        .byte   $80
        .byte   $02
        brk
        .byte   $4B
        and     $FE
        ora     (RES,x)
        cpy     #$CC
        asl     a
; X
str_dim:.byte   "DIM"
        .byte   $87
        brk
        .byte   $42
        inc     a:RESB,x
        cpy     #$CD
        asl     a
; X
str_fre:.byte   "FRE"
        .byte   $80
        .byte   $83
        sec
        lda     $07F7
        sbc     L005E
        pha
        lda     $07F8
        sbc     $5F
        tay
        pla
        jmp     LE7EF

        .byte   $5C
        inc     $0102,x
        cpy     #$CE
        .byte   $0C
; X
str_page:
        .byte   "PAGE$"
        .byte   $80
        .byte   $83
        jsr     LD40A
        lda     #$C1
        ldy     #$9C
        ldx     #$07
        jmp     LCF62

        adc     $FE,x
        ora     (RES,x)
        cpy     #$CF
        .byte   $0E
; X
str_serveur:
        .byte   "SERVEUR"
        sta     ($83,x)
        jsr     LD44F
        tax
        lda     #$C5
        jmp     LFEAD

        stx     $FE,y
        ora     (RES,x)
        cpy     #$D0
        .byte   $0E
; X
str_minitel:
        .byte   "MINITEL"
        .byte   $80
        .byte   $83
        ldx     $07F1
        txs
LFE89:  rts

        tsx
        stx     $07F1
        lda     $0800
        beq     LFE89
        jmp     (L07F9)

        lda     $01FE,x
        brk
        cpy     #$D1
        .byte   $0C
; X
str_aplic:
        .byte   "APLIC"
        .byte   $81
        .byte   $83
        jsr     LD484
        sta     $4D
        sty     $4E
        lda     #$BF
LFEAD:  ldy     #$03
        sty     $0417
        ldy     #$FF
        sta     $0415
        sty     $0416
        jmp     L040C

        .byte   $02
        .byte   $FF
        ora     (RES,x)
        cpy     #$D2
        .byte   $0D
        .byte   $54
; X
str_input:
        .byte   "INPUT"
        .byte   $C0
        .byte   $1F
        .byte   $83
        jsr     LD44C
        sta     $60
        lda     #$BC
        jsr     LFEAD
        jsr     LCF5C
        jmp     LD28F

        lda     #$47
        jsr     LCA69
        ldx     #$0F
        jsr     LC676
        bcs     LFF01
        jsr     LC674
        bcs     LFF01
        ldx     #$09
        jsr     LC676
        bcs     LFF01
        ldx     #$05
        jsr     LC676
        bcs     LFF01
        lda     #$2F
        jsr     LCA69
LFF01:  rts

        .byte   $32
        .byte   $FF
        .byte   $02
        asl     $C0
        .byte   $D4
        .byte   $0E
; X
str_middle:
        .byte   "MIDDLE$"
        .byte   $80
        .byte   $83
        jsr     LEB47
        sec
        lda     $63
        sbc     $60
        bcc     LFF2F
        lsr     a
        pha
        jsr     LCF5C
        pla
        tay
        clc
        adc     $60
        pha
        tya
        jsr     LE750
        pla
        sta     $60
        rts

LFF2F:  jmp     LF0FF

        pha
        .byte   $FF
        .byte   $02
        .byte   $02
        cpy     #$D5
        asl     a
        lsr     $544F
        .byte   $80
        .byte   $83
        jsr     LD1F7
        lda     L0061
        eor     #$01
        jmp     LE7FC

        lsr     $01FF,x
        brk
        cpy     #$D6
        .byte   $0B
; X
str_fill:
        .byte   "FILL"
        .byte   $01
        ora     ($81,x)
        .byte   $83
        lda     #$03
        ldy     #$96
        jmp     LF9E0

        .byte   $74
        .byte   $FF
        ora     (RES,x)
        cpy     #$D7
        .byte   $0B
; X
str_char:
        .byte   "C"
LFF66:  .byte   "HAR"
        .byte   $01
        ora     ($81,x)
        .byte   $83
        lda     #$03
        ldy     #$97
        jmp     LF9C8

        .byte   $8B
        .byte   $FF
        ora     (RES,x)
        cpy     #$D8
        .byte   $0C
; X
str_schar:
        .byte   "SCHAR"
        .byte   $82
        .byte   $83
        ldx     $60
        lda     L0061
        ldy     $62
        brk
        tya
        rts

        sbc     $0107,x
        brk
        cpy     #$D9
        .byte   $0B
        .byte   $43
        .byte   $4F
        lsr     $8054
        .byte   $0C
        pla
        pla
        pla
        sta     $0700
        pla
        sta     $C2
        jmp     (L07C0)

LFFA4:  ldx     #$01
        jsr     ROUTINE1
        jmp     ROUTINE3

; $FFAC
START_HYPERBASIC:
        lda     FLGTEL
        and     #$04
        bne     LFFE6
        lda     #$00
        ldy     #$C0
        ldx     #$05
        sta     $0415
        sty     $0416
        stx     $0417
        jmp     L040C

        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00
LFFE6:  jmp     LFFA4

        .byte   $4C
        .byte   $24
LFFEB:  .byte   $C2
        jmp     LCAE8

        jmp     LC3C2

        jmp     LC4E7

        jmp     ROUTINE2

        .byte   $6F
        cld
        bpl     LFFEB
        brk
        cpy     #$FA
        .byte   $02
