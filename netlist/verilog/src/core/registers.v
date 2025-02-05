`include "../config.v"
module registers(
    input wire clk,
    input wire rst,
    input wire [4:0] rs1_addr,
    input wire [4:0] rs2_addr,
    input wire [4:0] rd_addr,
    input wire [`MAX_BIT_POS:0] rd_data,
    input wire rd_en,
    output wire [`MAX_BIT_POS:0] rs1_out,
    output wire [`MAX_BIT_POS:0] rs2_out
);
    reg [`MAX_BIT_POS:0] reg_file[`MAX_BIT_POS:0];
    integer i;
    wire [`MAX_BIT_POS:0] x1_out;
    wire [`MAX_BIT_POS:0] x2_out;

    assign rs1_out = (rs1_addr == 5'd0) ? `XLEN'd0 : reg_file[rs1_addr];
    assign rs2_out = (rs2_addr == 5'd0) ? `XLEN'd0 : reg_file[rs2_addr];

    assign x1_out = reg_file[1];
    assign x2_out = reg_file[2];

    always @(posedge clk) begin
        if (!rst) begin
            for (i = 0; i < `XLEN; i = i + 1) begin
                reg_file[i] <= `XLEN'h00000000;
            end
        end
        else begin 
            if (rd_en & (rd_addr != 5'd0)) begin
                reg_file[rd_addr] <= rd_data;
            end
        end
    end
endmodule