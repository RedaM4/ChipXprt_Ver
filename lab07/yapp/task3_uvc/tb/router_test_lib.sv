class base_test extends uvm_test;   
         `uvm_component_utils(base_test)

    router_tb tb ; 
    // yapp_env env ;
    // yapp_tx_agent agnt;
    // yapp_tx_sequencer seqr;
        yapp_5_packets seq;
        yapp_5_packets seq2;


    function new(string name = "base_test",uvm_component parent);
            super.new(name, parent);
`uvm_info(get_type_name(), "Inside Constructor!", UVM_HIGH)

    endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
        uvm_config_wrapper::set(this, "tb.env.agnt.seqr.run_phase","default_sequence",yapp_5_packets::get_type());   
               tb = router_tb::type_id::create("tb",this);
            //    env = yapp_env::type_id::create("env",this);
            //    agnt = yapp_tx_agent::type_id::create("agnt",this);
            //    seqr = yapp_tx_sequencer::type_id::create("seqr",this);
            
          
         `uvm_info(get_type_name(), "Inside Build phase", UVM_HIGH)
            // tb = new("tb",this);
    endfunction  //"../sv/yapp_pkg.sv", 6  "../sv/yapp_pkg.sv", 6


//  task run_phase (uvm_phase phase);
//     super.run_phase(phase);
//     `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)
//         seq = yapp_5_packets::type_id::create("seq",this);
//         phase.raise_objection(this) ; 
//         seq.start(tb.env.agnt.seqr);
//         // seq2 = yapp_5_packets::type_id::create("seq2",this);
//         // seq2.start(tb.env.agnt.seqr);

//         phase.drop_objection(this) ; 

//     endtask


function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction


endclass //base_test extends superClass

