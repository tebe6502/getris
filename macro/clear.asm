.proc	clear (.word ya .byte x) .reg
	sta adr
	sty adr+1

	ldy #0
	tya
loop	sta $ffff,y
adr	equ *-2
	iny
	bne loop
	inc adr+1
	dex
	bne loop

	rts
.endp
