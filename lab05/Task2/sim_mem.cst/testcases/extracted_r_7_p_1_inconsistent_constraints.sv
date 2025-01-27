class c_7_1;
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

program p_7_1;
    c_7_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1101x1zzz1xz1x1z1zz1z1xz11xx0z1xzxxzxxxzxxzzxzxxxxzxxzxzzzzzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
