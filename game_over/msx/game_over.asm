;
; MUSIC init & play
; example by Raster/C.P.U., 2003-2004
;
;
VCOUNT		equ $d40b			;vertical screen lines counter address
VLINE		equ 16				;screen line for synchronization
STEREOMODE	equ 0				;0 => compile RMTplayer for mono 4 tracks

	org $4000					;RMT module is standard Atari binary file already
MODUL	ins "maynoaise.rmt",6				;include music RMT module

;								;1 => compile RMTplayer for stereo 8 tracks
;								;2 => compile RMTplayer for 4 tracks stereo L1 R2 R3 L4
;								;3 => compile RMTplayer for 4 tracks stereo L1 L2 R3 R4

	org $4400-3
	jmp start+3

	.ds $400

PLAYER	icl "rmtplayr.a65"			;include RMT player routine


start
	jmp *

	ldx #<MODUL					;low byte of RMT module to X reg
	ldy #>MODUL					;hi byte of RMT module to Y reg
	lda #0						;starting song line 0-255 to A reg
	jsr RASTERMUSICTRACKER		;Init
;Init returns instrument speed (1..4 => from 1/screen to 4/screen)
	tay
	lda tabpp-1,y
	sta acpapx2+1				;sync counter spacing
	
?tmp	equ 14
	
	lda #16+0-?tmp
	sta acpapx1+1				;sync counter init
;
;	lda #255
;	sta KEY						;no key pressed
;

?last   equ 156-?tmp

loop
acpapx1	lda #$ff				;parameter overwrite (sync line counter value)
	clc
acpapx2	adc #$ff				;parameter overwrite (sync line counter spacing)
	cmp #?last
	bcc lop4
	sbc #?last
lop4
	sta acpapx1+1
waipap
	cmp VCOUNT					;vertical line counter synchro
	bne waipap
	
;	lda #$0f
;	sta $d01a

	jsr RASTERMUSICTRACKER+3	;1 play
	
;	lda #0
;	sta $d01a

	lda $d010
	bne loop					;no => loop

stopmusic
	jsr RASTERMUSICTRACKER+9	;all sounds off
        rts

tabpp	dta ?last , 78-?tmp , 52-?tmp , 39-?tmp		;line counter spacing table for instrument speed from 1 to 4


	run start					;run addr
