class base_test extends uvm_test;   
         `uvm_component_utils(base_test)

    router_tb tb ; 
    // yapp_env env ;
    // yapp_tx_agent agnt;
    // yapp_tx_sequencer seqr;
        // yapp_5_packets seq;
        // yapp_5_packets seq2;


    function new(string name = "base_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        //uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",yapp_5_packets::get_type());   
        // uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",short_yapp_packet::get_type());   

               tb = router_tb::type_id::create("tb",this);
   
         `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)

uvm_config_int::set( this, "*", "recording_detail",1);

    endfunction  

function void check_phase(uvm_phase phase);
check_config_usage();

endfunction


function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction
task run_phase(uvm_phase phase );
uvm_objection obj = phase.get_objection();
obj.set_drain_time(this, 200ns);


endtask

function set_type_override();
     set_type_override_by_type(yapp_packet::get_type(),short_yapp_packet::get_type() );
endfunction
endclass //base_test extends superClass





class simple_test extends base_test;
      `uvm_component_utils(simple_test)
yapp_012_seq seq012 ; 
yapp_incr_payload_seq seqinc ; 
 function new(string name = "simple_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
// set_type_override();

    endfunction 


function  void build_phase(uvm_phase phase);
      super.build_phase(phase);
      set_type_override();
       uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",yapp_012_seq::get_type());   
       uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::get_type());   
       uvm_config_wrapper::set(this, "tb.clk_rst_env.agent.sequencer.run_phase","default_sequence",clk10_rst5_seq::get_type());   

endfunction //automatic


task run_phase(uvm_phase phase );
    //run_phase(phase)

//  seq012 = yapp_012_seq::type_id::create("seq012",this);
    phase.raise_objection(this);

    phase.drop_objection(this);



endtask //run
endclass //simple_test



class test_uvc_integration extends base_test;
     `uvm_component_utils(test_uvc_integration)
function new(string name = "test_uvc_integration",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)
  
    endfunction 
   
function  void build_phase(uvm_phase phase);
      super.build_phase(phase);
    //   set_type_override();
    uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",uvc_integ_seq::get_type());   
   uvm_config_wrapper::set(this, "tb.clk_rst_env.agent.sequencer.run_phase","default_sequence",clk10_rst5_seq::get_type());   
 uvm_config_wrapper::set(this, "tb.chan?.rx_agent.sequencer.run_phase","default_sequence",channel_rx_resp_seq::get_type());   
       uvm_config_wrapper::set(this, "tb.hbus.masters[0].sequencer.run_phase","default_sequence",hbus_small_packet_seq::get_type());   

endfunction //automatic
   


endclass //test_uvc_integration extends base_test

