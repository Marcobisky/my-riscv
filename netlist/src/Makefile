OBJDIR := ./objs
HEXDIR = ./hex

CC              := riscv32-unknown-elf-gcc       # C Compiler
AS              := riscv32-unknown-elf-as        # Assembler
LD              := riscv32-unknown-elf-ld        # Linker
OBJDUMP         := riscv32-unknown-elf-objdump   # Disassembler (elf to asm)
OBJCOPY         := riscv32-unknown-elf-objcopy   # Convert ELF to Binary

READELF		    := riscv32-unknown-elf-readelf   # ELF file reader

# Add VPATH to tell Make where to look for source files
VPATH := . \
		lib

COBJS := $(OBJDIR)/main.o $(OBJDIR)/gpio.o $(OBJDIR)/delay.o

all: $(OBJDIR)/boot.bin $(OBJDIR)/kernel.bin $(OBJDIR)/test.bin

# Compile .asm files
$(OBJDIR)/%.o: %.asm
	mkdir -p $(OBJDIR)
	$(AS) -march=rv32i_zicsr -mabi=ilp32 -I lib -o $@ $^

# Compile .c files
$(COBJS): $(OBJDIR)/%.o: %.c
	mkdir -p $(OBJDIR)
	$(CC) -march=rv32i_zicsr -mabi=ilp32 -Wall -nostdlib -fno-builtin-memset -I lib -c -O2 -o $@ $<

## .o to .elf, disassemble .elf to .asm (and readelf)
# For boot
$(OBJDIR)/boot.elf: $(OBJDIR)/boot.o
	$(LD) -T boot.ld -o $@ $^
	$(OBJDUMP) -D $@ > $@.asm
	# $(READELF) --sections $@

# For main.c
$(OBJDIR)/kernel.elf: $(OBJDIR)/startup.o $(COBJS)
	$(LD) -T kernel.ld -o $@ $^
	$(OBJDUMP) -D $@ > $@.asm
	# $(READELF) --sections $@

# For test (no linker script needed)
$(OBJDIR)/test.elf: $(OBJDIR)/test.o
	$(LD) -o $@ $^
	$(OBJDUMP) -D $@ > $@.asm
	# $(READELF) --sections $@

# .elf to .bin
$(OBJDIR)/%.bin: $(OBJDIR)/%.elf
	$(OBJCOPY) -O binary -S $^ $@

.PHONY: clean
clean:
	rm -rf *.bin* *.o *.elf* *.hex $(OBJDIR) $(HEXDIR)

.PHONY: hex
hex_boot: $(OBJDIR)/boot.bin
	mkdir -p $(HEXDIR)
	python3 hexboot.py

hex_kernel: $(OBJDIR)/kernel.bin
	mkdir -p $(HEXDIR)
	python3 hexkernel.py

hex_test: $(OBJDIR)/test.bin
	mkdir -p $(HEXDIR)
	python3 hextest.py

hex: hex_boot hex_kernel hex_test