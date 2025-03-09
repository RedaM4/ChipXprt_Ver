module top;
// import the UVM library
// include the UVM macros
import uvm_pkg::*;
`include "uvm_macros.svh"

import yapp_pkg::*;
`include "../tb/router_tb.sv"
`include "../tb/router_test_lib.sv"


yapp_packet p1 ; 
initial begin
// p1=new("p1") ; 
// p1.randomize();

// p1.print(uvm_default_tree_printer) ; 
// // p1.print() ; 

run_test("base_test") ; 
// run_test("set_config_test") ; 



end



// experiment with the copy, clone and compare UVM method
endmodule : top
