class counter;
  
   int counter;
    int max,min ; 
    function new(int num=0,int in1,int in2);
       // this.counter = count;
        check_limit(in1,in2) ; 
        check_set( num) ; 
    endfunction

    function void load(int num);
      //  counter = count;
        check_set( num) ; 

    endfunction

    function int getcount();
        return counter;
    endfunction

    function void check_limit(int in1 , int in2) ;
    this.max = (in1 > in2)? in1 : in2 ;     
    this.min = (in1 < in2)? in1 : in2 ;     
    endfunction

    function void check_set(int num);
        if (num > max | num < min)begin
            this.counter = min ; 
            $display("WARNINNG: the count out of range count=min");end
        
        else 
        this.counter = num ;
        
    endfunction

endclass


//--------down counter
class down_counter extends counter;
       function new(int num=0,int in1,int in2);
        super.new(num,in1,in2);
        super.check_limit(in1,in2) ; 
    endfunction

    function void next();
         if(counter == min)begin
            counter = max ; 
        end
        else begin
           counter--; 
        end
        


        $display("down counter: %d", counter);
    endfunction
    
    //count

endclass


//---------------upcounter
class up_counter extends counter;
      function new(int num=0,int in1,int in2);
        super.new(num,in1,in2);
        super.check_limit(in1,in2) ; 
    endfunction

    function void next();
        if(counter == max)begin
            counter = min ; 
        end
        else begin
        counter++; end
       
        $display("up counter: %d", counter);
    endfunction
endclass
