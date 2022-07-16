    .global place_food
    .global has_food
    .global reset_food
    .extern draw_pixel
    .extern read_pixel

    .equ food_color, 0x77
    .equ num_placements, 4 # keep in sync with placement data!
    .equ screen_dimension, 32

place_food:
    addi sp, sp, -4
    sw ra, 0(sp)
    call next_placement
    la t0, food
    sb a0, 0(t0)
    sb a1, 1(t0)
    li a2, food_color
    call draw_pixel
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# a0/a1 = x/y
# returns 0/1 in a0
has_food:
    la t0, food
    lbu t1, 0(t0)
    lbu t2, 1(t0)
    bne a0, t1, has_food_false
    bne a1, t2, has_food_false
    li a0, 1
    ret
has_food_false:
    li a0, 0
    ret

reset_food:
    la t0, placement_num
    sw zero, 0(t0)
    ret

# returns next x/y food coords in a0/a1
next_placement:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    call read_placement
    mv s0, a0
    mv s1, a1
    li s2, 0 # number of shifts done
next_placement_shift_loop:
    call read_pixel
    beqz a0, next_placement_done
    addi s0, s0, 1
    addi s1, s1, 1
    li t0, screen_dimension
next_placement_shift_check_x:
    bne s0, t0, next_placement_shift_check_y
    li s0, 0
next_placement_shift_check_y:
    bne s1, t0, next_placement_shift_check_num
    li s1, 0
next_placement_shift_check_num:
    addi s2, s2, 1
    bne s2, t0, next_placement_shift_done
    li s2, 0
    addi s0, s0, 1 # shift x one further if full diagonal pass made
    bne s0, t0, next_placement_shift_done
    li s0, 0
next_placement_shift_done:
    mv a0, s0
    mv a1, s1
    j next_placement_shift_loop

next_placement_done:
    mv a0, s0
    mv a1, s1
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret

# returns next placement x/y in a0/01
read_placement:
    la t0, placements
    la t1, placement_num
    lbu t2, 0(t1)
    slli t3, t2, 1
    add t0, t0, t3
    lbu a0, 0(t0)
    lbu a1, 1(t0)
    addi t2, t2, 1
    li t0, num_placements
    bltu t2, t0, read_placement_write_next_num
    mv t2, zero
read_placement_write_next_num:
    sb t2, 0(t1)
    ret

    .data

# each word contains 2 x/y coord pairs for food placement
# lsb are the lower index
placements:
    .word 0x140F0913
    .word 0x10101508
placement_num:
    .zero 1
# current x/y of food
food:
    .zero 2

