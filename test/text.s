    .global main
    .extern text_score

main:
    mv s11, ra

    li a0, 0
    call text_score
    li a0, 9
    call text_score
    li a0, 10
    call text_score
    li a0, 99
    call text_score
    li a0, 100
    call text_score
    li a0, 101
    call text_score
    li a0, 999
    call text_score

    mv ra, s11
    ret

