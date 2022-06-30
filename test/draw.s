.global main
.extern input_init
.extern input_val
.extern draw_pixel
.extern read_pixel
.extern draw_clear

.equ input_up, 0x00000040
.equ input_right, 0x00002000
.equ input_down, 0x00400000
.equ input_left, 0x00008000

main:
    mv s0, ra
    call input_init
main_loop:
    la t0, input_val
    lw a0, 0(t0)
    beqz a0, main_loop
    sw x0, 0(t0)
    call draw_input
    j main_loop

    mv ra, s0
    ret

# a0 input word
draw_input:
    addi sp, sp, -8
    sw ra, 0(sp)
    sw a0, 4(sp)

    call draw_clear

    lw t0, 4(sp)
    li a2, -1
draw_input_check_up:
    li t1, input_up
    bne t1, t0, draw_input_check_right
    li a0, 16
    li a1, 8
    call draw_pixel
    li a0, 16
    li a1, 8
    call read_pixel
    mv x31, a0
    j draw_input_done
draw_input_check_right:
    li t1, input_right
    bne t1, t0, draw_input_check_down
    li a0, 24
    li a1, 16
    call draw_pixel
    li a0, 24
    li a1, 16
    call read_pixel
    mv x31, a0
    j draw_input_done
draw_input_check_down:
    li t1, input_down
    bne t1, t0, draw_input_check_left
    li a0, 16
    li a1, 24
    call draw_pixel
    li a0, 16
    li a1, 24
    call read_pixel
    mv x31, a0
    j draw_input_done
draw_input_check_left:
    li t1, input_left
    bne t1, t0, draw_input_done
    li a0, 8
    li a1, 16
    call draw_pixel
    li a0, 8
    li a1, 15 # adjacent pixel to test resetting x31
    call read_pixel
    mv x31, a0
    j draw_input_done
draw_input_done:
    lw ra, 0(sp)
    addi sp, sp, 8
    ret

