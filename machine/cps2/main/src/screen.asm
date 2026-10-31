	include "cpu/68000/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub
	global screen_update_palette_dsub

	section code

screen_init_dsub:

		move.b	#$0, REG_OBJECT_RAM_BANK
		lea	d_memory_fill_list, a0
		DSUB	memory_fill_list
		move.b	#$1, REG_OBJECT_RAM_BANK

		move.w	#SCROLL1_BASE / 256, REGA_SCROLL1_BASE
		move.w	#SCROLL2_BASE / 256, REGA_SCROLL2_BASE
		move.w	#SCROLL3_BASE / 256, REGA_SCROLL3_BASE
		move.w	#ROW_SCROLL_BASE / 256, REGA_ROW_SCROLL_BASE

		; the combination of these 2 values should enable all
		; scroll layers and star layers
		move.w	#$12fe, REGB_LAYER_CTRL
		move.w	#$3e, REGA_VIDEO_CONTROL

		; should cause all palette regions to get copied
		move.w	#$3f, REGB_PALETTE_CTRL

		move.w	#$ffc0, REGA_SCROLL1_X
		move.w	#$0, REGA_SCROLL1_Y

		RS_SI_PALETTE_SETUP

	ifd _SCREEN_TATE_
		SEEK_XY	3, 0
	else
		SEEK_XY	13, 0
	endif
		lea	d_str_version, a0
		DSUB	print_string

		SEEK_XY	0, 1
		move.l	#'-', d0
		moveq	#SCREEN_NUM_COLUMNS, d1
		DSUB	print_char_repeat

		SEEK_XY	((SCREEN_NUM_COLUMNS - _ROMSET_STR_LENGTH_) - 1), 1
		lea	d_str_romset, a0
		DSUB	print_string
; this function doesn't appear to be safe to run on
; hardware when interrupts are enabled.  Presumably
; the vblank interrupt is firing while the scanline is
; 262.
screen_update_palette_dsub:
		move.w	REGB_SCANLINE, D0
		cmp.w	#262, D0
		bne	screen_update_palette_dsub
		move.w	#PALETTE_BASE / 256, REGA_PALETTE_BASE
		DSUB_RETURN

; in cases where we need to goto x, y location at runtime
; params:
;  d0 = x
;  d1 = y
screen_seek_xy_dsub:
		SEEK_XY	0, 0
		and.l	#$ff, d0
		and.l	#$ff, d1
	ifd _SCREEN_TATE_
		lsl.l	#2, d0
		lsl.l	#7, d1
		adda.l	d0, a6
		suba.l	d1, a6
	else
		lsl.l	#7, d0
		lsl.l	#2, d1
		adda.l	d0, a6
		adda.l	d1, a6
	endif
		DSUB_RETURN

	section data
	align 1

d_memory_fill_list
	; this first one being $20 is a bit of a hack for now, its
	; because mercs uses tile_group $0 so filling with $0 results
	; in the screen being filled with "0" tiles.
	MEMORY_FILL_ENTRY SCROLL1_BASE, SCROLL1_SIZE, $20
	MEMORY_FILL_ENTRY SCROLL2_BASE, SCROLL2_SIZE, $0
	MEMORY_FILL_ENTRY SCROLL3_BASE, SCROLL3_SIZE, $0
	MEMORY_FILL_ENTRY OBJECT_BASE, OBJECT_SIZE, $0
	MEMORY_FILL_ENTRY ROW_SCROLL_BASE, ROW_SCROLL_SIZE, $0
	MEMORY_FILL_ENTRY PALETTE_BASE, PALETTE_SIZE, $0
	MEMORY_FILL_LIST_END
