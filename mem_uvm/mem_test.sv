//`timescale 1ns/1ns

class mem_test extends uvm_test;
      `uvm_component_utils(mem_test)

mem_env env ;
//mem_base_seq reset_seq ;
mem_test_seq test_seq  ;
mem_base_seq base_seq  ;



  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new

  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build Phase!", UVM_HIGH)

    env = mem_env::type_id::create("env", this);

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


    base_seq = mem_base_seq::type_id::create("base_seq");
    base_seq.start(env.agnt.seqr);
       #10;



      // test_seq = mem_test_seq::type_id::create("test_seq");
      // if (!test_seq)
      //     `uvm_fatal("TEST_CLASS", "Failed to create test_seq!");
     
     
      // test_seq.start(env.agnt.seqr);



    phase.drop_objection(this);

  endtask: run_phase
endclass //mem_test extends superClass