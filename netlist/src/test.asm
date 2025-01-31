.section .text
.globl _start
_start:
    # Set GPIO1 pin
    li t0, 0x1FF          # configuration
    li t1, 0x1FF          # data
    sll t0, t0, 1
    sll t1, t1, 1
    li a0, 0xA0000000   # GPIO config address
    li a1, 0xA0000004   # GPIO data address
    sw t0, 0(a0)
    loop:            # loop to blink LED
        sw t1, 0(a1)
        call delay
        sw zero, 0(a1)    # turn off LED
        call delay
        jal loop

delay:
    li t2, 0x32
    1:
        addi t2, t2, -1
        bne t2, zero, 1b
    jr ra
