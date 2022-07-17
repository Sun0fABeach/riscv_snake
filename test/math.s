    .global main
#    .extern mult
    .extern div

main:
    mv s11, ra

#mult
#    li a0, 2
#    li a1, 3
#    jal mult
#    mv s0, a0
#    li a0, 5
#    li a1, -7
#    jal mult
#    mv s1, a0
#    li a0, -5
#    li a1, 7
#    jal mult
#    mv s2, a0
#    li a0, -5
#    li a1, -7
#    jal mult
#    mv s3, a0

#div
    li a0, 10
    li a1, 5
    jal div
    mv s4, a0
    mv s5, a1
    li a0, 13
    li a1, 6
    jal div
    mv s6, a0
    mv s7, a1
    li a0, 10
    li a1, 12
    jal div
    mv s8, a0
    mv s9, a1
    li a0, 1
    li a1, 0
    jal div
    mv t0, a0
    mv t1, a1

    mv ra, s11
    ret

