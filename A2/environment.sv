
   timeunit 1ns;
timeprecision 1ns;
class Environment#(parameter DEPTH=8, DATA_WIDTH=8);
    // Components of the testbench
    Generator gen;
    Driver drv;
    Monitor  mon;
    Scoreboard scb;

    // Mailboxes for communication between components
    mailbox gen2drv,mon2scb;
    virtual fifo_int vif; // Virtual interface to connect to DUT
        
    // Constructor: Initializes mailboxes and components
    function new(virtual fifo_int vi);
       
        this.vif = vi;
        gen2drv = new(); // Generator -> Driver
       // gen2scb = new(); // Generator -> Scoreboard
       // monfifo = new(); // Monitor -> Scoreboard
        mon2scb = new();
        
         //rep=8; 
        gen = new(gen2drv);
        drv = new(gen2drv, vif);
        mon = new(mon2scb, vif);
        scb = new( mon2scb,vif,13);
    endfunction

    // Task to start all testbench components
    task run();
        
        fork
            //begin forever @(posedge vif.clk) $display("clock is working in the env"); end
            gen.run(); 
                   
            drv.run();
           
            mon.run();
            
            scb.run(); //this is the problem
            join
           
        
    endtask
endclass

// `endif // ENVIRONMENT_SV
