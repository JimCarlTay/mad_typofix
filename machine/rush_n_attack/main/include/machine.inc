ROM_BASE			equ $0
ROM_SIZE			equ $4000

; RAM CHIPS
; scroll ram seems to be $40 in size, but only the first $20 can be read
SCROLL_RC_BASE			equ $e000
SCROLL_RC_SIZE			equ $20
SCROLL_RC_ADDR_LINES		equ 5

WORK_RC_BASE			equ $c000
WORK_RC_SIZE			equ $2000
WORK_RC_ADDR_LINES		equ 13

; MEMORY REGIONS
SCROLL_BASE			equ $e000
SCROLL_SIZE			equ $20

SPRITE_BASE			equ WORK_RC_BASE + $1000
SPRITE_SIZE			equ $200

TILE_BASE			equ WORK_RC_BASE + $800
TILE_SIZE			equ $800

TILE_ATTR_BASE			equ WORK_RC_BASE
TILE_ATTR_SIZE			equ $800

WORK_RAM_BASE			equ WORK_RC_BASE + $1200
WORK_RAM_SIZE			equ $300

; REG/IO
REG_CONTROL			equ $e044
REG_WATCHDOG			equ $f600

REG_SOUND_LATCH			equ $f200
REG_SOUND_TRIGGER		equ $f400

CTRL_NMI_DISABLE		equ $0
CTRL_NMI_ENABLE			equ $1
CTRL_IRQ_DISABLE		equ $0
CTRL_IRQ_ENABLE			equ $2
CTRL_FIRQ_DISABLE		equ $0
CTRL_FIRQ_ENABLE		equ $4

REG_INPUT_P1			equ $f602
REG_INPUT_P2			equ $f601
REG_INPUT_DSW1			equ $f600
REG_INPUT_DSW2			equ $f200
REG_INPUT_DSW3			equ $f400
REG_INPUT_SYS			equ $f603

CHAR_COLON			equ $10		; no colon char, using space

	macro WATCHDOG
		ld	(REG_WATCHDOG), a
	endm

	; we are only allowed to use a/de registers
	macro SOUND_PLAY
		ld	d, a
		srl	a
		srl	a
		srl	a
		srl	a
		or	a, $80
		ld	(REG_SOUND_LATCH), a
		ld	(REG_SOUND_TRIGGER), a
		nop
		nop
		nop
		nop
		nop
		nop
		ld	a, d
		and	a, $f
		ld	(REG_SOUND_LATCH), a
		ld	(REG_SOUND_TRIGGER), a
		nop
		nop
		nop
		nop
		nop
		nop
		ld	a, $93
		ld	(REG_SOUND_LATCH), a
		ld	(REG_SOUND_TRIGGER), a
	endm

	macro SOUND_STOP
		ld	a, $9f
		ld	(REG_SOUND_LATCH), a
		ld	(REG_SOUND_TRIGGER), a
	endm
