import os
import re
from collections import defaultdict

# Step 1: Extract submodules and dependencies
def extract_submodules(vhdl_file):
	with open(vhdl_file, 'r') as f:
		content = f.read()

	# Regex to match submodule blocks
	module_pattern = re.compile(r"(?i)(LIBRARY\s+ieee;.*?end\s+Behavioral;)", re.DOTALL)
	modules = module_pattern.findall(content)
	
	# Create a dictionary to store module names and their contents
	module_dict = {}
	dependency_dict = defaultdict(set)

	for module in modules:
		# Find entity name
		entity_match = re.search(r"entity\s+([a-zA-Z0-9_]+)\s+is", module)
		if entity_match:
			entity_name = entity_match.group(1)
			module_dict[entity_name] = module

			# Check for dependencies in the module
			dependencies = re.findall(r"entity\s+work\.([a-zA-Z0-9_]+)", module)
			for dep in dependencies:
				dependency_dict[entity_name].add(dep)
	
	return module_dict, dependency_dict

# Step 2: Write each submodule to a separate .vhdl file
def write_submodules_to_files(module_dict, output_dir='./src'):
	os.makedirs(output_dir, exist_ok=True)
	for entity_name, content in module_dict.items():
		file_path = os.path.join(output_dir, f"{entity_name}.vhdl")
		with open(file_path, 'w') as f:
			f.write(content)

# Step 3: Generate the Makefile
def generate_makefile(dependency_dict, output_dir='.'):
	os.makedirs(output_dir, exist_ok=True)
	
	makefile_path = os.path.join(output_dir, 'Makefile')
	
	# Collect FSYNOPSYS_FILES
	fsynopsys_files = []
	for entity_name, dependencies in dependency_dict.items():
		for dep in dependencies:
			dep_file = f"{dep}.vhdl"
			# Check if the file uses "USE ieee.std_logic_unsigned.all;"
			with open(os.path.join('./src', dep_file), 'r') as f:
				if "USE ieee.std_logic_unsigned.all;" in f.read():
					fsynopsys_files.append(dep_file)
	
	# Deduplicate FSYNOPSYS_FILES
	fsynopsys_files = list(set(fsynopsys_files))

	# Replace dependencies with macros
	def replace_with_macros(dep_list, dependency_dict):
		replaced_list = []
		for dep in dep_list:
			# Check if the dependency is a non-leaf module (has its own dependencies)
			if dep in dependency_dict and dependency_dict[dep]:
				replaced_list.append(f"$(DEPENDENCIES_{dep})")
			else:
				replaced_list.append(f"{dep}.vhdl")
		return replaced_list

	with open(makefile_path, 'w') as f:
		# Add initial content before FSYNOPSYS_FILES section
		f.write("""# Default CIRCUIT
CIRCUIT ?= main

# Paths and variables
CIRCUIT_DIR = src

TB = $(CIRCUIT)_tb
BUILD_DIR = build
TESTBENCH_DIR = tb

""")
		if fsynopsys_files:
			f.write(f"FSYNOPSYS_FILES = {' '.join(fsynopsys_files)}\n\n")
		
		# Write dependencies for each entity
		for entity_name, dependencies in dependency_dict.items():
			dep_list = replace_with_macros(dependencies, dependency_dict)
			f.write(f"DEPENDENCIES_{entity_name} = {' '.join(dep_list)} " + f"{entity_name}.vhdl\n")
		
		# Append the general pattern for dependencies, flags, and makefile commands
		f.write("""
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
	@if [ ! -f "$(TESTBENCH_DIR)/$(TB).vhdl" ]; then \\
		echo "Error: Testbench file '$(TB).vhdl' not found in $(TESTBENCH_DIR)."; \\
		exit 1; \\
	fi

# Track compiled dependencies
COMPILED_DEPS = $(DEPENDENCIES:%.vhdl=$(BUILD_DIR)/%.o)

# Compile dependencies and circuit files
compile: $(BUILD_DIR) $(CIRCUIT_DIR) check_testbench $(COMPILED_DEPS) $(BUILD_DIR)/$(CIRCUIT).o $(BUILD_DIR)/$(TB).o

# Pattern rule for compiling dependency files
$(BUILD_DIR)/%.o: %.vhdl
	@echo "\\033[0;34mCompiling $<...\\033[0m"
	@ghdl -a --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $<

# Specific rules for circuit and testbench
$(BUILD_DIR)/$(CIRCUIT).o: $(CIRCUIT_DIR)/$(CIRCUIT).vhdl $(COMPILED_DEPS)
	@echo "\\033[0;34mCompiling $(CIRCUIT).vhdl ...\\033[0m"
	@ghdl -a --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $<

$(BUILD_DIR)/$(TB).o: $(TESTBENCH_DIR)/$(TB).vhdl $(BUILD_DIR)/$(CIRCUIT).o
	@echo "\\033[0;34mCompiling $(TB).vhdl ...\\033[0m"
	@ghdl -a --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $<

# Elaborate the testbench
elaborate: compile
	@echo "\\033[0;34mElaborating ...\\033[0m"
	ghdl -e --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $(TB)

# Simulate the testbench
simulate: elaborate
	@echo "\\033[0;34mSimulating ...\\033[0m"
	ghdl -r --workdir=$(BUILD_DIR) $(FSYNOPSYS_FLAG) $(TB) --vcd=$(BUILD_DIR)/$(TB).vcd

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

# Run all steps for the circuit
run: clean compile elaborate simulate
	@echo "\\033[0;32mRun Finished\\033[0m"

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
	""")

# Step 4: Main function to orchestrate the process
def main():
	# Path to main.vhdl file
	vhdl_file = './main.vhdl'
	
	# Extract submodules and dependencies
	module_dict, dependency_dict = extract_submodules(vhdl_file)
	
	# Write submodules to files
	write_submodules_to_files(module_dict)
	
	# Generate the Makefile
	generate_makefile(dependency_dict)

if __name__ == "__main__":
	main()