class c_90_2;
    bit[0:0] write = 1'h0;
    int control_knob = 1; // ( control_knob = mem_sequencer_item::control_knob_t::wr_rand ) 

    constraint write_rand_this    // (constraint_mode = ON) (mem_sequencer_item.sv:38)
    {
       (control_knob == 1 /* mem_sequencer_item::control_knob_t::wr_rand */) -> (write inside {1});
    }
endclass

program p_90_2;
    c_90_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xzz0xx1z0xx00z01101zx0000z101xxzzzzxzxzzzzxzxzxzxzzzzzxxzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
