ROM_BASE			equ $0
ROM_SIZE			equ $8000

; RAM CHIPS
BG_TILE_RC_BASE			equ $c000
BG_TILE_RC_SIZE			equ $1000
BG_TILE_RC_ADDR_LINES		equ 12

PALETTE_RC_BASE			equ $d800
PALETTE_RC_SIZE			equ $400

PALETTE_EXT_RC_BASE		equ $dc00
PALETTE_EXT_RC_SIZE		equ $400

TXT_TILE_RC_BASE		equ $d000
TXT_TILE_RC_SIZE		equ $800
TXT_TILE_RC_ADDR_LINES		equ 11

WORK_RC_BASE			equ $e000
WORK_RC_SIZE			equ $2000
WORK_RC_ADDR_LINES		equ 13

; MEMORY RETIONS
BG_TILE_BASE			equ BG_TILE_RC_BASE
BG_TILE_SIZE			equ BG_TILE_RC_SIZE
BG_TILE_PALETTE_BASE		equ PALETTE_BASE
BG_TILE_PALETTE_ENTRY_SIZE	equ $20

PALETTE_BASE			equ PALETTE_RC_BASE
PALETTE_SIZE			equ PALETTE_RC_SIZE

PALETTE_EXT_BASE		equ PALETTE_EXT_RC_BASE
PALETTE_EXT_SIZE		equ PALETTE_EXT_RC_SIZE

SPRITE_BASE			equ WORK_RC_BASE + $1e00
SPRITE_SIZE			equ $300
SPRITE_PALETTE_BASE		equ PALETTE_BASE + $200
SPRITE_PALETTE_ENTRY_SIZE	equ $20

TXT_TILE_BASE			equ TXT_TILE_RC_BASE
TXT_TILE_SIZE			equ $400
TXT_TILE_PALETTE_BASE		equ PALETTE_BASE + $300
TXT_TILE_PALETTE_EXT_BASE	equ PALETTE_EXT_BASE + $300
TXT_TILE_PALETTE_ENTRY_SIZE	equ $8

TXT_TILE_ATTR_BASE		equ TXT_TILE_RC_BASE + $400
TXT_TILE_ATTR_SIZE		equ $400

WORK_RAM_BASE			equ WORK_RC_BASE
WORK_RAM_SIZE			equ $1000

; REG/IO
IO_INPUT_P1			equ $01
IO_INPUT_P2			equ $02

IO_INPUT_SYS			equ $00
SYS_VBLANK_BIT			equ $3
SYS_PAL_WRITE_ERROR_BIT		equ $2

IO_INPUT_DSW1			equ $03
IO_INPUT_DSW2			equ $04
IO_INPUT_DSW3			equ $05 ; not populated on board

IO_SPRITE_COPY_REQUEST		equ $06
IO_PAL_WRITE_ERROR_CLEAR	equ $02

IO_SCROLL_X_HIGH		equ $09
IO_SCROLL_X_LOW			equ $08
IO_SCROLL_Y_HIGH		equ $0b
IO_SCROLL_Y_LOW			equ $0a

IO_CONTROL			equ $04
IO_VIDEO			equ $0c
IO_BG_RAM_BANK			equ $0d
IO_BG_LAYOUT			equ $0e
IO_SOUND			equ $00

	macro WATCHDOG
	endm

	; Sound commands are sent through a latch, but the main CPU
	; has no way to tell the sound CPU to read the latch.  Insead
	; the sound CPU is constantly reading the latch.  If it sees
	; the same value as the previous read it will just ignore it.
	; This is problematic for beep codes, so to work around this
	; we need to send it a stop playing command, wait a bit, then
	; send our actual sound command.
	macro SOUND_PLAY
		ld	b, a
		ld	a, 0
		out	(IO_SOUND), a

		ld	de, $8ff
	.\@:
		cp	$0
		cp	$0
		cp	$0
		dec	de
		ld	a, e
		or	d
		jr	nz, .\@

		ld	a, b
		out	(IO_SOUND), a
	endm

	macro SOUND_STOP
		ld	a, $0
		out	(IO_SOUND), a
	endm
