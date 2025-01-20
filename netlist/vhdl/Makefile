# Default CIRCUIT
CIRCUIT ?= main

# Paths and variables
CIRCUIT_DIR = src

TB = $(CIRCUIT)_tb
BUILD_DIR = build
TESTBENCH_DIR = tb

FSYNOPSYS_FILES = DIG_Add.vhdl DIG_LUT_LUT_inst_Decoder.vhdl

DEPENDENCIES_decoder_3bit = MUX_GATE_BUS_1.vhdl DECODER_3.vhdl decoder_3bit.vhdl
DEPENDENCIES_decoder_2bit = MUX_GATE_BUS_1.vhdl DECODER_1.vhdl decoder_2bit.vhdl
DEPENDENCIES_instruction_decoder = DECODER_4.vhdl DIG_LUT_LUT_inst_Decoder.vhdl COMP_GATE_UNSIGNED.vhdl MUX_GATE_1.vhdl DRIVER_INV_GATE_BUS.vhdl MUX_GATE_BUS_1.vhdl $(DEPENDENCIES_decoder_2bit) $(DEPENDENCIES_decoder_3bit) instruction_decoder.vhdl
DEPENDENCIES_boot_rom = DIG_ROM_Boot_B1.vhdl DIG_ROM_Boot_B3.vhdl DIG_ROM_Boot_B0.vhdl DIG_ROM_Boot_B2.vhdl boot_rom.vhdl
DEPENDENCIES_program_counter = MUX_GATE_BUS_1.vhdl DIG_Register_BUS.vhdl DIG_Add.vhdl DRIVER_INV_GATE_BUS.vhdl program_counter.vhdl
DEPENDENCIES_cust_ctrl = DIG_Register_BUS.vhdl DRIVER_INV_GATE_BUS.vhdl cust_ctrl.vhdl
DEPENDENCIES_main = $(DEPENDENCIES_instruction_decoder) $(DEPENDENCIES_cust_ctrl) $(DEPENDENCIES_program_counter) $(DEPENDENCIES_boot_rom) main.vhdl

# General pattern to resolve dependencies
DEPENDENCIES = $(addprefix $(CIRCUIT_DIR)/, $(DEPENDENCIES_$(CIRCUIT)))

# Determine if -fsynopsys is needed
FSYNOPSYS_FLAG = $(if $(filter $(CIRCUIT) $(DEPENDENCIES_$(CIRCUIT)), $(FSYNOPSYS_FILES)), -fsynopsys)

# Ensure the build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Ensure the testbench directory exists
$(TESTBENCH_DIR):
	mkdir -p $(TESTBENCH_DIR)

# Ensure the dataflow directory exists
$(CIRCUIT_DIR):
	mkdir -p $(CIRCUIT_DIR)

# Check for testbench file, create placeholder if not found
check_testbench: $(TESTBENCH_DIR)
	@if [ ! -f "$(TESTBENCH_DIR)/$(TB).vhdl" ]; then \
		echo "Error: Testbench file '$(TB).vhdl' not found in $(TESTBENCH_DIR)."; \
		exit 1; \
	fi

# Track compiled dependencies
COMPILED_DEPS = $(DEPENDENCIES:%.vhdl=$(BUILD_DIR)/%.o)

# Compile dependencies and circuit files
compile: $(BUILD_DIR) $(CIRCUIT_DIR) check_testbench $(COMPILED_DEPS) $(BUILD_DIR)/$(CIRCUIT).o $(BUILD_DIR)/$(TB).o

# Pattern rule for compiling dependency files
$(BUILD_DIR)/%.o: %.vhdl
	@echo "\033[0;34mCompiling $<...\033[0m"
	@ghdl -a --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $<

# Specific rules for circuit and testbench
$(BUILD_DIR)/$(CIRCUIT).o: $(CIRCUIT_DIR)/$(CIRCUIT).vhdl $(COMPILED_DEPS)
	@echo "\033[0;34mCompiling $(CIRCUIT).vhdl ...\033[0m"
	@ghdl -a --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $<

$(BUILD_DIR)/$(TB).o: $(TESTBENCH_DIR)/$(TB).vhdl $(BUILD_DIR)/$(CIRCUIT).o
	@echo "\033[0;34mCompiling $(TB).vhdl ...\033[0m"
	@ghdl -a --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $<

# Elaborate the testbench
elaborate: compile
	@echo "\033[0;34mElaborating ...\033[0m"
	ghdl -e --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $(TB)

# Simulate the testbench
simulate: elaborate
	@echo "\033[0;34mSimulating ...\033[0m"
	ghdl -r --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $(TB) --vcd=$(BUILD_DIR)/$(TB).vcd

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

# Run all steps for the circuit
run: clean compile elaborate simulate
	@echo "\033[0;32mRun Finished\033[0m"

# Help target to display usage manual
help:
	@echo "Usage: make <target> [CIRCUIT=<circuit_name>]"
	@echo
	@echo "Targets:"
	@echo "  compile       Compile the specified circuit and dependencies."
	@echo "  elaborate     Elaborate the testbench for the specified circuit."
	@echo "  simulate      Simulate the testbench for the specified circuit."
	@echo "  run           Clean, compile, elaborate, and simulate the circuit."
	@echo "  clean         Remove build directory and temporary files."
	@echo "  help          Display this help message."
	@echo
	@echo "Options:"
	@echo "  CIRCUIT       Specify the circuit to process (default: main)."
	@echo "                Example: make run CIRCUIT=main"
	@echo
	@echo "Note: "
	@echo "                The testbench file must be located in the 'testbench' directory."
	@echo "                All circuit files are located in the 'dataflow' directory."
	