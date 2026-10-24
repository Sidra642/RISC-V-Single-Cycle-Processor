`timescale 1ns / 1ps

module top(
    input logic clk, 
    input logic reset
);

    // Internal wires
    logic [31:0] PC_top, instruction_top, Rd1_top, Rd2_top;
    logic [31:0] ImmExt_top, mux1_top, address_top, WriteBack_top;
    logic [31:0] adder_wire, branch_target, DataMem_out, PC_next;
    logic RegWrite_top, ALUSrc_top, zero_top, MemWrite_top, MemRead_top, MemtoReg_top, Branch_top;
    logic [1:0] ALUOp_top;
    logic [3:0] control_top;
    logic and_out;  // from branch AND gate

    // Program Counter
    program_counter PC(
        .PC_in(PC_next), 
        .reset(reset), 
        .clk(clk), 
        .PC_out(PC_top)
    );

    // PC + 4
    PC_plus4 PC_Adder(
        .fromPC(PC_top), 
        .NextoPC(adder_wire)
    );

    // Instruction Memory
    Instruction_Memory Inst_Memory(
        .clk(clk), 
        .reset(reset), 
        .read_address(PC_top), 
        .instruction_out(instruction_top)
    );

    // Register File
    Register_File Reg_File(
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite_top),
        .Rs1(instruction_top[19:15]), 
        .Rs2(instruction_top[24:20]), 
        .Rd(instruction_top[11:7]), 
        .Write_data(WriteBack_top), 
        .read_data1(Rd1_top), 
        .read_data2(Rd2_top)
    );

    // Immediate Generator
    ImmGen ImmGen_mod(
        .opcode(instruction_top[6:0]), 
        .instruction(instruction_top), 
        .ImmExt(ImmExt_top)
    );

    // Control Unit (extended for Load/Store/Branch)
    Control_unit Control_unit_mod(
        .reset(reset), 
        .opcode(instruction_top[6:0]), 
        .RegWrite(RegWrite_top), 
        .ALUOp(ALUOp_top), 
        .ALUSrc(ALUSrc_top),
        .MemWrite(MemWrite_top),
        .MemRead(MemRead_top),
        .MemtoReg(MemtoReg_top),
        .Branch(Branch_top)
    );

    // ALU Control
    ALU_Control ALU_Control_mod(
        .fun7(instruction_top[30]), 
        .fun3(instruction_top[14:12]), 
        .ALUOp(ALUOp_top), 
        .Control_out(control_top)
    );

    // ALU
    ALU ALU_mod(
        .A(Rd1_top),
        .B(mux1_top),
        .Control_in(control_top),
        .ALU_Result(address_top),
        .zero(zero_top)
    );

    // ALU input MUX (for reg vs immediate)
    Mux1 ALU_mux(
        .sel1(ALUSrc_top), 
        .A1(Rd2_top), 
        .B1(ImmExt_top), 
        .Mux1_out(mux1_top)
    );

    // Data Memory
    Data_Memory DM(
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite_top),
        .MemRead(MemRead_top),
        .read_address(address_top),
        .Write_data(Rd2_top),
        .MemData_out(DataMem_out)
    );

    // Write-back MUX (select between ALU result & Memory data)
    Mux3 WriteBack_mux(
        .sel3(MemtoReg_top),
        .A3(address_top),
        .B3(DataMem_out),
        .Mux3_out(WriteBack_top)
    );

    // Branch target adder (PC + ImmExt)
    assign branch_target = PC_top + ImmExt_top;

    // Branch AND gate
    AND_logic and_gate(
        .branch(Branch_top),
        .zero(zero_top),
        .and_out(and_out)
    );

    // Final PC MUX (PC+4 or Branch Target)
    Mux2 PC_mux(
        .sel2(and_out),
        .A2(adder_wire),       // Normal PC+4
        .B2(branch_target),    // Branch target
        .Mux2_out(PC_next)
    );

endmodule
