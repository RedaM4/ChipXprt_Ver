class yapp_tx_sequencer extends uvm_sequencer#(yapp_packet);
   `uvm_component_utils(yapp_tx_sequencer)

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "yapp_tx_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
  

function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction


endclass //yapp_tx_sequencer extends superClass