module mem_tes;




task write_mem (
	input   [4:0] addri  ,
	input   [7:0] data_ini,
    input debug   
);


addr = addri ; 
data_in = data_in1 ; 


initial begin
always@ (posedge clk)
read=0;write=1 ; 
end 

if(debug)
$display("write Data at addr %d: %d", addr, data_out);

endtask 



task read_mem (
	input   [4:0] addri  ,
	input   [7:0] data_ini ,
    input debug   
);


addr = addri ; 
data_in = data_in1 ; 


initial begin
always@ (posedge clk)
read=1;write=0 ; 
end 

if(debug)
$display("read Data at addr %d: %d", addr, data_out);

endtask 





endmodule 