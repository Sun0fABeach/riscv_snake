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
    .extern text_title
    .extern text_start
    .extern text_game_over
    .extern text_score

    .equ input_up, 0x00000040
    .equ input_right, 0x00002000
    .equ input_down, 0x00400000
    .equ input_left, 0x00008000
    .equ input_reset, 0x00000001

    .equ action_result_none, 0
    .equ action_result_collision, 1
    .equ action_result_eaten, 2
    .equ action_result_reset, 3

    .equ move_delay, 3000
    .equ move_delay_decrement, 125

main:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw s0, 4(sp)

    call gpio_init
    call text_title
main_init:
    la t0, score
    sh zero, 0(t0)
    la t0, ate_last_move
    sb zero, 0(t0)
    la t0, gpio_input_val
    sw zero, 0(t0) # flush inputs entered before program start
    la t0, direction_input
    li t1, input_right
    sw t1, 0(t0) # snake starts out moving to the right
    la t0, current_delay
    li t1, move_delay
    sh t1, 0(t0)
    li a0, 1
    call gpio_set_led
    call snake_init
    call reset_food
    call place_food
    call text_start
main_loop:
    la t0, current_delay
    lhu t0, 0(t0)
    li t1, 0 # delay counter
    j main_loop_delay_wait_check
main_loop_delay_wait:
    addi t1, t1, 1
main_loop_delay_wait_check:
    bne t1, t0, main_loop_delay_wait
    la t0, gpio_input_val
    lw a0, 0(t0)
    beqz a0, main_do_move
    li t0, input_reset
    beq a0, t0, main_init
    la t0, direction_input
    sw a0, 0(t0) # write current input
main_do_move:
    la t0, direction_input
    lw a0, 0(t0)
    la t0, ate_last_move
    lbu a1, 0(t0)
    call execute_move
    mv s0, a0
main_check_collision:
    li t0, action_result_collision
    bne s0, t0, main_check_move_tail
    li a0, 0
    call gpio_set_led
    call text_game_over
    la t0, score
    lhu a0, 0(t0)
    call text_score
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
    call increment_score
    call place_food
    call reduce_delay
    j main_loop
main_done:
    lw ra, 0(sp)
    lw s0, 4(sp)
    addi sp, sp, 8
    ret

# a0 input word
# a1 whether snake ate last move
# returns action result in a0
execute_move:
    addi sp, sp, -4
    sw ra, 0(sp)
    mv t0, a0
    mv a0, a1
execute_move_check_up:
    li t1, input_up
    bne t1, t0, execute_move_check_right
    call move_up
    j execute_move_done
execute_move_check_right:
    li t1, input_right
    bne t1, t0, execute_move_check_down
    call move_right
    j execute_move_done
execute_move_check_down:
    li t1, input_down
    bne t1, t0, execute_move_check_left
    call move_down
    j execute_move_done
execute_move_check_left:
    li t1, input_left
    bne t1, t0, execute_move_none
    call move_left
    j execute_move_done
execute_move_none:
    li a0, action_result_none
execute_move_done:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

increment_score:
    la t0, score
    lhu t1, 0(t0)
    addi t1, t1, 1
    sh t1, 0(t0)
    ret

reduce_delay:
    la t0, current_delay
    lhu t1, 0(t0)
    beqz t1, reduce_delay_done
    li t2, move_delay_decrement
    sub t1, t1, t2
    sh t1, 0(t0)
reduce_delay_done:
    ret

game_over_wait:
    la t0, gpio_input_val
    li t1, input_reset
game_over_wait_loop:
    lw t2, 0(t0)
    bne t1, t2, game_over_wait_loop
    ret

    .data

direction_input:
    .word 1
current_delay:
    .zero 2
ate_last_move:
    .zero 1
score:
    .zero 2
