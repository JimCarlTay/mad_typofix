	include "cpu/6809/include/common.inc"
	include "cpu/6x09/include/handlers/menu.inc"

	global memory_viewer_menu

	section code

memory_viewer_menu:
		ldx	#d_str_menu_title
		ldy	#d_menu_list
		jsr	menu_handler
		rts

view_mmio_input:
		ldx	#$4e00
		bra	view_memory

view_rom_space:
		ldx	#ROM_BASE
		bra	view_memory

view_sprite1_ram:
		ldx	#SPRITE1_BASE
		bra	view_memory

view_sprite2_ram:
		ldx	#SPRITE2_BASE
		bra	view_memory

view_tile_ram:
		ldx	#TILE_BASE
		bra	view_memory

view_work_ram:
		ldx	#WORK_RAM_BASE
		bra	view_memory

view_memory:
		ldy	#$0			; no callback
		jsr	memory_viewer_handler
		rts

	section data

d_menu_list:
	MENU_ENTRY view_mmio_input, d_str_mmio_input, ME_FLAG_NONE
	MENU_ENTRY view_sprite1_ram, d_str_sprite1_ram, ME_FLAG_NONE
	MENU_ENTRY view_sprite2_ram, d_str_sprite2_ram, ME_FLAG_NONE
	MENU_ENTRY view_tile_ram, d_str_tile_ram, ME_FLAG_NONE
	MENU_ENTRY view_rom_space, d_str_rom_space, ME_FLAG_NONE
	MENU_ENTRY view_work_ram, d_str_work_ram, ME_FLAG_NONE
	MENU_LIST_END

d_str_menu_title:		STRING "MEMORY VIEWER MENU"

d_str_mmio_input:		STRING "MMIO INPUT"
d_str_rom_space:		STRING "ROM SPACE"
d_str_sprite1_ram:		STRING "SPRITE1 RAM"
d_str_sprite2_ram:		STRING "SPRITE2 RAM"
d_str_tile_ram:			STRING "TILE RAM"
d_str_work_ram:			STRING "WORK RAM"
