	include "cpu/68000/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub


	section code

screen_init_dsub:

		; Upper nibble seems to be a y pixel offset
		; when drawing.  Lower is related to layer order
		move.b	#$78, REG_SCREEN_PRIORITY

		lea	d_memory_fill_list, a0
		DSUB	memory_fill_list

		move.w	#$0, REG_SPRITE_COPY

		; text color
		lea	TXT_TILE_PALETTE_BASE + $1e, a0
		move.w	#$0fff, (a0)

		; text shadow
		lea	TXT_TILE_PALETTE_BASE + $2, a0
		move.w	#$0111, (a0)

		; background color ($0)
		; background color ($400)
		; background color ($600)

		SEEK_XY	7, 0
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

		lsl.w	#2, d0
		lsl.w	#8, d1
		adda.l	d0, a6
		adda.l	d1, a6
		DSUB_RETURN

	section data
	align 1

d_memory_fill_list:
	MEMORY_FILL_ENTRY TXT_TILE_BASE, TXT_TILE_SIZE, $0
	MEMORY_FILL_ENTRY SPRITE_BASE, SPRITE_SIZE, $0
	MEMORY_FILL_ENTRY PALETTE_BASE, PALETTE_SIZE, $0
	MEMORY_FILL_ENTRY LAYER_A_TILE_BASE, LAYER_A_TILE_SIZE, $0
	MEMORY_FILL_ENTRY LAYER_B_TILE_BASE, LAYER_B_TILE_SIZE, $0
	MEMORY_FILL_LIST_END
