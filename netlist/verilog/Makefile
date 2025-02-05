# Default CIRCUIT
CIRCUIT ?= main

# Extract all directories and subdirectories inside ./src and add the current directory
INCDIRS := . $(shell find ./src -type d)
INCLUDE := $(patsubst %, -I %, $(INCDIRS))
yINCLUDE := -y . -y ./src/core

# Find all Verilog source files inside ./src/ (recursively)
VSRCS := $(shell find ./src -type f -name "*.v")

# Traverse all INCDIRs and complete the relative path of the circuit
VOBJS := $(wildcard $(addsuffix /$(CIRCUIT).v, $(INCDIRS)))

TB := $(CIRCUIT)_tb
BUILD_DIR := build
TESTBENCH_DIR := tb

# DEPENDENCIES_cpu_pipeline = inst_fetch.v inst_decoder.v ex_alu.v ex_branch.v ex_mem.v ex_csr.v registers.v
# # add the path for all dependencies
# VOBJS += $(addprefix ./src/core/, $(DEPENDENCIES_cpu_pipeline))

# Ensure the build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compilation: iverilog compilation
iverilog: $(INCDIRS) $(TESTBENCH_DIR)/$(TB).v | $(BUILD_DIR)
	iverilog $(INCLUDE) $(yINCLUDE) -o $(BUILD_DIR)/$(TB).vvp $(TESTBENCH_DIR)/$(TB).v

# Simulation: generate waveform (.vcd)
vvp: $(BUILD_DIR)/$(TB).vvp
	vvp $(BUILD_DIR)/$(TB).vvp

# Synthesis: generate circuit structure configuration file (.json)
YOSYS: $(VOBJS) | $(BUILD_DIR)
	yosys -p "prep -top $(CIRCUIT); write_json $(BUILD_DIR)/$(CIRCUIT).json" $(VOBJS)

# Visualization: generate human readable (.svg) from .json
NETLISTSVG: $(BUILD_DIR)/$(CIRCUIT).json | $(BUILD_DIR)
	netlistsvg $(BUILD_DIR)/$(CIRCUIT).json -o $(BUILD_DIR)/$(CIRCUIT).svg

# Schematic diagram only: Synthesis then Visualization
schematic: YOSYS NETLISTSVG

# Run all steps
run: iverilog vvp schematic

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)
	rm -f $(TB).vcd


# Help target to display usage manual
help:
	@echo "Usage: make <target> [CIRCUIT=<circuit_name>]"
	@echo
	@echo "Targets:"
	@echo "  iverilog       Compile the specified circuit and dependencies."
	@echo "  vvp      		Simulate the testbench for the specified circuit."
	@echo "  run           	Clean, compile and simulate the circuit."
	@echo "  clean         	Remove build directory."
	@echo "  help          	Display this help message."
	@echo
	@echo "Options:"
	@echo "  CIRCUIT       	Specify the circuit to process (default: main)."
	@echo "                	Example: make run CIRCUIT=main"
	@echo
	@echo "Note: "
	@echo "                	The testbench file must be located in the 'tb' directory."
	@echo "                	All circuit files are located in the 'src' directory."
