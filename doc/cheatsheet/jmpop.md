## Introduction

One category of instructions is jump operations (abbr. jmpop), which is just changing the value of PC (or some GPRs by the way)

## Commonly Used aluop instructions

```assembly
; unconditional:
jal ra, 0x10        ;ra = PC + 4, PC += 0x10 (link and jump, should be laj)
jalr ra, 8(t0)      ;ra = PC + 4, PC += t0+8 (wrt a register)

; conditional:
beq t0, t1, 0x8     ;PC += 0x8 if t0 == t1 (branch if equal)
bne t0, t1, 0x8     ;PC += 0x8 if t0 != t1 (branch if not equal)
blt t0, t1, 0x8     ;PC += 0x8 if t0 < t1 (signed less than)
bge t0, t1, 0x8     ;PC += 0x8 if t0 >= t1 (signed greater or equal)
bltu t0, t1, 0x8    ;PC += 0x8 if t0 < t1 (unsigned less than)
bgeu t0, t1, 0x8    ;PC += 0x8 if t0 >= t1 (unsigned greater or equal)

auipc t0, 0x1000    ;t0 = PC + (0x1000 << 12) (add upper imm and PC to a reg)
```

## Notes

```assembly
load:
    lbu a1, 0(t1)
    sb a1, 0(t2)
    addi t1, t1, 1
    addi t2, t2, 1
    bltu t2, t3, load
```

If `lbu a1, 0(t1)` is at location 0x8000001a, then this line: `bltu t2, t3, load` does NOT mean 

```assembly
PC += 0x8000001a if t2 < t3
```

but 

```assembly
PC = 0x8000001a if t2 < t3
```

(done by the smart compiler!)