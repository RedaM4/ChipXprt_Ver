

module mem_test ( input logic clk, 
                  output logic read, 
                  output logic write, 
                  output logic [4:0] addr, 
                  output logic [7:0] data_in,     // data TO memory
                  input  wire [7:0] data_out     // data FROM memory
                );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] rdata;      // stores data read from memory for checking

// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
      





// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest
  int error_status;

    $display("Clear Memory Test");

    for (int i = 0; i< 32; i++)
       // Write zero data to every address location
      write_mem(i,0,0) ;

    for (int i = 0; i<32; i++)
      begin 
       // Read every address location
          read_mem(i,1);
       // check each memory location for data = 'h00

      end

   // print results of test
    $display("Data = Address Test");

    for (int i = 0; i< 32; i++)
       write_mem (i,i,0) ; 
    for (int i = 0; i<32; i++)
      begin
       // Read every address location
                read_mem(i,1);
       // check each memory location for data = address
          if( i != data_out ) begin
              $display("something Wrong at %d data = %d", i,data_out); 
                error_status++ ; 
          end

      end

//Sequential Address Write-Read Test
$display("Data = RONDOM");



    for (int i = 0; i< 32; i++)
       random_meme(i,1) ; 






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
  write = 1;
  read = 0;
  addr = iaddr;
  data_in = idata;

  @(negedge clk);
  if(debug)$display("write Data at addr %d: %d", addr, data_in);
  write = 0;



endtask

//read_mem

task read_mem (
 input logic [4:0] iaddr,
  input logic debug
 // output logic [7:0] odata
);
  @(negedge clk);
  write = 0;
  read = 1;
  addr = iaddr;
  //data_out = odata;
  @(negedge clk);
    read = 0;

  if(debug)
  $display("Read Data at addr %d: %d", addr, data_out);
  //data_out = odata;
endtask



// add result print function

function void printstatus(input int status ); 
if(status>0)
    $display("the test FAILED =%d",status);
  else     $display("it works alhumdu le allah" );

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