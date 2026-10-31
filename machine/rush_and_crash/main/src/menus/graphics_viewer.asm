	include "cpu/6809/include/common.inc"
	include "cpu/6x09/include/handlers/menu.inc"

	global graphics_viewer_menu

	section code

graphics_viewer_menu:
		ldx	#d_str_menu_title
		ldy	#d_menu_list
		jsr	menu_handler
		rts

	section data

d_menu_list:
	MENU_ENTRY bg_tile_viewer, d_str_bg_tile, ME_FLAG_NONE
	MENU_ENTRY sprite_viewer, d_str_sprite_viewer, ME_FLAG_NONE
	MENU_ENTRY txt_tile_viewer, d_str_txt_tile, ME_FLAG_NONE
	MENU_LIST_END

d_str_menu_title:		STRING "GRAPHICS VIEWER"

d_str_bg_tile:			STRING "BG TILE"
d_str_sprite_viewer:		STRING "SPRITE VIEWER"
d_str_txt_tile:			STRING "TXT TILE"
