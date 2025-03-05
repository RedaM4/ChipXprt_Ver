//`timescale 1ns/1ns

class my_driver extends uvm_driver#(sequence_item);
     `uvm_component_utils(my_driver)

 virtual dut_if vif ; 
 sequence_item item ; 
 
 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("DRIVER_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS", "Build Phase!", UVM_HIGH)
    
    if(!(uvm_config_db #(virtual dut_if)::get(this, "", "vif", vif))) begin
      `uvm_error("DRIVER_CLASS", "Failed to get VIF from config DB!")
    end
    
  endfunction: build_phase
  
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS", "Connect Phase!", UVM_HIGH)
    
  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("DRIVER_CLASS", "Inside Run Phase!", UVM_HIGH)
   // clear();
    forever begin
      item = sequence_item :: type_id::create("item");
      seq_item_port.get_next_item(item);
     @(negedge vif.clk);
      vif.a <= item.a  ; 
      vif.b <=item.b ; 
      
  `uvm_info("DRIVER_CLASS", $sformatf(" a= %d, b= %d, sum= %d, carry=%d", 
                                       vif.a, vif.b, vif.sum, vif.carry), UVM_HIGH);
 
      seq_item_port.item_done();
    end
    
    
    
    
    
  endtask: run_phase
  


endclass //mem_driver extends superClass