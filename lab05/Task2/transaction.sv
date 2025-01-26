class transaction;
    randc bit [7:0] address ; 
    randc bit [7:0] data ; 
    //rand bit [7:0] random_val; 
    function new(bit [7:0] addr,int data);
        this.address = addr ; 
        this.data  =data ; 
    endfunction //new()

function void jj();
    
    

    
endfunction

endclass //transaction

