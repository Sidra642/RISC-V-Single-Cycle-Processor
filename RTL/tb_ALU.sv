`timescale 1ns / 1ps

module tb_ALU();

  // Testbench signals
  logic [31:0] A, B;
  logic [3:0]  Control_in;
  logic [31:0] ALU_Result;
  logic        zero;

  // Instantiate the ALU
  ALU uut (
    .A(A),
    .B(B),
    .Control_in(Control_in),
    .ALU_Result(ALU_Result),
    .zero(zero)
  );

  // Stimulus
  initial begin
    // Test ADD
    A = 32'd10; B = 32'd5; Control_in = 4'b0010;
    #10;

    // Test SUB
    A = 32'd10; B = 32'd5; Control_in = 4'b0110;
    #10;

    // Test AND
    A = 32'b1010; B = 32'b1100; Control_in = 4'b0000;
    #10;

    // Test OR
    A = 32'b1010; B = 32'b1100; Control_in = 4'b0001;
    #10;

    // Test XOR
    A = 32'b1010; B = 32'b1100; Control_in = 4'b0011;
    #10;

    // Test SLL
    A = 32'b0001; B = 32'd2; Control_in = 4'b0100;
    #10;

    // Test SRL
    A = 32'b0100; B = 32'd1; Control_in = 4'b0101;
    #10;

    // Test SRA
    A = -32'd8; B = 32'd1; Control_in = 4'b0111;
    #10;

    // Test SLT
    A = 32'd5; B = 32'd10; Control_in = 4'b1000;
    #10;

    // Test SLTU
    A = 32'd5; B = 32'd10; Control_in = 4'b1001;
    #10;

    // Test result zero
    A = 32'd0; B = 32'd0; Control_in = 4'b0010; // ADD 0+0=0
    #10;

    // End simulation
    #20 $finish;
  end

endmodule
