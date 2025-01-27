class c_24_1;
    rand bit[7:0] data; // rand_mode = ON 

    constraint uppercase_this    // (constraint_mode = ON) (transaction.sv:18)
    {
       (data inside {[8'h41:8'h5a]});
    }
    constraint lowercase_this    // (constraint_mode = ON) (transaction.sv:22)
    {
       (data inside {[8'h61:8'h7a]});
    }
endclass

program p_24_1;
    c_24_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz10z0xzz10zzzxz0zx1010zxx101xxxxzzzxxxxzxxxxzzxzxzxzxzxzxzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
