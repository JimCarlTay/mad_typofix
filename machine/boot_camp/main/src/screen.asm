	include "cpu/6309/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub

	section code

screen_init_dsub:
		ldx	#PALETTE_BASE
		ldw	#PALETTE_SIZE
		lda	#$00
		DSUB	memory_fill

		; bg1 tiles
		ldx	#K007121_G15_LAYER_A_TILE_BASE
		ldw	#K007121_G15_LAYER_A_TILE_SIZE
		lda	#$40
		DSUB	memory_fill

		ldx	#K007121_G15_LAYER_A_TILE_ATTR_BASE
		ldw	#K007121_G15_LAYER_A_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		; txt tiles
		ldx	#K007121_G15_LAYER_B_TILE_BASE
		ldw	#K007121_G15_LAYER_B_TILE_SIZE
		lda	#$40
		DSUB	memory_fill

		ldx	#K007121_G15_LAYER_B_TILE_ATTR_BASE
		ldw	#K007121_G15_LAYER_B_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		ldx	#K007121_G15_SPRITE_BASE
		ldw	#K007121_G15_SPRITE_SIZE
		lda	#$00
		DSUB	memory_fill

		lda	#$2c
		sta	REG_K007121_G15_C3

		lda	#REG_CTRL_K007121_G8
		sta	REG_CONTROL

		; bg2 tiles
		ldx	#K007121_G8_LAYER_A_TILE_BASE
		ldw	#K007121_G8_LAYER_A_TILE_SIZE
		lda	#$40
		DSUB	memory_fill

		ldx	#K007121_G8_LAYER_A_TILE_ATTR_BASE
		ldw	#K007121_G8_LAYER_A_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		; not used
		ldx	#K007121_G8_LAYER_B_TILE_BASE
		ldw	#K007121_G8_LAYER_B_TILE_SIZE
		lda	#$40
		DSUB	memory_fill

		ldx	#K007121_G8_LAYER_B_TILE_ATTR_BASE
		ldw	#K007121_G8_LAYER_B_TILE_ATTR_SIZE
		lda	#$00
		DSUB	memory_fill

		ldx	#K007121_G8_SPRITE_BASE
		ldw	#K007121_G8_SPRITE_SIZE
		lda	#$00
		DSUB	memory_fill

		lda	#$2c
		sta	REG_K007121_G8_C3

		lda	#REG_CTRL_K007121_G15
		sta	REG_CONTROL

		; txt color
		ldd	#$ffff
		std	(K007121_G15_LAYER_B_TILE_PALETTE_BASE + $2)

		SEEK_XY	3, 0
		ldy	#d_str_version
		DSUB	print_string

		SEEK_XY	0, 1
		lda	#$3c
		ldb	#SCREEN_NUM_COLUMNS
		DSUB	print_char_repeat
		DSUB_RETURN

; params:
;  a = x
;  b = y
screen_seek_xy_dsub:

		cmpb	#$5
		bge	.in_tile1
		SEEK_XY 0, 0
		bra	.do_seek

	.in_tile1:
		SEEK_XY 0, 5
		subb	#$5

	.do_seek:
		leax	a, x
		clra
		rold
		rold
		rold
		rold
		rold
		leax	d, x
		DSUB_RETURN
