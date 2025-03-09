class yapp_tx_driver extends uvm_driver#(yapp_packet);
      `uvm_component_utils(yapp_tx_driver)
yapp_packet item ; 
   
 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "yapp_tx_driver", uvm_component parent);
    super.new(name, parent);
           `uvm_info(get_type_name(), "Inside Constructor!", UVM_LOW)
  endfunction: new
  

  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(), "Inside Run Phase!", UVM_HIGH)

    forever begin
    //   item = sequence_item::type_id::create("item"); 
      seq_item_port.get_next_item(item);
         `uvm_info(get_type_name(), "Got transaction from the sequencer!", UVM_HIGH)
     send_to_dut(item) ; 
      
      seq_item_port.item_done();
    end
    
  endtask: run_phase
  
task  send_to_dut(yapp_packet packet);
      `uvm_info(get_type_name(), $sformatf("Packet is \n%s", packet.sprint()), UVM_LOW)
#10;
endtask //

  //--------------------------------------------------------
  //start_of_simulation_phase
  //--------------------------------------------------------
function void start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Running Simulation", UVM_HIGH)
endfunction

endclass //yapp_tx_driver extends superClass