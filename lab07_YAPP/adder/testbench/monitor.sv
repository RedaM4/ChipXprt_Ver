//`timescale 1ns/1ns

class mointor extends uvm_monitor;
     `uvm_component_utils(mointor)

 virtual dut_if vif ; 
 sequence_item item ; 
    uvm_analysis_port #(sequence_item) monitor_port;

 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mointor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR", "Build Phase!", UVM_HIGH)
        monitor_port = new("monitor_port", this);

    if(!(uvm_config_db #(virtual dut_if)::get(this, "", "vif", vif))) begin
      `uvm_error("MONITOR", "Failed to get VIF from config DB!")
    end
    
  endfunction: build_phase
  
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR", "Connect Phase!", UVM_HIGH)
    
  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR", "Inside Run Phase!", UVM_HIGH)
   // clear();
     @(negedge vif.clk);
    forever begin
      item = sequence_item :: type_id::create("item");
     @(posedge vif.clk);
      item.a = vif.a  ; 
      item.b = vif.b  ; 
      @(negedge vif.clk);
      item.sum = vif.sum  ; 
      item.carry = vif.carry  ; 
      monitor_port.write(item);

  `uvm_info("MONITOR", $sformatf(" a= %d, b= %d, sum= %d, carry=%d", 
                                       item.a, item.b, item.sum, item.carry), UVM_HIGH);
 
    end
    
    
    
    
    
  endtask: run_phase
  


endclass //mem_driver extends superClass