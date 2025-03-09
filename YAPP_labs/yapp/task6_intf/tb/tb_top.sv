module tb_top;
// import the UVM library
// include the UVM macros
import uvm_pkg::*;
`include "uvm_macros.svh"

import yapp_pkg::*;
`include "../tb/router_tb.sv"
`include "../tb/router_test_lib.sv"

//  virtual  yapp_if vif;


// hw_top dut();

// yapp_packet p1 ; 
initial begin
    yapp_vif_config::set(null, "*tb.env.agnt.*", "vif", hw_top.in0 );

run_test("base_test") ; 
// run_test("set_config_test") ; 



end



// experiment with the copy, clone and compare UVM method
endmodule : tb_top
