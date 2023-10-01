
scr40   	equ %00111110	;obraz normalny	*-screen 40b
pmBase_Text	equ $f000+$300

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


rejA    equ $80
rejX    equ rejA+1
rejY    equ rejX+1


;-- MAIN PROGRAM
 org $2000

main
;-- init PMG
 mva >pmBase_Text $d407	;PMCTL - wyswietlac duchy i pociski
 mva #3 $d01d		;PMCTL - show PMG

 lda 20			;czekamy 1 ramke zanim zrobimy jakies nieszczescie :)
 cmp 20			*- wait 1 frame
 beq *-2

 sei			;wylaczenie przerwan *- IRQ OFF, NMI OFF
 mva #0 $d40e
 mva #$fe $d301		;wylaczenie ROM-u *- ROM OFF

 mwa #nmi $fffa		;nasza nowa obsluga przerwania NMI

 mva #$c0 $d40e		;wlaczenie NMI z przerwaniami DLI

 jsr clr_pmg

?ofs = 48

 ldy #0
copy
.rept 5
	lda pmg+.r*$100,y
	sta pmBase_Text+.r*$100+?ofs,y
.endr

 iny
 cpy #256-?ofs
 bne copy

null jmp null


.proc clr_pmg
 ldy #0
 tya
clr
.rept 5
 sta pmBase_Text+.r*$100,y
.endr

 iny
 bne clr
 
 rts
.endp

;--

;-- dli program

dli1
 sta rejA
 
 lda #$83
 sta $d40a                   ;line=64
 sta Missile2_PositionX
 sta $d40a                   ;line=65
 sta $d40a                   ;line=66
 sta $d40a                   ;line=67
 lda #$6E
 sta $d40a                   ;line=68
 sta Missile2_PositionX
; sta $d40a                   ;line=69
; sta $d40a                   ;line=70
; sta $d40a                   ;line=71

 mwa #dli1_2 dliv+1
 rti
 
 
dli1_2
 sta rejA
 stx rejX

; sta $d40a                   ;line=72
; sta $d40a                   ;line=73
; sta $d40a                   ;line=74
; sta $d40a                   ;line=75
; sta $d40a                   ;line=76
; sta $d40a                   ;line=77
; sta $d40a                   ;line=78
; sta $d40a                   ;line=79
 lda #$83
 sta $d40a                   ;line=80
 sta Missile2_PositionX
 sta $d40a                   ;line=81
 lda #$7A
 ldx #$6F
 sta $d40a                   ;line=82
 sta Player1_PositionX
 stx Missile2_PositionX
 sta $d40a                   ;line=83
 sta $d40a                   ;line=84
 lda #$01
 ldx #$84
 sta $d40a                   ;line=85
 sta Player1_Size
 stx Player1_PositionX
; sta $d40a                   ;line=86
; sta $d40a                   ;line=87

 mwa #dli1_3 dliv+1
 lda rejA
 ldx rejX
 rti
 


dli1_3 
 sta rejA
 
; sta $d40a                   ;line=88
; sta $d40a                   ;line=89
; sta $d40a                   ;line=90
; sta $d40a                   ;line=91
; sta $d40a                   ;line=92
; sta $d40a                   ;line=93
; sta $d40a                   ;line=94
; sta $d40a                   ;line=95
 sta $d40a                   ;line=96
 sta $d40a                   ;line=97
 sta $d40a                   ;line=98
 sta $d40a                   ;line=99
 lda #$70
 sta $d40a                   ;line=100
 sta Missile2_PositionX
; sta $d40a                   ;line=101
; sta $d40a                   ;line=102
; sta $d40a                   ;line=103

 mwa #dli1_4 dliv+1
 lda rejA
 rti
 
 
dli1_4
 sta rejA
 
 sta $d40a                   ;line=104
 lda #$6D
 sta $d40a                   ;line=105
 sta Missile2_PositionX
; sta $d40a                   ;line=106
; sta $d40a                   ;line=107
; sta $d40a                   ;line=108
; sta $d40a                   ;line=109
; sta $d40a                   ;line=110
; sta $d40a                   ;line=111

 mwa #dli1_5 dliv+1
 lda rejA
 rti



dli1_5
 sta rejA
 stx rejX
 sty rejY
 
; sta $d40a                   ;line=112
; sta $d40a                   ;line=113
; sta $d40a                   ;line=114
; sta $d40a                   ;line=115
; sta $d40a                   ;line=116
; sta $d40a                   ;line=117
; sta $d40a                   ;line=118
; sta $d40a                   ;line=119
 sta $d40a                   ;line=120
 sta $d40a                   ;line=121
 sta $d40a                   ;line=122
 sta $d40a                   ;line=123
 sta $d40a                   ;line=124
 lda #$39
c8 ldx #$0C
 sta $d40a                   ;line=125
 sta Player2_PositionX
 stx Player2_Missile2_Color2_PM2
 sta $d40a                   ;line=126
 sta $d40a                   ;line=127

 sta $d40a                   ;line=128
 lda #$9D
 sta $d40a                   ;line=129
 sta Missile3_PositionX
 sta $d40a                   ;line=130
 sta $d40a                   ;line=131
 lda #$03
c9 ldx #$0C
 sta $d40a                   ;line=132
 sta Player1_Size
 stx Player1_Missile1_Color1_PM1
 sta $d40a                   ;line=133
 sta $d40a                   ;line=134
 sta $d40a                   ;line=135
c10 lda #$0C
 sta $d40a                   ;line=136
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=137
 lda #$03
 ldx #$A9
 ldy #$89
 sta $d40a                   ;line=138
 sta Player3_Size
 stx Player1_PositionX
 sty Player3_PositionX
 
 mwa #dli2 dliv+1
 lda rejA
 ldx rejX
 ldy rejY
 rti



dli2
 sta rejA
 stx rejX
 sty rejY

 lda >fnt+$400*$01
c11 ldx #$6A
c12 ldy #$84
 sta $d40a                   ;line=144
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
c13 lda #$78
 sta Playfield_Color2_PF2
 sta $d40a                   ;line=145
 sta $d40a                   ;line=146
 sta $d40a                   ;line=147
 lda #$58
 ldx #$A8
 ldy #$38
 sta $d40a                   ;line=148
 sta Player0_PositionX
 stx Player1_PositionX
 sty Player2_PositionX
 lda #$88
 sta Player3_PositionX
 sta $d40a                   ;line=149
 sta $d40a                   ;line=150
 sta $d40a                   ;line=151
 sta $d40a                   ;line=152
 sta $d40a                   ;line=153
 sta $d40a                   ;line=154
 sta $d40a                   ;line=155
 
 
 lda #$87
 ldx #$5F
 ldy #$64
 sta $d40a                   ;line=156
 sta Player3_PositionX
 stx Missile0_PositionX
 sty Missile3_PositionX
 sta $d40a                   ;line=157
 sta $d40a                   ;line=158
 lda #$54
 sta $d40a                   ;line=159
 sta Missile2_PositionX
 sta $d40a                   ;line=160
 sta $d40a                   ;line=161
 lda #$A0
 sta $d40a                   ;line=162
 sta Missile2_PositionX
 lda #$60
 sta $d40a                   ;line=163
 sta Missile0_PositionX
 lda #$39
 sta $d40a                   ;line=164
 sta Player2_PositionX
 sta $d40a                   ;line=165
 sta $d40a                   ;line=166
 sta $d40a                   ;line=167
 lda #$37
 sta $d40a                   ;line=168
 sta Player2_PositionX
 lda #$C4
 sta $d40a                   ;line=169
 sta Missile2_PositionX
 
 lda rejA
 ldx rejX
 ldy rejY
 rti


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
c1 lda #$1A
 sta Playfield_Color0_PF0
c2 lda #$E4
 sta Playfield_Color1_PF1
c3 lda #$F8
 sta Playfield_Color2_PF2
c4 lda #$14
 sta Playfield_Color3_PF3
 
 lda #$04
 sta PRIOR_GTIACTL

 lda #$03
 sta Player0_Size
 sta Player2_Size
 
 lda #$00
 sta Player3_Size
 sta Missiles_Size
 sta Player1_Size
  
 lda #$59
 sta Player0_PositionX
 lda #$91
 sta Player1_PositionX
 lda #$67
 sta Player2_PositionX
 lda #$79
 sta Player3_PositionX
 lda #$5C
 sta Missile0_PositionX
 lda #$7F
 sta Missile2_PositionX
 lda #$72
 sta Missile3_PositionX
 
c5 lda #$0C
 sta Player0_Missile0_Color0_PM0
c6 lda #$1C
 sta Player1_Missile1_Color1_PM1
 sta Player2_Missile2_Color2_PM2
c7 lda #$14
 sta Player3_Missile3_Color3_PM3

 mwa #dli1 dliv+1	;DLI ustawiamy na poczatek

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
text
 ins 'Over.scr',6*40,12*40
 ins 'texts_all.scr',8*40,4*40

;-- ANTIC PROGRAM
 org $3600
ant dta d'pppppp'
 dta $44,a(text)
 dta $84,4,$84,4,$84,$84,4,$84,4,4,$84,4,4,4,$84,4,4,4,4,4,4,4,4
 dta $41,a(ant)

;-- FONTS
 org $3800
fnt
 ins 'Over.fnt',0,1024
 ins 'texts_all.fnt'

;--
pmg
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$20,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$20,$00,$00,$00,$10,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$20,$00,$20,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$10,$00,$00,$00
 dta $00,$20,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$81,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$01,$01,$62,$20,$80,$00,$10,$00,$20,$00,$00
 dta $02,$10,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$10,$08,$04,$0E,$14,$08,$10,$00,$00,$40,$00,$00,$02,$02,$03
 dta $0B,$09,$12,$08,$24,$22,$42,$01,$13,$33,$62,$22,$00,$00,$00,$00
 dta $00,$08,$08,$04,$4C,$0C,$08,$08,$00,$00,$00,$00,$00,$00,$00,$00
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

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$04,$04,$04,$04,$04,$04,$04
 dta $00,$00,$00,$00,$00,$08,$0A,$0A,$0E,$4A,$4A,$4A,$40,$40,$40,$40
 dta $00,$00,$10,$10,$10,$1A,$32,$52,$52,$42,$02,$0A,$00,$20,$28,$28
 dta $38,$2C,$28,$2D,$0A,$04,$04,$01,$01,$01,$14,$36,$16,$36,$04,$08
 dta $18,$39,$2D,$29,$29,$09,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$44,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$00,$00,$00,$00,$02,$02,$00,$00,$20,$00,$00,$00
 dta $02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0A
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$40,$88,$CC,$88,$44,$00,$00,$00
 dta $00,$00,$88,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 run main

 opt l-
 icl 'xasm.mac'

