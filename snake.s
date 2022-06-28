    .global main
    .extern snake_init
    .extern input_init
    .extern input_val
    .extern move_up
    .extern move_right
    .extern move_down
    .extern move_left

    .equ input_up, 0x00000040
    .equ input_right, 0x00002000
    .equ input_down, 0x00400000
    .equ input_left, 0x00008000

main:
    addi sp, sp, -4
    sw ra, 0(sp)
    call snake_init
    call input_init
main_loop:
    la t0, input_val
    lw a0, 0(t0)
    beqz a0, main_loop
    sw x0, 0(t0)
    call main_move
    j main_loop

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

# a0 input word
main_move:
    addi sp, sp, -4
    sw ra, 0(sp)
main_move_check_up:
    li t0, input_up
    bne t0, a0, main_move_check_right
    call move_up
    j main_move_done
main_move_check_right:
    li t0, input_right
    bne t0, a0, main_move_check_down
    call move_right
    j main_move_done
main_move_check_down:
    li t0, input_down
    bne t0, a0, main_move_check_left
    call move_down
    j main_move_done
main_move_check_left:
    li t0, input_left
    bne t0, a0, main_move_done
    call move_left
main_move_done:
    lw ra, 0(sp)
    addi sp, sp, 4
    ret
