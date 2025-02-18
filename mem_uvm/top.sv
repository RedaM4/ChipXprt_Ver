
// `timescale 1ns/1ns

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

module top;
    

//--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
mem_intf memory(.clk(clock));

mem dut(intf) ; 
    


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
  end
  
  
  //--------------------------------------------------------
  //Clock Generation
  //--------------------------------------------------------
  initial begin
    clock = 0;
    #5;
    forever begin
      clock = ~clock;
      #2;
    end
  end
  
  
  //--------------------------------------------------------
  //Maximum Simulation Time
  //--------------------------------------------------------
  initial begin
    #5000;
    $display("Sorry! Ran out of clock cycles!");
    $finish();
  end


endmodule