	include "cpu/z80/include/common.inc"

	global txt_tile_viewer

	section code

PALETTE_NUM		equ $2
TILE_OFFSET_MASK_UPPER	equ $7

txt_tile_viewer:

		ld	hl, d_palette_data
		ld	(r_nmi_copy_src), hl
		ld	hl, TXT_TILE_PALETTE_BASE + (TXT_TILE_PALETTE_ENTRY_SIZE / 2)
		ld	(r_nmi_copy_dst), hl
		ld	a, TXT_TILE_PALETTE_ENTRY_SIZE / 2
		ld	(r_nmi_copy_size), a

		call	wait_nmi_copy

		ld	hl, d_palette_ext_data
		ld	(r_nmi_copy_src), hl
		ld	hl, TXT_TILE_PALETTE_EXT_BASE + (TXT_TILE_PALETTE_ENTRY_SIZE / 2)
		ld	(r_nmi_copy_dst), hl
		ld	a, TXT_TILE_PALETTE_ENTRY_SIZE / 2
		ld	(r_nmi_copy_size), a

		call	wait_nmi_copy

		ld	b, $0
		ld	c, TILE_OFFSET_MASK_UPPER
		ld	ix, seek_xy_cb
		ld	iy, draw_tile_cb
		call	tile_8x8_viewer_handler
		ret

seek_xy_cb:
		RSUB	screen_seek_xy
		ret

; params:
;  bc = tile (word)
;  hl = already at location in tile ram
; tile ram = 0000 0TTT TTTT TTTT
draw_tile_cb:
		ld	(hl), c

		ld	a, b
		sla	a
		sla	a
		sla	a
		sla	a
		sla	a

		ld	bc, $400
		add	hl, bc

		or	$1	; palette number
		ld	(hl), a
		ret

	section data

d_palette_data:
	RS_TXT_TV_PALETTE_DATA

d_palette_ext_data:
	RS_TXT_TV_PALETTE_EXT_DATA
