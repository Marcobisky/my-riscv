`timescale 1ns / 1ps
`include "config.v"

module inst_decoder_tb;

    // Inputs
    reg [`MAX_BIT_POS:0] instruction_code;
    reg en;

    // Outputs
    wire [4:0] rd, rs1, rs2;
    wire [19:0] imm_1231;
    wire invalid_instruction;
    wire [47:0] inst_flags;

    // Instantiate the instruction decoder
    inst_decoder uut (
        .instruction_code(instruction_code),
        .en(en),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2),
        .imm_1231(imm_1231),
        .invalid_instruction(invalid_instruction),
        .inst_flags(inst_flags)
    );

    // Waveform dump
    initial begin
        $dumpfile("./build/inst_decoder_tb.vcd");  // Specify the VCD file name
        $dumpvars(0, inst_decoder_tb);    // Dump all signals in this module
    end

    // Test sequence
    initial begin
        // Monitor changes
        $monitor("Time=%0t | Inst=%h | en=%b | RD=%b | RS1=%b | RS2=%b | Imm=%h | Invalid=%b | Flags=%b", 
                 $time, instruction_code, en, rd, rs1, rs2, imm_1231, invalid_instruction, inst_flags);

        // Initialize inputs
        en = 0;
        instruction_code = 0;
        #10;
        
        // Enable decoder
        en = 1;
        
        // Test BEQ (Branch Equal) Instruction
        instruction_code = 32'b000000000001_00001_000_00010_1100011; // BEQ R1, R2, offset
        #10;

        // Test ADDI (Add Immediate)
        instruction_code = 32'b000000000101_00001_000_00010_0010011; // ADDI R1, R2, 5
        #10;

        // Test LUI (Load Upper Immediate)
        instruction_code = 32'b00000000000000000001_00001_0110111; // LUI R1, Imm
        #10;

        // Test LW (Load Word)
        instruction_code = 32'b000000000100_00010_010_00001_0000011; // LW R1, offset(R2)
        #10;

        // Test SW (Store Word)
        instruction_code = 32'b000000000101_00010_010_00001_0100011; // SW R1, offset(R2)
        #10;

        // Test JAL (Jump and Link)
        instruction_code = 32'b00000000000000000000_00001_1101111; // JAL R1, offset
        #10;

        // Test JALR (Jump and Link Register)
        instruction_code = 32'b000000000000_00001_000_00010_1100111; // JALR R1, R2, offset
        #10;

        // Test AND
        instruction_code = 32'b0000000_00010_00001_111_00011_0110011; // AND R3, R1, R2
        #10;

        // Test OR
        instruction_code = 32'b0000000_00010_00001_110_00011_0110011; // OR R3, R1, R2
        #10;

        // Test XOR
        instruction_code = 32'b0000000_00010_00001_100_00011_0110011; // XOR R3, R1, R2
        #10;

        // Test Invalid Instruction
        instruction_code = 32'b11111111111111111111_11111_1111111; // Invalid instruction
        #10;

        // Disable decoder
        en = 0;
        instruction_code = 32'b0;
        #10;

        // End simulation
        $finish;
    end

endmodule