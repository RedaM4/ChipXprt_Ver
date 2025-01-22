module tb;
    counter co = new(19,100,2);
    down_counter dc = new(5,2,10);
    up_counter uc = new(70,4,2);


initial begin
    $display("------------new: %d", co.getcount());
   // co.load(420);
    $display("------------load: %d\n", co.getcount());
   
    $display("------------load: %d\n", dc.getcount());

    dc.next();    
    dc.next();
    dc.next(); 
    dc.next(); 
    $display("------------load: %d\n", uc.getcount());
    uc.next() ; 
    uc.next();
    uc.next();
    dc.next(); 

end

endmodule
