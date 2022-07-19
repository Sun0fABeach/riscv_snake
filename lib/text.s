    .global text_title
    .global text_start
    .global text_game_over
    .global text_score

    .extern div

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

# a0: score to display
text_score:
    # we know write_text, div and write_integer won't use t5 / t6
    mv t6, ra
    mv t5, s0

    mv s0, a0
    la a0, score
    call write_text
    mv a0, s0
    li a1, 100
    bltu a0, a1, text_score_check_tens
    call div
    call write_integer
    mv a0, a1
    li a1, 10
    j text_score_write_tens
text_score_check_tens:
    li a1, 10
    bltu a0, a1, text_score_write_ones
text_score_write_tens:
    call div
    call write_integer
    mv a0, a1
text_score_write_ones:
    call write_integer

    mv s0, t5
    mv ra, t6
    ret

# a0: integer to write as ascii char
write_integer:
    addi a0, a0, 48
    li t0, text_out
    sb a0, 0(t0)
    ret

# a0: address of string to write
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
score:
    .string " Score: "
