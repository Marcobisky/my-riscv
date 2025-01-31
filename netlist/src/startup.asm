.section .starttext
.globl _start
_start:
    # set sp
    li sp, 0x01000000
    # goto c main
    call main
