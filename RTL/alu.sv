`timescale 1ns / 1ps

module ALU (
    input  logic [31:0] A, B,
    input  logic [3:0]  Control_in,
    output logic [31:0] ALU_Result,
    output logic        zero
);

    always_comb begin
        // Default values
        ALU_Result = 32'b0;
        zero       = 1'b0;

        unique case (Control_in)
            4'b0010: begin // ADD / ADDI
                ALU_Result = A + B;
            end
            4'b0110: begin // SUB
                ALU_Result = A - B;
            end
            4'b0000: begin // AND / ANDI
                ALU_Result = A & B;
            end
            4'b0001: begin // OR / ORI
                ALU_Result = A | B;
            end
            4'b0011: begin // XOR / XORI
                ALU_Result = A ^ B;
            end
            4'b0100: begin // SLL / SLLI
                ALU_Result = A << B[4:0];  // only lower 5 bits for shift amount
            end
            4'b0101: begin // SRL / SRLI
                ALU_Result = A >> B[4:0];
            end
            4'b0111: begin // SRA / SRAI
                ALU_Result = $signed(A) >>> B[4:0];
            end
            4'b1000: begin // SLT / SLTI
                ALU_Result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;
            end
            4'b1001: begin // SLTU / SLTIU
                ALU_Result = ($unsigned(A) < $unsigned(B)) ? 32'd1 : 32'd0;
            end
            default: begin
                ALU_Result = 32'd0;
            end
        endcase

        // Optional: define zero flag as "result == 0"
        zero = (ALU_Result == 32'd0);
    end

endmodule

