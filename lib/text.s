    .global text_title
    .global text_start
    .global text_game_over

    .equ text_out, 0xC0000000

text_title:
    # store ra on t6 b/c we know t6 won't be used in write_text
    mv t6, ra
    la a0, title
    call write_text
    mv ra, t6
    ret

text_start:
    mv t6, ra
    la a0, start
    call write_text
    mv ra, t6
    ret

text_game_over:
    mv t6, ra
    la a0, game_over
    call write_text
    mv ra, t6
    ret

write_text:
    li t0, text_out
write_text_loop:
    lbu t1, 0(a0)
    beqz t1, write_text_done
    sb t1, 0(t0)
    addi a0, a0, 1
    j write_text_loop
write_text_done:
    ret

    .data

title:
    .string "*** Snake ***"
start:
    .string "\nStart!"
game_over:
    .string "\nGame Over!"
