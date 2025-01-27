class c_23_1;
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

program p_23_1;
    c_23_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1xzx00xxxzx1xx1101xxx111zxxz0zzxzzxzxzxzxzxzxzzzzzxxzxxzxzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
