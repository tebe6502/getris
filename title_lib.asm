// wersja do spakowania deflaterem

// adres uruchomienia pod $2400-3

// external declaration (.WORD)
reset_pokey			ext .word
tmc_player.initialization	ext .word
tmc_player.sound		ext .word
tmc_player.play			ext .word
default_nmi			ext .word


// zero page variables
rejA	equ $40
rejX	equ rejA+1
rejY	equ rejX+1
tmp	equ rejY+1
upd	equ tmp+2


// constans
ksywki	equ 7			; liczba ksywek do wyswietlenia

scr40	equ %00111110	        ; obraz normalny *-screen 40b

pmBase	equ $0000

hposp0	equ $D000
hposp1	equ $D001
hposp2	equ $D002
hposp3	equ $D003
hposm0	equ $D004
hposm1	equ $D005
hposm2	equ $D006
hposm3	equ $D007
sizep0	equ $D008
sizep1	equ $D009
sizep2	equ $D00A
sizep3	equ $D00B
sizem	equ $D00C

colpm0	equ $D012
colpm1	equ $D013
colpm2	equ $D014
colpm3	equ $D015
color0	equ $D016
color1	equ $D017
color2	equ $D018
color3	equ $D019
colbak	equ $D01A
gtictl	equ $D01B

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

Playfield_Color0_PF0 equ $d016
Playfield_Color1_PF1 equ $d017
Playfield_Color2_PF2 equ $d018
Playfield_Color3_PF3 equ $d019
Background_BAK       equ $d01a

PRIOR_GTIACTL        equ $d01b
CHARBASE             equ $d409


;-- MAIN PROGRAM
 opt h-
 org $1000

fnt
 ins 'title\Getr4_OK.fnt',0,4096	// 5*1024 bytes
 
 .get 'title\Getr4_logosy.fnt'

 .put [1024-3] = {jmp start} , <start , >start	; JMP START

 .sav 1024

fnt_press
 ins 'title\press.fnt',0,28*8

text
 ins 'title\Getr4_OK.scr',0,13*40

text_credits
 ins 'title\Getr4_logosy.scr',0,7*40

logosy
 ins 'title\Getr4_logosy.scr',7*40,14*40

press
 ins 'title\press.scr'
 
ant
 dta $44+$80,a(text)
 dta $84,4,$84,4,4,4,4,$84,4,4,$84,4,$f0,$20,$42,a(text_credits),2,2,2,2,2,2+$80,$42
log_adr dta a(logosy),2,$f0,$42,a(press),2,2,2,2
 dta $41,a(ant)


pmg_credits
 dta $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0    ;pm0
 dta $C0,$C0,$C0,$C0,$C0,$C0,$C0,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$C0,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$F8,$F8,$F8,$F8,$F8,$F8,$F8,$F8
 dta $F8,$F8,$F8,$F8,$F8,$F8,$F8

 dta $00,$00,$00,$00,$00,$00,$00,$00    ;pm3
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $3F,$3F,$3F,$3F,$3F,$3F,$3F,$3F    ;pm4
 dta $3F,$3F,$3F,$3F,$3F,$3F,$3F,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF

pmg_logo
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$08,$08,$04,$8C,$0C,$0C,$0C,$4D
 dta $00,$00,$00,$00,$00,$00,$00,$00,$40,$70,$70,$D0,$C0,$C0,$E0,$64
 dta $F4,$F4,$F4,$F4,$FC,$DC,$54,$60,$60,$20,$20,$00,$20,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$42,$01,$40,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$04,$00,$08,$10,$00,$40
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$04,$02,$83,$41,$20,$10,$10,$08
 dta $04,$82,$40,$20,$10,$00,$04,$00,$40,$20,$04,$0C,$06,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$02,$0A,$10,$20,$00,$80
 dta $00,$04,$08,$10,$01,$02,$04,$0C,$18,$45,$0A,$47,$0D,$85,$0E,$85
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$80,$80,$80,$80,$80
 dta $D0,$A0,$DC,$5E,$DC,$2E,$40,$00,$00,$00,$04,$04,$06,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$C0,$C0,$00,$00
 dta $00,$30,$38,$F8,$F8,$F8,$F0,$60,$42,$02,$02,$06,$06,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$40,$A0,$40,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$40,$40,$40,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$40,$00,$40,$40,$80,$80,$80,$82,$82
 dta $80,$80,$82,$87,$87,$07,$0F,$3F,$7E,$6C,$6E,$6E,$6E,$6E,$4E,$4E
 dta $4C,$8C,$44,$04,$00,$00,$00,$00,$00,$00,$1C,$04,$01,$04,$41,$12
 dta $07,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; tmc_relocator 'title\forever.tm8' , title_msx
; .sav [6] length

main

 jsr reset_pokey

// czyscimy pmBase
 ldy #0
 tya

clr
.rept 5
 sta pmBase+$300+.r*$100,y
.endr
 iny
 bne clr

// skopiowanie danych PMG pod adres pmBase
 ldy #95

?ofs = 0

.local
copy
.rept 5
	lda pmg_logo+.r*96,y 
	sta pmBase+$300+?ofs+.r*$100,y
.endr

 dey
 bpl copy
.endl

 .put = 0,3,4

 ldy #62

?ofs = 128+3+8-8

.local
copy
.rept 3
	lda pmg_credits+.r*63,y
	sta pmBase+$300+?ofs+.get[.r]*$100,y
.endr
	
 dey
 bpl copy
.endl

 jsr fade.save_color

 jsr tmc_player.initialization
 
 lda:rne $d40b

;-- init PMG
 mva >pmBase $d407	;PMCTL - wyswietlac duchy i pociski
 mva #3 $d01d		;PMCTL - show PMG

 mwa #nmi $fffa
 mva #$c0 $d40e

 ldx <fade.fade_in
 ldy >fade.fade_in
 jsr fade.fade


loop
;        lda:cmp:req 20
;        jsr tmc_player.play

 play 20+32
 play 76+16


.local logos

_fad lda #$ff
 bne _cnt2

_idx ldx #0
 lda tfad,x
 sta c7+1
 bne skp

 ldy _log
 lda tlog_l,y
 sta log_adr
 lda tlog_h,y
 sta log_adr+1 

 inc _log
 lda _log 
 cmp #ksywki
 bne skp

 lda #0
 sta _log

skp
 inc _idx+1
 cpx #25-1
 bne _skp

 stx _fad+1
 jmp _skp
 

_cnt2
 inw _cnt
 lda _cnt+1
 cmp #1
 bne _skp

 lda #0
 sta _cnt
 sta _cnt+1
 sta _fad+1
 sta _idx+1

_skp

.endl


 lda $d01f
 cmp #%011	; OPTION
 beq quit

 cmp #%110	; START
 beq quit

 lda $d010
 bne loop

quit

 sta console

 lda #{nop}
 sta nmi.player
 sta nmi.player+1
 sta nmi.player+2

 jsr reset_pokey

 ldx <fade.fade_out
 ldy >fade.fade_out
 jsr fade.fade


 lda:rne $d40b

 jsr default_nmi

 lda #%111
console equ *-1
 rts


_cnt .word
_log dta 1
tfad dta $c,$b,$a,9,8,7,6,5,4,3,2,1,0,1,2,3,4,5,6,7,8,9,$a,$b,$c

tlog_l
.rept ksywki
 dta l(logosy+.r*80)
.endr

tlog_h
.rept ksywki
 dta h(logosy+.r*80)
.endr


.local fade
	icl 'title\getr4.fad'
.endl


.proc	wait
 lda:cmp:req 20
 dex
 bne wait
 rts
.endp

	?old_dli = *
dli1

; sta $d40a                   ;line=0
; sta $d40a                   ;line=1
; sta $d40a                   ;line=2
; sta $d40a                   ;line=3
; sta $d40a                   ;line=4
; sta $d40a                   ;line=5
; sta $d40a                   ;line=6
; sta $d40a                   ;line=7

 sta $d40a                   ;line=8
 lda #$42
; sta $d40a                   ;line=9
 sta Player1_PositionX
; sta $d40a                   ;line=10
; sta $d40a                   ;line=11
; sta $d40a                   ;line=12
; sta $d40a                   ;line=13
; sta $d40a                   ;line=14
; sta $d40a                   ;line=15

 dli_quit dli1_2
 

dli1_2
 sta $d40a                   ;line=16
 lda #$3F
 sta $d40a                   ;line=17
 sta Player1_PositionX
 lda #$6C
 sta $d40a                   ;line=18
 sta Missile1_PositionX
 lda #$3D
 ldx #$74
 ldy #$6E
 sta $d40a                   ;line=19
 sta Player1_PositionX
 stx Player3_PositionX
 sty Missile1_PositionX
c9 lda #$68
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=20
 lda #$3C
 ldx #$6F
 ldy #$6D
 sta $d40a                   ;line=21
 sta Player1_PositionX
 stx Missile1_PositionX
 sty Missile3_PositionX
 lda #$70
 sta $d40a                   ;line=22
 sta Missile1_PositionX
c10 lda #$7A
 ldx #$3A
 ldy #$71
 sta $d40a                   ;line=23
 sta Playfield_Color2_PF2
 stx Player1_PositionX
 sty Missile1_PositionX
 lda >fnt+$400*$01
c11 ldx #$54
c12 ldy #$68
 sta $d40a                   ;line=24
 sta CHARBASE
 stx Playfield_Color0_PF0
 sty Playfield_Color1_PF1
 lda #$3C
 sta Player1_PositionX
 lda #$6B
 sta $d40a                   ;line=25
 sta Missile1_PositionX
c13 lda #$0C
 sta $d40a                   ;line=26
 sta Player1_Missile1_Color1_PM1
 lda #$03
 ldx #$37
 sta $d40a                   ;line=27
 sta Player1_Size
 stx Player1_PositionX
 sta $d40a                   ;line=28
 lda #$FC
 ldx #$54
 ldy #$9B
 sta $d40a                   ;line=29
 sta Missiles_Size
 stx Missile1_PositionX
 sty Missile3_PositionX
c14 lda #$0C
 sta Player3_Missile3_Color3_PM3
; sta $d40a                   ;line=30
; sta $d40a                   ;line=31

 dli_quit dli1_3


dli1_3 
 sta $d40a                   ;line=32
 sta $d40a                   ;line=33
 lda #$5A
 sta $d40a                   ;line=34
 sta Player0_PositionX
 lda #$76
 ldx #$9D
 sta $d40a                   ;line=35
 sta Player3_PositionX
 stx Missile3_PositionX
 sta $d40a                   ;line=36
 sta $d40a                   ;line=37
 lda #$5C
 sta $d40a                   ;line=38
 sta Missile2_PositionX
 sta $d40a                   ;line=39
 lda #$35
 ldx #$75
 ldy #$9E
 sta $d40a                   ;line=40
 sta Player1_PositionX
 stx Player3_PositionX
 sty Missile3_PositionX
 lda #$38
 sta $d40a                   ;line=41
 sta Player1_PositionX
 lda #$01
 ldx #$39
 ldy #$9F
 sta $d40a                   ;line=42
 sta Player1_Size
 stx Player1_PositionX
 sty Missile3_PositionX
 lda #$74
 sta $d40a                   ;line=43
 sta Player3_PositionX
 sta $d40a                   ;line=44
 lda #$A0
 sta $d40a                   ;line=45
 sta Missile3_PositionX
 lda #$52
 ldx #$A1
 sta $d40a                   ;line=46
 sta Missile1_PositionX
 stx Missile3_PositionX
 lda #$01
 ldx #$83
 ldy #$55
 sta $d40a                   ;line=47
 sta Player3_Size
 stx Player3_PositionX
 sty Missile2_PositionX
 lda >fnt+$400*$02
 ldx #$8F
 sta $d40a                   ;line=48
 sta CHARBASE
 stx Missile0_PositionX
 sta $d40a                   ;line=49
 lda #$82
 sta $d40a                   ;line=50
 sta Player3_PositionX
 sta $d40a                   ;line=51
 sta $d40a                   ;line=52
 sta $d40a                   ;line=53
 sta $d40a                   ;line=54
 sta $d40a                   ;line=55
 lda #$00
 ldx #$62
c15 ldy #$68
 sta $d40a                   ;line=56
 sta Player2_Size
 stx Player2_PositionX
 sty Player2_Missile2_Color2_PM2
 sta $d40a                   ;line=57
 lda #$3C
 ldx #$A6
 sta $d40a                   ;line=58
 sta Missiles_Size
 stx Missile3_PositionX
 sta $d40a                   ;line=59
 sta $d40a                   ;line=60
c16 lda #$54
 sta $d40a                   ;line=61
 sta Player3_Missile3_Color3_PM3
 sta $d40a                   ;line=62
 sta $d40a                   ;line=63
c17 lda #$14
 sta $d40a                   ;line=64
 sta Playfield_Color0_PF0
 lda #$00
 ldx #$8B
c18 ldy #$68
 sta $d40a                   ;line=65
 sta Player3_Size
 stx Player3_PositionX
 sty Player3_Missile3_Color3_PM3
c19 lda #$26
c20 ldx #$FA
 ldy #$85
 sta $d40a                   ;line=66
 sta Playfield_Color1_PF1
 stx Playfield_Color2_PF2
 sty Missile3_PositionX
c21 lda #$68
 sta Player0_Missile0_Color0_PM0
 sta $d40a                   ;line=67
 sta $d40a                   ;line=68
 sta $d40a                   ;line=69
 lda #$61
 sta $d40a                   ;line=70
 sta Player0_PositionX
 
 dli_quit dli2

 

dli2
 lda >fnt+$400*$03
 sta $d40a                   ;line=72
 sta CHARBASE
 sta $d40a                   ;line=73
 sta $d40a                   ;line=74
 sta $d40a                   ;line=75
 sta $d40a                   ;line=76
 sta $d40a                   ;line=77
 sta $d40a                   ;line=78
 sta $d40a                   ;line=79
 lda #$67
 sta $d40a                   ;line=80
 sta Player0_PositionX

 dli_quit dli3
 

dli3
 lda >fnt+$400*$04
 sta $d40a                   ;line=96
 sta CHARBASE

 dli_quit dli4


dli4

c2 lda #$00
c3 ldx #$08
 sta $d40a                   ;line=104
 sta color0
 sta color1
 stx color2
 sta color3

 lda #$01
 sta gtictl
 lda #$03
 sta sizep2
 sta sizep3
 lda #$FC
 sta sizem
 lda #$A4
 sta hposp2
 lda #$7C
 sta hposp3
 lda #$CC
 sta hposm1
 lda #$C4
 sta hposm2
 lda #$9C
 sta hposm3

c6 lda #$0C
 sta colpm3
 sta colpm2

 dli_quit dli5


dli5
c7 lda #$0C
 sta $d40a
 sta colpm1
 sta colpm2
 sta colpm3

 dli_quit dli6


dli6
 lda >fnt_press
c30 ldx #$0e
 ldy #$00
 sta $d40a
 sta CHARBASE
 stx $d017
 sty $d018

 jmp nmi.quit


;--

.proc nmi

 sta rejA
 stx rejX
 sty rejY

 bit $d40f
 bpl vbl

dliv jmp dli1

vbl
 sta $d40f		;reset znacznika przerwania $d40f

 inc 20

 mwa #ant $d402		;adres programu ANTICA ($d402,$d403)
 mva #scr40 $d400	;ustawienie szerokosci obrazu $d400

;-- init pierwszej linii

 lda >fnt
 sta CHARBASE
c0 lda #$00
 sta Background_BAK
c1 lda #$14
 sta Playfield_Color0_PF0
c2 lda #$26
 sta Playfield_Color1_PF1
c3 lda #$FA
 sta Playfield_Color2_PF2
c4 lda #$54
 sta Playfield_Color3_PF3
 lda #$04
 sta PRIOR_GTIACTL
 lda #$00
 sta Player0_Size
 sta Player1_Size
 lda #$01
 sta Player2_Size
 lda #$03
 sta Player3_Size
 lda #$34
 sta Missiles_Size
 lda #$3F
 sta Player0_PositionX
 lda #$49
 sta Player1_PositionX
 lda #$B9
 sta Player2_PositionX
 lda #$72
 sta Player3_PositionX
 sta Missile0_PositionX
 lda #$6B
 sta Missile1_PositionX
 lda #$5E
 sta Missile2_PositionX
 lda #$6A
 sta Missile3_PositionX
c5 lda #$7A
 sta Player0_Missile0_Color0_PM0
c6 lda #$68
 sta Player1_Missile1_Color1_PM1
c7 lda #$0C
 sta Player2_Missile2_Color2_PM2
c8 lda #$FA
 sta Player3_Missile3_Color3_PM3

 mwa #dli1 dliv+1	;DLI ustawiamy na poczatek

player jsr tmc_player.play

quit
 lda rejA
 ldx rejX
 ldy rejY
 rti

.endp


/*
  Aktualizacja adresow, wg kolejnosci deklaracji

reset_pokey			ext .word
tmc_player.initialization	ext .word
tmc_player.sound		ext .word
tmc_player.play			ext .word
default_nmi			ext .word

$FFEE,type(byte),count(word),length_label(word),label(text),address...

*/
start
 stx _word+1
 sty _word+2

 mwa #update upd

 jsr _upd	; reset_pokey
 jsr _upd	; tmc_player.initialization
 jsr _upd	; tmc_player.sound
 jsr _upd	; tmc_player.play
 jsr _upd	; default_nmi

;kk lda $d20a
; sta $d01a
; jmp kk
 
 jmp main


_upd
 ldy #6
_cp
 lda (upd),y
 sta __tmp,y
 dey
 bpl _cp

 lda #7		; omijamy 7 bajtow naglowka + dlugosc etykiety
 clc
 adc __tmp+5
 jsr add_upd

 ldx __tmp+3

_rep
 ldy #3-1
__cp
 lda (upd),y
 sta __tmp,y
 dey
 bpl __cp

 lda #3
 jsr add_upd

 mwa __tmp+1 tmp

 ldy #0
 jsr _word
 sta (tmp),y

 iny
 jsr _word
 sta (tmp),y

 dex
 bne _rep

 inw _word+1
 inw _word+1
 rts

_word lda $ffff,y
 rts


add_upd
 clc
 adc upd
 sta upd
 scc
 inc upd+1

 ldy #0
 rts


__tmp :7 brk

update

;---
        opt l-

.macro dli_quit

 .if .hi(?old_dli)==.hi(:1)
   mva <:1 nmi.dliv+1
 .else
   mwa #:1 nmi.dliv+1
 .endif

  jmp nmi.quit

  ?old_dli = *
.endm


.macro	play

wait    lda $d40b
        cmp #:1
        bne wait

;        lda #:1*2
;        sta $d01a

	jsr tmc_player.sound

;	lda #0
;	sta $d01a
.endm

	icl 'xasm.mac'

        opt l+

;---
; run main

	blk update external
