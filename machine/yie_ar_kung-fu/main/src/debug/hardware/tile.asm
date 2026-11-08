	include "cpu/6809/include/common.inc"
	include "cpu/6x09/include/handlers/memory_write.inc"

	global tile_debug

	section code

tile_debug:
		; setup initial values
		ldd	#$00bd
		std	r_mw_buffer

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
		ldx	#TILE_BASE + $4a0
		jsr	memory_write_generic_write
loop_cb:
		rts

	section data

d_mw_settings:		MW_SETTINGS 2, r_mw_buffer, highlight_cb, write_memory_cb, loop_cb

	section bss

r_mw_buffer:		dcb.b 2
