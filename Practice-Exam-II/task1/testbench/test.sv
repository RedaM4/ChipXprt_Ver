//`timescale 1ns/1ns

class test extends uvm_test;
      `uvm_component_utils(test)

enviroment env ;
  base_sequence base_seq;    //reset test
  //load_sequence load_sequence ; 
  // rand_data_seq rand_data_seq ; 
  // rand_rst_seq rand_rst_seq ; 
  // rand_seq rand_seq ; 



  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new

  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build Phase!", UVM_HIGH)

    env = enviroment::type_id::create("env", this);

  endfunction: build_phase

  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect Phase!", UVM_HIGH)

  endfunction: connect_phase


  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run Phase!", UVM_HIGH)

    phase.raise_objection(this);

    base_seq = base_sequence::type_id::create("base_seq");
    if (!base_seq)
          `uvm_fatal("TEST_CLASS", "Failed to create test_seq!");
    base_seq.start(env.agnt.seqr);
    `uvm_info("TEST_CLASS", "✅base test finished", UVM_HIGH)


    //   load_sequence = load_seq::type_id::create("load_sequence");  
    // if (!load_sequence)
    //       `uvm_fatal("TEST_CLASS", "Failed to create test_seq!");
    //   load_sequence.start(env.agnt.seqr);
    //   `uvm_info("TEST_CLASS", "✅ load_seq finished", UVM_HIGH)








    phase.drop_objection(this);

  endtask: run_phase
endclass //mem_test extends superClass