// GETRIS GRATULACJE v1.1
// CHANGES: 30.01.2006


pmBase  equ $0000

scr48	equ %00111111	;screen 48b
scr40	equ %00111110	;screen 40b
scr32	equ %00111101	;screen 32b

cloc	equ $0014	;(1)
byt2	equ $0000	;(1) <$0100
byt3	equ $0100	;(1) >$00FF

ftmp	equ $80		;(2)
regA	equ ftmp+2	;(1)
regX	equ regA+1	;(1)
regY	equ regX+1	;(1)
zp_free	equ regY+1	;(1)

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

chbase	equ $D409

;-- MAIN PROGRAM
; opt h-
 org $1000

fnt
 ins 'grat.fnt',0,4096+46*8

ant
 dta d'ppp',$c4,a(scr)
 dta 4,$84,$84,$84,$84,4,4,4,4,$84,$84,$f0,2,$82,2,2
 dta $41,a(ant)
 

scr
 ins 'grat.scr',120,12*40
 ins 'grat.scr',120+12*40+40,4*40

pmg
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$20,$00,$00,$00,$20,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$40,$80
 dta $80,$04,$08,$28,$00,$10,$00,$00,$C0,$08,$08,$04,$04,$00,$00,$08
 dta $C8,$08,$08,$00,$08,$04,$08,$08,$00,$08,$08,$00,$08,$08,$08,$04
 dta $00,$08,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$30,$30,$30,$30,$30,$30,$30,$30
 dta $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
 dta $30,$30

 dta $00,$00,$80,$80,$00,$00,$00,$00,$00,$08,$00,$00
 dta $00,$40,$28,$20,$20,$30,$20,$10,$20,$21,$01,$01,$20,$20,$00,$08
 dta $68,$20,$00,$00,$20,$24,$04,$00,$24,$24,$00,$04,$04,$04,$22,$60
 dta $80,$80,$00,$00,$08,$08,$10,$10,$18,$10,$10,$90,$88,$00,$08,$00
 dta $40,$00,$80,$00,$00,$80,$00,$40,$00,$00,$82,$00,$40,$00,$00,$88
 dta $00,$40,$20,$20,$20,$20,$20,$00,$20,$40,$20,$60,$80,$C0,$80,$C0
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF

 dta $00,$40,$20,$80,$40,$00,$00,$40,$04,$08,$44,$00
 dta $24,$04,$08,$04,$2D,$21,$08,$10,$08,$08,$10,$10,$20,$24,$14,$30
 dta $00,$24,$10,$10,$02,$00,$10,$12,$00,$00,$12,$10,$00,$11,$22,$48
 dta $0A,$10,$24,$68,$10,$A0,$50,$40,$7F,$00,$00,$00,$00,$00,$00,$00
 dta $7F,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$FF

 dta $60,$90,$00,$10,$20,$80,$20,$8A,$20,$00,$44,$10
 dta $A4,$84,$02,$80,$05,$84,$01,$4A,$48,$42,$00,$08,$00,$10,$01,$14
 dta $10,$04,$14,$40,$00,$00,$48,$42,$08,$42,$0A,$02,$49,$90,$00,$04
 dta $3F,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
 dta $FF,$DF,$DE,$A2,$62,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
 dta $00,$00

main

;-- init PMG
 mva >pmBase $d407	;missiles and players data address
 mva #3 $d01d		;enable players and missiles

 jsr save_color

 lda:cmp:req 20		;wait 1 frame

 sei			;stop interrups
 mva #0 $d40e		;stop all interrupts
 mva #$fe $d301		;switch off ROM to get 16k more ram


; clr pmg
 ldy #0
 tya
clr
.rept 5
 sta pmBase+$300+.r*$100,y
.endr
 iny
 bne clr

 .put = 0,2,3,4
 ?ofs = 36
 ?tmp = 126
 
; copy pmg
 ldy #0
copy
.rept 4
 lda pmg+.r*?tmp,y
 sta pmBase+$300+?ofs+.get[.r]*$100,y
.endr
 iny
 cpy #?tmp
 bne copy

 mwa #nmi $fffa
 
 mva #$c0 $d40e

 mva #scr40 $d400	;set new screen's width

;---

 jsr fade_in

 jsr cmc.init
 
 jsr stars

 jsr fade_out
 
; jsr default_nmi
 rts

;---

 ?old_dli = *


dli
; line=32
 lda #$00
 ldx #$00
 ldy #$00
 sta $d40a
 sta $d01e
 stx $d01e
 sty $d01e
 inc byt3

; line=33

 jsr wait60cycle

; line=34

 jsr wait60cycle

; line=35

 jsr wait60cycle

; line=36

 jsr wait60cycle

; line=37

 jsr wait60cycle

; line=38

 lda #$7D
 ldx #$00
 ldy #$00
 sta hposp3
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=39

 jsr wait60cycle

; line=40

h0 lda #$73
 sta hposp0

 DLINEW dli48



dli48
; line=48
 lda >fnt+$400*$01
h1 ldx #$74
 sta $d40a
 sta chbase
 stx hposp0

 DLINEW dli56



dli56
; line=56
h2 lda #$73
 ldx #$00
 ldy #$00
 sta $d40a
 sta hposp0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
; cmp byt2

; line=57

 jsr wait60cycle

; line=58

 lda #$87
 sta hposm2

 DLINEW dli64



dli64
; line=64
h3 lda #$74
 ldx #$00
 ldy #$00
 sta $d40a
 sta hposp0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
; cmp byt2

; line=65

 jsr wait60cycle

; line=66

 jsr wait60cycle

; line=67

 jsr wait60cycle

; line=68

 jsr wait60cycle

; line=69

 jsr wait60cycle

; line=70

 lda #$7F
 sta hposp3

 DLINEW dli72




dli72
; line=72

 lda >fnt+$400*$02
h4 ldx #$70
 ldy #$78
 sta $d40a
 sta chbase
 stx hposp0
 sty hposp2
 lda #$7A
 sta hposm3
; cmp byt2

; line=73

c9 lda #$14
 ldx #$03
 ldy #$30
 sta color1
 stx sizep3
 sty hposp3
c10 lda #$68
 sta colpm3
c50 ldx #$68
 stx $D016
c51 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=74

c11 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c52 ldx #$68
 stx $D016
c53 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=75

c12 lda #$18
 ldx #$C0
 ldy #$AE
 sta color0
 stx sizem
 sty hposm3
 lda #$00
 sta $d01e
c54 ldx #$68
 stx $D016
c55 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=76

c13 lda #$18
 ldx #$04
 ldy #$75
 sta color0
 stx gtictl
 sty hposp1
 lda #$00
 sta $d01e
c56 ldx #$68
 stx $D016
c57 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=77

c14 lda #$18
c15 ldx #$1A
 ldy #$00
 sta color0
 stx color2
 sty $d01e
 lda #$00
 sta $d01e
c58 ldx #$68
 stx $D016
c59 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=78

c16 lda #$18
 ldx #$02
 ldy #$00
 sta color0
 stx gtictl
 sty $d01e
 lda #$00
 sta $d01e
c60 ldx #$68
 stx $D016
c61 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=79

c17 lda #$18
 ldx #$03
 ldy #$B0
 sta color0
 stx sizep2
 sty hposp2
c18 lda #$68
 sta colpm2
c62 ldx #$68
 stx $D016
c63 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=80

c19 lda #$18
h5 ldx #$6C
 ldy #$00
 sta color0
 stx hposp0
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2

; line=81

c20 lda #$18
 ldx #$89
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c64 ldx #$68
 stx $D016
c65 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=82

c21 lda #$18
 ldx #$80
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c66 ldx #$68
 stx $D016
c67 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=83

c22 lda #$18
 ldx #$8A
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c68 ldx #$68
 stx $D016
c69 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=84

c23 lda #$18
 ldx #$AC
 ldy #$00
 sta color0
 stx hposm3
 sty $d01e
 lda #$00
 sta $d01e
c70 ldx #$68
 stx $D016
c71 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=85

c24 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c72 ldx #$68
 stx $D016
c73 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=86

c25 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c74 ldx #$68
 stx $D016
c75 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=87

c26 lda #$18
 ldx #$01
 ldy #$80
 sta color0
 stx sizep1
 sty hposm1
 lda #$00
 sta $d01e
c76 ldx #$68
 stx $D016
c77 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=88

c27 lda #$18
 ldx #$00
h6 ldy #$6D
 sta color0
 stx sizep1
 sty hposp0
 lda #$8A
 sta hposm1
 cmp byt2

; line=89

c28 lda #$18
 ldx #$80
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c78 ldx #$68
 stx $D016
c79 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=90

c29 lda #$18
 ldx #$77
 ldy #$89
 sta color0
 stx hposp1
 sty hposm1
 lda #$00
 sta $d01e
c80 ldx #$68
 stx $D016
c81 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=91

c30 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c82 ldx #$68
 stx $D016
c83 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=92

c31 lda #$18
 ldx #$80
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c84 ldx #$68
 stx $D016
c85 ldy #$18
 sta $D01E
 lda #$00
 sty $D016
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=93

c32 lda #$18
 ldx #$78
 ldy #$87
 sta color0
 stx hposp1
 sty hposm1
 lda #$00
 sta $d01e
c86 ldy #$18
 sty $D016
 :2 nop
c87 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=94

 lda #$80
 ldx #$00
 ldy #$00
 sta hposm1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c88 ldy #$18
 sty $D016
 :2 nop
c89 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=95

 lda #$87
 ldx #$00
 ldy #$00
 sta hposm1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c90 ldy #$18
 sty $D016
 :2 nop
c91 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=96

 lda >fnt+$400*$03
c33 ldx #$18
h7 ldy #$70
 sta chbase
 stx color0
 sty hposp0
 lda #$00
 sta $d01e
 cmp byt2

; line=97

c34 lda #$18
 ldx #$80
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c92 ldy #$18
 sty $D016
 :2 nop
c93 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=98

c35 lda #$18
 ldx #$7A
 ldy #$86
 sta color0
 stx hposp1
 sty hposm1
 lda #$00
 sta $d01e
c94 ldy #$18
 sty $D016
 :2 nop
c95 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=99

c36 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c96 ldy #$18
 sty $D016
 :2 nop
c97 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=100

c37 lda #$18
 ldx #$85
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c98 ldy #$18
 sty $D016
 :2 nop
c99 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=101

c38 lda #$18
 ldx #$80
 ldy #$00
 sta color0
 stx hposm1
 sty $d01e
 lda #$00
 sta $d01e
c100 ldy #$18
 sty $D016
 :2 nop
c101 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=102

c39 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
c102 ldy #$18
 sty $D016
 :2 nop
c103 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=103

c40 lda #$18
 ldx #$7C
 ldy #$83
 sta color0
 stx hposp1
 sty hposm1
 lda #$00
 sta $d01e
c104 ldy #$18
 sty $D016
 :2 nop
c105 ldx #$68
 lda #$00
 sta $D01E
 lda #$00
 sta $D01E
 stx $D016
 nop
 lda #$00
 sta $D01E

; line=104

c41 lda #$18
h8 ldx #$74
 ldy #$00
 sta color0
 stx hposp0
 sty $d01e
 lda #$00
 sta $d01e
 cmp byt2

; line=105

c42 lda #$18
 ldx #$00
 ldy #$00
 sta color0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=106

c43 lda #$18
 ldx #$7E
c44 ldy #$0C
 sta color0
 stx hposp1
 sty colpm3
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=107

c45 lda #$0C
 sta colpm2

 DLINEW dli112




dli112
; line=112
h9 lda #$72
 ldx #$00
 ldy #$00
 sta $d40a
 sta hposp0
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
; cmp byt2

; line=113

 jsr wait60cycle

; line=114

 jsr wait60cycle

; line=115

 lda #$7C
 ldx #$00
 ldy #$00
 sta hposp1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=116

 jsr wait60cycle

; line=117

 lda #$7B
 ldx #$00
 ldy #$00
 sta hposp1
 stx $d01e
 sty $d01e
 lda #$00
 sta $d01e
 jsr wait36cycle

; line=118

 jsr wait60cycle

; line=119

 lda #$7A
 sta hposp1

 DLINEW dli120




dli120
; line=120
 lda >fnt+$400*$00
 sta $d40a
 sta chbase

; line=124
 lda #$F0
 ldx #$68
 sta sizem
 stx hposm2

; line=125
 lda #$01
 ldx #$00
 ldy #$90
 sta gtictl
 stx sizep2
 sty hposp2
c46 lda #$0A
 sta colpm2

; line=127
c47 lda #$00
c48 ldx #$08
 sta color1
 stx color2

 DLINEW dli128



dli128
; line=128
 lda >fnt+$400*$03
 ldx #$03
 ldy #$70
 sta $d40a
 sta chbase
 stx sizep1
 sty hposp1

 DLINEW dli144



dli144
; line=144
 lda >fnt+$400*$04
 sta $d40a
 sta chbase
 
 jmp nmiQuit


;--

wait60cycle
 jsr _rts
 cmp byt3
wait44cycle
 inc byt3
 nop
wait36cycle
 jsr _rts
wait24cycle
 jsr _rts
_rts rts


nmi
 sta regA
 stx regX
 sty regY

 bit $d40f
 bpl vbl

dliv jmp dli

vbl
 sta $d40f

 inc cloc

 mwa #ant $d402
 mva #scr40 $d400

 lda >fnt+$400*$00
 sta chbase
c0 lda #$00
 sta colbak
c1 lda #$18
 sta color0
c2 lda #$68
 sta color1
c3 lda #$4A
 sta color2
c4 lda #$74
 sta color3
 lda #$02
 sta gtictl
 lda #$00
 sta sizep1
 sta sizep2
 sta sizep3
 sta sizem
 sta sizep0 
 lda #$7D
 sta hposp1
 lda #$7C
 sta hposp2
; lda #$7C
 sta hposp3
 lda #$7B
 sta hposm1
 lda #$84
 sta hposm2
 lda #$7B
 sta hposm3
c5 lda #$0C
 sta colpm1
c6 lda #$1A
 sta colpm2
c7 lda #$14
 sta colpm3
h0_ lda #$74
 sta hposp0
c8 lda #$ff
 sta colpm0

 mwa #dli dliv+1

play_stop jsr cmc.PLAYERCMC+6

 lda $d010
 bne nmiQuit

 lda #{rts}
 sta return

 lda #{nop}
 sta play_stop
 sta play_stop+1
 sta play_stop+2

 jsr reset_pokey

nmiQuit
 lda regA
 ldx regX
 ldy regY
 rti

 icl 'stars_add.asm'

 icl 'grat.fad'

lhpos dta l(h0_,h0,h1,h2,h3,h4,h5,h6,h7,h8,h9)
hhpos dta h(h0_,h0,h1,h2,h3,h4,h5,h6,h7,h8,h9)

*--- CMC module

.local cmc

music	equ *

DEFSONG	equ 0


	cmc_relocator 'msx_cmc\hlejnia.cmc' , music

	.sav [6] ?length

init
	lda #$70
	ldx #<MUSIC
	ldy #>MUSIC
	jsr PLAYERCMC+3
	lda #$00
	ldx #DEFSONG
	jsr PLAYERCMC+3
	rts

	icl 'msx_cmc\playcmc.asm'

.endl


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

;--
 run main

 opt l-
 icl 'grat.mac'

 icl 'msx_cmc\cmc_relocator.mac'
