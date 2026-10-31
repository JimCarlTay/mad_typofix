	include "cpu/z80/include/common.inc"
	include "cpu/z80/include/handlers/menu.inc"

	global memory_viewer_menu

	section code

memory_viewer_menu:
		ld	ix, d_str_menu_title
		ld	iy, d_menu_list
		call	menu_handler
		ret

view_bg_ram:
		ld	ix, BG_TILE_BASE
		jr	view_memory

view_bg_attr_ram:
		ld	ix, BG_TILE_ATTR_BASE
		jr	view_memory

view_rom_space:
		ld	ix, ROM_BASE
		jr	view_memory

view_sprite_ram:
		ld	ix, SPRITE_BASE
		jr	view_memory

view_txt_tile_ram:
		ld	ix, TXT_TILE_BASE
		jr	view_memory

view_txt_tile_attr_ram:
		ld	ix, TXT_TILE_ATTR_BASE
		jr	view_memory
view_work_ram:
		ld	ix, WORK_RAM_BASE

view_memory:
		ld	iy, $0			; no callback
		call	memory_viewer_handler
		ret

	section data

d_menu_list:
	MENU_ENTRY view_bg_ram, d_str_bg_ram, ME_FLAG_NONE
	MENU_ENTRY view_bg_attr_ram, d_str_bg_attr_ram, ME_FLAG_NONE
	MENU_ENTRY view_rom_space, d_str_rom_space, ME_FLAG_NONE
	MENU_ENTRY view_sprite_ram, d_str_sprite_ram, ME_FLAG_NONE
	MENU_ENTRY view_txt_tile_ram, d_str_txt_tile_ram, ME_FLAG_NONE
	MENU_ENTRY view_txt_tile_attr_ram, d_str_txt_tile_attr_ram, ME_FLAG_NONE
	MENU_ENTRY view_work_ram, d_str_work_ram, ME_FLAG_NONE
	MENU_LIST_END

d_str_menu_title:		STRING "MEMORY VIEWER MENU"

d_str_bg_ram:			STRING "BG RAM"
d_str_bg_attr_ram:		STRING "BG ATTR RAM"
d_str_rom_space:		STRING "ROM SPACE"
d_str_sprite_ram:		STRING "SPRITE RAM"
d_str_txt_tile_ram:		STRING "TXT TILE RAM"
d_str_txt_tile_attr_ram:	STRING "TXT TILE ATTR RAM"
d_str_work_ram:			STRING "WORK RAM"
