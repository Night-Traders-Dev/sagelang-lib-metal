## metal.vga — Early VGA Text Mode
## Provides direct access to VGA text buffer for boot-time display.

let VGA_BUF = 0xB8000
let COLS = 80
let ROWS = 25

let BLACK = 0
let GREEN = 2
let CYAN = 3
let WHITE = 15

let WHITE_ON_BLACK = 0x0F
let GREEN_ON_BLACK = 0x02

## Initialize VGA text mode (assumes BIOS already set it, or resets cursor)
proc init():
    # Hide cursor
    return nil

## Clear the screen with a specific background color
proc clear(color):
    let attr = color << 4
    let i = 0
    while i < COLS * ROWS:
        let pos = VGA_BUF + (i * 2)
        core.mmio_write8(pos, 32)
        core.mmio_write8(pos + 1, attr)
        i = i + 1
    return nil

## Put a string at (x, y) with specific attribute
proc puts(x, y, s, attr):
    let pos = VGA_BUF + ((y * COLS + x) * 2)
    let n = len(s)
    let i = 0
    while i < n:
        core.mmio_write8(pos + (i * 2), ord(s[i]))
        core.mmio_write8(pos + (i * 2) + 1, attr)
        i = i + 1
    return nil

## Draw a progress bar
proc draw_progress_bar(x, y, width, pct, color):
    if width <= 2:
        return nil
    let inner_width = width - 2
    let filled = (pct * inner_width) / 100
    let pos = VGA_BUF + ((y * COLS + x) * 2)
    core.mmio_write8(pos, ord("["))
    core.mmio_write8(pos + 1, color)
    let i = 0
    while i < inner_width:
        let ch = ord(" ")
        if i < filled:
            ch = ord("=")
        core.mmio_write8(pos + ((i + 1) * 2), ch)
        core.mmio_write8(pos + ((i + 1) * 2) + 1, color)
        i = i + 1
    core.mmio_write8(pos + (inner_width + 1) * 2, ord("]"))
    core.mmio_write8(pos + (inner_width + 1) * 2 + 1, color)
    return nil
