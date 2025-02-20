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

//--------------------------------------------------------
// NOTE TO A VERIFICATION ENGINEER:
//
// AS A VERIFICATION ENGINEER, ONE SHOULD NEVER PEEK INTO
// DESIGN AND TRY TO REVERSE ENGINEER WHAT'S HAPPENING.
// JUST FOCUS ON GIVEN SPEC AND BUILD YOUR TESTBENCH ACCORDINGLY.
//--------------------------------------------------------








// `timescale 1ns/1ns
// `timescale 1ns/1ns

module mem (
        input        clk,
	input        read,
	input        write, 
	input  logic [4:0] addr  ,
	input  logic [7:0] data_in  ,
        output logic [7:0] data_out


	   );


     
// SYSTEMVERILOG: timeunit and timeprecision specification
// timeunit 1ns;
// timeprecision 1ns;

// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31] ;
  
  always @(posedge clk)
    if (write && !read)
// SYSTEMVERILOG: time literals
      #1 memory[addr] <= data_in;

// SYSTEMVERILOG: always_ff and iff event control
  always_ff @(posedge clk iff ((read == '1)&&(write == '0)) )
       data_out <= memory[addr];

endmodule
