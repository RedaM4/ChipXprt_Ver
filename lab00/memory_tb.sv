`timescale 1ns/1ps

module memory_tb; 

    logic clk;
    logic read;
    logic write;
    logic [4:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

    // Instantiate the mem module
    mem uut (
        .clk(clk),           // Connect clk to clk
        .read(read),         // Connect read to read
        .write(write),       // Connect write to write
        .addr(addr),         // Connect addr to addr
        .data_in(data_in),   // Connect data_in to data_in
        .data_out(data_out)  // Connect data_out to data_out
    );


 always #5 clk = ~clk;

initial begin
clk=0 ; 
write = 1 ; read = 0 ; data_in = 20 ; addr=40 ;  
#10 
write = 1 ; read = 0 ; data_in = 30 ; addr=41 ;  
#10 
write = 0 ; read = 1 ; data_in = 0 ; addr=41 ;  
$display("Data at addr %d: %d", addr, data_out);
#10 
write = 0 ; read = 1 ; data_in = 0 ; addr=40 ; 
#10

$display("Data at addr %d: %d", addr, data_out);


$finish;

end 

endmodule 