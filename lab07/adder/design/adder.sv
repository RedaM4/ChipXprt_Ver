
//--------------------------------------------------------
// NOTE TO A VERIFICATION ENGINEER:
//
// AS A VERIFICATION ENGINEER, ONE SHOULD NEVER PEEK INTO
// DESIGN AND TRY TO REVERSE ENGINEER WHAT'S HAPPENING.
// JUST FOCUS ON GIVEN SPEC AND BUILD YOUR TESTBENCH ACCORDINGLY.
//--------------------------------------------------------

module  adder(dut_if dif);    


 always @(posedge dif.clk) begin
    
// @(posedge dif.clk);  
            {dif.carry,dif.sum} = dif.b + dif.a ; 


  `uvm_info("DUT", $sformatf(" a= %d, b= %d, sum= %d, carry=%d", 
                                       dif.a, dif.b, dif.sum, dif.carry), UVM_HIGH);
 end
endmodule