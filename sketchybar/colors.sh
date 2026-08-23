#!/bin/bash

# -- Dark & Moody Scheme --
export WHITE=0xffd8d8e0            # soft off-white, not stark white
export BAR_COLOR=0x80101014        # translucent but with enough tint to stay
                                    # readable over busy/bright wallpapers
export ITEM_BG_COLOR=0xe61b1b22    # dark slate for item pills, kept more
                                    # opaque than the bar so pills stay legible
export ACCENT_COLOR=0xff8f97b3     # muted periwinkle - visible but not loud
export DIM_COLOR=0xff5c5c66        # muted gray for inactive/secondary text
export BORDER_COLOR=0xff2a2a33     # subtle border, barely lighter than bg

# Status colors - used by battery/cpu to color-code by state, independent
# of whichever scheme below is active.
export GOOD_COLOR=0xff6fd68f       # soft green  - healthy/plenty
export WARN_COLOR=0xffe0b34d       # soft amber  - getting low/high
export BAD_COLOR=0xffe0666f        # soft coral  - critical

# -- Previous Teal Scheme (kept for reference) --
# export BAR_COLOR=0x40001f30
# export ITEM_BG_COLOR=0xe6003547
# export ACCENT_COLOR=0xff2cf9ed

# -- Gray Scheme --
# export BAR_COLOR=0x40101314
# export ITEM_BG_COLOR=0xe6353c3f
# export ACCENT_COLOR=0xffffffff

# -- Purple Scheme --
export BAR_COLOR=0xbd140c42
export ITEM_BG_COLOR=0xff2b1c84
export ACCENT_COLOR=0xffeb46f9

# -- Red Scheme ---
# export BAR_COLOR=0x4023090e
# export ITEM_BG_COLOR=0xe6591221
# export ACCENT_COLOR=0xffff2453

# -- Blue Scheme --- 
# export BAR_COLOR=0x40021254
# export ITEM_BG_COLOR=0xe6093aa8
# export ACCENT_COLOR=0xff15bdf9

# -- Green Scheme --
# export BAR_COLOR=0x40003315
# export ITEM_BG_COLOR=0xe6008c39
# export ACCENT_COLOR=0xff1dfca1

# -- Orange Scheme --
# export BAR_COLOR=0x40381c02
# export ITEM_BG_COLOR=0xe699440a
# export ACCENT_COLOR=0xfff97716

# -- Yellow Scheme --
# export BAR_COLOR=0x402d2b02
# export ITEM_BG_COLOR=0xe68e7e0a
# export ACCENT_COLOR=0xfff7fc17
