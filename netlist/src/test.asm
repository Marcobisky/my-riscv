.section .text
.globl _start
_start:
    # Set GPIO1 pin
    li t0, 0x1          # Value to set GPIO1
    li a0, 0xA0000000   # GPIO config address
    li a1, 0xA0000004   # GPIO data address
    sw t0, 0(a0)        # Config GPIO1 to output
    sw t0, 0(a1)        # Write to GPIO1

    # Infinite loop to prevent returning
    1: 
        j 1b