class spi_slave_monitor extends uvm_monitor#(uvm_sequence_item);
      `uvm_component_utils(spi_slave_monitor)


   virtual interface spi_slave_intf vif;

 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "spi_slave_monitor", uvm_component parent);
    super.new(name, parent);
           `uvm_info(get_type_name(), "Inside Constructor!", UVM_LOW)
  endfunction


   //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
//     if (!yapp_vif_config::get(this,"","vif", vif))
// `uvm_error("NOVIF","vif not set")   
  endfunction: connect_phase

  task void run();
    


  endtask //void
endclass //spi_slave_driver extends uvm_driver