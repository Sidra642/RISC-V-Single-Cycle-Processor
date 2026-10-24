`timescale 1ns / 1ps
module Register_File (
    input  logic        clk,
    input  logic        reset,
    input  logic        RegWrite,       // Write enable
    input  logic [4:0]  Rs1,            // Source register 1
    input  logic [4:0]  Rs2,            // Source register 2
    input  logic [4:0]  Rd,             // Destination register
    input  logic [31:0] Write_data,     // Data to write
    output logic [31:0] read_data1,     // Output from Rs1
    output logic [31:0] read_data2      // Output from Rs2
);

    // 32 registers, 32-bit wide
    logic [31:0] Registers [0:31];

    // Synchronous reset + write operation
    always_ff @(posedge clk) begin
        if (reset) begin
            Registers <= '{default:32'd0};  // Reset all to 0
        end
        else if (RegWrite && Rd != 0) begin
            Registers[Rd] <= Write_data;   // Protect x0
        end
    end

    // Combinational read
    always_comb begin
        read_data1 = Registers[Rs1];
        read_data2 = Registers[Rs2];
    end

endmodule
