class timer;
    //int hour,min,sec ; 
    
    up_counter hour;
    up_counter min;
    up_counter sec;

    function new(int h=0,int m=0,int s=0);
        this.hour = new(h,0,23) ; 
        this.min = new(m,0,59) ; 
        this.sec = new(s,0,59) ; 

    endfunction //new()


    function void load(int h,int m,int s);
        hour.load(h) ; 
        min.load(m) ; 
        sec.load(s) ; 

    endfunction

    function void showval();
    $display("%02d : %02d : %02d",hour.getcounter(),min.getcounter(),sec.getcounter());
        
    endfunction


    function void next();
        
        sec.next(); 

        if(sec.carry ==1)min.next() ; 
        if (min.carry ==1 && sec.carry ==1) hour.next() ; 

        //bit temp=0;
        // if(sec.getcounter()==0)begin  min.next() ;  temp=1 ;end
        // if(min.getcounter()==0 && sec.getcounter() ==0 && temp==1) hour.next() ; 

    endfunction

endclass //timer