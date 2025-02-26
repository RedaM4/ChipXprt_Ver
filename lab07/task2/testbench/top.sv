
`include "uvm_macros.svh"


import uvm_pkg::*;

`include "../design/dut.sv"

`include "../testbench/dut_if.sv"

`include "../testbench/sequence_item.sv"
`include "../testbench/my_sequence.sv"
`include "../testbench/sequencer.sv"
`include "../testbench/my_driver.sv"

`include "../testbench/enviroment.sv"
`include "../testbench/test.sv"

module top;
  logic clk ;   
dut_if inte(clk);
dut dut(.dif(inte)) ; 


initial clk=0 ; 
always#5 clk=~clk ; 

initial begin
  
     uvm_config_db #(virtual dut_if)::set(null, "*", "dut_if", inte );
    run_test("my_test");
end



initial begin
  #100 ; 
  $finish ; 
end
    
endmodule
