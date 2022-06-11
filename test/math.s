.global main
.extern mult

main:
    mv s11, ra
    li a0, 2
    li a1, 3
    jal mult
    mv s0, a0
    li a0, 5
    li a1, -7
    jal mult
    mv s1, a0
    mv ra, s11
    ret

