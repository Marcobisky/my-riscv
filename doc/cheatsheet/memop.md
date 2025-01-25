## Introduction

One category of instructions is memory operations (abbr. memop), which is just exchanging data between GPRs to memory locations.

So naturally, these signals are crucial for storing a data into memory:

* `WE`: Write enable. Whenever a memop intruction is detected, the memory block needs to be enabled.
* `[31:0] data_mem`: the 32-bit data to be stored.
* `[31:0] mem_addr`: where to be stored.
* `[3:0] storebytes_size`: Store a byte (0001), half word (0011), or a word (1111)?

## Commonly Used memop instructions

```assembly
lui t0, 0x40000 ;t0 = 0x40000 << 12b (load unsigned imm)
lb t0, 1(a0)    ;t0 = mem[a0 + 1] (load byte)
lh t0, 2(a0)    ;t0 = mem[a0 + 2] (load half word)
lw t0, 4(a0)    ;t0 = mem[a0 + 4] (load word)
lbu t0, 1(a0)   ;unsigned (zero extending)
lhu t0, 2(a0)   ;unsigned (zero extending)

sb t0, 1(a0)    ;mem[a0 + 1] = t0 (store byte)
sh t0, 2(a0)    ;mem[a0 + 2] = t0 (store half word)
sw t0, 4(a0)    ;mem[a0 + 4] = t0 (store word)
```