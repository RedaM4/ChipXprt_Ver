

module mem_test ( input logic clk, 
                 mem_intf intf
                );


           
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: new data types - bit ,logic
bit      debug = 0;
logic [7:0] rdata;      // stores data read from memory for checking
int check [32];  
int error_status;
// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
      





// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest




    $display("Clear Memory Test");

    for (int i = 0; i< 32; i++)
       // Write zero data to every address location
      write_mem(i,0,debug) ;

    for (int i = 0; i<32; i++)
      begin 
       // Read every address location
          read_mem(i,debug);
       // check each memory location for data = 'h00

      end

   // print results of test
    $display("Data = Address Test");

    for (int i = 0; i< 32; i++)
       write_mem (i,i,debug) ; 
    for (int i = 0; i<32; i++)
      begin
       // Read every address location
                read_mem(i,debug);
       // check each memory location for data = address
          if( i != intf.data_out ) begin
              $display("something Wrong at %d data = %d", i,intf.data_out); 
                error_status++ ; 
          end

      end

//Sequential Address Write-Read Test
$display("Data = RONDOM");



    for (int i = 0; i< 32; i++)
       random_meme(i,debug) ; 






   // print results of test
    printstatus(error_status);
    $finish;
  
  end
// add read_mem and write_mem tasks



task write_mem(
  input logic [4:0] iaddr,
  input logic [7:0] idata,
    input logic debug
);

  @(negedge clk);
  intf.write = 1;
  intf.read = 0;
  intf.addr = iaddr;
  intf.data_in = idata;

  @(negedge clk);
  if(debug)$display("write Data at addr %d: %d", intf.addr, intf.data_in);
  intf.write = 0;

check [iaddr] = intf.data_in ; 

endtask

//read_mem

task read_mem (
 input logic [4:0] iaddr,
  input logic debug
 // output logic [7:0] odata
);
  @(negedge clk);
  intf.write = 0;
  intf.read = 1;
  intf.addr = iaddr;
  //data_out = odata;
  @(negedge clk);
    intf.read = 0;

  if(debug)begin
  $display("Read Data at addr %d: %d", intf.addr, intf.data_out);

if (check [iaddr] != intf.data_out )begin
  $display("Error: dismatch data") ; 
  error_status++ ; 
  end
else $display("Mathcy matchy");
      end

  //data_out = odata;
endtask



// add result print function

function void printstatus(input int status ); 
if(status>0)
    $display("the test FAILED =%d",status);
  else    begin  //$display("it works alhumdu allah" );
  $display("       (•‿•)  Yo.");
        $display("      \\__/|     it works, man.");
        $display("        ||");
        $display("        ||");
        $display("       /  \\");
  
  
  
  end
endfunction 

task random_meme(
    input logic [4:0] iaddr,
    input logic debug
);
 int rando ;
rando = $urandom_range(0, 31);

write_mem(iaddr,rando, debug);
read_mem(iaddr,debug);

endtask





endmodule