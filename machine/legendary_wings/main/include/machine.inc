ROM_BASE			equ $0
ROM_SIZE			equ $8000

; RAM CHIPS
BG_TILE_RC_BASE			equ $e800
BG_TILE_RC_SIZE			equ $800
BG_TILE_RC_ADDR_LINES		equ 11

TXT_TILE_RC_BASE		equ $e000
TXT_TILE_RC_SIZE		equ $800
TXT_TILE_RC_ADDR_LINES		equ 11

PALETTE_RC_BASE			equ $f000
PALETTE_RC_SIZE			equ $400
PALETTE_RC_ADDR_LINES		equ 10

PALETTE_EXT_RC_BASE		equ $f400
PALETTE_EXT_RC_SIZE		equ $400
PALETTE_EXT_RC_ADDR_LINES	equ 10

WORK_RC_BASE			equ $c000
WORK_RC_SIZE			equ $2000
WORK_RC_ADDR_LINES		equ 13

; MEMORY REGIONS
BG_TILE_BASE			equ BG_TILE_RC_BASE
BG_TILE_SIZE			equ $400
BG_TILE_PALETTE_BASE		equ PALETTE_BASE
BG_TILE_PALETTE_EXT_BASE	equ PALETTE_EXT_BASE
BG_TILE_PALETTE_ENTRY_SIZE	equ $20

BG_TILE_ATTR_BASE		equ BG_TILE_RC_BASE + $400
BG_TILE_ATTR_SIZE		equ $400

TXT_TILE_BASE			equ TXT_TILE_RC_BASE
TXT_TILE_SIZE			equ $400
TXT_TILE_PALETTE_BASE		equ PALETTE_BASE + $200
TXT_TILE_PALETTE_EXT_BASE	equ PALETTE_EXT_BASE + $200
TXT_TILE_PALETTE_ENTRY_SIZE	equ $8

TXT_TILE_ATTR_BASE		equ TXT_TILE_RC_BASE + $400
TXT_TILE_ATTR_SIZE		equ $400

PALETTE_BASE			equ PALETTE_RC_BASE
PALETTE_SIZE			equ PALETTE_RC_SIZE

PALETTE_EXT_BASE		equ PALETTE_EXT_RC_BASE
PALETTE_EXT_SIZE		equ PALETTE_EXT_RC_SIZE

SPRITE_BASE			equ WORK_RC_BASE + $1e00
SPRITE_SIZE			equ $180	; ??
SPRITE_PALETTE_BASE		equ PALETTE_BASE + $180
SPRITE_PALETTE_EXT_BASE		equ PALETTE_EXT_BASE + $180
SPRITE_PALETTE_ENTRY_SIZE	equ $20

WORK_RAM_BASE			equ WORK_RC_BASE
WORK_RAM_SIZE			equ $1000

; REG/IO
REG_CONTROL			equ $f80e
REG_SPRITE_COPY_REQUEST		equ $f80d
REG_SOUND			equ $f80c

CTRL_NMI_ENABLE			equ $08
CTRL_NMI_DISABLE		equ $00
CTRL_SND_RESET_ON		equ $20
CTRL_SND_RESET_OFF		equ $00
CTRL_SCREEN_FLIP		equ $01

REG_INPUT_P1			equ $f809
REG_INPUT_P2			equ $f80a
REG_INPUT_DSW1			equ $f80b
REG_INPUT_DSW2			equ $f80c
REG_INPUT_SYS			equ $f808

REG_BG_SCROLL_X			equ $f808
REG_BG_SCROLL_Y			equ $f80a

CHAR_COLON			equ $25


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
		ld	a, $ff
		ld	(REG_SOUND), a

		ld	de, $7ff
	.\@:
		cp	$0
		cp	$0
		cp	$0
		dec	de
		ld	a, e
		or	d
		jr	nz, .\@

		ld	a, b
		ld	(REG_SOUND), a

	endm

	macro SOUND_STOP
		ld	a, $0
		ld	(REG_SOUND), a
	endm
