
scr40	equ %00111110	;obraz normalny	*-screen 40b
pmBase	equ $B000

Player0_PositionX equ $D000
Player1_PositionX equ $D001
Player2_PositionX equ $D002
Player3_PositionX equ $D003

Missile0_PositionX equ $D004
Missile1_PositionX equ $D005
Missile2_PositionX equ $D006
Missile3_PositionX equ $D007

Player0_Size equ $D008
Player1_Size equ $D009
Player2_Size equ $D00A
Player3_Size equ $D00B

Missiles_Size equ $D00C

Player0_Missile0_Color0_PM0 equ $D012
Player1_Missile1_Color1_PM1 equ $D013
Player2_Missile2_Color2_PM2 equ $D014
Player3_Missile3_Color3_PM3 equ $D015

Playfield_Color0_PF0 equ $D016
Playfield_Color1_PF1 equ $D017
Playfield_Color2_PF2 equ $D018
Playfield_Color3_PF3 equ $D019

Background_BAK equ $D01A
PRIOR_GTIACTL equ $D01B

CHARBASE equ $D409

;-- BASIC switch OFF
 org $2000
 lda #$ff
 sta $d301
 rts
 ini $2000

;-- MAIN PROGRAM
 org $2000

main
;-- init PMG
 mva >pmBase $d407	;PMCTL - wyswietlac duchy i pociski
 mva #3 $d01d		;PMCTL - show PMG

 lda 20			;czekamy 1 ramke zanim zrobimy jakies nieszczescie :)
 cmp 20			*- wait 1 frame
 beq *-2

 sei			;wylaczenie przerwan *- IRQ OFF, NMI OFF
 mva #0 $d40e
 mva #$fe $d301		;wylaczenie ROM-u *- ROM OFF

 mwa #nmi $fffa		;nasza nowa obsluga przerwania NMI
			*- new NMI routine

 mva #$c0 $d40e		;wlaczenie NMI z przerwaniami DLI
			*- NMI ON with DLI interrupt

null jmp dli1		;tutaj CPU sie nudzi, nie wolno nic tutaj robic
			*- over, no more routines or system crash
;--

;-- MAIN PROGRAM
 org $2100-16

dli1
 lda $d40b
 cmp #2
 bne dli1
 :3 sta $d40a

 sta $d40a                   ;line=0
 lda #$61
 sta $d40a                   ;line=1
 sta Player2_PositionX
 lda #$81
 sta $d40a                   ;line=2
 sta Player3_PositionX
 sta $d40a                   ;line=3
 lda #$5F
 ldx #$80
 sta $d40a                   ;line=4
 sta Player2_PositionX
 stx Player3_PositionX
 lda #$61
 sta $d40a                   ;line=5
 sta Player2_PositionX
 sta $d40a                   ;line=6
 sta $d40a                   ;line=7
 lda #$60
 sta $d40a                   ;line=8
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=9
 sta Player2_PositionX
 lda #$60
 sta $d40a                   ;line=10
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=11
 sta Player2_PositionX
 sta $d40a                   ;line=12
 sta $d40a                   ;line=13
 sta $d40a                   ;line=14
 sta $d40a                   ;line=15
 sta $d40a                   ;line=16
 sta $d40a                   ;line=17
 sta $d40a                   ;line=18
 sta $d40a                   ;line=19
 sta $d40a                   ;line=20
 sta $d40a                   ;line=21
 sta $d40a                   ;line=22
 sta $d40a                   ;line=23
 sta $d40a                   ;line=24
 sta $d40a                   ;line=25
 sta $d40a                   ;line=26
 sta $d40a                   ;line=27
 sta $d40a                   ;line=28
 sta $d40a                   ;line=29
 sta $d40a                   ;line=30
 lda #$8C
 sta $d40a                   ;line=31
 sta Missile2_PositionX
 lda #$7F
 sta $d40a                   ;line=32
 sta Player3_PositionX
 lda #$81
 sta $d40a                   ;line=33
 sta Player3_PositionX
 sta $d40a                   ;line=34
 lda #$80
 sta $d40a                   ;line=35
 sta Player3_PositionX
 lda #$60
 sta $d40a                   ;line=36
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=37
 sta Player2_PositionX
 sta $d40a                   ;line=38
 sta $d40a                   ;line=39
 sta $d40a                   ;line=40
 sta $d40a                   ;line=41
 lda #$60
 sta $d40a                   ;line=42
 sta Player2_PositionX
 lda #$61
 sta $d40a                   ;line=43
 sta Player2_PositionX
 sta $d40a                   ;line=44
 sta $d40a                   ;line=45
 sta $d40a                   ;line=46
 sta $d40a                   ;line=47
 sta $d40a                   ;line=48
 sta $d40a                   ;line=49
 sta $d40a                   ;line=50
 sta $d40a                   ;line=51
 lda #$88
 sta $d40a                   ;line=52
 sta Missile2_PositionX
 sta $d40a                   ;line=53
 sta $d40a                   ;line=54
 sta $d40a                   ;line=55
 sta $d40a                   ;line=56
 sta $d40a                   ;line=57
 sta $d40a                   ;line=58
 sta $d40a                   ;line=59
 sta $d40a                   ;line=60
 lda #$68
 sta $d40a                   ;line=61
 sta Missile2_PositionX
 lda #$7F
 sta $d40a                   ;line=62
 sta Player3_PositionX
c7 lda #$48
c8 ldx #$74
c9 ldy #$0A
 sta $d40a                   ;line=63
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
c10 lda #$0E
 sta Player3_Missile3_Color3_PM3
c11 lda #$78
c12 ldx #$84
c13 ldy #$6A
 sta $d40a                   ;line=64
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
c14 lda #$14
 sta Playfield_Color3_PF3
 lda #$39
 sta Player2_PositionX
;--
 lda #$89
 sta Player3_PositionX
 lda #$6D
 sta Missile2_PositionX
c15 lda #$0C
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=65
 sta $d40a                   ;line=66
 sta $d40a                   ;line=67
 lda #$58
 ldx #$A8
 ldy #$38
 sta $d40a                   ;line=68
 sta Player0_PositionX
 stx Player1_PositionX
 sty Player2_PositionX
 lda #$88
 sta Player3_PositionX
 sta $d40a                   ;line=69
 sta $d40a                   ;line=70
 sta $d40a                   ;line=71
 sta $d40a                   ;line=72
 sta $d40a                   ;line=73
 sta $d40a                   ;line=74
 sta $d40a                   ;line=75
 lda #$87
 ldx #$5F
 ldy #$64
 sta $d40a                   ;line=76
 sta Player3_PositionX
 stx Missile0_PositionX
 sty Missile3_PositionX
 sta $d40a                   ;line=77
 sta $d40a                   ;line=78
 lda #$54
 sta $d40a                   ;line=79
 sta Missile2_PositionX
 sta $d40a                   ;line=80
 sta $d40a                   ;line=81
 lda #$A0
 sta $d40a                   ;line=82
 sta Missile2_PositionX
 lda #$60
 sta $d40a                   ;line=83
 sta Missile0_PositionX
 lda #$39
 sta $d40a                   ;line=84
 sta Player2_PositionX
 sta $d40a                   ;line=85
 sta $d40a                   ;line=86
 sta $d40a                   ;line=87
 lda #$37
 sta $d40a                   ;line=88
 sta Player2_PositionX
 lda #$C4
 sta $d40a                   ;line=89
 sta Missile2_PositionX
 sta $d40a                   ;line=90
 sta $d40a                   ;line=91
 sta $d40a                   ;line=92
 sta $d40a                   ;line=93
 sta $d40a                   ;line=94
c16 lda #$74
c17 ldx #$00
 sta $d40a                   ;line=95
 sta Playfield_Color1_PF1
 stx Playfield_Color3_PF3
c18 lda #$38
c19 ldx #$24
c20 ldy #$2A
 sta $d40a                   ;line=96
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
 lda #$30
 sta Missiles_Size
 lda #$77
 sta Player2_PositionX
;--
 lda #$58
 sta Player3_PositionX
 lda #$99
 sta Missile2_PositionX
 lda #$95
 sta Missile3_PositionX
c21 lda #$1C
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3
;--
 lda #$59
 sta $d40a                   ;line=97
 sta Player3_PositionX
 lda #$79
 sta $d40a                   ;line=98
 sta Player2_PositionX
 lda #$77
 ldx #$58
 sta $d40a                   ;line=99
 sta Player2_PositionX
 stx Player3_PositionX
 lda #$98
 sta $d40a                   ;line=100
 sta Missile2_PositionX
 sta $d40a                   ;line=101
 sta $d40a                   ;line=102
 sta $d40a                   ;line=103
 lda #$78
 sta $d40a                   ;line=104
 sta Player2_PositionX
 sta $d40a                   ;line=105
 sta $d40a                   ;line=106
 lda #$77
 sta $d40a                   ;line=107
 sta Player2_PositionX
 lda #$99
 sta $d40a                   ;line=108
 sta Missile2_PositionX
 sta $d40a                   ;line=109
 sta $d40a                   ;line=110
 lda #$56
 sta $d40a                   ;line=111
 sta Player3_PositionX
 sta $d40a                   ;line=112
 lda #$58
 sta $d40a                   ;line=113
 sta Player3_PositionX
 sta $d40a                   ;line=114
 sta $d40a                   ;line=115
 sta $d40a                   ;line=116
 sta $d40a                   ;line=117
 sta $d40a                   ;line=118
 sta $d40a                   ;line=119
 lda #$57
 sta $d40a                   ;line=120
 sta Player3_PositionX
 sta $d40a                   ;line=121
 lda #$58
 sta $d40a                   ;line=122
 sta Player3_PositionX
 sta $d40a                   ;line=123
 sta $d40a                   ;line=124
 sta $d40a                   ;line=125
 sta $d40a                   ;line=126
 sta $d40a                   ;line=127
 lda #$57
 ldx #$38
 ldy #$79
 sta $d40a                   ;line=128
 sta Player2_PositionX
 stx Player3_PositionX
 sty Missile2_PositionX
 lda #$75
 sta Missile3_PositionX
c22 lda #$48
c23 ldx #$74
c24 ldy #$0A
 sta $d40a                   ;line=129
 sta Playfield_Color0_PF0
 stx Playfield_Color1_PF1
 sty Playfield_Color2_PF2
 mwa #null null+1
 jmp null

;--

nmi bit $d40f
 bpl vbl

dliv jmp dliQ

vbl pha			;przerwanie VBL *- VBL routine
; txa
; pha
; tya
; pha
 sta $d40f		;reset znacznika przerwania $d40f

 mwa #ant $d402		;adres programu ANTICA ($d402,$d403)
 mva #scr40 $d400	;ustawienie szerokosci obrazu $d400

;-- init pierwszej linii

 lda >fnt+$400*$00
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$C8
 sta Playfield_Color0_PF0
c2 lda #$B4
 sta Playfield_Color1_PF1
c3 lda #$EA
 sta Playfield_Color2_PF2
c4 lda #$00
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$03
 sta Player2_Size
 sta Player3_Size
 lda #$00
 sta Missiles_Size
 lda #$5F
 sta Player2_PositionX
 lda #$7F
 sta Player3_PositionX
 lda #$68
 sta Missile2_PositionX
c5 lda #$0C
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3
 lda #$03
 sta Player0_Size
 sta Player1_Size
 lda #$59
 sta Player0_PositionX
 lda #$A9
 sta Player1_PositionX
 lda #$5C
 sta Missile0_PositionX
 lda #$9D
 sta Missile3_PositionX
c6 lda #$0C
 sta Player0_Missile0_Color0_PM0
 sta Player1_Missile1_Color1_PM1

 mwa #dli1 null+1	;odpalamy synchro pierwszej linii

;-- tutaj miejsce na twoja procedurke, tylko zachowaj wartosci rejestrow X i Y
;*- this area is for yours routine, register X,Y must survive

; pla
; tay
; pla
; tax
 pla
dliQ rti

;--
 org $3000
text  ins 'texts_all.scr'

;-- ANTIC PROGRAM
 org $3600
ant dta $44,a(text)
 dta 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
 dta $41,a(ant)

;-- FONTS
 org $3800
fnt ins 'texts_all.fnt'

;--
 org pmBase+$300
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$10,$10,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$10,$00,$20,$00,$00,$00,$00,$00,$00
 dta $20,$00,$00,$00,$00,$00,$00,$00,$81,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$01,$01,$62,$20,$80,$00,$10,$00,$20,$00,$00
 dta $02,$10,$10,$00,$00,$00,$00,$00,$10,$20,$30,$20,$10,$00,$00,$00
 dta $00,$00,$20,$00,$00,$00,$00,$10,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$04,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$20,$02,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$88,$CC,$88,$44,$00,$00,$00
 dta $20,$00,$88,$00,$00,$00,$00,$04,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$00,$02,$02,$00,$00,$20,$00,$00,$00
 dta $02,$00,$00,$00,$00,$00,$00,$00,$44,$44,$CC,$44,$44,$00,$00,$00
 dta $20,$00,$88,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$44,$CC,$CC,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$8C,$CC,$44,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$40,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$CC,$CC,$44,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$21,$03,$02,$00,$00,$00,$00,$00,$00
 dta $02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 run main

 opt l-
 icl 'xasm.mac'