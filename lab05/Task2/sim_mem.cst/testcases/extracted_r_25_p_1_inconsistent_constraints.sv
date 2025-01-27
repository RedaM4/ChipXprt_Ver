class c_25_1;
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

program p_25_1;
    c_25_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xz1zz11x0zxz01xxzzx0zz1001zzz01zxxxzxzzzxzxxzzzxxxxzxxxxzzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
