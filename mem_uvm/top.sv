
`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

//--------------------------------------------------------
//Include Files
//--------------------------------------------------------
`include "mem_intf.sv"            
`include "mem_sequencer_item.sv"  
`include "mem_sequence.sv"        
`include "mem_sequencer.sv"       
`include "mem_driver.sv"          
`include "mem_monitor.sv"         
`include "mem_scoreboard.sv"      
`include "mem_agent.sv"           
`include "mem_env.sv"            
`include "memory.sv"             
`include "mem_test.sv"           
//    timeunit 1ns;
// timeprecision 1ns;
module top;
    
logic clock;
//--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
mem_intf intf(clock);

// mem dut(intf) ; 
    

    mem dut (
        .clk      (intf.clk),
        .read     (intf.read),
        .write    (intf.write),
        .addr     (intf.addr),
        .data_in  (intf.data_in),
        .data_out (intf.data_out)
    );


  //--------------------------------------------------------
  //Interface Setting
  //--------------------------------------------------------
    initial begin
    uvm_config_db #(virtual mem_intf)::set(null, "*", "vif", intf );
  end


  //--------------------------------------------------------
  //Start The Test
  //--------------------------------------------------------
  initial begin
    run_test("mem_test");
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
  //   bit clock = 0;
  // always #5 clock = ~clock;
  
  //--------------------------------------------------------
  //Maximum Simulation Time
  //--------------------------------------------------------
  // initial begin
  //   #25000;
  //   $display("Sorry! Ran out of clock cycles!");
  //   $finish();
  // end


endmodule