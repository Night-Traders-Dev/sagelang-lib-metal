# metal

## Purpose
Low-level hardware abstraction layer for bare-metal systems, embedded platforms, and kernel development.

## Features
- **Hardware Access**: GPIO, Timer, Serial, IRQ support.
- **Graphics (Basic)**: VGA support for legacy display interaction.

## Usage Example
```sage
import metal.gpio
import metal.timer

metal.gpio.setup(1, metal.gpio.OUTPUT)
metal.timer.sleep(1000)
```
