## Introduction

* CSR (Control and Status Registers)
* Are accessed using CSR instructions, not via memory-mapped I/O like GPIO registers.
* GPRs can be accessed at any privilege level, while CSRs are defined at a specific privilege level and can only be accessed by that level and any levels of higher privilege.
* Every CSR has a unique address, each 32 bits share one address (instead of 8 bits).
* CSR addresses are 12-bits, meaning that up to 4,096 CSRs can be implemented ($2^12 = 4096$). The bits in a CSR address define its accessibility, use, and CSR number.
![https://danielmangum.com/posts/risc-v-bytes-privilege-levels/](csr-addr-def.png)

* While GPRs are used for storing data used to perform operations, CSRs typically modify the behavior of a hart (i.e. “Control”) or inform of its state and attributes (i.e. “Status”), or both.

## Commonly Used CSRs and their sub-fields

![reg (addr, reset_val)](common-csrs.png)

1.	`mstatus (0x300, 0x00001800)`: Machine Status (lower 32 bits), controls global interrupt enable and privilege modes.
- `mstatus.MPP[12:11]`: Machine Previous Priviledge mode. When an mret is executed, the privilege mode is change to this value.
- `mstatus.MIE[3]`: Machine (*global*) Interrupt Enable.

2.	`mie (0x304, 0x00000000)`: Machine Interrupt Enable, enables *specific* interrupts.
- `MTIE[7]`: Machine Timer Interrupt Enable

3.	`mtvec (0x305, )`: Machine Trap-Handler Base Address, specifies where the CPU jumps on an interrupt/exception.
4.	`mepc (0x341, 0x00000000)`: Machine Exception Program Counter, saves the address of the interrupted instruction. When an exception is encountered, the current program counter is saved in MEPC, and the core jumps to the exception address. When a mret instruction is executed, the value from MEPC replaces the current program counter.
5.	`mcause (0x342)`: Machine Trap Cause, identifies the cause of the interrupt/exception.
6.	`mtval (0x343)`: Machine Trap Value, provides extra information about exceptions.
7.	`mip (0x344)`: Machine Interrupt Pending Register, indicates which interrupts are pending.

## Commonly Used CSR instructions

```assembly
;register version:
csrrw x5, mstatus, x10  ;x5 = mstatus (read), mstatus = x10 (write)
csrw mtvec, t0          ;mtvec = t0 (write only)
csrrs x5, mie, x10      ;x5 = mie (read), mie |= x10 (set)
csrrc x5, mie, x10      ;x5 = mie (read), mie &= x10 (clear)

;imm version:
csrrwi x5, mstatus, 0x1 ;x5 = mstatus (read), mstatus = 0x1 (write imm)
csrrsi x5, mie, 0x1     ;x5 = mie (read), mie |= 0x1 (set imm)
csrrc x5, mie, 0x1      ;x5 = mie (read), mie &= 0x1 (clear imm)
```

Convenient pseudo-instructions:

```assembly
csrr rd, csr    ;csrrs rd, csr, x0
csrw csr, rs    ;csrrw x0, csr, rs
csrs csr, rs    ;csrrs x0, csr, rs
csrc csr, rs    ;csrrc x0, csr, rs
csrwi csr, imm  ;csrrwi x0, csr, imm
csrsi csr, imm  ;csrrsi x0, csr, imm
csrci csr, imm  ;csrrci x0, csr, imm
```