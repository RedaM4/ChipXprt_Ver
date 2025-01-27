class c_10_1;
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

program p_10_1;
    c_10_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01xx000xxxxxz0101x0zxz1zx0z0z1xxxzxxzxxxzxxxxxxzxxzzzzxzxzxxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
