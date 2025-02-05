`include "../config.v"
module ex_csr (
    input rst,
    input [4:0] rd,
    input [4:0] imm_1519,
    input [`MAX_BIT_POS:0] rs1_data, csr_data,
    input [11:0] imm_2031,
    input [47:0] inst_flags,
    output reg [4:0] rd_out,
    output reg out_en,
    output reg [`MAX_BIT_POS:0] rd_data,
    output reg csr_out_en,
    output reg [`MAX_BIT_POS:0] csrw_data,
    output reg [11:0] csrw_addr
);

    wire inst_csrrc; 
    wire inst_csrrci;
    wire inst_csrrs;
    wire inst_csrrsi;
    wire inst_csrrw;
    wire inst_csrrwi;

    assign inst_csrrc = inst_flags[37];
    assign inst_csrrci = inst_flags[38];
    assign inst_csrrs = inst_flags[39];
    assign inst_csrrsi = inst_flags[40];
    assign inst_csrrw = inst_flags[41];
    assign inst_csrrwi = inst_flags[42];

/* verilator lint_off LATCH */
always @(*) begin
    if (rst) begin
        rd_out = rd;
        csrw_addr = imm_2031;
        if (inst_csrrc) begin
            out_en = 1'b1;
            csr_out_en = 1'b1;
            rd_data = csr_data;
            csrw_data = csr_data & ~rs1_data;
        end
        else if (inst_csrrci) begin
            out_en = 1'b1;
            csr_out_en = 1'b1;
            rd_data = csr_data;
            csrw_data = csr_data & ~{27'b0,imm_1519};
        end
        else if (inst_csrrsi) begin
            out_en = 1'b1;
            csr_out_en = 1'b1;
            csrw_data = csr_data & {27'b0,imm_1519};
            rd_data = csr_data;
        end
        else if (inst_csrrs) begin
            out_en = 1'b1;
            csr_out_en = 1'b1;
            csrw_data = csr_data & rs1_data;
            rd_data = csr_data;
        end
        else if (inst_csrrwi) begin
            out_en = 1'b1;
            csr_out_en = 1'b1;
            csrw_data = {27'b0,imm_1519};
            rd_data = csr_data;
        end
        else if (inst_csrrw) begin
            out_en = 1'b1;
            csr_out_en = 1'b1;
            csrw_data = rs1_data;
            rd_data = csr_data;
        end
        else begin
            out_en = 1'b0;
            csr_out_en = 1'b0;
        end
    end
    else begin
        out_en = 1'b0;
        csr_out_en = 1'b0;
    end
end

endmodule