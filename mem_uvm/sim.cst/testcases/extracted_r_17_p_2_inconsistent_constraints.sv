class c_17_2;
    bit[0:0] write = 1'h0;
    int control_knob = 1; // ( control_knob = mem_sequencer_item::control_knob_t::wr_rand ) 

    constraint write_rand_this    // (constraint_mode = ON) (mem_sequencer_item.sv:38)
    {
       (control_knob == 1 /* mem_sequencer_item::control_knob_t::wr_rand */) -> (write inside {1});
    }
endclass

program p_17_2;
    c_17_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z100zx0x0xzxx10z0x01x0x11xx0xzxxxxxxxzxzxxxxzxxxxzxxxzzxxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
