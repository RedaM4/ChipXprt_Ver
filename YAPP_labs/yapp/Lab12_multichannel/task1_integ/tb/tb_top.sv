module tb_top;
// import the UVM library
// include the UVM macros
import uvm_pkg::*;
`include "uvm_macros.svh"

import yapp_pkg::*;
import channel_pkg::*;
import clock_and_reset_pkg::*;
import hbus_pkg::*;


`include "../tb/router_mcsequencer.sv"
`include "../tb/router_mcseqs_lib.sv"
`include "../tb/router_tb.sv"
`include "../tb/router_test_lib.sv"
//  virtual  yapp_if vif;


// hw_top dut();

// yapp_packet p1 ; 
initial begin
    yapp_vif_config::set(null, "*tb.env.agnt.*", "vif", hw_top.in0 );

channel_vif_config::set(null,"*tb.chan0*","vif",hw_top.chif0);
channel_vif_config::set(null,"*tb.chan1*","vif",hw_top.chif1);
channel_vif_config::set(null,"*tb.chan2*","vif",hw_top.chif2);

hbus_vif_config::set(null,"*","vif",hw_top.hbus);

clock_and_reset_vif_config::set(null,"*","vif",hw_top.clk_rst_if);

run_test("base_test") ; 
// run_test("set_config_test") ; 



end



// experiment with the copy, clone and compare UVM method
endmodule : tb_top
