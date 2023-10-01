
	icl 'atari.hea'

	org $80

regA	.ds 1
regX	.ds 1
regY	.ds 1

cloc	.ds 1

txt	= $a000

/* ----------------------------------------------------------- */


	org $2000

dlist	dta d'ppp'
	dta $44,a(txt)
	:23 dta 4
	dta $41,a(dlist)

/* ----------------------------------------------------------- */

main	lda:cmp:req 20

	sei
	mva #0 nmien
	sta dmactl

	mva #$fe portb

	mwa #nmi nmivec

	mva #$40 nmien


	jmp *

/* ----------------------------------------------------------- */

.local	NMI
	bit nmist
	bpl vbl

dli	rti

vbl	sta nmist

	sta regA
	stx regX
	sty regY

	inc cloc

	mwa #dlist dlptr
	mva #scr40 dmactl


	lda regA
	ldx regX
	ldy regY
	rti


.endl


/* ----------------------------------------------------------- */

	run main
