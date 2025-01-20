module full_adder #(
    parameter WIDTH = 8  // Parameter to set the width of the inputs and outputs
)(
    input logic [WIDTH-1:0] a,    // First input
    input logic [WIDTH-1:0] b,    // Second input
    input logic cin,              // Carry-in
    output logic [WIDTH-1:0] sum, // Sum output
    output logic cout             // Carry-out
);

    logic [WIDTH:0] result; // Internal logic to hold the addition result

    // Full adder functionality
    always_comb begin
        result = a + b + cin;      // Perform addition
        sum = result[WIDTH-1:0];  // Extract the sum
        cout = result[WIDTH];     // Extract the carry-out
    end

endmodule