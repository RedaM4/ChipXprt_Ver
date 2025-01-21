/*
              -----------------
              |               |
    addr ---->|               |
              |               |------> data_out
              | Memory Model  |
 data_in ---->|               |
              |               | 
              -----------------
                   ^     ^
                   |     |
                 write  read     
*/

module mem (
        input        clk,
mem_intf intf
	   );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31] ;
  
  always @(posedge clk)
    if (intf.write && !intf.read)
// SYSTEMVERILOG: time literals
      #1 memory[intf.addr] <= intf.data_in;

// SYSTEMVERILOG: always_ff and iff event control
  always_ff @(posedge clk iff ((intf.read == '1)&&(intf.write == '0)) )
       intf.data_out <= memory[intf.addr];

endmodule
