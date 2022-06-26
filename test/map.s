    .global main
    .extern map_init
    .extern map_read
    .extern map_write
    .extern div

    .equ up, 0
    .equ right, 1
    .equ down, 2
    .equ left, 3

main:
    mv s11, ra

    call map_init
    li a0, 0
    li a1, 0
    li a2, right
    call map_write
    li a0, 3
    li a1, 0
    li a2, left
    call map_write
    li a0, 15 # last bit-pair of first word of map
    li a1, 0
    li a2, down
    call map_write
    li a0, 1
    li a1, 1
    li a2, left
    call map_write

    li a0, 1
    li a1, 1
    call map_read
    mv s10, a0

    mv ra, s11
    ret

