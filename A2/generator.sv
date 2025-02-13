   timeunit 1ns;
timeprecision 1ns;
class Generator #(parameter DEPTH=8, DATA_WIDTH=8);
    mailbox gen2drv;
    transaction #(DEPTH, DATA_WIDTH) t;
    
    function new(mailbox g2d);
        this.gen2drv = g2d;
       // this.gen2scb = g2s;
       
    endfunction

task run(bit debug =1);
     scen1() ; 
    // $display("🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 ");
  //  scen2() ; 
    // $display("🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 ");
      scen3() ; 
    //  $display("🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 ");
    //  scen4() ; 
    //  $display("🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 🎯 ");
    //  scen5() ; 
endtask //run


task send_transaction(transaction t);
    transaction temp = new();

    // ✅ Clone all required fields
    temp.rst_n    = t.rst_n;
    temp.wr_en    = t.wr_en;
    temp.rd_en    = t.rd_en;
    temp.data_in  = t.data_in;

    // ✅ Send to mailboxes
    //  if (temp.wr_en ==1 ) begin
    //     gen2scb.put(temp);
    //  end
     
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


task scen1(bit debug =1) ;
    t = new();

      $display("\nreset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);

      $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(2, debug);

    //  $display("\nfull and empty signals:");
    //     t.control_knob = transaction#(DEPTH, DATA_WIDTH)::fe;
    //     generate_transactions(1, debug);

       
        $display("\nread:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::read;
        generate_transactions(2, debug);
endtask


task scen2(bit debug =1) ;
    t = new();
    
      $display("reset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);

      $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(5, debug);

    //  $display("\nfull and empty signals:");
    //     t.control_knob = transaction#(DEPTH, DATA_WIDTH)::fe;
    //     generate_transactions(1, debug);

    
        $display("\nread:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::read;
        generate_transactions(4, debug);

endtask

task scen3(bit debug =1) ;
    t = new();
    
      $display("reset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);

    $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(1, debug);

      $display("\nwrite and read");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_and_rd;
        generate_transactions(1, debug);

    
        

endtask

task scen4(bit debug =1) ;
    t = new();
    
      $display("reset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);

      $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(8, debug);

     $display("\nfull and empty signals:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::fe;
        generate_transactions(1, debug);

    
        $display("\nread:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::read;
        generate_transactions(9, debug);

endtask

task scen5(bit debug =1) ;
    t = new();
    
      $display("reset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);

      $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(5, debug);

     $display("\nfull and empty signals:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::fe;
        generate_transactions(1, debug);

    $display("reset:");
      t.control_knob = transaction#(DEPTH, DATA_WIDTH)::rest;
        generate_transactions(1, debug);

        $display("\nwrite random values");
       t.control_knob = transaction#(DEPTH, DATA_WIDTH)::wr_rand;
        generate_transactions(2, debug);


        $display("\nread:");
        t.control_knob = transaction#(DEPTH, DATA_WIDTH)::read;
        generate_transactions(2, debug);

endtask


endclass //generator



