	include "cpu/konami2/include/common.inc"

	global screen_init_dsub
	global screen_seek_xy_dsub

	section code

screen_init_dsub:

		; bank to palette ram
		lda	#CTRL_PALETTE_BANK
		sta	REG_CONTROL

		MEMORY_FILL16 #PALETTE_BASE, #(PALETTE_SIZE / 2), #$0
		WATCHDOG

		; font color
		ldd	#$ffff
		std	TXT_TILE_PALETTE_BASE + $2

		clr	REG_CONTROL

		; fill tiles with spaces
		MEMORY_FILL16 #TXT_TILE_BASE, #(TXT_TILE_SIZE/2), #$1010
		MEMORY_FILL16 #LAYER_A_TILE_BASE, #(LAYER_A_TILE_SIZE/2), #$1010
		MEMORY_FILL16 #LAYER_B_TILE_BASE, #(LAYER_B_TILE_SIZE/2), #$1010
		WATCHDOG

		MEMORY_FILL16 #TXT_TILE_ATTR_BASE, #(TXT_TILE_ATTR_SIZE / 2), #$0
		MEMORY_FILL16 #LAYER_A_TILE_ATTR_BASE, #(LAYER_B_TILE_ATTR_SIZE / 2), #$0
		MEMORY_FILL16 #LAYER_B_TILE_ATTR_BASE, #(LAYER_B_TILE_ATTR_SIZE / 2), #$0
		WATCHDOG


		MEMORY_FILL16 #LAYER_A_TILE_SCROLL_BASE, #(LAYER_A_TILE_SCROLL_SIZE / 2), #$0
		MEMORY_FILL16 #LAYER_B_TILE_SCROLL_BASE, #(LAYER_B_TILE_SCROLL_SIZE / 2), #$0
		WATCHDOG

		lda	#CTRL_SPRITE_BANK
		sta	REG_CONTROL

		MEMORY_FILL16 #SPRITE_BASE, #(SPRITE_SIZE / 2), #$0
		WATCHDOG

		clr	REG_CONTROL

		; -'s on 2nd line
		SEEK_XY 0, 1
		CHAR_REPEAT #$79, #SCREEN_NUM_COLUMNS

		SEEK_XY 5,0
		ldy	#d_str_version
		DSUB	print_string
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
