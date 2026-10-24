`timescale 1ns / 1ps

module Instruction_Memory (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] read_address,
    output logic [31:0] instruction_out
);

    // Declare memory (128 x 32-bit)
    logic [31:0] I_Memory [0:127];
    integer k;
    // Initialize / reset memory
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (k = 0; k < 64; k++) begin
                I_Memory[k] <= 32'b0;
            end
        end 
        else begin
            // R-type instructions
            I_Memory[0]  <= 32'b0000000_00000_00000_000_00000_0000000; // no instruction
            I_Memory[4]  <= 32'b0000000_00010_00000_000_00001_0110011; // add r1, r30, r31
            I_Memory[8]  <= 32'b0000000_00100_00000_000_00010_0110011; // sub r2, r30, r31
            
            I_Memory[12] <= 32'b0000000_00010_00001_000_00011_0110011; // xor r3, r30, r31
            I_Memory[16] <= 32'b01000000000100010000001000110011; // or r4, r30, r31
            I_Memory[20] <= 32'b0000000_11111_11110_111_00101_0110011; // and r5, r30, r31
            I_Memory[24] <= 32'b0000000_11111_11110_001_00110_0110011; // sll r6, r30, r31
            I_Memory[28] <= 32'b0000000_11111_11110_101_00111_0110011; // srl r7, r30, r31
            I_Memory[32] <= 32'b0100000_11111_11110_101_01000_0110011; // sra r8, r30, r31
            I_Memory[36] <= 32'b0000000_11111_11110_010_01001_0110011; // slt r9, r30, r31
            I_Memory[40] <= 32'b0000000_11111_11110_011_01010_0110011; // sltu r10, r30, r31

            // I-type instructions
            I_Memory[44] <= 32'b000000000111_10100_000_01011_0010011; // addi r11, r20, 7
            I_Memory[48] <= 32'b000000000111_10101_100_01100_0010011; // xori r12, r20, 7
            I_Memory[52] <= 32'b000000000111_10100_110_01101_0010011; // ori  r13, r20, 7
            I_Memory[56] <= 32'b000000000111_10100_111_01110_0010011; // andi r14, r20, 7
            I_Memory[60] <= 32'b000000000111_10100_001_01111_0010011; // slli r15, r20, 7
            I_Memory[64] <= 32'b000000000111_10100_101_10000_0010011; // srli r16, r20, 7
            I_Memory[68] <= 32'b000000000111_10100_101_10001_0010011; // srai r17, r20, 7
            I_Memory[72] <= 32'b000000000111_10100_010_10010_0010011; // srti r18, r20, 7
            I_Memory[76] <= 32'b000000000111_10100_011_10011_0010011; // srtiu r19, r20, 7

           // lw x10, 8(x5)  --> word aligned
            I_Memory[80] <= 32'b000000001000_00101_010_01010_0000011; 
            // lb x11, 7(x6)  --> any address
            I_Memory[84] <= 32'b000000000111_00110_000_01011_0000011;
            // lbu x12, 9(x7) --> any address
            I_Memory[88] <= 32'b000000001001_00111_100_01100_0000011;
            // lh x13, 12(x8) --> halfword aligned
            I_Memory[92] <= 32'b000000001100_01000_001_01101_0000011;
            // lhu x14, 14(x9) --> halfword aligned
            I_Memory[96] <= 32'b000000001110_01001_101_01110_0000011;

            // ---------------- STORE INSTRUCTIONS ----------------
            // sw x1, 16(x2)  --> word aligned
            I_Memory[100] <= 32'b0000000_00001_00010_010_10000_0100011;
            // sb x3, 5(x4)   --> any address
            I_Memory[104] <= 32'b0000000_00011_00100_000_00101_0100011;
            // sh x15, 18(x12) --> halfword aligned
            I_Memory[108] <= 32'b0000000_01111_01100_001_10010_0100011;

            // ---------------- BRANCH EXAMPLE ----------------
            // beq x3, x3, 4
            I_Memory[112] <= 32'b0000000_00011_00011_000_00100_1100011;
        end
        
end
 assign instruction_out = I_Memory[read_address];
endmodule

