class base_sequence extends uvm_sequence; //reset
  `uvm_object_utils(base_sequence)
  
  sequence_item base_seq;    //reset test
  //sequence_item load_seq ; 
  //sequence_item rand_data_seq ; 
  // sequence_item rand_rst_seq ; 
  // sequence_item rand_seq ; 
  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "base_seq");
    super.new(name);
    `uvm_info("BASE_SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction
  
 
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("BASE_SEQ", "Inside body task!", UVM_HIGH)
    
    base_seq = sequence_item::type_id::create("base_seq");
   
  
      start_item(base_seq);
     base_seq.rst_n = 0 ;
     base_seq.load = 0;
     base_seq.data_i = 4 ; 
    
finish_item(base_seq);
// #10;
       
  endtask: body
  
  
endclass: base_sequence

/*
 //--------------------------------------------------------
  //=================load_seq
  //--------------------------------------------------------

class load_sequence extends base_sequence;
      `uvm_object_utils(load_sequence)

sequence_item item ; 
  sequence_item load_seq ; 

 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "load_seq");
    super.new(name);
    `uvm_info("load_seq", "Inside Constructor!", UVM_HIGH)
  endfunction
  
 
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("load_seq", "Inside body task!", UVM_HIGH)
    
    load_seq = sequence_item::type_id::create("load_seq");
   
  
      start_item(load_seq);
       load_seq.rst_n = 1 ;
     load_seq.load = 1;
     load_seq.data_i = 8'hC4 ; 
    
finish_item(load_seq);

repeat(8)begin
    start_item(load_seq);
    load_seq.rst_n = 1 ;
     load_seq.load = 0; 
    load_seq.data_i = 4 ; 

    finish_item(load_seq);end

endtask

//load_Seq
endclass: load_sequence


//--------------------------------------------------------
  //=================rand_data_seq
  //--------------------------------------------------------

class rand_data_seq extends base_sequence;
      `uvm_object_utils(rand_data_seq)

sequence_item item ; 
  sequence_item rand_data_seq ; 

 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "rand_data_seq");
    super.new(name);
    `uvm_info("rand_data_seq", "Inside Constructor!", UVM_HIGH)
  endfunction
  
 
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("rand_data_seq", "Inside body task!", UVM_HIGH)
    
    rand_data_seq = sequence_item::type_id::create("rand_data_seq");
   
  
      start_item(rand_data_seq);
    
    rand_data_seq.randomize() ; 
     rand_data_seq.rst_n = 1 ;
     rand_data_seq.load = 1;
finish_item(rand_data_seq);

repeat(8)begin
    start_item(rand_data_seq);
    rand_data_seq.rst_n = 1 ;
     rand_data_seq.load = 0; 
    rand_data_seq.data_i = 4 ; 

    finish_item(rand_data_seq);end

endtask

//load_Seq
endclass: rand_data_seq



//--------------------------------------------------------
  //=================rand_rst_seq
  //--------------------------------------------------------

class rand_rst_seq extends base_sequence;//rand_rst_seq
      `uvm_object_utils(rand_rst_seq)

sequence_item item ; 
 // sequence_item rand_rst_seq ; 

 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "rand_rst_seq");
    super.new(name);
    `uvm_info("rand_rst_seq", "Inside Constructor!", UVM_HIGH)
  endfunction
  
 
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("rand_rst_seq", "Inside body task!", UVM_HIGH)
    
    item = sequence_item::type_id::create("item");
   
  
  start_item(item);
     
    item.randomize() ; 
     item.rst_n = 1 ;
     item.load = 1;       
finish_item(item);



repeat(3)begin
    start_item(rand_rst_seq);
    rand_rst_seq.rst_n = 1 ;
     rand_rst_seq.load = 0; 
     rand_rst_seq.data_i = 4 ; 

    finish_item(rand_rst_seq);
end
  
start_item(rand_rst_seq);
     rand_rst_seq.rst_n = 0 ;
     rand_rst_seq.load = 0;
     rand_rst_seq.data_i = 4 ; 
    
finish_item(rand_rst_seq);

    

 start_item(rand_rst_seq);
    
    rand_rst_seq.randomize() ; 
     rand_rst_seq.rst_n = 1 ;
     rand_rst_seq.load = 1;
finish_item(rand_rst_seq);

repeat(8)begin
    start_item(rand_rst_seq);
    rand_rst_seq.rst_n = 1 ;
     rand_rst_seq.load = 0; 
    rand_rst_seq.data_i = 4 ; 

    finish_item(rand_rst_seq);end




// #10;

endtask

//load_Seq
endclass: rand_rst_seq

//--------------------------------------------------------
  //=================rand_seq
  //--------------------------------------------------------

class rand_seq extends base_sequence;
      `uvm_object_utils(rand_seq)

sequence_item item ; 
  sequence_item rand_seq ; 

 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "rand_seq");
    super.new(name);
    `uvm_info("rand_seq", "Inside Constructor!", UVM_HIGH)
  endfunction
  
 
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("rand_seq", "Inside body task!", UVM_HIGH)
    
    rand_seq = sequence_item::type_id::create("rand_seq");
   
  
      start_item(rand_seq);
      
    rand_seq.randomize() ; 
        finish_item(rand_seq);
// #10;

endtask

//load_Seq
endclass: rand_seq

*/