	include "cpu/konami2/include/common.inc"
	include "cpu/6x09/include/print_error.inc"
	include "cpu/6x09/include/handlers/error.inc"

	global d_ec_list

	section data

d_ec_list:
	EC_ENTRY EC_PALETTE_RC_ADDRESS, PRINT_ERROR_MEMORY, d_str_palette_ram_address
	EC_ENTRY EC_PALETTE_RC_DATA, PRINT_ERROR_MEMORY, d_str_palette_ram_data
	EC_ENTRY EC_PALETTE_RC_MARCH, PRINT_ERROR_MEMORY, d_str_palette_ram_march
	EC_ENTRY EC_PALETTE_RC_OUTPUT, PRINT_ERROR_ADDRESS, d_str_palette_ram_output
	EC_ENTRY EC_PALETTE_RC_WRITE, PRINT_ERROR_ADDRESS, d_str_palette_ram_write

	EC_ENTRY EC_TILE_RC_ADDRESS, PRINT_ERROR_MEMORY, d_str_tile_ram_address
	EC_ENTRY EC_TILE_RC_DATA, PRINT_ERROR_MEMORY, d_str_tile_ram_data
	EC_ENTRY EC_TILE_RC_MARCH, PRINT_ERROR_MEMORY, d_str_tile_ram_march
	EC_ENTRY EC_TILE_RC_OUTPUT, PRINT_ERROR_ADDRESS, d_str_tile_ram_output
	EC_ENTRY EC_TILE_RC_WRITE, PRINT_ERROR_ADDRESS, d_str_tile_ram_write

	EC_ENTRY EC_TILE_ATTR_RC_ADDRESS, PRINT_ERROR_MEMORY, d_str_tile_attr_ram_address
	EC_ENTRY EC_TILE_ATTR_RC_DATA, PRINT_ERROR_MEMORY, d_str_tile_attr_ram_data
	EC_ENTRY EC_TILE_ATTR_RC_MARCH, PRINT_ERROR_MEMORY, d_str_tile_attr_ram_march
	EC_ENTRY EC_TILE_ATTR_RC_OUTPUT, PRINT_ERROR_ADDRESS, d_str_tile_attr_ram_output
	EC_ENTRY EC_TILE_ATTR_RC_WRITE, PRINT_ERROR_ADDRESS, d_str_tile_attr_ram_write

	EC_ENTRY EC_SPRITE_RC_ADDRESS, PRINT_ERROR_MEMORY, d_str_sprite_ram_address
	EC_ENTRY EC_SPRITE_RC_DATA, PRINT_ERROR_MEMORY, d_str_sprite_ram_data
	EC_ENTRY EC_SPRITE_RC_MARCH, PRINT_ERROR_MEMORY, d_str_sprite_ram_march
	EC_ENTRY EC_SPRITE_RC_OUTPUT, PRINT_ERROR_ADDRESS, d_str_sprite_ram_output
	EC_ENTRY EC_SPRITE_RC_WRITE, PRINT_ERROR_ADDRESS, d_str_sprite_ram_write

	EC_LIST_END

d_str_palette_ram_address:	STRING "PALETTE RAM ADDRESS"
d_str_palette_ram_data:		STRING "PALETTE RAM DATA"
d_str_palette_ram_march:	STRING "PALETTE RAM MARCH"
d_str_palette_ram_output:	STRING "PALETTE RAM DEAD OUTPUT"
d_str_palette_ram_write:	STRING "PALETTE RAM WRITE"

d_str_tile_ram_address:		STRING "TILE RAM ADDRESS"
d_str_tile_ram_data:		STRING "TILE RAM DATA"
d_str_tile_ram_march:		STRING "TILE RAM MARCH"
d_str_tile_ram_output:		STRING "TILE RAM DEAD OUTPUT"
d_str_tile_ram_write:		STRING "TILE RAM WRITE"

d_str_tile_attr_ram_address:	STRING "TILE ATTR RAM ADDRESS"
d_str_tile_attr_ram_data:	STRING "TILE ATTR RAM DATA"
d_str_tile_attr_ram_march:	STRING "TILE ATTR RAM MARCH"
d_str_tile_attr_ram_output:	STRING "TILE ATTR RAM DEAD OUTPUT"
d_str_tile_attr_ram_write:	STRING "TILE ATTR RAM WRITE"

d_str_sprite_ram_address:	STRING "SPRITE RAM ADDRESS"
d_str_sprite_ram_data:		STRING "SPRITE RAM DATA"
d_str_sprite_ram_march:		STRING "SPRITE RAM MARCH"
d_str_sprite_ram_output:	STRING "SPRITE RAM DEAD OUTPUT"
d_str_sprite_ram_write:		STRING "SPRITE RAM WRITE"
