/*
 Getris v2.0
 by Tomasz Biela (Tebe/Madteam)
 changes: 25.02.2006
 
 Opis rozgrywki:
 - zaczynamy od poziomu = 0, opoznienie dla spadajacych klockow to 8fps
 - aby przejsc na nastepny poziom musimy usunac 8 poziomych linii
 - z kazdym nowym poziomem liczba poziomych linii do usuniecia zwiekszana jest o 2, a opoznienie zmniejszane o 1 (min=2fps)
 - maksymalna liczba linii poziomych do usuniecia ograniczona jest do 16

 Punktacja:
 - za kazdy upuszczony klocek dostajemy 10pkt * numer_poziomu
 - za usuniecie linii poziomej dostajemy 100pkt

 Banki pamieci:
 - bank #1  over_msx ($4000..$4FFF), title_intro ($5000..$7FFF)
 - bank #2  muza z ekranu tytulowego
 - bank #3  muzy podczas gry
 - bank #4  mem_backup ($4000..$6FFF)
*/

@TAB_MEM_BANKS	equ $0100
@PROC_ADD_BANK	equ $0400

intro.fade_out	equ $b000		; 'JMP ADDRESS' do procedury wygaszenia ekranu GETRIS LOADING

title_intro.main	equ $2400-3	; adres uruchomienia dla TITLE_INTRO, blok aktualizacji i skok pod MAIN
congrat_intro.main	equ $1000

muza            equ $4000


delay_trig_default_value	equ $ff
delay_joy_default_value		equ 4


max_fps         equ 8           ; maksymalne opoznienie spadajacych klockow = 8
min_fps         equ 2           ; minimalne opoznienie spadajacych klockow = 2

max_line        equ 16          ; maksymalna liczba poziomych linii do usuniecia
min_line	equ 8           ; minimalna liczba poziomych linii do usuniecia

;nowy_klocek	equ 3           ; od ktorego poziomu gry dopuszczac najtrudniejszy klocek (krzyzowy)


scr32	equ %00111101	        ; obraz waski    *-screen 32b
scr40	equ %00111110	        ; obraz normalny *-screen 40b

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

buf		equ $0200           ; bufor tetris'a (width*height) ($d00 bajtow)

fnt_txt1	equ $1000           ; zestaw znakow z grafika GAME OVER
fnt_txt2	equ fnt_txt1+$400   ; zestaw znakow z grafika napisow (well done, pause, game over)

t_satur		equ $c000
pmBase1		equ t_satur+$300    ; pamiec dla PMG1

t_color		equ $c800
pmBase2		equ t_color+$300    ; pamiec dla PMG2

pmBase_Text	equ pmBase2         ; pamiec PMG dla napisow (well done, pause, game over) i High Score

level_gfx	equ $d800           ; grafika licznika leveli (1200 bajtow)
klocki_gfx	equ $dd00           ; wycentrowana grafika klockow dla pola NEXT (648 bajtow)

fnt3_2		equ $e000           ; 2 zestaw znakow dla High Score ($400)
fnt3		equ $e800           ; 1 zestaw znakow dla High Score ($300)


// !!!  FREE $EB00 ...  !!!
free_rom	equ $eb00


klocek_char	equ 107             ; wspolny znak klocka dla wszystkich zestawow znakow
puste_char	equ klocek_char+8   ; wspolny znak pustego klocka dla wszystkich zestawow znakow

rejA	equ $80
rejX	equ rejA+1
rejY	equ rejX+1
tmp	equ rejY+1

zp_free		equ tmp+2

ofset		equ 3

color_l		equ 37


;--- BASIC OFF
 org $2000

 mva #1 82
 mva #$ff $d301
 
 clrscr

; print ' ' 
 print '          GETRIS 25.02.2006'
 print '          -------------------' 
 print ' '
 print '                 CODE                 '*
 print '           Tomasz TEBE Biela'
 print ' '
 print '               GRAPHICS               '*
 print '          Kamil VIDOL Walaszek'
 print ' '
 print '                MUSIC                 '*
 print '          Various People from'
 print '        Atari Sap Music Archive'
 print ' '
 print '        -----------------------'  
 print '         Hardware Requirements'
 print '        -----------------------' 
; print ' '
 print '- ANTIC (PAL System)'
 print '- POKEY (Recommended 2 pokey''''s)'
 print '- 64kB additional memory (ATARI 130XE) - Joystick in port 1 (AUTOFIRE=OFF !!!)- Color TV (PAL System)'
 print ' '
 print '   >> Press any key to continue <<'

_lp
 ldy:iny 764
 beq _lp
 
 mva #$ff 764

 print ' '

 lda:cmp:req 20

 lda #0
 sta 559
 sta $d400

 mva #$40 $d40e 
 mva #$ff $d301
 
 jsr @mem_detect
 
 cmp #4
 bcs ok
 
 lda #scr40
 sta 559

 print 'GETRIS requires at least 64kB of RAM'
 print ' '
 print 'Press any key'

 mva #$ff 764

_rk
 ldy:iny 764
 beq _rk

 mva #$ff 764

 pla
 pla

 jmp ($a)


ok
 lda:cmp:req 20

 mva #$40 $d40e 
 mva #$ff $d301
 rts

 icl 'proc\@mem_detect.asm'

 ini $2000


 org $2000

*--- INTRO
 opt h-

 ins 'intro3\intro3.obx'

 opt h+

;--- BANK #1,#2,#3,#4
 opt b+

*--- BANK #1

 lmb #1

.pages $40

over_msx
 ins 'game_over\msx\over_msx.dat'

title_intro
 ins 'title_lib.def'	; wersja z etykietami external

congrat_intro
 ins 'grat_lib.def'	; wersja z etykietami external

.endpg

 .print 'Bank #1 $4000..',*


*--- BANK #2

 lmb #2

.pages $40

title_intro_msx

 opt l-
 tmc_relocator 'title\forever_loop.tm8' , muza
 opt l+
 .sav [6] length

.endpg

 .print 'Bank #2 $4000..',*


*--- BANK #3

 lmb #3

.pages $40

game_msx

 opt l-
 mpt_relocator 'mpt\freedom.mpt' , *
 opt l+
 .sav [6] ?length


game_msx2

 opt l-
 mpt_relocator 'mpt\memory.mpt' , *
 opt l+
 .sav [6] ?length


game_msx3

 opt l-
 mpt_relocator 'mpt\revenge.mpt' , *		; zamiast RAMA.MPT
 opt l+
 .sav [6] ?length


hscore_msx

 opt l-
 mpt_relocator 'mpt\enigmatic_man.mpt' , *
 opt l+
 .sav [6] ?length
 

congrat_intro_msx

 opt l-
 cmc_relocator 'grat\msx_cmc\hlejnia.cmc' , *
 opt l+

 .sav [6] ?length

.endpg

 .print 'Bank #3 $4000..',*


*--- BANK #0

 lmb #0		; koniecznie ustawiamy bank #0 wymuszajac wpisanie do $D301 wartosci $FF


 opt b-


*--- BANK #4

 lmb #4

mem_backup = $4000


*--- BANK #0 (default)

 rmb


/******************************************************************/

/******************************************************************/

/******************************************************************/
 

;---
 org $2000
;---

 lda:cmp:req 20
 
 sei
 mva #0 $d40e
; sta $d400
; sta 559

 mva #$fe $d301

; fonty przepisz przed PMG
; PMG wykorzystuje koncowke zestawow znakowych
 
 @move _fnt3_cop , fnt3 , 4

 @move _fnt3_2_cop , fnt3_2 , 4

/*
 ldy #0
pm_ini
 lda pm1,y
 sta pmBase1,y
 lda pm1+$100,y
 sta pmBase1+$100,y
 lda pm1+$200,y
 sta pmBase1+$200,y
 lda pm1+$300,y
 sta pmBase1+$300,y
 lda pm1+$400,y
 sta pmBase1+$400,y

 lda pm2,y
 sta pmBase2,y
 lda pm2+$100,y
 sta pmBase2+$100,y
 lda pm2+$200,y
 sta pmBase2+$200,y
 lda pm2+$300,y
 sta pmBase2+$300,y
 lda pm2+$400,y
 sta pmBase2+$400,y

 iny
 bne pm_ini
*/

 @move lvl_gfx , level_gfx , 5

 ldy #0
_cp lda kloc_gfx,y
 sta klocki_gfx,y
 lda kloc_gfx+$100,y
 sta klocki_gfx+$100,y
 iny
 bne _cp
 
/*
 plik 'klocek_fazy.mic' zostanie przepisany
 na koniec zestawow znakow FNT1, FNT2
*/

 ldy #0
_cp2 lda kloc_fazy,y
 sta fnt1+$400*0+klocek_char*8,y
 sta fnt1+$400*1+klocek_char*8,y
 sta fnt1+$400*2+klocek_char*8,y
 sta fnt1+$400*3+klocek_char*8,y
 sta fnt1+$400*4+klocek_char*8,y
 sta fnt1+$400*5+klocek_char*8,y
 
 sta fnt2+$400*0+klocek_char*8,y
 sta fnt2+$400*1+klocek_char*8,y
 sta fnt2+$400*2+klocek_char*8,y
 sta fnt2+$400*3+klocek_char*8,y
 sta fnt2+$400*4+klocek_char*8,y
 sta fnt2+$400*5+klocek_char*8,y
 iny
 cpy #21*8
 bne _cp2


 ldx #$14
 ldy #0
_cp0 lda pod_rom,y
_cp1 sta free_rom,y
 iny
 bne _cp0

 inc _cp0+2
 inc _cp1+2
 dex
 bpl _cp0


 mva #$ff $d301
 mva #$40 $d40e
 cli 
 rts

;---

/*
  Kopiuj 4kb obszar
  src: A (msb), dst: Y (msb)
*/

.macro @move
 mwa #:1 move._src+1
 lda >:2
 ldx #:3
 jsr move
.endm

.proc move
 sta _dst+2
 
 ldy #0
 
_src lda $ff00,y
_dst sta $ff00,y

 iny
 bne _src
 
 inc _src+2
 inc _dst+2

 dex
 bne _src
 rts

.endp

;---

.macro load_level
?licz = :3

 .rept :2
  ins :1,?licz,3
?licz = ?licz + 32
 .endr

.endm


.macro get_klocSCR_pion
 ins :1+:2,1
 ins :1+:2+32,1
 ins :1+:2+64,1
 ins :1+:2+96,1
.endm

.macro get_klocSCR
 get_klocSCR_pion :1 , 0
 get_klocSCR_pion :1 , 1
 get_klocSCR_pion :1 , 2
 get_klocSCR_pion :1 , 3
 get_klocSCR_pion :1 , 4
 get_klocSCR_pion :1 , 5
 get_klocSCR_pion :1 , 6
 get_klocSCR_pion :1 , 7
 get_klocSCR_pion :1 , 8
.endm


// fazy spadajacego klocka
kloc_fazy
 ins 'klocek_fazy.fnt',0,21*8

// zestaw znakow dla High Score
_fnt3_cop
 ins 'H_Score_OK.fnt'                   ; FNT3

_fnt3_2_cop
 ins 'H_Score_OK.fnt',128*8,107*8       ; FNT3_2
 

// grafika klockow dla okna NEXT
kloc_gfx
 load_level 'klocki_mic.scr'* , 30 , 0
 ins 'klocki_mic.fnt',0,24*8

// grafika dla licznika leveli (360 bajtow + 840 bajtow = 1200 bajtow)
lvl_gfx
 load_level 'level_al.scr'* , 20 , 0
 load_level 'level_al.scr'* , 20 , 3
 load_level 'level_al.scr'* , 20 , 6
 load_level 'level_al.scr'* , 20 , 9
 load_level 'level_al.scr'* , 20 , 12
 load_level 'level_al.scr'* , 20 , 15
 
 ins 'level_al.fnt',0,105*8

/*
// ekran1
pm1
 :ofset brk
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $0E,$06,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$06,$0E,$08
 dta $0E,$02,$0E,$06,$0E,$02,$0E,$02,$02,$02,$02,$02,$02,$02,$02,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
 dta $02,$02,$02,$0A,$0E,$02,$02,$02,$02,$02,$02,$02,$06,$02,$0A,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$0A,$02,$06,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$06,$02,$06,$02,$02,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$0A,$02,$06,$02,$04
 dta $0E,$02,$0A,$02,$02,$02,$06,$02,$02,$02,$0E,$02,$02,$02,$06,$00
 dta $02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$55,$FF,$FF,$FF,$FF,$FF,$FF,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $A0,$80,$80,$80,$80,$EA,$20,$FE,$D4,$FC,$F4,$FC,$F8,$E8,$FC,$50
 dta $F9,$03,$A3,$01,$A1,$01,$81,$03,$02,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$02,$28,$00,$20,$00,$23,$80,$A8,$50,$F8,$50,$F0
 dta $70,$B0,$6B,$F5,$FF,$D5,$FF,$C0,$EA,$00,$A8,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$01,$00,$02,$00,$24,$00,$28,$00,$2A
 dta $0A,$3B,$4A,$9F,$0B,$1F,$1F,$1A,$1F,$0A,$1B,$02,$0A,$00,$0A,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$80,$00
 dta $FE,$00,$00,$00,$00,$00,$00,$00,$5C,$00,$00,$00,$00,$00,$00,$00
 dta $30,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $04,$00,$08,$00,$00,$00,$00,$00,$68,$00,$00,$00,$01,$00,$02,$00
 dta $16,$00,$08,$00,$00,$00,$00,$00,$00,$0E,$11,$40,$00,$80,$00,$00
 dta $1C,$04,$1C,$00,$00,$00,$00,$00,$28,$00,$00,$00,$30,$00,$80,$00
 dta $C0,$00,$98,$00,$00,$00,$02,$00,$02,$00,$00,$00,$00,$00,$00,$00
 dta $21,$00,$6C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$28,$78,$78,$78,$78,$78,$78,$00
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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$28,$78,$78,$78,$78,$78,$78,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;---
// ekran2
pm2
 :ofset brk
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $0A,$0E,$02,$02,$02,$02,$02,$0E,$02,$02,$02,$02,$02,$02,$02,$02
 dta $0A,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$0A,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$06
 dta $06,$02,$02,$02,$02,$0A,$02,$0A,$02,$0A,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02
 dta $02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
 dta $01,$01,$01,$01,$01,$01,$01,$01,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $E0,$C0,$00,$20,$00,$A0,$00,$00,$7F,$00,$00,$00,$00,$08,$00,$08
 dta $24,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$04,$00,$A0,$00,$A0,$00,$D4,$00,$F0,$A8,$F0,$A0
 dta $F0,$F0,$7E,$FF,$00,$00,$00,$00,$80,$00,$00,$01,$00,$00,$00,$04
 dta $00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$08,$00,$48,$00,$AA,$00
 dta $3E,$22,$BE,$2A,$AC,$3A,$2E,$3E,$2A,$3E,$22,$2E,$00,$2A,$00,$08
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00
 dta $3F,$02,$00,$40,$00,$80,$00,$02,$02,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $0A,$00,$02,$00,$0B,$00,$3F,$2A,$3E,$2E,$36,$3C,$34,$3C,$54,$7C
 dta $04,$50,$00,$10,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $01,$50,$00,$00,$00,$08,$08,$28,$F5,$05,$00,$30,$00,$40,$00,$C0
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00,$00,$00,$00
 dta $00,$94,$00,$E0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

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
 dta $00,$00,$00,$00,$00,$00,$00,$00,$78,$78,$78,$78,$78,$78,$78,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
*/


/*
  Procedury do przepisania pod ROM
*/
pod_rom

        org free_rom,*

switch_bank
 lda @TAB_MEM_BANKS,x
 and #$fe
 sta $d301
 rts 


.proc mem_move
 stx src+2
 sty dst+2

 ldx #$30-1
 ldy #0
src lda $FF00,y
dst sta $FF00,y
 iny
 bne src

 inc src+2
 inc dst+2
 dex
 bpl src
 rts

.endp


/*
  Procedura wlaczajaca ekran CONGRATULATIONS  (koniecznie ponizej adresu $4000)
*/
.proc congrat

;--- zachowujemy zawartosc obszaru $1000..$3FFF
 ldx #=mem_backup
 jsr switch_bank

 ldx >$1000
 ldy >mem_backup
 jsr mem_move

;--- kopiujemy CONGRAT_INTRO w obszar $1000..$3FFF
 ldx #=congrat_intro
 jsr switch_bank

 mwa #congrat_intro inputPointer
 mwa #$1000	    outputPointer
 jsr inflate

 ldx #=congrat_intro_msx
 jsr switch_bank

 ldx <congrat_intro_update_address
 ldy >congrat_intro_update_address
 jsr congrat_intro.main

 jmp title.return

.endp

;  music		ext .word
;  default_nmi		ext .word
;  reset_pokey		ext .word

congrat_intro_update_address
 dta a( congrat_intro_msx , default_nmi , reset_pokey )


/*
  Procedura wlaczajaca ekran tytulowy  (koniecznie ponizej adresu $4000)
*/
.proc title

;--- zachowujemy zawartosc obszaru $1000..$3FFF
 ldx #=mem_backup
 jsr switch_bank

 ldx >$1000
 ldy >mem_backup
 jsr mem_move

;--- kopiujemy obszar $5000..$7FFF w obszar $1000..$3FFF
 ldx #=title_intro
 jsr switch_bank

 mwa #title_intro inputPointer
 mwa #$1000	  outputPointer
 jsr inflate 

 ldx #=title_intro_msx
 jsr switch_bank

 ldx <title_intro_update_address
 ldy >title_intro_update_address
 jsr title_intro.main

;--- przywracamy poprzednia zawartosc obszaru $1000..$3FFF
return
 sta console

 ldx #=mem_backup
 jsr switch_bank

 ldx >mem_backup
 ldy >$1000
 jsr mem_move

 mva #$fe $d301

 lda #0
console equ *-1
 rts
.endp


title_intro_update_address
 dta a(reset_pokey , tmc_player.initialization , tmc_player.sound , tmc_player.play , default_nmi)


game_msx_stop
 mva #0 mpt.player

reset_pokey
 ldy #8			;muza stop
 lda #0
sil
 sta $d200,y
 sta $d210,y
 dey
 bpl sil

 lda #3
 sta $d20f
 sta $d21f
 rts


// domyslne przerwanie NMI
.proc default_nmi

 lda #0
 sta $d40e
 sta $d400
 mwa #nmi._rti $fffa
 rts

.endp


* --------- *
* -  NMI  - *
* --------- *
.proc nmi

 sta rejA
 stx rejX
 sty rejY

 bit $d40f
 bpl vbl

 jmp quit
vdli equ *-2

  
vbl
 sta $d40f
 
 inc $14

 mwa #ant $d402
 
 mva #scr40 $d400       	;ustawienie szerokosci obrazu ($d400)
 
 lda #0
pmBase equ *-1
 eor #[>pmBase1^>pmBase2]
 sta $d407
 sta pmBase
 
 lda adr+1
 eor #[>TEXT1^>text2]
 sta adr+1
 
;--- wspolne wartosci dla obu ekranow

 lda #$04
 sta PRIOR_GTIACTL
 lda #$00
 sta Background_BAK
 sta Player1_Size 

; lda #$08
 sta Player2_Missile2_Color2_PM2   ; poza gorna ramka klocki niewidoczne (kolor czarny)
 sta Player3_Missile3_Color3_PM3 
 
c0 lda #$14
 sta Playfield_Color0_PF0
c1 lda #$78
 sta Playfield_Color1_PF1

 lda #$78
 sta Player3_PositionX
  
c2 lda #$0A
 sta Playfield_Color2_PF2
c3 lda #$54
 sta Playfield_Color3_PF3
 sta Player1_Missile1_Color1_PM1  
 lda #$03
 sta Player0_Size
 sta Player2_Size
 sta Player3_Size
 lda #$F3
 sta Missiles_Size
 lda #$7C
 sta Player0_PositionX
 lda #$44
 sta Player1_PositionX
 lda #$68
 sta Player2_PositionX
 lda #$64
 sta Missile0_PositionX
 lda #$4D
 sta Missile1_PositionX
 lda #$90
 sta Missile2_PositionX
 lda #$88
 sta Missile3_PositionX
c4 lda #$48
 sta Player0_Missile0_Color0_PM0

;--- odczyt joya i przycisku
 
 lda read_joy
 bne _skip
 
 lda $d300
 and #$f
 cmp #14
 bcs _skip
 
ok
 cmp old_joy
 bne new_joy
 
 dec delay_joy
 bne _skip
 
new_joy
 sta tetris.r_d300
 sta old_joy
 
 lda #delay_joy_default_value
 sta delay_joy
 sta read_joy
 
_skip
 lda $d010
 bne nmiQ

 dec delay_trig
 bne wyjscie

 sta tetris.r_d010

 lda #delay_trig_default_value
; sta delay_trig
 jmp ___s

nmiQ
 lda #1

___s
 sta delay_trig

wyjscie

 ldx #=game_msx
 jsr mpt

quit
 lda rejA
 ldx rejX
 ldy rejY
_rti
 rti

.endp


.proc mpt

 lda #0
player equ *-1
 beq skp

 jsr switch_bank

 jsr mpt_player.play

 lda #$fe
 sta $d301

skp
 rts

.endp

 
;---

maska      brk
read_joy   brk
delay      dta max_fps
delay_trig dta delay_trig_default_value
delay_joy  dta 4
old_joy    brk
 
;---

wait60cycle
 jsr _rts
 cmp raster
wait44cycle
 inc raster
 nop
wait36cycle
 jsr _rts
wait24cycle
 jsr _rts
_rts rts

raster	brk

 icl 'title\tmc_player.asm'

 icl 'mpt\mpt_player.asm'

 icl 'inflate.asm'


 .print 'ROM: $EB00..',*


;---
 org $8000
fnt1 ins 'ekran1.fnt'
fnt2 ins 'ekran2.fnt'


 org intro.fade_out+3			; wylaczamy ekran, aby nie widac bylo logosow GETRIS
; jsr intro.fade_out
 lda #0
 sta 559
 sta $d400
 rts

 ini intro.fade_out


 org $b000
 
text1_null :40 brk              ; $B000
text1 ins 'ekran1.scr',40

klocSCR_fazy
 get_klocSCR """'klocek_fazy.scr'+klocek_char,0"""
 get_klocSCR """'klocek_fazy.scr'+klocek_char,4*32"""
 get_klocSCR """'klocek_fazy.scr'+klocek_char,8*32"""
 :36 dta puste_char


ant dta [ofset-1]*$10,$f0,$44
adr dta a(text1)
 dta 4,4,$84,$84,$84,4,4,$84,4,4,4,$84,4,4,4,$84,4,4,4,$84,$84,4,4,4,4,4
 dta $41,a(ant)


 ALIGN 0

text2_null :40 brk
text2 ins 'ekran2.scr',40


scren_lcol
 dta l(ekran1.c0,ekran1.c9,nmi.c0,nmi.c1,nmi.c2,nmi.c3,nmi.c4) 
 dta l(ekran1.c10,ekran1.c11,ekran1.c12,ekran1.c13,ekran1.c14,ekran1.c15,ekran1.c16,ekran1.c17,ekran1.c18,ekran1.c19)
 dta l(ekran1.c20,ekran1.c21,ekran1.c22,ekran1.c23,ekran1.c24,ekran1.c25,ekran1.c26,ekran1.c27,ekran1.c28,ekran1.c29)
 dta l(ekran1.c30,ekran1.c31,ekran1.c32,ekran1.c33,ekran1.c34,ekran1.c35,ekran1.c36,ekran1.c37,ekran1.c38,ekran1.c39)
 dta l(ekran1.c40,ekran1.c41,ekran1.c42,ekran1.c43,ekran1.c44,ekran1.c45,ekran1.c46,ekran1.c47,ekran1.c48,ekran1.c49)
 dta l(ekran1.c50,ekran1.c51,ekran1.c52,ekran1.c53,ekran1.c54,ekran1.c55,ekran1.c56,ekran1.c57,ekran1.c58,ekran1.c59)
 dta l(ekran1.c60,ekran1.c61,ekran1.c62,ekran1.c63,ekran1.c64,ekran1.c65,ekran1.c66,ekran1.c67,ekran1.c68,ekran1.c69)
 dta l(ekran1.c70,ekran1.c71,ekran1.c72,ekran1.c73,ekran1.c74,ekran1.c75,ekran1.c76,ekran1.c77,ekran1.c78,ekran1.c79)
 dta l(ekran1.c80,ekran1.c81,ekran1.c82,ekran1.c83,ekran1.c84,ekran1.c85,ekran1.c86,ekran1.c87,ekran1.c88,ekran1.c89)
 dta l(ekran1.c90,ekran1.c91,ekran1.c92,ekran1.c93,ekran1.c94,ekran1.c95,ekran1.c96,ekran1.c97,ekran1.c98,ekran1.c99)
 dta l(ekran1.c100,ekran1.c101,ekran1.c102,ekran1.c103,ekran1.c104,ekran1.c105,ekran1.c106,ekran1.c107,ekran1.c108,ekran1.c109)
 dta l(ekran1.c110,ekran1.c111,ekran1.c112,ekran1.c113,ekran1.c114,ekran1.c115,ekran1.c116,ekran1.c117,ekran1.c118,ekran1.c119)
 dta l(ekran1.c120,ekran1.c121,ekran1.c122,ekran1.c123,ekran1.c124,ekran1.c125,ekran1.c126,ekran1.c127,ekran1.c128,ekran1.c129)
 dta l(ekran1.c130,ekran1.c131,ekran1.c132,ekran1.c133,ekran1.c134,ekran1.c135,ekran1.c136,ekran1.c137,ekran1.c138,ekran1.c139)
 dta l(ekran1.c140,ekran1.c141,ekran1.c142,ekran1.c143,ekran1.c144,ekran1.c145,ekran1.c146,ekran1.c147,ekran1.c148,ekran1.c149)
 dta l(ekran1.c150,ekran1.c151,ekran1.c152,ekran1.c153,ekran1.c154,ekran1.c155,ekran1.c156,ekran1.c157,ekran1.c158,ekran1.c159)
 dta l(ekran1.c160,ekran1.c161,ekran1.c162,ekran1.c163,ekran1.c164,ekran1.c165,ekran1.c166,ekran1.c167,ekran1.c168,ekran1.c169)
 dta l(ekran1.c170,ekran1.c171,ekran1.c172,ekran1.c173,ekran1.c174,ekran1.c175,ekran1.c176,ekran1.c177,ekran1.c178,ekran1.c179)
 dta l(ekran1.c180)


 dta l(ekran2.c0,ekran2.c9)
 dta l(ekran2.c10,ekran2.c11,ekran2.c12,ekran2.c13,ekran2.c14,ekran2.c15,ekran2.c16,ekran2.c17,ekran2.c18,ekran2.c19)
 dta l(ekran2.c20,ekran2.c21,ekran2.c22,ekran2.c23,ekran2.c24,ekran2.c25,ekran2.c26,ekran2.c27,ekran2.c28,ekran2.c29)
 dta l(ekran2.c30,ekran2.c31,ekran2.c32,ekran2.c33,ekran2.c34,ekran2.c35,ekran2.c36,ekran2.c37,ekran2.c38,ekran2.c39)
 dta l(ekran2.c40,ekran2.c41,ekran2.c42,ekran2.c43,ekran2.c44,ekran2.c45,ekran2.c46,ekran2.c47,ekran2.c48,ekran2.c49)
 dta l(ekran2.c50,ekran2.c51,ekran2.c52,ekran2.c53,ekran2.c54,ekran2.c55,ekran2.c56,ekran2.c57,ekran2.c58,ekran2.c59)
 dta l(ekran2.c60,ekran2.c61,ekran2.c62,ekran2.c63,ekran2.c64,ekran2.c65,ekran2.c66,ekran2.c67,ekran2.c68,ekran2.c69)
 dta l(ekran2.c70,ekran2.c71,ekran2.c72,ekran2.c73,ekran2.c74,ekran2.c75,ekran2.c76,ekran2.c77,ekran2.c78,ekran2.c79)
 dta l(ekran2.c80,ekran2.c81,ekran2.c82,ekran2.c83,ekran2.c84,ekran2.c85,ekran2.c86,ekran2.c87,ekran2.c88,ekran2.c89)
 dta l(ekran2.c90,ekran2.c91,ekran2.c92,ekran2.c93,ekran2.c94,ekran2.c95,ekran2.c96,ekran2.c97,ekran2.c98,ekran2.c99)
 dta l(ekran2.c100,ekran2.c101,ekran2.c102,ekran2.c103,ekran2.c104,ekran2.c105,ekran2.c106,ekran2.c107,ekran2.c108,ekran2.c109)
 dta l(ekran2.c110,ekran2.c111,ekran2.c112,ekran2.c113,ekran2.c114,ekran2.c115,ekran2.c116,ekran2.c117,ekran2.c118,ekran2.c119)
 dta l(ekran2.c120,ekran2.c121,ekran2.c122,ekran2.c123,ekran2.c124,ekran2.c125,ekran2.c126,ekran2.c127,ekran2.c128,ekran2.c129)
 dta l(ekran2.c130,ekran2.c131,ekran2.c132,ekran2.c133,ekran2.c134,ekran2.c135,ekran2.c136,ekran2.c137,ekran2.c138,ekran2.c139)
 dta l(ekran2.c140,ekran2.c141,ekran2.c142,ekran2.c143,ekran2.c144,ekran2.c145,ekran2.c146,ekran2.c147,ekran2.c148,ekran2.c149)
 dta l(ekran2.c150,ekran2.c151,ekran2.c152,ekran2.c153,ekran2.c154,ekran2.c155,ekran2.c156,ekran2.c157,ekran2.c158,ekran2.c159)
 dta l(ekran2.c160,ekran2.c161,ekran2.c162,ekran2.c163,ekran2.c164,ekran2.c165,ekran2.c166,ekran2.c167,ekran2.c168,ekran2.c169)
 dta l(ekran2.c170,ekran2.c171,ekran2.c172,ekran2.c173,ekran2.c174,ekran2.c175,ekran2.c176,ekran2.c177,ekran2.c178,ekran2.c179)
 dta l(ekran2.c180,ekran2.c181,ekran2.c182,ekran2.c183,ekran2.c184,ekran2.c185,ekran2.c186,ekran2.c187,ekran2.c188,ekran2.c189)
 dta l(ekran2.c190,ekran2.c191,ekran2.c192,ekran2.c193,ekran2.c194,ekran2.c195,ekran2.c196,ekran2.c197,ekran2.c198,ekran2.c199)
 dta l(ekran2.c200,ekran2.c201,ekran2.c202,ekran2.c203,ekran2.c204,ekran2.c205,ekran2.c206,ekran2.c207,ekran2.c208,ekran2.c209)
 dta l(ekran2.c210,ekran2.c211,ekran2.c212,ekran2.c213,ekran2.c214,ekran2.c215,ekran2.c216,ekran2.c217,ekran2.c218,ekran2.c219)
 dta l(ekran2.c220,ekran2.c221,ekran2.c222,ekran2.c223,ekran2.c224,ekran2.c225,ekran2.c226,ekran2.c227,ekran2.c228,ekran2.c229)
 dta l(ekran2.c230,ekran2.c231,ekran2.c232,ekran2.c233,ekran2.c234,ekran2.c235,ekran2.c236,ekran2.c237,ekran2.c238,ekran2.c239)
 dta l(ekran2.c240,ekran2.c241,ekran2.c242,ekran2.c243,ekran2.c244,ekran2.c245,ekran2.c246,ekran2.c247,ekran2.c248,ekran2.c249)
 dta l(ekran2.c250,ekran2.c251,ekran2.c252,ekran2.c253,ekran2.c254,ekran2.c255,ekran2.c256,ekran2.c257,ekran2.c258,ekran2.c259)
 dta l(ekran2.c260,ekran2.c261,ekran2.c262,ekran2.c263,ekran2.c264,ekran2.c265,ekran2.c266,ekran2.c267,ekran2.c268,ekran2.c269)
 dta l(ekran2.c270,ekran2.c271)


scren_hcol
 dta h(ekran1.c0,ekran1.c9,nmi.c0,nmi.c1,nmi.c2,nmi.c3,nmi.c4) 
 dta h(ekran1.c10,ekran1.c11,ekran1.c12,ekran1.c13,ekran1.c14,ekran1.c15,ekran1.c16,ekran1.c17,ekran1.c18,ekran1.c19)
 dta h(ekran1.c20,ekran1.c21,ekran1.c22,ekran1.c23,ekran1.c24,ekran1.c25,ekran1.c26,ekran1.c27,ekran1.c28,ekran1.c29)
 dta h(ekran1.c30,ekran1.c31,ekran1.c32,ekran1.c33,ekran1.c34,ekran1.c35,ekran1.c36,ekran1.c37,ekran1.c38,ekran1.c39)
 dta h(ekran1.c40,ekran1.c41,ekran1.c42,ekran1.c43,ekran1.c44,ekran1.c45,ekran1.c46,ekran1.c47,ekran1.c48,ekran1.c49)
 dta h(ekran1.c50,ekran1.c51,ekran1.c52,ekran1.c53,ekran1.c54,ekran1.c55,ekran1.c56,ekran1.c57,ekran1.c58,ekran1.c59)
 dta h(ekran1.c60,ekran1.c61,ekran1.c62,ekran1.c63,ekran1.c64,ekran1.c65,ekran1.c66,ekran1.c67,ekran1.c68,ekran1.c69)
 dta h(ekran1.c70,ekran1.c71,ekran1.c72,ekran1.c73,ekran1.c74,ekran1.c75,ekran1.c76,ekran1.c77,ekran1.c78,ekran1.c79)
 dta h(ekran1.c80,ekran1.c81,ekran1.c82,ekran1.c83,ekran1.c84,ekran1.c85,ekran1.c86,ekran1.c87,ekran1.c88,ekran1.c89)
 dta h(ekran1.c90,ekran1.c91,ekran1.c92,ekran1.c93,ekran1.c94,ekran1.c95,ekran1.c96,ekran1.c97,ekran1.c98,ekran1.c99)
 dta h(ekran1.c100,ekran1.c101,ekran1.c102,ekran1.c103,ekran1.c104,ekran1.c105,ekran1.c106,ekran1.c107,ekran1.c108,ekran1.c109)
 dta h(ekran1.c110,ekran1.c111,ekran1.c112,ekran1.c113,ekran1.c114,ekran1.c115,ekran1.c116,ekran1.c117,ekran1.c118,ekran1.c119)
 dta h(ekran1.c120,ekran1.c121,ekran1.c122,ekran1.c123,ekran1.c124,ekran1.c125,ekran1.c126,ekran1.c127,ekran1.c128,ekran1.c129)
 dta h(ekran1.c130,ekran1.c131,ekran1.c132,ekran1.c133,ekran1.c134,ekran1.c135,ekran1.c136,ekran1.c137,ekran1.c138,ekran1.c139)
 dta h(ekran1.c140,ekran1.c141,ekran1.c142,ekran1.c143,ekran1.c144,ekran1.c145,ekran1.c146,ekran1.c147,ekran1.c148,ekran1.c149)
 dta h(ekran1.c150,ekran1.c151,ekran1.c152,ekran1.c153,ekran1.c154,ekran1.c155,ekran1.c156,ekran1.c157,ekran1.c158,ekran1.c159)
 dta h(ekran1.c160,ekran1.c161,ekran1.c162,ekran1.c163,ekran1.c164,ekran1.c165,ekran1.c166,ekran1.c167,ekran1.c168,ekran1.c169)
 dta h(ekran1.c170,ekran1.c171,ekran1.c172,ekran1.c173,ekran1.c174,ekran1.c175,ekran1.c176,ekran1.c177,ekran1.c178,ekran1.c179)
 dta h(ekran1.c180)


 dta h(ekran2.c0,ekran2.c9)
 dta h(ekran2.c10,ekran2.c11,ekran2.c12,ekran2.c13,ekran2.c14,ekran2.c15,ekran2.c16,ekran2.c17,ekran2.c18,ekran2.c19)
 dta h(ekran2.c20,ekran2.c21,ekran2.c22,ekran2.c23,ekran2.c24,ekran2.c25,ekran2.c26,ekran2.c27,ekran2.c28,ekran2.c29)
 dta h(ekran2.c30,ekran2.c31,ekran2.c32,ekran2.c33,ekran2.c34,ekran2.c35,ekran2.c36,ekran2.c37,ekran2.c38,ekran2.c39)
 dta h(ekran2.c40,ekran2.c41,ekran2.c42,ekran2.c43,ekran2.c44,ekran2.c45,ekran2.c46,ekran2.c47,ekran2.c48,ekran2.c49)
 dta h(ekran2.c50,ekran2.c51,ekran2.c52,ekran2.c53,ekran2.c54,ekran2.c55,ekran2.c56,ekran2.c57,ekran2.c58,ekran2.c59)
 dta h(ekran2.c60,ekran2.c61,ekran2.c62,ekran2.c63,ekran2.c64,ekran2.c65,ekran2.c66,ekran2.c67,ekran2.c68,ekran2.c69)
 dta h(ekran2.c70,ekran2.c71,ekran2.c72,ekran2.c73,ekran2.c74,ekran2.c75,ekran2.c76,ekran2.c77,ekran2.c78,ekran2.c79)
 dta h(ekran2.c80,ekran2.c81,ekran2.c82,ekran2.c83,ekran2.c84,ekran2.c85,ekran2.c86,ekran2.c87,ekran2.c88,ekran2.c89)
 dta h(ekran2.c90,ekran2.c91,ekran2.c92,ekran2.c93,ekran2.c94,ekran2.c95,ekran2.c96,ekran2.c97,ekran2.c98,ekran2.c99)
 dta h(ekran2.c100,ekran2.c101,ekran2.c102,ekran2.c103,ekran2.c104,ekran2.c105,ekran2.c106,ekran2.c107,ekran2.c108,ekran2.c109)
 dta h(ekran2.c110,ekran2.c111,ekran2.c112,ekran2.c113,ekran2.c114,ekran2.c115,ekran2.c116,ekran2.c117,ekran2.c118,ekran2.c119)
 dta h(ekran2.c120,ekran2.c121,ekran2.c122,ekran2.c123,ekran2.c124,ekran2.c125,ekran2.c126,ekran2.c127,ekran2.c128,ekran2.c129)
 dta h(ekran2.c130,ekran2.c131,ekran2.c132,ekran2.c133,ekran2.c134,ekran2.c135,ekran2.c136,ekran2.c137,ekran2.c138,ekran2.c139)
 dta h(ekran2.c140,ekran2.c141,ekran2.c142,ekran2.c143,ekran2.c144,ekran2.c145,ekran2.c146,ekran2.c147,ekran2.c148,ekran2.c149)
 dta h(ekran2.c150,ekran2.c151,ekran2.c152,ekran2.c153,ekran2.c154,ekran2.c155,ekran2.c156,ekran2.c157,ekran2.c158,ekran2.c159)
 dta h(ekran2.c160,ekran2.c161,ekran2.c162,ekran2.c163,ekran2.c164,ekran2.c165,ekran2.c166,ekran2.c167,ekran2.c168,ekran2.c169)
 dta h(ekran2.c170,ekran2.c171,ekran2.c172,ekran2.c173,ekran2.c174,ekran2.c175,ekran2.c176,ekran2.c177,ekran2.c178,ekran2.c179)
 dta h(ekran2.c180,ekran2.c181,ekran2.c182,ekran2.c183,ekran2.c184,ekran2.c185,ekran2.c186,ekran2.c187,ekran2.c188,ekran2.c189)
 dta h(ekran2.c190,ekran2.c191,ekran2.c192,ekran2.c193,ekran2.c194,ekran2.c195,ekran2.c196,ekran2.c197,ekran2.c198,ekran2.c199)
 dta h(ekran2.c200,ekran2.c201,ekran2.c202,ekran2.c203,ekran2.c204,ekran2.c205,ekran2.c206,ekran2.c207,ekran2.c208,ekran2.c209)
 dta h(ekran2.c210,ekran2.c211,ekran2.c212,ekran2.c213,ekran2.c214,ekran2.c215,ekran2.c216,ekran2.c217,ekran2.c218,ekran2.c219)
 dta h(ekran2.c220,ekran2.c221,ekran2.c222,ekran2.c223,ekran2.c224,ekran2.c225,ekran2.c226,ekran2.c227,ekran2.c228,ekran2.c229)
 dta h(ekran2.c230,ekran2.c231,ekran2.c232,ekran2.c233,ekran2.c234,ekran2.c235,ekran2.c236,ekran2.c237,ekran2.c238,ekran2.c239)
 dta h(ekran2.c240,ekran2.c241,ekran2.c242,ekran2.c243,ekran2.c244,ekran2.c245,ekran2.c246,ekran2.c247,ekran2.c248,ekran2.c249)
 dta h(ekran2.c250,ekran2.c251,ekran2.c252,ekran2.c253,ekran2.c254,ekran2.c255,ekran2.c256,ekran2.c257,ekran2.c258,ekran2.c259)
 dta h(ekran2.c260,ekran2.c261,ekran2.c262,ekran2.c263,ekran2.c264,ekran2.c265,ekran2.c266,ekran2.c267,ekran2.c268,ekran2.c269)
 dta h(ekran2.c270,ekran2.c271)

color_nr equ scren_hcol-scren_lcol


pmg_highScore
 ins 'pmg\pm_high_score.rle'

pmg_wellDone
 ins 'pmg\pm_well_done.rle'


 .print "Free: ",*,"..$C000 = ",$C000-*
 
 ert *>$BFFF

 ini $2000


/******************************************************************/

/******************************************************************/

/******************************************************************/


/*
  Fonty dla grafiki napisow 'well done', 'pause', 'game over'
  Pamiec obrazu dla tych napisow
*/
 org fnt_txt1           ; $1400
 ins 'over.fnt',0,1024
 
 ins 'texts_all.fnt'    ; $1800

text_wellDone equ *-32  ; wykorzystamy 32 bajty z konca zestawu znakow TEXTS_ALL.FNT
// :32 brk
 ins 'texts_all.scr',4,32
 ins 'texts_all.scr',40+4,32
 ins 'texts_all.scr',40*2+4,32
 ins 'texts_all.scr',40*3+4,32
 ins 'texts_all.scr',40*4+4,32
 ins 'texts_all.scr',40*5+4,32
 ins 'texts_all.scr',40*6+4,32
 ins 'texts_all.scr',40*7+4,32

text_over
 ins 'Over.scr',6*40,12*40
 ins 'texts_all.scr',8*40,4*40

text_pause
 ins 'texts_all.scr',12*40+4,32
 ins 'texts_all.scr',13*40+4,32
 ins 'texts_all.scr',14*40+4,32
 ins 'texts_all.scr',15*40+4,32 

pmg_pause
 ins 'pmg\pm_pause.rle'

pmg_over
 ins 'pmg\pm_over.rle'

pm1
 ins 'pmg\pm1.rle'

pm2
 ins 'pmg\pm2.rle'

game_msx_l dta l(game_msx2 , game_msx , game_msx2 , game_msx3)
game_msx_h dta h(game_msx2 , game_msx , game_msx2 , game_msx3)


 .print "Free: ",*,"..$2000 = ",$2000-*


 org $2000

/*
  Program DLI dla ekranu GAME OVER  (koniecznie ponizej adresu $4000)
*/
.local game_over
 icl 'over_add.asm'
.endl


/*
  Programy DLI dla glownego ekranu rozgrywki GETRIS'a (interlace)
  Ekran1
  Ekran2
*/
.local ekran1
 icl 'ekran1.asm'
.endl

.local ekran2
 icl 'ekran2.asm'
.endl


/*
  Program DLI dla ekranu WELL DONE
*/
.local well
 icl 'well_done_add.asm'
.endl


/*
  Program DLI dla ekranu PAUSE
*/
.local pau
 icl 'pause_add.asm'
.endl


/*
  Program DLI dla ekranu HIGH SCORE
*/
.local logo
 icl 'H_SCORE_ok.asm'
.endl


/*
  Pamiec obrazu dla ekranu HIGH SCORE
*/
text_logo  ins 'h_score_ok.scr'


main
 jsr wajt

 sei			;wylaczenie przerwan
 mva #0 $d40e
 sta $d400
 
 sta tetris.lvl

 mva #$fe $d301		;wylaczenie ROM-u

;-- init fade colors

 jsr save_color         ; zapamietujemy i kasujemy kolory dla glownego ekranu gry 
 jsr logo.save_color    ; zapamietujemy i kasujemy kolory dla ekranu HIGH SCORE

 lda <tetris.high_score.fad_over       ; modyfikacja adresow procedr fade_in, fade_out dla ekranu GAME OVER
 ldx >tetris.high_score.fad_over
 jsr tetris.set_fade

 jsr logo.save_color    ; zapamietujemy i kasujemy kolory dla ekranu GAME OVER


 lda <tetris.well_done.fad_well       ; modyfikacja adresow procedr fade_in, fade_out dla ekranu WELL DONE
 ldx >tetris.well_done.fad_well
 jsr tetris.set_fade

 jsr logo.save_color    ; zapamietujemy i kasujemy kolory dla ekranu GAME OVER


 lda <tetris.pause.fad_pause          ; modyfikacja adresow procedr fade_in, fade_out dla ekranu PAUSE
 ldx >tetris.pause.fad_pause
 jsr tetris.set_fade

 jsr logo.save_color    ; zapamietujemy i kasujemy kolory dla ekranu PAUSE


nowa_gra

 jsr title

 cmp #%011
 bne _skp

 jsr tetris.licznik.reset 
 jmp tetris.high_score.h_score		; ekran HIGH SCORE

_skp
 lda #0
 sta msx_losuj+1

restart

;-- init PMG
 mwa #pmBase1 decode.q1+1
 hax #pm1-1
 jsr decode.dep        ; musimy tak wywolac, bo DECODE ustawia domyslny adres _DST

 hax #pm2-1
 jsr decode


 mva >pmBase1 $d407     ;PMCTL - wyswietlac duchy i pociski
 sta nmi.pmBase
 
 mva #3 $d01d           ;PMCTL - show sprites and missiles

 jsr tetris.init

 mwa #ekran2.dli nmi.vdli


msx_losuj lda #0
 bne _nie 

 lda $d20a
 and #3
old_msx cmp #0
 bne msx_ok

 clc
 adc #1
 and #3
 
msx_ok
 sta old_msx+1
 
 clc
 adc #1
 sta msx_losuj+1

_nie
 tax
 dex
 lda game_msx_l,x
 ldy game_msx_h,x

 ldx #=game_msx         ;init modulu MPT

 jsr mpt_player.initialization

 mwa #nmi $fffa
 mva #$c0 $d40e

;---

.local tetris

 icl 'tetris_add.asm'

.endl 


/*
  Zapamietujemy kolory i kasujemy je
*/
.proc save_color

 lda #0
 jsr scolor

 inc sladr+2
 inc shadr+2
 inc sat+2
 inc col+2
 
 lda <color_nr

scolor
 sta c_max
 ldx #0
save_l
sladr lda scren_lcol,x
 sta tmp
shadr lda scren_hcol,x
 sta tmp+1

 ldy #1
 lda (tmp),y
 pha
 and #$0f
sat sta t_satur,x
 pla
 and #$f0
col sta t_color,x

 lda #0        ; black screen (all colors = $00)
 sta (tmp),y

 inx
 cpx #0
c_max equ *-1
 bne save_l
 rts

.endp


/*
  FADE in
*/
.proc fade_in

 lda >scren_lcol
 sta sladr+2
 lda >scren_hcol
 sta shadr+2
 lda >t_satur
 sta sat+2
 lda >t_color
 sta col+2

 lda #0
 jsr fadein

 inc sladr+2
 inc shadr+2
 inc sat+2
 inc col+2
 
 lda <color_nr

fadein
 sta cmax
 
 ldx #0
fade_l
sladr lda scren_lcol,x
 sta tmp
shadr lda scren_hcol,x
 sta tmp+1

 ldy #1
 lda (tmp),y
 tay

 and #$0f
sat cmp t_satur,x
 beq skp0

 iny

skp0

 tya
 and #$f0
col cmp t_color,x
 beq skp1

 tya
 clc
 adc #$10
 tay

skp1
 tya

 ldy #1
 sta (tmp),y

 inx
 cpx #0
cmax equ *-1
 bne fade_l
 rts

.endp


/*
  FADE out
*/
.proc fade_out

 lda >scren_lcol
 sta sladr+2
 lda >scren_hcol
 sta shadr+2

 lda #0
 jsr fadeout

 inc sladr+2
 inc shadr+2
 
 lda <color_nr

fadeout
 sta cmax
 
 ldx #0
fade_l
sladr lda scren_lcol,x
 sta tmp
shadr lda scren_hcol,x
 sta tmp+1

 ldy #1
 lda (tmp),y
 tay

 and #$0f
 beq skp0

 dey

skp0

 tya
 and #$f0
 beq skp1

 tya
 sec
 sbc #$10
 tay

skp1
 tya

 ldy #1
 sta (tmp),y

 inx
 cpx #0
cmax equ *-1
 bne fade_l
 rts

.endp



/*
  plynne zapalenie kolorow ekranu
*/
.proc zapal_ekran

 lda #0
 sta licz
 
zap
 jsr wajt
 jsr fade_in
 
 inc licz
 lda licz
 cmp #16
 bne zap
 rts

licz .byte

.endp


/*
  plynne wygaszenie kolorow ekranu
*/
.proc zgas_ekran

 lda #0
 sta licz
 
zap
 jsr wajt
 jsr fade_out
 
 inc licz
 lda licz
 cmp #16
 bne zap
 
 jmp game_msx_stop 

licz .byte

.endp


/*
  Wait 1 frame
*/
.proc wajt

 lda:cmp:req 20
 rts
 
.endp


/*
  Dekompresja RLE
*/
.proc decode

        ldy <pmBase_Text
        sty q1+1
        ldy >pmBase_Text
        sty q1+2

dep
        sta adr+2

loop    jsr get
        beq stop
        lsr @

        tay
q0      jsr get
q1      sta $ffff
        inc q1+1
        bne skip0
        inc q1+2
skip0
        dey
_bpl    bmi loop

        bcs q0
        bcc q1

get     inx
        bne skip1
        inc adr+2
skip1
adr     lda $ff00,x

stop    rts

.endp


pg_tmp org *+[tetris.height+9]*2


 .print "End: ",*

 ift *>$7FFF
  ert "Buuu !!!"
 eif 
 
;---

 run main

;---

/*******************************************************
  Macro definition
*******************************************************/
 opt l-
 icl '@bank_add.mac'
 icl 'title\tmc_relocator.mac'
 icl 'mpt\mpt_relocator.mac'
 icl 'grat\msx_cmc\cmc_relocator.mac'

.macro align

 .if <* > 0
   org >[*+$100]*$100+:1
 .endif

.endm


.macro dli_quit

 .if .hi(?old_dli)==.hi(:1)
   mva <:1 nmi.vdli
 .else
   mwa #:1 nmi.vdli
 .endif

  jmp nmi.quit

  .def ?old_dli
.endm


.macro max " "
 lda <:2
 ldx >:2
.endm


.macro hax " "
 lda >:2
 ldx <:2
.endm


.macro	print
	ldx <text
	ldy >text
	jsr $c642
	jmp skip
text	dta c :1,$9b
skip
.endm


.macro	clrscr
	lda #'}'
	jsr $f2b0
.endm
