scr40	equ %00111110	;obraz normalny	*-screen 40b

pmBase	equ $b000
fnt3    equ $3800
fnt3_2  equ $3c00


Player0_PositionX equ $d000
Player1_PositionX equ $d001
Player2_PositionX equ $d002
Player3_PositionX equ $d003

Missile0_PositionX equ $d004
Missile1_PositionX equ $d005
Missile2_PositionX equ $d006
Missile3_PositionX equ $d007

Player0_Size equ $d008
Player1_Size equ $d009
Player2_Size equ $d00a
Player3_Size equ $d00b

Missiles_Size equ $d00c

Player0_Missile0_Color0_PM0 equ $d012
Player1_Missile1_Color1_PM1 equ $d013
Player2_Missile2_Color2_PM2 equ $d014
Player3_Missile3_Color3_PM3 equ $d015

Playfield_Color0_PF0	equ $d016
Playfield_Color1_PF1	equ $d017
Playfield_Color2_PF2	equ $d018
Playfield_Color3_PF3	equ $d019
Background_BAK		equ $d01a

PRIOR_GTIACTL	equ $d01b
CHARBASE	equ $d409

rejA equ $80
rejX equ rejA+2
rejY equ rejX+2

zp   equ rejY+2
zp_  equ zp+2
txt  equ zp_+2

 org $2000

main
;-- init PMG
 lda >pmBase
 sta $d407
 lda #3
 sta $d01d		*- PMCTL - show PMG

 lda 20			;czekamy 1 ramke zanim zrobimy jakies nieszczescie :)
 cmp 20			*- wait 1 frame
 beq *-2

 sei			;wylaczenie przerwan *- IRQ OFF, NMI OFF
 lda #0
 sta $d40e
 lda #$fe
 sta $d301		;wylaczenie ROM-u *- ROM OFF

 mwa #nmi $fffa		;nasza nowa obsluga przerwania NMI
 
 mwa #dli1 dliv+1
 
 jsr save_color

 lda #$c0
 sta $d40e		;wlaczenie NMI z przerwaniami DLI

 jsr fade_in

;kk lda $d20a
; sta $d01a
; jmp kk 

 jsr input_string


;--

licz brk

wait lda 20
 cmp 20
 beq *-2
 dex
 bne wait
 rts

;--
 
dli1

 sta $d40a                   ;line=0
 sta $d40a                   ;line=1
 sta $d40a                   ;line=2
 sta $d40a                   ;line=3
 sta $d40a                   ;line=4
 sta $d40a                   ;line=5
c8 lda #$6A
c9 ldx #$58
c10 ldy #$44
 sta $d40a                   ;line=6
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
 lda #$75
 sta Player0_PositionX
c11 lda #$2A
 sta Player0_Missile0_Color0_PM0
;--
 sta $d40a                   ;line=7
 sta $d40a                   ;line=8
 sta $d40a                   ;line=9
 sta $d40a                   ;line=10
 sta $d40a                   ;line=11
 sta $d40a                   ;line=12
 sta $d40a                   ;line=13
 lda #$7F
 ldx #$7D
 sta $d40a                   ;line=14
 sta Player0_PositionX
 stx Missile0_PositionX
 lda #$4D
 sta $d40a                   ;line=15
 sta Missile0_PositionX
 lda #$84
 sta $d40a                   ;line=16
 sta Missile2_PositionX
 sta $d40a                   ;line=17
 sta $d40a                   ;line=18
 lda #$01
 ldx #$3D
 sta $d40a                   ;line=19
 sta Player0_Size
 stx Player0_PositionX
 sta $d40a                   ;line=20
 sta $d40a                   ;line=21
 lda #$70
 sta $d40a                   ;line=22
 sta Player3_PositionX
 lda #$76
 sta $d40a                   ;line=23
 sta Player0_PositionX
 lda #$75
 ldx #$3F
 sta $d40a                   ;line=24
 sta Player0_PositionX
 stx Missile0_PositionX
; sta $d40a                   ;line=25
; sta $d40a                   ;line=26
; sta $d40a                   ;line=27
; sta $d40a                   ;line=28
; sta $d40a                   ;line=29
; sta $d40a                   ;line=30
; sta $d40a                   ;line=31
 mwa #dli1_2 dliv+1
 mrti


dli1_2
 sta $d40a                   ;line=32
 sta $d40a                   ;line=33
c12 lda #$44
 sta $d40a                   ;line=34
 sta Player0_Missile0_Color0_PM0
c13 lda #$78
c14 ldx #$76
c15 ldy #$74
 sta $d40a                   ;line=35
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
 lda #$A6
 sta Missile0_PositionX
 
 mwa #dli2 dliv+1
 mrti


dli2
 lda >fnt3_2
c16 ldx #$AA
 ldy #$D0
 sta $d40a                   ;line=40
 sta CHARBASE
 stx Playfield_Color2_PF2
 sty Player0_PositionX
c17 lda #$00
 sta Player0_Missile0_Color0_PM0
 sta $d40a                   ;line=41
c18 lda #$00
 sta $d40a                   ;line=42
 sta Playfield_Color3_PF3
c19 lda #$A4
 sta $d40a                   ;line=43
 sta Playfield_Color0_PF0
 sta $d40a                   ;line=44
c20 lda #$A6
 sta $d40a                   ;line=45
 sta Playfield_Color1_PF1
 sta $d40a                   ;line=46
; sta $d40a                   ;line=47
c21 lda #$C4
c22 ldx #$C6
c23 ldy #$CC
; sta $d40a                   ;line=48
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
; sta $d40a                   ;line=49
; sta $d40a                   ;line=50
; sta $d40a                   ;line=51
; sta $d40a                   ;line=52
; sta $d40a                   ;line=53
; sta $d40a                   ;line=54
; sta $d40a                   ;line=55
 
 mwa #dli2_2 dliv+1
 mrti


dli2_2
 sta $d40a                   ;line=56
 sta $d40a                   ;line=57
 lda #$33
c24 ldx #$06
 sta $d40a                   ;line=58
 sta Player2_PositionX
 stx Player2_Missile2_Color2_PM2
 sta $d40a                   ;line=59
 lda #$00
 ldx #$33
c25 ldy #$06
 sta $d40a                   ;line=60
 sta Player1_Size
 stx Player1_PositionX
 sty Player1_Missile1_Color1_PM1
 lda #$33
c26 ldx #$08
c27 ldy #$0E
 sta $d40a                   ;line=61
 sta Player3_PositionX
 stx Player2_Missile2_Color2_PM2
 sty Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=62
c28 lda #$C8
 sta $d40a                   ;line=63
 sta Playfield_Color3_PF3
 mwa #dli3 dliv+1
 mrti


dli3
 lda >fnt3
c29 ldx #$A4
c30 ldy #$A6
 sta $d40a                   ;line=88
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c31 lda #$00
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=89
c32 lda #$AC
 sta $d40a                   ;line=90
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=91
 sta $d40a                   ;line=92
c33 lda #$04
c34 ldx #$06
c35 ldy #$0C
 sta $d40a                   ;line=93
 sta Player1_Missile1_Color1_PM1
 stx Player2_Missile2_Color2_PM2
 sty Player3_Missile3_Color3_PM3
c36 lda #$34
c37 ldx #$36
c38 ldy #$3C
 sta $d40a                   ;line=94
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
c39 lda #$38
 sta $d40a                   ;line=95
 sta Playfield_Color3_PF3
 lda >fnt3_2
 sta $d40a                   ;line=96
 sta CHARBASE
 mwa #dli4 dliv+1
 mrti
 

dli4
 lda >fnt3
c40 ldx #$A4
c41 ldy #$A6
 sta $d40a                   ;line=120
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c42 lda #$00
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=121
c43 lda #$AC
 sta $d40a                   ;line=122
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=123
c44 lda #$0E
 sta $d40a                   ;line=124
 sta Player3_Missile3_Color3_PM3
c45 lda #$0A
 sta $d40a                   ;line=125
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=126
c46 lda #$98
 sta $d40a                   ;line=127
 sta Playfield_Color3_PF3
 lda >fnt3_2
c47 ldx #$94
c48 ldy #$96
 sta $d40a                   ;line=128
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c49 lda #$9C
 sta Playfield_Color2_PF2
 mwa #dli5 dliv+1
 mrti


dli5
 lda >fnt3
c50 ldx #$A4
c51 ldy #$A6
 sta $d40a                   ;line=152
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c52 lda #$00
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=153
c53 lda #$AC
 sta $d40a                   ;line=154
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=155
c54 lda #$0E
 sta $d40a                   ;line=156
 sta Player3_Missile3_Color3_PM3
c55 lda #$08
 sta $d40a                   ;line=157
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=158
c56 lda #$F8
 sta $d40a                   ;line=159
 sta Playfield_Color3_PF3
 lda >fnt3_2
c57 ldx #$E4
c58 ldy #$F6
 sta $d40a                   ;line=160
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c59 lda #$FC
 sta Playfield_Color2_PF2
 mwa #dli6 dliv+1
 mrti


dli6
 lda >fnt3
c60 ldx #$A4
c61 ldy #$A6
 sta $d40a                   ;line=184
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c62 lda #$00
 sta Playfield_Color3_PF3
 sta $d40a                   ;line=185
c63 lda #$AC
 sta $d40a                   ;line=186
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=187
c64 lda #$06
 sta $d40a                   ;line=188
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=189
 sta $d40a                   ;line=190
c65 lda #$28
 sta $d40a                   ;line=191
 sta Playfield_Color3_PF3
 lda >fnt3_2
c66 ldx #$24
c67 ldy #$26
 sta $d40a                   ;line=192
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c68 lda #$2C
 sta Playfield_Color2_PF2
; sta $d40a                   ;line=193
; sta $d40a                   ;line=194
; sta $d40a                   ;line=195
; sta $d40a                   ;line=196
; sta $d40a                   ;line=197
; sta $d40a                   ;line=198
; sta $d40a                   ;line=199
 mwa #dli6_2 dliv+1
 mrti


dli6_2
c69 lda #$A4
c70 ldx #$A6
c71 ldy #$00
 sta $d40a                   ;line=216
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color3_PF3
 sta $d40a                   ;line=217
c72 lda #$AC
 sta $d40a                   ;line=218
 sta Playfield_Color2_PF2
c73 lda #$0E
 sta $d40a                   ;line=219
 sta Player3_Missile3_Color3_PM3
 mrti


;--

nmi bit $d40f
 bpl vbl
 
 sta rejA
 stx rejX
 sty rejY

dliv jmp dliQ

vbl pha			;przerwanie VBL *- VBL routine
; txa
; pha
; tya
; pha
 sta $d40f		;reset znacznika przerwania $d40f
 
 inc $14

 mwa #ant $d402		;adres programu ANTICA ($d402,$d403)
 mva #scr40 $d400	;ustawienie szerokosci obrazu $d400

;-- init pierwszej linii

 lda >fnt3
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$2A
 sta Playfield_Color0_PF0
c2 lda #$38
 sta Playfield_Color1_PF1
c3 lda #$34
 sta Playfield_Color2_PF2
c4 lda #$38
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$00
 sta Player0_Size
 sta Player2_Size
 sta Player3_Size
 sta Missiles_Size
 lda #$63
 sta Player0_PositionX
 lda #$49
 sta Player2_PositionX
 lda #$73
 sta Player3_PositionX
 lda #$4D
 sta Missile0_PositionX
 lda #$7B
 sta Missile2_PositionX
 lda #$3F
 sta Missile3_PositionX
c5 lda #$6A
 sta Player0_Missile0_Color0_PM0
c6 lda #$34
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3
 lda #$01
 sta Player1_Size
 lda #$20
 sta Player1_PositionX
c7 lda #$00
 sta Player1_Missile1_Color1_PM1

 mwa #dli1 dliv+1

; pla
; tay
; pla
; tax
 pla
dliQ rti

;--
;--

ant dta $80,$44,a(text)
 dta 4,4,$84,$84,$70,$f0,$70,4,4,$84,$70,4,4,$84,$70,4,4,$84,$70,4,4,$84,$70,4,4,$84
 dta $41,a(ant)

text
 ins 'H_Score_OK.scr'

 
/*
  FADE ON-OUT
*/
 icl 'h_score_ok.fad'


/*
  INPUT STRING
*/
 icl 'input_string.asm'
 
;--
;--

 org fnt3
 ins 'H_Score_OK.fnt',0,91*8

 org fnt3_2
 ins 'H_Score_OK.fnt',128*8,107*8

;--
;--

 org pmBase+$300
 icl 'H_Score_OK.pmg'
 
 run main

;--
;--

 opt l-
 icl 'xasm.mac'

.macro align
 .if <* > 0
   org >[*+$100]*$100+%%1
 .endif
.endm

.macro mrti
 lda rejA
 ldx rejX
 ldy rejY
 rti
.endm
