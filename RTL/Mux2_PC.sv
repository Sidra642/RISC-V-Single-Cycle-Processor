`timescale 1ns / 1ps

module Mux2 (
    input  logic        sel2,
    input  logic [31:0] A2,
    input  logic [31:0] B2,
    output logic [31:0] Mux2_out
);

    assign Mux2_out = (sel2 == 1'b0) ? A2 : B2;

endmodule
