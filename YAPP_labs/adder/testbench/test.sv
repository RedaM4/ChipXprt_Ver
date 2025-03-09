// `include "uvm_macros.svh"
// import uvm_pkg::*;

class my_test extends uvm_test;
     `uvm_component_utils(my_test)


    enviroment env ; 
    my_sequence seq ; 
    
    function new(string name = "my_test",uvm_component parent);
            super.new(name, parent);
           `uvm_info("TEST_CLASS", "Inside Constructor!", UVM_LOW)
    env = enviroment::type_id::create("env", this);
    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      `uvm_info("TEST_CLASS", "Connect Phase!", UVM_MEDIUM)
endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect Phase!", UVM_HIGH)

  endfunction: connect_phase



task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info("TEST_CLASS", "run phase", UVM_LOW)
     
    `uvm_info("TEST_CLASS", "Hello World222", UVM_LOW)
   seq = my_sequence::type_id::create("seq");
    seq.start(env.seqr);

   #10;
    phase.drop_objection(this);


endtask //




endclass :my_test //my_test extends superClass