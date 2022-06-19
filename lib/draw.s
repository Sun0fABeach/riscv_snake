.global draw_pixel
.global draw_clear

.equ map_start, 0x00000C00
.equ map_end, 0x00000FFF

.equ black, 0
.equ white, -1

# a0 x coordinate
# a1 y coordinate
# a2 pixel byte
draw_pixel:
# calculate byte address
    slli a1, a1, 5 # *32
    add a1, a1, a0
    li t0, map_start
    add t0, t0, a1
# write pixel
    sb a2, 0(t0)
    ret

draw_clear:
    li t0, map_start
    li t1, map_end
    li t2, black
draw_clear_loop:
    sw t2, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, draw_clear_loop
    ret

