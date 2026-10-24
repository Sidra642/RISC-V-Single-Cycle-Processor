`timescale 1ns / 1ps

module program_counter (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] PC_in,
    output logic [31:0] PC_out
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            PC_out <= 32'b0;
        else
            PC_out <= PC_in;
    end

endmodule
