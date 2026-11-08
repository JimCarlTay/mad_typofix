	include "cpu/6809/include/common.inc"
	include "cpu/6x09/include/handlers/values_edit.inc"

	global sprite_viewer

	section code

sprite_viewer:
		ldy	#d_screen_xys_list
		jsr	print_xy_string_list

		ldd	#$0
		std	r_sprite_num

		lda	#$70
		sta	r_sprite_pos_x

		lda	#$80
		sta	r_sprite_pos_y

		clra
		sta	r_sprite_flip_x
		sta	r_sprite_flip_y

		ldx	#d_ve_settings
		ldy	#d_ve_list

		jsr	values_edit_handler
		rts

; Per MAME (reformattd)

; * Byte | Bit(s)   | Use
; * -----+-76543210-+----------------
; * SPRITE1 BASE
; *   0  | x------- | flip y
; *   0  | -x------ | flip x
; *   0  | -------x | sprite num (high bit)
; *   1  | xxxxxxxx | y position
; * SPRITE2 BASE
; *   0  | xxxxxxxx | x position
; *   1  | xxxxxxxx | sprite num

value_changed_cb:

		ldd	r_sprite_num
		stb	SPRITE2_BASE + 1

		ldb	r_sprite_flip_x
		beq	.skip_sprite_flip_x
		ora	#$40

	.skip_sprite_flip_x:
		ldb	r_sprite_flip_y
		beq	.skip_sprite_flip_y
		ora	#$80

	.skip_sprite_flip_y:
		sta	SPRITE1_BASE

		lda	r_sprite_pos_x
		sta	SPRITE2_BASE

		lda	r_sprite_pos_y
		sta	SPRITE1_BASE + 1
		rts


loop_input_cb:
		rts

	section data

d_ve_settings:
	VE_SETTINGS value_changed_cb, loop_input_cb

d_ve_list:
	VE_ENTRY VE_TYPE_WORD, VE_INPUT_EDGE, r_sprite_num, $1ff
	VE_ENTRY VE_TYPE_BYTE, VE_INPUT_RAW, r_sprite_pos_x, $ff
	VE_ENTRY VE_TYPE_BYTE, VE_INPUT_RAW, r_sprite_pos_y, $ff
	VE_ENTRY VE_TYPE_NIBBLE, VE_INPUT_EDGE, r_sprite_flip_x, $1
	VE_ENTRY VE_TYPE_NIBBLE, VE_INPUT_EDGE, r_sprite_flip_y, $1
	VE_LIST_END

d_screen_xys_list:
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 2), "SPRITE NUM"
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 3), "POS X"
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 4), "POS Y"
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 5), "FLIP X"
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 6), "FLIP Y"
	XY_STRING_LIST_END

	section bss

r_sprite_num:		dcb.w 1
r_sprite_pos_x:		dcb.w 1
r_sprite_pos_y:		dcb.b 1
r_sprite_flip_x:	dcb.b 1
r_sprite_flip_y:	dcb.b 1
