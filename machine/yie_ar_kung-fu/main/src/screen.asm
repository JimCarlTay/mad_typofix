	include "cpu/6809/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub

	section code

screen_init_dsub:
		ldx	#TILE_BASE
		ldy	#TILE_SIZE / 2
		ldd	#$10
		DSUB	memory_fill_word

		ldx	#SPRITE1_BASE
		ldy	#SPRITE1_SIZE
		lda	#$0
		DSUB	memory_fill

		ldx	#SPRITE2_BASE
		ldy	#SPRITE2_SIZE
		lda	#$0
		DSUB	memory_fill

		SEEK_XY	5, 0
		ldy	#d_str_version
		DSUB	print_string

		SEEK_XY	0, 1
		lda	#$2f
		ldb	#SCREEN_NUM_COLUMNS
		DSUB	print_char_repeat
		DSUB_RETURN

; params:
;  a = x
;  b = y
screen_seek_xy_dsub:
		SEEK_XY 0, 0

		asla
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
