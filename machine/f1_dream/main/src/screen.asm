	include "cpu/68000/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub

	section code

screen_init_dsub:

		lea	d_memory_fill_list, a0
		DSUB	memory_fill_list

		move.w	#$ffff, TXT_TILE_PALETTE_BASE
		move.w	#$ffff, TXT_TILE_PALETTE_BASE + 4

		SEEK_XY	5, 0
		lea	d_str_version, a0
		DSUB	print_string

		SEEK_XY	0, 1
		move.l	#'-', d0
		moveq	#SCREEN_NUM_COLUMNS, d1
		DSUB	print_char_repeat
		DSUB_RETURN

; in cases where we need to goto x, y location at runtime
; params:
;  d0 = x
;  d1 = y
screen_seek_xy_dsub:
		SEEK_XY	0, 0
		and.l	#$ff, d0
		and.l	#$ff, d1

		lsl.w	#1, d0
		lsl.w	#6, d1
		adda.l	d0, a6
		adda.l	d1, a6
		DSUB_RETURN

	section data
	align 1

d_memory_fill_list
	MEMORY_FILL_ENTRY TXT_TILE_BASE, TXT_TILE_SIZE, $20
	MEMORY_FILL_ENTRY PALETTE_BASE, PALETTE_SIZE, $0
	MEMORY_FILL_LIST_END
