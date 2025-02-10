   timeunit 1ns;
timeprecision 1ns;
class Generator #(parameter DEPTH=8, DATA_WIDTH=8);
    mailbox gen2drv, gen2scb;
    transaction #(DEPTH, DATA_WIDTH) t,temp;
    int rep ; 
    function new(mailbox g2d, mailbox g2s,int num =5);
        this.gen2drv = g2d;
        this.gen2scb = g2s;
        this.rep = num ; 
    endfunction

task run(bit debug =1);
    
     t = new();
      $display("reset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);
      
      $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(rep, debug);
        // $display("\nwrite zero:");
        // t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_zero;
        // generate_transactions(rep, debug);
        $display("\nread:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::read;
        generate_transactions(6, debug);
endtask //run


task send_transaction(transaction t);
    transaction temp = new();

    // ✅ Clone all required fields
    temp.rst_n    = t.rst_n;
    temp.wr_en    = t.wr_en;
    temp.rd_en    = t.rd_en;
    temp.data_in  = t.data_in;

    // ✅ Send to mailboxes
     if (temp.wr_en) begin
        gen2scb.put(temp);
     end
     
        gen2drv.put(temp);
     
    
    
endtask


task generate_transactions(int rep, bit debug);
    repeat (rep) begin
        t.randomize();
        send_transaction(t); // Call the send task

        if (debug) begin
            $display("[GENERATOR] Transaction Sent: rst_n = %0b, wr_en = %0b, rd_en = %0b, data_in = 0x%0h", 
                     t.rst_n, t.wr_en, t.rd_en, t.data_in);
        end
    end
endtask



endclass //generator