timeunit 1ns;
timeprecision 1ns;

class Scoreboard#(parameter DEPTH=8, DATA_WIDTH=8);
    mailbox mon2scb,fifo;
    int errors = 0,count;
    virtual fifo_int vif;   
    event done;
    //int fe ; 
   // bit expected.full,expected.empty ; 
   // int expected ; 
   transaction expected, actual,temp;

    function new(mailbox m2sr,virtual fifo_int vi,int co =4);
     //   this.gen2scb = g2s;
        this.mon2scb = m2sr;
        this.vif = vi;
        fifo = new();
       actual=new() ; 
       expected = new() ; 
       this.count = co  ; 
    endfunction



task run() ; 

    forever begin

     
     
        wait (mon2scb.num() > 0 ) ;         
     // $display("f=%b e=%b",expected.full,expected.empty);
      //$display("gen2scb: %d",gen2scb.num() );
        $display("mon2scb.num(): %d ",mon2scb.num());
        //$display("fifo %d",fifo.num());
         
         
            mon2scb.get(actual);
        $display(" \n------- Actual   -> data_out  = 0x%0h,wr=%b, read=%b  actual.full= %b, actual.empty= %b", actual.data_out,actual.wr_en,actual.rd_en, actual.full, actual.empty);
         if (actual.wr_en==1) begin
            fifo.put(actual.data_in) ; 
            $display("fifo added data");
         end 
         
          if (actual.rd_en==1) begin
            if (fifo.num() ==0) begin
                expected.data_out=0;
            end else
            fifo.get(expected.data_out) ;
        $display("fifo read data");
         end
        
        if (actual.rst_n==0) begin
            // clear_mailbox() ; 
           // temp = new() ; 
             while (fifo.try_get(temp));  // ✅ Keep removing until mailbox is expected.empty
             $display("\n[MAILBOX] 🗑️🗑️  Mailbox cleared.");
        end




         
            

          //fifo.get(temp);
       if (fifo.num() == 0) begin //expected.empty
                expected.full = 0;
                expected.empty = 1;
            end else if (fifo.num() == DEPTH) begin  //expected.full
                expected.full = 1;
                expected.empty = 0;
            end else begin  
                expected.full = 0;
                expected.empty = 0;
            end

          
           // $display("hi2");
          

            
             
if (actual.rd_en && actual.rst_n) begin
    
if (expected.data_out == actual.data_out && expected.full == actual.full && expected.empty == actual.empty) begin
                $display("[SCOREBOARD] ✅ PASS -> Data Matched:" );
                $display("  Expected -> data_out = 0x%0h, expected.full= %b, expected.empty= %b", expected.data_out, expected.full,expected.empty);
                $display("  Actual   -> data_out  = 0x%0h,  actual.full= %b, actual.empty= %b", actual.data_out, actual.full, actual.empty);              
            end else begin
                $display("[SCOREBOARD] ❌ ERROR -> Mismatch!");
                $display("  Expected -> data_out = 0x%0h, expected.full= %b, expected.empty= %b", expected.data_out, expected.full,expected.empty);
                $display("  Actual   -> data_out  = 0x%0h,  actual.full= %b, actual.empty= %b", actual.data_out, actual.full, actual.empty);
                errors++;
            end

end


if (!actual.rst_n) begin
     
if (expected.empty == actual.empty) begin
                $display("[SCOREBOARD] ✅ PASS -> Reset WORKS:" );
                $display("  Expected -> expected.full= %b, expected.empty= %b",  expected.full,expected.empty);
                $display("  Actual   ->   actual.full= %b, actual.empty= %b",  actual.full, actual.empty);              
            end else begin
                $display("[SCOREBOARD] ❌ ERROR -> Reset doesnt work");
                $display("  Expected -> expected.full= %b, expected.empty= %b", expected.full,expected.empty);
                $display("  Actual   ->  actual.full= %b, actual.empty= %b",  actual.full, actual.empty);
                errors++;
            end


end
            // ✅ Enhanced Verification for All Signals
            

            
            $display("Queue Status: fifo = %0d, mon2scb = %0d", fifo.num(), mon2scb.num());

                    showscb();
           count-- ; 
            
        

            
               // #10; // ✅ Ensures last transaction is expected.fully processed
       
      
      end

    
    endtask

task  showscb();
     if(count ==0)begin
        if (errors == 0) begin
            $display("[FINISH] 🟢🟢🟢 TEST PASSED! No Errors.");
        end else begin
            $display("[FINISH] ❌❌❌ TEST FAILED! Errors: %0d", errors);
        end
                $finish ;
        end
endtask //


    task clear_mailbox();
    
    while (fifo.try_get(temp));  // ✅ Keep removing until mailbox is expected.empty

    $display("\n[MAILBOX] 🗑️🗑️  Mailbox cleared.");
endtask

endclass