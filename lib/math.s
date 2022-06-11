# multiplication using the shift-add algorithm
# a0 is multiplicand
# a1 is multiplier
# t0 is product

.global mult

mult:
    li t0, 0
mult_loop:
    beq a1, x0, mult_done
    andi t1, a1, 1 # test rightmost bit of multiplier
    beq t1, x0, mult_noadd
    add t0, t0, a0
mult_noadd:
    slli a0, a0, 1
    srli a1, a1, 1
    j mult_loop
mult_done:
    mv a0, t0
    ret

