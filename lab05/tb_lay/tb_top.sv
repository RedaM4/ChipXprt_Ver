`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "dut.sv"
 Environment env; // Environment instance
 
module tb;
   timeunit 1ns;
timeprecision 1ns;

   // clock generator starts 
  bit clk = 0;
  always #5 clk = ~clk;
   
    mem_interf vif(clk); // Declare the interface
   

    // Explicitly connect the interface to the DUT
    dut dut_inst(.mif(vif));


    // Reset logic
    initial begin
        
        env = new(vif);
        env.run();
        $display("FINISH COMPLETED ");

    end
     initial begin    
        #500; // Allow time for transactions
        $finish;
    end
endmodule

