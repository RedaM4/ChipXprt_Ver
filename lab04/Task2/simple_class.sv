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

    function int getcounter();
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
bit borrow ; 
static int count ; 

       function new(int num=0,int in1,int in2,bit borrow = 0);
        super.new(num,in1,in2);
        super.check_limit(in1,in2) ; 
        this.borrow = borrow ; 
        count++ ; 
    
    endfunction

    function void next();
         if(counter == min)begin
            counter = max ; 
            borrow=1 ; 
        end
        else begin
           counter--; 
           borrow =0 ; 
        end
        


        //$display("down counter: %d", counter);
    endfunction
    
    //count
function int getcount();
    return count ; 
    endfunction


endclass


//---------------upcounter
class up_counter extends counter;
       bit carry ; 
       static int count ; 
      function new(int num=0,int in1,int in2,bit carry = 0);
        super.new(num,in1,in2);
        super.check_limit(in1,in2) ;
        this.carry = carry ;  
        count++ ; 
    endfunction

    function void next();
        if(counter == max)begin
            counter = min ; 
            carry=1 ; 
        end
        else begin
            carry=0 ; 
        counter++; end
       
       // $display("up counter: %d", counter);
    endfunction


function int getcount();
    return count ; 
    
endfunction


endclass


