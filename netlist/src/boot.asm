.section .text
.globl _start
_start:
    # cust flag set instruction code
    .word 0x8000007F
    # ssd base address
    li t1, 0x40000000 # load immediate
    # kernel memory base
    li t2, 0x02000000
    # total 2048 bytes
    li t3, 0x02000800

load:
    lbu a1, 0(t1) # load byte unsigned <-
    sb a1, 0(t2) # store byte ->
    addi t1, t1, 1
    addi t2, t2, 1
    bltu t2, t3, load # branch if less than unsigned
    # clear all registers
    lui t0, 0
    lui t1, 0
    lui t2, 0
    lui t3, 0

    # jump to start
    call 0x02000000
