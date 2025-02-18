//`timescale 1ns/1ns

interface mem_intf( input logic clk);
//     timeunit 1ns;
// timeprecision 1ns;


    logic read;
    logic write;
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

endinterface //interfacename mem_intf;


