
   timeunit 1ns;
timeprecision 1ns;
class Environment#(parameter DEPTH=8, DATA_WIDTH=8);
    // Components of the testbench
    Generator #(DEPTH, DATA_WIDTH) gen;
    Driver #(DEPTH, DATA_WIDTH) drv;
    Monitor #(DEPTH, DATA_WIDTH) mon;
    Scoreboard #(DEPTH, DATA_WIDTH) scb;

    // Mailboxes for communication between components
    mailbox gen2drv, mon2scb, gen2scb;
    virtual fifo_int vif; // Virtual interface to connect to DUT
        int rep ; 
    // Constructor: Initializes mailboxes and components
    function new(virtual fifo_int vi);
       
        this.vif = vi;
        gen2drv = new(); // Generator -> Driver
        gen2scb = new(); // Generator -> Scoreboard
        mon2scb = new(); // Monitor -> Scoreboard
         rep=5; 
        gen = new(gen2drv, gen2scb,rep);
        drv = new(gen2drv, vif);
        mon = new(mon2scb, vif);
        scb = new(gen2scb, mon2scb,rep);
    endfunction

    // Task to start all testbench components
    task run();
        fork
            gen.run(); 
                   
            drv.run();
           
            mon.run();
            
            scb.run(); 
            join
           
        
    endtask
endclass

// `endif // ENVIRONMENT_SV
