.global input_init
.global input_handler

.equ gpio_base_addr, 0xD0000000
.equ gpio_interrupt_enable, 0x0040A040

input_init:
    li t0, gpio_base_addr
    li t1, gpio_interrupt_enable
    sw t1, 4(t0)
    ret

input_handler:
    li t0, gpio_base_addr
    lw t1, 0x8(t0)
# only handle 0 -> 1 (mouse down)
    beqz t1, input_handler_done
    la t2, input_val
    sw t1, 0(t2)
    sw x0, 0x8(t0)
input_handler_done:
    sw x0, 0xC(t0)
    ret

    .data

input_val:
    .word 0
