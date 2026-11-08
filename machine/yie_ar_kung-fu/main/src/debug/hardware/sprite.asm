	include "cpu/6809/include/common.inc"
	include "cpu/6x09/include/handlers/memory_write.inc"

	global sprite_debug

	section code

sprite_debug:
		ldy	#d_screen_xys_list
		jsr	print_xy_string_list

		; setup initial values
		ldd	#$0080
		std	r_mw_buffer
		ldd	#$7000
		std	r_mw_buffer + 2

		ldx	#d_mw_settings
		jsr	memory_write_handler
		rts

; params:
;  x = txt ram location to set highlight
; we are also on the hook for clearing out the
; previous highlight
highlight_cb:
		rts

write_memory_cb:
		lda	r_mw_buffer
		sta	SPRITE1_BASE
		SEEK_XY	(SCREEN_START_X + 12), (SCREEN_START_Y + 15)
		RSUB	print_hex_byte

		lda	r_mw_buffer + 1
		sta	SPRITE1_BASE + 1
		SEEK_XY	(SCREEN_START_X + 15), (SCREEN_START_Y + 15)
		RSUB	print_hex_byte

		lda	r_mw_buffer + 2
		sta	SPRITE2_BASE
		SEEK_XY	(SCREEN_START_X + 12), (SCREEN_START_Y + 17)
		RSUB	print_hex_byte

		lda	r_mw_buffer + 3
		sta	SPRITE2_BASE + 1
		SEEK_XY	(SCREEN_START_X + 15), (SCREEN_START_Y + 17)
		RSUB	print_hex_byte
loop_cb:
		rts

	section data

d_mw_settings:		MW_SETTINGS 4, r_mw_buffer, highlight_cb, write_memory_cb, loop_cb

d_screen_xys_list:
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 13), "LAST WRITTEN"
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 15), "SPRITE1 RAM"
	XY_STRING SCREEN_START_X, (SCREEN_START_Y + 17), "SPRITE2 RAM"
	XY_STRING_LIST_END

	section bss

r_mw_buffer:		dcb.b 4
