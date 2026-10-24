`timescale 1ns / 1ps

// ALU Control in SystemVerilog
module ALU_Control (
    input  logic       fun7,        // funct7[5] bit (for SUB/SRA)
    input  logic [2:0] fun3,        // funct3 field
    input  logic [1:0] ALUOp,       // from Control Unit
    output logic [3:0] Control_out  // to ALU
);

    always_comb begin
        Control_out = 4'b0000; // default

        case ({ALUOp, fun7, fun3})
            // =======================
            // R-type instructions
            // =======================
            6'b10_0_000: Control_out = 4'b0010; // ADD
            6'b10_1_000: Control_out = 4'b0110; // SUB
            6'b10_0_100: Control_out = 4'b0011; // XOR
            6'b10_0_110: Control_out = 4'b0001; // OR
            6'b10_0_111: Control_out = 4'b0000; // AND
            6'b10_0_001: Control_out = 4'b0100; // SLL
            6'b10_0_101: Control_out = 4'b0101; // SRL
            6'b10_1_101: Control_out = 4'b0111; // SRA
            6'b10_0_010: Control_out = 4'b1000; // SLT
            6'b10_0_011: Control_out = 4'b1001; // SLTU

            // =======================
            // I-type instructions
            // =======================
            6'b11_0_000: Control_out = 4'b0010; // ADDI
            6'b11_0_100: Control_out = 4'b0011; // XORI
            6'b11_0_110: Control_out = 4'b0001; // ORI
            6'b11_0_111: Control_out = 4'b0000; // ANDI
            6'b11_0_001: Control_out = 4'b0100; // SLLI
            6'b11_0_101: Control_out = 4'b0101; // SRLI
            6'b11_1_101: Control_out = 4'b0111; // SRAI
            6'b11_0_010: Control_out = 4'b1000; // SLTI
            6'b11_0_011: Control_out = 4'b1001; // SLTIU

            default: Control_out = 4'b0000;
        endcase
    end

endmodule
