    .global map_init
    .global map_read
    .global map_write
#    .global map_clear
    .extern div

map_init:
    # init map with 15/16, 16/16, 17/16, all pointing right
    la t0, map
    li t1, 0b00000101
    sb t1, 131(t0)
    li t1, 0b01000000
    sb t1, 132(t0)
    ret

# a0: x
# a1: y
# returns direction in a0
map_read:
    mv t5, ra # we know map_get_pos won't use t5

    call map_get_pos

    lbu t0, 0(a0)   # load byte from map address

    li t1, 3
    sll t1, t1, a1
    and t0, t0, t1
    srl a0, t0, a1  # grab bit-pair and shift to lsb

    mv ra, t5
    ret

# a0: x
# a1: y
# a2: direction to write
map_write:
    mv t5, ra # we know map_get_pos won't use t5

    call map_get_pos # won't use a2, so we don't save it

    lbu t0, 0(a0)   # load byte from map address

    li t1, 3
    sll t1, t1, a1
    xori t1, t1, -1
    and t0, t0, t1  # set bit-pair to 00

    sll a2, a2, a1
    or t0, t0, a2   # set bit-pair to direction

    sb t0, 0(a0)    # write byte to map

    mv ra, t5
    ret


#map_clear:
#    la t0, map
#    addi t1, t0, 256
#map_clear_loop:
#    sw zero, 0(t0)
#    addi t0, t0, 8
#    bltu t0, t1, map_clear_loop
#    ret

# a0: x
# a1: y
# returns byte address in a0
# returns bit shift amount for addressing bit-pair in a1
map_get_pos:
    mv t6, ra # we know div won't use t6

    slli a1, a1, 5
    add a0, a0, a1
    li a1, 4
    call div        # quot,rem = ((y * 32) + x) / 4

    la t0, map
    add a0, a0, t0  # determine byte address on map

    li t1, 3
    sub t1, t1, a1
    slli a1, t1, 1  # bit-pair pos = (3 - rem) * 2

    mv ra, t6
    ret

# 32x32 map containing snake as 2 bit direction fields
map:
    .zero 256
