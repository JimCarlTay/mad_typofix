	include "cpu/6809/include/common.inc"

	global txt_tile_viewer

	section code

; no need to setup palettes as palette colors are hardcoded on this board
TILE_OFFSET_MASK	equ $ff

txt_tile_viewer:
		ldd	#TILE_OFFSET_MASK
		ldx	#txt_tile_seek_xy_cb
		ldy	#txt_tile_draw_tile_cb
		jsr	tile_8x8_viewer_handler
		rts

txt_tile_seek_xy_cb:
		RSUB	screen_seek_xy
		rts

; params:
;  d = tile (word)
;  x = already at location in tile ram
;  ???? PPTT TTTT TTTT
txt_tile_draw_tile_cb:
		stb	,x
		rts
