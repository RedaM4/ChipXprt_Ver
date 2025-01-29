timeunit 1ns;
timeprecision 1ns;

class transaction;
    typedef enum {
        ascii, // Constraint a: Printable ASCII characters
        upper,       // Constraint b: Uppercase A-Z
        lower,       // Constraint c: Lowercase a-z
        weight    // Constraint d: Weighted case distribution
    } control_knob_t;
    
    randc bit [4:0] address ; 
    rand bit [7:0] data ;
    // int control_knob;
control_knob_t control_knob;

function new(bit [4:0] addr = 8'h00, logic [7:0] rdata = 8'h00, control_knob_t knob = ascii);
        this.address = addr; 
        this.data = rdata; 
        this.control_knob = knob;
    endfunction



    constraint printable_ascii {
        if(control_knob==ascii)
        data inside {[8'h20 : 8'h7F]};
    }

    constraint uppercase {
        if(control_knob== upper)
        data inside {[8'h41 : 8'h5A]}; // ASCII range for 'A' to 'Z'
    }

    constraint lowercase {
        if(control_knob==lower)
        data inside {[8'h61 : 8'h7A]}; // ASCII range for 'a' to 'z'
    }

    constraint weighted_case {
        if(control_knob==weight)
        data dist {
            [8'h41 : 8'h5A] := 80, // Uppercase A-Z (80%)
            [8'h61 : 8'h7A] := 20  // Lowercase a-z (20%)
        };
    }
    
    

    

endclass //transaction

