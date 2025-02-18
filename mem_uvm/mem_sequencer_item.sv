//`timescale 1ns/1ns
class mem_sequencer_item extends uvm_sequence_item;
    `uvm_component_utils(mem_sequencer_item)
    
  typedef enum {
        wr_zero, // Constraint a: Printable ASCII characters
       wr_rand,
       rd
       
    } control_knob_t;
  
  control_knob_t control_knob;

  //--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
    bit read;
    bit write;
    randc bit [4:0] addr;
    rand bit [7:0] data_in;
  
    logic [7:0] data_out; //output
 // bit carry_out; // output

  //--------------------------------------------------------
  //Default Constraints
  //--------------------------------------------------------

//   constraint input1_c {a inside {[10:20]};}
//   constraint input2_c {b inside {[1:10]};}
//   constraint op_code_c {op_code inside {0,1,2,3};}
  
  constraint write_zero{  
       if (control_knob == wr_zero) {
       data_in inside {0}; 
        read == 0;
        write==1 ;
            }
                   }


 constraint write_rand{  
       if (control_knob == wr_rand) {
        read == 0;
        write==1 ;
            }
                   }


constraint Read{
    if (control_knob == rd) { //  Ensure correct enum reference
        write == 0;             //  Write enable set
        read == 1;             //  Read disabled
    }
}

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_sequencer_item");
    super.new(name);

  endfunction: new
endclass //mem_sequencer_item extends superClass