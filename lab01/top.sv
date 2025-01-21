
module top;
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;


mem_intf intf() ; 


// SYSTEMVERILOG: logic and bit data types
bit         clk;
// wire       read;
// wire       write;
// wire [4:0] addr;

// wire [7:0] data_out;      // data_from_mem
// wire [7:0] data_in;       // data_to_mem

// SYSTEMVERILOG:: implicit .* port connections.
mem_test test (clk,intf);

// SYSTEMVERILOG:: implicit .name port connections
mem memory ( clk, intf   );

always #5 clk = ~clk;
endmodule