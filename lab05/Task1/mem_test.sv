
module mem_test ( 
                  mem_interf.tb mif
                );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] rdata;      // stores data read from memory for checking
int error_status = 0;
   byte random_val = 8'h00 ; 

// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest

    $display("===========================================================");
    $display("                  Clearing Memory Test");
    $display("===========================================================\n");    
    error_status = 0; // setting error count to zero at the start of each test
    for (int i = 0; i< 32; i++)
       mif.write_mem (i, 0, debug);
    for (int i = 0; i<32; i++)
      begin 
       mif.read_mem (i, rdata, debug);
       // check each memory location for data = 'h00
       checkit (i, rdata, 8'h00);
      end
    printstatus(error_status);


    $display("===========================================================");
    $display("                    Data = Address Test");
    $display("===========================================================\n");   

    error_status = 0; // setting error count to zero at the start of each test
    for (int i = 0; i< 32; i++)
       mif.write_mem (i, i, debug);
    for (int i = 0; i<32; i++)
      begin
       mif.read_mem (i, rdata, debug);
       // check each memory location for data = address
       checkit (i, rdata, i);
      end
    printstatus(error_status);
    
    
    $display("===========================================================");
    $display("                    Data = random_val Test");
    $display("===========================================================\n");   
    // Complete this test
   error_status = 0; 
   //byte random_val = 8'h00 ; 
     for (int i = 0; i< 32; i++)begin
    if (randomize(random_val) with {
      random_val dist{
        [8'h41:8'h5a]:=80,
        [8'h61:8'h7a] :=20            } ;} ) begin 
              
        mif.write_mem (i, random_val, debug);
        $display("address %d: %c",i,random_val);
        mif.read_mem (i, rdata, debug);
        checkit (i, rdata, random_val);

      end else begin
        $display("FAILED: address %d ",i);
      error_status++ ; 
      end
      
      //$display("Test completed. Total errors: %d", error_status);


     end
  printstatus(error_status);
    $finish;
  end

function void checkit (input [4:0] address,
                      input [7:0] actual, expected);

  if (actual !== expected) begin
    $display("[CHECKER] ERROR:  Address:%d  Data:%d  Expected:%d",
                address, actual, expected);
// SYSTEMVERILOG: post-increment
    error_status++;
    $display("[CHECKER] ERROR:  error number %d",error_status);
   end
  
endfunction: checkit

// SYSTEMVERILOG: void function
function void printstatus(input int status);
if (status == 0)
begin
    $display("\n");
    $display("                                  _\\|/_");
    $display("                                  (o o)");
    $display(" ______________________________oOO-{_}-OOo______________________________");
    $display("|                                                                       |");
    $display("|                               TEST PASSED                             |");
    $display("|_______________________________________________________________________|");
    $display("\n");
end
else
begin
    $display("Test Failed with %d Errors", status);
    $display("\n");
    $display("                              _ ._  _ , _ ._");
    $display("                            (_ ' ( `  )_  .__)");
    $display("                          ( (  (    )   `)  ) _)");
    $display("                         (__ (_   (_ . _) _) ,__)");
    $display("                             `~~`\ ' . /`~~`");
    $display("                             ,::: ;   ; :::,");
    $display("                            ':::::::::::::::'");
    $display(" ________________________________/_ __ \________________________________");
    $display("|                                                                       |");
    $display("|                               TEST FAILED                             |");
    $display("|_______________________________________________________________________|");
    $display("\n");
end
endfunction : printstatus

endmodule