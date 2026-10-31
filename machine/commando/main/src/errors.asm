	include "cpu/z80/include/common.inc"
	include "cpu/z80/include/print_error.inc"
	include "cpu/z80/include/handlers/error.inc"

	global d_ec_list

	section data

d_ec_list:
	EC_ENTRY EC_BG_TILE_RC_ADDRESS, PRINT_ERROR_MEMORY, d_str_bg_tile_ram_address
	EC_ENTRY EC_BG_TILE_RC_DATA, PRINT_ERROR_MEMORY, d_str_bg_tile_ram_data
	EC_ENTRY EC_BG_TILE_RC_MARCH, PRINT_ERROR_MEMORY, d_str_bg_tile_ram_march
	EC_ENTRY EC_BG_TILE_RC_OUTPUT, PRINT_ERROR_ADDRESS, d_str_bg_tile_ram_output
	EC_ENTRY EC_BG_TILE_RC_WRITE, PRINT_ERROR_HEX_BYTE, d_str_bg_tile_ram_write

	EC_ENTRY EC_TXT_TILE_RC_ADDRESS, PRINT_ERROR_MEMORY, d_str_txt_tile_ram_address
	EC_ENTRY EC_TXT_TILE_RC_DATA, PRINT_ERROR_MEMORY, d_str_txt_tile_ram_data
	EC_ENTRY EC_TXT_TILE_RC_MARCH, PRINT_ERROR_MEMORY, d_str_txt_tile_ram_march
	EC_ENTRY EC_TXT_TILE_RC_OUTPUT, PRINT_ERROR_ADDRESS, d_str_txt_tile_ram_output
	EC_ENTRY EC_TXT_TILE_RC_WRITE, PRINT_ERROR_HEX_BYTE, d_str_txt_tile_ram_write
	EC_LIST_END

d_str_bg_tile_ram_address:		STRING "BG TILE RC ADDRESS"
d_str_bg_tile_ram_data:			STRING "BG TILE RC DATA"
d_str_bg_tile_ram_march:		STRING "BG TILE RC MARCH"
d_str_bg_tile_ram_output:		STRING "BG TILE RC DEAD OUTPUT"
d_str_bg_tile_ram_write:		STRING "BG TILE RC WRITE"

d_str_txt_tile_ram_address:		STRING "TXT TILE RC ADDRESS"
d_str_txt_tile_ram_data:		STRING "TXT TILE RC DATA"
d_str_txt_tile_ram_march:		STRING "TXT TILE RC MARCH"
d_str_txt_tile_ram_output:		STRING "TXT TILE RC DEAD OUTPUT"
d_str_txt_tile_ram_write:		STRING "TXT TILE RC WRITE"
