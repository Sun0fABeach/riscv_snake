.global input_init
.global input_handler
.global input_val

.equ gpio_base_addr, 0xD0000000
.equ gpio_interrupt_enable, 0x0040A040

input_init:
    li t0, gpio_base_addr
    li t1, gpio_interrupt_enable
    sw t1, 4(t0)
    ret

input_handler:
# only use saved registers to avoid thrashing registers of interrupted routine
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)

    li s0, gpio_base_addr
    lw s1, 0x8(s0)
# only handle 0 -> 1 (mouse down)
    beqz s1, input_handler_done
    la s2, input_val
    sw s1, 0(s2)
    sw x0, 0x8(s0)
input_handler_done:
    sw x0, 0xC(s0)

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret

    .data

input_val:
    .word 0
