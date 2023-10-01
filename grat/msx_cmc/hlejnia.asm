
music	equ $4000

DEFSONG	equ 0


	cmc_relocator 'hlejnia.cmc' , music

	org music
	.sav [6] ?length


	org $2000
main

         lda #$70
         ldx #<MUSIC
         ldy #>MUSIC
         jsr PLAYERCMC+3
         lda #$00
         ldx #DEFSONG
         jsr PLAYERCMC+3

loop
	lda:cmp:req 20

	jsr PLAYERCMC+6

	jmp loop

	icl 'playcmc.asm'

	run main

	opt l-
	icl 'cmc_relocator.mac'