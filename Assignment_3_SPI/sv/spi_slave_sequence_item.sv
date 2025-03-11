class spi_slave_item extends uvm_sequence_item;
rand bit cs,mosi,miso ;

rand bit [7:0] data [];
rand bit [2:0]ins;
rand bit [4:0]addr; 
rand int length ; 

`uvm_object_utils_begin
`uvm_field_int(ins,UVM_ALL_ON)  
`uvm_field_bit(addr,UVM_ALL_ON)  
`uvm_field_array_int (data,UVM_ALL_ON)

`uvm_object_utils_end


 function new(string name = "spi_slave_item");
        super.new(name);
    endfunction //new()



function void post_randomize();

  endfunction


constraint size { length == data.size(); }
constraint length_con {length inside {[0:20]} ; }
constraint address {addr inside {[2:30]} ; }




endclass //spi_slave_item extends uvm_sequence_item
