	include "cpu/6309/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub

	section code

screen_init_dsub:
		ldx	#PALETTE_BASE
		ldw	#PALETTE_SIZE
		lda	#$00
		DSUB	memory_fill

		; fill with spaces
		ldx	#TXT_TILE_BASE
		ldw	#TXT_TILE_SIZE
		lda	#$10
		DSUB	memory_fill

		ldx	#LAYER_A_TILE_BASE
		ldw	#LAYER_A_TILE_SIZE
		lda	#$10
		DSUB	memory_fill

		ldx	#LAYER_B_TILE_BASE
		ldw	#LAYER_B_TILE_SIZE
		lda	#$10
		DSUB	memory_fill

		ldx	#TXT_TILE_ATTR_BASE
		ldw	#TXT_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		ldx	#LAYER_A_TILE_ATTR_BASE
		ldw	#LAYER_A_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		ldx	#LAYER_B_TILE_ATTR_BASE
		ldw	#LAYER_B_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		ldx	#LAYER_A_TILE_SCROLL_BASE
		ldw	#LAYER_A_TILE_SCROLL_SIZE
		clra
		DSUB	memory_fill

		ldx	#LAYER_B_TILE_SCROLL_BASE
		ldw	#LAYER_B_TILE_SCROLL_SIZE
		clra
		DSUB	memory_fill

		ldx	#SPRITE_BASE
		ldw	#SPRITE_SIZE
		clra
		DSUB	memory_fill

		; txt color
		ldd	#$ffff
		std	TXT_TILE_PALETTE_BASE + $2

		SEEK_XY	1, 0
		ldy	#d_str_version
		DSUB	print_string

		SEEK_XY	0, 1
		lda	#$2e
		ldb	#SCREEN_NUM_COLUMNS
		DSUB	print_char_repeat
		DSUB_RETURN

; params:
;  a = x
;  b = y
screen_seek_xy_dsub:
		SEEK_XY 0, 0

		leax	b, x
		clrb
		rord
		rord
		negd
		leax	d, x
		DSUB_RETURN
