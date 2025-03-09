class sequence_item extends uvm_sequence_item;
       `uvm_object_utils(sequence_item)

     rand bit reset, cmd;
     rand bit [7:0] addr, data ; 


    function new(string name = "sequence_item");
    super.new(name);
    // seq_coverage = new();
  endfunction: new



    constraint c1 { addr>=2 ; addr<=32; }
    constraint c2 {data>=200 ; data <=255 ; }
endclass //sequence_item extends superClass