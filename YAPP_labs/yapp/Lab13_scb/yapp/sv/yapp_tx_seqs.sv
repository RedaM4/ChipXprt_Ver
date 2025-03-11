
//------------------------------------------------------------------------------
//
// SEQUENCE: base yapp sequence - base sequence with objections from which 
// all sequences can be derived
//
//------------------------------------------------------------------------------
class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
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

endclass : yapp_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 yapp_5_packets::get_type());
//
//------------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

//yapp_base_seq base_seq ; 

//yapp_packet yapp_1_seq,yapp_012_seq,yapp_111_seq,yapp_repeat_addr_seq ; 
  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
  endtask
  
endclass : yapp_5_packets
 //--------------------------------------------------------
  //yapp_rand_seq
  //--------------------------------------------------------
class yapp_rand_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_rand_seq)

  function new(string name="yapp_rand_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_rand_seq sequence", UVM_LOW)
    `uvm_do(req) ; 
  endtask
  
endclass : yapp_rand_seq

  //--------------------------------------------------------
  //yapp_1_seq
  //--------------------------------------------------------
class yapp_1_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_1_seq)

  function new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_1_seq sequence", UVM_LOW)
    `uvm_do_with(req, {addr ==1;}) ; 
  endtask
  
endclass : yapp_1_seq

  //--------------------------------------------------------
  //yapp_012_seq
  //--------------------------------------------------------
class yapp_012_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_012_seq)
  function new(string name="yapp_012_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_012_seq sequence", UVM_LOW)
    `uvm_do_with(req, {addr ==0;}) ; 
    `uvm_do_with(req, {addr ==1;}) ; 
    `uvm_do_with(req, {addr ==2;}) ; 
  endtask
  
endclass : yapp_012_seq


  //--------------------------------------------------------
  //yapp_111_seq
  //--------------------------------------------------------
   yapp_1_seq seq1 ; 
class yapp_111_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_111_seq)
  function new(string name="yapp_111_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_111_seq sequence", UVM_LOW)
    `uvm_do(seq1) ; 
  endtask
  
endclass : yapp_111_seq


  //--------------------------------------------------------
  //yapp_repeat_addr_seq
  //--------------------------------------------------------
    bit [1:0] prev_addr ; 
class yapp_repeat_addr_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_repeat_addr_seq)
  function new(string name="yapp_repeat_addr_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_repeat_addr_seq sequence", UVM_LOW)
    `uvm_do_with(req, {addr!=3;}) ; 
    prev_addr= req.addr ; 
    `uvm_do_with(req, {addr ==prev_addr; addr!=3;}) ; 

  endtask
  
endclass : yapp_repeat_addr_seq


  //--------------------------------------------------------
  //yapp_incr_payload_seq
  //--------------------------------------------------------
class yapp_incr_payload_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_incr_payload_seq)
  function new(string name="yapp_incr_payload_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
   // int i=0 ; 
    `uvm_info(get_type_name(), "Executing yapp_incr_payload_seq sequence", UVM_LOW)
`uvm_create(req);
if (!req.randomize()) begin
        `uvm_error(get_type_name(), "Randomization failed for req!") end

for (bit [7:0] i =0 ;i< req.length  ;i++ ) begin
  req.payload[i]=i;
end
req.set_parity() ; 
`uvm_send(req) ; 

  endtask
  
endclass
 //--------------------------------------------------------
  //uvc_integ_seq
  //--------------------------------------------------------
  // yapp_1_seq  seq1;


class uvc_integ_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(uvc_integ_seq)
  function new(string name="uvc_integ_seq");
    super.new(name);
  endfunction

  // Sequence body definition
virtual task body();
    `uvm_info(get_type_name(), "Executing uvc_integ_seq sequence", UVM_LOW)

    for (int i = 1; i <= 22; i++) begin  // Now runs 22 times instead of 21
        for (int j = 0; j < 4; j++) begin
            `uvm_create(req);

            if (!req.randomize() with { req.length ==i ; req.parity_type dist {GOOD_PARITY := 80, BAD_PARITY := 20}; }) begin
                `uvm_error(get_type_name(), "Randomization failed for req!");
            end

            req.addr = j; 
          //  req.length = i;
            req.set_parity(); 
            `uvm_send(req); 
        end
    end
endtask

endclass : uvc_integ_seq














  //--------------------------------------------------------
  //yapp_exhaustive_seq
  //--------------------------------------------------------
  // yapp_1_seq  seq1;
  yapp_012_seq seq012 ; 
  yapp_111_seq seq111;
  yapp_repeat_addr_seq  seqras ; 
  yapp_incr_payload_seq seqincr;
class yapp_exhaustive_seq extends yapp_base_seq;
  // Required macro for sequences automation
  `uvm_object_utils(yapp_exhaustive_seq)
  function new(string name="yapp_exhaustive_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
   // int i=0 ; 
    `uvm_info(get_type_name(), "Executing yapp_exhaustive_seq sequence", UVM_LOW)
`uvm_do(seq1) ; 
`uvm_do(seq012) ; 
`uvm_do(seq111) ; 
`uvm_do(seqras) ; 
`uvm_do(seqincr) ; 
  endtask

endclass : yapp_exhaustive_seq