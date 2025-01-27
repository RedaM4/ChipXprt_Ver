`include "mem_test.sv"

module top;
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

  // clock generator starts 
  bit clk = 0;
  always #5 clk = ~clk;
  // clock generator endsjj
  //hi
  mem_interf mif(clk);  
  
  mem_test test (.mif);  // memory test

  mem    memory (.mif);  // memory design 
  
  initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0);
  end

endmodule
