// `include "uvm_macros.svh"
// import uvm_pkg::*;

class enviroment extends uvm_env;
     `uvm_component_utils(enviroment)

    
    
    function new(string name = "enviroment",uvm_component parent);
            super.new(name, parent);
           `uvm_info("ENV CLASS", "Inside Constructor!", UVM_LOW)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      `uvm_info("ENV CLASS", "Connect Phase!", UVM_LOW)
endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV CLASS", "Connect Phase!", UVM_LOW)

  endfunction: connect_phase



task run_phase(uvm_phase phase);
    super.run_phase(phase);
  

endtask //




endclass :enviroment //enviroment extends superClass