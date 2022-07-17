#    .global mult
    .global div

# signed multiplication using the shift-add algorithm
# a0 is multiplicand
# a1 is multiplier
# t0 is product
# product placed in a0
#mult:
#    li t0, 0
#mult_loop:
#    beq a1, x0, mult_done
#    andi t1, a1, 1 # test rightmost bit of multiplier
#    beq t1, x0, mult_noadd
#    add t0, t0, a0
#mult_noadd:
#    slli a0, a0, 1
#    srli a1, a1, 1
#    j mult_loop
#mult_done:
#    mv a0, t0
#    ret


# unsigned division using using repeated subtraction
# performant as long as dividend and divisor aren't far apart (factor 10 is ok)
# division by 0 results in quotient = 0, remainder = dividend
# a0 is dividend
# a1 is divisor
# quotient placed in a0
# remainder placed in a1
div:
  li t0, 0
  beq a1, x0, div_done
  j div_test
div_loop:
  sub a0, a0, a1
  addi t0, t0, 1
div_test:
  bleu a1, a0, div_loop
div_done:
  mv a1, a0
  mv a0, t0
  ret

