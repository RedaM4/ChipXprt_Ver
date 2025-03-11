class spi_slave_env extends uvm_env;

  `uvm_component_utils(spi_slave_env)
spi_slave_agent spis_agnt ; 

function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

void function build_phase(uvm_phase phase);
    super.build_phase(phase);
    spis_agnt = spi_slave_agent::type_id::create("spis_agnt", this);

endfunction


function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction

endclass //spi_slave_env extends uvm_env