class yapp_tx_monitor extends uvm_monitor#(yapp_packet);
  `uvm_component_utils(yapp_tx_monitor)

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "yapp_tx_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  
   task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Inside Run Phase!", UVM_LOW)

    endtask

  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction
endclass //yapp_tx_monitor extends superClass