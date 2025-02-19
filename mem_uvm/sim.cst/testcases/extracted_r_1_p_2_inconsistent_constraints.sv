class c_1_2;
    bit[0:0] write = 1'h0;
    int control_knob = 0; // ( control_knob = mem_sequencer_item::control_knob_t::wr_zero ) 

    constraint write_zero_this    // (constraint_mode = ON) (mem_sequencer_item.sv:29)
    {
       (control_knob == 0 /* mem_sequencer_item::control_knob_t::wr_zero */) -> (write inside {1});
    }
endclass

program p_1_2;
    c_1_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111zzzx1z001x0011z1xzxxz0z11x0z1zzzxzxzzxxzxzxzxzzxzzxxzzzzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
