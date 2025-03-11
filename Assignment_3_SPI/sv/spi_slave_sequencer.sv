class spi_slave_sequencer extends uvm_sequencer#(spi_slave_sequence_item);
      `uvm_component_utils(yapp_tx_sequencer)

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "spi_slave_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
  

function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction

endclass //spi_slave_sequencer extends uvm_sequencer