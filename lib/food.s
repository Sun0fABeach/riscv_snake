    .global place_food
    .global has_food
    .extern draw_pixel
    .extern read_pixel

    .equ food_color, 0x77

place_food:
    addi sp, sp, -4
    sw ra, 0(sp)
    la t0, food
    li a0, 20
    li a1, 5
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

    .data
# current x/y of food
food:
    .zero 2

