class c_6_4;
    rand bit[1:0] addr; // rand_mode = ON 

    constraint address_this    // (constraint_mode = ON) (../sv/yapp_packet.sv:120)
    {
       (addr != 2'h2);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (../sv/yapp_tx_seqs.sv:116)
    {
       (addr == 2'h2);
    }
endclass

program p_6_4;
    c_6_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x00x00xx111zz0111z11xxzxzz1z110zxzzxxxzzxxzzxxxzxxzxzxxzxxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
