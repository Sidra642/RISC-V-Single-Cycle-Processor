`timescale 1ns / 1ps

module Data_Memory (
    input  logic        clk,
    input  logic        reset,
    input  logic        MemWrite,
    input  logic        MemRead,
    input  logic [31:0] read_address,
    input  logic [31:0] Write_data,
    output logic [31:0] MemData_out
);

    // 32 memory locations, each 32-bit wide
    logic [31:0] D_Memory [0:31];
    integer i;

    // Sequential block: reset + write operations
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Clear memory when reset is high
            for (i = 0; i < 32; i++) begin
                D_Memory[i] <= 32'h00000000;
            end
        end
        else if (MemWrite) begin
            // Write to memory
            D_Memory[read_address] <= Write_data;
        end
    end

    // Combinational read logic
    always_comb begin
        if (MemRead)
            MemData_out = D_Memory[read_address];
        else
            MemData_out = 32'b0;
    end

    // Initial values (pre-load data into memory at start)
    initial begin
        D_Memory[0]  = 0;
        D_Memory[1]  = 4;
        D_Memory[2]  = 2;
        D_Memory[3]  = 24;
        D_Memory[4]  = 4;
        D_Memory[5]  = 1;
        D_Memory[6]  = 44;
        D_Memory[7]  = 4;
        D_Memory[8]  = 2;
        D_Memory[9]  = 1;
        D_Memory[10] = 23;
        D_Memory[11] = 4;
        D_Memory[12] = 9;
        D_Memory[13] = 1;
        D_Memory[14] = 2;
        D_Memory[15] = 3;
        D_Memory[16] = 4;
        D_Memory[17] = 5;
        D_Memory[18] = 6;
        D_Memory[19] = 3;
        D_Memory[20] = 4;
        D_Memory[21] = 5;
        D_Memory[22] = 6;
        D_Memory[23] = 3;
        D_Memory[24] = 4;
        D_Memory[25] = 5;
        D_Memory[26] = 6;
        D_Memory[27] = 3;
        D_Memory[28] = 4;
        D_Memory[29] = 5;
        D_Memory[30] = 6;
        D_Memory[31] = 3;
    end

endmodule
