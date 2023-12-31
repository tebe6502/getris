zpage	equ	$f0	; 11 bytes


* 'Inflate'
; Written by Piotr Fusik (a.k.a. Fox/Taquart)
; Purpose: to uncompress Deflate format compressed data on 6502-based system.

* const
; Maximum length of a Huffman code
MAX_BITS      equ	15
; Index in bitsCount, bitsPointer_l and bitsPointer_h
; for temporary tree and literal/length tree
PRIMARY_TREE  equ	0
; Index in bitsCount, bitsPointer_l and bitsPointer_h for distance tree
DISTANCE_TREE equ	MAX_BITS
; Size of each of bitsCount, bitsPointer_l and bitsPointer_h
TREES_SIZE    equ	2*MAX_BITS

* page zero
; (public) Pointer to compressed data
inputPointer            equ	zpage    ; 2 bytes
; (public) Pointer to uncompressed data
outputPointer           equ	zpage+2  ; 2 bytes
; Local variables
getBit_hold             equ	zpage+10 ; 1 byte

inflateDynamicBlock_cnt equ	zpage+4  ; 1 byte
inflateCodes_src        equ	zpage+4  ; 2 bytes
buildHuffmanTree_src    equ	zpage+4  ; 2 bytes
getNextLength_last      equ	zpage+4  ; 1 byte
getNextLength_index     equ	zpage+5  ; 1 byte

buildHuffmanTree_ptr    equ	zpage+6  ; 2 bytes
fetchCode_ptr           equ	zpage+6  ; 2 bytes
getBits_tmp             equ	zpage+6  ; 1 byte

moveBlock_len           equ	zpage+8  ; 2 bytes
inflateDynamicBlock_np  equ	zpage+8  ; 1 byte
inflateDynamicBlock_nd  equ	zpage+9  ; 1 byte

* code
*	org	inflate
* (public) inflate
; Decompress Deflate data pointed by inputPointer
; to memory at outputPointer

inflate
	mvy	#1	getBit_hold
	bne	inflate_2	!
inflate_1
	jsr	inflate_3
inflate_2
; Get a bit of EOF and two bits of block type
	ldx	#3
	lda	#0
	jsr	getBits
	lsr	@
	bcc	inflate_1
inflate_3
	bne	inflateCompressedBlock

* inflateCopyBlock
; Decompress 'stored' data block
inflateCopyBlock
; Ignore bits until byte boundary
	mvy	#1	getBit_hold
; Get 16-bit length
	ldx	#inputPointer
	mva	(0,x)	moveBlock_len
	mva	(inputPointer),y	moveBlock_len+1
; Skip length and one's complement length
	lda	#4
	add:sta	inputPointer
	scc:inc	inputPointer+1

* moveBlock
; Copy block of length moveBlock_len from (0,x) to output
moveBlock
	ldy	moveBlock_len
	beq	moveBlock_1
	ldy	#0
	inc	moveBlock_len+1
moveBlock_1
	mva	(0,x)	(outputPointer),y
	inw	0,x
	inw	outputPointer
	dec	moveBlock_len
	bne	moveBlock_1
	dec	moveBlock_len+1
	bne	moveBlock_1
	rts

* inflateCompressedBlock
; Decompress Huffman-coded data block
; A = 1: fixed, A = 2: dynamic
inflateCompressedBlock
	lsr	@
	bne	inflateDynamicBlock

* inflateFixedBlock
; Decompress Huffman-coded data block with default Huffman trees:
; literalCodeLength	:144	dta 8
;			:112	dta 9
; endCodeLength		:24	dta 7
;			:6	dta 8
; distanceCodeLength	:30	dta 5+DISTANCE_TREE
;			:2	dta 8
; (two 8-bit codes from primary tree are not used)
inflateFixedBlock
	ldx	#159
	stx	distanceCodeLength+32
	lda	#8
inflateFixedBlock_1
	sta	literalCodeLength-1,x
	sta	literalCodeLength+159-1,x-
	bne	inflateFixedBlock_1
	ldx	#112
	inc:rne	literalCodeLength+144-1,x-
	ldx	#24
	dec:rne	endCodeLength-1,x-
	ldx	#30
	lda	#5+DISTANCE_TREE
	sta:rne	distanceCodeLength-1,x-
	beq	inflateCodes	!

* inflateDynamicBlock
; Decompress Huffman-coded data block, reading Huffman trees first
inflateDynamicBlock
; numberOfPrimaryCodes = 257 + getBits(5)
	ldx	#5
;	lda	#1
	jsr	getBits
	sta	inflateDynamicBlock_np
; numberOfDistanceCodes = 1 + getBits(5)
	ldx	#5
	lda	#1+29+1
	jsr	getBits
	sta	inflateDynamicBlock_nd
; numberOfTemporaryCodes = 4 + getBits(4)
	lda:tax	#4
	jsr	getBits
	sta	inflateDynamicBlock_cnt
; Get lengths of temporary codes in order stored in tempCodeLengthOrder
	lda:tay	#0
inflateDynamicBlock_1
	ldx	#3		; A = 0
	jsr	getBits		; does not change Y
inflateDynamicBlock_2
	ldx	tempCodeLengthOrder,y
	sta	literalCodeLength,x
	lda	#0
	iny
	cpy	inflateDynamicBlock_cnt
	bcc	inflateDynamicBlock_1
	cpy	#19
	bcc	inflateDynamicBlock_2
	ror	literalCodeLength+19	+
; Build tree for temporary codes
	jsr	buildHuffmanTree

; Use temporary codes to get lengths for literal/length and distance codes
	ldx	#0
	ldy	#1
	stx	getNextLength_last
inflateDynamicBlock_3
	jsr	getNextLength
	sta	literalCodeLength,x+
	bne	inflateDynamicBlock_3
inflateDynamicBlock_4
	jsr	getNextLength
	sta	endCodeLength,x+
	cpx	inflateDynamicBlock_np
	bcc	inflateDynamicBlock_4
	lda	#0
	bcs	inflateDynamicBlock_6	!
inflateDynamicBlock_5
	sta	endCodeLength,x+
inflateDynamicBlock_6
	cpx	#1+29
	bcc	inflateDynamicBlock_5
inflateDynamicBlock_7
	jsr	getNextLength
	cmp	#0
	seq:adc	#DISTANCE_TREE-1	+
	sta	endCodeLength,x+
	cpx	inflateDynamicBlock_nd
	bcc	inflateDynamicBlock_7
	ror	endCodeLength,x	+

* inflateCodes
; Decompress data block basing on given Huffman trees
inflateCodes
	jsr	buildHuffmanTree
inflateCodes_1
	jsr	fetchPrimaryCode
	bcs	inflateCodes_2
; Literal code
        ldy     #0
	sta	(outputPointer),y
	inc	outputPointer
	bne	inflateCodes_1
	inc	outputPointer+1
	bcc	inflateCodes_1	!
; End of block
inflateCodes_ret
	rts
inflateCodes_2
	beq	inflateCodes_ret
; Repeat block
	jsr	getValue
	sta	moveBlock_len
	tya
	jsr	getBits
	sta	moveBlock_len+1
	ldx	#DISTANCE_TREE
	jsr	fetchCode
	jsr	getValue
	sec
	eor	#$ff
	adc	outputPointer
	sta	inflateCodes_src
	php
	tya
	jsr	getBits
	plp
	eor	#$ff
	adc	outputPointer+1
	sta	inflateCodes_src+1
	ldx	#inflateCodes_src
	jsr	moveBlock
	beq	inflateCodes_1	!

* buildHuffmanTree
; Build Huffman trees basing on code lengths.
; Lengths (in bits) are stored in *CodeLength tables.
; A byte with highest bit set marks end of length table.
buildHuffmanTree
	mwa	#literalCodeLength	buildHuffmanTree_src
; Clear bitsCount and bitsPointer_l
	ldy	#2*TREES_SIZE+1
	lda	#0
	sta:rne	bitsCount-1,y-
	beq	buildHuffmanTree_3	!
; Count number of codes of each length
buildHuffmanTree_2
	tax
	inc	bitsPointer_l,x
	iny
	bne	buildHuffmanTree_3
	inc	buildHuffmanTree_src+1
buildHuffmanTree_3
	lda	(buildHuffmanTree_src),y
	bpl	buildHuffmanTree_2
; Calculate pointer for each length
	ldx	#0
	lda	#<sortedCodes
	ldy	#>sortedCodes
	clc
buildHuffmanTree_4
	sta	bitsPointer_l,x
	tya:sta	bitsPointer_h,x
	lda	bitsPointer_l+1,x
	adc	bitsPointer_l,x	-
	scc:iny
	inx
	cpx	#TREES_SIZE
	bcc	buildHuffmanTree_4
	mva	#>literalCodeLength	buildHuffmanTree_src+1
	ldy	#0
	bcs	buildHuffmanTree_9	!
; Put codes into their place in sorted table
buildHuffmanTree_6
	beq	buildHuffmanTree_7
	tax
	mva	bitsPointer_l-1,x	buildHuffmanTree_ptr
	mva	bitsPointer_h-1,x	buildHuffmanTree_ptr+1
	tya
	ldy:inc	bitsCount-1,x
	sta	(buildHuffmanTree_ptr),y
	tay
buildHuffmanTree_7
	iny
	bne	buildHuffmanTree_9
	inc	buildHuffmanTree_src+1
	ldx	#MAX_BITS-1
	mva:rpl	bitsCount,x	literalCount,x-
buildHuffmanTree_9
	lda	(buildHuffmanTree_src),y
	bpl	buildHuffmanTree_6
	rts

* getNextLength
; Get next code length basing on temporary codes
getNextLength
	stx	getNextLength_index
	dey
	bne	getNextLength_1
; Fetch a temporary code
	jsr	fetchPrimaryCode
; Temporary code 0..15: put this length
	ldy	#1
	cmp	#16
	bcc	getNextLength_2
; Temporary code 16: repeat last length 3 + getBits(2) times
; Temporary code 17: put zero length 3 + getBits(3) times
; Temporary code 18: put zero length 11 + getBits(7) times
	tay
	ldx	tempExtraBits-16,y
	lda	tempBaseValue-16,y
	jsr	getBits
	cpy	#17
	tay
	lda	#0
	bcs	getNextLength_2
getNextLength_1
	lda	getNextLength_last
getNextLength_2
	sta	getNextLength_last
	ldx	getNextLength_index
	rts

* fetchPrimaryCode
; Read code basing on primary tree
fetchPrimaryCode
	ldx	#PRIMARY_TREE

* fetchCode
; Read code from input stream basing on tree given in X.
; Return low byte of code in A.
; For literal/length tree C is set if non-literal code.
fetchCode
	lda	#0
fetchCode_1
	jsr	getBit
	rol	@
	inx
	sub	bitsCount-1,x
	bcs	fetchCode_1
	adc	bitsCount-1,x	-
	cmp	literalCount-1,x
	sta	fetchCode_ptr
	ldy	bitsPointer_l-1,x
	mva	bitsPointer_h-1,x	fetchCode_ptr+1
	lda	(fetchCode_ptr),y
	rts

* getValue
; Read low byte of value (length or distance), basing on code A
getValue
	tay
	ldx	lengthExtraBits-1,y
	lda:pha	lengthBaseValue_l-1,y
	lda:tay	lengthBaseValue_h-1,y
	pla

* getBits
; Read X-bit number from input stream and add it to A.
; In case of carry, Y is incremented.
; If X > 8, only 8 bits are read.
; On return X holds number of unread bits: X = (X > 8 ? X - 8 : 0);
getBits
	cpx	#0
	beq	getBits_ret
	pha
	mva	#1	getBits_tmp
	pla
getBits_1
	jsr	getBit
	bcc	getBits_2
	add	getBits_tmp
	scc:iny
getBits_2
	dex
	beq	getBits_ret
	asl	getBits_tmp
	bcc	getBits_1
getBits_ret
	rts

* getBit
; Read single bit from input stream, returns it in C flag
getBit
	lsr	getBit_hold
	bne	getBit_ret
	pha
	tya:pha
	ldy     #0
	lda	(inputPointer),y
	inw	inputPointer
	ror	@	+
	sta	getBit_hold
	pla:tay
	pla
getBit_ret
	inc $d01a
	rts

* Tables for temporary codes
; Value is BaseValue + getBits(ExtraBits)

; Order, in which lengths of temporary codes are stored
tempCodeLengthOrder
	dta	b(16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15)

; Base values
tempBaseValue
	dta	b(3,3,11)

; Number of extra bits to read
tempExtraBits
	dta	b(2,3,7)

* Tables for length and distance codes
; Value is BaseValue + getBits(ExtraBits)

; Base values
lengthBaseValue_l
	dta	l(3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43)
	dta	l(51,59,67,83,99,115,131,163,195,227,258)
distanceBaseValue_l
	dta	l(1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385)
	dta	l(513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577)
lengthBaseValue_h
	dta	h(3,4,5,6,7,8,9,10,11,13,15,17,19,23,27,31,35,43)
	dta	h(51,59,67,83,99,115,131,163,195,227,258)
distanceBaseValue_h
	dta	h(1,2,3,4,5,7,9,13,17,25,33,49,65,97,129,193,257,385)
	dta	h(513,769,1025,1537,2049,3073,4097,6145,8193,12289,16385,24577)

; Number of extra bits to read
lengthExtraBits
	dta	b(0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4)
	dta	b(4,4,5,5,5,5,0)
distanceExtraBits
	dta	b(0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10)
	dta	b(11,11,12,12,13,13)


literalCount equ buffer
literalCodeLength equ literalCount
endCodeLength equ literalCodeLength+256
lengthCodeLength equ endCodeLength+1
distanceCodeLength equ lengthCodeLength+29
bitsCount equ distanceCodeLength+33
bitsPointer_l equ bitsCount+TREES_SIZE
bitsPointer_h equ bitsPointer_l+TREES_SIZE+1
sortedCodes equ bitsPointer_h+TREES_SIZE
*	org	*+256+1+29+30+2
