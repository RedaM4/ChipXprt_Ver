typedef enum bit { BAD_PARITY, GOOD_PARITY } control;

class yapp_packet extends uvm_sequence_item;
      //  `uvm_object_utils(yapp_packet)
rand bit [1:0] addr ; 
rand bit [5:0]length ;
rand bit [7:0] payload [] ; 
rand int packet_delay ; 
bit [7:0]parity;
 
rand control parity_type;

//  control = parity_type ; 
`uvm_object_utils_begin(yapp_packet)
    `uvm_field_int (addr,UVM_ALL_ON)
    `uvm_field_int (length,UVM_ALL_ON)
    `uvm_field_int (parity,UVM_ALL_ON)
    `uvm_field_array_int (payload,UVM_ALL_ON)
     `uvm_field_int (packet_delay,UVM_ALL_ON)
    // `uvm_field_int (,UVM_ALL_ON)

`uvm_object_utils_end


    function new(string name = "yapp_packet");
        super.new(name);
    endfunction //new()

    
function bit [7:0] calc_parity();
  bit [7:0] parity_temp = 0;
  
  for (int i = 0; i < length; i++) begin
    parity_temp ^= payload[i];
  end

  return parity_temp;
endfunction



function void set_parity();
    parity = calc_parity();
    if (parity_type == BAD_PARITY) begin
        parity= ~parity ; 
    end
    
endfunction

function void post_randomize();
    set_parity() ; 
    
endfunction

constraint lecon { length == payload.size(); }
constraint pay_lencon { length > 0; length < 64; }
constraint address { addr <4; }
constraint parcon { parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1}; }
constraint pa_delcon { packet_delay inside {[1:20]}; }

endclass //yapp_packet extends superClass




class short_yapp_packet extends yapp_packet;

    function new(string name = "short_yapp_packet");
        super.new(name);
    endfunction //new()

   //  `uvm_object_utils(yapp_packet)
rand bit [1:0] addr ; 
rand bit [5:0]length ;
rand bit [7:0] payload [] ; 
rand int packet_delay ; 
bit [7:0]parity;
 
rand control parity_type;

//  control = parity_type ; 
`uvm_object_utils_begin(yapp_packet)
    `uvm_field_int (addr,UVM_ALL_ON)
    `uvm_field_int (length,UVM_ALL_ON)
    `uvm_field_int (parity,UVM_ALL_ON)
    `uvm_field_array_int (payload,UVM_ALL_ON)
     `uvm_field_int (packet_delay,UVM_ALL_ON)
    // `uvm_field_int (,UVM_ALL_ON)

`uvm_object_utils_end


function bit [7:0] calc_parity();
  bit [7:0] parity_temp = 0;
  
  for (int i = 0; i < length; i++) begin
    parity_temp ^= payload[i];
  end

  return parity_temp;
endfunction



function void set_parity();
    parity = calc_parity();
    if (parity_type == BAD_PARITY) begin
        parity= ~parity ; 
    end
    
endfunction

function void post_randomize();
    set_parity() ; 
    
endfunction

constraint lecon { length == payload.size(); }
constraint pay_lencon { length > 0; length < 15; }
constraint address { addr !=2 ; }
// constraint parcon { parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1}; }
// constraint pa_delcon { packet_delay inside {[1:20]}; }



endclass //short_yapp_packet extends superClass