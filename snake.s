    .global main
    .extern snake_init
    .extern gpio_init
    .extern gpio_input_val
    .extern gpio_set_led
    .extern move_up
    .extern move_right
    .extern move_down
    .extern move_left

    .equ input_up, 0x00000040
    .equ input_right, 0x00002000
    .equ input_down, 0x00400000
    .equ input_left, 0x00008000
    .equ input_reset, 0x00000001

    .equ action_result_none, 0
    .equ action_result_collision, 1
    .equ action_result_reset, 2

main:
    addi sp, sp, -4
    sw ra, 0(sp)

    call gpio_init
main_init:
    call snake_init
    la t0, gpio_input_val
    sw zero, 0(t0) # flush inputs entered before program start
    li a0, 1
    call gpio_set_led
main_loop:
    la t0, gpio_input_val
    lw a0, 0(t0)
    beqz a0, main_loop
    sw zero, 0(t0)
    call main_handle_input
    li t0, action_result_none
    beq a0, t0, main_loop
main_check_reset:
    li t0, action_result_reset
    bne a0, t0, main_check_collision
    j main_init
main_check_collision:
    li t0, action_result_collision
    bne a0, t0, main_loop
    li a0, 0
    call gpio_set_led
main_done:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# a0 input word
# retuns action result in a0
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
