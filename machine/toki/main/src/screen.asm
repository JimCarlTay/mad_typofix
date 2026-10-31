	include "cpu/68000/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub
	global screen_update_dsub

	section code

screen_init_dsub:
		lea	d_memory_fill_list, a0
		DSUB	memory_fill_list

		; text color
		move.w	#$fff, TXT_TILE_PALETTE_BASE + $16

		; text shadow color
		move.w	#$222, TXT_TILE_PALETTE_BASE + $8

		; background color
		move.w	#0, PALETTE_BASE + $41c
		move.w	#0, PALETTE_BASE + $61e

		SEEK_XY	5, 0
		lea	d_str_version, a0
		DSUB	print_string

		SEEK_XY	0, 1
		move.l	#'-', d0
		moveq	#SCREEN_NUM_COLUMNS, d1
		DSUB	print_char_repeat

		move.b	#$1, r_sprite_copy_req
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


; toki only updates the screen when MMIO_UPDATE_SCREEN
; is written to.
screen_update_dsub:
		move.w	sr, d0
		btst	#8, d0
		beq	.skip_update
		SCREEN_UPDATE

	.skip_update:
		DSUB_RETURN

	section data
	align 1

d_memory_fill_list:
	MEMORY_FILL_ENTRY BG_TILE_BASE, BG_TILE_SIZE, $0
	MEMORY_FILL_ENTRY FG_TILE_BASE, FG_TILE_SIZE, $0
	MEMORY_FILL_ENTRY SPRITE_BASE, SPRITE_SIZE, $0
	MEMORY_FILL_ENTRY TXT_TILE_BASE, TXT_TILE_SIZE, $0
	MEMORY_FILL_ENTRY PALETTE_BASE, PALETTE_SIZE, $0
	MEMORY_FILL_LIST_END
