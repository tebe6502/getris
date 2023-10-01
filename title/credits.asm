;-- Use X-ASM or MADS for compile this source code
;--
;-- Graph2Font - TeBe(Tomasz Biela) / Madteam
;-- DLI (char mode)
;--
;-- Uwaga! Przerwania DLI nie zapamietuja i nie zwracaja zawartosci
;--        rejestrow AXY, dla wiekszej szybkosci dokonywania zmian w linii
;--


scr48	equ %00111111	;obraz szeroki	*-screen 48b
scr40	equ %00111110	;obraz normalny	*-screen 40b
scr32	equ %00111101	;obraz waski	*-screen 32b
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

 lda >fnt
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$08
 sta Playfield_Color0_PF0
c2 lda #$00
 sta Playfield_Color1_PF1
c3 lda #$06
 sta Playfield_Color2_PF2
c4 lda #$0E
 sta Playfield_Color3_PF3
 lda #$01
 sta PRIOR_GTIACTL
 sta Player1_Size
 sta Player2_Size
 lda #$03
 sta Player3_Size
 lda #$FC
 sta Missiles_Size
 lda #$83
 sta Player1_PositionX
 lda #$7F
 sta Player2_PositionX
 lda #$84
 sta Player3_PositionX
 lda #$93
 sta Missile1_PositionX
 lda #$98
 sta Missile2_PositionX
 lda #$7C
 sta Missile3_PositionX
c5 lda #$0C
 sta Player1_Missile1_Color1_PM1
c6 lda #$0A
 sta Player2_Missile2_Color2_PM2
c7 lda #$08
 sta Player3_Missile3_Color3_PM3

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
text  ins 'credits.scr'

;-- ANTIC PROGRAM
 org $3600
ant dta $42,a(text)
 dta 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
 dta $41,a(ant)

;-- FONTS
 org $3800
fnt ins 'credits.fnt'

;--
 org pmBase+$300
 dta $00,$00,$00,$00,$00,$00,$00,$00,$7C,$7C,$7C,$7C,$7C,$7C,$7C,$7C
 dta $7C,$7C,$7C,$7C,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
 dta $FC,$FC,$FC,$FC,$FC,$FC,$FC,$C0,$C0,$FC,$FC,$FC,$FC,$FC,$FC,$FC
 dta $FC,$FC,$FC,$FC,$FC,$FC,$F0,$F0,$F0,$FC,$FC,$FC,$FC,$FC,$FC,$FC
 dta $FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC,$FC
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 org *+$100
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$BF,$00,$00,$3F,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
 dta $C0,$C0,$C0,$C0,$C0,$C0,$C0,$00,$00,$F0,$F0,$C0,$C0,$C0,$C0,$C0
 dta $C0,$C0,$C0,$C0,$FC,$FC,$FF,$80,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
 dta $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 run main
