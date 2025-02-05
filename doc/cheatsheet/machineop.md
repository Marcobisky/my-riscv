## Introduction

One category of instructions is machine operations (abbr. machineop), which is a set of *privileged* instructions in the RISC-V privileged architecture. These instructions are all related to the [CSRs](csr.md), so make sure you are familiar with those registers first.

## RISCV Privilege Levels from High to Low

* Debug (D)
* Machine (M): "must-have"
* Supervisor (S)
    - Hypervisor-extended Supervisor (HS)
    - Virtual Supervisor (VS)
    - Virtual User (VU)
* User (U)

## Commonly Used machineop instructions

### `mret`

Return from Machine-mode to Supervisor-mode (or User-mode). Steps:

1.	Restore the privilege mode:
*	The processor sets the current privilege mode based on MPP from mstatus.
*	MPP is cleared to user mode (00) or supervisor mode (01) if applicable.
2.	Restore the interrupt enable status:
*	The MIE bit in mstatus is set to MPIE.
*	The MPIE bit is cleared (0).
3.	Restore the program counter (PC):
*	The PC is set to the value stored in mepc, resuming execution where it was interrupted.