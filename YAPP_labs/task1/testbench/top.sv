
`include "uvm_macros.svh"


import uvm_pkg::*;

`include "../design/dut.sv"
//`include "/home/Reda_Alhashem/chip_ver/lab07/task1/design/dut.sv"
`include "../testbench/interface.sv"
`include "../testbench/enviroment.sv"
`include "../testbench/test.sv"

module top;
    
dut_if inte();
dut dut(.dif(inte)) ; 

initial begin
    run_test("my_test");
end
    
endmodule
