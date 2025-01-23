
`include "timer.sv"
`timescale 1ns/1ps

module tb;
    // counter co = new(19,100,2);
    // down_counter dc = new(5,2,10);
    // up_counter uc = new(70,4,2);
    //up_counter uc2 = new(70,4,2);
    timer ti = new() ; 


// initial begin   //before timer
//     $display("------------new: %d", co.getcount());
//    // co.load(420);
//     $display("------------load: %d\n", co.getcount());
//     $display("------------load: %d\n", dc.getcount());

//     dc.next();    
//     dc.next();
//     dc.next(); 
//     $display("borrow= %b",dc.borrow);

//     dc.next(); 
//     $display("borrow= %b",dc.borrow);

//     $display("------------load: %d\n", uc.getcount());
//     uc.next() ; 
//     uc.next();
//     $display("carry= %b",uc.carry);
//     uc.next();
//    // dc.next(); 
//     $display("carry= %b",uc.carry);

//     $display("up_counter count: %d",uc.getcount());
//     //$display("uc2 count: %d",uc2.getcount());

// end

initial begin  //timer
    
ti.showval() ; 
ti.load(23,59,58) ; 
ti.showval() ; 
for (int i =0 ;i<250 ;i++ ) begin
   
ti.next() ; 
ti.showval() ; 
end
        
end


endmodule
