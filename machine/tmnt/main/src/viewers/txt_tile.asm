	include "cpu/68000/include/common.inc"

	global txt_tile_viewer

	section code

TILE_OFFSET_MASK	equ $7fff

txt_tile_viewer:
		lea	TXT_TILE_PALETTE_BASE + (PALETTE_ENTRY_SIZE * TVC_PALETTE_NUM), a0
		bsr	tvc_init

		moveq	#$0, d0
		move.w	#TILE_OFFSET_MASK, d1
		lea	txt_seek_xy_cb, a0
		lea	tvc_draw_tile_cb, a1
		bsr	tile_8x8_viewer_handler
		rts

txt_seek_xy_cb:
		RSUB	screen_seek_xy
		rts
