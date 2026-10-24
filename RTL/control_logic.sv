`timescale 1ns / 1ps

module Control_unit (
    input  logic       reset,
    input  logic [6:0] opcode,       // instruction[6:0]
    output logic       RegWrite,
    output logic [1:0] ALUOp,
    output logic       ALUSrc,
    output logic       MemRead,
    output logic       MemWrite,
    output logic       MemToReg,
    output logic       Branch,
    output logic MemtoReg

);

    always_comb begin
        if (reset) begin
            RegWrite = 0;
            ALUOp    = 2'b00;
            ALUSrc   = 0;
            MemRead  = 0;
            MemWrite = 0;
            MemToReg = 0;
            Branch =0;
        end
        else begin
            case (opcode)
                7'b0110011: begin // R-type
                    RegWrite = 1;
                    ALUOp    = 2'b10;
                    ALUSrc   = 0;
                    MemRead  = 0;
                    MemWrite = 0;
                    Branch =0;
                    MemToReg = 0;
                end
                7'b0010011: begin // I-type (ADDI, ANDI, etc.)
                    RegWrite = 1;
                    ALUOp    = 2'b10;
                    ALUSrc   = 1;
                    MemRead  = 0;
                    MemWrite = 0;
                    MemToReg = 0;
                    Branch =0;
                end
                7'b0000011: begin // I-type Load (LW, LH, LB, etc.)
                    RegWrite = 1;
                    ALUOp    = 2'b00;  // Just ADD for address
                    ALUSrc   = 1;
                    MemRead  = 1;
                    MemWrite = 0;
                    MemToReg = 1;      // Write back memory data
                    Branch =0;
                end
                7'b0100011: begin // S-type Store (SW, SH, SB)
                    RegWrite = 0;
                    ALUOp    = 2'b00;  // Just ADD for address
                    ALUSrc   = 1;
                    MemRead  = 0;
                    MemWrite = 1;
                    MemToReg = 0;      // Don't care
                    Branch =0;               
                end
                7'b1100011: begin // B-type (branches)
                RegWrite = 0;
                ALUOp    = 2'b01; // ALU compares for branch
                ALUSrc   = 0;
                Branch   = 1;
            end
                default: begin
                    RegWrite = 0;
                    ALUOp    = 2'b00;
                    ALUSrc   = 0;
                    MemRead  = 0;
                    MemWrite = 0;
                    MemToReg = 0;
                end
            endcase
        end
    end

endmodule
