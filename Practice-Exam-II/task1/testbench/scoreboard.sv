class scoreboard extends uvm_test;
      `uvm_component_utils(scoreboard)


  uvm_analysis_imp #(sequence_item,scoreboard) scoreboard_port;
    sequence_item transactions[$];
   sequence_item actual;
   int expected[8] ; 
   int temp ; 
 //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "mem_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCB_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCB_CLASS", "Build Phase!", UVM_HIGH)
   
    scoreboard_port = new("scoreboard_port", this);
    
  endfunction: build_phase
  
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCB_CLASS", "Connect Phase!", UVM_HIGH)
    
   
  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Write Method
  //--------------------------------------------------------
  function void write(sequence_item item);
    transactions.push_back(item);
  endfunction: write 
   
     //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCB_CLASS", "Run Phase!", UVM_HIGH)
   
   
     actual = new ; 
forever begin
  

   wait((transactions.size() != 0));
      actual = transactions.pop_front();
      `uvm_info("SCOREBOARD", "Receiving !", UVM_LOW)

//expected
show() ; 
if (!actual.rst_n ) begin //reset ==0
    for (int i  =0 ;i<8 ;i++ ) begin
        expected[i]=0 ; 
        temp=0;
    end

if (actual.load && actual.rst_n) begin   //load=1, rst=0
    
  for (int i  =0 ;i<8 ;i++ ) begin
        expected[i]=actual.data_i[i] ; 
    end
end

if (!actual.load && actual.rst_n) begin //load=0 , rst=1
    compare() ; 
    if (temp==7) 
       temp=0;
    else
    temp++ ; 
    
end


end
end
endtask


task compare ();
    if(actual.serial_o == expected[temp] )
          `uvm_info("COMPARE", $sformatf("✅Transaction Passed! ACT=%0d, EXP=%0d", actual.serial_o, expected[temp]), UVM_HIGH)        
            else begin
           `uvm_error("COMPARE", $sformatf("🔴Transaction failed! ACT=%0d, EXP=%0d", actual.serial_o, expected[temp]))        
            end

endtask //compare


task  show();
    
$display("[SCB] Expected-> serial_o: %0d", expected[temp] );
$display("[SCB] Actual  -> serial_o: %0d, rst: %0d, data_in: %0d, load: %0d"
, actual.serial_o, actual.rst_n, actual.data_i, actual.load );



endtask //





endclass //scoreboard extends superClass