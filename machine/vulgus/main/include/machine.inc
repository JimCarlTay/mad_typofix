ROM_BASE			equ $0
ROM_SIZE			equ $8000

; RAM CHIPS
; bg ram chip is $800 in size, but A10 is tied to GND. This causes a mirror
; of $d800-$dbff at $dc00-$dfff
BG_TILE_RC_BASE			equ $d800
BG_TILE_RC_SIZE			equ $400
BG_TILE_RC_ADDR_LINES		equ 10

SPRITE_RC_BASE			equ $cc00
SPRITE_RC_SIZE			equ $80

TXT_TILE_RC_BASE		equ $d000
TXT_TILE_RC_SIZE		equ $800
TXT_TILE_RC_ADDR_LINES		equ 11

; work ram is 2x $800 chips, we are only using the lower $800
WORK_RC_BASE			equ $e000
WORK_RC_SIZE			equ $800
WORK_RC_ADDR_LINES		equ 11

WORK_HIGH_RC_BASE		equ $e800
WORK_HIGH_RC_SIZE		equ $800
WORK_HIGH_RC_ADDR_LINES		equ 11

; MEMORY REGIONS
BG_TILE_BASE			equ BG_TILE_RC_BASE
BG_TILE_SIZE			equ BG_TILE_RC_SIZE

BG_TILE_ATTR_BASE		equ BG_TILE_RC_BASE + $400
BG_TILE_ATTR_SIZE		equ $400

SPRITE_BASE			equ SPRITE_RC_BASE
SPRITE_SIZE			equ SPRITE_RC_SIZE

TXT_TILE_BASE			equ TXT_TILE_RC_BASE
TXT_TILE_SIZE			equ $400

TXT_TILE_ATTR_BASE		equ TXT_TILE_RC_BASE + $400
TXT_TILE_ATTR_SIZE		equ $400

WORK_RAM_BASE			equ WORK_RC_BASE
WORK_RAM_SIZE			equ WORK_RC_SIZE

WORK_HIGH_RAM_BASE		equ WORK_HIGH_RC_BASE
WORK_HIGH_RAM_SIZE		equ WORK_HIGH_RC_SIZE

; REG/IO
REG_BG_SCROLL_X_LOW		equ $c803
REG_BG_SCROLL_X_HIGH		equ $c903
REG_BG_SCROLL_Y_LOW		equ $c802
REG_BG_SCROLL_Y_HIGH		equ $c902

REG_CONTROL			equ $c804
REG_PALETTE_BANK		equ $c805
REG_ROM_BANK			equ $c806
REG_SOUND			equ $c800

REG_INPUT_P1			equ $c001
REG_INPUT_P2			equ $c002
REG_INPUT_DSW1			equ $c003
REG_INPUT_DSW2			equ $c004
REG_INPUT_SYS			equ $c000

CHAR_COLON			equ ' '


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
