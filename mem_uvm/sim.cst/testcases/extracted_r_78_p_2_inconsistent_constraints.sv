class c_78_2;
    bit[0:0] write = 1'h0;
    int control_knob = 1; // ( control_knob = mem_sequencer_item::control_knob_t::wr_rand ) 

    constraint write_rand_this    // (constraint_mode = ON) (mem_sequencer_item.sv:38)
    {
       (control_knob == 1 /* mem_sequencer_item::control_knob_t::wr_rand */) -> (write inside {1});
    }
endclass

program p_78_2;
    c_78_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzzx0xz1x111z00x1101zxxzx1x01xz0zzzzxzzzxzzzxxxxxzzxzzxzxzxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
