    .global snake_init
    .global move
    .global move_up
    .global move_right
    .global move_down
    .global move_left
    .global move_tail

    .extern draw_pixel
    .extern read_pixel
    .extern draw_clear
    .extern map_init
    .extern map_read
    .extern map_write
    .extern map_clear
    .extern has_food

    .equ up, 0
    .equ right, 1
    .equ down, 2
    .equ left, 3

    .equ empty_color, 0
    .equ snake_color, 0xFF

    .equ move_result_none, 0
    .equ move_result_collision, 1
    .equ move_result_eaten, 2

snake_init:
    addi sp, sp, -4
    sw ra, 0(sp)

    call snake_clear

    call map_init

    li a0, 14
    li a1, 16
    call write_tail
    li a2, snake_color
    call draw_pixel
    li a0, 15
    li a1, 16
    li a2, snake_color
    call draw_pixel
    li a0, 16
    li a1, 16
    li a2, snake_color
    call draw_pixel
    li a0, 17
    li a1, 16
    li a2, right
    call write_head
    li a2, snake_color
    call draw_pixel

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

snake_clear:
    add sp, sp, -4
    sw ra, 0(sp)
    call map_clear
    call draw_clear
    lw ra, 0(sp)
    add sp, sp, 4
    ret

# a0: whether tail won't move
# returns move result in a0
move_up:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    mv s2, a0
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, down
    beq a2, t0, move_finish_done # disallow moving in opposite direction
    beqz a1, move_finish_collision # border collision
    addi a1, a1, -1
    mv a2, s2
    call check_self_collision
    bnez a0, move_finish_collision # snake self collision
    mv a0, s0
    mv a1, s1
    li a2, up
    call map_write # write direction to current map pos
    mv a0, s0
    addi a1, s1, -1
    li a2, up
    call write_head # save current coords and direction
    li a2, snake_color
    call draw_pixel
    mv a0, s0 # check if food eaten
    addi a1, s1, -1
    call has_food
    bnez a0, move_finish_eaten
    j move_finish_none

move_right:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    mv s2, a0
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, left
    beq a2, t0, move_finish_done
    li t0, 31
    beq a0, t0, move_finish_collision
    addi a0, a0, 1
    mv a2, s2
    call check_self_collision
    bnez a0, move_finish_collision
    mv a0, s0
    mv a1, s1
    li a2, right
    call map_write
    addi a0, s0, 1
    mv a1, s1
    li a2, right
    call write_head
    li a2, snake_color
    call draw_pixel
    addi a0, s0, 1
    mv a1, s1
    call has_food
    bnez a0, move_finish_eaten
    j move_finish_none

move_down:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    mv s2, a0
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, up
    beq a2, t0, move_finish_done
    li t0, 31
    beq a1, t0, move_finish_collision
    addi a1, a1, 1
    mv a2, s2
    call check_self_collision
    bnez a0, move_finish_collision
    mv a0, s0
    mv a1, s1
    li a2, down
    call map_write
    mv a0, s0
    addi a1, s1, 1
    li a2, down
    call write_head
    li a2, snake_color
    call draw_pixel
    mv a0, s0
    addi a1, s1, 1
    call has_food
    bnez a0, move_finish_eaten
    j move_finish_none

move_left:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    mv s2, a0
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, right
    beq a2, t0, move_finish_done
    beqz a0, move_finish_collision
    addi a0, a0, -1
    mv a2, s2
    call check_self_collision
    bnez a0, move_finish_collision
    mv a0, s0
    mv a1, s1
    li a2, left
    call map_write
    addi a0, s0, -1
    mv a1, s1
    li a2, left
    call write_head
    li a2, snake_color
    call draw_pixel
    addi a0, s0, -1
    mv a1, s1
    call has_food
    bnez a0, move_finish_eaten
    j move_finish_none

# final instructions for all move_dir routines
move_finish_none:
    li a0, move_result_none
    j move_finish_done
move_finish_collision:
    li a0, move_result_collision
    j move_finish_done
move_finish_eaten:
    li a0, move_result_eaten
move_finish_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret

# a0/a1: x/y of move target
# a2: whether tail won't move
# returns collision result of snake with itself (0/1) in a0
check_self_collision:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)

    mv s0, a0
    mv s1, a1
    mv s2, a2
    call read_pixel
    li t0, snake_color
    bne a0, t0, check_self_collision_false
    call read_tail
    bne a0, s0, check_self_collision_true
    bne a1, s1, check_self_collision_true
    beqz s2, check_self_collision_false # hit tail, but it will move
check_self_collision_true:
    li a0, 1
    j check_self_collision_done
check_self_collision_false:
    li a0, 0
check_self_collision_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret

move_tail:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    call read_tail
    mv s0, a0
    mv s1, a1
    call read_head
    bne a0, s0, move_tail_draw_empty
    bne a1, s1, move_tail_draw_empty
    j move_tail_check_directions # don't draw empty field if head takes tail pos
move_tail_draw_empty:
    mv a0, s0
    mv a1, s1
    li a2, empty_color
    call draw_pixel
move_tail_check_directions:
    mv a0, s0
    mv a1, s1
    call map_read
move_tail_check_up:
    li t0, up
    bne a0, t0, move_tail_check_right
    addi s1, s1, -1
    j move_tail_write
move_tail_check_right:
    li t0, right
    bne a0, t0, move_tail_check_down
    addi s0, s0, 1
    j move_tail_write
move_tail_check_down:
    li t0, down
    bne a0, t0, move_tail_left
    addi s1, s1, 1
    j move_tail_write
move_tail_left:
    addi s0, s0, -1
move_tail_write:
    mv a0, s0
    mv a1, s1
    call write_tail
move_tail_check_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

read_head:
    la t0, head
    lbu a0, 0(t0)
    lbu a1, 1(t0)
    lbu a2, 2(t0)
    ret

read_tail:
    la t0, tail
    lbu a0, 0(t0)
    lbu a1, 1(t0)
    ret

write_head:
    la t0, head
    sb a0, 0(t0)
    sb a1, 1(t0)
    sb a2, 2(t0)
    ret

write_tail:
    la t0, tail
    sb a0, 0(t0)
    sb a1, 1(t0)
    ret


    .data
# current x/y of snake head
head:
    .zero 3
# current x/y of snake tail
tail:
    .zero 2

