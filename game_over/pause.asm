
scr32	        equ %00111101	;obraz waski	*-screen 32b
pmBase_Text     equ $f000+$300

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

rejA equ $80
rejX equ rejA+1
rejY equ rejX+1


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
 
 ldy #26
copy
 lda pmg,y
 sta pmBase_Text+112,y
 lda pmg+27,y
 sta pmBase_Text+$300+112,y
 lda pmg+27*2,y
 sta pmBase_Text+$400+112,y
 dey
 bpl copy
 
null jmp null


.proc clr_pmg
 ldy #0
 tya
clr
 sta pmBase_Text,y
 sta pmBase_Text+$100,y
 sta pmBase_Text+$200,y
 sta pmBase_Text+$300,y
 sta pmBase_Text+$400,y
 iny
 bne clr
 
 rts
.endp


;--

dli1
 sta rejA
 stx rejX
 sty rejY

 sta $d40a                   ;line=104
 lda #$59
 sta $d40a                   ;line=105
 sta Player3_PositionX
 lda #$79
 sta $d40a                   ;line=106
 sta Player2_PositionX
 lda #$77
 ldx #$58
 sta $d40a                   ;line=107
 sta Player2_PositionX
 stx Player3_PositionX
 lda #$98
 sta $d40a                   ;line=108
 sta Missile2_PositionX
 sta $d40a                   ;line=109
 sta $d40a                   ;line=110
 sta $d40a                   ;line=111
 lda #$78
 sta $d40a                   ;line=112
 sta Player2_PositionX
 sta $d40a                   ;line=113
 sta $d40a                   ;line=114
 lda #$77
 sta $d40a                   ;line=115
 sta Player2_PositionX
 lda #$99
 sta $d40a                   ;line=116
 sta Missile2_PositionX
 sta $d40a                   ;line=117
 sta $d40a                   ;line=118
 lda #$56
 sta $d40a                   ;line=119
 sta Player3_PositionX
 sta $d40a                   ;line=120
 lda #$58
 sta $d40a                   ;line=121
 sta Player3_PositionX
 sta $d40a                   ;line=122
 sta $d40a                   ;line=123
 sta $d40a                   ;line=124
 sta $d40a                   ;line=125
 sta $d40a                   ;line=126
 sta $d40a                   ;line=127
 lda #$57
 sta $d40a                   ;line=128
 sta Player3_PositionX
 sta $d40a                   ;line=129
 lda #$58
 sta $d40a                   ;line=130
 sta Player3_PositionX
 sta $d40a                   ;line=131
 sta $d40a                   ;line=132
 sta $d40a                   ;line=133
 sta $d40a                   ;line=134
 sta $d40a                   ;line=135
 lda #$57
 ldx #$38
 ldy #$79
 sta $d40a                   ;line=136
 sta Player2_PositionX
 stx Player3_PositionX
 sty Missile2_PositionX
 lda #$75
 sta Missile3_PositionX
 
 lda rejA
 ldx rejX
 ldy rejY
 rti
 
;--

nmi bit $d40f
 bpl vbl

dliv jmp dli1

vbl pha			;przerwanie VBL *- VBL routine
; txa
; pha
; tya
; pha
 sta $d40f		;reset znacznika przerwania $d40f

 mwa #ant $d402		;adres programu ANTICA ($d402,$d403)
 mva #scr32 $d400	;ustawienie szerokosci obrazu $d400

;-- init pierwszej linii

 lda >fnt+$400*$00
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$38
 sta Playfield_Color0_PF0
c2 lda #$24
 sta Playfield_Color1_PF1
c3 lda #$2A
 sta Playfield_Color2_PF2
c4 lda #$00
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$03
 sta Player2_Size
 sta Player3_Size
 lda #$30
 sta Missiles_Size
 lda #$77
 sta Player2_PositionX
 lda #$58
 sta Player3_PositionX
 lda #$99
 sta Missile2_PositionX
 lda #$95
 sta Missile3_PositionX
c5 lda #$1C
 sta Player2_Missile2_Color2_PM2
 sta Player3_Missile3_Color3_PM3

 mwa #dli1 dliv+1	;odpalamy synchro pierwszej linii

;-- tutaj miejsce na twoja procedurke, tylko zachowaj wartosci rejestrow X i Y
;*- this area is for yours routine, register X,Y must survive

; pla
; tay
; pla
; tax
 pla
 rti

;--
 org $3000
text
 ins 'texts_all.scr',12*40+4,32
 ins 'texts_all.scr',13*40+4,32
 ins 'texts_all.scr',14*40+4,32
 ins 'texts_all.scr',15*40+4,32

;-- ANTIC PROGRAM
 org $3600
ant
 dta d'pppppppppppp',$f0,$44,a(text),4,4,4
 dta $41,a(ant)

;-- FONTS
 org $3800
fnt ins 'texts_all.fnt'

;--
pmg
 dta $10,$20,$30,$20,$10,$00,$00,$00,$00,$00,$20,$00,$00,$00,$00,$10
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80
 
 dta $44,$44,$CC,$44,$44,$00,$00,$00,$20,$00,$88,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 
 dta $44,$CC,$CC,$44,$44,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00,$21
 dta $03,$02,$00,$00,$00,$00,$00,$00,$02,$00,$00

 run main

 opt l-
 icl 'xasm.mac'