class c_21_2;
    bit[0:0] write = 1'h0;
    int control_knob = 1; // ( control_knob = mem_sequencer_item::control_knob_t::wr_rand ) 

    constraint write_rand_this    // (constraint_mode = ON) (mem_sequencer_item.sv:38)
    {
       (control_knob == 1 /* mem_sequencer_item::control_knob_t::wr_rand */) -> (write inside {1});
    }
endclass

program p_21_2;
    c_21_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z1x110z00x1x11xz0x011x1zzzxzz0xxzxzxzxxzzxxzxxzxzxzzxzzxzzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
