class c_8_1;
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

program p_8_1;
    c_8_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzzzx1010z0xzz0zx0x1z1xx0z0xx01xxzxxzzzxzxxxxzxxzxxxzxxzzxzxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
