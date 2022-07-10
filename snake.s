    .global main
    .extern snake_init
    .extern gpio_init
    .extern gpio_input_val
    .extern gpio_set_led
    .extern move_up
    .extern move_right
    .extern move_down
    .extern move_left
    .extern move_tail
    .extern place_food
    .extern reset_food

    .equ input_up, 0x00000040
    .equ input_right, 0x00002000
    .equ input_down, 0x00400000
    .equ input_left, 0x00008000
    .equ input_reset, 0x00000001

    .equ action_result_none, 0
    .equ action_result_collision, 1
    .equ action_result_eaten, 2
    .equ action_result_reset, 3

main:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    call gpio_init
main_init:
    la t0, score
    sh zero, 0(t0)
    la t0, ate_last_move
    sb zero, 0(t0)
    la t0, gpio_input_val
    sw zero, 0(t0) # flush inputs entered before program start
    li a0, 1
    call gpio_set_led
    call snake_init
    call reset_food
    call place_food
main_loop:
    la t0, gpio_input_val
    lw a0, 0(t0)
    beqz a0, main_loop
    sw zero, 0(t0)
    call main_handle_input
    mv s0, a0
main_check_reset:
    li t0, action_result_reset
    bne s0, t0, main_check_collision
    j main_init
main_check_collision:
    li t0, action_result_collision
    bne s0, t0, main_check_move_tail
    li a0, 0
    call gpio_set_led
    call game_over_wait
    j main_init
main_check_move_tail:
    la t0, ate_last_move
    lbu t1, 0(t0)
    bnez t1, main_check_eaten # skip tail move if food eaten at previous move
    call move_tail
main_check_eaten:
    li t0, action_result_eaten
    sltu t0, s0, t0 # 1 if action result is not eaten
    xori t0, t0, 1
    la t1, ate_last_move
    sb t0, 0(t1)
    beqz t0, main_loop
    call place_food
    j main_loop
main_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    ret

game_over_wait:
    la t0, gpio_input_val
    li t1, input_reset
game_over_wait_loop:
    lw t2, 0(t0)
    bne t1, t2, game_over_wait_loop
    sw zero, 0(t0)
    ret

# a0 input word
# returns action result in a0
main_handle_input:
    addi sp, sp, -4
    sw ra, 0(sp)
main_handle_input_check_move_up:
    li t0, input_up
    bne t0, a0, main_handle_input_check_move_right
    call move_up
    j main_handle_input_done
main_handle_input_check_move_right:
    li t0, input_right
    bne t0, a0, main_handle_input_check_move_down
    call move_right
    j main_handle_input_done
main_handle_input_check_move_down:
    li t0, input_down
    bne t0, a0, main_handle_input_check_move_left
    call move_down
    j main_handle_input_done
main_handle_input_check_move_left:
    li t0, input_left
    bne t0, a0, main_handle_input_check_reset
    call move_left
    j main_handle_input_done
main_handle_input_check_reset:
    li t0, input_reset
    bne t0, a0, main_handle_input_none
    li a0, action_result_reset
    j main_handle_input_done
main_handle_input_none:
    li a0, action_result_none
main_handle_input_done:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

increment_score:
    la t0, score
    lhu t1, 0(t0)
    addi t1, t1, 1
    sh t1, 0(t0)
    ret

    .data

score:
    .zero 2
ate_last_move:
    .zero 1
