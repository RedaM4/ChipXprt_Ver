`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "fifo.sv"
   timeunit 1ns;
timeprecision 1ns;
 Environment #(8, 8) env; // Environment instance
 
module tb;


   // clock generator starts 
  bit clk = 0;
  always #5 clk = ~clk;
   
    fifo_int #(.DEPTH(8),.DATA_WIDTH(8)) vif(clk); // Declare the interface
   

    // Explicitly connect the interface to the DUT
    synchronous_fifo #(.DEPTH(8),.DATA_WIDTH(8))  dut_inst(vif);


    // Reset logic
    initial begin
             
        env = new(vif);
        
        env.run();


             
    end
   



   initial begin
    #300;
        $finish;

   end
endmodule

