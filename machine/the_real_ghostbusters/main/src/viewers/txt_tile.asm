	include "cpu/6309/include/common.inc"

	global txt_tile_viewer

	section code

; no need to setup palettes as palette colors are hardcoded on this board
TILE_OFFSET_MASK	equ $3ff

txt_tile_viewer:
		RSUB	screen_init

		SEEK_XY	SCREEN_START_X, SCREEN_START_Y
		ldy	#d_str_title
		RSUB	print_string

		ldd	#TILE_OFFSET_MASK
		ldx	#txt_seek_xy_cb
		ldy	#txt_draw_tile_cb
		jsr	tile_8x8_viewer_handler
		rts

txt_seek_xy_cb:
		RSUB	screen_seek_xy
		rts

; params:
;  d = tile (word)
;  x = already at location in tile ram
;  ???? PPTT TTTT TTTT
txt_draw_tile_cb:
		std	,x
		rts

	section data

d_str_title:	STRING "TXT TILE VIEWER"
