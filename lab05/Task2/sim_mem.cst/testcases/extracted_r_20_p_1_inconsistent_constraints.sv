class c_20_1;
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

program p_20_1;
    c_20_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zz0100xzx101zxxz1zx0000xz11x11xzzzzxxzxzxxxxzxxzzzzzzxzzzxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
