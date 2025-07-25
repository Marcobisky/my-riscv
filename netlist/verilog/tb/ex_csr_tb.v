`timescale 1ns / 1ps
`include "./src/config.v"

module ex_csr_tb;

    // Testbench signals
    reg rst;
    reg [4:0] rd;
    reg [4:0] imm_1519;
    reg [`MAX_BIT_POS:0] rs1_data, csr_data;
    reg [11:0] imm_2031;
    reg [47:0] inst_flags;

    wire [4:0] rd_out;
    wire out_en;
    wire [`MAX_BIT_POS:0] rd_data;
    wire csr_out_en;
    wire [`MAX_BIT_POS:0] csrw_data;
    wire [11:0] csrw_addr;

    // Instantiate the DUT (Device Under Test)
    ex_csr dut (
        .rst(rst),
        .rd(rd),
        .imm_1519(imm_1519),
        .rs1_data(rs1_data),
        .csr_data(csr_data),
        .imm_2031(imm_2031),
        .inst_flags(inst_flags),
        .rd_out(rd_out),
        .out_en(out_en),
        .rd_data(rd_data),
        .csr_out_en(csr_out_en),
        .csrw_data(csrw_data),
        .csrw_addr(csrw_addr)
    );

    // VCD Dump for waveform analysis
    initial begin
        $dumpfile("./build/ex_csr_tb.vcd");  // VCD output file
        $dumpvars(0, ex_csr_tb);    // Dump all variables
    end

    // Test procedure
    initial begin
        // Initialize values
        rst = 0;
        rd = 5'b00000;
        imm_1519 = 5'b00000;
        rs1_data = 32'h00000000;
        csr_data = 32'h00000000;
        imm_2031 = 12'h000;
        inst_flags = 48'h000000000000;

        #5 rst = 1; // Activate reset

        // Test CSRRW (Control and Status Register Read-Write)
        #10 inst_flags[41] = 1; rs1_data = 32'hAAAA5555;
        #10 inst_flags[41] = 0;

        // Test CSRRS (Control and Status Register Read-Set)
        #10 inst_flags[39] = 1; rs1_data = 32'hFFFF0000;
        #10 inst_flags[39] = 0;

        // Test CSRRC (Control and Status Register Read-Clear)
        #10 inst_flags[37] = 1; rs1_data = 32'h0000FFFF;
        #10 inst_flags[37] = 0;

        // Test CSRRSI (Control and Status Register Read-Set Immediate)
        #10 inst_flags[40] = 1; imm_1519 = 5'b10101;
        #10 inst_flags[40] = 0;

        // Test CSRRWI (Control and Status Register Read-Write Immediate)
        #10 inst_flags[42] = 1; imm_1519 = 5'b01110;
        #10 inst_flags[42] = 0;

        // Test CSRRCI (Control and Status Register Read-Clear Immediate)
        #10 inst_flags[38] = 1; imm_1519 = 5'b11011;
        #10 inst_flags[38] = 0;

        // End simulation
        #20 $finish;
    end

endmodule