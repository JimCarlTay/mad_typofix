ROM_BASE			equ $0
ROM_SIZE			equ $8000

; RAM CHIPS
; palette ram is write-only
PALETTE_RC_BASE			equ $c000
PALETTE_RC_SIZE			equ $800
PALETTE_EXT_RC_BASE		equ PALETTE_RC_BASE + $400
PALETTE_ENTRY_SIZE		equ $20

TILE_RC_BASE			equ $d000
TILE_RC_SIZE			equ $1000
TILE_RC_ADDR_LINES		equ 12

WORK_RC_BASE			equ $e000
WORK_RC_SIZE			equ $2000
WORK_RC_ADDR_LINES		equ 13

; MEMORY REGIONS
PALETTE_BASE			equ PALETTE_RC_BASE
PALETTE_SIZE			equ PALETTE_RC_SIZE
PALETTE_EXT_BASE		equ PALETTE_RC_BASE + $400

SPRITE_BASE			equ WORK_RC_BASE + $1000
SPRITE_SIZE			equ $1000
SPRITE_PALETTE_BASE		equ PALETTE_BASE + $200
SPRITE_PALETTE_ENTRY_SIZE	equ $20

TXT_TILE_BASE			equ TILE_RC_BASE
TXT_TILE_SIZE			equ $800
TXT_TILE_PALETTE_BASE		equ PALETTE_BASE + $300
TXT_TILE_PALETTE_EXT_BASE	equ PALETTE_EXT_BASE + $300
TXT_TILE_PALETTE_ENTRY_SIZE	equ $8

TXT_TILE_ATTR_BASE		equ TILE_RC_BASE + $800
TXT_TILE_ATTR_SIZE		equ $800

WORK_RAM_BASE			equ WORK_RC_BASE
WORK_RAM_SIZE			equ $1000

; MISC PALETTE
BG_TILE_PALETTE_BASE		equ PALETTE_BASE
BG_TILE_PALETTE_ENTRY_SIZE	equ $20

STARFIELD_PALETTE_BASE		equ PALETTE_BASE + $37c
STARFIELD_PALETTE_ENTRY_SIZE	equ $8

; REG/IO
REG_SPRITE_COPY_REQUEST		equ $c802
REG_PAL_WRITE_ERROR_CLEAR	equ $c803
REG_STARFIELD_SCROLL_X		equ $c805
REG_STARFIELD_SCROLL_Y		equ $c806

REG_SOUND			equ $c800

REG_INPUT_P1			equ $c801
REG_INPUT_P2			equ $c802
REG_INPUT_DSW1			equ $c803
REG_INPUT_DSW2			equ $c804
REG_INPUT_DSW3			equ $c805
REG_INPUT_SYS			equ $c800

SYS_PAL_WRITE_ERROR_BIT		equ $2
SYS_VBLANK_BIT			equ $3

REG_LAYER			equ $c80c
LAYER_BG_ENABLE			equ $01
LAYER_SPRITE_ENABLE		equ $02

REG_BG_SCROLL_X			equ $c808
REG_BG_SCROLL_Y			equ $c80a

REG_STAR_SCROLL_X		equ $c805
REG_STAR_SCROLL_Y		equ $c806

CHAR_COLON			equ $2c


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
		ld	(REG_SOUND), a

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
		ld	(REG_SOUND), a

	endm

	macro SOUND_STOP
		ld	a, $0
		ld	(REG_SOUND), a
	endm
