module top;
// import the UVM library
// include the UVM macros
import uvm_pkg::*;
`include "uvm_macros.svh"

// import the YAPP package
import yapp_pkg::*;
// generate 5 random packets and use the print method

yapp_packet p1 ; 
initial begin
p1=new("p1") ; 
p1.randomize();

// p1.print(uvm_default_tree_printer) ; 
p1.print() ; 


end



// experiment with the copy, clone and compare UVM method
endmodule : top
