
// `timescale 1ns/1ns

`include "uvm_macros.svh"


import uvm_pkg::*;


//--------------------------------------------------------
//Include Files
//--------------------------------------------------------
`include "../testbench/piso_intf.sv"            
`include "../design/piso.sv"             
`include "../testbench/sequence_item.sv"  
`include "../testbench/sequence.sv"        
`include "../testbench/sequencer.sv"       
`include "../testbench/driver.sv"          
`include "../testbench/monitor.sv"         
`include "../testbench/scoreboard.sv"      
`include "../testbench/agent.sv"           
`include "../testbench/enviroment.sv"            
`include "../testbench/test.sv"           
//    timeunit 1ns;
// timeprecision 1ns;
module top;
    
logic clock;
//--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
piso_intf intf(clock);

//piso_shift_reg dut(intf) ; 

  piso_shift_reg dut (
    .clk      (intf.clk),
    .rst_n    (intf.rst_n),
    .load     (intf.load),
    .data_i   (intf.data_i),
    .serial_o (intf.serial_o)
  );




  //--------------------------------------------------------
  //Interface Setting
  //--------------------------------------------------------
    initial begin
    uvm_config_db #(virtual piso_intf)::set(null, "*", "intf", intf );
  end



//--------------------------------------------------------
  //Start The Test
  //--------------------------------------------------------
  initial begin
    run_test("test");
   // uvm_report_server::get_server().summarize();
  end
  
  
  //--------------------------------------------------------
  //Clock Generation
  //--------------------------------------------------------
  initial begin
    clock = 0;
    #5;
    forever begin
      clock = ~clock;
      #5;
    end
  end



endmodule


