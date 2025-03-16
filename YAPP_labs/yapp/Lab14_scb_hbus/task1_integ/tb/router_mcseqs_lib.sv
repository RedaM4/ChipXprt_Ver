class base_seq extends uvm_sequence ;
  
  // Required macro for sequences automation
  `uvm_object_utils(base_seq)

  // Constructor
  function new(string name="base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : base_seq


class router_simple_mcseq extends base_seq;
  
    `uvm_object_utils(router_simple_mcseq)
    // `uvm_declare_P_sequencer(router_mcsequencer)
`uvm_declare_p_sequencer(router_mcsequencer)
  yapp_012_seq yapp012;
  hbus_read_max_pkt_seq  hbusmaxsize ; 
  hbus_small_packet_seq hbus_setsmall;
  hbus_set_default_regs_seq hbus_set_large ; 
  yapp_rand_seq yapp_rand ; 
   //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "router_simple_mcseq");
    super.new(name);
    `uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  endfunction: new


  virtual task body();
//start raise objection ?
    
    // `uvm_do_on(hbus_setsmall,p_sequencer.hbus_seqr);

    // repeat(6)
`uvm_do_on(yapp012, p_sequencer.yapp_seqr)

    // `uvm_do_on(hbus_set_large,p_sequencer.hbus_seqr);


//     `uvm_do_on(hbusmaxsize,p_sequencer.hbus_seqr);
// `uvm_info(get_type_name(), $sformatf("READ YAPP MAX_PKT_REG:%h", hbusmaxsize.max_pkt_reg), UVM_HIGH)    
   
//    repeat(6)
//     `uvm_do_on(yapp_rand, p_sequencer.yapp_seqr)



//drop starting phase
endtask

endclass //className extends superClass