class c_7_1;
    int j = 0;
    rand bit[5:0] length; // rand_mode = ON 

    constraint pay_lencon_this    // (constraint_mode = ON) (../yapp/sv/yapp_packet.sv:58)
    {
       (length > 6'h0);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (../yapp/sv/yapp_tx_seqs.sv:213)
    {
       (length == j);
    }
endclass

program p_7_1;
    c_7_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1zz00zxxxz01xz0zx1xx1xz11z11x11xzzxzzxxxxzzxzzxxzzxzxxzzzzxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
