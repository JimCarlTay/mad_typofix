	include "cpu/6309/include/common.inc"
	include "cpu/6x09/include/handlers/menu.inc"

	global memory_viewer_menu

	section code

memory_viewer_menu:
		ldy	#d_str_menu_title
		ldy	#d_menu_list
		jsr	menu_handler
		rts

view_k007121_10e_layer_a_tile_ram:
		ldx	#K007121_10E_LAYER_A_TILE_BASE
		bra	view_memory

view_k007121_10e_layer_b_tile_ram:
		ldx	#K007121_10E_LAYER_B_TILE_BASE
		bra	view_memory

view_k007121_10e_sprite_ram:
		ldx	#K007121_10E_SPRITE_BASE
		bra	view_memory

view_k007121_18e_layer_a_tile_ram:
		ldx	#K007121_18E_LAYER_A_TILE_BASE
		bra	view_memory

view_k007121_18e_layer_b_tile_ram:
		ldx	#K007121_18E_LAYER_B_TILE_BASE
		bra	view_memory

view_k007121_18e_sprite_ram:
		ldx	#K007121_18E_SPRITE_BASE
		bra	view_memory

view_mmio_input:
		ldx	#$0000
		bra	view_memory

view_palette_ram:
		ldx	#PALETTE_BASE
		bra	view_memory

view_rom_space:
		ldx	#ROM_BASE
		bra	view_memory

view_rom_bank_space:
		ldx	#$6000
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
	MENU_ENTRY view_k007121_10e_layer_a_tile_ram, d_str_k007121_10e_layer_a_tile, ME_FLAG_NONE
	MENU_ENTRY view_k007121_10e_layer_b_tile_ram, d_str_k007121_10e_layer_b_tile, ME_FLAG_NONE
	MENU_ENTRY view_k007121_10e_sprite_ram, d_str_k007121_10e_sprite, ME_FLAG_NONE
	MENU_ENTRY view_k007121_18e_layer_a_tile_ram, d_str_k007121_18e_layer_a_tile, ME_FLAG_NONE
	MENU_ENTRY view_k007121_18e_layer_b_tile_ram, d_str_k007121_18e_layer_b_tile, ME_FLAG_NONE
	MENU_ENTRY view_k007121_18e_sprite_ram, d_str_k007121_18e_sprite, ME_FLAG_NONE
	MENU_ENTRY view_mmio_input, d_str_mmio_input, ME_FLAG_NONE
	MENU_ENTRY view_palette_ram, d_str_palette_ram, ME_FLAG_NONE
	MENU_ENTRY view_rom_space, d_str_rom_space, ME_FLAG_NONE
	MENU_ENTRY view_rom_bank_space, d_str_rom_bank_space, ME_FLAG_NONE
	MENU_ENTRY view_work_ram, d_str_work_ram, ME_FLAG_NONE
	MENU_LIST_END

d_str_menu_title:		STRING "MEMORY VIEWER MENU"

d_str_k007121_10e_layer_a_tile:	STRING "K007121 10E LAYER A TILE"
d_str_k007121_10e_layer_b_tile:	STRING "K007121 10E LAYER B TILE"
d_str_k007121_10e_sprite:	STRING "K007121 10E SPRITE"
d_str_k007121_18e_layer_a_tile:	STRING "K007121 18E LAYER A TILE"
d_str_k007121_18e_layer_b_tile:	STRING "K007121 18E LAYER B TILE"
d_str_k007121_18e_sprite:	STRING "K007121 18E SPRITE"
d_str_mmio_input:		STRING "MMIO INPUT"
d_str_palette_ram:		STRING "PALETTE RAM"
d_str_rom_space:		STRING "ROM SPACE"
d_str_rom_bank_space:		STRING "ROM BANK SPACE"
d_str_work_ram:			STRING "WORK RAM"
