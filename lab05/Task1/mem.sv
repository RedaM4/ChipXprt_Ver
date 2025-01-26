
`include "mem_interface.sv"
module mem (mem_interf.mem mif);
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31] ;
  
  always @(posedge mif.clk)
    if (mif.write && !mif.read)
// SYSTEMVERILOG: time literals
      #1 memory[mif.addr] <= mif.data_in;

// SYSTEMVERILOG: always_ff and iff event control
  always_ff @(posedge mif.clk iff ((mif.read == '1)&&(mif.write == '0)) )
    mif.data_out <= memory[mif.addr];

endmodule
