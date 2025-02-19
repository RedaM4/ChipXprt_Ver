class c_33_2;
    bit[0:0] write = 1'h0;
    int control_knob = 1; // ( control_knob = mem_sequencer_item::control_knob_t::wr_rand ) 

    constraint write_rand_this    // (constraint_mode = ON) (mem_sequencer_item.sv:38)
    {
       (control_knob == 1 /* mem_sequencer_item::control_knob_t::wr_rand */) -> (write inside {1});
    }
endclass

program p_33_2;
    c_33_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx1101x0z11z0xz0z00x0100z00x11z0xxxxzzzxxxxzzxzxzzxxzzzzzxzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
