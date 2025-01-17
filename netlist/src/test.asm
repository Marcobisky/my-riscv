.section .text
.globl _start

_start:
    li a0, 42        # Load 42 into register a0
    li a7, 93        # Load 93 into register a7 (exit syscall)
    ecall            # Make a system call to exit