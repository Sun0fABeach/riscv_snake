.global gpio_init
.global gpio_input_handler
.global gpio_input_val
.global gpio_set_led

.equ gpio_base_addr, 0xD0000000
.equ gpio_direction_mask, 0x00FFFFFF
.equ gpio_interrupt_enable, 0x0040A041

gpio_init:
    li t0, gpio_base_addr
    li t1, gpio_direction_mask
    sw t1, 0(t0)
    li t1, gpio_interrupt_enable
    sw t1, 4(t0)
    ret

gpio_input_handler:
# only use saved registers to avoid thrashing registers of interrupted routine
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)

    li s0, gpio_base_addr
    lw s1, 0x8(s0)
# only handle 0 -> 1 (mouse down)
    beqz s1, gpio_input_handler_done
    la s2, gpio_input_val
    sw s1, 0(s2)
    sw zero, 0x8(s0)
gpio_input_handler_done:
    sw zero, 0xC(s0)

    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret

# a0: led on/off (1/0)
gpio_set_led:
    li t0, gpio_base_addr
    beqz a0, gpio_set_led_off
    li t1, 0x01000000
    j gpio_set_led_write
gpio_set_led_off:
    li t1, 0x00000000
gpio_set_led_write:
    sw t1, 0x10(t0)
    ret

    .data

gpio_input_val:
    .word 0

