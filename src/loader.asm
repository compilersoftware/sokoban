	org 23760
	ld sp,23999
	ld a,7
	out (254),a
	ld hl, 16384
	ld de, 16385
	ld bc, 6144
	ld (hl),l
	ldir
	ld a,63
	ld hl, 22528
	ld de, 22529
	ld bc, 767
	ld (hl),a
	ldir
	ld a,255
	ld ix,32768
	ld de,6912
	scf
	call 1366
	ld hl,32768
	ld de,16384
	ld bc,6912
	ldir
	ld a,255
	ld ix,24000
	ld de,41535
	scf
	call 1366
	jp 24000
