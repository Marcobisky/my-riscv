## Description

The markdown files in this folder contains the notes when I'm building the structure of the circuit and writing the kernel in assembly. It records my learning footprint and it's quite easy to understand.

## Journey Starts Here

### Unprivilege Stuff


#### General Data flow

First, we should have a clear picture of how the normal instructions such as `addi`, `jal`, `lb`, etc. work. These have something to do with the ALU operations, jump operations and memory operations, also you need to know how program is tracked by the program counter (PC), how instructions are stored and fetched and how to decode the instructions. So you can read these specific files in this order:

* [ALU operations](aluop.md)
* [Jump operations](jmpop.md)
* [Memory operations](memop.md)

Here is a handbook for searching any RISCV uniprivileged instruction:
* [RISCV card](../RISCV/RISCV_CARD.pdf)

#### Extensions in RISCV

In RISC-V, extensions are optional instruction sets that extend the base ISA (RV32I, 32-bit integer instructions) to add extra functionality. 

Some extensions are listed here:

| Extension | Meaning                          | Purpose                                      |
|-----------|----------------------------------|----------------------------------------------|
| M         | Integer Multiplication & Division| Adds mul, div, rem instructions              |
| A         | Atomic Instructions              | Adds atomic memory operations (e.g., amoadd.w)|
| F         | Single-Precision Floating Point  | Supports float (32-bit) operations           |
| D         | Double-Precision Floating Point  | Supports double (64-bit) operations          |
| C         | Compressed Instructions          | Reduces code size (e.g., c.add, c.sw)        |

For example, RV32IMAC → A 32-bit RISC-V CPU with Integer (I), Multiply (M), Atomic (A), and Compressed (C) extensions.

* `Zicsr`: Z (Standard), I (Integer), CSR (Support read and write to CSRs)


### Privileged Stuff

Now we can begin to learn privilege- things, read these in this order:

* [CSR control](csr.md)
* [Machine operation](machineop.md)
* [Interrupts](https://danielmangum.com/posts/risc-v-bytes-timer-interrupts/)
