`timescale 1ns / 1ps

module Mux3 (
    input  logic       sel3,
    input  logic [31:0] A3, 
    input  logic [31:0] B3,
    output logic [31:0] Mux3_out
);

    assign Mux3_out = (sel3 == 1'b0) ? A3 : B3;

endmodule
