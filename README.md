## Project Description

(This project is far from finished, btw.)

This is a personal project, aiming to build a CPU in RISC-V architecture.

## Usage

### How to install the RV32GC toolchain?

Following the instructions on the opensource [riscv-gnu-toolchain](https://github.com/riscv-collab/riscv-gnu-toolchain). Specifically on MacOS M2 chip, cd into a folder, then (make sure you have installed `brew`):

```bash
git clone https://github.com/riscv/riscv-gnu-toolchain
brew install python3 gawk gnu-sed make gmp mpfr libmpc isl zlib expat texinfo flock libslirp
./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32d     
gmake
```

Then add the CLI to `system path` (permanently):

```bash
export PATH=$PATH:/opt/riscv/bin
```