	include "cpu/6809/include/common.inc"

	global screen_init_dsub
	global screen_init_no_scroll_clear_dsub
	global screen_seek_xy_dsub

	section code

screen_init_dsub:
		ldx	#TILE_SCROLL_BASE
		ldy	#TILE_SCROLL_SIZE
		lda	#$0
		DSUB	memory_fill


screen_init_no_scroll_clear_dsub:
		ldx	#TILE_BASE
		ldy	#TILE_SIZE
		lda	#$10
		DSUB	memory_fill

		ldx	#TILE_ATTR_BASE
		ldy	#TILE_ATTR_SIZE
		lda	#$0
		DSUB	memory_fill

		ldx	#SPRITE_BASE
		ldy	#SPRITE_SIZE
		lda	#$0
		DSUB	memory_fill

		SEEK_XY	3, 0
		ldy	#d_str_version
		DSUB	print_string

		SEEK_XY	0, 1
		lda	#$0c
		ldb	#SCREEN_NUM_COLUMNS
		DSUB	print_char_repeat
		DSUB_RETURN

; params:
;  a = x
;  b = y
screen_seek_xy_dsub:
		SEEK_XY 0, 0

		leax	a, x

		clra

		aslb
		rola
		aslb
		rola
		aslb
		rola
		aslb
		rola
		aslb
		rola
		aslb
		rola

		leax	d, x
		DSUB_RETURN
