    .global move
    .global move_up
    .global move_right
    .global move_down
    .global move_left
    .global snake_init

    .extern draw_pixel
    .extern read_pixel
    .extern map_init
    .extern map_read
    .extern map_write

    .equ up, 0
    .equ right, 1
    .equ down, 2
    .equ left, 3

    .equ empty_color, 0
    .equ snake_color, 0xFF

snake_init:
    addi sp, sp, -4
    sw ra, 0(sp)

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

# a0 direction
# returns collision 0/1 in a0
move:
    addi sp, sp, -4
    sw ra, 0(sp)
move_check_up:
    li t0, up
    bne a0, t0, move_check_right
    call move_up
    j move_done
move_check_right:
    li t0, right
    bne a0, t0, move_check_down
    call move_right
    j move_done
move_check_down:
    li t0, down
    bne a0, t0, move_check_left
    call move_down
    j move_done
move_check_left:
    li t0, left
    bne a0, t0, move_done
    call move_left
move_done:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# returns collision 0/1 in a0
move_up:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
# head movement
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, down
    beq a2, t0, move_up_done # disallow moving in opposite direction
    beqz a1, move_up_collision # border collision
    addi a1, a1, -1
    call read_pixel
    li t0, snake_color
    beq a0, t0, move_up_collision # snake collision
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
# tail movement
    call move_tail
    li a0, 0
    j move_up_done
move_up_collision:
    li a0, 1
move_up_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

move_right:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
# head movement
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, left
    beq a2, t0, move_right_done
    li t0, 31
    beq a0, t0, move_right_collision
    addi a0, a0, 1
    call read_pixel
    li t0, snake_color
    beq a0, t0, move_right_collision
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
# tail movement
    call move_tail
    li a0, 0
    j move_right_done
move_right_collision:
    li a0, 1
move_right_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

move_down:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
# head movement
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, up
    beq a2, t0, move_down_done
    li t0, 31
    beq a1, t0, move_down_collision
    addi a1, a1, 1
    call read_pixel
    li t0, snake_color
    beq a0, t0, move_down_collision
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
# tail movement
    call move_tail
    li a0, 0
    j move_down_done
move_down_collision:
    li a0, 1
move_down_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

move_left:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
# head movement
    call read_head
    mv s0, a0
    mv s1, a1
    li t0, right
    beq a2, t0, move_left_done
    beqz a0, move_left_collision
    addi a0, a0, -1
    call read_pixel
    li t0, snake_color
    beq a0, t0, move_left_collision
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
# tail movement
    call move_tail
    li a0, 0
    j move_left_done
move_left_collision:
    li a0, 1
move_left_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

move_tail:
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)

    call read_tail
    mv s0, a0
    mv s1, a1
    li a2, empty_color
    call draw_pixel
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

