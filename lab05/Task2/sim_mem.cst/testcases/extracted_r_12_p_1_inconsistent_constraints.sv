class c_12_1;
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

program p_12_1;
    c_12_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x1zx01101xx111xzzxxz0100x0zxx1xzzxxzzzxxzxxxxzzxzxzzzxxxzxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
