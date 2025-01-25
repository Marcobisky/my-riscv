OBJDIR := ./objs
FILENAME := boot

CC              := riscv32-unknown-elf-gcc       # C Compiler
AS              := riscv32-unknown-elf-as        # Assembler
LD              := riscv32-unknown-elf-ld        # Linker
OBJDUMP         := riscv32-unknown-elf-objdump   # Disassembler (elf to asm)
OBJCOPY         := riscv32-unknown-elf-objcopy   # Convert ELF to Binary

READELF		    := riscv32-unknown-elf-readelf   # ELF file reader

all: $(OBJDIR)/boot.bin $(OBJDIR)/test.bin

# Compile .asm files
$(OBJDIR)/%.o: %.asm
	mkdir -p $(OBJDIR)
	$(AS) -march=rv32i_zicsr -mabi=ilp32 -o $@ $^

# .o to .elf, disassemble .elf to .asm, and readelf
$(OBJDIR)/boot.elf: $(OBJDIR)/boot.o
	$(LD) -T boot.ld -o $@ $^
	$(OBJDUMP) -D $@ > $@.asm
	$(READELF) --sections $@

$(OBJDIR)/test.elf: $(OBJDIR)/test.o
	$(LD) -T test.ld -o $@ $^
	$(OBJDUMP) -D $@ > $@.asm
	$(READELF) --sections $@

# .elf to .bin
$(OBJDIR)/%.bin: $(OBJDIR)/%.elf
	$(OBJCOPY) -O binary -S $^ $@

.PHONY: clean
clean:
	rm -rf *.bin* *.o *.elf* *.hex $(OBJDIR)

.PHONY: hex
hex:
	python3 hexboot.py
	python3 hextest.py