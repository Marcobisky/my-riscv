## Introduction

One category of instructions is arithmetic operations (abbr. aluop), which is just doing things between GPRs.

## Commonly Used aluop instructions

```assembly
lui t0, 0x40000     ;t0 = 0x40000 << 12 (load upper 20 bits of the imm)

add t0, t1, t2      ;t0 = t1 + t2
sub t0, t1, t2      ;t0 = t1 - t2 (no imm version)
or t0, t1, t2       ;t0 = t1 | t2
and t0, t1, t2      ;t0 = t1 & t2
xor t0, t1, t2      ;t0 = t1 ^ t2

addi t0, t1, 10     ;t0 = t1 + 10 (decimal)
ori t0, t1, 0xF     ;t0 = t1 | 0xF
andi t0, t1, 0xF    ;t0 = t1 & 0xF
xori t0, t1, 0xF    ;t0 = t1 ^ 0xF

sll t0, t1, t2      ;t0 = t1 << t2 (shift left logical)
srl t0, t1, t2      ;t0 = t1 >> t2 (shift right logical)
sra t0, t1, t2      ;t0 = t1 >> t2 (shift right arithmetic, preserve sign)

slli t0, t1, 2      ;t0 = t1 << 2
srli t0, t1, 2      ;t0 = t1 >> 2
srai t0, t1, 2      ;t0 = t1 >> 2 (preserve sign)

slt t0, t1, t2      ;t0 = (t1 < t2) (set if less than signed)
sltu t0, t1, t2     ;t0 = (t1 < t2) (set if less than unsigned)

slti t0, t1, -5     ;t0 = (t1 < -5) (imm signed)
sltiu t0, t1, 10    ;t0 = (t1 < 10) (imm unsigned)
```