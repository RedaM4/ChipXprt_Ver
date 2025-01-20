
`timescale 1ns/1ps


module FA_tb;


    // Parameters
    parameter WIDTH = 8;

    // Testbench signals
    logic [WIDTH-1:0] a, b;   // Inputs
    logic cin;                // Carry-in
    logic [WIDTH-1:0] sum;    // Sum output
    logic cout;               // Carry-out

    // Instantiate the full_adder module
    full_adder #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Testbench procedure
    initial begin
        $display("Time		A		B		Cin		Sum		Cout");
        $monitor("%0t	%b	%b	%b	%b	%b", $time, a, b, cin, sum, cout);

        // Test case 1: Simple addition without carry-in
        a = 8'd5; b = 8'd10; cin = 1'b0;
        #10; // Wait for 10 time units

        // Test case 2: Addition with carry-in
        a = 8'd15; b = 8'd20; cin = 1'b1;
        #10;

        // Test case 3: Overflow case
        a = 8'd255; b = 8'd1; cin = 1'b0;
        #10;

        // Test case 4: Random inputs
        a = 8'hAA; b = 8'h55; cin = 1'b1;
        #10;

        // End simulation
        $stop;
    end

endmodule
