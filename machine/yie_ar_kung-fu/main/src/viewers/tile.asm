	include "cpu/6809/include/common.inc"

	global tile_viewer

	section code

; no need to setup palettes as palette colors are hardcoded on this board
TILE_OFFSET_MASK	equ $1ff

tile_viewer:
		ldd	#TILE_OFFSET_MASK
		ldx	#seek_xy_cb
		ldy	#draw_tile_cb
		jsr	tile_8x8_viewer_handler
		rts

seek_xy_cb:
		RSUB	screen_seek_xy
		rts

; params:
;  d = tile (word)
;  x = already at location in tile ram
;  tile ram  = TTTT TTTT 
;  color ram = TTYX PPPP 
draw_tile_cb:

		stb	1, x
		asla
		asla
		asla
		asla
		sta	, x
		rts
