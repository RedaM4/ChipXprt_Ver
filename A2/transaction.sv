class transaction#(parameter DATA_WIDTH = 8, DEPTH=8 );
      typedef enum {
        wr_zero, // Constraint a: Printable ASCII characters
       wr_rand,
       read,
       rest,
       fe,
       wr_and_rd
    } control_knob_t;
    
    
    rand bit [DATA_WIDTH - 1:0] data_in ;
    rand bit rst_n,wr_en,rd_en ; 
     
    logic [DATA_WIDTH - 1:0] data_out ; 
    logic full,empty ; 
    //  t.data = vif.data_out;
    //             t.full = vif.full ; 
    //             t.empty = vif.empty ; 

    // int control_knob;
control_knob_t control_knob;
   
   
 function new(//bit [4:0] addr = 8'h00, 
        logic [7:0] rdata = 8'h00,
        logic rst_n =1,logic w_en =0 ,logic rd_en=0 , 
        control_knob_t knob = wr_zero);
 
 
        // this.address = addr; 
        this.data_in = rdata; 
        this.rst_n =rst_n ;
        this.wr_en = w_en ;
        this.rd_en = rd_en ; 
        this.control_knob = knob;
    endfunction

  constraint write_zero{
    if (control_knob == wr_zero) { //  Ensure correct enum reference
        data_in inside {0};        //  Ensure data is 0
        rst_n == 1;             //  Active low reset
        wr_en == 1;             //  Write enable set
        rd_en == 0;             //  Read disabled
    }
}

constraint write_rand_ {
    if (control_knob == wr_rand) { //  Ensure correct enum reference
        data_in inside {[8'h20 : 8'h7F]};
        rst_n == 1;             //  Active low reset
        wr_en == 1;             //  Write enable set
        rd_en == 0;             //  Read disabled
    }
}

constraint Read{
    if (control_knob == read) { //  Ensure correct enum reference
        data_in inside {0};        //  Ensure data is 0
        rst_n == 1;             //  Active low reset
        wr_en == 0;             //  Write enable set
        rd_en == 1;             //  Read disabled
    }
}

constraint reset{
    if (control_knob == rest) { //  Ensure correct enum reference
        data_in inside {0};        //  Ensure data is 0
        rst_n == 0;             //  Active low reset
        wr_en == 0;             //  Write enable set
        rd_en == 0;             //  Read disabled
    }
}


constraint read_signals{
    if (control_knob == fe) { //  Ensure correct enum reference
        data_in inside {0};        //  Ensure data is 0
        rst_n == 1;             //  Active low reset
        wr_en == 0;             //  Write enable set
        rd_en == 0;             //  Read disabled
    }
}//wr_and_rd

constraint writeandread{
    if (control_knob == wr_and_rd) { //  Ensure correct enum reference
        data_in inside {[8'h20 : 8'h7F]};
        rst_n == 1;             //  Active low reset
        wr_en == 1;             //  Write enable set
        rd_en == 1;             //  Read disabled
    }
}

endclass //transaction