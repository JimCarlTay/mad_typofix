	include "cpu/z80/include/common.inc"
	include "cpu/z80/include/handlers/menu.inc"

	global debug_hardware_menu

	section code

debug_hardware_menu:
		ld	ix, d_str_menu_title
		ld	iy, d_menu_list
		call	menu_handler
		ret

ram_find_bg_tile:
		ld	ix, BG_TILE_BASE
		jp	ram_find

ram_find_txt_tile:
		ld	ix, TXT_TILE_BASE
		jp	ram_find

ram_find_txt_tile_attr:
		ld	ix, TXT_TILE_ATTR_BASE
		jp	ram_find

ram_find_palette:
		ld	ix, PALETTE_BASE
		jp	ram_find

ram_find_palette_ext:
		ld	ix, PALETTE_EXT_BASE
		jp	ram_find

ram_find_sprite:
		ld	ix, SPRITE_BASE
		jp	ram_find

ram_find_work:
		ld	ix, WORK_RAM_BASE
		jp	ram_find

	section data

d_menu_list:
	MENU_ENTRY io_debug, d_str_io_debug, ME_FLAG_NONE
	MENU_ENTRY sprite_debug, d_str_sprite_debug, ME_FLAG_NONE
	MENU_ENTRY ram_find_none, d_str_ram_find_none, ME_FLAG_NONE
	MENU_ENTRY ram_find_bg_tile, d_str_ram_find_bg_tile, ME_FLAG_NONE
	MENU_ENTRY ram_find_txt_tile, d_str_ram_find_txt_tile, ME_FLAG_NONE
	MENU_ENTRY ram_find_txt_tile_attr, d_str_ram_find_txt_tile_attr, ME_FLAG_NONE
	MENU_ENTRY ram_find_palette, d_str_ram_find_palette, ME_FLAG_NONE
	MENU_ENTRY ram_find_palette_ext, d_str_ram_find_palette_ext, ME_FLAG_NONE
	MENU_ENTRY ram_find_sprite, d_str_ram_find_sprite, ME_FLAG_NONE
	MENU_ENTRY ram_find_work, d_str_ram_find_work, ME_FLAG_NONE
	MENU_LIST_END

d_str_menu_title:		STRING "DEBUG HARDWARE MENU"

d_str_io_debug:			STRING "IO DEBUG"
d_str_sprite_debug:		STRING "SPRITE DEBUG"

d_str_ram_find_bg_tile:		STRING "RAM FIND BG TILE"
d_str_ram_find_txt_tile:	STRING "RAM FIND TXT TILE"
d_str_ram_find_txt_tile_attr:	STRING "RAM FIND TXT TILE ATTR"
d_str_ram_find_none:		STRING "RAM FIND NONE"
d_str_ram_find_palette:		STRING "RAM FIND PALETTE"
d_str_ram_find_palette_ext:	STRING "RAM FIND PALETTE EXT"
d_str_ram_find_sprite:		STRING "RAM FIND SPRITE"
d_str_ram_find_work:		STRING "RAM FIND WORK"
