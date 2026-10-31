	include "cpu/68000/include/common.inc"
	include "cpu/68000/include/handlers/menu.inc"

	global memory_viewer_menu

	section code

memory_viewer_menu:
		lea	d_str_menu_title, a0
		lea	d_menu_list, a1
		jsr	menu_handler
		rts

view_layer_a_tile_ram:
		lea	LAYER_A_TILE_BASE, a0
		bra	view_memory

view_layer_a_tile_attr_ram:
		lea	LAYER_A_TILE_ATTR_BASE, a0
		bra	view_memory

view_layer_a_tile_ext_ram:
		lea	LAYER_A_TILE_EXT_BASE, a0
		bra	view_memory

view_layer_b_tile_ram:
		lea	LAYER_B_TILE_BASE, a0
		bra	view_memory

view_layer_b_tile_attr_ram:
		lea	LAYER_B_TILE_ATTR_BASE, a0
		bra	view_memory

view_layer_b_tile_ext_ram:
		lea	LAYER_B_TILE_EXT_BASE, a0
		bra	view_memory

view_mmio_input:
		lea	$10a000, a0
		bra	view_memory

view_palette_ram:
		lea	PALETTE_BASE, a0
		bra	view_memory

view_rom_space:
		lea	ROM_BASE, a0
		bra	view_memory

view_sprite_ram:
		lea	SPRITE_BASE, a0
		bra	view_memory

view_txt_tile_ram:
		lea	TXT_TILE_BASE, a0
		bra	view_memory

view_txt_tile_attr_ram:
		lea	TXT_TILE_ATTR_BASE, a0
		bra	view_memory

view_txt_tile_ext_ram:
		lea	TXT_TILE_EXT_BASE, a0
		bra	view_memory

view_work_ram:
		lea	WORK_RAM_BASE, a0

view_memory:
		lea	$0, a1			; no callback
		jsr	memory_viewer_handler
		rts


	section data
	align 1

d_menu_list:
	MENU_ENTRY view_layer_a_tile_ram, d_str_layer_a_tile_ram, ME_FLAG_NONE
	MENU_ENTRY view_layer_a_tile_attr_ram, d_str_layer_a_tile_attr_ram, ME_FLAG_NONE
	MENU_ENTRY view_layer_a_tile_ext_ram, d_str_layer_a_tile_ext_ram, ME_FLAG_NONE
	MENU_ENTRY view_layer_b_tile_ram, d_str_layer_b_tile_ram, ME_FLAG_NONE
	MENU_ENTRY view_layer_b_tile_attr_ram, d_str_layer_b_tile_attr_ram, ME_FLAG_NONE
	MENU_ENTRY view_layer_b_tile_ext_ram, d_str_layer_b_tile_ext_ram, ME_FLAG_NONE
	MENU_ENTRY view_mmio_input, d_str_mmio_input, ME_FLAG_NONE
	MENU_ENTRY view_palette_ram, d_str_palette_ram, ME_FLAG_NONE
	MENU_ENTRY view_rom_space, d_str_rom_space, ME_FLAG_NONE
	MENU_ENTRY view_sprite_ram, d_str_sprite_ram, ME_FLAG_NONE
	MENU_ENTRY view_txt_tile_ram, d_str_txt_tile_ram, ME_FLAG_NONE
	MENU_ENTRY view_txt_tile_attr_ram, d_str_txt_tile_attr_ram, ME_FLAG_NONE
	MENU_ENTRY view_txt_tile_ext_ram, d_str_txt_tile_ext_ram, ME_FLAG_NONE
	MENU_ENTRY view_work_ram, d_str_work_ram, ME_FLAG_NONE
	MENU_LIST_END


d_str_menu_title:		STRING "MEMORY VIEWER MENU"

d_str_layer_a_tile_ram:		STRING "LAYER A TILE RAM"
d_str_layer_a_tile_attr_ram:	STRING "LAYER A TILE ATTR RAM"
d_str_layer_a_tile_ext_ram:	STRING "LAYER A TILE EXT RAM"
d_str_layer_b_tile_ram:		STRING "LAYER B TILE RAM"
d_str_layer_b_tile_attr_ram:	STRING "LAYER B TILE ATTR RAM"
d_str_layer_b_tile_ext_ram:	STRING "LAYER B TILE EXT RAM"
d_str_mmio_input:		STRING "MMIO INPUT"
d_str_palette_ram:		STRING "PALETTE RAM"
d_str_rom_space:		STRING "ROM SPACE"
d_str_sprite_ram:		STRING "SPRITE RAM"
d_str_txt_tile_ram:		STRING "TXT TILE RAM"
d_str_txt_tile_attr_ram:	STRING "TXT TILE ATTR RAM"
d_str_txt_tile_ext_ram:		STRING "TXT TILE EXT RAM"
d_str_work_ram:			STRING "WORK RAM"

