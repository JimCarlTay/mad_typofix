ROM_BASE			equ $000000
ROM_SIZE			equ $40000

; RAM CHIPS
; There are 2x 32kx8bit sram that everything
; uses on the 68k ram
WORK_RC_BASE			equ $060000
WORK_RC_SIZE			equ $10000
WORK_RC_ADDR_LINES		equ 16
WORK_RC_MASK			equ $ffff

; MEMORY REGIONS
BG_TILE_BASE			equ WORK_RC_BASE + $e800
BG_TILE_SIZE			equ $800
BG_TILE_PALETTE_BASE		equ PALETTE_BASE + $400

FG_TILE_BASE			equ WORK_RC_BASE + $f000
FG_TILE_SIZE			equ $800
FG_TILE_PALETTE_BASE		equ PALETTE_BASE + $600

PALETTE_BASE			equ WORK_RC_BASE + $e000
PALETTE_SIZE			equ $800
PALETTE_ENTRY_SIZE		equ $20

SPRITE_BASE			equ WORK_RC_BASE + $d800
SPRITE_SIZE			equ $800
SPRITE_PALETTE_BASE		equ PALETTE_BASE

TXT_TILE_BASE			equ WORK_RC_BASE + $f800
TXT_TILE_SIZE			equ $800
TXT_TILE_PALETTE_BASE		equ PALETTE_BASE + $200

WORK_RAM_BASE			equ WORK_RC_BASE
WORK_RAM_SIZE			equ $c000

; REG/IO
; the hardware doesn't seem to update video output
; unless a write happens to this address
REG_SCREEN_UPDATE		equ $0a0040
REG_SCREEN_FLIP			equ $0a0050
REG_SPRITE_COPY			equ $0a0048	; not safe to hit outside of vblank

REG_SOUND1			equ $080000
REG_SOUND2			equ $080002
REG_SOUND3			equ $080004
REG_SOUND4			equ $080006
REG_SOUND5			equ $080008
REG_SOUND6			equ $08000a
REG_SOUND7			equ $08000c

REG_INPUT_DSW1			equ $0c0001
REG_INPUT_DSW2			equ $0c0000
REG_INPUT_P1			equ $0c0003
REG_INPUT_P2			equ $0c0002
REG_INPUT_SYSTEM		equ $0c0005

SYS_SERVICE_BIT			equ $2
SYS_START1_BIT			equ $3
SYS_START2_BIT			equ $4

SYS_SERVICE			equ $04
SYS_START1			equ $08
SYS_START2			equ $10

DSW1_FLIP_SCREEN_BIT		equ $7
DSW1_FLIP_SCREEN		equ $80

CHAR_COLON			equ ':'

SOUND_NUM_STOP			equ $ff

	macro WATCHDOG
	endm

	; its unclear what sending #$80/$82 is doing
	macro SOUND_PLAY
		move.w	d0, REG_SOUND1
		move.w	#$80, REG_SOUND2
		move.w	#$80, REG_SOUND7
		move.w	#$80, REG_SOUND5
	endm

	macro SOUND_STOP
		move.w	#SOUND_NUM_STOP, REG_SOUND1
		move.w	#$82, REG_SOUND2
		move.w	#$82, REG_SOUND7
		move.w	#$82, REG_SOUND5
	endm
