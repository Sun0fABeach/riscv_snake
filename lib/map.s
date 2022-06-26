    .global map_init
    .global map_read
    .global map_write
    .extern div

map_init:
    # init map with 15/16 and 16/16, both pointing right
    la t0, map
    li t1, 0b00000001
    sb t1, 131(t0)
    li t1, 0b01000000
    sb t1, 132(t0)
    ret

# a0: x
# a1: y
# returns direction in a0
map_read:
    addi sp, sp, -4
    sw ra, 0(sp)

    call map_get_pos

    lbu t0, 0(a0)   # load byte from map address

    li t1, 3
    sll t1, t1, a1
    and t0, t0, t1
    srl a0, t0, a1  # grab bit-pair and shift to lsb

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# a0: x
# a1: y
# a2: direction to write
map_write:
    addi sp, sp, -5
    sw ra, 0(sp)
    sb a2, 4(sp)

    call map_get_pos

    lbu t0, 0(a0)   # load byte from map address

    li t1, 3
    sll t1, t1, a1
    xori t1, t1, -1
    and t0, t0, t1  # set bit-pair to 00

    lbu t1, 4(sp)
    sll t1, t1, a1
    or t0, t0, t1   # set bit-pair to direction

    sb t0, 0(a0)    # write byte to map

    lw ra, 0(sp)
    addi sp, sp, 5
    ret


# a0: x
# a1: y
# returns byte address in a0
# returns bit shift amount for addressing bit-pair in a1
map_get_pos:
    addi sp, sp, -4
    sw ra, 0(sp)

    slli a1, a1, 5
    add a0, a0, a1
    li a1, 4
    call div        # quot,rem = ((y * 32) + x) / 4

    la t0, map
    add a0, a0, t0  # determine byte address on map

    li t1, 3
    sub t1, t1, a1
    slli a1, t1, 1  # bit-pair pos = (3 - rem) * 2

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# 32x32 map containing snake as 2 bit direction fields
map:
    .zero 256
